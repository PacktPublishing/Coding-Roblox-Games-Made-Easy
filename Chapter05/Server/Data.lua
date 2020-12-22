local playerService = game:GetService("Players")
local dataService = game:GetService("DataStoreService")
local store = dataService:GetDataStore("DataStoreV1")

local sessionData = {}
local dataMod = {}
local AUTOSAVE_INTERVAL = 120


dataMod.recursiveCopy = function(dataTable)
	local tableCopy = {}
	
	for index, value in pairs(dataTable) do
		if type(value) == "table" then
			value = dataMod.recursiveCopy(value)
		end
		tableCopy[index] = value
	end
	
	return tableCopy
end

local defaultData = {
	Coins = 0;
	Stage = 1;
}

dataMod.load = function(player)
	local key = player.UserId
	local data 
	local success, err = pcall(function()
		data = store:GetAsync(key)
	end)
	
	if not success then
		data = dataMod.load(player)
	end
	
	return data
end

dataMod.setupData = function(player)
	local key = player.UserId
	local data = dataMod.load(player)
	
	sessionData[key] = dataMod.recursiveCopy(defaultData)
	
	if data then
		for index, value in pairs(data) do
			print(index, value)
			dataMod.set(player, index, value)
		end
		
		print(player.Name.. "'s data has been loaded!")
	else
		print(player.Name.. " is a new player!")
	end
end

playerService.PlayerAdded:Connect(function(player)
	local folder = Instance.new("Folder")
	folder.Name = "leaderstats"
	folder.Parent = player
	
	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Parent = folder
	coins.Value = defaultData.Coins
	
	local stage = Instance.new("IntValue")
	stage.Name = "Stage"
	stage.Parent = folder
	stage.Value = defaultData.Stage
	
	dataMod.setupData(player)
end)

dataMod.set = function(player, stat, value)
	local key = player.UserId
	sessionData[key][stat] = value
	player.leaderstats[stat].Value = value
end

dataMod.increment = function(player, stat, value)
	local key = player.UserId
	sessionData[key][stat] = dataMod.get(player, stat) + value
	player.leaderstats[stat].Value = dataMod.get(player, stat)
end

dataMod.get = function(player, stat)
	local key = player.UserId
	return sessionData[key][stat]
end

dataMod.save = function(player)
	local key = player.UserId
	local data = dataMod.recursiveCopy(sessionData[key])
	
	local success, err = pcall(function()
		store:SetAsync(key, data)
	end)
	
	if success then
		print(player.Name.. "'s data has been saved!")
	else
		dataMod.save(player)
	end
end

dataMod.removeSessionData = function(player)
	local key = player.UserId
	sessionData[key] = nil
end

playerService.PlayerRemoving:Connect(function(player)
	dataMod.save(player)
	dataMod.removeSessionData(player)
end)


local function autoSave()
	while wait(AUTOSAVE_INTERVAL) do
		print("Auto-saving data for all players")
		
		for key, dataTable in pairs(sessionData) do
			local player = playerService:GetPlayerByUserId(key)
			dataMod.save(player)
		end
	end
end

spawn(autoSave) --Initialize autosave loop

game:BindToClose(function()
	for _, player in pairs(playerService:GetPlayers()) do
		dataMod.save(player)
		player:Kick("Shutting down game. All data saved.")
	end
end)

return dataMod
