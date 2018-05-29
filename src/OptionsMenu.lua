local OptionsMenu = Game:addState("OptionsMenu")

function OptionsMenu:enterState()
	OptionsMenu.menuChoice = 1
	OptionsMenu.menuItems = {
		"Music",
		"FPS"
	}
end

function OptionsMenu:draw()
	love.graphics.setColor(255,255,255,128)
	love.graphics.draw(Images.MENU_BG,0,0,0,1,1)
	
	love.graphics.setFont(Font.title_font)
	love.graphics.setColor(Color.white)
	love.graphics.printf("Options", 0, Font.title_font:getHeight()/2, GameWidth, 'center')
	
	local menuBiasY = GameHeight / 4 
	local menuStepY = menuFontSize * 2
	
	for i,item in ipairs(OptionsMenu.menuItems) do
		if OptionsMenu.menuChoice == i then
			love.graphics.setColor(Color.white)
			love.graphics.setFont(Font.menu_select_font)
			if item == OptionsMenu.menuItems[1] then
				if MUSIC_ENABLED then
					love.graphics.printf(item .. " on",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				else
					love.graphics.printf(item .. " off",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				end
			elseif item == OptionsMenu.menuItems[2] then
				if FPS_ENABLED then
					love.graphics.printf(item .. " on",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				else
					love.graphics.printf(item .. " off",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				end
			end
		else
			love.graphics.setColor(Color.menu_font_color)
			love.graphics.setFont(Font.menu_font)
			if item == OptionsMenu.menuItems[1] then
				if MUSIC_ENABLED then
					love.graphics.printf(item .. " on",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				else
					love.graphics.printf(item .. " off",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				end
			elseif item == OptionsMenu.menuItems[2] then
				if FPS_ENABLED then
					love.graphics.printf(item .. " on",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				else
					love.graphics.printf(item .. " off",10,menuBiasY + ((menuStepY*i)/1.5),GameWidth-10,"center")
				end
			end
		end
	end
end

function OptionsMenu:update(dt)
end

function OptionsMenu:keypressed(key)
	if key == "escape" then
		Game:popState()
	elseif key == "down" then
		keyPressing = true
		OptionsMenu.menuChoice = OptionsMenu.menuChoice + 1
		PlayMenuSFX()
		if OptionsMenu.menuChoice > table.getn(OptionsMenu.menuItems) then
			OptionsMenu.menuChoice = 1
		end
	elseif key == "up" then
		keyPressing = true
		OptionsMenu.menuChoice = OptionsMenu.menuChoice - 1
		PlayMenuSFX()
		if OptionsMenu.menuChoice < 1 then
			OptionsMenu.menuChoice = table.getn(OptionsMenu.menuItems)
		end
	elseif key == "return" then
		PlayMenuSFX()
		if OptionsMenu.menuChoice == 1 then
			MUSIC_ENABLED = not MUSIC_ENABLED
		elseif OptionsMenu.menuChoice == 2 then
			FPS_ENABLED = not FPS_ENABLED
		end
	end
end

function OptionsMenu:exitState()
end