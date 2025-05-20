local fonts = script.Parent:WaitForChild("Fonts")

local lib = script.Parent:WaitForChild("lib")
local Unicode = require(lib:WaitForChild("Unicode"))

local fontify = {}

function fontify:CreateGUI(parent)
	local gui
	if parent.Name == "StarterGui" or parent.Name ==  "PlayerGui" then
		--Create a ScreenGui
		gui = Instance.new("ScreenGui")
		gui.Parent = parent
		gui.Name = "Fontify_Gui"
	else
		--Create a Frame
		gui = Instance.new("Frame")
		gui.Parent = parent
		gui.Name = "Fontify_Gui"
		gui.Size = UDim2.new(1,0,1,0)
		gui.BackgroundTransparency = 1
	end
	return gui
end

function FindFirstAncestor(descendent,ancestor)
	local d = descendent
	repeat
		d = d.Parent
	until d:IsA(ancestor)
	return d
end

function calculateScaleFactor(r,w,s)
	--Get second height
	local y = r * w

	--use new height to calculate scale factor
	return r * (s/y)
end

function fontify:CreateText(text : string, textsize : number, fontcolor : Color3, strokecolor : Color3, font : string, textalignment : string, strokeTransparency : number, parent : Object)
	local label = fontify:CreateGUI(parent)
	--Alignment
	local area = Instance.new("Frame")
	area.Parent = label
	area.Name = text:gsub(" ","").."_Label"
	area.Size = UDim2.new(0,0,0,0)
	area.BackgroundTransparency = 1
	area.AutomaticSize = Enum.AutomaticSize.XY

	local align = string.split(textalignment, ":")
	local alignX,alignY = align[1],align[2]

	--AlignmentX
	if alignX == "Center" then
		area.AnchorPoint = Vector2.new(.5,area.AnchorPoint.Y)
		area.Position = UDim2.new(.5,0,area.Position.Y.Scale,area.Position.Y.Offset)
	elseif alignX == "Right" then
		area.AnchorPoint = Vector2.new(1,area.AnchorPoint.Y)
		area.Position = UDim2.new(1,0,area.Position.Y.Scale,area.Position.Y.Offset)
	elseif alignX == "Left" then
		area.AnchorPoint = Vector2.new(0,area.AnchorPoint.Y)
		area.Position = UDim2.new(0,0,area.Position.Y.Scale,area.Position.Y.Offset)
	end

	--AlignmentY
	if alignY == "Center" then
		area.AnchorPoint = Vector2.new(area.AnchorPoint.X,.5)
		area.Position = UDim2.new(area.Position.X.Scale,area.Position.X.Offset,.5,0)
	elseif alignY == "Bottom" then
		area.AnchorPoint = Vector2.new(area.AnchorPoint.X,1)
		area.Position = UDim2.new(area.Position.X.Scale,area.Position.X.Offset,1,0)
	elseif alignY == "Top" then
		area.AnchorPoint = Vector2.new(area.AnchorPoint.X,0)
		area.Position = UDim2.new(area.Position.X.Scale,area.Position.X.Offset,0,0)
	end

	local CurrentFont = fonts:WaitForChild(font)
	local Bitmap = CurrentFont:WaitForChild("FontBitmap").Texture
	local FontData = require(CurrentFont:WaitForChild("Font"))

	--Split up text into individual characters
	local charTable = string.split(text,"")
	local offset = 0
	local AspectRatio = FontData[Unicode[charTable[1]]].width/FontData[Unicode[charTable[1]]].height

	local scaleFactor = calculateScaleFactor(AspectRatio,FontData[Unicode["P"]].width,textsize/2)

	for index, char in pairs(charTable) do
		--Turn Character into unicode
		local unicodeChar = Unicode[char]
		local dataChar = FontData[unicodeChar]

		--Create Character
		local chrimg = Instance.new("ImageLabel")
		chrimg.Parent = area
		chrimg.Name = unicodeChar.."_"..char
		chrimg.Image = Bitmap
		chrimg.BackgroundTransparency = 1

		--Set up the sizing, and positioning

		chrimg.ImageRectSize = Vector2.new(dataChar.width,dataChar.height)
		chrimg.ImageRectOffset = Vector2.new(dataChar.x,dataChar.y)

		chrimg.Size = UDim2.new(0,dataChar.width*(scaleFactor), 0, dataChar.height*(scaleFactor))

		chrimg.Position = UDim2.new(0,offset + (dataChar.xoffset*(scaleFactor)),0,0 + (dataChar.yoffset*(scaleFactor)))

		offset += dataChar.xadvance*(scaleFactor)

		--Colors
		chrimg.ImageColor3 = fontcolor

		--Stroke
		if strokeTransparency ~= 1 then
			local gui = FindFirstAncestor(chrimg,"ScreenGui")
			if gui:IsA("ScreenGui") then
				gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
			end

			local s1 = chrimg:Clone()
			s1.Size = UDim2.new(0,chrimg.Size.X.Offset,0, chrimg.Size.Y.Offset)
			s1.Parent = chrimg
			s1.ImageColor3 = strokecolor
			s1.ImageTransparency = strokeTransparency/3
			s1.Position = UDim2.new(0.5,0,0.5,0)
			s1.AnchorPoint = Vector2.new(.5,.5)
			local s2 = chrimg:Clone()
			s2.Size = UDim2.new(0,chrimg.Size.X.Offset + 2,0, chrimg.Size.Y.Offset + 2)
			s2.Parent = chrimg
			s2.ImageColor3 = strokecolor
			s2.ImageTransparency = strokeTransparency/3
			s2.Position = UDim2.new(0.5,0,0.5,0)
			s2.AnchorPoint = Vector2.new(.5,.5)
			local s3 = chrimg:Clone()
			s3.Size = UDim2.new(0,chrimg.Size.X.Offset - 2,0, chrimg.Size.Y.Offset - 2)
			s3.Parent = chrimg
			s3.ImageColor3 = strokecolor
			s3.ImageTransparency = strokeTransparency/3
			s3.Position = UDim2.new(0.5,0,0.5,0)
			s3.AnchorPoint = Vector2.new(.5,.5)

			chrimg.ZIndex += 1
		end
	end
end

return fontify
