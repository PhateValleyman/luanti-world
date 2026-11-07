local shared = ...
local S = shared.S

local workbench = assert(loadfile(core.get_modpath(core.get_current_modname()) .. "/workbench.lua"))(S("Rifles Workbench"))
local item_diamond = "default:diamond"
local item_gold = "default:gold_ingot"
local item_steel = "default:steel_ingot"
local item_coal = "default:coal_lump"
local item_tin = "default:tin_ingot"
local item_mese = "default:mese_crystal"
local item_bronze = "default:bronze_ingot"
local item_copper = "default:copper_ingot"
local item_fragment = "default:mese_crystal_fragment"
local item_gunpowder = "tnt:gunpowder"

if core.get_modpath("mcl_core") then
	item_diamond = "mcl_core:diamond"
	item_gold = "mcl_core:gold_ingot"
	item_steel = "mcl_core:iron_ingot"
	item_coal = "mcl_core:coal_lump"
	item_tin = "mcl_core:lapis"
	item_mese = "mcl_nether:netherite_ingot"
	item_bronze = "mcl_core:emerald"
	item_copper = "mcl_copper:copper_ingot"
	item_fragment = "mesecons:mesecon"
	item_gunpowder = "mcl_mobitems:gunpowder"
end

workbench.register_craft({
	output = "rifles:gunsteel_ingot",
	recipe = {
		{item_steel, item_tin, item_coal},
	}
},true)
workbench.register_craft({
	output = "rifles:ultra_gunsteel_ingot",
	recipe = {
		{item_mese},
		{item_gold, "rifles:gunsteel_ingot", item_gold},
		{item_diamond},
	}
},true)
workbench.register_craft({
	output = "rifles:plastic_sheet",
	recipe = {
		{"group:tree", item_coal, "group:tree"},
		{item_coal, "group:tree", item_coal},
	}
},true)

