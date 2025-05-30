--@jahoobas
--Not really sure when I programmed this, never made sure to actually document it

--[[

This script makes it easy to show the old Message instance accurately to the time period.

]]


local orms = {}

function newFitsLabel()
	local new = script:WaitForChild("fitslabel"):Clone()
	
	return new
end

function orms:msg(text, version, plr)
	--[[
		Versions:
		
		1: 2006-2009
		2: 2010
		3: 2011-2014
		
		orms:msg("text", 1, game.Players.LocalPlayer)
		orms:msg("text", 2, game.Players.LocalPlayer)
	]]
	local gui = plr.PlayerGui.RobloxGui
	
	--remove all RBXMESSAGE in gui
	for _,child in pairs(gui:GetChildren()) do
		if child.Name == "RBXMESSAGE" then
			child:Destroy()
		end
	end
	
	if version == 1 then
		local aspect = 3.34593023255814
		
		local width = .59947916666666664
		local height = .3416087388282026
		
		local messageScreen = Instance.new("Frame")
		messageScreen.Parent = gui
		messageScreen.Name = "RBXMESSAGE"
		messageScreen.Size = UDim2.new(width,0,height,0)
		messageScreen.BackgroundTransparency = .5
		messageScreen.BorderSizePixel = 0
		messageScreen.BackgroundColor3 = Color3.fromRGB(172,172,172)
		messageScreen.AnchorPoint = Vector2.new(.5,.5)
		messageScreen.Position = UDim2.new(.5,0,.5,0)
		
		local border = Instance.new("Frame")
		border.Parent = messageScreen
		border.Name = "Border"
		border.BackgroundTransparency = 1
		border.Size = UDim2.new(1,2,1,2)
		border.Position = UDim2.new(0,-1,0,-1)

		local top = Instance.new("Frame")
		top.Parent = border
		top.Size = UDim2.new(1,0,0,1)
		top.BackgroundColor3 = Color3.fromRGB(172,172,172)
		top.BorderSizePixel = 0

		local bottom = Instance.new("Frame")
		bottom.Parent = border
		bottom.Size = UDim2.new(1,0,0,1)
		bottom.Position = UDim2.new(0,0,1,-1)
		bottom.BackgroundColor3 = Color3.fromRGB(172,172,172)
		bottom.BorderSizePixel = 0

		local left = Instance.new("Frame")
		left.Parent = border
		left.Size = UDim2.new(0,1,1,0)
		left.BackgroundColor3 = Color3.fromRGB(172,172,172)
		left.BorderSizePixel = 0

		local right = Instance.new("Frame")
		right.Parent = border
		right.Size = UDim2.new(0,1,1,0)
		right.Position = UDim2.new(1,-1,0,0)
		right.BackgroundColor3 = Color3.fromRGB(172,172,172)
		right.BorderSizePixel = 0
		
		local aspectratio = Instance.new("UIAspectRatioConstraint")
		aspectratio.AspectRatio = aspect
		aspectratio.Parent = messageScreen
		
		local lbl = newFitsLabel()
		lbl.Parent = messageScreen
		lbl.Name = "Label"
		lbl.Position = UDim2.new(-1,0,0.5,0)
		lbl.AnchorPoint = Vector2.new(0,0.5)
		lbl.Text = text
		lbl.Size = UDim2.new(3,0,0.2,0)
		lbl.Font = Enum.Font.Cartoon
		lbl.BackgroundTransparency = 1
		lbl.TextColor3 = Color3.new(1,1,1)
	elseif version == 2 then
		local aspect = 3.34593023255814

		local width = .59947916666666664
		local height = .3416087388282026

		local messageScreen = Instance.new("Frame")
		messageScreen.Parent = gui
		messageScreen.Name = "RBXMESSAGE"
		messageScreen.Size = UDim2.new(width,0,height,0)
		messageScreen.BackgroundTransparency = .5
		messageScreen.BorderSizePixel = 0
		messageScreen.BackgroundColor3 = Color3.fromRGB(172,172,172)
		messageScreen.AnchorPoint = Vector2.new(.5,.5)
		messageScreen.Position = UDim2.new(.5,0,.5,0)

		local border = Instance.new("Frame")
		border.Parent = messageScreen
		border.Name = "Border"
		border.BackgroundTransparency = 1
		border.Size = UDim2.new(1,2,1,2)
		border.Position = UDim2.new(0,-1,0,-1)

		local top = Instance.new("Frame")
		top.Parent = border
		top.Size = UDim2.new(1,0,0,1)
		top.BackgroundColor3 = Color3.fromRGB(172,172,172)
		top.BorderSizePixel = 0

		local bottom = Instance.new("Frame")
		bottom.Parent = border
		bottom.Size = UDim2.new(1,0,0,1)
		bottom.Position = UDim2.new(0,0,1,-1)
		bottom.BackgroundColor3 = Color3.fromRGB(172,172,172)
		bottom.BorderSizePixel = 0

		local left = Instance.new("Frame")
		left.Parent = border
		left.Size = UDim2.new(0,1,1,0)
		left.BackgroundColor3 = Color3.fromRGB(172,172,172)
		left.BorderSizePixel = 0

		local right = Instance.new("Frame")
		right.Parent = border
		right.Size = UDim2.new(0,1,1,0)
		right.Position = UDim2.new(1,-1,0,0)
		right.BackgroundColor3 = Color3.fromRGB(172,172,172)
		right.BorderSizePixel = 0

		local aspectratio = Instance.new("UIAspectRatioConstraint")
		aspectratio.AspectRatio = aspect
		aspectratio.Parent = messageScreen

		local lbl = newFitsLabel()
		lbl.Parent = messageScreen
		lbl.Name = "Label"
		lbl.Position = UDim2.new(-1,0,0.5,0)
		lbl.AnchorPoint = Vector2.new(0,0.5)
		lbl.Text = text
		lbl.Size = UDim2.new(3,0,0.2,0)
		lbl.Font = Enum.Font.Arimo
		lbl.BackgroundTransparency = 1
		lbl.TextColor3 = Color3.new(1,1,1)
	elseif version == 3 then
		local aspect = 4

		local width = .5
		local height = .23833167825223438

		local messageScreen = Instance.new("Frame")
		messageScreen.Parent = gui
		messageScreen.Name = "RBXMESSAGE"
		messageScreen.Size = UDim2.new(width,0,height,0)
		messageScreen.BackgroundTransparency = .5
		messageScreen.BorderSizePixel = 0
		messageScreen.BackgroundColor3 = Color3.new(0,0,0)
		messageScreen.AnchorPoint = Vector2.new(.5,.5)
		messageScreen.Position = UDim2.new(.5,0,.5,0)

		local aspectratio = Instance.new("UIAspectRatioConstraint")
		aspectratio.AspectRatio = aspect
		aspectratio.Parent = messageScreen

		local lbl = newFitsLabel()
		lbl.Parent = messageScreen
		lbl.Name = "Label"
		lbl.Position = UDim2.new(-1,0,0.5,0)
		lbl.AnchorPoint = Vector2.new(0,0.5)
		lbl.Text = text
		lbl.Size = UDim2.new(3,0,.145,0)
		lbl.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
		lbl.BackgroundTransparency = 1
		lbl.TextColor3 = Color3.new(1,1,1)
	else
		warn("Invalid message version")
	end
end

return orms
