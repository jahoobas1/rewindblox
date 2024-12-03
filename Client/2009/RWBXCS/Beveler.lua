-- RWBXCS/Beveler.lua
-- By jahoobas on 9/4/2024

-- DO NOT CHANGE THIS UNLESS FIXING A BUG!

local replicatedStorage = game:GetService("ReplicatedStorage")
local assets = replicatedStorage:WaitForChild("Assets")

local beveled = assets:WaitForChild("Beveled")

function getSurfaceType(p : BasePart,face : BasePart,Type,Face)
	if Face == "Top" then
		if p.TopSurface == Type then
			for i,e in pairs(p:GetChildren()) do
				if e:IsA("Texture") then
					local str = string.split(tostring(Type),".")[3]
					if e.Name == str then
						if e.Face == Enum.NormalId.Top then
							e:Clone().Parent = face
						end
					end
				end
			end
		end
	elseif Face == "Bottom" then
		if p.BottomSurface == Type then
			for i,e in pairs(p:GetChildren()) do
				if e:IsA("Texture") then
					local str = string.split(tostring(Type),".")[3]
					if e.Name == str then
						if e.Face == Enum.NormalId.Bottom then
							e:Clone().Parent = face
						end
					end
				end
			end
		end
	elseif Face == "Front" then
		if p.FrontSurface == Type then
			for i,e in pairs(p:GetChildren()) do
				if e:IsA("Texture") then
					local str = string.split(tostring(Type),".")[3]
					if e.Name == str then
						if e.Face == Enum.NormalId.Right then
							e:Clone().Parent = face
						end
					end
				end
			end
		end
	elseif Face == "Back" then
		if p.BackSurface == Type then
			for i,e in pairs(p:GetChildren()) do
				if e:IsA("Texture") then
					local str = string.split(tostring(Type),".")[3]
					if e.Name == str then
						if e.Face == Enum.NormalId.Left then
							e:Clone().Parent = face
						end
					end
				end
			end
		end
	end
end

