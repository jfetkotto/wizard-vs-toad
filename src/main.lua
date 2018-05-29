
function love.load()
	math.randomseed(os.time())
	GameHeight = love.graphics.getHeight()
	GameWidth = love.graphics.getWidth()
	
	require("MiddleClass.lua")
	require("MindState.lua")
	
	require("FNT.lua")
	require("GFX.lua")
	require("SND.lua")
	require("Tools.lua")
	require("Settings.lua")

	require("Obj.lua")
	
	require("Game.lua")
	require("Menu.lua")
	require("OptionsMenu.lua")
	require("Instructions.lua")
	require("HiScoreScreen.lua")
	require("Play.lua")
	require("WinScreen.lua")
	require("FailScreen.lua")
	require("PauseScreen.lua")
	
	require("PlayerClass.lua")
	require("BossToad.lua")
	require("PlayerBullet.lua")
	require("EnemyBullet.lua")
	require("PowerUp.lua")
	require("ExplodeParticle.lua")
	require("Cloud.lua")
	
	love.keyboard.setKeyRepeat(KEY_DELAY,KEY_REPEAT)
	love.mouse.setVisible(false)
	Game = Game:new()
	Game:gotoState('Menu')
end

function love.draw()
	Game:draw()
end

function love.update(dt)
	Game:update(dt)
end

function love.keypressed(key)
	Game:keypressed(key)
end

function love.keyreleased(key)
	Game:keyreleased(key)
end

