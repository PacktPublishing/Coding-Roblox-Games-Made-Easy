local playerService = game:GetService("Players")
local dataMod = require(script.Parent.Data)
local spawnParts = workspace.SpawnParts
local initializeMod = {}

local function getStage(stageNum)
	for _, stagePart in pairs(spawnParts:GetChildren()) do
		if stagePart.Stage.Value == stageNum then
			return stagePart
		end
	end
end

playerService.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		wait()
		initializeMod.givePremiumTools(player)
		local stageNum = dataMod.get(player, "Stage")
		local spawnPoint = getStage(stageNum)
		char:SetPrimaryPartCFrame(spawnPoint.CFrame * CFrame.new(0,3,0))
	end)
end)

local collectionService = game:GetService("CollectionService")
local marketService = game:GetService("MarketplaceService")
local monetization = require(script.Parent.Monetization)
local toolPasses = {11835596}

initializeMod.givePremiumTools = function(player)
	for _, ID in pairs(toolPasses) do
		local key = player.UserId
		local ownsPass = marketService:UserOwnsGamePassAsync(key, ID)
		local hasTag = collectionService:HasTag(player, ID)
		
		if hasTag or ownsPass then
			monetization[ID](player)
		end
	end
end

return initializeMod