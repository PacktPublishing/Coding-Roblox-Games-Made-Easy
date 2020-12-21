local playerService = game:GetService("Players")
local physicsService = game:GetService("PhysicsService")
local physicsMod = {}

physicsService:CreateCollisionGroup("Players")
physicsService:CollisionGroupSetCollidable("Players", "Players", false)

playerService.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				physicsService:SetPartCollisionGroup(part, "Players")
			end
		end
	end)
end)


return physicsMod