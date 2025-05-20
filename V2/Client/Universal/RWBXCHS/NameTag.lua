--RWBXCHS/NameTag.lua
--By jahoobas on 8/24/2024

--Don't change!

local HBGui = game.ServerStorage:WaitForChild("HealthBarGui"):Clone()

HBGui.Parent = script.Parent.Head
HBGui.Adornee = script.Parent.Head

local hum = script.Parent.Humanoid

hum.Changed:Connect(function()
	HBGui.HealthBar.Bar.Size = UDim2.new((hum.Health/hum.MaxHealth),0,1,0)
end)

script.Parent.Changed:Connect(function()
	HBGui.NameLabel.Text = script.Parent.Name
end)

HBGui.NameLabel.Text = script.Parent.Name