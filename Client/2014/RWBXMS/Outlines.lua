--RWBXMS/Outlines.lua
--By jahoobas on 8/24/2024

--NO EDITING

local outline = game.ReplicatedStorage.Assets.PartOutline

for i,e in pairs(game:GetDescendants()) do
	if e:IsA("Part") and e.Shape == Enum.PartType.Block and not e:FindFirstChildOfClass("SpecialMesh") and not e:FindFirstChildOfClass("CylinderMesh") and not e:FindFirstChildOfClass("FileMesh") and not e:FindFirstChildOfClass("BlockMesh") then
		if not e.Parent:FindFirstChild("Humanoid") and not e.Parent:FindFirstChild("FFMiddle") then
			local ol = outline:Clone()
			ol.Parent = e
			ol.Adornee = e
		end
	end
end
