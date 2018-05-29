PlayerClass = class("PlayerClass",Obj)


function PlayerClass:initialize()
	Obj.initialize(self,Images.PLAYER_IMG,PLAYER_R)
	self.hp = PLAYER_MAX_HP
	self.dx = 0
	self.dy = 0
	self.score = 0
	self.tick = 0
end


function PlayerClass:moveByInput()
	local px, py = Player:getPos()
	local tx, ty = px, py
	local speed = 0
	
	if love.keyboard.isDown("p") or love.keyboard.isDown("P") or love.keyboard.isDown("x") then
		speed = PLAYER_SLOW_SPEED
	else
		speed = PLAYER_SPEED
	end
	
	
	if love.keyboard.isDown("w") or love.keyboard.isDown("W") or love.keyboard.isDown("up") then
		ty = ty - speed
	end
	
	if love.keyboard.isDown("s") or love.keyboard.isDown("S") or love.keyboard.isDown("down") then
		ty = ty + speed
	end
	
	if love.keyboard.isDown("a") or love.keyboard.isDown("A") or love.keyboard.isDown("left") then
		tx = tx - speed
	end
	
	if love.keyboard.isDown("d") or love.keyboard.isDown("D") or love.keyboard.isDown("right") then
		tx = tx + speed
	end
	
	tx, ty = makeValidPos(tx, ty)
	
	local dx,dy = getStep(tx - px,ty - py, speed)
	
	Player:move(dx,dy)

	if love.keyboard.isDown("o") or love.keyboard.isDown("O") or love.keyboard.isDown("z") or love.keyboard.isDown("Z") then
		if self.tick % 3 == 0 then
			local b = PlayerBullet:new(self.x,self.y,-math.pi/2)
			b = PlayerBullet:new(self.x+self.r*12,self.y+self.r*4,-math.pi/2)
			b = PlayerBullet:new(self.x-self.r*12,self.y+self.r*4,-math.pi/2)
			PlayPlayerFireSFX()
		end
	end
	
	self.tick = self.tick + 1
end

function PlayerClass:keypressed(key)

end

function PlayerClass:getScore()
	return self.score
end

function PlayerClass:setScore(score)
	self.score = score
end

function PlayerClass:getHp()
	return self.hp
end

function PlayerClass:setHp(hp)
	self.hp = hp
end
