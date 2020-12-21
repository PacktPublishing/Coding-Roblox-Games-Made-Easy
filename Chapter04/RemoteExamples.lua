RemoteEvent:FireServer()


RemoteEvent.OnServerEvent:Connect(function(player)
	--Statements
end)


RemoteEvent:FireClient(player) --Sends signal to single client
RemoteEvent:FireAllClients() --Sends signal to all clients


--server
wait(5)
RemoteEvent:FireAllClients("Game over!", "Blue team has won!")

--client
local starterGui = game:GetService("StarterGui")
RemoteEvent.OnClientEvent:Connect(function(title, text)
	starterGui:SetCore("SendNotification", {
		Title = title;
		Text = text;
	})
end)


RemoteFunction:InvokeServer()


RemoteFunction.OnServerInvoke = function(player)
	return --optional but use a RemoteEvent for subroutines
end


RemoteFunction:InvokeClient(player)


--server
local clientCamCFrame = RemoteFunction:InvokeClient(player)

--client
local cam = workspace.CurrentCamera
local function getCamCFrame()
	return cam.CFrame
end

RemoteFunction.OnClientInvoke = getCamCFrame


--script 1
local function sum(...)
	local sum = 0
	local nums = {...}

	for _, num in pairs(nums) do
		sum = sum + num
	end

	return sum
end

Function.OnInvoke = sum

--script 2
local sum = Function:Invoke(2, 4, 11)
print(sum)