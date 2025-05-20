-- RWBXCS/Backpack.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

--Variables

local plr = game.Players.LocalPlayer
local bp = plr:WaitForChild("Backpack")

local plrGui = plr:WaitForChild("PlayerGui")
local rbxGui = plrGui:WaitForChild("RobloxGui")
local bpGui = rbxGui:WaitForChild("Backpack")

local templates = game:GetService("ReplicatedStorage"):WaitForChild("Core"):WaitForChild("Templates")

local userInputService = game:GetService("UserInputService")

local numbers = {
	[1] = "One",
	[2] = "Two",
	[3] = "Three",
	[4] = "Four",
	[5] = "Five",
	[6] = "Six",
	[7] = "Seven",
	[8] = "Eight",
	[9] = "Nine",
	[0] = "Zero"
}

--Functions

function hover(hasImageIcon,template) --Hover function for items
	if not template.Equipped.Value then
		if not hasImageIcon then
			--Text label based
			template.Hover.Visible = true
		else
			--Image label based
			template.ImageHolder.Transparency = 0
		end
	end
end

function unhover(hasImageIcon,template) --Mouseleave function for items
	if not template.Equipped.Value then
		if not hasImageIcon then
			--Text label based
			template.Hover.Visible = false
		else
			--Image label based
			template.ImageHolder.Transparency = 1
		end
	end
end

function held(hasImageIcon,template) --Hold function for items
	local equipped = template.Equipped.Value
	if not equipped then
		if not hasImageIcon then
			--Text label based
			template.Hover.Visible = true
			template.Hover.BackgroundColor3 = Color3.fromRGB(255,255,0)
		else
			--Image label based
			template.ImageHolder.BackgroundColor3 = Color3.fromRGB(0,0,255)
		end
	end
end

function click(hasImageIcon,template) --Click function for items
	template.Equipped.Value = not template.Equipped.Value
	
	local equipped = template.Equipped.Value
	
	--Disable all the others
	for _,tem in pairs(bpGui:GetChildren()) do
		if tem:IsA("Frame") then
			if tem ~= template then
				tem.Outline.Visible = false
				tem.ImageHolder.Transparency = 1
				tem.Equipped.Value = false
			end
		end
	end
	
	if equipped then
		--Equip the item
		plr.Character.Humanoid:EquipTool(template.LinkedItem.Value)
		if hasImageIcon then
			template.ImageHolder.BackgroundColor3 = Color3.fromRGB(0,255,0)
			template.ImageHolder.Transparency = 0
		else
			template.Hover.Visible = false
		end
	else
		--Unequip all items
		plr.Character.Humanoid:UnequipTools()
		if hasImageIcon then
			template.ImageHolder.BackgroundColor3 = Color3.fromRGB(255,255,0)
			template.ImageHolder.Transparency = 1
		else
			template.Hover.Visible = false
		end
	end
	
	template.Outline.Visible = equipped
end

function init()
	bp = plr.Backpack
	wait(.1)
	print(bp:GetChildren())
	-- Add the items
	for index,item in pairs(bp:GetChildren()) do
		print(item)
		if not bpGui:FindFirstChild(item.Name) then
			local temp = templates:WaitForChild("BackpackItemTemplate"):Clone()
			temp.Parent = bpGui
			temp.Name = item.Name
			temp.LinkedItem.Value = item

			temp.ItemLabel.Text = item.Name

			local usesImage = item.TextureId ~= ""

			if usesImage then
				temp.ItemLabel.Visible = false
				temp.ImageHolder.Icon.Image = item.TextureId
			end
		end
	end
	
	-- Set up all of them
	for index,e in pairs(bpGui:GetChildren()) do
		if e:IsA("Frame") and not e:FindFirstChild("SetUp") then
			e.ItemNumber.Value = index-1
			e.LayoutOrder = index-1
			e.NumberLabel.Text = index-1

			local usesImage = e.LinkedItem.Value.TextureId ~= ""

			e.Clicker.MouseEnter:Connect(function() --Hover
				hover(usesImage,e)
			end)

			e.Clicker.MouseLeave:Connect(function() --Unhover
				unhover(usesImage,e)
			end)

			e.Clicker.MouseButton1Down:Connect(function() --Hold
				held(usesImage,e)
			end)

			e.Clicker.MouseButton1Up:Connect(function() --Click
				click(usesImage,e)
			end)

			local checker = Instance.new("BoolValue")
			checker.Parent = e
			checker.Name = "SetUp"
		end
	end
end

function added(child)
	if not bpGui:FindFirstChild(child.Name) then
		local temp = templates:WaitForChild("BackpackItemTemplate"):Clone()
		temp.Parent = bpGui
		temp.Name = child.Name
		temp.LinkedItem.Value = child

		temp.ItemLabel.Text = child.Name

		local usesImage = child.TextureId ~= ""

		if usesImage then
			temp.ItemLabel.Visible = false
			temp.ImageHolder.Icon.Image = child.TextureId
		end
	end

	-- Set up all of them
	for index,e in pairs(bpGui:GetChildren()) do
		if e:IsA("Frame") and not e:FindFirstChild("SetUp") then
			e.ItemNumber.Value = index-1
			e.LayoutOrder = index-1
			e.NumberLabel.Text = index-1

			local usesImage = e.LinkedItem.Value.TextureId ~= ""

			e.Clicker.MouseEnter:Connect(function() --Hover
				hover(usesImage,e)
			end)

			e.Clicker.MouseLeave:Connect(function() --Unhover
				unhover(usesImage,e)
			end)

			e.Clicker.MouseButton1Down:Connect(function() --Hold
				held(usesImage,e)
			end)

			e.Clicker.MouseButton1Up:Connect(function() --Click
				click(usesImage,e)
			end)
			
			local checker = Instance.new("BoolValue")
			checker.Parent = e
			checker.Name = "SetUp"
		end
	end
end

function removed(child)
	--Remove the child
	for _,icon in pairs(bpGui:GetChildren()) do
		if icon:IsA("Frame") then
			if icon.LinkedItem.Value == child then
				if not icon.Equipped.Value then
					icon:Destroy()
				end
			end
		end
	end

	-- Set up all of them
	for index,e in pairs(bpGui:GetChildren()) do
		if e:IsA("Frame") and not e:FindFirstChild("SetUp") then
			e.ItemNumber.Value = index-1
			e.LayoutOrder = index-1
			e.NumberLabel.Text = index-1

			local checker = Instance.new("BoolValue")
			checker.Parent = e
			checker.Name = "SetUp"
		end
	end
end

function onInput(inp,gpe)
	if gpe then return end

	local splitKeyCode = string.split(tostring(inp.KeyCode),".")

	for i,e in pairs(bpGui:GetChildren()) do
		if not e:IsA("UIListLayout") then
			if numbers[e.ItemNumber.Value] == splitKeyCode[3] then
				local usesImage = e.LinkedItem.Value.TextureId ~= ""
				click(usesImage,e)
			end
		end
	end
end

--Events
wait(.5)
bp.ChildAdded:Connect(added)
bp.ChildRemoved:Connect(removed)

plr.CharacterAdded:Connect(init)

userInputService.InputBegan:Connect(onInput)

--Run on initialize

init()
