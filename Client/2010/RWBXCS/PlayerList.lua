-- RWBXCS/PlayerList.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

--Variables

local replicatedStorage = game:GetService("ReplicatedStorage")
local coreGuiStuff = replicatedStorage:WaitForChild("Core")
local templates = coreGuiStuff:WaitForChild("Templates")

local players = game:GetService("Players")
local plr = players.LocalPlayer

local plrGui = plr:WaitForChild("PlayerGui")
local rblxGui = plrGui:WaitForChild("RobloxGui")
local plrList = rblxGui:WaitForChild("PlayerList")
local holder = plrList:WaitForChild("PlayerListHolder")

local list = holder:WaitForChild("List")

local teams = game:GetService("Teams")

--Functions

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

function getTeamStats(team)
	local teamPlayers = team:GetPlayers()
	
	local StatsTable = {}
	
	for _,player in pairs(teamPlayers) do
		for index,stat in pairs(player.leaderstats:GetChildren()) do
			if not StatsTable[index] then
				StatsTable[index] = {
					["Name"] = stat.Name;
					["Value"] = 0;
					["Linked"] = stat;
				}
			end
			StatsTable[index].Value += stat.Value
		end
	end
	
	return StatsTable
end

function leaderstats(isName,template,currentPlayer,isATeam,Team)
	if not isName then
		--Is the top of the leaderboard. Get the labels set up.
		plrList.LSHolder.AllHolder.UIListLayout.Padding = UDim.new(0,-(#plr.leaderstats:GetChildren()*30))
		for _,stat in pairs(plr.leaderstats:GetChildren()) do
			if not plrList.LSHolder.AllHolder:FindFirstChild(stat.Name) then
				local statTemp = templates.PlayerListStatLabelTemplate:Clone()
				statTemp.Parent = plrList.LSHolder.AllHolder
				statTemp.Name = stat.Name
				statTemp.Text = stat.Name
			end
		end
	else
		if not isATeam then
			--Is a players name. Set up the values.
			template.LSHolder.AllHolder.UIListLayout.Padding = plrList.LSHolder.AllHolder.UIListLayout.Padding
			for _,stat in pairs(currentPlayer.leaderstats:GetChildren()) do
				if not template.LSHolder.AllHolder:FindFirstChild(stat.Name) then
				local statTemp = templates.PlayerListStatValueTemplate:Clone()
					statTemp.Parent = template.LSHolder.AllHolder
					statTemp.Name = stat.Name
					statTemp.Text = stat.Value
					statTemp.Linked.Value = stat
					
					statTemp.Linked.Value.Changed:Connect(function()
						statTemp.Text = statTemp.Linked.Value.Value
					end)
				end
			end
		else
			--Is a team. Set up values accordingly.
			template.LSHolder.AllHolder.UIListLayout.Padding = plrList.LSHolder.AllHolder.UIListLayout.Padding
			
			local currentstats = getTeamStats(Team)
			if #currentstats ~= 0 then
				--Set stats
				for index,stat in pairs(currentstats) do
					if not template.LSHolder.AllHolder:FindFirstChild(stat.Name) then
						local statTemp = templates.PlayerListStatValueTemplate:Clone()
						statTemp.Parent = template.LSHolder.AllHolder
						statTemp.Name = stat.Name
						statTemp.Text = stat.Value

						statTemp.TextStrokeTransparency = 0
						statTemp.TextColor3 = Team.TeamColor.Color
						
						stat.Linked.Changed:Connect(function()
							statTemp.Text = stat.Value	
						end)
					end
				end
			else
				--Set them to 0
				for index,stat in pairs(plr.leaderstats:GetChildren()) do
					if not template.LSHolder.AllHolder:FindFirstChild(stat.Name) then
						local statTemp = templates.PlayerListStatValueTemplate:Clone()
						statTemp.Parent = template.LSHolder.AllHolder
						statTemp.Name = stat.Name
						statTemp.Text = 0
						
						statTemp.TextStrokeTransparency = 0
						statTemp.TextColor3 = Team.TeamColor.Color
					end
				end
			end
		end
	end
end

function init()
	--Remove all of the existing names
	for i,e in pairs(list:GetChildren()) do
		if e:IsA("TextLabel") then
			e:Destroy()
		end
	end

	--Check for leaderstats
	if plr:FindFirstChild("leaderstats") then --leaderstats is in the localplayer.
		--Set the player list up to be able to handle this!
		plrList.Transparency = 0.5
		plrList.Title.Visible = true
		plrList.LSHolder.Visible = true
		plrList.Title.Text = "Player"
		plrList.Position = UDim2.new(1,-326,0,11)

		--Get the stats on the leaderboard.
		leaderstats(false,nil,nil)
	end
	
	if #teams:GetChildren() == 0 then
		--Add back the names
		for _,player in pairs(players:GetPlayers()) do
			--Get the template
			local temp = templates:WaitForChild("PlayerListTemplate"):Clone()
			temp.Parent = list
			temp.Name = player.Name
			temp.Text = player.Name
			
			local color = getPlayerNameColor(player.Name)
			temp.TextColor3 = color
			
			--Check for leaderstats
			if player:FindFirstChild("leaderstats") then --leaderstats is in this player.
				--Set the players name to handle this.
				
				temp.LSHolder.Visible = true
				
				--Get the stats on the players name
				leaderstats(true,temp,player,false,nil)
			end
		end
	else
		--Add the teams, and give them children
		--Check for leaderstats
		if plr:FindFirstChild("leaderstats") then --leaderstats is in the localplayer.
			--Set the player list up to be able to handle this!
			plrList.Title.Text = "Team"
		else
			--Move the stuff up so we can get rid of the titlebar
			plrList.Position = UDim2.new(1,-9,0,-36)
			plrList.Transparency = 1
			plrList.Title.Visible = false
		end
		
		--Get the team labels
		for _,team in pairs(teams:GetChildren()) do
			--Get the template
			local temp = templates:WaitForChild("PlayerListTeamTemplate"):Clone()
			temp.Parent = list
			temp.Name = team.Name
			temp.Text = team.Name

			local color = team.TeamColor.Color
			temp.TextColor3 = color
			temp.TeamLine.BackgroundColor3 = color
			temp.LSHolder.TeamLine.BackgroundColor3 = color

			--Check for leaderstats
			if plr:FindFirstChild("leaderstats") then --leaderstats is in this game,thus team.
				--Set the players name to handle this.

				temp.LSHolder.Visible = true

				--Get the stats on the players name
				leaderstats(true,temp,nil,true,team)
			end
			
			--Put the team members in the Children frame
			for _,player in pairs(players:GetPlayers()) do
				if player.TeamColor == team.TeamColor then
					--Get the template
					local plrtemp = templates:WaitForChild("PlayerListTemplate"):Clone()
					plrtemp.Parent = temp.Children
					plrtemp.Name = player.Name
					plrtemp.Text = player.Name

					local color = team.TeamColor.Color
					plrtemp.TextColor3 = color

					--Check for leaderstats
					if player:FindFirstChild("leaderstats") then --leaderstats is in this player.
						--Set the players name to handle this.

						plrtemp.LSHolder.Visible = true
						plrtemp.LSHolder.BackgroundTransparency = 1

						--Get the stats on the players name
						leaderstats(true,plrtemp,player,false,nil)

						for _,label in pairs(plrtemp.LSHolder.AllHolder:GetChildren()) do
							if label:IsA("TextLabel") then
								label.TextColor3 = color
							end
						end
					end
				end
			end
		end
	end
end

--Events
players.PlayerAdded:Connect(init)
players.PlayerRemoving:Connect(init)

plr.DescendantAdded:Connect(function(d)
	if d then
		if d.Name == "leaderstats" or d.Parent.Name == "leaderstats" then
			init()
		end
	end
end)
plr.DescendantRemoving:Connect(function(d)
	if d then
		if d.Name == "leaderstats" or d.Parent.Name == "leaderstats" then
			init()
		end
	end
end)

--Run on initialize
init()
