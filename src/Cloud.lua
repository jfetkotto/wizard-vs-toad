Cloud = class("Cloud", Obj)

Clouds = {}

function Cloud:initialize(x,y)
	Obj.initialize(self,Images.CLOUD_IMG,CLOUD_R)
	self.x = x
	self.y = y
	self.bigTick = 0
	self.sy = CLOUD_SPEED + math.random(-0.1,0.1)
end

function Cloud:update(dt)
	self.y = self.y + self.sy
	self:updateBox(dt)
end
