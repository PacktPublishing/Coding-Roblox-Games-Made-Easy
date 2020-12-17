for i = 0, 10, 1 do
	print(i)
end


local n = 17
local sum = 0

for i = 1, n do
	sum = sum + i
end

print(sum)
print("Function working = ".. tostring(sum == (n * (n + 1)) / 2)) 


local items = {
	Animal = "Elephant";
	Food = "Egg";
	Plant = "Flower"
}

for index, value in pairs(items) do
	print(index, value)
end


local values = {37, 60, 59, 20, 4, 10, 100, 75, 83}

for index, value in pairs(values) do
	value = value % 2
	if value == 1 then --Odd number
		values[index] = values[index] * 2
	end
end


local items = workspace:GetDescendants()
for _, object in pairs(items) do
	if object:IsA("BasePart") then
		object.Anchored = true
	end
end


local num = 0
while num < 10 do
	num = num + 1
end

print(num) 


local elapsedTime = 0
while true do
	wait(1)
	elapsedTime = elapsedTime + 1
	print(elapsedTime)
end


local num = 12
repeat
	num = num - 1
until num == 0

print(num)