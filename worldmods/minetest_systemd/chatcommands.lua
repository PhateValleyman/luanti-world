minetest.register_chatcommand("minetestd", {
	description = "Minetest_systemd service management command. Valid actions: start, stop, restart, status. '*' can be used to operate on all services at once.",
	params = "<action> <service> | services [<search pattern>]",
	privs = {server=true},
	func = function(name, argstring) 
		minetestd.minetestd_command(name, argstring) --Defined at the bottom of this file because it's f***in' huge.
	end,
})

minetest.register_chatcommand("groups", {
	description = "List all item groups on your held item",
	privs={debug=true},
	func = function(player_name)
		local player = minetest.get_player_by_name(player_name)
		if player then
			local str = ""
			local i=player:get_wielded_item():get_name()
			if not minetest.registered_items[i] then return false, "You must be holding a valid item" end
			if (not minetest.registered_items[i].groups) then return false, "This item has no groups" end
			for group, value in pairs(minetest.registered_items[i].groups) do
				if not (str == "") then
					str = str..", "
				end
				str = str..group.."="..value
			end
			if str == "" then str = "This item has no groups" end
			return true,str
		end
	end
})

minetest.register_chatcommand("getwear", {
	description = "Print the wear on your held item",
	privs={debug=true},
	func = function(player_name)
		local player = minetest.get_player_by_name(player_name)
		if player then
			return true,"Wear: "..(player:get_wielded_item():get_wear() or "nil")
		end
	end
})

minetest.register_chatcommand("getlight", {
	description = "Print useful data about the node and sky light where you're standing",
	func = function(player_name)
		local player = minetest.get_player_by_name(player_name)
		if player then
			local pos = player:get_pos()
			pos = vector.round(pos)
			local str = "Light: "
			if not minetest.get_node_light(pos) then
				return false, "Light value here is nil, for some odd reason..."
			end
			str = str..minetest.get_node_light(pos)
			str = str.."\nDay: "..minetest.get_node_light(pos, 0.5)..", Night: "..minetest.get_node_light(pos, 0)
			str = str.."\nSky (fast): "..minetestd.utils.get_sky_light_fast(pos)
			str = str.."\nSky (accurate): "..minetestd.utils.get_natural_light(pos)
			str = str.."\nArtificial: "..minetestd.utils.get_artificial_light(pos)
			return true,str
		end
	end
})

minetest.register_privilege("setphysics", {
	description = "Allowed to change worldwide default physics using /setgravity, /setjump, /setspeed",
	give_to_singleplayer = false
})

minetest.register_chatcommand("setgravity", {
	privs = {setphysics=true},
	func = function(_, p)
		local value = tonumber(p)
		if value then
			minetestd.physicsctl.worldPhysics.gravity = value
			return true, "World physics updated."
		else
			return false, "Expected a valid number for argument 1"
		end
	end
})

minetest.register_chatcommand("setspeed", {
	privs = {setphysics=true},
	func = function(_, p)
		local value = tonumber(p)
		if value then
			minetestd.physicsctl.worldPhysics.speed = value
			return true, "World physics updated."
		else
			return false, "Expected a valid number for argument 1"
		end
	end
})

minetest.register_chatcommand("setjump", {
	privs = {setphysics=true},
	func = function(_, p)
		local value = tonumber(p)
		if value then
			minetestd.physicsctl.worldPhysics.jump = value
			return true, "World physics updated."
		else
			return false, "Expected a valid number for argument 1"
		end
	end
})



minetestd.disable_service = function(servicename, playername) 
	if minetestd.services[servicename].stop then 
		minetestd.services[servicename].stop()
	else
		minetestd.services[servicename].enabled = false
	end
	for s,service in pairs(minetestd.services) do
		if service.depends[servicename] and service.enabled then
			minetestd.disable_service(s, playername)
			if playername then minetest.chat_send_player(playername, "Stopping dependant service "..s..".") end
		end
	end
end

