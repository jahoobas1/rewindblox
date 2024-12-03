--RWBXCS/MainMenuActions.lua
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

local leaveMenu = pageHolder:WaitForChild("LeaveConfirmationMenu")
local resetMenu = pageHolder:WaitForChild("ResetConfirmationMenu")

local leaveButton = leaveMenu:WaitForChild("YesButton")
local resetButton = resetMenu:WaitForChild("YesButton")

local settingsEvents = game.ReplicatedStorage:WaitForChild("SettingsRemoteEvents")

local reset = settingsEvents:WaitForChild("Reset")
local leave = settingsEvents:WaitForChild("Leave")
local report = settingsEvents:WaitForChild("Report")

local lStart = leaveMenu.Position
local rStart = resetMenu.Position

function tweener()
	local tweenService = game:GetService("TweenService")
	local start = menu
	start.Position = menu.Position

	local goal = {}
	goal.Position = UDim2.new(0.5, -262,-0.5, -200)
	task.spawn(function() 
		wait(.15) 
		menuShield.Visible = false 
		mainMenu.Position = UDim2.new(0,0,0,0) 
		mainMenu.Visible = true 
		leaveMenu.Position = lStart
		resetMenu.Position = rStart

		resetMenu.Visible = false
		leaveMenu.Visible = false
	end)

	local info = TweenInfo.new(0.15)

	local tween = tweenService:Create(start,info,goal)

	tween:Play()
end

leaveButton.MouseButton1Click:Connect(function()
	leave:FireServer()
	tweener()
end)

resetButton.MouseButton1Click:Connect(function()
	reset:FireServer()
	tweener()
end)
