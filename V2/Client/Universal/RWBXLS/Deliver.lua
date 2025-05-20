--RWBXLS/Deliver.lua
--By jahoobas on 8/24/2024

--DO NOT EDIT

game.ReplicatedStorage:WaitForChild("Delivery").OnClientEvent:Connect(function(e,plr)
	if e:FindFirstChild("Signed") then
		if not plr.PlayerScripts:FindFirstChild(e.Name) then
			e:Clone().Parent = plr.PlayerScripts 
		end
	end
end)
