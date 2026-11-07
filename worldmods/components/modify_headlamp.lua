

if minetest.get_modpath("headlamp") then
	
	local headlamp_on = minetest.registered_items["headlamp:headlamp_on"]
	if not headlamp_on.groups.headlamp then
		headlamp_on.groups.headlamp = 1
		minetest.override_item("headlamp:headlamp_on"	, { groups = headlamp_on.groups })
	end
	
	local headlamp_off = minetest.registered_items["headlamp:headlamp_off"]
	if not headlamp_off.groups.headlamp then
		headlamp_off.groups.headlamp = 1
		minetest.override_item("headlamp:headlamp_off"	, { groups = headlamp_off.groups })
	end
	
	minetest.register_craft{
		type = "shapeless",
		output = "headlamp:headlamp_off",
		recipe = {"group:headlamp", "components:batery"},
	}
	
end