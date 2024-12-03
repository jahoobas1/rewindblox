--RWBXMS/OldForceField.lua
--By jahoobas on 8/24/2024

--DO NOT EDIT PLEASE!

local forcef = game.ReplicatedStorage:WaitForChild("FF")

function forcefield(ch)
	local ff = forcef:Clone()
	ff.Parent = workspace
	ff:PivotTo(ch.HumanoidRootPart.CFrame)
	if ff:FindFirstChild("ForceFieldM") then
		local ts = game:GetService("TweenService")

		local innerTween = ts:Create(ff.ForceFieldM:WaitForChild("FFInner"), TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { Transparency = 0.5 })
		local innerTween_1 = ts:Create(ff.ForceFieldM:WaitForChild("FFInner"), TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { Transparency = 1 })
		local outerTween = ts:Create(ff.ForceFieldM:WaitForChild("FFOuter"), TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { Transparency = 0.75 })
		local outerTween_1 = ts:Create(ff.ForceFieldM:WaitForChild("FFOuter"), TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { Transparency = 1 })
		
		task.spawn(function()
			local m6d = Instance.new("Motor6D")
			m6d.Parent = ff.PrimaryPart
			m6d.Part0 = ch.HumanoidRootPart
			m6d.Part1 = ff.PrimaryPart
		end)
		
		repeat
			innerTween:Play()
			wait(0.5)
			outerTween:Play()
			innerTween_1:Play()
			wait(0.6)
			outerTween_1:Play()
		until not ch:FindFirstChildOfClass("ForceField")
		
		ff:Destroy()
	end
end

game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(ch)
		wait(.1)
		ch.ChildAdded:Connect(function(c)
			if c:IsA("ForceField") then
				c.Visible = false
				wait(.1)
				forcefield(ch)
			end
		end)
		local c = ch:FindFirstChildOfClass("ForceField")
		if c:IsA("ForceField") then
			c.Visible = false
			forcefield(ch)
		end
	end)
end)

if #game.Players:GetPlayers() == 1 then
	local p = game.Players:GetPlayers()[1]
	p.CharacterAdded:Connect(function(ch)
		wait(.1)
		ch.ChildAdded:Connect(function(c)
			if c:IsA("ForceField") then
				c.Visible = false
				wait(.1)
				forcefield(ch)
			end
		end)
		local c = ch:FindFirstChildOfClass("ForceField")
		if c:IsA("ForceField") then
			c.Visible = false
			forcefield(ch)
		end
	end)
end
