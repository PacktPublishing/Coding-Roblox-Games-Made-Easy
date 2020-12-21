local playerService = game:GetService("Players")
local player = playerService.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local tool = script.Parent
local mouse = player:GetMouse()

local equipped
local clicked = false
local JUMP_POWER = 90

tool.Equipped:Connect(function()
	equipped = true
end)

tool.Unequipped:Connect(function()
	equipped = false
end)

mouse.Button1Down:Connect(function()
	if equipped and not clicked then
		clicked = true
		char.Humanoid.JumpPower = JUMP_POWER
		
		delay(30, function()
			char.Humanoid.JumpPower = 50
			tool:Destroy()
		end)
	end
end)