local part = workspace.FloatingPart
local mass = part:GetMass()

local bodyForce = Instance.new("BodyForce")
bodyForce.Force = Vector3.new(0,mass * workspace.Gravity,0)
bodyForce.Parent = part


local Part = workspace.TouchPart
Part.Touched:Connect(function(hit)
	print(hit)
end)


local Part = workspace.TouchPart
local function printHitName(hit)
	print(hit)
end

Part.Touched:Connect(printHitName)