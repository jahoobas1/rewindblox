-- RWBXMS/Chat.lua
-- By jahoobas on idk what day

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

-- TODO: Rewrite chat scripts

local event = game:GetService("ReplicatedStorage"):WaitForChild("CreateChat")
local chatevent = game:GetService("ReplicatedStorage"):WaitForChild("OnChat")

local ChatService = require(game.ServerScriptService:WaitForChild("ChatServiceRunner"):WaitForChild("ChatService")) 

local textService = game:GetService("TextService")

event.OnServerEvent:Connect(function(plr,text)
	local speaker = ChatService:GetSpeaker(plr.Name)
	local NameColor = speaker.ExtraData.NameColor

	local filterText = textService:FilterStringAsync(text,plr.UserId):GetChatForUserAsync(plr.UserId)

	chatevent:FireAllClients(plr, text, NameColor, filterText)
end)
