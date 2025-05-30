--@jahoobas
--Unsure when

--[[

Puts important scripts in the first player of a server

]]

local event = game:GetService("ReplicatedStorage"):WaitForChild("RewindBloxV3"):WaitForChild("all"):WaitForChild("hsp")

local rwbxasset_ = game:GetService("ReplicatedStorage"):WaitForChild("RewindBloxV3"):WaitForChild("rwbxasset")

event.OnClientEvent:Connect(function(plr)
	local plyr = game:GetService("Players").LocalPlayer
	
	local studioashx = rwbxasset_:WaitForChild("setup"):Clone()
	studioashx.Parent = plyr.PlayerScripts

	local modifiedPlayer = rwbxasset_:WaitForChild("PlayerModule"):Clone()
	modifiedPlayer.Parent = plyr.PlayerScripts
end)