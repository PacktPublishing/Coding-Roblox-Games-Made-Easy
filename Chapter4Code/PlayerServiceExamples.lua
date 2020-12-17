local playersService = game:GetService("Players")

playersService.PlayerAdded:Connect(function(player)
	print(player.Name.. " joined the game.")
end)


playersService.PlayerRemoving:Connect(function(player)
	print(player.Name.. " left the game.")
end)


playersService.PlayerAdded:Connect(function(player)
	local folder = Instance.new("Folder")
	folder.Name = "leaderstats"
	folder.Parent = player

	local gold = Instance.new("IntValue")
	gold.Name = "Gold"
	gold.Parent = folder
end)


local player = playersService.LocalPlayer --nil in reg. script
print(player.UserId)


local players = playersService:GetPlayers()

for _, player in pairs(players) do
	local char = player.Character
	if char then
		print(char.Name.. "’s speed is now 30.") 
		char.Humanoid.WalkSpeed = 30
	end
end