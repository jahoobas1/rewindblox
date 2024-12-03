-- RWBXMS/SurfaceTypes.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

--Surface

local replicatedStorage = game:GetService("ReplicatedStorage")
local assets = replicatedStorage:WaitForChild("Assets")

local inst = {
	Studs = assets:WaitForChild("Studs");
	Inlet = assets:WaitForChild("Inlet");
	Glue = assets:WaitForChild("Glue");
	Weld = assets:WaitForChild("Weld");
}

function checkSide(part,surfaceType,Side)
	if Side == "Top" then
		if part.TopSurface == Enum.SurfaceType[surfaceType] then
			local surf = inst[surfaceType]:Clone()
			surf.Parent = part
			surf.Face = Enum.NormalId.Top
		end
	elseif Side == "Bottom" then
		if part.BottomSurface == Enum.SurfaceType[surfaceType] then
			local surf = inst[surfaceType]:Clone()
			surf.Parent = part
			surf.Face = Enum.NormalId.Bottom
		end
	elseif Side == "Left" then
		if part.LeftSurface == Enum.SurfaceType[surfaceType] then
			local surf = inst[surfaceType]:Clone()
			surf.Parent = part
			surf.Face = Enum.NormalId.Left
		end
	elseif Side == "Right" then
		if part.RightSurface == Enum.SurfaceType[surfaceType] then
			local surf = inst[surfaceType]:Clone()
			surf.Parent = part
			surf.Face = Enum.NormalId.Right
		end
	elseif Side == "Front" then
		if part.FrontSurface == Enum.SurfaceType[surfaceType] then
			local surf = inst[surfaceType]:Clone()
			surf.Parent = part
			surf.Face = Enum.NormalId.Front
		end
	elseif Side == "Back" then
		if part.BackSurface == Enum.SurfaceType[surfaceType] then
			local surf = inst[surfaceType]:Clone()
			surf.Parent = part
			surf.Face = Enum.NormalId.Back
		end
	end
end

function changeSurfaces()
	for i,e in pairs(game:GetDescendants()) do
		if e:IsA("BasePart") and not e.Parent:FindFirstChildOfClass("SpecialMesh") and not e.Parent:FindFirstChild("Humanoid") and not e:IsA("Terrain") then
			--Add original material value so a Material script can change that.
			local mat = Instance.new("StringValue")
			mat.Parent = e
			mat.Name = "OriginalMaterial"
			mat.Value = tostring(e.Material)

			--Set material to SmoothPlastic to remove the normal studs but keep the effects of a surface.
			e.Material = Enum.Material.SmoothPlastic

			--Set surfaces.
			--1. Studs
			checkSide(e,"Studs","Top")
			checkSide(e,"Studs","Bottom")
			checkSide(e,"Studs","Left")
			checkSide(e,"Studs","Right")
			checkSide(e,"Studs","Front")
			checkSide(e,"Studs","Back")

			--2. Inlets
			checkSide(e,"Inlet","Top")
			checkSide(e,"Inlet","Bottom")
			checkSide(e,"Inlet","Left")
			checkSide(e,"Inlet","Right")
			checkSide(e,"Inlet","Front")
			checkSide(e,"Inlet","Back")

			--3. Welds.
			checkSide(e,"Weld","Top")
			checkSide(e,"Weld","Bottom")
			checkSide(e,"Weld","Left")
			checkSide(e,"Weld","Right")
			checkSide(e,"Weld","Front")
			checkSide(e,"Weld","Back")

			--4. Glues.
			checkSide(e,"Glue","Top")
			checkSide(e,"Glue","Bottom")
			checkSide(e,"Glue","Left")
			checkSide(e,"Glue","Right")
			checkSide(e,"Glue","Front")
			checkSide(e,"Glue","Back")

			--Cylinder textures
			if e:IsA("Part") then
				if e.Shape == Enum.PartType.Cylinder then
					local one = game.ReplicatedStorage.Assets.cyltxt:Clone()
					one.Parent = e
					one.Face = Enum.NormalId.Left

					local two = game.ReplicatedStorage.Assets.cyltxt:Clone()
					two.Parent = e
					two.Face = Enum.NormalId.Right
				end
			end
		end
	end
end

changeSurfaces()
