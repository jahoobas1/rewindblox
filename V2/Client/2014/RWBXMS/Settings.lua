-- RWBXMS/Settings.lua
-- By jahoobas on 8/24/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local settingsEvents = game.ReplicatedStorage:WaitForChild("SettingsRemoteEvents")

local reset = settingsEvents:WaitForChild("Reset")
local leave = settingsEvents:WaitForChild("Leave")
local report = settingsEvents:WaitForChild("Report")

reset.OnServerEvent:Connect(function(plr)
	plr.Character.Humanoid.Health = 0
end)

leave.OnServerEvent:Connect(function(plr) 
	--TODO
end)

report.OnServerEvent:Connect(function(plr)
	--Will be done when Studio is finished
end)
