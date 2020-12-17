local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local player = playerService.LocalPlayer
local replication = {}
local replicateRemote = replicatedStorage.Replicate

replicateRemote.OnClientEvent:Connect(function(otherPlayer, gunSettings, cframe, length)
	if otherPlayer ~= player then
		local visual = Instance.new("Part")
		visual.Anchored = true
		visual.CanCollide = false
		visual.Material = Enum.Material.Neon
		visual.Color = gunSettings.rayColor
		visual.Size = Vector3.new(gunSettings.raySize.X, gunSettings.raySize.Y, length)
		visual.CFrame = cframe
		visual.Parent = workspace.Effects
		game.Debris:AddItem(visual, gunSettings.debrisTime)
	end
end)

return replication