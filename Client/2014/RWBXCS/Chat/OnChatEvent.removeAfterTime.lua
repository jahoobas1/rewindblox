function disappear(msg)
	for i=0,1,.5 do
		msg.ImageTransparency = i
		msg.plrmsg.TextTransparency = i
		wait()
	end
end
function fadeIn(msg)
	for i=1,0,-.5 do
		msg.ImageTransparency = i
		msg.plrmsg.TextTransparency = i
		wait()
	end
end
fadeIn(script.Parent)
wait(20)
disappear(script.Parent)
script.Parent:Destroy()
