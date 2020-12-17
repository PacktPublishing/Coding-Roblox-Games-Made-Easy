local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local hitRemote = replicatedStorage.Hit
local replicateRemote = replicatedStorage.Replicate
local dataMod = require(script.Parent.Data)
local weapons = {}

weapons.playerFromHit = function(hit)
	local char = hit:FindFirstAncestorOfClass("Model")
	local player = playerService:GetPlayerFromCharacter(char)

	return player, char
end

local SECURITY_ANGLE = 15

local function verifyHit(hit, direction, origin, relCFrame, gunSettings)
	local target = (hit.CFrame * relCFrame).p
	local serverDirection = target - origin
	
	if serverDirection.Magnitude > gunSettings.range then return end
	
	if serverDirection.Magnitude == 0 or direction.Magnitude == 0 then return end

	local combinedVectors = serverDirection:Dot(direction)
	local angle = combinedVectors/(direction.Magnitude * serverDirection.Magnitude)

	if angle > 1 then
		angle = 0
	elseif angle < -1 then
		angle = math.pi
	else
		angle = math.acos(angle)
	end
	angle = math.deg(angle)

	if angle <= SECURITY_ANGLE then
		return true
	end
end

hitRemote.OnServerEvent:Connect(function(player, weapon, hit, direction, origin, relCFrame)	
	local otherPlayer, char = weapons.playerFromHit(hit)
	
	if char and char:FindFirstChildOfClass("Humanoid") and not weapon.Debounce.Value then
		local gunSettings = require(weapon.Settings)
		
		if verifyHit(hit, direction, origin, relCFrame, gunSettings) then
			weapon.Debounce.Value = true
			local waitTime = 60/gunSettings.rateOfFire
			delay(waitTime, function()
				weapon.Debounce.Value = false
			end)
			
			local hum = char:FindFirstChildOfClass("Humanoid")

			if hum.Health > 0 then
				local damage = gunSettings.damage
				if hit.Name == "Head" then
					damage = damage * gunSettings.headshotMultiplier
				end
				
				
				hum.Health = hum.Health - damage
				
				if hum.Health <= 0 then
					dataMod.increment(player, "Kills", 1)
				end
			end
		end
	end
end)

replicateRemote.OnServerEvent:Connect(function(player, weapon, origin, target)
	local length = (target - origin).Magnitude
	local visualCFrame = CFrame.new(origin, target) * CFrame.new(0,0,-length/2)
	local gunSettings = require(weapon.Settings)
	
	replicatedStorage.Replicate:FireAllClients(player, gunSettings, visualCFrame, length)
end)

return weapons
