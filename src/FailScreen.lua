FailScreen = Game:addState("FailScreen")

function FailScreen:enterState()
	FailScreen.score = Player:getScore()
end

function FailScreen:draw()
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

	-- Fail Screen
	love.graphics.setFont(Font.title_font)
	love.graphics.setColor(255,255,255,200)
	love.graphics.printf(
		"YOU FAIL\n" .. 
		"Score: " .. FailScreen.score, 0,Font.title_font:getHeight()/2, GameWidth, 'center')
	
	love.graphics.setFont(Font.menu_font)
end

function FailScreen:keypressed(key)
	if key == "escape" then
		Game:popState()
	end
end

function FailScreen:update(dt)
end

function FailScreen:exitState()
end
