-- RWBXMS/ChangeToolParent.lua
-- By jahoobas on 8/22/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

function ChangeToolParent(player, tool, parent)
	local char = player.Character
	if char then
		for i,v in pairs(char:GetChildren()) do
			if v:IsA("BackpackItem") then
				v.Parent = player.Backpack
			end
		end
	end
	
	if tool and parent then
		if tool:IsA("BackpackItem") then
			tool.Parent = parent
		end
	end
end

game.ReplicatedStorage.ChangeToolParent.OnServerEvent:Connect(ChangeToolParent)

function DropHat(player)
	if player.Character ~= nil then
		for i,v in pairs(player.Character:GetChildren()) do
			if v.ClassName == "Accessory" then
				v.Parent = game.Workspace
			end
		end
	end
end

--game.ReplicatedStorage.DropHat.OnServerEvent:Connect(DropHat)