print("PREPARING LIGHTING....")

local lighting = game:GetService("Lighting")

lighting.Brightness = 2
lighting.Ambient = Color3.fromRGB(128,128,128)
lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)

lighting.GlobalShadows = false

print("LIGHTING PREPARED")
