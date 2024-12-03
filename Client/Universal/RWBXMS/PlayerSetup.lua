--RWBXMS/PlayerSetup
--By jahoobas on 8/27/2024

--NO EDITING!!

local BadgeService = game:GetService("BadgeService")
local BID = 2542710991316750

function runner(plr)
	if not plr:FindFirstChild("Wearing") then
		local wearing = Instance.new("Folder")
		wearing.Name = "Wearing"
		wearing.Parent = plr

		local itemList = Instance.new("StringValue")
		itemList.Parent = wearing
		itemList.Name = "AllWearingItems"

		local colorValues = Instance.new("Folder")
		colorValues.Parent = plr
		colorValues.Name = "AvatarColors"

		local head = Instance.new("StringValue")
		head.Parent = colorValues
		head.Name = "Head"

		local torso = Instance.new("StringValue")
		torso.Parent = colorValues
		torso.Name = "Torso"

		local leftArm = Instance.new("StringValue")
		leftArm.Parent = colorValues
		leftArm.Name = "Left Arm"

		local rightArm = Instance.new("StringValue")
		rightArm.Parent = colorValues
		rightArm.Name = "Right Arm"

		local leftLeg = Instance.new("StringValue")
		leftLeg.Parent = colorValues
		leftLeg.Name = "Left Leg"

		local rightLeg = Instance.new("StringValue")
		rightLeg.Parent = colorValues
		rightLeg.Name = "Right Leg"

		--[[if not plr.PlayerGui:FindFirstChild("LoadingGui") then
			print("LoadingGui not found. Making new one..")
			game.ReplicatedFirst.LoadingGui:Clone().Parent = plr.PlayerGui
		end]]

		for i,e in pairs(game.Players:GetPlayers()) do
			local IsFriend = plr:IsFriendsWith(e.UserId)
			if IsFriend then
				if (plr and not BadgeService:UserHasBadgeAsync(e.UserId, BID)) then
					BadgeService:AwardBadge(plr.UserId, BID)
				end
				if (e and not BadgeService:UserHasBadgeAsync(e.UserId, BID)) then
					BadgeService:AwardBadge(e.UserId, BID)
				end
			end
		end
	end
end

game.Players.PlayerAdded:Connect(runner)

for i,e in pairs(game.Players:GetPlayers()) do
	if e:IsA("Player") then
		runner(e)
	end
end
