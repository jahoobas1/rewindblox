--RWBXCS/PlayerList.lua
--By jahoobas on 8/24/24

--DO NOT CHANGE UNLESS FIXING A BUG!

local players = game:GetService("Players")
local plr = players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()

local plrGui = plr:WaitForChild("PlayerGui")
local rbxGui = plrGui:WaitForChild("RobloxGui")
local plrList = rbxGui:WaitForChild("PlayerList")
local header = plrList:WaitForChild("LeaderBoardFrame"):WaitForChild("Header")
local scrollingArea = plrList:WaitForChild("LeaderBoardFrame"):WaitForChild("ListFrame"):WaitForChild("BottomFrame"):WaitForChild("SubFrame")

local replicatedStorage = game:GetService("ReplicatedStorage")
local core = replicatedStorage:WaitForChild("Core")
local templates = core:WaitForChild("Templates")

local plrListNameTemplate = templates:WaitForChild("NameTemp")
local plrListTeamTemplate = templates:WaitForChild("TeamTemp")

local teams = game:GetService("Teams")

local moderators = require(replicatedStorage:WaitForChild("moderatorList"))

local width = 0

local existing = {}

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

function leaderstats(isTeam,temp,tplr,isname,team)
	if tplr then
		for i,e in pairs(tplr.leaderstats:GetChildren()) do
			if i == 1 then
				header.PlayerScore.Text = e.Value
				header.PlayerScore.Visible = true

				local linked = Instance.new("ObjectValue")
				linked.Parent = header.PlayerScore
				linked.Name = "LinkedStat"
				linked.Value = e

				linked.Value.Changed:Connect(function()
					header.PlayerScore.Text = linked.Value.Value
				end)
			end
			break
		end
	end
	if not isTeam then
		if isname then
			local statsHolder = temp.Stats
			--Is a players name.
			for i,e in pairs(statsHolder:GetChildren()) do
				if e:IsA("TextLabel") then
					if e.Name ~= "StatTemplate" then
						e:Destroy()
					end
				end
			end
			for i,e in pairs(tplr.leaderstats:GetChildren()) do
				local new = statsHolder.StatTemplate:Clone()
				new.Parent = statsHolder
				new.Visible = true

				new.Text = e.Value
				new.Name = e.Name
				
				local linked = Instance.new("ObjectValue")
				linked.Parent = new
				linked.Name = "LinkedStat"
				linked.Value = e
				
				linked.Value.Changed:Connect(function()
					new.Text = linked.Value.Value
				end)
				
				--pos
				new.Position = UDim2.new(1,linked.Value.Shared.Value,.4,0)
			end
		else
			local statsHolder = header.StatTitles
			--Is the top.
			for i,e in pairs(statsHolder:GetChildren()) do
				if e:IsA("TextLabel") then
					if e.Name ~= "StatTemplate" then
						e:Destroy()
					end
				end
			end
			plrList:WaitForChild("LeaderBoardFrame").Size = UDim2.new(0,145,0,800)
			for i,e in pairs(plr.leaderstats:GetChildren()) do
				local new = statsHolder.StatTemplate:Clone()
				new.Parent = statsHolder
				new.Visible = true
				
				new.Text = e.Name
				new.Name = e.Name
				
				--positioning
				--add up all other widths
				
				width = 0
				
				for i,v in pairs(statsHolder:GetChildren()) do
					if v:IsA("TextLabel") then
						if v.Name ~= "StatTemplate" then
							if v ~= new then
								width += v.TextBounds.X+6
							end
						end
					end
				end
				
				local sharedpos
				
				if not e:FindFirstChild("Shared") then
					sharedpos = Instance.new("NumberValue")
					sharedpos.Name = "Shared"
					sharedpos.Parent = e
				else
					sharedpos = e.Shared
				end
				
				sharedpos.Value = -(((width)+(new.TextBounds.X))+6)
				
				--apply that to the position with other values
				new.Position = UDim2.new(1,-(((width)+(new.TextBounds.X))+6),.4,0)
				
				--sizing
				plrList:WaitForChild("LeaderBoardFrame").Size += UDim2.new(0,new.TextBounds.X+6,0,0)
			end
		end
	else
		local teamStats = getTeamStats(team)
		local statsHolder = temp.Stats
		--Is a team.
		if #teamStats ~= 0 then
			for i,e in pairs(statsHolder:GetChildren()) do
				if e:IsA("TextLabel") then
					if e.Name ~= "StatTemplate" then
						e:Destroy()
					end
				end
			end
			for i,e in pairs(teamStats) do
				local new = statsHolder.StatTemplate:Clone()
				new.Parent = statsHolder
				new.Visible = true

				new.Text = e.Value
				new.Name = e.Name

				local linked = Instance.new("ObjectValue")
				linked.Parent = new
				linked.Name = "LinkedStat"
				linked.Value = e.Linked

				--pos
				new.Position = UDim2.new(1,linked.Value.Shared.Value,.4,0)

				for _,player in pairs(team:GetPlayers()) do
					for _,stat in pairs(player.leaderstats:GetChildren()) do
						stat.Changed:Connect(function()
							leaderstats(true,temp,nil,nil,team)
						end)
					end
				end
			end
		else
			for i,e in pairs(plr.leaderstats:GetChildren()) do
				local new = statsHolder.StatTemplate:Clone()
				new.Parent = statsHolder
				new.Visible = true

				new.Text = "0"
				new.Name = e.Name

				--pos
				new.Position = UDim2.new(1,e.Shared.Value,.4,0)
			end
		end
	end
