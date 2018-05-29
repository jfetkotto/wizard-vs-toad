Instructions = Game:addState("Instructions")

function Instructions:enterState()
end

function Instructions:draw()
	love.graphics.setColor(255,255,255,128)
	love.graphics.draw(Images.MENU_BG,0,0,0,1,1)
	
	love.graphics.setFont(Font.title_font)
	love.graphics.setColor(Color.white)
	love.graphics.printf("Instructions", 0, Font.title_font:getHeight()/2, GameWidth, 'center')
	love.graphics.setFont(Font.instructions_font)
	love.graphics.setColor(Color.white)
	love.graphics.printf(
		"W,A,S,D to move around\n" .. 
		"O to shoot main weapon\n" ..
		"P to move slowly\n" .. 
		"Survive at all costs", 0, (GameHeight/2) - Font.instructions_font:getHeight()*2, GameWidth, 'center')
	
end

function Instructions:update(dt)
end

function Instructions:keypressed(key)
	if key == "escape" then
		Game:popState()
	end
end

function Instructions:exitState()
end