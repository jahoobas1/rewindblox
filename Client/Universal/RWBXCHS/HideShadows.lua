--RWBXCHS/HideShadows.lua
--By jahoobas on 8/29/2024

--NO CHANGE

wait(.1)

for i,e in pairs(script.Parent:GetDescendants()) do
	if e:IsA("BasePart") then
		e.CastShadow = false
	end
end
