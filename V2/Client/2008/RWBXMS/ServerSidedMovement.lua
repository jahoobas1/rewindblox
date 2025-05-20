-- RWBXMS/ServerSidedMovement.lua
-- By jahoobas on 8/18/24

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function setNetworkOwner(part)
	if part:IsA("BasePart") then
		part:SetNetworkOwner() -- Set the network owner to the server
	end
end

local function onCharacterAdded(character)
	RunService.Heartbeat:Wait() -- Allow the character to load into the workspace

	for _, descendant in character:GetDescendants() do -- Existing descendants
		setNetworkOwner(descendant)
	end

	character.DescendantAdded:Connect(function(descendant)
		setNetworkOwner(descendant)
	end)
end

local function onPlayerAdded(player)
	if player.Character then -- Existing player character
		onCharacterAdded(player.Character)
	end

	player.CharacterAdded:Connect(onCharacterAdded)
end

for _, player in Players:GetPlayers() do -- Existing players
	onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)