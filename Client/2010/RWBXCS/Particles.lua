-- RWBXCS/Particles.lua
-- By jahoobas on 10/5/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets")

local particles = assets:WaitForChild("Particles")

local fire = particles:WaitForChild("Fire")
local smoke = particles:WaitForChild("Smoke")

workspace.DescendantAdded:Connect(function(d)
	if d:IsA("Fire") then
		local f = fire:Clone()
		script.ParticleUpdater:Clone().Parent = f
		f.Parent = d
		f.Position = d.Parent.Position

		f.Fire.Enabled = d.Enabled
		
		d.Enabled = false
	elseif d:IsA("Smoke") then
		local f = smoke:Clone()
		script.ParticleUpdater:Clone().Parent = f
		f.Parent = d
		f.Position = d.Parent.Position

		f.Smoke.Enabled = d.Enabled
		f.Smoke.Color = ColorSequence.new(d.Color)

		d.Enabled = false
	end
end)
