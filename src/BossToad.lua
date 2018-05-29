BossToad = class("BossToad",Obj)

function BossToad:initialize()
	Obj.initialize(self,Images.TOAD_IMG,BOSS_R)
	self.hp = BOSS_MAX_HP
	self.bigTick = 0
	self.smallTick = 0
	self.i = 0
	
	local i = math.random(100)
	if i < 50 then
		self.moveLeft = true 
	else
		self.moveLeft = false
	end
end

function BossToad:getHp()
	return self.hp
end

function BossToad:setHp(hp)
	self.hp = hp
end

function BossToad:moveToPlayer()
	local dx,dy = getStep(Player:getX() - self.x,self.y,BOSS_SPEED)
	Boss:move(dx,0)
end

function BossToad:autoMove()
	if self.moveLeft == true then
		Boss:move(-BOSS_SPEED,0)
		if self.x <= (GameWidth/2) - self.r then 
			self.moveLeft = false
		end
	elseif self.moveLeft == false then
		Boss:move(BOSS_SPEED,0)
		if self.x >= (GameWidth/2) + self.r then 
			self.moveLeft = true
		end
	end

end

function BossToad:generateBullets()
	local o = Player:getX() - self.x
	local h = Player:getY() - self.y
	local a = (math.pi/2) - math.sin(o/h)
   local b = 0
	
	-- Stage 1
	if self.hp / BOSS_MAX_HP <= 1 and self.hp / BOSS_MAX_HP > 0.95 then
	
		if self.smallTick % 6 == 0 then
			b = EnemyBullet:new(self.x,self.y,(math.pi/2) + math.sin(2*math.pi*(self.i/64)))
			b = EnemyBullet:new(self.x,self.y,(math.pi/2) + math.cos(2*math.pi*(self.i/64)))
			if self.i > 64 then
				self.i = 1
			end
				self.i = self.i + 1
		end
	end
	
	-- Stage 2
	if self.hp / BOSS_MAX_HP <= 0.95 and self.hp / BOSS_MAX_HP > 0.90 then
		if self.smallTick % 3 == 0 then
			b = EnemyBullet:new(self.x,self.y,(math.pi/2) + math.sin(2*math.pi*(self.i/64)))
			b = EnemyBullet:new(self.x,self.y,(math.pi/2) + math.cos(2*math.pi*(self.i/64)))
			if self.i > 64 then
				self.i = 1
			end
				self.i = self.i + 1
		end
	end
	
	-- Stage 3
	if self.hp / BOSS_MAX_HP <= 0.90 and self.hp / BOSS_MAX_HP > 0.85 then
		if self.smallTick % 48 == 0 then
			b = EnemyBullet:new(self.x,self.y,a)
			b = EnemyBullet:new(self.x,self.y-ENEMY_BULLET_R,a - math.pi/16)
			b = EnemyBullet:new(self.x,self.y+ENEMY_BULLET_R,a + math.pi/16)
			b = EnemyBullet:new(self.x,self.y-ENEMY_BULLET_R,a - math.pi/32)
			b = EnemyBullet:new(self.x,self.y+ENEMY_BULLET_R,a + math.pi/32)
			b = EnemyBullet:new(self.x,self.y-ENEMY_BULLET_R,a - math.pi/64)
			b = EnemyBullet:new(self.x,self.y+ENEMY_BULLET_R,a + math.pi/64)
		end
	end
	
	-- Stage 4
	if self.hp / BOSS_MAX_HP <= 0.85 and self.hp / BOSS_MAX_HP > 0.80 then
		if self.smallTick % 12 == 0 then
			b = EnemyBullet:new(self.x,self.y,math.pi/2)
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*32,self.y,math.pi/2 - math.pi/8)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*32,self.y,math.pi/2 + math.pi/8)
		end
	end
	
	-- Stage 5
	if self.hp / BOSS_MAX_HP <= 0.80 and self.hp / BOSS_MAX_HP > 0.75 then
		if self.smallTick % 48 == 0 then
			b = EnemyBullet:new(self.x,self.y,math.abs(a))
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*10,self.y-ENEMY_BULLET_R*10,math.abs(a))
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*10,self.y-ENEMY_BULLET_R*10,math.abs(a))
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*20,self.y-ENEMY_BULLET_R*20,math.abs(a))
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*20,self.y-ENEMY_BULLET_R*20,math.abs(a))
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*30,self.y-ENEMY_BULLET_R*30,math.abs(a))
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*30,self.y-ENEMY_BULLET_R*40,math.abs(a))
		end
	end
	
	-- Stage 6
	if self.hp / BOSS_MAX_HP <= 0.75 and self.hp / BOSS_MAX_HP > 0.70 then
		if self.smallTick % 3 == 0 then
			b = EnemyBullet:new(self.x,self.y,(math.pi/2) + 0.25*math.sin(2*math.pi*(self.i/64)))
			b:setSpeed(((self.i/64) + 1) * ENEMY_BULLET_SPEED)
			b = EnemyBullet:new(self.x,self.y,(math.pi/2) + 0.25*math.cos(2*math.pi*(self.i/64)))
			b:setSpeed(((self.i/64) + 1) * ENEMY_BULLET_SPEED)
			if self.i > 64 then
				self.i = 1
			end
				self.i = self.i + 1
		end
	end
	
	-- Stage 7
	if self.hp / BOSS_MAX_HP <= 0.70 and self.hp / BOSS_MAX_HP > 0.65 then
		if self.smallTick % 24 == 0 then
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R,math.abs(a) - math.pi/32)
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*16,self.y-ENEMY_BULLET_R,math.abs(a) - math.pi/32)
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*24,self.y-ENEMY_BULLET_R,math.abs(a) - math.pi/32)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R,math.abs(a) + math.pi/32)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*16,self.y-ENEMY_BULLET_R,math.abs(a) + math.pi/32)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*24,self.y-ENEMY_BULLET_R,math.abs(a) + math.pi/32)
		end

		
		if self.smallTick % 12 == 0 then
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,math.pi/8 * 5)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,math.pi/8 * 3)
		end	
	end

	-- Stage 8
	if self.hp / BOSS_MAX_HP <= 0.65 and self.hp / BOSS_MAX_HP > 0.60 then
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x,self.y,self.i * ((2*math.pi)/16) + (self.i * ((2*math.pi)/64)))
			b:setSpeed((self.i/64) + 1 * ENEMY_BULLET_SPEED)
			if self.i > 64 then
				self.i = 0
			end
				self.i = self.i + 1
			
		end
	end

	-- Stage 9
	if self.hp / BOSS_MAX_HP <= 0.60 and self.hp / BOSS_MAX_HP > 0.55 then
		
		if self.smallTick % 2 == 0 then
			b = EnemyBullet:new(self.x,self.y,self.i * ((2*math.pi)/64))
			b = EnemyBullet:new(self.x,self.y,2*self.i * ((2*math.pi)/64))
			if self.i > 64 then
				self.i = 0
			end
				self.i = self.i + 1
			
		end
		
		if self.smallTick % 12 == 0 then
			b = EnemyBullet:new(self.x,self.y,a)
		end
	end
	
	-- Stage 10
	if self.hp / BOSS_MAX_HP <= 0.55 and self.hp / BOSS_MAX_HP > 0.50 then
		if self.smallTick % 6 == 0 then
			b = EnemyBullet:new(self.x,self.y,math.pi/2)
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R,math.pi/2 + math.pi/32)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R,math.pi/2 - math.pi/32)
		end
	
		if self.smallTick % 6 == 0 then
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,math.pi/8 * 5)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,math.pi/8 * 3)	
		end
	end
	
	-- Stage 11
	if self.hp / BOSS_MAX_HP <= 0.50 and self.hp / BOSS_MAX_HP > 0.475 then
		
		if self.smallTick % 3 == 0 then
			b = EnemyBullet:new(self.x,self.y,self.i * ((2*math.pi)/32))
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	end
	if self.hp / BOSS_MAX_HP <= 0.475 and self.hp / BOSS_MAX_HP > 0.45 then
		
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x,self.y,self.i * ((2 * math.pi)/32))
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	end
	
	-- Stage 12
	if self.hp / BOSS_MAX_HP <= 0.45 and self.hp / BOSS_MAX_HP > 0.40 then
		
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x,self.y,self.i * ((2 * math.pi)/32))
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
		
		if self.smallTick % 12 == 0 then
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,a + (math.pi/64))
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,a - (math.pi/64))
		end
	end
	
	-- Stage 13
	if self.hp / BOSS_MAX_HP <= 0.40 and self.hp / BOSS_MAX_HP > 0.35 then
		
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x + (self.r * 2),self.y,self.i * ((2*math.pi)/128))
			b = EnemyBullet:new(self.x - (self.r * 2),self.y,(self.i * ((2*math.pi)/128)) * -1)
			if self.i > 128 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	end
	
	-- Stage 14
	if self.hp / BOSS_MAX_HP <= 0.35 and self.hp / BOSS_MAX_HP > 0.30 then
		
		if self.smallTick % 6 == 0 then
			b = EnemyBullet:new(self.x - (self.r * 2) ,self.y,self.i * ((2*math.pi)/32))
			b = EnemyBullet:new(self.x + (self.r * 2) ,self.y,(self.i * ((2*math.pi)/32)) * -1)
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
		if self.smallTick % 12 == 0 then
			b = EnemyBullet:new(self.x,self.y,math.pi/2)
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R,math.pi/2 + math.pi/32)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R,math.pi/2 - math.pi/32)
		end
	end
	
	-- Stage 15
	if self.hp / BOSS_MAX_HP <= 0.30 and self.hp / BOSS_MAX_HP > 0.25 then
		
		if self.smallTick % 2 == 0 then
			b = EnemyBullet:new(self.x,self.y,self.i * ((2 * math.pi)/32))
			b = EnemyBullet:new(self.x + (self.r * 2) ,self.y,self.i * ((2*math.pi)/32))
			b = EnemyBullet:new(self.x - (self.r * 2) ,self.y,(self.i * ((2*math.pi)/32)) * -1)
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	end
	
	-- Stage 16
	if self.hp / BOSS_MAX_HP <= 0.25 and self.hp / BOSS_MAX_HP > 0.20 then
		
		if self.smallTick % 2 == 0 then
			b = EnemyBullet:new(self.x - self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			b = EnemyBullet:new(self.x + self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			b = EnemyBullet:new(self.x - self.r*2,self.y,self.i * ((2 * math.pi)/32))
			b = EnemyBullet:new(self.x + self.r*2,self.y,self.i * ((2 * math.pi)/32))
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	end
	
	-- Stage 17
	if self.hp / BOSS_MAX_HP <= 0.20 and self.hp / BOSS_MAX_HP > 0.15 then
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
		
		if self.smallTick % 12 == 0 then
			b = EnemyBullet:new(self.x - (ENEMY_BULLET_R * 2),self.y,math.abs(a))
			b = EnemyBullet:new(self.x + (ENEMY_BULLET_R * 2),self.y,math.abs(a))
			b = EnemyBullet:new(self.x - (ENEMY_BULLET_R * 4),self.y,math.abs(a))
			b = EnemyBullet:new(self.x + (ENEMY_BULLET_R * 4),self.y,math.abs(a))
			b = EnemyBullet:new(self.x - (ENEMY_BULLET_R * 6),self.y,math.abs(a))
			b = EnemyBullet:new(self.x + (ENEMY_BULLET_R * 6),self.y,math.abs(a))
		end
	end
	
	-- Stage 18
	if self.hp / BOSS_MAX_HP <= 0.15 and self.hp / BOSS_MAX_HP > 0.10 then
		
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x - self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			b = EnemyBullet:new(self.x + self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	
		if self.smallTick % 24 == 0 then
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,math.pi/8 * 5)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*4,self.y-ENEMY_BULLET_R,math.pi/8 * 3)
		end
	end
	
	-- Stage 19
	if self.hp / BOSS_MAX_HP <= 0.10 and self.hp / BOSS_MAX_HP > 0.05 then
		
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x - self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			b = EnemyBullet:new(self.x + self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	
		if self.smallTick % 12 == 0 then
			b = EnemyBullet:new(self.x,self.y,a)
		end
	end

	-- Stage 20
	if self.hp / BOSS_MAX_HP <= 0.05 and self.hp / BOSS_MAX_HP > 0.00 then
		
		if self.smallTick % 1 == 0 then
			b = EnemyBullet:new(self.x - self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			b = EnemyBullet:new(self.x + self.r*2,self.y,(self.i * ((2 * math.pi)/32)) * -1)
			if self.i > 32 then
				self.i = 0
			end
				self.i = self.i + 1
		end
	
		if self.smallTick % 24 == 0 then
			b = EnemyBullet:new(self.x,self.y,a)
			b = EnemyBullet:new(self.x-ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R*8,a)
			b = EnemyBullet:new(self.x+ENEMY_BULLET_R*8,self.y-ENEMY_BULLET_R*8,a)
		end
	end
	
		
	if self.smallTick > 96 then
		self.smallTick = 1
	else
		self.smallTick = self.smallTick + 1
	end
end
