local Play = Game:addState("Play")

function Play:enterState()
	self:initStartState()
end

function Play:initStartState()
	
	self.powerTick = 0
	self.cloudTick = 0
	
	PlayerBullets = {}
	EnemyBullets = {}
	Particles = {}
	PowerUps = {}
	Clouds = {}
	
	Player = PlayerClass:new()
	Player:setY(GameHeight - GameHeight/8)
	Player:setX(GameWidth/2)
	
	Boss = BossToad:new()
	Boss:setPos(math.random(Boss:getR()*2,GameWidth - (Boss:getR()*2)),1.5*Boss:getR())
	if MUSIC_ENABLED then
	   love.audio.play(Sound.music)
	   Sound.music:setLooping(true)
       Sound.music:setVolume(0.75)
   end
end


function Play:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(Images.BG,0,0,0,1,1)

	for i,obj in ipairs(Clouds) do
		love.graphics.setColor(255,255,255,255)
		obj:draw()
	end	
	
	
	love.graphics.setColor(255,255,255,255)
	Boss:draw()
	
	
	love.graphics.setColor(255,255,255,255)
	for i,obj in ipairs(PlayerBullets) do
		love.graphics.setColor(255,255,255,255)
		obj:draw()
	end	
	
	
		
	love.graphics.setColor(255,255,255,255)
	Player:draw()
	
	
	
	love.graphics.setColor(255,255,255,255)
	DrawParticles()
	
	for i,obj in ipairs(PowerUps) do
		love.graphics.setColor(255,255,255,255)
		obj:draw()
	end
	
	for i,obj in ipairs(EnemyBullets) do
		love.graphics.setColor(255,255,255,255)
		obj:draw()
	end	
	
		
	-- draw shit looking Gui
	
	local health,blah = math.modf((Boss:getHp() / BOSS_MAX_HP) * 100)

	-- draw player hp info
	love.graphics.setColor(255,0,0,128)
	local drawhp = (Player:getHp() / 100) * ((GameWidth/2)-2)
	love.graphics.rectangle("fill",2,2,drawhp,30)
	love.graphics.setColor(0,0,255,200)
	love.graphics.setFont(Font.score_font)
	love.graphics.printf("Wizard: " .. Player:getHp() .. "%",2,2,(GameWidth/2)-2,'center')
	
	-- draw boss hp info
	love.graphics.setColor(0,0,255,128)
	drawhp = ((Boss:getHp() / BOSS_MAX_HP) * ((GameWidth/2)-2))
	love.graphics.rectangle("fill",(GameWidth/2)+2,2,drawhp,30)
	love.graphics.setColor(255,0,0,200)
	love.graphics.setFont(Font.score_font)
	love.graphics.printf("Toad: " .. health .. "%",(GameWidth/2)+2,2,(GameWidth/2)-2,'center')
	
	-- score
	love.graphics.setColor(255,255,255,200)
	love.graphics.setFont(Font.menu_font)
	love.graphics.printf(Player:getScore(),0,50,GameWidth,'right')

	-- borders
	love.graphics.setColor(Color.black)
	love.graphics.rectangle("line",2,2,(GameWidth/2)-2,30)
	love.graphics.rectangle("line",(GameWidth/2)+2,2,(GameWidth/2)-2,30)


	if FPS_ENABLED then
		love.graphics.setColor(Color.white)
		love.graphics.setFont(Font.score_font)
		love.graphics.printf(
			"Bullets: " .. table.getn(PlayerBullets) + table.getn(EnemyBullets) .. 
			"\nFPS: " .. love.timer.getFPS() .. "",0,GameHeight-(2*Font.score_font:getHeight()),GameWidth - 10,'right')
	end
end

