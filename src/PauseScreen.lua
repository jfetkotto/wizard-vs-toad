PauseScreen = Game:addState("PauseScreen")

function PauseScreen:enterState()
	if MUSIC_ENABLED then
      love.audio.stop(Sound.music)
	end
	PauseScreen.menuChoice = 1
	PauseScreen.menuItems = {
		"Continue",
		"Exit"
	}
end

function PauseScreen:draw()
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
	-- draw pause menu

	love.graphics.setFont(Font.menu_font)
	local menuBiasY = GameHeight / 4 
	local menuStepY = menuFontSize * 2
	
	love.graphics.setFont(Font.title_font)
	love.graphics.setColor(Color.white)
	love.graphics.printf("Pause", 10, Font.title_font:getHeight()/2, GameWidth - 10, 'center')
	
	for i,item in ipairs(PauseScreen.menuItems) do
		if PauseScreen.menuChoice == i then
			love.graphics.setColor(Color.white)
			love.graphics.setFont(Font.menu_select_font)
			love.graphics.printf(item,10,menuBiasY + ((menuStepY*i)/2),GameWidth-10,"center")
		else
			love.graphics.setColor(Color.menu_font_color)
			love.graphics.setFont(Font.menu_font)
			if i < PauseScreen.menuChoice then
			
				love.graphics.printf(item,10,menuBiasY + ((menuStepY*i)/2),GameWidth-10,"center")
			else
				love.graphics.printf(item,10,menuBiasY + ((menuStepY*i)/2),GameWidth-10,"center")
			end
		end
	end
end

function PauseScreen:update(dt)
end

function PauseScreen:keypressed(key)
	if key == "escape" then
		Game:popState()
		Game:popState()
	elseif key == "down" then
		keyPressing = true
		PauseScreen.menuChoice = PauseScreen.menuChoice + 1
		PlayMenuSFX()
		if PauseScreen.menuChoice > table.getn(PauseScreen.menuItems) then
			PauseScreen.menuChoice = 1
		end
	elseif key == "up" then
		keyPressing = true
		PauseScreen.menuChoice = PauseScreen.menuChoice - 1
		PlayMenuSFX()
		if PauseScreen.menuChoice < 1 then
			PauseScreen.menuChoice = table.getn(PauseScreen.menuItems)
		end
	elseif key == "return" then
		PlayMenuSFX()
		if PauseScreen.menuChoice == 1 then
			Game:popState()
			if MUSIC_ENABLED then
            love.audio.play(Sound.music)
         end
		elseif PauseScreen.menuChoice == 2 then
			Game:popState()
			Game:popState()
         if MUSIC_ENABLED then
			   love.audio.stop(Sound.music)
         end
		end
	end

end

function PauseScreen:exitState()
end
