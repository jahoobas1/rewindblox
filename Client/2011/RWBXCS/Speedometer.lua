--RWBXCS/Speedometer.lua
--By jahoobas on 8/20/24

--DO NOT EDIT!

local plr = game.Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")
local robloxGui = plrGui:WaitForChild("RobloxGui")
local speedometer = robloxGui:WaitForChild("Speedometer")

local chr = plr.Character or plr.CharacterAdded:Wait()

local humanoid = chr.Humanoid

humanoid.Changed:Connect(function()
	local sp = humanoid.SeatPart
	if sp then
		if sp.ClassName == "VehicleSeat" then
			repeat
				local speed = math.round(chr.PrimaryPart.Velocity.Magnitude)
				speedometer.SpeedFrame.Visible = true
				speedometer.SpeedFrame.Size = UDim2.new(0,speed*10,0,20)
				speedometer.SpeedFrame.SpeedText.Text = "Speed: "..speed
				
				task.wait()
			until humanoid.SeatPart == nil
			speedometer.SpeedFrame.Visible = false
			speedometer.SpeedFrame.Size = UDim2.new(0,0,0,20)
		end
	end
end)
