local part = workspace.Part

local bodyForce = Instance.new("BodyForce")
bodyForce.Parent = part

local requiredForce = part:GetMass() * workspace.Gravity
bodyForce.Force = Vector3.new(0,requiredForce,0)


local Part2 = workspace.Part2
local lookVector = (Part2.Position - Part1.Position).Unit
--p2 – p1 = directional vector at p1 looking at p2

local moverVel = lookVector * projectileVel
bodyVelocity.Velocity = moverVel


local part = workspace.Part
local bodyPosition = Instance.new("BodyPosition")
local huge = math.huge
bodyPosition.MaxForce = Vector3.new(huge,huge,huge)
bodyPosition.Parent = part
bodyPosition.Position = Vector3.new(0,15,0)


local bodyGyro = Instance.new("BodyGyro")
local huge = math.huge
bodyGyro.MaxTorque = Vector3.new(huge,huge,huge)
bodyGyro.Parent = part
bodyGyro.CFrame = part.CFrame * CFrame.fromOrientation(0,0, math.pi/4)


local bodyThrust = Instance.new("BodyThrust")
bodyThrust.Parent = part
local requiredForce = part:GetMass() * workspace.Gravity * 2
bodyThrust.Force = Vector3.new(0,requiredForce,0)
--Force will be applied upwards relative to part orientation
