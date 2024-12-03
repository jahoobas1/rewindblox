local fontify = game:GetService("ReplicatedStorage"):WaitForChild("Fontify")
local mod = require(fontify:WaitForChild("FontifyModule"))

for i,e in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
	if e:IsA("TextLabel") then
		if e.Font == Enum.Font.Cartoon then
			if e:FindFirstChild("Fontify_Gui") then
				e.Fontify_Gui:Destroy()
			end
			e.TextTransparency = 1
			mod:CreateText(e.Text, e.TextSize, e.TextColor3, e.TextStrokeColor3, "ComicSansMS", e.TextXAlignment.Name..":"..e.TextYAlignment.Name,e.TextStrokeTransparency, e)
		end
	end
end

game:GetService("Players").LocalPlayer.PlayerGui.DescendantAdded:Connect(function(e)
	wait(0.05)
	if e:IsA("TextLabel") or e:IsA("TextButton") then
		if e.Font == Enum.Font.Cartoon then
			e.TextTransparency = 1
			mod:CreateText(e.Text, e.TextSize, e.TextColor3, e.TextStrokeColor3, "ComicSansMS", e.TextXAlignment.Name..":"..e.TextYAlignment.Name,e.TextStrokeTransparency, e)	
			
			e.Changed:Connect(function(prop)
				if e:FindFirstChild("Fontify_Gui") then
					e.Fontify_Gui:Destroy()
				end
				if e:IsA("TextLabel") or e:IsA("TextButton") then
					if prop == "Text" then
						if e.Font == Enum.Font.Cartoon then
							e.TextTransparency = 1
							mod:CreateText(e.Text, e.TextSize, e.TextColor3, e.TextStrokeColor3, "ComicSansMS", e.TextXAlignment.Name..":"..e.TextYAlignment.Name,e.TextStrokeTransparency, e)
						end
					end
				end
			end)
		end
	end
end)