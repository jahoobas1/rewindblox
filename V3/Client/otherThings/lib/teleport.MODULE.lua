--@jahoobas
--Unsure when

--[[

This script handles player teleports (quickly)

]]

local tele = {}

function tele:tp(player,id)
	local TeleportService = game:GetService("TeleportService")

	TeleportService:TeleportAsync(id, {player})
end

return tele
