-- RWBXMS/Explosions.lua
-- By jahoobas on 8/31/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local replicatedStorage = game:GetService("ReplicatedStorage")

local explosion = replicatedStorage:WaitForChild("Explosion")

workspace.DescendantAdded:Connect(function(c)
	if c:IsA("Explosion") then
		c.Visible = false
		local new = explosion:Clone()
		new.Parent = c
		new.Position = c.Position
	end
end)
