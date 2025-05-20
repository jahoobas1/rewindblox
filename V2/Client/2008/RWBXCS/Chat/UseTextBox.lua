-- RWBXCS/UseTextBox.lua
-- By jahoobas on idk what day

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

-- TODO: Rewrite chat scripts

local ContextActionService = game:GetService("ContextActionService")

if game.Players.LocalPlayer.PlayerGui:FindFirstChild("TouchGui") then
	local sel = game.Players.LocalPlayer.PlayerGui.TouchGui.TouchControlFrame:WaitForChild("Select")
	ContextActionService:SetPosition("Select", sel.Position-UDim2.new(800,0,0,0))
end

local chatbox = game.Players.LocalPlayer.PlayerGui:WaitForChild("RobloxGui"):WaitForChild("Chatbar"):WaitForChild("ChatBar")

local UIS = game:GetService("UserInputService")

local function handleAction(actionName, inputState, inputObject)
	if actionName == "Select" then
		if inputState == Enum.UserInputState.Begin then
			wait(.01)
			chatbox:CaptureFocus()
			chatbox.Placeholder.Visible = false
		end
	end
end

chatbox.FocusLost:Connect(function(enter)
	if enter then
		chatbox.Placeholder.Visible = true
	end
end)

chatbox.Focused:Connect(function(enter)
	chatbox.Placeholder.Visible = false
end)

ContextActionService:BindAction("Select", handleAction, true, Enum.KeyCode.Slash)
