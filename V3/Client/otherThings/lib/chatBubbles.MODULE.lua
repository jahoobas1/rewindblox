--@jahoobas
--Unsure when

--[[

This script creates time period accurate chat bubbles.

]]


local cb = {}

local replicatedStorage = game:GetService("ReplicatedStorage")

local rwbxasset_ = replicatedStorage:WaitForChild("RewindBloxV3"):WaitForChild("rwbxasset")
local chatbbl = rwbxasset_:WaitForChild("ChatBubble")
local rchatbbl = rwbxasset_:WaitForChild("RedChatBubble")
local gchatbbl = rwbxasset_:WaitForChild("GreenChatBubble")
local bchatbbl = rwbxasset_:WaitForChild("BlueChatBubble")

function cb:displayBubble(tier,type,text,object : Object)
	local newBubble
	if type == "normal" then
		newBubble = chatbbl:Clone()
	elseif type == "r" then
		newBubble = rchatbbl:Clone()
	elseif type == "g" then
		newBubble = gchatbbl:Clone()
	elseif type == "b" then
		newBubble = bchatbbl:Clone()
	end
	
	for _,b in pairs(object:GetChildren()) do
		if b:IsA("BillboardGui") then
			if b.Name == newBubble.Name then
				b.Tier.Value += 1

				if b.Tier.Value > 3 then
					b:Destroy()
					continue
				end
				
				b.Body.TextLabel.TextTransparency = 0.5
				
				b.Tail.Visible = false
				
				b.Body.Position -= UDim2.new(0,0,0,45)
			end
		end
	end
	
	newBubble.Parent = object
	
	newBubble.Tier.Value = tier
	
	newBubble.Body.TextLabel.Text = text
	
	newBubble.Fade.Enabled = true
end

return cb
