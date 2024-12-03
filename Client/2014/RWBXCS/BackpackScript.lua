-- RWBXCS/BackpackScript.lua
-- By jahoobas on 8/22/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()

local humanoid = chr:WaitForChild("Humanoid")

local bp = plr:WaitForChild("Backpack")

local plrGui = plr:WaitForChild("PlayerGui")
local rbxGui = plrGui:WaitForChild("RobloxGui")
local bpGui = rbxGui:WaitForChild("CurrentLoadout")

local connections = {}

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

function tween(out,ico)
	local tweenService = game:GetService("TweenService")
	
	local start = ico
	start.Size = start.Size
	
	local goal= {}
	if out then
		goal.Size = UDim2.new(1.2,0,1.2,0)
	else
		goal.Size = UDim2.new(1,0,1,0)
	end

	local tweenInfo = TweenInfo.new(.1)

	local tween = tweenService:Create(start, tweenInfo, goal)

	tween:Play()
end

function equip(hold,tmp)
	chr = plr.Character or plr.CharacterAdded:Wait()
	humanoid = chr:WaitForChild("Humanoid")
	
	if hold then
		humanoid:EquipTool(tmp.ConnectedObject.Value)
		
		for _,icon in pairs(bpGui:GetChildren()) do
			if icon:IsA("Frame") then
				if icon.Tool.Equipped.Value == true then
					tween(false,icon.Tool)
					icon.Tool.Equipped.Value = false
				end
			end
		end
		
		tween(true,tmp)
	else
		humanoid:UnequipTools()

		for _,icon in pairs(bpGui:GetChildren()) do
			if icon:IsA("Frame") then
				if icon.Tool.Equipped.Value == true then
					tween(false,icon.Tool)
					icon.Tool.Equipped.Value = false
				end
			end
		end
	end
	tmp.Equipped.Value = hold
end

function init()
	local bp = plr:WaitForChild("Backpack")
	rbxGui = plrGui:WaitForChild("RobloxGui")
	bpGui = rbxGui:WaitForChild("CurrentLoadout")
	for i,e in pairs(bpGui:GetChildren()) do
		if e:IsA("Frame") then
			if e:WaitForChild("Tool").Equipped.Value == false and e:WaitForChild("Tool").ConnectedObject.Value then
				if e:WaitForChild("Tool").ConnectedObject.Value.Parent ~= bp then
					e.Visible = false 
				end
			end
		end
	end
	
	for index,tool in pairs(bp:GetChildren()) do
		local slot = bpGui:FindFirstChild(index)
		if slot.Visible == false then
			slot.Visible = true
			
			local button = slot:WaitForChild("Tool")
			
			button.GearText.Text = tool.Name
			button.GearImage.Image = tool.TextureId
			
			if tool.TextureId ~= "" then
				button.GearText.Visible = false
			end

			button.SlotNumber.Text = index
			button.SlotNumberDownShadow.Text = index
			button.SlotNumberUpShadow.Text = index
			
			button.ConnectedObject.Value = tool

			if connections[index] then
				connections[index]:Disconnect()
			end

			connections[index] = button.MouseButton1Click:Connect(function()
				equip(not button.Equipped.Value,button)
			end)
		end
	end
end

function onInput(inp,gpe)
	if gpe then return end

	local splitKeyCode = string.split(tostring(inp.KeyCode),".")

	for i,e in pairs(bpGui:GetChildren()) do
		if e:IsA("Frame") then
			if numbers[tonumber(e.Tool.SlotNumber.Text)] == splitKeyCode[3] then -- using text because I'm too lazy to add a separate value right now
				equip(not e.Tool.Equipped.Value,e.Tool)
			end
		end
	end
end

--[[function initChild(child) -- Might use later if the above function does not work :) TODO finish this idk
	if bp:FindFirstChild(child) then
		--Added
		
	else
		--Removed
	end
end]]

bp.ChildAdded:Connect(init)
bp.ChildRemoved:Connect(init)

userInputService.InputBegan:Connect(onInput)

chr.ChildAdded:Connect(function(c)
	if c:IsA("Tool") then
		init()
	end
end)

chr.ChildRemoved:Connect(function(c)
	if c:IsA("Tool") then
		init()
	end
end)

plr.CharacterAdded:Connect(init)

init()
