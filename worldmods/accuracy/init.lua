accuracy = {}

local registered = {}
local spread_min = 0.2

local function calculateCombinedRotationDifference(initialYaw, initialPitch, newYaw, newPitch)
	local diffYaw = newYaw - initialYaw
	local diffPitch = newPitch - initialPitch
	return math.sqrt(diffYaw^2 + diffPitch^2)
end


local player_data = {}
local hud_definitions = {
	hithud = {
		type = "image",
		text = "accuracy_hit.png",
		scale = {x = 1, y = 1},
		position = {x = 0.5, y = 0.5},
		offset = {x = 0, y = 0},
		alignment = {x = 0, y = 0}
	},
	gunsmith_spread = {
		type = "image",
		text = "accuracy_spread.png",
		scale = {x = 1, y = 1},
		position = {x = 0.5, y = 0.5},
		offset = {x = 0, y = 0},
		alignment = {x = 0, y = 0}
	},
}
local hud_definitions_initial = {
	hithud = {
		type = "image",
		text = "accuracy_hit.png",
		scale = {x = 0, y = 0},
		position = {x = 0.5, y = 0.5},
		offset = {x = 0, y = 0},
		alignment = {x = 0, y = 0},
	},
	gunsmith_spread = {
		type = "image",
		text = "accuracy_spread.png",
		scale = {x = 1, y = 1},
		position = {x = 0.5, y = 0.5},
		offset = {x = 0, y = 0},
		alignment = {x = 0, y = 0},
	},
}

core.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	player_data[player_name] = {
		start_time = 0,
		cooldown = 0,
		spread = 1,
	}
end)

core.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	local data = player_data[player_name]
	if data.hitjob then data.hitjob:cancel() end
	player_data[player_name] = nil
end)

local hide_hithud
local function set_hud(player, hudname, show) --show also serves to transport the right scale for spread
	local data = player_data[player:get_player_name()]
	if data[hudname] and not show then
		player:hud_change(data[hudname],"scale", {x = 0, y = 0})
	end
	if show then
		if hudname == "hithud" then
			if data.hitjob then data.hitjob:cancel() end
			data.hitjob = core.after(0.5, hide_hithud, player:get_player_name())
		end
		
		if data[hudname] then
			player:hud_change(data[hudname],"scale", hud_definitions[hudname].scale)
		end
		
		if hudname == "gunsmith_spread" and data[hudname] then
			hud_definitions[hudname].scale.x = show
			hud_definitions[hudname].scale.y = show
			player:hud_change(data[hudname],"scale",hud_definitions[hudname].scale)
		end
	end
end

hide_hithud = function(player_name)
	local player = core.get_player_by_name(player_name)
	local data = player_data[player_name]
	data.hitjob = nil
	if data["hithud"] then
		set_hud(player, "hithud",false)
	end
end

local check_interval = 0.1
local time_since_last_check = check_interval

core.register_globalstep(function(dtime)
	if time_since_last_check > check_interval then
	local dtime = time_since_last_check
	time_since_last_check = 0
	local clock = os.clock()
	for _, player in ipairs(core.get_connected_players()) do
		local player_name = player:get_player_name()
		local data = player_data[player_name]
		local controls = player:get_player_control()
		local current_time = core.get_gametime()
		local wielded_item = player:get_wielded_item():get_name()
		if registered[wielded_item] then
			local current_pos = player:get_pos()
			--~ local current_rotation = player:get_rotation()
			local yaw = player:get_look_horizontal()
			local pitch = player:get_look_vertical()
			data.last_spread = data.spread
			
			local wield_index = player:get_wield_index()
			if not data.armed then
				data.armed = true
				data.last_pos = current_pos
				data.yaw = yaw
				data.pitch = yaw
				data.spread = 1
				data.wield_index = wield_index
				data.wield_item = wielded_item
				for hudname,v in pairs(hud_definitions_initial) do
					if not data[hudname] then
						local def = table.copy(v)
						data[hudname] = player:hud_add(def)
					end
				end
			else
				if data.wield_index ~= wield_index or data.wield_item ~= wielded_item then
					data.spread = 1
					data.wield_index = wield_index
					data.wield_item = wielded_item
				end
			end
			
			
			if vector.distance(current_pos, data.last_pos) < 0.1*dtime then
				if not data.is_standing then
					data.is_standing = true
					data.is_sneaking = false
					data.start_time = current_time
					--~ core.chat_send_player(player_name, "You are standing still!")
				end
			elseif controls.sneak then
				if not data.is_sneaking then
					data.is_sneaking = true
					data.is_standing = false
					data.start_time = current_time
					--~ core.chat_send_player(player_name, "You started sneaking!")
				end
			else
				if data.is_sneaking then
					--~ local duration = current_time - data.start_time
					--~ core.chat_send_player(player_name, "You stopped sneaking after " .. duration .. " seconds!")
					data.is_sneaking = false
				end
				if data.is_standing then
					--~ local duration = current_time - data.start_time
					--~ core.chat_send_player(player_name, "You stopped standing still after " .. duration .. " seconds!")
					data.is_standing = false
				end
			end
			local spread = data.spread
			local aim = data.cooldown < clock

			local rotation = math.min(1,calculateCombinedRotationDifference(data.yaw,data.pitch,yaw,pitch))*dtime
			spread = spread + rotation
			if rotation > 0.01 then
				aim = false
			end
			
			if not data.is_standing then
				if data.is_sneaking then
					spread = math.max(spread,0.35)
				else
					spread = spread + 2*dtime
					aim = false
				end
			end
			
			if aim then
				spread = spread + (-1.4*dtime)
			end
			spread = math.min(math.max(spread,0),1)
			if data.last_spread ~= spread then
					set_hud(player,"gunsmith_spread",spread * (1-spread_min) + spread_min)
			end
			player_data[player_name].spread = spread
			data.last_pos = current_pos
			data.yaw = player:get_look_horizontal()
			data.pitch = player:get_look_vertical()
		else
			if data.armed then
				data.armed = false
				for hudname,_ in pairs(hud_definitions) do
					if data[hudname] then
						player:hud_remove(data[hudname])
						data[hudname] = nil
					end
				end
			end
		end
	end
	
	end
	time_since_last_check = time_since_last_check + dtime
end)

accuracy.reset = function (player)
	local player_name = player:get_player_name()
	player_data[player_name].spread = 1
end

--returns value between 0 and 1
accuracy.get = function (player)
	local player_name = player:get_player_name()
	return player_data[player_name].spread
end

accuracy.add = function (player, acc, clamp, cooldown)
	local player_name = player:get_player_name()
	local data = player_data[player_name]
	local old_acc = data.spread
	local new_acc = old_acc + acc
	if old_acc >= clamp then return end
	if new_acc >= clamp then new_acc = clamp end
	data.spread = new_acc
	data.cooldown = cooldown or 0
end

accuracy.register = function (item_name)
	registered[item_name] = true
end

accuracy.hit = function (player)
	set_hud(player, "hithud", true)
end