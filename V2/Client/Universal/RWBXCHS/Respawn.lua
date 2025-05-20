--RWBXCHS/Respawn.lua
--By jahoobas on 8/25/2024

--DO NOT EDIT

script.Parent.Humanoid.Died:Connect(function()
	wait(game.Players.RespawnTime)
	game.Players:GetPlayerFromCharacter(script.Parent):LoadCharacter()
end)