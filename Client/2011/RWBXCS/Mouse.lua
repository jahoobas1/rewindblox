-- RWBXCS/Mouse.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()

local mouseGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("Mouse"):WaitForChild("ImageLabel")

--local char = game.Players.LocalPlayer.Character

game:GetService("UserInputService").MouseIconEnabled = false

RunService.RenderStepped:Connect(function()
	mouseGui.Position = UDim2.new(0,mouse.X - 40,0,mouse.Y - 40)
	--[[if char:FindFirstChildOfClass("Tool") then--TODO: Custom mouse icons. This should work but I'd prefer not putting a value inside of every tool that has a custom mouse icon.
		if char:FindFirstChildOfClass("Tool"):FindFirstChild("ChangeMIcon") then
			script.Parent.Visible = false
			game:GetService("UserInputService").MouseIconEnabled = true
		else
			script.Parent.Visible = true
			game:GetService("UserInputService").MouseIconEnabled = false
		end
	else
		script.Parent.Visible = true
		game:GetService("UserInputService").MouseIconEnabled = false
	end]]
end)

