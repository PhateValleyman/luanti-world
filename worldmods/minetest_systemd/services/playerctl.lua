if not minetestd.services.playerctl.initialized then 
minetestd.playerctl = {}
minetestd.playerctl.steps = {}
end
minetestd.playerctl.test = function()
	local passed = false
	local path = minetest.get_worldpath().."/players/testfile.minetestd"
	local content = tostring(os.date())
	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
	end
	file = io.open(path, "r")
	if file then
		passed = (file:read("*all") == content)
		file:close()
	end
	return passed
end

if minetestd.playerctl.test() and minetestd.error_notify then
	minetestd.error_notify.errors["playerctl_directory_missing"] = nil
else
	minetestd.error_notify.errors["playerctl_directory_missing"] = 
	"NOTE: PlayerCTL's data-saving functionality requires a \"players\" folder to be present in your world path ("..minetest.get_worldpath()..
	").\nWithout it, PlayerCTL will still function, but any player data handled through this service will vanish when a player leaves the game."
end
minetestd.playerctl.players = {}
minetestd.playerctl.register_playerstep = function(name, step) 
-- Step named "name", calls stepFunc(player, dtime) for every player on globalstep. 
-- Stores per-player data (initialized with data_default) in minetestd.playerctl.players[player_name][step_name]

	if name then
		minetestd.playerctl.steps[name] = step
	end
	if step.interval then
		step.dt = 0
	end
	if step.getNewData then 
		for _,player in pairs(minetest.get_connected_players()) do
			if minetestd.playerctl.players[player:get_player_name()] and 
				not minetestd.playerctl.players[player:get_player_name()][name]
			then
				minetestd.playerctl.players[player:get_player_name()][name] = step.getNewData(player)
			end
		end
	end
end

minetestd.playerctl.delete_step = function(name)
	minetestd.playerctl.steps[name] = nil
	for _,player in pairs(minetestd.playerctl.players) do
		player[name] = nil
	end
end

minetestd.playerctl.edit_offline = function(name, func, ...) --If you call this, be prepared, for your expected data might be nil!
	local file = io.open(minetest.get_worldpath().."/players/"..name..".minetestd_data", "r") --This is basically on_join
	local data
	if file then
		data = file:read("*all")
		file:close()
	end
	if data then
		minetestd.playerctl.players[name] = minetest.deserialize(data)
	else
		minetestd.playerctl.players[name] = {}
	end
	
	local retv = func(...)--Now the player is "in-game", we can interact with their data.
	
	if not minetestd.playerctl.players[name] then minetestd.playerctl.players[name] = {} end --this is basically on_leave
	for skey,step in pairs(minetestd.playerctl.steps) do
		if not step.save then
			minetestd.playerctl.players[name][skey] = nil
		end
	end
	local file = io.open(minetest.get_worldpath().."/players/"..name..".minetestd_data", "w")
	if file then
		file:write(minetest.serialize(minetestd.playerctl.players[name]))
		file:close()
	end
	minetestd.playerctl.players[name] = nil
	
	return retv
end

minetestd.playerctl.meta_overwrites = {}
minetestd.playerctl.register_metatable_change = function(changer, deprecated_syntax_changer)
	if type(deprecated_syntax_changer) == "function" then
		changer = deprecated_syntax_changer
	end
	table.insert(minetestd.playerctl.meta_overwrites, changer)
	minetestd.playerctl.meta_queued = true
end


minetestd.playerctl.on_join = function(player) 
	if minetestd.services["playerctl"].enabled then
		if not minetestd.services.playerctl.metatable then
			minetestd.services.playerctl.metatable = getmetatable(player)
		end
		
		local name = player:get_player_name()
		local file = io.open(minetest.get_worldpath().."/players/"..name..".minetestd_data", "r")
		local data
		if file then
			data = file:read("*all")
			file:close()
		end
		if data then
			minetestd.playerctl.players[name] = minetest.deserialize(data)
		else
			minetestd.playerctl.players[name] = {}
		end
		for skey,step in pairs(minetestd.playerctl.steps) do
			if not (step.save and minetestd.playerctl.players[name][skey]) then
				if step.getNewData then
					minetestd.playerctl.players[name][skey] = step.getNewData(player)
				end
			end
		end
	end
end


minetestd.playerctl.on_leave = function(player)
	if minetestd.services["playerctl"].enabled then
		
		local name = player:get_player_name()
		if not minetestd.playerctl.players[name] then minetestd.playerctl.players[name] = {} end
		for skey,step in pairs(minetestd.playerctl.steps) do
			if not step.save then
				minetestd.playerctl.players[name][skey] = nil
			end
		end
		local file = io.open(minetest.get_worldpath().."/players/"..name..".minetestd_data", "w")
		if file then
			file:write(minetest.serialize(minetestd.playerctl.players[name]))
			file:close()
		end
		minetestd.playerctl.players[name] = nil
	end
end



if not minetestd.services.playerctl.initialized then 
	-- Only do minetest.register_stuff if this is the initialization call (in which case, service.initialized will be false)

	minetest.register_on_leaveplayer(function(player)
		minetestd.playerctl.on_leave(player)
	end)

	minetest.register_on_shutdown(function()
		for _,player in pairs(minetest.get_connected_players()) do
			minetestd.playerctl.on_leave(player)
		end
	end)
end

minetestd.services.playerctl.step = function(dtime)
	if minetestd.services["playerctl"].enabled then
		if minetestd.playerctl.meta_queued and minetestd.services.playerctl.metatable then
			for name,func in pairs(minetestd.playerctl.meta_overwrites) do
				if type(func) == "function" then
					func(minetestd.services.playerctl.metatable)
				end
			end
			minetestd.playerctl.meta_overwrites = {}
			minetestd.playerctl.meta_queued = false
		end
		
		local queue = {}
		for _,step in pairs(minetestd.playerctl.steps) do
			if step.interval then
				if step.dt >= 0 then
					step.dt = step.dt - dtime
				else
					queue[#queue + 1] = step.func
					step.dt = step.interval
				end
			else
				queue[#queue + 1] = step.func
			end
		end
		
		for _,player in pairs(minetest.get_connected_players()) do
			if not minetestd.playerctl.players[player:get_player_name()] then
				minetestd.playerctl.on_join(player)
			else
				for _,func in pairs(queue) do
					func(player, dtime)
				end
			end
		end
	end
end

return true
