
Sound = {
	music = love.audio.newSource("media/snd/music.ogg","stream"),
	menu = love.audio.newSource("media/snd/menu.wav","static"),
	enemy_hit = love.audio.newSource("media/snd/hit.wav","static"),
	power_up = love.audio.newSource("media/snd/power_up.wav","static"),
	player_fire = love.audio.newSource("media/snd/fire.wav","static"),
	wizard_hit_1 = love.audio.newSource("media/snd/WIZ_ow_that_hurt.wav","static"),
	wizard_hit_2 = love.audio.newSource("media/snd/WIZ_that_hit_me.wav","static"),
	toad_mock_1 = love.audio.newSource("media/snd/TOAD_foolish_wizard.wav","static"),
	toad_mock_2 = love.audio.newSource("media/snd/TOAD_mocking_laugh.wav","static"),
	toad_mock_3 = love.audio.newSource("media/snd/TOAD_you_suck.wav","static")
}

function PlayMockingToadSFX()
	local choice = math.random(100)
	if choice > 66 then
		love.audio.stop(Sound.toad_mock_1)
		love.audio.stop(Sound.toad_mock_2)
		love.audio.stop(Sound.toad_mock_3)
		love.audio.play(Sound.toad_mock_1)
	elseif choice > 33 and choice <= 66 then
		love.audio.stop(Sound.toad_mock_1)
		love.audio.stop(Sound.toad_mock_2)
		love.audio.stop(Sound.toad_mock_3)
		love.audio.play(Sound.toad_mock_2)
	else
		love.audio.stop(Sound.toad_mock_1)
		love.audio.stop(Sound.toad_mock_2)
		love.audio.stop(Sound.toad_mock_3)
		love.audio.play(Sound.toad_mock_3)
	end
end

function PlayPlayerFireSFX()
	love.audio.stop(Sound.player_fire)
	love.audio.play(Sound.player_fire)
end

function PlayEnemyHitSFX()
	love.audio.stop(Sound.enemy_hit)
	love.audio.play(Sound.enemy_hit)
end

function PlayPlayerHitSFX()

	if math.random(100) >= 50 then 
		love.audio.stop(Sound.wizard_hit_1)
		love.audio.stop(Sound.wizard_hit_2)
		love.audio.play(Sound.wizard_hit_1)
	else
		love.audio.stop(Sound.wizard_hit_1)
		love.audio.stop(Sound.wizard_hit_2)
		love.audio.play(Sound.wizard_hit_2)
	end
end

function PlayMenuSFX()
	love.audio.stop(Sound.menu)
	love.audio.play(Sound.menu)
end

function PlayPowerUpSFX()
	love.audio.stop(Sound.power_up)
	love.audio.play(Sound.power_up)
end