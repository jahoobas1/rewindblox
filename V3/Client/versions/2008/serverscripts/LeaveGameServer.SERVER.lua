local replicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local rwbx3 = require(replicatedStorage:WaitForChild("RewindBloxV3"))
local rwbxasset_ = replicatedStorage:WaitForChild("RewindBloxV3"):WaitForChild("rwbxasset")

local event = rwbxasset_:WaitForChild("Leave")

event.OnServerEvent:Connect(function(plr,place)
	TeleportService:TeleportAsync(place, {plr})
end)
