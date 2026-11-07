modMinerTrade = {
	modName = minetest.get_current_modname(),
	modPath = minetest.get_modpath(minetest.get_current_modname()),
	save_compressed = (minetest.settings:get_bool("minertrade.save_compressed") ~= false),
	bank = {
		accounts = 0,
		last_pay = 0,
		player = { },
	},
	
}
