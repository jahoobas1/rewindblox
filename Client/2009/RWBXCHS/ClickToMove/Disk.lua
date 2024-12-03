local disk
if not workspace.MIgnore:FindFirstChild("CTMDisk") then
	disk = game:GetService("ReplicatedStorage"):WaitForChild("CTMDisk"):Clone()
	disk.Parent = workspace.MIgnore
end 

local plr = game.Players.LocalPlayer
local m = plr:GetMouse()

m.TargetFilter = workspace.MIgnore

local closeIcon = "rbxassetid://17474489840"
local farIcon = "rbxassetid://17474489571"

game:GetService("RunService").RenderStepped:Connect(function()
	if workspace.MIgnore:FindFirstChild("CTMDisk") then
		if plr.Character:FindFirstChild("HumanoidRootPart") then
			disk = workspace.MIgnore.CTMDisk
			local state = script.Parent.IsWalkingV.Value
			if (m.Hit.Position-script.Parent.Parent.HumanoidRootPart.Position).Magnitude <= 75 and not script.Parent.Parent:FindFirstChildOfClass("Tool") and (state ~= true or script.Parent.UsingCTMWalk.Value) then
				disk.Transparency = 0
				disk.Position = m.Hit.Position
				plr.PlayerGui.Mouse.ImageLabel.Image = closeIcon
				script.Parent.CTMEnabled.Value = true
			else
				disk.Transparency = 1
				if script.Parent.Parent:FindFirstChildOfClass("Tool") then
				else
					plr.PlayerGui.Mouse.ImageLabel.Image = farIcon
				end

				script.Parent.CTMEnabled.Value = false
			end
		end
	end
end)
