--RWBXCS/DeliverUIScripts.lua
--By jahoobas on 8/24/2024

--DO NOT EDIT

local plr = game.Players.LocalPlayer

function del()
	for i,e in pairs(script:GetChildren()) do
		if e:IsA("Script") then
			local c = e:Clone()
			c.Parent = plr:WaitForChild("PlayerGui"):WaitForChild("RobloxGui")
			c.Enabled = true
		end
	end
end

del()

plr.CharacterAdded:Connect(del)