function Play:update(dt)
	if Boss:getHp() > 0 and Player:getHp() > 0 then
		Boss:autoMove()
		Player:moveByInput()
		Player:update(dt)
		Boss:generateBullets()
		self:GenerateClouds()
		self:updatePlayerBullets(PlayerBullets)
		self:updateEnemyBullets(EnemyBullets)
		self:updatePowerUps(PowerUps)
		self:updateClouds(Clouds)
		UpdateParticles(dt)
   -- YOU LOSE
	elseif Boss:getHp() > 0 and Player:getHp() <= 0 then
		Game:popState()
		Player:setHp(0)
    	if MUSIC_ENABLED then
        	love.audio.stop(Sound.music)
    	end
		
		Game:pushState('FailScreen') 
   -- YOU WIN
   else
		Game:popState()
      Boss:setHp(0)
      if MUSIC_ENABLED then
			love.audio.stop(Sound.music)
		end
      
      local newscore,blah = math.modf(Player:getScore() + ((Player:getHp() / PLAYER_MAX_HP) * Player:getScore()))
	  	Player:setScore(newscore)
		Game:pushState('WinScreen')
	end
end

function Play:GeneratePowerUps()
	if self.powerTick % 512 == 500 then
		if math.random(0,100) >= 50 then
			local x = math.random(POWERUP_R * 2,GameWidth - (POWERUP_R * 2))
			local y = math.random(0 - POWERUP_R * 2,0 - POWERUP_R)
			local p = PowerUp:new(x,y)
			table.insert(PowerUps,p)
			PlayMockingToadSFX()
		end
	end
	
	if self.powerTick > 1024 then
		self.powerTick = 1
	else
		self.powerTick = self.powerTick + 1
	end
end

function Play:GenerateClouds()
	if self.cloudTick % 128 == 0 then
		local x = math.random(0,GameWidth)
		local y = math.random(0 - CLOUD_R * 2,0 - CLOUD_R)
		local c = Cloud:new(x,y)
		table.insert(Clouds,c)
	end
	
	if self.cloudTick > 1024 then
		self.cloudTick = 1
	else
		self.cloudTick = self.cloudTick + 1
	end
end

function Play:updateClouds(clouds)
	for i=#clouds,1,-1 do
		local cloud = clouds[i]
		cloud:update()
		if cloud:shouldBeDeleted() then
			table.remove(clouds,i)
		end
	end
end


function Play:updateEnemyBullets(bullets)
	for i=#bullets,1,-1 do
		local bullet = bullets[i]
		bullet:update()
		if bullet:shouldBeDeleted() then
			table.remove(bullets,i)
		elseif bullet:collideWith(Player) then
			PlayPlayerHitSFX()
			AddBulletExplode(Player:getX(),Player:getY())
			Player:setHp(Player:getHp() - ENEMY_BULLET_DMG)
			table.remove(bullets,i)
		end
	end
end


function Play:updatePlayerBullets(bullets)
	for i=#bullets,1,-1 do
		local bullet = bullets[i]
		bullet:update()
		if bullet:shouldBeDeleted() then
			table.remove(bullets,i)
		elseif bullet:collideWith(Boss) then
			self:GeneratePowerUps()
			AddBulletExplode(bullet:getX(),bullet:getY())
			PlayEnemyHitSFX()
			Boss:setHp(Boss:getHp() - bullet:getDmg())
			Player:setScore(Player:getScore() + 99)
			table.remove(bullets,i)
		end
	end
end

function Play:updatePowerUps(powerups)
	for i=#powerups,1,-1 do
		local p = powerups[i]
		p:update()
		if p:shouldBeDeleted() then
			table.remove(powerups,i)
		elseif p:collideWith(Player) then
			Player:setHp(Player:getHp() + p:getHp())
			if Player:getHp() > 100 then
				Player:setHp(100) 
			end
			Player:setScore(Player:getScore() + (p:getHp() * POWERUP_SCORE_MULTIPLIER))
			table.remove(powerups,i)
			AddPowerUpExplode(Player:getX(),Player:getY())
			PlayPowerUpSFX()
		end
	end
end

function Play:keypressed(key)
	Player:keypressed(key)
	if key == "escape" then
		Game:pushState('PauseScreen')
	end
end

function Play:keyreleased(key)
end

function Play:exitState()
end