end

function createName(name,isATeam,belongsToTeam,Team,ttemp,index)
	if isATeam == false then
		if not belongsToTeam then
			local clonedTemplate = plrListNameTemplate:Clone()
			clonedTemplate.Parent = scrollingArea
			
			clonedTemplate.Name = name
			clonedTemplate.Content.Label.Dropshadow.Text = name
			clonedTemplate.Content.Label.Text = name
			
			if players[name]:FindFirstChild("leaderstats") then
				leaderstats(false,clonedTemplate,players[name],true,nil)
			end
			
			if moderators[name] then
				--Is a moderator.
				clonedTemplate.Content.img.Image = moderators[name]
			end
		else
			local clonedTemplate = plrListNameTemplate:Clone()
			clonedTemplate.Parent = scrollingArea

			clonedTemplate.Name = name
			clonedTemplate.Content.Label.Text = name
			clonedTemplate.Content.Label.Dropshadow.Text = name
			
			clonedTemplate.LayoutOrder = ttemp.LayoutOrder + 1

			if players[name]:FindFirstChild("leaderstats") then
				leaderstats(false,clonedTemplate,players[name],true,nil)
			end

			if moderators[name] then
				--Is a moderator.
				clonedTemplate.Content.img.Image = moderators[name]
			end
		end
	else
		local clonedTemplate = plrListTeamTemplate:Clone()
		clonedTemplate.Parent = scrollingArea
		
		--teamcolor
		clonedTemplate.Content.BackgroundColor3 = Team.TeamColor.Color
		clonedTemplate.Content.BorderColor3 = Team.TeamColor.Color
		--clonedTemplate.Stats.BackgroundColor3 = Team.TeamColor.Color

		clonedTemplate.Name = name
		clonedTemplate.Content.Label.Text = name

		clonedTemplate.LayoutOrder = #clonedTemplate.Parent:GetChildren() + 1

		if plr:FindFirstChild("leaderstats") then
			leaderstats(true,clonedTemplate,nil,nil,Team)
		end
		
		for _,p in pairs(Team:GetPlayers()) do
			createName(p.Name,false,true,Team,clonedTemplate)
		end
	end
	
	scrollingArea.Size += UDim2.new(0,0,0,20)
end

function init(h)
	plr = players.LocalPlayer
	chr = plr.Character or plr.CharacterAdded:Wait()
	for _,item in pairs(scrollingArea:GetChildren()) do
		if item:IsA("Frame") then
			item:Destroy()
		end
	end
	
	header.PlayerName.Text = plr.Name
	
	leaderstats(false,nil,nil,false,nil)
	
	if #teams:GetChildren() == 0 then
		for index,player in pairs(players:GetPlayers()) do
			createName(player.Name,false,false,nil,nil,index)
		end
	else
		for index,team in pairs(teams:GetChildren()) do
			createName(team.Name,true,false,team,nil,index)
		end
	end
end

game.Players.PlayerAdded:Connect(init)
game.Players.PlayerRemoving:Connect(init)

plr.CharacterAdded:Connect(init)

plr.DescendantAdded:Connect(function(d)
	if d.Name == "leaderstats" or d.Parent.Name == "leaderstats" then
		init()
	end
end)
plr.DescendantRemoving:Connect(function(d)
	if d.Name == "leaderstats" or d.Parent.Name == "leaderstats" then
		init()
	end
end)

init()
