HiScoreScreen = Game:addState("HiScoreScreen")


function HiScoreScreen:enterState()

end

function HiScoreScreen:draw()
	love.graphics.setColor(255,255,255,128)
	love.graphics.draw(Images.MENU_BG,0,0,0,1,1)
	
	love.graphics.setFont(Font.title_font)
	love.graphics.setColor(Color.white)
	love.graphics.printf("Hi Scores", 0, Font.title_font:getHeight()/2, GameWidth, 'center')
end

function HiScoreScreen:update(dt)
end

function HiScoreScreen:keypressed(key)
	if key == "escape" then
		Game:popState()
	end
end

function HiScoreScreen:exitState()
end