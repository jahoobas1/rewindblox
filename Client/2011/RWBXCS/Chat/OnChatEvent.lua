-- RWBXCS/OnChatEvent.lua
-- By jahoobas on idk what day

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

-- TODO: Rewrite chat scripts

local onChat = game:GetService("ReplicatedStorage"):WaitForChild("OnChat")

local rbxGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("RobloxGui")

onChat.OnClientEvent:Connect(function(plr,text,chatcolor, filtered)
	local color = tostring(chatcolor):split(",")

	local r = math.round(tonumber(color[1]) * 255)
	local g = math.round(tonumber(color[2]) * 255)
	local b = math.round(tonumber(color[3]) * 255)
	local ChatColor3 = r..", "..g..", "..b

	local clonedTextLabel = script.Chat:Clone()
	clonedTextLabel.Parent = rbxGui.ChatsHolder
	clonedTextLabel.Text = "<font color='rgb("..tostring(r)..", "..tostring(g)..", "..tostring(b)..")'>"..plr.Name..";</font>     "..filtered

	local timeRemover = script.removeAfterTime:Clone()
	timeRemover.Parent = clonedTextLabel
	timeRemover.Enabled = true
end)

