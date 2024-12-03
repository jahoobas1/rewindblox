--RWBXCS/SwitchTabs.lua
--By jahoobas on 8/24/2024

--DO NOT EDIT UNLESS FIXING ISSUES

local player = game.Players.LocalPlayer
local plrGui = player:WaitForChild("PlayerGui")
local rbxGui = plrGui:WaitForChild("RobloxGui")

local ControlFrame = rbxGui:WaitForChild("ControlFrame")
local menuShield = ControlFrame:WaitForChild("UserSettingsShield")

local menu = menuShield:WaitForChild("Settings")

local pageHolder = menu:WaitForChild("SettingsStyle")

local mainMenu = pageHolder:WaitForChild("GameMainMenu")
local settingsMenu = pageHolder:WaitForChild("GameSettingsMenu")
local leaveMenu = pageHolder:WaitForChild("LeaveConfirmationMenu")
local resetMenu = pageHolder:WaitForChild("ResetConfirmationMenu")

local settingsButton = mainMenu:WaitForChild("SettingsButton")
local leaveButton = mainMenu:WaitForChild("LeaveGameButton")
local resetButton = mainMenu:WaitForChild("ResetButton")

local settingsBack = settingsMenu:WaitForChild("BackButton")
local leaveBack = leaveMenu:WaitForChild("NoButton")
local resetBack = resetMenu:WaitForChild("NoButton")

local setStart = settingsMenu.Position
local lStart = leaveMenu.Position
local rStart = resetMenu.Position

function tweener(newTab,old)
	local tweenService = game:GetService("TweenService")
	
	--move the main menu
	local start = mainMenu
	local goal = {}

	if newTab == "Main" then
		--Just come back
		start.Position = mainMenu.Position
		goal.Position = UDim2.new(0,0,0,0)
		mainMenu.Visible = true
	elseif newTab == "Sett" then
		--go left
		start.Position = mainMenu.Position
		goal.Position = UDim2.new(-2,-100,0,10)

		task.spawn(function()
			wait(.15)
			mainMenu.Visible = false
		end)
	elseif newTab == "Leav" then
		--go down
		start.Position = mainMenu.Position
		goal.Position = UDim2.new(0,0,1,125)

		task.spawn(function()
			wait(.15)
			mainMenu.Visible = false
		end)
	elseif newTab == "Rese" then
		--go up
		start.Position = mainMenu.Position
		goal.Position = UDim2.new(0,0,1,155)

		task.spawn(function()
			wait(.15)
			mainMenu.Visible = false
		end)
	end

	local info = TweenInfo.new(0.15)

	local tween = tweenService:Create(start,info,goal)

	tween:Play()

	--move the new menu
	local goal = {}

	if newTab == "Main" then
		--Just come back
		if old == "Sett" then
			--go left
			start = settingsMenu
			start.Position = settingsMenu.Position
			goal.Position = setStart
		elseif old == "Leav" then
			--go down
			start = leaveMenu
			start.Position = leaveMenu.Position
			goal.Position = lStart
		elseif old == "Rese" then
			--go up
			start = resetMenu
			start.Position = resetMenu.Position
			goal.Position = rStart
		end
		task.spawn(function() wait(.15) start.Visible = false end)
	elseif newTab == "Sett" then
		--go left
		start = settingsMenu
		start.Position = settingsMenu.Position
		goal.Position = UDim2.new(0,0,0,0)
		start.Visible = true
	elseif newTab == "Leav" then
		--go down
		start = leaveMenu
		start.Position = leaveMenu.Position
		goal.Position = UDim2.new(0,0,0,0)
		start.Visible = true
	elseif newTab == "Rese" then
		--go up
		start = resetMenu
		start.Position = resetMenu.Position
		goal.Position = UDim2.new(0,0,0,0)
		start.Visible = true
	end

	local info = TweenInfo.new(0.15)

	local tween = tweenService:Create(start,info,goal)

	tween:Play()
end

settingsButton.MouseButton1Click:Connect(function()
	tweener("Sett",nil)
end)

resetButton.MouseButton1Click:Connect(function()
	tweener("Rese",nil)
end)

leaveButton.MouseButton1Click:Connect(function()
	tweener("Leav",nil)
end)

settingsBack.MouseButton1Click:Connect(function()
	tweener("Main","Sett")
end)

resetBack.MouseButton1Click:Connect(function()
	tweener("Main","Rese")
end)

leaveBack.MouseButton1Click:Connect(function()
	tweener("Main","Leav")
end)
