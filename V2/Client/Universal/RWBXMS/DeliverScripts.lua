-- RWBXMS/DeliverScripts.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")

players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		for i,e in pairs(replicatedStorage.Core.Scripts:GetChildren()) do
			game.ReplicatedStorage.Delivery:FireClient(plr,e,plr)
		end
	end)
end)

wait(.1)

if #game.Players:GetPlayers() == 1 then
	for i,e in pairs(replicatedStorage.Core.Scripts:GetChildren()) do
		game.ReplicatedStorage.Delivery:FireClient(game.Players:GetPlayers()[1],e,game.Players:GetPlayers()[1])
	end
end
