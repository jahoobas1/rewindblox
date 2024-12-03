-- RWBXMS/SurfaceTypes.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

--Surface

local replicatedStorage = game:GetService("ReplicatedStorage")
local assets = replicatedStorage:WaitForChild("Assets")

local inst = {
	Studs = assets:WaitForChild("Studs");
	Universal = assets:WaitForChild("Universal");
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
		if e:IsA("BasePart") and not e.Parent:FindFirstChild("Humanoid") then
			--Set surfaces.
			--1. Studs
			checkSide(e,"Studs","Top")
			checkSide(e,"Studs","Bottom")
			checkSide(e,"Studs","Left")
			checkSide(e,"Studs","Right")
			checkSide(e,"Studs","Front")
			checkSide(e,"Studs","Back")

			--2. Universals.
			checkSide(e,"Universal","Top")
			checkSide(e,"Universal","Bottom")
			checkSide(e,"Universal","Left")
			checkSide(e,"Universal","Right")
			checkSide(e,"Universal","Front")
			checkSide(e,"Universal","Back")
		end
	end
end

changeSurfaces()
