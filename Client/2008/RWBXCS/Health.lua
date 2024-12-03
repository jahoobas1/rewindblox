-- RWBXCS/Health.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local rbxGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("RobloxGui")
local HealthTray = rbxGui:WaitForChild("HealthTray")
local Backing = HealthTray:WaitForChild("HealthBarBacking")
local bar = HealthTray:WaitForChild("HealthBar")

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()

local humanoid = chr.Humanoid

function func()
	--re declare variables

	chr = plr.Character or plr.CharacterAdded:Wait()
	if chr ~= nil then
		humanoid = chr.Humanoid

		rbxGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("RobloxGui")
		HealthTray = rbxGui:WaitForChild("HealthTray")
		Backing = HealthTray:WaitForChild("HealthBarBacking")
		bar = HealthTray:WaitForChild("HealthBar")
		
		bar.Size = UDim2.new(0.159,0,0, 123 * (humanoid.Health / humanoid.MaxHealth))
		bar.Position = UDim2.new(0.4,0,0,123)
	end
end

while wait() do
	func()
end
