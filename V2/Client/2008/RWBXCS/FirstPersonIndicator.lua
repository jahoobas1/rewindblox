-- RWBXCS/FirstPersonIndicator.lua
-- By jahoobas on 8/18/24

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local players = game:GetService("Players")
local plr = players.LocalPlayer

local plrGui = plr:WaitForChild("PlayerGui")
local rbxGui = plrGui:WaitForChild("RobloxGui")

local indicator = rbxGui:WaitForChild("FirstPersonIndicator")

local camera = workspace.CurrentCamera

camera.Changed:Connect(function()
	local head = plr.Character:WaitForChild("Head")
	local dist = (camera.CFrame.Position - head.Position).Magnitude
	
	if dist < 1 then
		indicator.Visible = true
	else
		indicator.Visible = false
	end
end)
