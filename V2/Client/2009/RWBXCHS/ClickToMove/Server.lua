local nctm = 0

function withinReason(num1,num2,Error)
	if num1+Error >= num2 and num1-Error <= num2 then
		return true
	else
		return false
	end
end

script.Parent.CTM.OnServerEvent:Connect(function(plr,mouse)
	script.Parent.UsingCTMWalk.Value = true
	nctm += 1
	script.Parent.Parent.Humanoid:MoveTo(mouse)
	repeat wait() if nctm ~= 1 then return end until withinReason(script.Parent.Parent.HumanoidRootPart.Position.X,mouse.X,2.5) and withinReason(script.Parent.Parent.HumanoidRootPart.Position.Z,mouse.Z,2.5)
	print("Made it!")
	
	script.Parent.Arrived:FireClient(game.Players:GetPlayerFromCharacter(script.Parent.Parent))
	nctm -= 1
end)

script.Parent.Cut.OnServerEvent:Connect(function(plr)
	script.Parent.UsingCTMWalk.Value = false
	nctm = 1000
end)
