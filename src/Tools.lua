function distanceFrom(x1,y1,x2,y2)
   return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function makeValidPos(x,y)
	if x < 20 then
		x = 20
	end
	
	if x > GameWidth - 20 then
		x = GameWidth - 20
	end
	
	if y < 20 then
		y = 20
	end
	
	if y > GameHeight - 20 then
		y = GameHeight - 20
	end
	
	return x,y
end

function getStep(dx, dy, speed)
	local d = math.sqrt(dx * dx + dy * dy)
	if d <= speed then
		return dx, dy
	else
		local angle = math.atan2(dy, dx)
		return speed * math.cos(angle), speed * math.sin(angle)
	end
end