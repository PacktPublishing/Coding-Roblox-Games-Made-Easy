local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local dataMod = require(script.Parent.Data)
local lootMod = require(script.Parent.Loot)
local random = Random.new()
local message = replicatedStorage.Message
local remaining = replicatedStorage.Remaining
local gameRunner = {}
local competitors = {}

local MIN_PLAYERS = 2
local INTERMISSION_LENGTH = 5
local ROUND_LENGTH = 300
local PRIZE_AMOUNT = 100

local getCompetitors = replicatedStorage.GetCompetitors
local updateCompetitors = replicatedStorage.UpdateCompetitors

getCompetitors.OnServerInvoke = function()
	return competitors
end

local function getPlayerInTable(player)
	for i, competitor in pairs(competitors) do
		if competitor == player then
			return i, player
		end
	end
end

local function removePlayerFromTable(player)
	local index, _ = getPlayerInTable(player)
	if index then
		table.remove(competitors, index)
		updateCompetitors:FireAllClients(competitors)
	end
end

local function spawnPlayers()
	local spawnPoints = workspace.Spawns:GetChildren()
	
	for _, player in pairs(competitors) do
		local char = player.Character or player.CharacterAdded:Wait()
		local randomIndex = random:NextInteger(1, #spawnPoints)
		local spawnPoint = spawnPoints[randomIndex]
		table.remove(spawnPoints, randomIndex)
		
		char:SetPrimaryPartCFrame(spawnPoint.CFrame * CFrame.new(0,2,0))
	end
end

local function preparePlayer(player)
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")

	local defaultWeapon = replicatedStorage.Weapons.M1911:Clone()
	defaultWeapon.Parent = player.Backpack
	
	hum.Died:Connect(function()
		removePlayerFromTable(player)
	end)
end

local function addPlayersToTable()
	for _, player in pairs(playerService:GetPlayers()) do
		local char = player.Character or player.CharacterAdded:Wait()
		
		if char.Humanoid.Health > 0 then
			table.insert(competitors, player)
			preparePlayer(player)
		end
	end
end

local function loadAllPlayers()
	for _, player in pairs(competitors) do
		player:LoadCharacter()
	end
end

playerService.PlayerRemoving:Connect(function(player)
	removePlayerFromTable(player)
end)

gameRunner.gameLoop = function()
	while wait(0.5) do
		if #playerService:GetPlayers() < MIN_PLAYERS then
			message.Value = "There must be ".. MIN_PLAYERS.. " players to start."
		else
			local intermission = INTERMISSION_LENGTH
			repeat
				message.Value = "Intermission: ".. intermission
				intermission = intermission - 1
				wait(1)
			until intermission == 0

			message.Value = "Get ready..."
			wait(2)
			addPlayersToTable()
			spawnPlayers()
			lootMod.spawnWeapons()
			updateCompetitors:FireAllClients(competitors)

			local gameTime = ROUND_LENGTH
			repeat
				message.Value = "Time remaining: ".. gameTime
				remaining.Value = #competitors.. " remaining"
				gameTime = gameTime - 1
				wait(1)
			until #competitors <= 1 or gameTime == 0
			
			loadAllPlayers()
			remaining.Value = ""

			if gameTime == 0 or #competitors == 0 then
				message.Value = "There were no victors..."
			else
				local winner = competitors[1]
				dataMod.increment(winner, "Wins", 1)
				dataMod.increment(winner, "Coins", PRIZE_AMOUNT)
				message.Value = winner.Name.. " has won the round!"
			end
			
			competitors = {}
			updateCompetitors:FireAllClients(competitors)
			wait(5)
		end
	end
end

spawn(gameRunner.gameLoop)


return gameRunner