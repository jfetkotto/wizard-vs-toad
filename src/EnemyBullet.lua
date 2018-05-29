EnemyBullet = class("EnemyBullet",Obj)

function EnemyBullet:initialize(x,y,angle)
	Obj.initialize(self, Images.ENEMY_BULLET_IMG ,ENEMY_BULLET_R)
	self.x = x
	self.y = y
	self.angle = angle
	self.sx = ENEMY_BULLET_SPEED * math.cos(angle)
	self.sy = ENEMY_BULLET_SPEED * math.sin(angle)
	self.dmg = ENEMY_BULLET_DMG
	table.insert(EnemyBullets,self)
	self:updateBox() 
end

function EnemyBullet:update(dt)
	self.x = self.x + self.sx
	self.y = self.y + self.sy
	self:updateBox(dt)
end

function EnemyBullet:getDmg()
	return self.dmg
end

function EnemyBullet:setSpeed(speed)
	self.sx  = speed * math.cos(self.angle)
	self.sy = speed * math.sin(self.angle)
end