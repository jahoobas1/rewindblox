--RWBXCS/PlayerList.lua
--By jahoobas on 8/21/24

--DO NOT CHANGE UNLESS FIXING A BUG!

local players = game:GetService("Players")
local plr = players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()

local plrGui = plr:WaitForChild("PlayerGui")
local rbxGui = plrGui:WaitForChild("RobloxGui")
local plrList = rbxGui:WaitForChild("PlayerList")
local header = plrList:WaitForChild("SmallPlayerlist"):WaitForChild("Header")
local scrollingArea = plrList:WaitForChild("SmallPlayerlist"):WaitForChild("ScrollingArea"):WaitForChild("ScrollingFrame")

local closeButton = header:WaitForChild("CloseButton")
local maximizeButton = plrList:WaitForChild("MinimizedPlayerlist"):WaitForChild("GoSmallButton")
local bigButton = header:WaitForChild("GoBigButton")

local replicatedStorage = game:GetService("ReplicatedStorage")
local core = replicatedStorage:WaitForChild("Core")
local templates = core:WaitForChild("Templates")

local plrListNameTemplate = templates:WaitForChild("PlayerListName")
local plrListTeamTemplate = templates:WaitForChild("PlayerListTeam")

local teams = game:GetService("Teams")

local moderators = require(replicatedStorage:WaitForChild("moderatorList"))

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
	if not isTeam then
		if isname then
			local statsHolder = temp.Stats
			--Is a players name.
			for i,e in pairs(tplr.leaderstats:GetChildren()) do
				statsHolder:WaitForChild("Stat"..i).Visible = true
				statsHolder:WaitForChild("Stat"..i).Text = e.Value
				
				local linked = Instance.new("ObjectValue")
				linked.Parent = statsHolder:WaitForChild("Stat"..i)
				linked.Name = "LinkedStat"
				linked.Value = e
				
				linked.Value.Changed:Connect(function()
					statsHolder:WaitForChild("Stat"..i).Text = linked.Value.Value
				end)
				
				if i == 3 then
					break -- In 2011-2012, the playerlist only displayed 3 leaderstats. I know this because I did some testing in an older client.
				end
			end
		else
			local statsHolder = plrList.SmallPlayerlist.Header.Headers
			--Is the top.
			for i,e in pairs(plr.leaderstats:GetChildren()) do
				statsHolder:WaitForChild("Stat"..i).Visible = true
				statsHolder:WaitForChild("Stat"..i).Text = e.Name

				if i == 3 then
					break
				end
			end
		end
	else
		local teamStats = getTeamStats(team)
		local statsHolder = temp:WaitForChild("Stats")
		--Is a team.
		if #teamStats ~= 0 then
			for i,e in pairs(teamStats) do
				statsHolder.Holder:WaitForChild("Stat"..i).Visible = true
				statsHolder.Holder:WaitForChild("Stat"..i).Text = e.Value

				local linked = Instance.new("ObjectValue")
				linked.Parent = statsHolder.Holder:WaitForChild("Stat"..i)
				linked.Name = "LinkedStat"
				linked.Value = e.Linked

				for _,player in pairs(team:GetPlayers()) do
					for _,stat in pairs(player.leaderstats:GetChildren()) do
						stat.Changed:Connect(function()
							leaderstats(true,temp,nil,nil,team)
						end)
					end
				end

				if i == 3 then
					break
				end
			end
		else
			for i,e in pairs(plr.leaderstats:GetChildren()) do
				statsHolder.Holder:WaitForChild("Stat"..i).Visible = true
				statsHolder.Holder:WaitForChild("Stat"..i).Text = "0"
				
				if i == 3 then
					break
				end
			end
		end
	end
end

function createName(name,isATeam,alt,belongsToTeam,Team,ttemp)
	if isATeam == false then
		if not belongsToTeam then
			local clonedTemplate = plrListNameTemplate:Clone()
			clonedTemplate.Parent = scrollingArea
			if not alt then
				clonedTemplate.BackgroundTransparency = 0.95
			end
			
			clonedTemplate.Name = name
			clonedTemplate.NameArea.NameLabel.Text = name
			
			if players[name]:FindFirstChild("leaderstats") then
				leaderstats(false,clonedTemplate,players[name],true,nil)
			end
			
			if moderators[name] then
				clonedTemplate.NameArea.MembershipTypeLabel.Image = moderators[name]
			end
		else
			local clonedTemplate = plrListNameTemplate:Clone()
			clonedTemplate.Parent = ttemp.Children
			if not alt then
				clonedTemplate.BackgroundTransparency = 0.95
			end

			clonedTemplate.Name = name
			clonedTemplate.NameArea.NameLabel.Text = name
			clonedTemplate.NameArea.NameLabel.TextColor3 = Team.TeamColor.Color

			if players[name]:FindFirstChild("leaderstats") then
				leaderstats(false,clonedTemplate,players[name],true,nil)
			end

			if moderators[name] then
				clonedTemplate.NameArea.MembershipTypeLabel.Image = moderators[name]
			end
		end
	else
		local clonedTemplate = plrListTeamTemplate:Clone()
		clonedTemplate.Parent = scrollingArea
		
		--teamcolor
		clonedTemplate.NameArea.NameLabel.BackgroundColor3 = Team.TeamColor.Color
		clonedTemplate.Stats.BackgroundColor3 = Team.TeamColor.Color

		clonedTemplate.Name = name
		clonedTemplate.NameArea.NameLabel.Text = name

		if plr:FindFirstChild("leaderstats") then
			leaderstats(true,clonedTemplate,nil,nil,Team)
		end
		
		for _,p in pairs(Team:GetPlayers()) do
			createName(p.Name,false,nil,true,Team,clonedTemplate)
		end
	end
end

function close(closing)
	local tweenservice = game:GetService("TweenService")
	
	local start = plrList:WaitForChild("SmallPlayerlist")
	start.Position = start.Position
	
	local goal = {}
	
	if closing then
		goal.Position = UDim2.new(1,0,0,5)
	else
		plrList:WaitForChild("SmallPlayerlist").Visible = true
		plrList:WaitForChild("MinimizedPlayerlist").Visible = false
		goal.Position = UDim2.new(0,-20,0,5)
	end
	
	local tweenInfo = TweenInfo.new(.15,Enum.EasingStyle.Sine)

	local tween = tweenservice:Create(start, tweenInfo, goal)

	tween:Play()
	wait(.15)
	plrList:WaitForChild("SmallPlayerlist").Visible = not closing
	plrList:WaitForChild("MinimizedPlayerlist").Visible = closing
end

function init()
	for _,item in pairs(scrollingArea:GetChildren()) do
		if item:IsA("Frame") then
			item:Destroy()
		end
	end

	if plr:FindFirstChild("leaderstats") then
		leaderstats(false,nil,nil,false,nil)
	end
	
	if #teams:GetChildren() == 0 then
		for index,player in pairs(players:GetPlayers()) do
			createName(player.Name,false,index % 2 == 0,false,nil,nil)
		end
	else
		for index,team in pairs(teams:GetChildren()) do
			createName(team.Name,true,nil,false,team,nil)
		end
	end
end

game.Players.PlayerAdded:Connect(init)
game.Players.PlayerRemoving:Connect(init)

closeButton.MouseButton1Click:Connect(function()
	close(true)
end)

maximizeButton.MouseButton1Click:Connect(function()
	close(false)
end)

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
