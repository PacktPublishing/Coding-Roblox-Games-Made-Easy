--module
local module = {}
module.initialize = function()
	print("Initialized")
end

return module

--script
local mod = require(module)
mod.initialize()


--module
local module = {}
module.Heavy = {
	MaxHealth = 500;
	Health = 500;
	WalkSpeed = 11;
}

return module

--script
local mod = require(module)
print(mod.Heavy.MaxHealth)
