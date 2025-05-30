local serverStorage = game:GetService("ServerStorage")

function changeObject(obj : Object)
	if obj then
		if obj:IsA("Model") then
			if obj:FindFirstChildOfClass("Humanoid") then
				if obj:FindFirstChild("Head") then
					local healthbar = serverStorage.HealthBarGui:Clone()
					healthbar.Parent = obj:FindFirstChild("Head")
					healthbar.Adornee = obj:FindFirstChild("Head")
					healthbar:WaitForChild("healthBarScript").Enabled = true
				end
			end
		end
	end
end

for _,objects in pairs(game:GetDescendants()) do
	changeObject()
end

game.DescendantAdded:Connect(changeObject)
