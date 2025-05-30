local service = {}

local centerDialogs = {

}

function service:AddCenterDialog(instance, dialogType, showfunc, hidefunc)
	if not game:GetService("RunService"):IsClient() then warn("Cannot run AddCenterDialog on the server") return end

	for v,i in pairs(centerDialogs) do
		if i == tostring(instance) then
			return
		end
	end

	table.insert(centerDialogs, tostring(instance))
	if typeof(showfunc) == "function" then
		showfunc()
	end

	if typeof(hidefunc) == "function" then
		centerDialogs[tostring(instance)] = hidefunc
	end
end

function service:RemoveCenterDialog(instance)
	if not game:GetService("RunService"):IsClient() then warn("Cannot run RemoveCenterDialog on the server") return end
	for v,i in pairs(centerDialogs) do
		if i == tostring(instance) then
			if typeof(centerDialogs[i]) == "function" then
				centerDialogs[i]()
			end
			table.remove(centerDialogs, v)
		end
	end
end

return service
