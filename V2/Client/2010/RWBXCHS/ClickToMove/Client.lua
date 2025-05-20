local disk = workspace.MIgnore:WaitForChild("CTMDisk")

local plr = game.Players.LocalPlayer
local m = plr:GetMouse()

local uis = game:GetService("UserInputService")

m.Button1Down:Connect(function()
	if script.Parent.CTMEnabled.Value and not script.Parent.Parent:FindFirstChildOfClass("Tool") then
		--Delete all old disks
		for i,e in pairs(workspace.MIgnore:GetChildren()) do
			if e.Name == "CTMDiskWalkto" then
				e:Destroy()
			end
		end
		
		--make a new one at the position
		local pos = m.Hit.Position
		
		local d = disk:Clone()
		d.Parent = disk.Parent
		d.Name = "CTMDiskWalkto"
		d.Position = disk.Position
		
		--Fire server event to walk to it
		script.Parent.CTM:FireServer(pos)
	end
end)

script.Parent:WaitForChild("Arrived").OnClientEvent:Connect(function(plr)
	workspace.MIgnore.CTMDiskWalkto:Destroy()
end)

script.Parent.Parent.Humanoid.Died:Connect(function()
	script.Parent.Cut:FireServer()
	for i,e in pairs(workspace.MIgnore:GetChildren()) do
		e:Destroy()
	end
end)

uis.InputBegan:Connect(function(input,gpe)
	if gpe then return end
	
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.MouseButton2 and input.UserInputType ~= Enum.UserInputType.MouseButton3 and input.KeyCode ~= Enum.KeyCode.Left and input.KeyCode ~= Enum.KeyCode.Right and input.KeyCode ~= Enum.KeyCode.Space then
		if workspace.MIgnore:FindFirstChild("CTMDiskWalkto") then
			script.Parent.Cut:FireServer()
			workspace.MIgnore.CTMDiskWalkto:Destroy()
		end
	end
end)
