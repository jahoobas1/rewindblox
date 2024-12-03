--RWBXCHS/MidAirRotation.lua
--By jahoobas on 8/17/2024

--DO NOT EDIT!

while task.wait() do
	if script.Parent.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or script.Parent.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
		script.Parent.Humanoid.AutoRotate = false
	else
		script.Parent.Humanoid.AutoRotate = true
	end
end
