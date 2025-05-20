-- RWBXMS/KeepTrackOfPlaceInfo.lua
-- By jahoobas on 8/17/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local dataStoreService = game:GetService("DataStoreService")

local LetOtherServersKnowODS = dataStoreService:GetOrderedDataStore("RefreshStore") -- ODS which will tell other servers when to check their count and other stats.
local playerCountODS = dataStoreService:GetOrderedDataStore("RewindBloxPreMadeGamePlayerCount") -- Ordered Data Store which will hold player count for premade games.

function UpdatePlayerCount()
	local function addtocount()
		--Add to the existing Count.
		--==First we need to get the current playercount.
		local data
		local success, response = pcall(function()
			data = playerCountODS:GetAsync(tostring(game.PlaceId).."-PlayerCount")
		end)
		--Then add it.
		if success then
			playerCountODS:SetAsync(tostring(game.PlaceId).."-PlayerCount",data + #game.Players:GetPlayers())
		else
			--Retry if it has failed.
			warn("Setting player count store has failed! Try again")
			addtocount()
		end
		print(data)
	end
	addtocount()
	LetOtherServersKnowODS:SetAsync(tostring(game.PlaceId).."-RS",1)
end

function UpdatePlayerCountWithoutAlertingServers()
	local function addtocount()
		--Add to the existing Count.
		--==First we need to get the current playercount.
		local data
		local success, response = pcall(function()
			data = playerCountODS:GetAsync(tostring(game.PlaceId).."-PlayerCount")
		end)
		--Then add it.
		if success then
			playerCountODS:SetAsync(tostring(game.PlaceId).."-PlayerCount",data + #game.Players:GetPlayers())
		else
			--Retry if it has failed.
			warn("Setting player count store has failed! Try again")
			addtocount()
		end
		print(data)
	end
	addtocount()
end

game.Players.PlayerAdded:Connect(function()
	--Set count to zero.
	playerCountODS:SetAsync(tostring(game.PlaceId).."-PlayerCount",0)
	UpdatePlayerCount()
end)
game.Players.PlayerRemoving:Connect(function()
	--Set count to zero.
	playerCountODS:SetAsync(tostring(game.PlaceId).."-PlayerCount",0)
	UpdatePlayerCount()
end)

while task.wait(10) do
	local data
	local success, response = pcall(function()
		data = LetOtherServersKnowODS:GetAsync(tostring(game.PlaceId).."-RS")
	end)
	if success then
		if data == 1 then
			--REFRESH!!!!
			LetOtherServersKnowODS:SetAsync(tostring(game.PlaceId).."-RS",0)
			UpdatePlayerCountWithoutAlertingServers()
		end
	end
end
