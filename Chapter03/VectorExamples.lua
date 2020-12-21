local myVector = Vector3.new(0,0,0)


myVector = Vector3.new(1,3,5) + Vector3.new(2,4,6)


myVector = Vector3.new(2,4,6) * 2
myVector = Vector3.new(2,4,6) / 2 
myVector = 2 / Vector3.new(2,4,6) 


local x,y,z = myVector.X, myVector.Y, myVector.Z


local magnitude = myVector.Magnitude


local vector1 = Vector3.new(1,5,7)
local vector2 = Vector3.new(2,4,6)
local distance = (vector1 - vector2).Magnitude
print(distance)