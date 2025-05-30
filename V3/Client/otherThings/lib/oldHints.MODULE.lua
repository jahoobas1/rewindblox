--@jahoobas
--Not really sure when I programmed this, never made sure to actually document it

--[[

This script makes it easy to show the old Hint instance accurately to the time period.

]]

local hint = {}

function hint:convert_hint(obj : Object,ver : number)
	if obj:IsA("Hint") then
		--might break some scripts but i couldn't care less (i can fix it)
		obj.Parent = game:GetService("ReplicatedStorage") --so client can access it
		
		if ver == 1 then
			--comic sans
			--For all players
			local function handler(player)
				local still = true

				local robloxgui = player:WaitForChild("PlayerGui"):WaitForChild("RobloxGui")

				local hintGUI = Instance.new("TextLabel")
				hintGUI.Parent = robloxgui
				hintGUI.Position = UDim2.new(0,0,1,-39)
				hintGUI.Size = UDim2.new(1,0,0,19)
				hintGUI.Name = "hint"
				hintGUI.TextColor3 = Color3.new(1,1,1)
				hintGUI.Text = obj.Text
				hintGUI.Font = Enum.Font.Cartoon
				hintGUI.TextSize = 16
				hintGUI.BackgroundColor3 = Color3.new(0,0,0)
				hintGUI.BorderSizePixel = 0

				local connection = Instance.new("ObjectValue")
				connection.Value = obj
				connection.Parent = hintGUI
				connection.Name = "ConnectedHint"

				connection.Value.Changed:Connect(function()
					if still then
						hintGUI.Text = connection.Value.Text
					end
				end)

				connection.Value.Destroying:Connect(function()
					hintGUI:Destroy()
					still = false
				end)
			end
			
			for _,player in pairs(game:GetService("Players"):GetPlayers()) do
				task.spawn(function() handler(player) end)
			end
			
			game:GetService("Players").PlayerAdded:Connect(function(player)
				task.spawn(function() handler(player) end)
			end)
		elseif ver == 2 then
			--arial
			--For all players
			local function handler(player)
				local still = true

				local robloxgui = player:WaitForChild("PlayerGui"):WaitForChild("RobloxGui")

				local hintGUI = Instance.new("TextLabel")
				hintGUI.Parent = robloxgui
				hintGUI.Position = UDim2.new(0,0,1,-39)
				hintGUI.Size = UDim2.new(1,0,0,19)
				hintGUI.Name = "hint"
				hintGUI.TextColor3 = Color3.new(1,1,1)
				hintGUI.Text = obj.Text
				hintGUI.Font = Enum.Font.Arimo
				hintGUI.TextSize = 19
				hintGUI.BackgroundColor3 = Color3.new(0,0,0)
				hintGUI.BorderSizePixel = 0

				local connection = Instance.new("ObjectValue")
				connection.Value = obj
				connection.Parent = hintGUI
				connection.Name = "ConnectedHint"

				connection.Value.Changed:Connect(function()
					if still then
						hintGUI.Text = connection.Value.Text
					end
				end)

				connection.Value.Destroying:Connect(function()
					hintGUI:Destroy()
					still = false
				end)
			end

			for _,player in pairs(game:GetService("Players"):GetPlayers()) do
				task.spawn(function() handler(player) end)
			end

			game:GetService("Players").PlayerAdded:Connect(function(player)
				task.spawn(function() handler(player) end)
			end)
		else
			warn("invalid version")
		end
	else
		warn("invalid object")
	end
end

function hint:convert_msg(obj : Object,ver : number,plr : Player)
	if obj.ClassName == "Message" then
		if ver == 1 then
			local text = obj.Text
			obj.Text = ""
			--For all players
			local function handler(player)
				if obj.Parent == workspace or obj.Parent == player then
					local still = true
					
					local robloxgui = player:WaitForChild("PlayerGui"):WaitForChild("RobloxGui")
					
					local hintGUI = Instance.new("TextLabel")
					hintGUI.Parent = robloxgui
					if obj.Parent ~= player then
						hintGUI.Size = UDim2.new(1,0,1,0)
					else
						hintGUI.Size = UDim2.new(0.25,0,0.2504970178926441,0)
						hintGUI.Position = UDim2.new(0,30,0,31)
					end
					hintGUI.Name = "msg"
					hintGUI.TextColor3 = Color3.fromRGB(139,139,139)
					hintGUI.Text = text
					hintGUI.Font = Enum.Font.Cartoon
					hintGUI.TextSize = 19
					hintGUI.BorderSizePixel = 0
					hintGUI.BackgroundTransparency = 0.5
					hintGUI.TextColor3 = Color3.new(1,1,1)
					hintGUI.TextStrokeTransparency = 0
					hintGUI.ZIndex = 0

					local connection = Instance.new("ObjectValue")
					connection.Value = obj
					connection.Parent = hintGUI
					connection.Name = "ConnectedHint"

					connection.Value.Changed:Connect(function()
						if still then
							hintGUI.Text = connection.Value.Text
							text = obj.Text
							obj.Text = ""
						end
					end)

					connection.Value.Destroying:Connect(function()
						hintGUI:Destroy()
						still = false
					end)
				end
			end

			if not plr then
				for _,player in pairs(game:GetService("Players"):GetPlayers()) do
					task.spawn(function() handler(player) end)
				end

				game:GetService("Players").PlayerAdded:Connect(function(player)
					task.spawn(function() handler(player) end)
				end)
			else
				task.spawn(function() handler(plr) end)
			end
		elseif ver == 2 then
			local text = obj.Text
			obj.Text = ""
			--For all players
			local function handler(player)
				if obj.Parent == workspace or obj.Parent == player then
					local still = true

					local robloxgui = player:WaitForChild("PlayerGui"):WaitForChild("RobloxGui")

					local hintGUI = Instance.new("TextLabel")
					hintGUI.Parent = robloxgui
					if obj.Parent ~= player then
						hintGUI.Size = UDim2.new(1,0,1,0)
					else
						hintGUI.Size = UDim2.new(0.25,0,0.2504970178926441,0)
						hintGUI.Position = UDim2.new(0,30,0,31)
					end
					hintGUI.Name = "msg"
					hintGUI.TextColor3 = Color3.fromRGB(139,139,139)
					hintGUI.Text = text
					hintGUI.Font = Enum.Font.Arimo
					hintGUI.TextSize = 21
					hintGUI.BorderSizePixel = 0
					hintGUI.BackgroundTransparency = 0.5
					hintGUI.TextColor3 = Color3.new(1,1,1)
					hintGUI.TextStrokeTransparency = 0
					hintGUI.ZIndex = 0

					local connection = Instance.new("ObjectValue")
					connection.Value = obj
					connection.Parent = hintGUI
					connection.Name = "ConnectedHint"

					connection.Value.Changed:Connect(function()
						if still then
							hintGUI.Text = connection.Value.Text
							text = obj.Text
							obj.Text = ""
						end
					end)

					connection.Value.Destroying:Connect(function()
						hintGUI:Destroy()
						still = false
					end)
				end
			end

			if not plr then
				for _,player in pairs(game:GetService("Players"):GetPlayers()) do
					task.spawn(function() handler(player) end)
				end

				game:GetService("Players").PlayerAdded:Connect(function(player)
					task.spawn(function() handler(player) end)
				end)
			else
				task.spawn(function() handler(plr) end)
			end
		else
			warn("invalid version")
		end
	else
		warn("invalid object")
	end
end

return hint
