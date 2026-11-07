local shared = ...
local S = shared.S

local workbench = assert(loadfile(core.get_modpath(core.get_current_modname()) .. "/workbench.lua"))(S("Power Workbench"))

local item_diamond = "default:diamond"
local item_gold = "default:gold_ingot"
local item_steel = "default:steel_ingot"
local item_coal = "default:coal_lump"
local item_tin = "default:tin_ingot"
local item_mese = "default:mese_crystal"

if minetest.get_modpath("mcl_core") then
	item_diamond = "mcl_core:diamond"
	item_gold = "mcl_core:gold_ingot"
	item_steel = "mcl_core:iron_ingot"
	item_coal = "mcl_core:coal_lump"
	item_tin = "mcl_copper:copper_ingot"
	item_mese = "mcl_nether:netherite_ingot"
end

workbench.register_craft({
	output = "powerguns:gunsteel_ingot",
	recipe = {
		{item_steel, item_tin, item_coal},
	}
},true)

workbench.register_craft({
	output = "powerguns:ultra_gunsteel_ingot",
	recipe = {
		{item_mese},
		{item_gold, "powerguns:gunsteel_ingot", item_gold},
		{item_diamond},
	}
},true)

workbench.register_craft({
	output = "powerguns:gun_power_core",
	recipe = {
		{"powerguns:gunsteel_ingot", item_gold.." 9", "powerguns:gunsteel_ingot"},
		{item_diamond.." 9", item_mese.." 9", item_diamond.." 9"},
		{"powerguns:gunsteel_ingot", item_gold.." 9", "powerguns:gunsteel_ingot"},
	}
},true)

workbench.register_craft({
	output = "powerguns:pistol",
	recipe = {
		{item_steel, "powerguns:gun_power_core", item_steel},
		{"powerguns:gunsteel_ingot", "powerguns:gunsteel_ingot", "powerguns:gunsteel_ingot"},
		{item_steel},
	}
})

workbench.register_craft({
	output = "powerguns:forcegun",
	recipe = {
		{"powerguns:gunsteel_ingot", item_diamond.." 9", item_mese.." 9"},
		{"powerguns:gunsteel_ingot", "powerguns:gunsteel_ingot", "powerguns:gunsteel_ingot"},
		{"powerguns:gun_power_core", item_steel},
	}
})

workbench.register_craft({
	output = "powerguns:rifle",
	recipe = {
		{"powerguns:ultra_gunsteel_ingot", "powerguns:gun_power_core", "powerguns:ultra_gunsteel_ingot"},
		{"powerguns:gun_power_core", "powerguns:ultra_gunsteel_ingot", item_gold},
		{item_gold, item_mese.." 9", "powerguns:ultra_gunsteel_ingot"},
	}
})

workbench.register_craft({
	output = "powerguns:shotgun",
	recipe = {
		{"powerguns:ultra_gunsteel_ingot", "powerguns:gun_power_core", "powerguns:ultra_gunsteel_ingot"},
		{"powerguns:gun_power_core", "powerguns:gun_power_core", "powerguns:ultra_gunsteel_ingot"},
		{"powerguns:ultra_gunsteel_ingot", "powerguns:ultra_gunsteel_ingot"},
	}
})

workbench.register_craft({
	output = "powerguns:generator",
	recipe = {
		{item_gold, item_gold, item_gold},
		{"powerguns:gunsteel_ingot", "powerguns:gun_power_core", "powerguns:gunsteel_ingot"},
		{"powerguns:gunsteel_ingot", "powerguns:gunsteel_ingot", "powerguns:gunsteel_ingot"},
	}
})

core.register_craft({
	output = "powerguns:workbench",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_steel, item_diamond, item_steel},
		{item_steel, item_steel, item_steel},
	}
})

