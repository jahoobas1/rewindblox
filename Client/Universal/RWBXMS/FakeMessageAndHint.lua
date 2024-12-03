--RWBXMS/FakeMessageAndHint.lua
--By jahoobas on 8/25/2024

--DO NOT EDIT UNLESS FIXING ISSUES

local players = game:GetService("Players")

task.spawn(function()
	local text = Instance.new("StringValue")
	for i,e in pairs(players:GetPlayers()) do
		e.ChildAdded:Connect(function(c)
			if c.ClassName == "Message" then
				local msg

				if tonumber(script.SelectedClient.Value) < 2010 then
					msg = e.PlayerGui.FakeMessage.WeirdPlayerHolder2009BELOW:Clone()
				end
				msg.Parent = e.PlayerGui.FakeMessage
				msg.Visible = true
				msg.Linked.Value = c
				
				msg.Text.Text = c.Text
				text.Parent = c
				text.Name = "TXT"
				text.Value = c.Text
				c.Text = ""
			elseif c.ClassName == "Hint" then
				local msg

				if tonumber(script.SelectedClient.Value) < 2010 then
					msg = e.PlayerGui.FakeHint["2009<"]:Clone()
				elseif tonumber(script.SelectedClient.Value) == 2010 then
					msg = e.PlayerGui.FakeHint["2010"]:Clone()
				elseif tonumber(script.SelectedClient.Value) >= 2011 then
					msg = e.PlayerGui.FakeHint["2011+"]:Clone()
				end
				msg.Parent = e.PlayerGui.FakeHint
				msg.Visible = true
				msg.Linked.Value = c

				msg.Text.Text = c.Text

				text.Changed:Connect(function()
					msg.Text.Text = text.Value
				end)

				c.Destroying:Connect(function()
					msg:Destroy()
				end)
				text.Parent = c
				text.Name = "TXT"
				text.Value = c.Text
				c.Text = ""
				c.Parent = game.ServerStorage
			end
		end)

		e.ChildRemoved:Connect(function(c)
			if c.ClassName == "Message" then
				for i,v in pairs(e.PlayerGui.FakeMessage:GetChildren()) do
					if v.Linked.Value == c then
						v:Destroy()
					end
				end
			end
		end)
	end
	
	game.Players.PlayerAdded:Connect(function(e)
		e.ChildAdded:Connect(function(c)
			if c.ClassName == "Message" then
				local msg

				if tonumber(script.SelectedClient.Value) < 2010 then
					msg = e.PlayerGui.FakeMessage.WeirdPlayerHolder2009BELOW:Clone()
				end
				msg.Parent = e.PlayerGui.FakeMessage
				msg.Visible = true
				msg.Linked.Value = c

				msg.Text.Text = c.Text

				text.Changed:Connect(function()
					msg.Text.Text = text.Value
				end)
				text.Parent = c
				text.Name = "TXT"
				text.Value = c.Text
				c.Text = ""
			elseif c.ClassName == "Hint" then
				local msg

				if tonumber(script.SelectedClient.Value) < 2010 then
					msg = e.PlayerGui.FakeHint["2009<"]:Clone()
				elseif tonumber(script.SelectedClient.Value) == 2010 then
					msg = e.PlayerGui.FakeHint["2010"]:Clone()
				elseif tonumber(script.SelectedClient.Value) >= 2011 then
					msg = e.PlayerGui.FakeHint["2011+"]:Clone()
				end
				msg.Parent = e.PlayerGui.FakeHint
				msg.Visible = true
				msg.Linked.Value = c

				msg.Text.Text = c.Text

				text.Changed:Connect(function()
					msg.Text.Text = text.Value
				end)

				c.Destroying:Connect(function()
					msg:Destroy()
				end)
				text.Parent = c
				text.Name = "TXT"
				text.Value = c.Text
				c.Text = ""
				c.Parent = game.ServerStorage
			end
		end)
		
		e.ChildRemoved:Connect(function(c)
			if c.ClassName == "Message" then
				for i,e in pairs(e.PlayerGui.FakeMessage:GetChildren()) do
					if e.Linked.Value == c then
						e:Destroy()
					end
				end
			end
		end)
	end)
end)


workspace.ChildAdded:Connect(function(c)
	if c.ClassName == "Message" then
		local text = Instance.new("StringValue")
		for i,p in pairs(game.Players:GetPlayers()) do
			local msg
			
			if tonumber(script.SelectedClient.Value) >= 2010 then
				msg = p.PlayerGui.FakeMessage.Holder2010Andabove:Clone()
			else
				msg = p.PlayerGui.FakeMessage.Holder2009AndBelow:Clone()
			end
			
			msg.Parent = p.PlayerGui.FakeMessage
			msg.Visible = true
			msg.Linked.Value = c

			msg.Text.Text = c.Text

			text.Changed:Connect(function()
				msg.Text.Text = text.Value
			end)
		end
		text.Parent = c
		text.Name = "TXT"
		text.Value = c.Text
		c.Text = ""
	elseif c.ClassName == "Hint" then
		local text = Instance.new("StringValue")
		for i,p in pairs(game.Players:GetPlayers()) do
			local msg

			if tonumber(script.SelectedClient.Value) < 2010 then
				msg = p.PlayerGui.FakeHint["2009<"]:Clone()
			elseif tonumber(script.SelectedClient.Value) == 2010 then
				msg = p.PlayerGui.FakeHint["2010"]:Clone()
			elseif tonumber(script.SelectedClient.Value) >= 2011 then
				msg = p.PlayerGui.FakeHint["2011+"]:Clone()
			end
			msg.Parent = p.PlayerGui.FakeHint
			msg.Visible = true
			msg.Linked.Value = c

			msg.Text.Text = c.Text

			text.Changed:Connect(function()
				print("changed")
				msg.Text.Text = text.Value
			end)

			c.Destroying:Connect(function()
				msg:Destroy()
			end)
		end
		text.Parent = c
		text.Name = "TXT"
		text.Value = c.Text
		c.Text = ""
		c.Parent = game.ServerStorage
	end
end)

workspace.ChildRemoved:Connect(function(c)
	for i,p in pairs(game.Players:GetPlayers()) do
		if c.ClassName == "Message" then
			for i,e in pairs(p.PlayerGui.FakeMessage:GetChildren()) do
				if e.Linked.Value == c then
					e:Destroy()
				end
			end
		end
	end
end)
