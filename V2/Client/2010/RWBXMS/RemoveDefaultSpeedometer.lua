--RWBXMS/RemoveDefaultSpeedometer.lua
--By jahoobas on 8/20/24

--DO NOT EDIT!

for i,e in pairs(game:GetDescendants()) do
	if e:IsA("VehicleSeat") then
		e.HeadsUpDisplay = false
	end
end

game.DescendantAdded:Connect(function(d)
	if d:IsA("VehicleSeat") then
		d.HeadsUpDisplay = false
	end
end)
