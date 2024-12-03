--RWBXCHS/MeshHead.lua
--By jahoobas on 8/17/2024

--DO NOT EDIT!

local meshHead = game.ReplicatedStorage.Assets.MeshHead:Clone()
meshHead.Parent = script.Parent
meshHead.Transparency = 0
meshHead.Decal.Transparency = 0

local head = script.Parent:WaitForChild("Head")
head.Transparency = 1
head.face.Transparency = 1

meshHead.Color = head.Color

game["Run Service"].RenderStepped:Connect(function()
	meshHead.CFrame = head.CFrame

	meshHead.Color = head.Color
end)
