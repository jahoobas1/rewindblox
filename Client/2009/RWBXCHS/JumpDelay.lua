--RWBXCHS/JumpDelay.lua
--By jahoobas on 8/17/2024, redone by robloxsammy747 on 10/11/2024

--DO NOT EDIT!

local char = script.Parent
local humanoid = char:WaitForChild("Humanoid")

local function onStateChanged(old,new)
	if old == Enum.HumanoidStateType.Freefall and new == Enum.HumanoidStateType.Landed then
		humanoid:SetStateEnabled("Jumping",false)
		task.wait(0.45)
		humanoid:SetStateEnabled("Jumping",true)
	end
end

humanoid.StateChanged:Connect(onStateChanged)