minetestd.can_start = function(servicename) 
	if not minetestd.services[servicename] then 
		local err = "Start Failed: Service "..servicename.." does not exist."
		return false, err
	end
	if not minetestd.services[servicename].start then 
		return false, "Start Failed: Service "..servicename.." does not have a start call."
	end
	if minetestd.services[servicename].enabled then 
		local err = "Start Failed: Service "..servicename.." is already running."
		return false, err
	end
	if not minetestd.services[servicename].initialized then
		local err = "Start Failed: Service "..servicename.." did not initialize correctly, and can't be started."
		return false, err
	end
	for dep,_ in pairs(minetestd.services[servicename].depends) do
		if not minetestd.services[dep].enabled then
			local err = "Start Failed: Service "..servicename.." depends on "..dep..", but it is not running."
			return false, err
		end
	end
	return true
end

minetestd.minetestd_command = function(name, argstring)
	local args = ""
	local argc = 0
	if argstring ~= nil and argstring ~= "" and argstring ~= " " then
		args = string.split(argstring, " ")
		argc = #args 
	end
	if argc > 0 and (args[1] == "services" or args[1] == "list" or (args[1] == "status" and args[2] == "*")) then
		local pattern = ""
		local n = 2
		while n <= argc do
			if n > 2 then 
				pattern=pattern.." "
			end
			pattern = pattern..args[n]
			n = n+1
		end
		if pattern == "*" then pattern = "" end
		local found = minetest.colorize("#80F","Minetestd Registered Services").. minetest.colorize("#C9F"," (A=Active, I=Inactive, X=Failed):\n")
		local first = true
		for service,sv in pairs(minetestd.services) do
			if string.find(service, pattern) then
				if first then
					first = false
				else
					found = found..", "
				end
				found = found..service
				if sv.initialized then 
					if sv.enabled then
						found = found.." (A)"
					else
						found = found.." (I)"
					end
				else
					found = found.."(X)"
				end
			end
		end
		minetest.chat_send_player(name, found)
	elseif argc == 2 then
		if minetestd.services[args[2]] or args[2] == "*" then
			if args[1] == "start" or args[1] == "enable" then
				if args[2] == "*" then
					for _,s in pairs(minetestd.service_load_order) do
						local service = minetestd.services[s]
						local ok, err = minetestd.can_start(s)
						if ok then
							service.start()
						else
							minetest.chat_send_player(name, err)
						end
					end
				elseif minetestd.services[args[2]].start then 
					local ok, err = minetestd.can_start(args[2])
					if ok then
						minetestd.services[args[2]].start()
					else
						minetest.chat_send_player(name, err)
					end
				end
			elseif args[1] == "stop" or args[1] == "disable" then
				if args[2] == "*" then
					for name,service in pairs(minetestd.services) do
						if service.enabled then
							if service.stop then service.stop() end
						else
							minetest.chat_send_player(name, "Stop failed: Service "..name.." is not active.")
						end
					end
				else
					if minetestd.services[args[2]].enabled then minetestd.disable_service(args[2], name) else
						minetest.chat_send_player(name, "Stop failed: Service is not active.")
					end
				end
			elseif args[1] == "restart" or args[1] == "reload" then
				if args[2] == "*" then
					for _,s in pairs(minetestd.service_load_order) do
						local service = minetestd.services[s]
						if service.enabled and service.stop then service.stop() end
						local ok, err = minetestd.can_start(s)
						if ok then
							service.start()
						else
							minetest.chat_send_player(name, err)
						end
					end
				else
					if minetestd.services[args[2]].stop then minetestd.services[args[2]].stop() end
					local ok, err = minetestd.can_start(args[2])
					if ok then
						minetestd.services[args[2]].start()
					else
						minetest.chat_send_player(name, err)
					end
				end
			elseif args[1] == "status" then
				local status = args[2]..": "
				if minetestd.services[args[2]].initialized then 
					if minetestd.services[args[2]].enabled then
						status = status.."active"
					else
						status = status.."idle"
					end
				else
					status = status.."failed to initialize"
				end
				minetest.chat_send_player(name, status)
			else
				minetest.chat_send_player(name, "Invalid arguments. See /help minetestd for usage.")
			end
		else
			minetest.chat_send_player(name, "That service doesn't seem to be registered.")
		end
	else
		minetest.chat_send_player(name, "Invalid arguments. See /help minetestd for usage.")
	end
end