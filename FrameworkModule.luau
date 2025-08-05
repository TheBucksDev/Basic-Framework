local Module = {}

local Types = require(script.Types)

function Module.GetClient () : Types.FrameWork
	local _Table = {}

	for _, Module in script.Parent.Modules:GetChildren() do
		task.spawn(function()
			_Table[Module.Name] = require(Module)
		end)
	end

	return _Table
end 

function Module.GetServer () : Types.Server
	local CurrentService = game:GetService("RunService"):IsServer()
	
	local _Table = {}

	if CurrentService then
		for _, Module in game:GetService("ServerStorage").Modules:GetChildren() do
			task.spawn(function()
				_Table[Module.Name] = require(Module)
			end)
		end
		
		return _Table
	end
end 

return {["Server"] = Module.GetServer(), ["Client"] = Module.GetClient()} or {["Client"] = Module.GetClient()}
