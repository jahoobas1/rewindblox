-- RWBXCHS/OldForceField.lua
-- By jahoobas on 8/18/24

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local RainbowMode = false	--If true, it will cycle through the whole spectrum.
							--If false, it will cycle from red -> blue -> red like it actually did.
local Boxes = {}

function CreateBoxes(ForceField)
	for Index, Value in ipairs(script.Parent:GetDescendants()) do
		if Value:IsA("BasePart") and Value.Name ~= "HumanoidRootPart" then
			local Box = Instance.new("SelectionBox")
			Box.Color3 = Color3.new(1, 0, 0)
			Box.Adornee = Value
			Box.Parent = ForceField
			table.insert(Boxes, Box)
		end
	end
end

function CycleBoxes()
	local Val = 0
	local Ratio = 0
	while true do
		local T = game:GetService("RunService").Heartbeat:Wait()
		if RainbowMode then
			local NoBoxes = true
			for Index, Box in ipairs(Boxes) do
				if Box:IsDescendantOf(script.Parent) then
					Box.Color3 = Color3.fromHSV(Val / 360, 1, 0.75)
					NoBoxes = false
				else
					table.remove(Boxes, Index)
				end
			end
			
			Val = Val + 5
			if Val > 360 then
				Val = Val - 360
			end
			if NoBoxes then
				break
			end
		else
			if Val <= 1 then
				Ratio = Val
			else
				Ratio = 1-(Val-1)
			end
			local NoBoxes = true
			for Index, Box in ipairs(Boxes) do
				if Box:IsDescendantOf(script.Parent) then
					Box.Color3 = Color3.new(1, 0, 0):lerp(Color3.new(0, 0, 1), Ratio)
					NoBoxes = false
				else
					table.remove(Boxes, Index)
				end
			end
			
			Val = Val + (T * 2)
			if Val > 2 then
				Val = Val - 2
			end
			if NoBoxes then
				break
			end
		end
	end
end

function OnChildAdded(Child)
	if Child:IsA("ForceField") then
		Child.Visible = false
		CreateBoxes(Child)
		CycleBoxes()
	end
end

local FF = script.Parent:FindFirstChildOfClass("ForceField")
if FF then
	FF.Visible = false
	CreateBoxes(FF)
	CycleBoxes()
end

script.Parent.ChildAdded:Connect(OnChildAdded)