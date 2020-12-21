local replicatedStorage = game:GetService("ReplicatedStorage")
local playerService = game:GetService("Players")
local getCompetitors = replicatedStorage.GetCompetitors
local updateCompetitors = replicatedStorage.UpdateCompetitors
local player = playerService.LocalPlayer
local cam = workspace.CurrentCamera
local spectate = {}

local gui = script.Parent.Parent
local spectateFrame = gui:WaitForChild("Spectate")
local toggle = gui:WaitForChild("Toggle")
local nameLabel = spectateFrame:WaitForChild("NameLabel")
local nextPlayer = spectateFrame:WaitForChild("NextPlayer")
local lastPlayer = spectateFrame:WaitForChild("LastPlayer")

local competitors = {}
local curIndex = 1
local spectating = false
spectateFrame.Visible = false

spectate.getCompetitors = function()
	competitors = getCompetitors:InvokeServer()
end

updateCompetitors.OnClientEvent:Connect(function(list)
	competitors = list
	
	for _, competitor in pairs(competitors) do
		if competitor == player then
			toggle.Visible = false
			
			if spectating then
				spectate.toggleSpectate()
			end
			return
		end
	end
	
	if spectating then
		spectate.focusCamera(competitors[curIndex])
	end
end)

spectate.toggleSpectate = function()
	if not spectating then
		spectating = true
		spectate.getCompetitors()
		spectateFrame.Visible = true
		local targetPlayer = competitors[1]
		spectate.focusCamera(targetPlayer)
	else
		spectating = false
		spectateFrame.Visible = false
		spectate.focusCamera(player)
	end
end

spectate.focusCamera = function(targetPlayer)
	if #competitors == 0 and spectating then
		spectate.toggleSpectate()
	else
		if targetPlayer then
			cam.CameraSubject = targetPlayer.Character
			nameLabel.Text = targetPlayer.Name
		else
			spectate.getCompetitors()
			local newTargetPlayer = competitors[1]
			spectate.focusCamera(newTargetPlayer)
		end
	end
end

toggle.MouseButton1Click:Connect(function()
	spectate.toggleSpectate()
end)

nextPlayer.MouseButton1Click:Connect(function()
	spectate.getCompetitors()
	
	curIndex = curIndex + 1
	if curIndex > #competitors then
		curIndex = 1
	end
	
	local targetPlayer = competitors[curIndex]
	spectate.focusCamera(targetPlayer)
end)

lastPlayer.MouseButton1Click:Connect(function()
	spectate.getCompetitors()
	
	curIndex = curIndex - 1
	if curIndex < 1 then
		curIndex = #competitors
	end
	
	local targetPlayer = competitors[curIndex]
	spectate.focusCamera(targetPlayer)
end)

return spectate