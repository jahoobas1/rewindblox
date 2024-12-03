--RWBXCHS/JumpDelayClient.lua
--By jahoobas on 8/17/2024

--DO NOT EDIT!

local plr = game.Players.LocalPlayer
local character = plr.Character
local humanoid = character:WaitForChild("Humanoid")

local event = script.Parent:WaitForChild("JumpingDelay")

humanoid.Jumping:Connect(function()
	event:FireServer()
end)
