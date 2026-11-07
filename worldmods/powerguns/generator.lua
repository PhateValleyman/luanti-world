local shared = ...
local S = shared.S
local function generated_power(nodemeta)
	return math.min(200, math.floor((core.get_gametime()-nodemeta:get_int("last_used"))/3))
end
core.register_node("powerguns:generator", {
	description = S("Power Particle Generator"),
	tiles = {
		"powerguns_generator_top.png",
		"powerguns_workbench_bottom.png",
		"powerguns_generator_side.png",
	},
	paramtype = "light",
	light_source = 9,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if clicker:is_player() then
			local nodemeta = core.get_meta(pos)
			core.chat_send_player(clicker:get_player_name(), S("Charge: @1", generated_power(nodemeta)))
		end
	end,
	on_punch = function(pos, node, puncher)
		local nodemeta = core.get_meta(pos)
		local inv = puncher:get_inventory()
		local power = generated_power(nodemeta)
		if power > 0 and inv:room_for_item("main", "powerguns:power " .. power) then
			inv:add_item("main", "powerguns:power " .. power)
			nodemeta:set_int("last_used", core.get_gametime())
		end
	end,
	on_construct = function(pos)
		local nodemeta = core.get_meta(pos)
		nodemeta:set_int("last_used", core.get_gametime())
	end,
})
