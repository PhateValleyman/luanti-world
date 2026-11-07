-- simple_furniture/init.lua

-- Loads The LUA Files For The Mod

local path = minetest.get_modpath("simple_furniture")

dofile(path .. "/sf_benches.lua")
dofile(path .. "/sf_chairs.lua")

dofile(path .. "/sf_end_tables.lua")
dofile(path .. "/sf_dining_tables.lua")

dofile(path .. "/sf_cabinets.lua")

dofile(path .. "/sf_crafting.lua")

-- These Are For When Cropocalypse And/Or Dynamic Trees Are Installed
-- Checks If Cropocalypse Is Installed
if minetest.get_modpath("cropocalypse") then
	dofile(path .. "/sf_cropocalypse.lua")
end
-- Checks If Dynamic Trees Is Installed
if minetest.get_modpath("dynamic_trees") then
	dofile(path .. "/sf_dynamic_trees.lua")
end