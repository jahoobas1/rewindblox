--Admin Commands
--By jahoobas
--3/27/2025
--For RewindBlox

local replicatedStorage = game:GetService("ReplicatedStorage")
local textService = game:GetService("TextService")

local rwbx3 = replicatedStorage:WaitForChild("RewindBloxV3")
local rwbxasset_ = rwbx3:WaitForChild("rwbxasset")

local chatBindable = rwbxasset_:WaitForChild("chatBindable")

local prefix = "!"

--//COMMANDS FUNCTIONS
--[[
	Command Syntax
	
	command args|args2
]]

function print_(message)
	print(message)
end

function superkick(player, reason)
	player:Kick(reason)
end

function softkick(player)
	rwbx3.tele:tp(player,17464894113)
end

function hint(admin,message)
	local filteredResult = textService:FilterStringAsync(message, admin.UserId, Enum.TextFilterContext.PublicChat)
	local filteredText = filteredResult:GetChatForUserAsync(admin.UserId)
	filteredText = filteredText or "[Content Deleted]"

	local hint = Instance.new("Hint")
	hint.Parent = workspace
	hint.Text = admin.Name..": "..filteredText

	task.spawn(function()
		wait(3)
		hint:Destroy()
	end)
end

function msg(admin,message)
	local filteredResult = textService:FilterStringAsync(message, admin.UserId, Enum.TextFilterContext.PublicChat)
	local filteredText = filteredResult:GetChatForUserAsync(admin.UserId)
	filteredText = filteredText or "[Content Deleted]"

	local hint = Instance.new("Message")
	hint.Parent = workspace
	hint.Text = admin.Name..": "..filteredText

	task.spawn(function()
		wait(3)
		hint:Destroy()
	end)
end

--//EVENT

chatBindable.Event:Connect(function(plr : Player, text : string)
	if table.find(require(rwbx3.lib.admins),plr.UserId) then
		if text:sub(1,7) == prefix.."print " then
			print_(text:sub(8))
		elseif text:sub(1,11) == prefix.."superkick " then
			local args = text:sub(12):split("|")

			local playerToKick = game:GetService("Players"):FindFirstChild(args[1])
			local reason = args[2]

			if playerToKick then
				superkick(playerToKick,reason)
			end
		elseif text:sub(1,6) == prefix.."kick " then
			local playerToKick = game:GetService("Players"):FindFirstChild(text:sub(7))

			if playerToKick then
				softkick(playerToKick)
			end
		elseif text:sub(1,3) == prefix.."h " then
			local admin = plr

			if admin then
				hint(admin,text:sub(4))
			end
		elseif text:sub(1,3) == prefix.."m " then
			local admin = plr

			if admin then
				msg(admin,text:sub(4))
			end
		end
	end
end)