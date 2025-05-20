local humanoid = script.Parent.Humanoid

if (humanoid == nil) then
	print("ERROR: no humanoid found in 'HealthScript v2.0'")
end

function UpdateGUI(health)
	local pgui = game.Players:GetPlayerFromCharacter(humanoid.Parent).PlayerGui
	local tray = pgui.RobloxGui.HealthTray

	tray.HealthBar.Size = UDim2.new(0.2, 0, 0.8 * (health / humanoid.MaxHealth), 0) 
	tray.HealthBar.Position = UDim2.new(0.4, 0, 0.8 * (1-  (health / humanoid.MaxHealth)) , 0) 

end

function HealthChanged(health)
	UpdateGUI(health)
end
HealthChanged(100)
humanoid.HealthChanged:connect(HealthChanged)
humanoid.Died:connect(function() HealthChanged(0) end)