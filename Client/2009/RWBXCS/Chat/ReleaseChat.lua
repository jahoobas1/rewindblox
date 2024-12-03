-- RWBXCS/ReleaseChat.lua
-- By jahoobas on idk what day

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

-- TODO: Rewrite chat scripts

local event = game:GetService("ReplicatedStorage"):WaitForChild("CreateChat")

local chatbox = game.Players.LocalPlayer.PlayerGui:WaitForChild("RobloxGui"):WaitForChild("Chatbar"):WaitForChild("ChatBar")

local function focusLost(enterPressed)
	if enterPressed then
		event:FireServer(chatbox.Text)
		chatbox.Text = ""
	end
end


chatbox.FocusLost:Connect(focusLost)