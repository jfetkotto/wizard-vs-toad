ExplodeParticle = class("ExplodeParticle")

Particles = {}

function ExplodeParticle:initialize(image, x, y, buffer)
	self.x = x
	self.y = y
	self.particleSystem = love.graphics.newParticleSystem(image,buffer)
	self.particleSystem:setPosition(x, y)
end

function ExplodeParticle:shouldBeDeleted()
	return not self.particleSystem:isActive()
end

function ExplodeParticle:update(dt)
    self.particleSystem:update(dt)

	if self.tickCount ~= nil then
		self.tickCount = self.tickCount - 1
		if self.tickCount == 0 then
			self.particleSystem:setEmissionRate(0)
		end
	end
end

function ExplodeParticle:draw()
    love.graphics.draw(self.particleSystem, 0, 0)
end

function AddBulletExplode(x, y)
	local p = ExplodeParticle:new(Images.DOT, x, y, 25)
	p.particleSystem:setEmissionRate(100)
	p.particleSystem:setSpeed(-50,-50)
	p.particleSystem:setGravity(0)
	p.particleSystem:setSize(2,2)
	p.particleSystem:setColor(255, 255, 0, 64, 255, 0, 0, 255)
	p.particleSystem:setPosition(x, y)
	p.particleSystem:setLifetime(0.5)
	p.particleSystem:setParticleLife(0.1,1)
	p.particleSystem:setDirection(1)
	p.particleSystem:setSpread(360)
	p.particleSystem:setRadialAcceleration(200)
	p.particleSystem:setTangentialAcceleration(0)

    p.particleSystem:setParticleLife(0.3, 0.6)
    p.particleSystem:setSpread(math.pi * 2)
    p.particleSystem:start()
	
	table.insert(Particles, p)
end

function AddPowerUpExplode(x, y)
	local p = ExplodeParticle:new(Images.DOT, x, y, 25)
	p.particleSystem:setEmissionRate(1000)
	p.particleSystem:setSpeed(-25,-25)
	p.particleSystem:setGravity(0)
	p.particleSystem:setSize(2,2)
	p.particleSystem:setColor(0, 128, 0, 128, 128, 128, 128, 128)
	p.particleSystem:setPosition(x, y)
	p.particleSystem:setLifetime(0.5)
	p.particleSystem:setParticleLife(0.1,1)
	p.particleSystem:setDirection(1)
	p.particleSystem:setSpread(360)
	p.particleSystem:setRadialAcceleration(30)
	p.particleSystem:setTangentialAcceleration(0)

    p.particleSystem:setParticleLife(0.3, 0.6)
    p.particleSystem:setSpread(math.pi * 2)
    p.particleSystem:start()
	
	table.insert(Particles, p)
end

function UpdateParticles()
	for i=#Particles, 1, -1 do
		local p = Particles[i]
		if p:shouldBeDeleted() then
			table.remove(Particles, i)
		else
			p:update(0.05)
		end
	end
end

function DrawParticles()
	for i, p in ipairs(Particles) do
		p:draw()
	end
end

function DeleteAllParticles()
	for i=#Particles, 1, -1 do
		table.remove(Particles, i)
	end
end
