--RWBXCHS/PrepareAvatar.lua
--By jahoobas on 8/27/2024

--NO EDITING

local t = Instance.new("ShirtGraphic")

local dss = game:GetService("DataStoreService")
local wearingItems = dss:GetDataStore("WearingItems")
local ColorDS = dss:GetDataStore("ColorDS")
local settingsData = dss:GetDataStore("Settings")

function getNumOfType(class)
	local num = 0
	for i,e in pairs(script.Parent:GetChildren()) do
		if e:IsA(class) then
			num += 1
		end
	end
	return num
end

while true do
	wait(0.1)
	--Get avatar items
	local player = game.Players:GetPlayerFromCharacter(script.Parent)
	--== Obtain all items
	local wearingFolder = player:WaitForChild("Wearing")

	local wearData

	local success, errorMessage = pcall(function()
		wearData = wearingItems:GetAsync("wearing-"..player.UserId)
	end)

	if success then
		if wearData ~= nil then
			wearingFolder.AllWearingItems.Value = wearData
		end
	else
		if errorMessage then
			warn(errorMessage)
		end
	end

	--== Put them on avatar
	local split = string.split(wearingFolder.AllWearingItems.Value,":")
	for i,e in pairs(split) do
		if not script.Parent:FindFirstChild(e) and e ~= "" then
			local clonedItem = game:GetService("ServerStorage"):WaitForChild("AvatarItems"):WaitForChild(e):Clone()
			clonedItem.Parent = script.Parent
		end
	end

	--Get body colors selected by the player
	--==Get color values
	local headColorData,torsoColorData,larmColorData,rarmColorData,llegColorData,rlegColorData

	local success2, errorMessage2 = pcall(function()
		headColorData = ColorDS:GetAsync("Head-"..player.UserId)
		torsoColorData = ColorDS:GetAsync("Torso-"..player.UserId)
		larmColorData = ColorDS:GetAsync("Left Arm-"..player.UserId)
		rarmColorData = ColorDS:GetAsync("Right Arm-"..player.UserId)
		llegColorData = ColorDS:GetAsync("Left Leg-"..player.UserId)
		rlegColorData = ColorDS:GetAsync("Right Leg-"..player.UserId)
	end)
	local hs,ts,las,ras,lls,rls
	if success2 then
		if headColorData ~= nil and torsoColorData ~= nil and larmColorData ~= nil and rarmColorData ~= nil and llegColorData ~= nil and rlegColorData ~= nil then
			player.AvatarColors.Head.Value = headColorData
			player.AvatarColors.Torso.Value = torsoColorData
			player.AvatarColors["Left Arm"].Value = larmColorData
			player.AvatarColors["Right Arm"].Value = rarmColorData
			player.AvatarColors["Left Leg"].Value = llegColorData
			player.AvatarColors["Right Leg"].Value = rlegColorData

			hs = string.split(headColorData,", ")
			ts = string.split(torsoColorData,", ")
			las = string.split(larmColorData,", ")
			ras = string.split(rarmColorData,", ")
			lls = string.split(llegColorData,", ")
			rls = string.split(rlegColorData,", ")
		end
	else
		if errorMessage2 then
			warn(errorMessage2)
		end
	end

	--Put them on the avatar
	if headColorData ~= nil and torsoColorData ~= nil and larmColorData ~= nil and rarmColorData ~= nil and llegColorData ~= nil and rlegColorData ~= nil then
		script.Parent["Body Colors"].HeadColor3 = Color3.new(hs[1],hs[2],hs[3])
		script.Parent["Body Colors"].TorsoColor3 = Color3.new(ts[1],ts[2],ts[3])
		script.Parent["Body Colors"].LeftArmColor3 = Color3.new(las[1],las[2],las[3])
		script.Parent["Body Colors"].RightArmColor3 = Color3.new(ras[1],ras[2],ras[3])
		script.Parent["Body Colors"].LeftLegColor3 = Color3.new(lls[1],lls[2],lls[3])
		script.Parent["Body Colors"].RightLegColor3 = Color3.new(rls[1],rls[2],rls[3])
	end

	--Make face old
	script.Parent.Head.face.Texture = "rbxassetid://15654927653"

	--Give TShirt
	t.Name = "RobloxTee"
	t.Parent = script.Parent
	t.Graphic = "rbxassetid://17466418848"

	--Give player studs
	if not script.Parent:FindFirstChild("Studs") then
		local shirt = game.ReplicatedStorage.Assets.StudsShirt:Clone()
		shirt.Parent = script.Parent
	end
	if not script.Parent:FindFirstChild("StudsPants") then
		game.ReplicatedStorage.Assets.StudsPants:Clone().Parent = script.Parent
	end

	--If wearing clothing, remove the stud
	if getNumOfType("Shirt") > 1 then
		script.Parent.StudsShirt:Destroy()
		script.Parent.StudsPants:Destroy()
	end
	if getNumOfType("Pants") > 1 then
		script.Parent.StudsPants:Destroy()
	end
end

