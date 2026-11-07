modComponents = {
	modname = minetest.get_current_modname(),
	modpath = minetest.get_modpath(minetest.get_current_modname())
}
dofile(modComponents.modpath.."/translate.lua")
dofile(modComponents.modpath.."/components_objects.lua")
dofile(modComponents.modpath.."/components_recipes.lua")
dofile(modComponents.modpath.."/components_digs.lua")
dofile(modComponents.modpath.."/modify_headlamp.lua")

minetest.log('action',"["..modComponents.modname:upper().."] Loaded!")
