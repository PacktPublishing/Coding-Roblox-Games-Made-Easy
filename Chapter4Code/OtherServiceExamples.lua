local starterGui = game:GetService("StarterGui")
starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)


local physics = game:GetService("PhysicsService")

physics:CreateCollisionGroup("Players")
physics:CollisionGroupSetCollidable("Players", "Players", false)

player.CharacterAdded:Connect(function(char)
	for _, part in pairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			physics:SetPartCollisionGroup(part, "Players")
		end
	end
	print(player.Name.. " added to group!")
end)


local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input, typing)
	if typing then return end

	if input.KeyCode == Enum.KeyCode.E then
		print("Client pressed E!")
	end
end)