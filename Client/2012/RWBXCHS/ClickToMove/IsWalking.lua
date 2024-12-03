script.Parent.Parent.Humanoid.Running:Connect(function(number)
	if number ~= 0 then
		script.Parent.IsWalkingV.Value = true
	else
		script.Parent.IsWalkingV.Value = false
	end
end)
