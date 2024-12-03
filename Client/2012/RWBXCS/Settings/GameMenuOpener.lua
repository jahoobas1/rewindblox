--RWBXCS/GameMenuOpener.lua
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
local resume = mainMenu:WaitForChild("resumeGameButton")

local blcontrol = ControlFrame:WaitForChild("BottomLeftControl")
local button = blcontrol:WaitForChild("SettingsButton")

local uis = game:GetService("UserInputService")

function tweener(opening)
	local tweenService = game:GetService("TweenService")
	local start = menu
	start.Position = menu.Position
	
	local goal = {}
	if opening then
		goal.Position = UDim2.new(0.5, -262,0.5, -200)
		menuShield.Visible = opening
	else
		goal.Position = UDim2.new(0.5, -262,-0.5, -200)
		task.spawn(function() wait(.15) menuShield.Visible = opening end)
	end
	
	local info = TweenInfo.new(0.15)
	
	local tween = tweenService:Create(start,info,goal)
	
	tween:Play()
end

function runner()
	tweener(not menuShield.Visible)

	if menuShield.Visible then
		button.ImageTransparency = 0
	else
		button.ImageTransparency = .75
	end
end

button.MouseButton1Click:Connect(runner)

resume.MouseButton1Click:Connect(runner)

uis.InputBegan:Connect(function(inp)
	if mainMenu.Visible then
		if inp.KeyCode == Enum.KeyCode.Escape then
			runner()
		end
	end
end)

player.Character:WaitForChild("Humanoid").Died:Connect(function()
	wait(5.01)
	
	--Redeclare variables

	rbxGui = plrGui:WaitForChild("RobloxGui")

	ControlFrame = rbxGui:WaitForChild("ControlFrame")
	menuShield = ControlFrame:WaitForChild("UserSettingsShield")

	menu = menuShield:WaitForChild("Settings")

	pageHolder = menu:WaitForChild("SettingsStyle")

	mainMenu = pageHolder:WaitForChild("GameMainMenu")
	resume = mainMenu:WaitForChild("resumeGameButton")

	blcontrol = ControlFrame:WaitForChild("BottomLeftControl")
	button = blcontrol:WaitForChild("SettingsButton")
end)
