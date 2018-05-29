PowerUp = class("PowerUp",Obj)

PowerUps = {}

function PowerUp:initialize(x,y)
	Obj.initialize(self,Images.POWERUP_IMG,POWERUP_R)
	self.x = x
	self.y = y
	self.bigTick = 0
	self.hp = POWERUP_VALUE
end

function PowerUp:update(dt)
	self.y = self.y + POWERUP_SPEED
	self:updateBox(dt)
end

function PowerUp:getHp()
	return self.hp
end
