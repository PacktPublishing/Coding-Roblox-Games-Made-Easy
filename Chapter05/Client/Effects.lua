local replicatedStorage = game:GetService("ReplicatedStorage")
local effectsMod = {}

local function playSound(part)	
	local sound = part:FindFirstChildOfClass("Sound")
	if sound then
		sound:Play()
	end
	
	return sound
end

local function emitParticles(part, amount)
	local emitter = part:FindFirstChildOfClass("ParticleEmitter")
	if emitter then
		emitter:Emit(amount)
	end
	
	return emitter
end

replicatedStorage.Effect.OnClientEvent:Connect(function(part)
	local folderName = part.Parent.Name
	effectsMod[folderName](part)
end)

effectsMod.RewardParts = function(part)
	part.Transparency = 1
	playSound(part)
end

effectsMod.SpawnParts = function(part)
	playSound(part)
	emitParticles(part, 50)
	part.Material = Enum.Material.Neon
	
	delay(1, function()
		part.Material = Enum.Material.SmoothPlastic
	end)
end

local runService = game:GetService("RunService")
local rotParts = {}

local partGroups = {
	workspace.KillParts;
	workspace.DamageParts;
	workspace.SpawnParts;
	workspace.RewardParts;
	workspace.BadgeParts;
	workspace.PurchaseParts;
	workspace.ShopParts;
}

for _, group in pairs(partGroups) do
	for _, part in pairs(group:GetChildren()) do
		if part:IsA("BasePart") then
			if part:FindFirstChild("Rotate") then
				table.insert(rotParts, part)
			end
		end
	end
end

runService.RenderStepped:Connect(function(dt)
	for _, part in pairs(rotParts) do
		local rot = part.Rotate.Value
		rot = rot * dt
		rot = rot * ((2 * math.pi) / 360)
		rot = CFrame.Angles(rot.X, rot.Y, rot.Z)
		
		part.CFrame = part.CFrame * rot
	end
end)

return effectsMod