local desc = ...
local t = {}
local modname = core.get_current_modname()
local name = modname .. ":workbench"
local recipes = {}

function itemname_matcher(group) --group or node
	if string.find(group, "^group:") then
		local groups = string.split(group:sub(7), ",")
		return function(nodename)
			for _, groupname in pairs(groups) do
				if core.get_item_group(nodename, groupname) == 0 then
					return false
				end
			end
			return true
		end
	else
		return function(nodename)
			return nodename == group
		end
	end
	
end

local function first_registered_item_of_group(group)
	for name, def in pairs(core.registered_items) do
		if itemname_matcher(group)(name) then
			return name
		end
	end
end

local function is_group(s)
	if s:find("^group:") then return true end
end

local function contains_item_or_group(inv, list_name, input)
	local item_or_group, count = unpack(input:split(" "))
	count = tonumber(count) or 1
	local total_count = 0
	local list = inv:get_list(list_name)
	for _, stack in ipairs(list) do
		if stack:get_name() ~= "" then
			if stack:get_name() == item_or_group or (item_or_group:match("^group:") and core.get_item_group(stack:get_name(), item_or_group:sub(7)) > 0) then
				total_count = total_count + stack:get_count()
				if total_count >= count then
					return true
				end
			end
		end
	end
	return false
end

local function remove_item_or_group(inv, list_name, input)
	local item_or_group, count = unpack(input:split(" "))
	count = tonumber(count) or 1
	local remaining = count
	local list = inv:get_list(list_name)
	for index, stack in ipairs(list) do
		if stack:get_name() ~= "" then
			if stack:get_name() == item_or_group or (item_or_group:match("^group:") and core.get_item_group(stack:get_name(), item_or_group:sub(7)) > 0) then
				local stack_count = stack:get_count()
				if stack_count >= remaining then
					stack:take_item(remaining)
					inv:set_stack(list_name, index, stack)
					return true
				else
					remaining = remaining - stack_count
					stack:clear()
					inv:set_stack(list_name, index, stack)
				end
			end
		end
	end
	return false
end


local function make_formspec(player, selected_item)
	local f = {}
	table.insert(f,"formspec_version[5]size[10,10]")
	local i = 0.5
	local valid_selection = false
	for k,v in pairs(recipes) do
		if not v.alias then
			if selected_item==k then
				valid_selection = true
				table.insert(f,"item_image["..(i%9)..","..(math.floor(i/9)+0.5)..";1,1;"..k.."]")
			else
				table.insert(f,"item_image_button["..(i%9)..","..(math.floor(i/9)+0.5)..";1,1;"..k..";"..k..";]")
			end
			i = i + 1
		end
	end
	if valid_selection then
		table.insert(f,"label[0.5,6;"..ItemStack(selected_item):get_description().."]")
		local i = 0.5
		local can_craft = true
		local inv = player:get_inventory()
		for _,v in ipairs(recipes[selected_item]) do
			local g = is_group(v)
			table.insert(f,"item_image_button[".. (i%7) ..","..(math.floor(i/7)+7.5)..";1,1;"..(g and first_registered_item_of_group(v:split(" ")[1]).." "..v:split(" ")[2] or v)..";"..v..(g and ";G]" or ";]") )
			if not contains_item_or_group(inv,"main", v) then can_craft = false end
			i = i + 1
		end
		if can_craft then
			table.insert(f,"image_button[8,8;1.5,1.5;"..modname.."_workbench_craft.png;craft_"..selected_item..";]")
		else
			table.insert(f,"image[8,8;1.5,1.5;"..modname.."_workbench_craft_disabled.png]")
		end
	end
	return table.concat(f)
end

t.register_craft = function(craft, is_alias)
	local counting = {}
	for _,v in ipairs(craft.recipe) do
	for _,w in ipairs(v) do
		local is = ItemStack(w)
		w = is:get_name()
		if recipes[w] and recipes[w].alias then
			for k,v in pairs(recipes[w]) do
				if k ~= "alias" then
					counting[k] = (counting[k] or 0) + v*is:get_count()
				end
			end
		else
			counting[w] = (counting[w] or 0) + is:get_count()
		end
	end
	end
	local new_recipe = {}
	if is_alias then
		counting.alias = true
		recipes[craft.output] = counting
	else
		for k,v in pairs(counting) do
			table.insert(new_recipe, k.." "..v)
		end
		recipes[craft.output] = new_recipe
	end
end

core.register_node(name, {
	description = desc,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	tiles = {modname.."_workbench_top.png",
	modname.."_workbench_bottom.png",
	modname.."_workbench_side.png",},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if clicker:is_player() then
			 core.show_formspec(clicker:get_player_name(), name, make_formspec(clicker))
		end
	end,
})

core.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= name then
		return
	end

	for k,v in pairs(fields) do
		if k:find("^craft_") then
			local result = k:sub(7)
			local inv = player:get_inventory()
			if inv:room_for_item("main", result) then
				for _,v in ipairs(recipes[result]) do
					if not contains_item_or_group(inv,"main", v) then return end
				end
				for _,v in ipairs(recipes[result]) do
					remove_item_or_group(inv,"main", v)
				end
				inv:add_item("main", result)
				core.show_formspec(player:get_player_name(), name, make_formspec(player, result))
			end
			return
		end
		if k:find(modname..":") then
			core.show_formspec(player:get_player_name(), name, make_formspec(player, k))
			return
		end
	end
end)


return t