if true then
	print("Executed")
end


if part.Transparency == 1 then
	part.CanCollide = true
end


local humanoid = char.Humanoid
if humanoid.Health > 0 then
	print("Player is alive!")
end


if not part.Anchored then
	part.Material = Enum.Material.Neon
end


local item1 = "Fruit"
local item2 = "Vegetable"
if item1 == "Fruit" and item2 == "Fruit" then
	print("Both fruit.") --No output as requirements not met.
end


local item = "Vegetable"
if item == "Fruit" or item == "Vegetable" then
	print("Is produce.") --Prints as one requirement is met.
end


if myInstance:IsA("BasePart") then
	print(myInstance.Name.. "'s transparency is ".. myInstance.Transparency)
end


local heavy = true
local strengthRequired = 0

if heavy then
	strengthRequired = 100
else
	strengthRequired = 50
end

print(strengthRequired)


local numFruits = 0
local numVeggies = 0
local notProduce = 0
local item = "Fruit"

if item == "Fruit" then
	numFruits = numFruits + 1
elseif item == "Vegetable" then
	numVeggies = numVeggies + 1
else
	notProduce = notProduce + 1
end


local isAnchored = Part.Anchored and "Anchored" or "Unanchored"
