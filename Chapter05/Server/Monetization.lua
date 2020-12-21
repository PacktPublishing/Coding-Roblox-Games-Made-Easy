local playerService = game:GetService("Players")
local dataService = game:GetService("DataStoreService")
local insertService = game:GetService("InsertService")
local marketService = game:GetService("MarketplaceService")
local dataMod = require(script.Parent.Data)
local monetizationMod = {}

monetizationMod.insertTool = function(player, assetId)
	local asset = insertService:LoadAsset(assetId)
	local tool = asset:FindFirstChildOfClass("Tool")
	tool.Parent = player.Backpack
	asset:Destroy()
end

monetizationMod[11835596] = function(player)
	--Speed coil
	monetizationMod.insertTool(player, 99119158)
end

monetizationMod[000000] = function(player)
	--Gravity coil
	monetizationMod.insertTool(player, 16688968)
end

monetizationMod[000000] = function(player)
	--Radio
	monetizationMod.insertTool(player, 212641536)
end

monetizationMod[1090082724] = function(player)
	--100 Coins
	dataMod.increment(player, "Coins", 100)
end

local collectionService = game:GetService("CollectionService")

marketService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
	if wasPurchased then
		collectionService:AddTag(player, gamePassId)
		monetizationMod[gamePassId](player)
	end
end)

local PurchaseHistory = dataService:GetDataStore("PurchaseHistory")

function marketService.ProcessReceipt(receiptInfo)
	local playerProductKey = receiptInfo.PlayerId .. ":" .. receiptInfo.PurchaseId
	if PurchaseHistory:GetAsync(playerProductKey) then
		return Enum.ProductPurchaseDecision.PurchaseGranted 
	end
	
	local player = playerService:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	PurchaseHistory:SetAsync(playerProductKey, true)	
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

marketService.PromptProductPurchaseFinished:Connect(function(playerId, productId, wasPurchased)
	if wasPurchased then
		local player = playerService:GetPlayerByUserId(playerId)
		monetizationMod[productId](player)
	end
end)


return monetizationMod