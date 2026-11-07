minetest.register_craft({
	output = "components:steel_core",
	recipe = {
		{"default:steel_ingot",		"default:steel_ingot", 		"default:steel_ingot"},
		{"",		 						"default:steelblock", 		""},
		{"default:steel_ingot", 	"default:steel_ingot",		"default:steel_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:wire_steel",
	recipe = {
		{"", 								"",							"default:steel_ingot"},
		{"", 								"default:steel_ingot", 	""},
		{"components:steel_core",	"", 							""}
	},
	replacements = {
	   {"components:steel_core", "components:steel_core"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:wire_copper",
	recipe = {
		{"",								"",					 			"default:copper_ingot"},
		{"",								"default:copper_ingot", 	""},
		{"components:steel_core",	"",								""}
	},
	replacements = {
	   {"components:steel_core", "components:steel_core"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:wire_gold",
	recipe = {
		{"",								"",					 			"default:gold_ingot"},
		{"",								"default:gold_ingot", 	""},
		{"components:steel_core",	"",								""}
	},
	replacements = {
	   {"components:steel_core", "components:steel_core"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:steel_spiral",
	recipe = {
		{"", "components:wire_steel", ""},
		{"components:wire_steel", "", "components:wire_steel"},
		{"", "components:wire_steel", ""}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:eletric_lamp",
	recipe = {
		{"default:glass",		"default:glass", 				""},
		{"default:glass", 	"default:mese_crystal", 	"default:glass"},
		{"", 						"default:glass", 				"components:steel_spiral"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:gauge",
	recipe = {
		{"default:glass",		"default:glass", 			"default:stick"},
		{"default:glass", 	"default:steel_ingot", 	"default:glass"},
		{"default:glass", 	"default:glass",			"default:glass"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:cylinder",
	recipe = {
		{"components:gauge",				"", 		""},
		{"default:steelblock", 	"", 		""},
		{"default:steelblock", 	"",		""}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:steel_pipe",
	recipe = {
		{"default:steel_ingot",		"", 	"default:steel_ingot"},
		{"default:steel_ingot", 	"", 	"default:steel_ingot"},
		{"default:steel_ingot", 	"",		"default:steel_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:copper_coil",
	recipe = {
		{"components:wire_copper", 	"components:steel_core",	"components:wire_copper"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:eletric_pump",
	recipe = {
		{"components:wire_copper",		"components:capacitor",			"components:steel_pipe"},
		{"components:switch_button",	"components:copper_coil",		"default:steelblock"},
		{"components:wire_copper",		"components:printed_circuit",	"components:steel_pipe"}
	}
})
--########################################################################################################################
minetest.register_craft({
	type = "shapeless",
	output = "components:bioplastic_mass",
	recipe = {"components:bioresin",	"default:coal_lump"}
})
--########################################################################################################################
minetest.register_craft({
    type = "cooking",
    output = "components:bioplastic_ingot",
    recipe = "components:bioplastic_mass",
    cooktime = 10,
})
--########################################################################################################################
minetest.register_craft({
	output = "components:speaker",
	recipe = {
		{"default:paper",	"components:bioplastic_ingot",	"components:bioplastic_ingot"},
		{"", 			"default:paper", 		"components:copper_coil"},
		{"default:paper", 	"components:bioplastic_ingot",	"components:bioplastic_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:printed_circuit",
	recipe = {
		{"default:copper_ingot",	"components:bioplastic_ingot", 	"default:copper_ingot"},
		{"components:bioplastic_ingot", 	"default:copper_ingot", 	"components:bioplastic_ingot"},
		{"default:copper_ingot", 	"components:bioplastic_ingot",	"default:copper_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	type = "shapeless",
	output = "components:oxigen_system",
	recipe = {"components:cylinder",	"components:eletric_pump", 	"components:printed_circuit"}

})
--########################################################################################################################
minetest.register_craft({
	output = "components:switch_button",
	recipe = {
		{"default:steel_ingot",			"", 								""},
		{"components:bioplastic_ingot", 		"components:bioplastic_ingot", 	"components:bioplastic_ingot"},
		{"components:wire_copper", 			"default:copper_ingot",		"components:wire_copper"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:panel",
	recipe = {
		{"components:gauge",					"components:gauge", 					"components:gauge"},
		{"components:switch_button", 		"components:switch_button", 		"components:switch_button"},
		{"components:speaker", 				"components:computer",				"keys:skeleton_key"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:pilot_manche",
	recipe = {
		{"components:bioplastic_ingot",	"", 								"components:bioplastic_ingot"},
		{"default:steel_ingot", 	"default:steelblock", 		"default:steel_ingot"},
		{"", 								"default:steelblock",		""}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:upholstered_chair",
	recipe = {
		{"",	"", 				"wool:red"},
		{"", 	"", 				"wool:red"},
		{"", 	"wool:red",		"default:steel_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:steel_ring",
	recipe = {
		{"",								"default:steel_ingot", 	""},
		{"default:steel_ingot", 	"",						 	"default:steel_ingot"},
		{"",							 	"default:steel_ingot",	""}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:copper_coil_toroidal",
	recipe = {
		{"",		"components:wire_copper", 	""},
		{"components:wire_copper", 	"components:steel_ring", 	"components:wire_copper"},
		{"", 	"components:wire_copper",	""}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:microwave_resonance_chamber",
	recipe = {
		{"default:steel_ingot",		"components:copper_coil",		 	"default:steel_ingot"},
		{"default:steel_ingot", 	"default:mese_crystal", 	"default:steel_ingot"},
		{"default:steel_ingot", 	"components:copper_coil",			"default:steel_ingot"}
	}
})
--########################################################################################################################

minetest.register_craft({
	output = "components:ballon_dirigible",
	recipe = {
		{"wool:white",		"wool:white", 		"wool:dark_green"},
		{"wool:white",		"wool:white", 		"wool:white"},
		{"wool:white",		"wool:white", 		"wool:dark_green"},
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:helice_blades_4",
	recipe = {
		{"default:steel_ingot",		"", 							"default:steel_ingot"},
		{"",								"default:steelblock", 	""},
		{"default:steel_ingot",		"", 							"default:steel_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:storage_fuel_50L",
	recipe = {
		{"components:steel_ring",			"components:bioplastic_ingot", 	"components:bioplastic_ingot"},
		{"components:bioplastic_ingot",	"", 										"components:bioplastic_ingot"},
		{"components:bioplastic_ingot",	"components:bioplastic_ingot", 	"components:bioplastic_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:engine_combustion",
	recipe = {
		{"components:steel_ring",	"components:eletric_pump", "components:printed_circuit"},
		{"components:steel_pipe", 	"components:steel_ring", 	"default:steel_ingot"},
		{"components:steel_ring", 	"default:steelblock",		"components:power_cell"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:engine_emdrive",
	recipe = {
		{"default:steel_ingot",		"default:steel_ingot", 	"components:printed_circuit"},
		{"", 								"default:steel_ingot", 	"components:microwave_resonance_chamber"},
		{"default:steel_ingot", 	"default:steel_ingot",	"components:power_cell"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:microprocessor",
	recipe = {
		{"components:bioplastic_ingot",	"components:wire_gold",		"components:bioplastic_ingot"},
		{"components:bioplastic_ingot", 	"default:diamond",			"components:bioplastic_ingot"},
		{"components:bioplastic_ingot", 	"components:wire_gold",		"components:bioplastic_ingot"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:power_cell",
	recipe = {
		{"default:steelblock",		"default:steelblock", 		"default:steelblock"},
		{"components:batery", 				"components:batery", 				"components:batery"},
		{"default:diamondblock", 	"default:diamondblock",		"default:diamondblock"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:batery",
	recipe = {
		{"default:obsidian_glass",		"default:tin_ingot", 		"default:obsidian_glass"},
		{"default:obsidian_glass", 	"components:bioresin", 				"default:obsidian_glass"},
		{"default:obsidian_glass", 	"default:copper_ingot",		"default:obsidian_glass"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:resistance_electrical",
	recipe = {
		{"",								"components:bioplastic_ingot", 	"components:wire_copper"},
		{"components:bioplastic_ingot", 	"default:coalblock",			"components:bioplastic_ingot"},
		{"components:wire_copper", 		"components:bioplastic_ingot",	""}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:capacitor",
	recipe = {
		{"components:bioplastic_ingot",	"default:paper", 	"components:bioplastic_ingot"},
		{"components:bioplastic_ingot", 	"default:paper", 	"components:bioplastic_ingot"},
		{"components:wire_steel", 			"",					"components:wire_steel"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:ram_memory",
	recipe = {
		{"components:switch_button",		"components:switch_button", 	"components:switch_button"},
		{"components:microprocessor", 	"components:microprocessor", 	"components:microprocessor"},
		{"components:printed_circuit", 	"components:printed_circuit",	"components:printed_circuit"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:dna_checker",
	recipe = {
		{"default:obsidian_glass",			"default:diamond", 						"default:obsidian_glass"},
		{"components:wire_gold", 			"components:copper_coil_toroidal",	"components:wire_gold"},
		{"components:printed_circuit", 	"components:printed_circuit",			"components:printed_circuit"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:computer",
	recipe = {
		{"components:resistance_electrical",	"components:copper_coil_toroidal",		"components:capacitor"},
		{"components:dna_checker",				 	"components:microprocessor", 				"components:switch_button"},
		{"components:wire_copper",					"components:printed_circuit",				"components:ram_memory"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:transistor",
	recipe = {
		{"components:bioplastic_ingot",	"components:bioplastic_ingot",		"components:bioplastic_ingot"},
		{"components:capacitor",			"components:quartzo_crystal_pink",	"components:resistance_electrical"},
		{"components:wire_steel",			"components:wire_steel",				"components:wire_steel"}
	}
})
--########################################################################################################################
minetest.register_craft({
	output = "components:cockpit",
	recipe = {
		{"components:panel",				"components:eletric_lamp",			"components:storage_fuel_50L"},
		{"components:pilot_manche", 	"components:upholstered_chair", 	"components:oxigen_system"},
		{"default:steel_ingot", 		"default:steelblock",				"default:steel_ingot"}
	}
})
--########################################################################################################################
--[[
minetest.register_craft({
	output = "components:artif_inteligency",
	recipe = {
		{"components:copper_coil_toroidal",		"flowers:mushroom_red",		"components:copper_coil_toroidal"},
		{"components:microprocessor",				"default:diamond",			"components:transistor"},
		{"components:capacitor",					"components:bioplastic_ingot",	"components:resistance_electrical"}
	}
})
--]]
--########################################################################################################################
--[[
minetest.register_craft({
	output = "components:ionized_bioresin 9",
	recipe = {
		{"components:bioresin",	"components:bioresin",			"components:bioresin"},
		{"components:bioresin", 	"default:mese_crystal_fragment", 	"components:bioresin"},
		{"components:bioresin", 	"components:bioresin",			"components:bioresin"}
	}
})
minetest.register_alias("ionizedbioresin","components:ionized_bioresin")
minetest.register_alias(modComponents.translate("ionizedbioresin"),"components:ionized_bioresin")
--]]
--########################################################################################################################

