local Menu = Game:addState("Menu")

function Menu:enterState()
	Menu.menuChoice = 1
	Menu.menuItems = {
		"Play", --1
		"Options", --2
		"Instructions", --3
		"Hi Scores", --4
		"exit" --5
		} 
end

function Menu:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(Images.MENU_BG,0,0,0,1,1)

	--love.graphics.setFont(Font.title_font)
	--love.graphics.setColor(Color.white)
	--love.graphics.printf("Wizard Vs Toad", 0, Font.title_font:getHeight()/2, GameWidth, 'center')
	
	love.graphics.setFont(Font.menu_font)
	local menuBiasY = GameHeight / 4 
	local menuStepY = menuFontSize * 2
	
	for i,item in ipairs(Menu.menuItems) do
		if Menu.menuChoice == i then
			love.graphics.setColor(Color.white)
			love.graphics.setFont(Font.menu_select_font)
			love.graphics.printf(item,10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-20,"right")
		else
			love.graphics.setColor(Color.menu_font_color)
			love.graphics.setFont(Font.menu_font)
			if i < Menu.menuChoice then
			
				love.graphics.printf(item,10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"right")
			else
				love.graphics.printf(item,10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"right")
			end
		end
	end
	
	love.graphics.setColor(Color.default)
end

function Menu:keypressed(key)
	if key == "escape" then
		love.event.push("q")
	elseif key == "down" then
		keyPressing = true
		Menu.menuChoice = Menu.menuChoice + 1
		PlayMenuSFX()
		if Menu.menuChoice > table.getn(Menu.menuItems) then
			Menu.menuChoice = 1
		end
	elseif key == "up" then
		keyPressing = true
		Menu.menuChoice = Menu.menuChoice - 1
		PlayMenuSFX()
		if Menu.menuChoice < 1 then
			Menu.menuChoice = table.getn(Menu.menuItems)
		end
	elseif key == "return" then
		PlayMenuSFX()
		if Menu.menuChoice == 1 then
			Game:pushState('Play')
		elseif Menu.menuChoice == 2 then
			Game:pushState('OptionsMenu')
		elseif Menu.menuChoice == 3 then
			Game:pushState('Instructions')
		elseif Menu.menuChoice == 4 then
			Game:pushState('HiScoreScreen')
		elseif Menu.menuChoice == 5 then
			love.event.push("q")
		end
	end
end

function Menu:update(dt)
end

function Menu:exitState()
end
