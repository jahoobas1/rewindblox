--RWBXCHS/JumpDelay.lua
--By jahoobas on 8/17/2024

--DO NOT EDIT!

local character = script.Parent.Parent
local humanoid = character:WaitForChild("Humanoid")

local event = script.Parent:WaitForChild("JumpingDelay")

local debounce = false

event.OnServerEvent:Connect(function(plr)
	if debounce == false then
		debounce = true

		wait(.2)

		character.Humanoid.JumpPower = 0

		wait(1)

		debounce = false
		character.Humanoid.JumpPower = 50 
	end
end)
