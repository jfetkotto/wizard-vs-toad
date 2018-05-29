Obj = class("Obj")


function Obj:initialize(image, r)
	self.image = image
	self.ox = self.image:getWidth() / 2
	self.oy = self.image:getHeight() / 2
	
	self.r = r
	self.x = GameWidth / 2
	self.y = GameHeight / 2
	
	self.dead = false
	
	self.validTop = 0 - GameHeight / 2
	self.validBottom = GameHeight + (GameHeight / 2)
	self.validLeft = 0 - GameWidth / 2
	self.validRight = GameWidth + GameWidth / 2
	
	self.followers = {}
	self:updateBox()
end

function Obj:updateBox()
	self.top = self.y - self.r
	self.bottom = self.y + self.r
	self.left = self.x - self.r
	self.right = self.x + self.r
end

function Obj:update(dt)
	for i, obj in ipairs(self.followers) do
		obj:update(dt)
	end
end

function Obj:draw()
	if self.dead == false then
		love.graphics.draw(
			self.image,
			self.x,self.y,0,
			1,1,
			self.ox,self.oy)
		
		-- Visable Hit Box	
      if HITBOX_ENABLED then
      	love.graphics.setColor(Color.red)
      	love.graphics.circle("fill",self.x,self.y,self.r,26)
      end	
	end
	
	for i,obj in ipairs(self.followers) do
		obj:draw()
	end
end

function Obj:getR()
	return self.r
end

function Obj:getX()
	return self.x
end

function Obj:getY()
	return self.y
end

function Obj:getPos()
	return self.x, self.y
end

function Obj:setX(x)
	self.x = x
	self:updateBox()
end

function Obj:setY(y)
	self.y = y
	self:updateBox()
end

function Obj:setPos(x,y)
	self.x = x
	self.y = y
	self:updateBox()
end

function Obj:move(dx, dy)
	self.x = self.x + dx
	self.y = self.y + dy
	
	for i, obj in ipairs(self.followers) do
		obj:move(dx, dy)
	end
	
	self:updateBox()
end

function Obj:outOfScreen()
	if self.y > self.validBottom then
		return true
	elseif self.y < self.validTop then
		return true
	elseif self.x < self.validLeft then
		return true
	elseif self.x > self.validRight then
		return true
	else
		return false
	end
end


function Obj:shouldBeDeleted()
	return self.dead or self:outOfScreen()
end

function Obj:collideWith(otherObj)
	if self.bottom < otherObj.top then
		return false
	elseif self.top > otherObj.bottom then
		return false
	elseif self.right < otherObj.left then
		return false
	elseif self.left > otherObj.right then
		return false
	end
	
	local dist = distanceFrom(self.x, self.y, otherObj.x, otherObj.y)
	return dist <= self.r + otherObj.r
end

function Obj:addFollower(follower)
	table.insert(self.followers, follower)
end

