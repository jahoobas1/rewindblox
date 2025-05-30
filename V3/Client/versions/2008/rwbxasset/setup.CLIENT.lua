wait(.1)

local replicatedStorage = game:GetService("ReplicatedStorage")

local asset_ = replicatedStorage:WaitForChild("RewindBloxV3"):WaitForChild("asset")
local game_ = replicatedStorage:WaitForChild("RewindBloxV3"):WaitForChild("game")

local player = game:GetService("Players").LocalPlayer

local studioashx = game_:WaitForChild("studio"):Clone()
studioashx.Parent = player.PlayerScripts
