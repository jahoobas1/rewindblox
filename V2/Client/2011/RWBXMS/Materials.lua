-- RWBXMS/Materials.lua
-- By jahoobas on 8/22/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

wait(.1)

local matFolder = game.ReplicatedStorage.Assets.Materials

local concrete = matFolder.Concrete
local diamondplate = matFolder.DiamondPlate
local foil = matFolder.Foil
local grass = matFolder.Grass
local ice = matFolder.Ice
local slate = matFolder.Slate
local wood = matFolder.Wood

for i,e in pairs(game:GetDescendants()) do
	if e:IsA("BasePart") then
		if e.Material == Enum.Material.Concrete then
			for _,side in pairs(concrete:GetChildren()) do
				side:Clone().Parent = e
			end
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "Concrete"
		elseif e.Material == Enum.Material.DiamondPlate then
			for _,side in pairs(diamondplate:GetChildren()) do
				side:Clone().Parent = e
			end
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "DiamondPlate"
		elseif e.Material == Enum.Material.Foil then
			for _,side in pairs(foil:GetChildren()) do
				side:Clone().Parent = e
			end
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "Foil"
		elseif e.Material == Enum.Material.Grass then
			for _,side in pairs(grass:GetChildren()) do
				side:Clone().Parent = e
			end
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "Grass"
		elseif e.Material == Enum.Material.Ice then
			for _,side in pairs(ice:GetChildren()) do
				side:Clone().Parent = e
			end
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "Ice"
		elseif e.Material == Enum.Material.Slate then
			for _,side in pairs(slate:GetChildren()) do
				side:Clone().Parent = e
			end
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "Slate"
		elseif e.Material == Enum.Material.Wood then
			for _,side in pairs(wood:GetChildren()) do
				side:Clone().Parent = e
			end
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "Wood"
		elseif e.Material == Enum.Material.Plastic then
			local matVal = Instance.new("StringValue")
			matVal.Parent = e
			matVal.Value = "Plastic"
		end

		e.Material = Enum.Material.SmoothPlastic
	end
end
