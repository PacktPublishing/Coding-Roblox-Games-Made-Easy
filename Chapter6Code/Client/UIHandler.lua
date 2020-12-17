for _, module in pairs(script:GetChildren()) do
	local loadMod = coroutine.create(function()
		require(module)
	end)

	coroutine.resume(loadMod)
end