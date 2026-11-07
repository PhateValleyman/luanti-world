-----------------
------MATH-------
-----------------
minetestd.math = {}

minetestd.math.sortp = function(minp, maxp)
	if not (type(minp) == "table" and type(maxp) == "table") then return end
	if minp.x > maxp.x then
		minp.x, maxp.x = maxp.x, minp.x
	end
	if minp.y > maxp.y then
		minp.y, maxp.y = maxp.y, minp.y
	end
	if minp.z > maxp.z then
		minp.z, maxp.z = maxp.z, minp.z
	end
	
	return minp, maxp
end

minetestd.math.volume_in_volume = function(minp1, maxp1, minp2, maxp2)
	minp1, maxp1 = minetestd.math.sortp(minp1, maxp1)
	minp2, maxp2 = minetestd.math.sortp(minp2, maxp2)
	return (minp1.x <= maxp2.x and minp2.x <= maxp1.x and
		minp1.y <= maxp2.y and minp2.y <= maxp1.y and
		minp1.z <= maxp2.z and minp2.z <= maxp1.z
	)
end

minetestd.math.get_volume_in_volume = function(minp1, maxp1, minp2, maxp2)
	minp1, maxp1 = minetestd.math.sortp(minp1, maxp1)
	minp2, maxp2 = minetestd.math.sortp(minp2, maxp2)
	if (minp1.x <= maxp2.x and minp2.x <= maxp1.x and
		minp1.y <= maxp2.y and minp2.y <= maxp1.y and
		minp1.z <= maxp2.z and minp2.z <= maxp1.z
	) then
		return {
			x=math.max(minp1.x, minp2.x),
			y=math.max(minp1.y, minp2.y),
			z=math.max(minp1.z, minp2.z)
		}, {
			x=math.min(maxp1.x, maxp2.x),
			y=math.min(maxp1.y, maxp2.y),
			z=math.min(maxp1.z, maxp2.z)
		}
	else
		return nil
	end
end

minetestd.math.pos_in_volume = function(pos, minp, maxp)
	minp, maxp = minetestd.math.sortp(minp, maxp)
	return (minp.x <= pos.x and pos.x <= maxp.x and
		minp.y <= pos.y and pos.y <= maxp.y and
		minp.z <= pos.z and pos.z <= maxp.z
	)
end

-----------------
---Table stuff---
-----------------

minetestd.tables = {}

minetestd.tables.get_keytable = function(t)
	if not (type(t) == "table") then return end
	local key_table = {}
	for k,_ in pairs(t) do
		table.insert(key_table, k)
	end
	return key_table
end

minetestd.tables.merge_tables=function(t1, t2, func, ...)
	local t = table.copy(t1)
	for k,v in pairs(t2) do
		if func and (t[k] ~= nil) then 
			t[k] = func(t[k], v, k, ...)
		else
			t[k] = v
		end
	end
	return t
end

minetestd.tables.smart_merge_values = function(v1, v2, _, shallow_tables)
	if (type(v1) == "table") then
		if (type(v2) == "table") then
			if shallow_tables then
				return minetestd.tables.merge_tables(v1,v2)
			else
				return minetestd.tables.smart_merge_values(v1,v2)
			end
		else
			table.insert(v1, v2)
		end
	elseif (type(v2) == "table") then
		table.insert(v2, v1)
	
	elseif (type(v1) == "userdata") or (type(v2) == "userdata") then return v2
	elseif (type(v1) == "function") 
		or (type(v2) == "function") 
		or (type(v1) == "CFunction") 
		or (type(v2) == "CFunction") 
	then
		if 
			((type(v1) == "function") or (type(v1) == "CFunction")) 
			and ((type(v2) == "function") or (type(v2) == "CFunction")) 
		then
			return (function(...) 
				return v1(v2(...))
			end)
		else
			return v2
		end
	elseif (type(v1) == "string") or (type(v2) == "string") then
		return tostring(v1)..tostring(v2)
	elseif (type(v1) == "boolean") and (type(v2) == "boolean") then
		return (v1 or v2)
	elseif (type(v1) == "number") or (type(v1) == "boolean") or (type(v2) == "number") or (type(v2) == "boolean") then
		if (type(v1) == "boolean") then
			v1 = v1 and 1 or 0
		end
		if (type(v2) == "boolean") then
			v2 = v2 and 1 or 0
		end
		return v1 + v2
	else
		return v2
	end
	
end


-----------------
----misc-util----
-----------------
minetestd.utils = {}


minetestd.utils.check_item_match = function(item_name, match, recurse_internal) 

	if type(match) == "string" then
		if item_name == match then return match end
		if string.sub(match,1,6) == "group:" then
			local group = string.sub(match,7)
			if minetest.registered_nodes[item_name] then
				if minetest.registered_nodes[item_name].groups[group] then return match end
			elseif minetest.registered_items[item_name] then
				if minetest.registered_items[item_name].groups[group] then return match end
			end
		elseif match == "minetest:node" and minetest.registered_nodes[item_name] then
			return match
		end
		return nil
	elseif type(match) == "table" then
		for _,name in pairs(match) do
			local m = minetestd.utils.check_item_match(item_name, name, true)
			if m then
				if not recurse_internal then 
					return m
				else
					return match
				end 
			end
		end
	end
end

minetestd.utils.is_solid_block = function(pos)
	if not minetest.get_node_or_nil(pos) then return true end
	local def = minetest.registered_nodes[minetest.get_node(pos).name]
	if not def then return true end -- Unknown node is a solid block
	return (def.drawtype == "normal" and def.walkable ~= false)