function bevelPart(part : BasePart)
	--make sure part is not a product of beveling process
	if not part:FindFirstChild("BEVELPRODUCT") then
		--check if part is allowed to be beveled
		if not part:FindFirstChild("BEVELIGNORE") then
			--Set up part
			local ogRot = CFrame.Angles(math.rad(part.Rotation.X),math.rad(part.Rotation.Y),math.rad(part.Rotation.Z))
			
			if part.Name == "Base" then
				print(part)
			end

			local mainFolder = Instance.new("Folder")
			mainFolder.Parent = part
			mainFolder.Name = "RWBX/Bevel"

			local welds = Instance.new("Folder")
			welds.Parent = mainFolder
			welds.Name = "RWBX/Bevel/Welds"

			local faces = Instance.new("Folder")
			faces.Parent = mainFolder
			faces.Name = "RWBX/Bevel/Faces"

			local edges = Instance.new("Folder")
			edges.Parent = mainFolder
			edges.Name = "RWBX/Bevel/Edges"

			local corners = Instance.new("Folder")
			corners.Parent = mainFolder
			corners.Name = "RWBX/Bevel/Corners"
			
			part.Rotation = Vector3.new(0,0,0)
			
			--Resize Part to fit bevels.
			part.Size = Vector3.new(part.Size.X-0.1, part.Size.Y - 0.1, part.Size.Z - 0.1)
			
			--Add the faces
			for i,e in pairs(beveled.Faces:GetChildren()) do
				local face = e:Clone()
				if e.Name == "Top" then
					face.Position = part.Position + Vector3.new(0,(part.Size.Y/2)+(0.05/2),0)
					face.Size = Vector3.new(part.Size.X,0.05,part.Size.Z-0.1)
					face.Rotation = part.Rotation
					
					face.TopSurface = part.TopSurface
					face.FrontSurface = part.TopSurface
					face.LeftSurface = part.TopSurface
					face.RightSurface = part.TopSurface
					face.BackSurface = part.TopSurface
					face.BottomSurface = part.TopSurface
				elseif e.Name == "Bottom" then
					face.Position = part.Position + Vector3.new(0,-((part.Size.Y/2)+(0.05/2)),0)
					face.Size = Vector3.new(part.Size.X,0.05,part.Size.Z-0.1)
					face.Rotation = part.Rotation

					face.TopSurface = part.BottomSurface
					face.FrontSurface = part.BottomSurface
					face.LeftSurface = part.BottomSurface
					face.RightSurface = part.BottomSurface
					face.BackSurface = part.BottomSurface
					face.BottomSurface = part.BottomSurface
				elseif e.Name == "Front" then
					face.Position = part.Position + Vector3.new((part.Size.X/2)+(0.05/2),0,0)
					face.Size = Vector3.new(0.05,part.Size.Y,part.Size.Z-0.1)
					face.Rotation = part.Rotation

					face.TopSurface = part.FrontSurface
					face.BackSurface = part.FrontSurface
					face.LeftSurface = part.FrontSurface
					face.RightSurface = part.FrontSurface
					face.BottomSurface = part.FrontSurface
					face.FrontSurface = part.FrontSurface
				elseif e.Name == "Back" then
					face.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.05/2)),0,0)
					face.Size = Vector3.new(0.05,part.Size.Y,part.Size.Z-0.1)
					face.Rotation = part.Rotation

					face.TopSurface = part.BackSurface
					face.FrontSurface = part.BackSurface
					face.LeftSurface = part.BackSurface
					face.RightSurface = part.BackSurface
					face.BottomSurface = part.BackSurface
					face.BackSurface = part.BackSurface
				end

				task.spawn(function()getSurfaceType(part,face,Enum.SurfaceType.Studs,e.Name)end)
				task.spawn(function()getSurfaceType(part,face,Enum.SurfaceType.Universal,e.Name)end)
				task.spawn(function()getSurfaceType(part,face,Enum.SurfaceType.Inlet,e.Name)end)
				task.spawn(function()getSurfaceType(part,face,Enum.SurfaceType.Weld,e.Name)end)
				task.spawn(function()getSurfaceType(part,face,Enum.SurfaceType.Glue,e.Name)end)
				
				face.Parent = faces
				face.Color = part.Color
				face.Transparency = part.Transparency

				local weld = Instance.new("WeldConstraint")
				weld.Parent = welds
				weld.Part0 = part
				weld.Part1 = face
				weld.Name = "RWBX/Weld_"..e.Name.."_"..part.Name

				--prevent the game from trying to bevel this
				local product = Instance.new("BoolValue")
				product.Parent = face
				product.Name = "BEVELPRODUCT"

				part.Changed:Connect(function()
					face.Color = part.Color

					face.Transparency = part.Transparency
				end)
			end
			
			--Add the edges
			for i,e in pairs(beveled.Edges:GetChildren()) do
				local edge = e:Clone()
				if e.Name == "EdgeTR" then
					edge.Position = part.Position + Vector3.new(0,((part.Size.Y/2)+(0.025)),-((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.X,0.05,0.05)
					edge.Rotation = part.Rotation
				elseif e.Name == "EdgeTL" then
					edge.Position = part.Position + Vector3.new(0,((part.Size.Y/2)+(0.025)),((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.X,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,180,0)
				elseif e.Name == "EdgeBR" then
					edge.Position = part.Position + Vector3.new(0,-((part.Size.Y/2)+(0.025)),-((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.X,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(270,0,0)
				elseif e.Name == "EdgeBL" then
					edge.Position = part.Position + Vector3.new(0,-((part.Size.Y/2)+(0.025)),((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.X,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(90,180,0)
				elseif e.Name == "EdgeTF" then
					edge.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),((part.Size.Y/2)+(0.025)),0)
					edge.Size = Vector3.new(part.Size.Z - 0.1,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,270,0)
				elseif e.Name == "EdgeTB" then
					edge.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),((part.Size.Y/2)+(0.025)),0)
					edge.Size = Vector3.new(part.Size.Z - 0.1,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,90,0)
				elseif e.Name == "EdgeBF" then
					edge.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),-((part.Size.Y/2)+(0.025)),0)
					edge.Size = Vector3.new(part.Size.Z - 0.1,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,270,180)
				elseif e.Name == "EdgeBB" then
					edge.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),-((part.Size.Y/2)+(0.025)),0)
					edge.Size = Vector3.new(part.Size.Z - 0.1,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,90,180)
				elseif e.Name == "EdgeLB" then
					edge.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),0,-((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.Y,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,0,90)
				elseif e.Name == "EdgeLF" then
					edge.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),0,-((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.y,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,0,-90)
				elseif e.Name == "EdgeRB" then
					edge.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),0,((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.y,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,180,-90)
				elseif e.Name == "EdgeRF" then
					edge.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),0,((part.Size.Z/2)+(-0.025)))
					edge.Size = Vector3.new(part.Size.y,0.05,0.05)
					edge.Rotation = part.Rotation + Vector3.new(0,-90,-90)
				end
				
				edge.Parent = edges
				edge.Color = part.Color
				edge.Transparency = part.Transparency

				local weld = Instance.new("WeldConstraint")
				weld.Parent = welds
				weld.Part0 = part
				weld.Part1 = edge
				weld.Name = "RWBX/Weld_"..e.Name.."_"..part.Name

				--prevent the game from trying to bevel this
				local product = Instance.new("BoolValue")
				product.Parent = edge
				product.Name = "BEVELPRODUCT"

				part.Changed:Connect(function()
					edge.Color = part.Color

					edge.Transparency = part.Transparency
				end)
			end

			--Add the corners
			for i,e in pairs(beveled.Corners:GetChildren()) do
				local corner = e:Clone()
				if e.Name == "Corner1" then
					corner.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),((part.Size.Y/2)+(0.025)),((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation + Vector3.new(0,180,0)
				elseif e.Name == "Corner2" then
					corner.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),((part.Size.Y/2)+(0.025)),-((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation + Vector3.new(0,-90,0)
				elseif e.Name == "Corner3" then
					corner.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),-((part.Size.Y/2)+(0.025)),-((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation + Vector3.new(0,0,180)
				elseif e.Name == "Corner4" then
					corner.Position = part.Position + Vector3.new(((part.Size.X/2)+(0.025)),-((part.Size.Y/2)+(0.025)),((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation + Vector3.new(0,180,90)
				elseif e.Name == "Corner5" then
					corner.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),((part.Size.Y/2)+(0.025)),-((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation
				elseif e.Name == "Corner6" then
					corner.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),((part.Size.Y/2)+(0.025)),((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation + Vector3.new(0,90,0)
				elseif e.Name == "Corner7" then
					corner.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),-((part.Size.Y/2)+(0.025)),-((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation + Vector3.new(0,0,90)
				elseif e.Name == "Corner8" then
					corner.Position = part.Position + Vector3.new(-((part.Size.X/2)+(0.025)),-((part.Size.Y/2)+(0.025)),((part.Size.Z/2)+(-0.025)))
					corner.Size = Vector3.new(0.05,0.05,0.05)
					corner.Rotation = part.Rotation + Vector3.new(0,180,180)
				end

				corner.Parent = corners
				corner.Color = part.Color
				corner.Transparency = part.Transparency
				
				local weld = Instance.new("WeldConstraint")
				weld.Parent = welds
				weld.Part0 = part
				weld.Part1 = corner
				weld.Name = "RWBX/Weld_"..e.Name.."_"..part.Name
				
				--prevent the game from trying to bevel this
				local product = Instance.new("BoolValue")
				product.Parent = corner
				product.Name = "BEVELPRODUCT"
				
				part.Changed:Connect(function()
					corner.Color = part.Color
					
					corner.Transparency = part.Transparency
				end)
			end
			part.CFrame = CFrame.new(part.CFrame.Position) * ogRot

			--prevent the game from trying to bevel this part
			local product = Instance.new("BoolValue")
			product.Parent = part
			product.Name = "BEVELPRODUCT"
		end
	end
end

wait(.2)

for i,e in pairs(workspace:GetDescendants()) do
	if e.ClassName == "Part" then
		if not e.Parent:FindFirstChild("Humanoid") then
			if e.Shape == Enum.PartType.Block and not e:FindFirstChildOfClass("SpecialMesh") then
				if not e:FindFirstChild("BEVELPRODUCT") then
					if not e:FindFirstChild("BEVELIGNORE") then
						bevelPart(e)
					end
				end
			end
		end
	end
end
