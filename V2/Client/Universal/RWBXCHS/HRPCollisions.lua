--RWBXCHS/HRPCollisions.lua
--By jahoobas on 8/24/2024

--NO EDITING

script.Parent.Humanoid.Died:Connect(function()
	if script.Parent:FindFirstChild("HumanoidRootPart") then
		script.Parent.HumanoidRootPart.CanCollide = false
	end
end)