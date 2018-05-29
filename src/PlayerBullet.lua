PlayerBullet = class("PlayerBullet",Obj)

function PlayerBullet:initialize(x,y,angle)
	Obj.initialize(self, Images.FIREBALL_IMG ,PLAYER_BULLET_R)
	self.x = x
	self.y = y
	self.angle = angle
	self.sx = PLAYER_BULLET_SPEED * math.cos(angle)
	self.sy = PLAYER_BULLET_SPEED * math.sin(angle)
	self.dmg = PLAYER_BULLET_DMG
	table.insert(PlayerBullets,self)
	self:updateBox() 
end

function PlayerBullet:update(dt)
	self.x = self.x + self.sx
	self.y = self.y + self.sy
	self:updateBox(dt)
end

function PlayerBullet:getDmg()
	return self.dmg
end

