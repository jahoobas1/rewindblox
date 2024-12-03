-- RWBXMS/OldSpawnLocationDecal.lua
-- By robloxsammy747 on 10/11/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

for i,v in pairs (workspace:GetDescendants()) do
	if v:IsA("Decal") then
		texture = string.lower(v.Texture)
		local match2 = string.match(texture, "spawnlocation%.png")
		if match2 then  
			v.Texture = "rbxassetid://103640649117815"
		end
	end
end