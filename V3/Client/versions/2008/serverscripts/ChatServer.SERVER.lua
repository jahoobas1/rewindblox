--Chat Server
--By jahoobas
--3/26/2025
--For RewindBlox

local replicatedStorage = game:GetService("ReplicatedStorage")
local textService = game:GetService("TextService")

local rwbx3 = replicatedStorage:WaitForChild("RewindBloxV3")
local rwbxasset_ = rwbx3:WaitForChild("rwbxasset")

local send = rwbxasset_:WaitForChild("SendChat")
local receive = rwbxasset_:WaitForChild("OnChatReceive")

local chatBindable = rwbxasset_:WaitForChild("chatBindable")

function getPlayerNameColor(name)
	--I literally found this on the devforum, and it works. No clue how it does, but I'm not complaining.
	--If you know how this works then let me know :) -jahoobas
	local NAME_COLORS =
		{
			Color3.new(253/255, 41/255, 67/255),
			Color3.new(1/255, 162/255, 255/255),
			Color3.new(2/255, 184/255, 87/255),
			BrickColor.new("Bright violet").Color,
			BrickColor.new("Bright orange").Color,
			BrickColor.new("Bright yellow").Color,
			BrickColor.new("Light reddish violet").Color,
			BrickColor.new("Brick yellow").Color,
		}

	local function GetNameValue(pName)
		local value = 0
		for index = 1, #pName do
			local cValue = string.byte(string.sub(pName, index, index))
			local reverseIndex = #pName - index + 1
			if #pName%2 == 1 then
				reverseIndex = reverseIndex - 1
			end
			if reverseIndex%4 >= 2 then
				cValue = -cValue
			end
			value = value + cValue
		end
		return value
	end

	local color_offset = 0
	local function ComputeNameColor(pName)
		return NAME_COLORS[((GetNameValue(pName) + color_offset) % #NAME_COLORS) + 1]
	end
	local predictedColor = ComputeNameColor(name)

	return predictedColor
end

send.OnServerEvent:Connect(function(plr, text : string)
	local usercolor = getPlayerNameColor(plr.Name)
	
	local filteredResult = textService:FilterStringAsync(text, plr.UserId, Enum.TextFilterContext.PublicChat)
	local filteredText = filteredResult:GetNonChatStringForBroadcastAsync()
	filteredText = filteredText or "[Content Deleted]"
	
	receive:FireAllClients(plr, usercolor, filteredText)
	chatBindable:Fire(plr, text) -- Send original text so scripts can get the non filtered one. Useful for quiz games and other kinds of scripts
end)