workbench.register_craft({
	output = "rifles:aa12",
	recipe = {
		{"rifles:gunsteel_ingot", item_steel, item_steel},
		{item_diamond.." 9", item_steel, "rifles:plastic_sheet"},
		{item_steel, "rifles:plastic_sheet"},
	}
})
workbench.register_craft({
	output = "rifles:ak47",
	recipe = {
		{item_diamond, item_steel, "group:tree"},
		{"group:tree", item_mese.." 9", item_steel},
		{item_steel, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:awp",
	recipe = {
		{"rifles:gunsteel_ingot", item_diamond.." 9", "rifles:gunsteel_ingot"},
		{"rifles:gunsteel_ingot", "rifles:gunsteel_ingot", "rifles:gunsteel_ingot"},
		{item_diamond, "rifles:plastic_sheet"},
	}
})
workbench.register_craft({
	output = "rifles:benelli",
	recipe = {
		{"rifles:gunsteel_ingot", item_diamond, item_steel},
		{"rifles:plastic_sheet", item_diamond, item_steel},
		{item_mese},
	}
})
workbench.register_craft({
	output = "rifles:beretta",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_mese, "rifles:plastic_sheet"},
		{"rifles:plastic_sheet"},
	}
})
workbench.register_craft({
	output = "rifles:m1991",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_mese, "group:tree"},
		{"group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:deagle",
	recipe = {
		{"rifles:gunsteel_ingot", "rifles:gunsteel_ingot", "rifles:gunsteel_ingot"},
		{"rifles:gunsteel_ingot", item_diamond, "rifles:plastic_sheet"},
		{"rifles:plastic_sheet"},
	}
})
workbench.register_craft({
	output = "rifles:python",
	recipe = {
		{"rifles:gunsteel_ingot", "rifles:gunsteel_ingot", "rifles:gunsteel_ingot"},
		{item_diamond, "group:tree"},
		{item_mese, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:g36",
	recipe = {
		{item_diamond, item_mese.." 9", item_diamond},
		{item_steel, item_diamond, item_steel},
		{item_steel, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:glock17",
	recipe = {
		{"rifles:plastic_sheet", "rifles:plastic_sheet", "rifles:plastic_sheet"},
		{item_steel, item_steel, item_steel},
		{item_diamond, "rifles:plastic_sheet"},
	}
})
workbench.register_craft({
	output = "rifles:jackhammer",
	recipe = {
		{"rifles:gunsteel_ingot", "rifles:gunsteel_ingot"},
		{item_mese.." 9", item_steel.." 9", item_diamond.." 9"},
		{item_mese.." 9", item_diamond.." 9"},
	}
})
workbench.register_craft({
	output = "rifles:kriss",
	recipe = {
		{"rifles:plastic_sheet", "rifles:plastic_sheet", "rifles:plastic_sheet"},
		{item_gold, item_mese, "rifles:plastic_sheet"},
		{"rifles:plastic_sheet", item_gold},
	}
})
workbench.register_craft({
	output = "rifles:luger",
	recipe = {
		{item_fragment},
		{item_steel, item_steel, item_steel},
		{item_fragment, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:m16",
	recipe = {
		{item_diamond, item_steel.." 9", item_steel},
		{item_steel, item_diamond, item_steel},
		{item_steel, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:m60",
	recipe = {
		{item_diamond, item_mese.." 9", item_mese.." 9"},
		{item_steel, item_steel.." 9", item_steel.." 9"},
		{item_diamond, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:m79",
	recipe = {
		{item_steel, item_mese},
		{item_steel.." 9", item_diamond, "group:tree"},
		{"group:tree", "group:tree", "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:m200",
	recipe = {
		{item_diamond.." 9", item_steel, item_diamond.." 9"},
		{item_steel, item_steel, item_steel},
		{item_steel, item_diamond, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:makarov",
	recipe = {
		{item_steel, item_steel},
		{item_fragment, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:milkor",
	recipe = {
		{item_diamond, item_steel, item_diamond},
		{item_steel, item_steel.." 9", item_steel},
		{item_steel, item_mese.." 9", item_steel},
	}
})
workbench.register_craft({
	output = "rifles:minigun",
	recipe = {
		{item_steel.." 9", item_mese.." 9"},
		{item_diamond.." 9", item_diamond.." 9", item_diamond.." 9"},
		{item_steel.." 9", item_steel.." 9", item_steel.." 9"},
	}
})
workbench.register_craft({
	output = "rifles:mp5",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_steel, item_diamond, item_steel},
		{item_steel, "rifles:plastic_sheet"},
	}
})
workbench.register_craft({
	output = "rifles:thompson",
	recipe = {
		{item_steel, item_steel, item_diamond},
		{"group:tree", "group:tree", item_steel},
		{item_steel, item_diamond, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:mp40",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_steel, item_mese, item_steel},
		{item_steel, item_fragment},
	}
})

workbench.register_craft({
	output = "rifles:remington",
	recipe = {
		{item_steel, item_steel, item_steel},
		{"group:tree", item_mese, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:rpg",
	recipe = {
		{item_diamond, item_steel},
		{item_steel.." 9", "group:tree", item_diamond.." 9"},
		{item_diamond, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:rpk",
	recipe = {
		{item_diamond, "rifles:ak47"},
		{item_steel, item_steel.." 9", "group:tree"},
		{item_diamond, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:scar",
	recipe = {
		{item_diamond, item_mese.." 9", item_mese.." 9"},
		{item_steel, item_steel, item_mese.." 9"},
		{"rifles:plastic_sheet", item_mese},
	}
})
workbench.register_craft({
	output = "rifles:spas12",
	recipe = {
		{item_steel, item_steel},
		{item_steel, item_mese.." 9", item_diamond},
		{"rifles:plastic_sheet", item_diamond, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:svd",
	recipe = {
		{item_steel, item_diamond.." 9", item_steel},
		{item_steel, item_steel, item_steel},
		{"group:tree", item_diamond, "group:tree"},
	}
})
workbench.register_craft({
	output = "rifles:taurus",
	recipe = {
{"rifles:gunsteel_ingot", item_mese, item_fragment},
{"rifles:gunsteel_ingot", item_diamond.." 9", "rifles:gunsteel_ingot"},
		{"rifles:gunsteel_ingot", "rifles:plastic_sheet"},
	}
})
workbench.register_craft({
	output = "rifles:tec9",
	recipe = {
		{"rifles:plastic_sheet", "rifles:plastic_sheet", "rifles:plastic_sheet"},
		{item_steel, item_steel, item_steel},
		{item_steel, item_fragment, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:tmp",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_steel, item_fragment, item_steel},
		{item_steel},
	}
})
workbench.register_craft({
	output = "rifles:ump",
	recipe = {
		{item_steel, item_steel, item_steel},
		{"rifles:gunsteel_ingot", item_diamond, item_diamond},
		{item_steel, item_mese, item_steel},
	}
})
workbench.register_craft({
	output = "rifles:uzi",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_diamond, "rifles:plastic_sheet", item_steel},
		{item_steel},
	}
})

workbench.register_craft({
	output = "rifles:grenade",
	recipe = {
		{item_fragment},
		{item_steel, item_gunpowder},
		{item_gunpowder, item_gunpowder},
	}
})

workbench.register_craft({
	output = "rifles:smoke_grenade",
	recipe = {
		{item_gunpowder},
		{item_steel, item_gunpowder},
		{item_gunpowder, item_gunpowder},
	}
})

workbench.register_craft({
	output = "rifles:9mm 40",
	recipe = {
		{item_steel},
		{item_gunpowder},
		{item_copper},
	}
})
workbench.register_craft({
	output = "rifles:762mm 50",
	recipe = {
		{item_bronze, item_gunpowder, item_bronze},
		{item_gold, item_gunpowder, item_gold},
		{item_gold, item_gunpowder, item_gold},
	}
})
workbench.register_craft({
	output = "rifles:408ct 10",
	recipe = {
		{item_bronze, item_gunpowder, item_bronze},
		{item_gold, item_gold, item_gold},
		{item_gold, item_gunpowder, item_gold},
	}
})
workbench.register_craft({
	output = "rifles:556mm 90",
	recipe = {
		{item_gold},
		{item_gold, item_gunpowder, item_gold},
		{item_gold, item_gunpowder, item_gold},
	}
})
workbench.register_craft({
	output = "rifles:shell 12",
	recipe = {
		{item_bronze, item_steel, item_bronze},
		{item_bronze, item_gunpowder, item_bronze},
		{item_gold, item_gunpowder, item_gold},
	}
})
workbench.register_craft({
	output = "rifles:40mm 5",
	recipe = {
		{item_gold},
		{item_steel, item_gunpowder, item_steel},
		{item_gunpowder, item_bronze, item_gunpowder},
	}
})
workbench.register_craft({
	output = "rifles:rocket 1",
	recipe = {
		{"rifles:40mm"},
		{item_gunpowder},
		{item_steel},
	}
})

core.register_craft({
	output = "rifles:workbench",
	recipe = {
		{item_steel, item_steel, item_steel},
		{item_steel, item_gunpowder, item_steel},
		{item_steel, item_steel, item_steel},
	}
})