end

minetestd.utils.get_artificial_light = function(pos)
	--Lua implementation of https://github.com/minetest/minetest/pull/5680, with my own approach
	local node = minetest.get_node(pos)
	if minetest.registered_nodes[node.name] then
		if minetest.registered_nodes[node.name].paramtype == "light" then
			return math.floor(node.param1/16)
		elseif minetest.registered_nodes[node.name].light_source then
			return minetest.registered_nodes[node.name].light_source
		else
			return 0
		end
	else
	
	end
end

minetestd.utils.get_sky_light_fast = function(pos)
	--Faster than get_natural_light, but a very ugly hack.
	local node = minetest.get_node(pos)
	if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].paramtype == "light" then
		local light1, light2 = math.floor(node.param1/16), node.param1%16
		if light2 == light1 then light2 = 0 end
		return light2
	else
		return 0
	end
	
end

minetestd.utils.get_natural_light = function(pos, max_loops)
	-- Lua implementation of https://github.com/minetest/minetest/pull/5680, with my own, different approach
	-- Will likely be removed when those are merged.
	
	local l = minetest.get_node_light(pos, 0.5)
	if l == 0 or l == 15 or not l then -- Quick escapes
		return l or 0
	end
	--Now, for the ugly part.
	local search = {
		{
			strength = 15,
			p = {x=0,y=0,z=0}
		},
	}
	local passed = {}
	local highest_light = 0
	local light, n, param1
	local hash = minetest.hash_node_position
	local copy = table.copy
	
	local loops = 0
	while #search > 0 do
		loops = loops + 1
		if loops >= (max_loops or 6) then
			--print("minetestd.utils.get_natural_light: Memory bomb detected, breaking loop.")
			break
		end
		local search_next = {}
		for _,trace in pairs(search) do
			n = minetest.get_node_or_nil(vector.add(pos, trace.p))
			if n then
				param1 = n.param1
				n = n.name
			end
			if not (minetest.registered_nodes[n] or {}).paramtype == "light" --[[or param1 == 0]] then --Blocks light, or in true dark
				passed[hash(trace)] = true -- Mark this node as passed so that traces don't go inside.
				-- This trace dies here.
			else
				light = (param1%16)
				if light == math.floor(param1/16) then light = 0 else
					light = light + trace.strength - 15
				end
				if light > highest_light then --It's brighter
					highest_light = light
				end
				trace.strength = trace.strength - 1
			
				if trace.strength > highest_light then 
					 -- minetest.set_node(vector.add(pos, trace.p), {name="default:glass"}) --Debug
					 -- It's possible we could still find a brighter source.
					 -- Spead out further.
					trace.p.x = trace.p.x+1
					if not passed[hash(trace.p)] then
						table.insert(search_next, copy(trace))
					end
					trace.p.x = trace.p.x-2
					if not passed[hash(trace.p)] then
						table.insert(search_next, copy(trace))
					end
					trace.p.x = trace.p.x+1
					trace.p.y = trace.p.y+1
					if not passed[hash(trace.p)] then
						table.insert(search_next, copy(trace))
					end
					trace.p.y = trace.p.y-2
					if not passed[hash(trace.p)] then
						table.insert(search_next, copy(trace))
					end
					trace.p.y = trace.p.y+1
					trace.p.z = trace.p.z+1
					if not passed[hash(trace.p)] then
						table.insert(search_next, copy(trace))
					end
					trace.p.z = trace.p.z-2
					if not passed[hash(trace.p)] then
						table.insert(search_next, copy(trace))
					end
				end
			end
		end
		for _,trace in pairs(search_next) do
			passed[hash(trace.p)] = true
		end
		search = search_next
	end
	--minetest.chat_send_all(loops)
	return highest_light
end

minetestd.utils.get_light_info = function(pos) --Deprecated
	pos = vector.round(pos)
	if not (pos and minetest.get_node_light(pos)) then return end
	return {
		light=minetest.get_node_light(pos),
		day=minetest.get_node_light(pos, 0.5),
		night=minetest.get_node_light(pos, 0),
		skylit=minetestd.utils.get_sky_light(pos) > 0,
		direct_sun=(minetestd.utils.get_sky_light(pos) >= 15),
	}
end

minetestd.utils.parse_chatargs = function(argstring) 
	local args = {""}
	local argc = 0
	if argstring ~= nil and argstring ~= "" and argstring ~= " " then
		args = string.split(argstring, " ")
		argc = #args 
	end
	return args, argc
end

minetestd.utils.pos_to_shorthand = function(p)
	local pos = vector.round(p)
	local sign = 0
	if pos.x < 0 then
		sign = sign + 1
		pos.x = math.abs(pos.x)
	end
	if pos.y < 0 then
		sign = sign + 2
		pos.y = math.abs(pos.y)
	end
	if pos.z < 0 then
		sign = sign + 4
		pos.z = math.abs(pos.z)
	end
	return sign..pos.x.."_"..pos.y.."_"..pos.z
end

minetestd.utils.shorthand_to_pos = function(str)
	local parts = string.split(str, "_")
	local sign = tonumber(string.sub(parts[1], 1, 1))
	parts[1] = string.sub(parts[1], 2, -1)
	return {
		x=tonumber(parts[1]) * (((sign%2) > 0) and -1 or 1),
		y=tonumber(parts[2]) * (((sign%4) > 1) and -1 or 1),
		z=tonumber(parts[3]) * ((sign > 3) and -1 or 1),
	}
end