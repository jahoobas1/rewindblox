--@jahoobas
--3/25/25

--[[

This script handles CoreScript loading.

]]

local csloader = {}

--wait(.1) --delay to wait for everything to load in

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local SecureKey = "jfOMxSfdaOtfqHkKV2p4jnTjWpPiz6p8" -- prevent players from loading corescripts that they shouldn't by forcing them to provide a key

local asset_ = replicatedStorage:WaitForChild("RewindBloxV3"):WaitForChild("asset")

function csloader:load(corescript, key)
	if key ~= SecureKey then warn("failed: key error") return end
	if players.LocalPlayer == nil then warn("cannot load corescripts from server") return end
	
	local CoreScriptLoaded = asset_:WaitForChild(corescript):Clone()
	
	return CoreScriptLoaded
end

return csloader
