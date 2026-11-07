minetest.register_craftitem("components:wire_steel", {
	description = modComponents.translate("Steel Wire"),
	inventory_image = "obj_wire_steel_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:wire_copper", {
	description = modComponents.translate("Copper Wire"),
	inventory_image = "obj_wire_copper_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:wire_gold", {
	description = modComponents.translate("Gold Wire"),
	inventory_image = "obj_wire_gold_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:steel_spiral", {
	description = modComponents.translate("Steel Spiral"),
	inventory_image = "obj_steel_spiral_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:eletric_lamp", {
	description = modComponents.translate("Eletric Lamp"),
	inventory_image = "obj_eletric_lamp_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:gauge", {
	description = modComponents.translate("Gauge"),
	inventory_image = "obj_gauge_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:cylinder", {
	description = modComponents.translate("Cylinder"),
	inventory_image = "obj_cylinder_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:steel_pipe", {
	description = modComponents.translate("Steel Pipe"),
	inventory_image = "obj_steel_pipe_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:steel_core", {
	description = modComponents.translate("Steel Core"),
	inventory_image = "obj_steel_core_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:copper_coil", {
	description = modComponents.translate("Copper Coil"),
	inventory_image = "obj_copper_coil_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:eletric_pump", {
	description = modComponents.translate("Eletric Pump"),
	inventory_image = "obj_eletric_pump_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:bioresin", {
	description = core.colorize("#00FF00", 
		modComponents.translate("Bioresin")
	)
	.."\n * "..modComponents.translate("Extracted from pine wood."),
	inventory_image = "obj_bioresin_16.png",
})
--########################################################################################################################
minetest.register_craftitem("components:bioplastic_mass", {
	description = modComponents.translate("Bioplastic Mass"),
	inventory_image = "obj_bioplastic_mass_16.png",
})
--########################################################################################################################
minetest.register_craftitem("components:bioplastic_ingot", {
	description = modComponents.translate("Bioplastic Ingot"),
	inventory_image = "obj_bioplastic_ingot_16.png",
})
--########################################################################################################################
minetest.register_craftitem("components:speaker", {
	description = modComponents.translate("Speaker"),
	inventory_image = "obj_speaker_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:printed_circuit", {
	description = modComponents.translate("Printed Circuit"),
	inventory_image = "obj_printed_circuit_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:oxigen_system", {
	description = modComponents.translate("Oxigen System"),
	inventory_image = "obj_oxigen_system_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:switch_button", {
	description = modComponents.translate("Switch Button"),
	inventory_image = "obj_switch_button_on_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:panel", {
	description = modComponents.translate("Panel"),
	inventory_image = "obj_panel_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:pilot_manche", {
	description = modComponents.translate("Pilot Manche"),
	inventory_image = "obj_pilot_manche_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:upholstered_chair", {
	description = modComponents.translate("Upholstered Chair"),
	inventory_image = "obj_upholstered_chair_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:steel_ring", {
	description = modComponents.translate("Steel Ring"),
	inventory_image = "obj_steel_ring_32.png",
})
--########################################################################################################################
minetest.register_craftitem("components:copper_coil_toroidal", {
	description = modComponents.translate("Toroidal Copper Coil"),
	inventory_image = "obj_cooper_coil_toroidal_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:ballon_dirigible", {
	description = modComponents.translate("Balloon (for Dirigible)"),
	inventory_image = "obj_ballon_dirigible_128.png",
})
--########################################################################################################################
minetest.register_craftitem("components:helice_blades_4", {
	description = modComponents.translate("Helice (4 blades)"),
	inventory_image = "obj_helice_blades4_128.png",
})
--########################################################################################################################
minetest.register_craftitem("components:storage_fuel_50L", {
	description = modComponents.translate("Fuel Storage (50 liters)"),
	inventory_image = "obj_fuel_storage_50L_128.png",
})
--########################################################################################################################
minetest.register_craftitem("components:engine_combustion", {
	description = core.colorize("#00FF00", 
		modComponents.translate("Combustion Engine")
	)
	.."\n * "..modComponents.translate("Engine for producing torque from controlled explosions of fuel and oxygen inside a chamber."),
	inventory_image = "obj_engine_combustion_128.png",
})
--########################################################################################################################
minetest.register_craftitem("components:microwave_resonance_chamber", {
	description = modComponents.translate("Microwave Resonance Chamber"),
	inventory_image = "obj_microwave_resonance_chamber_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:engine_emdrive", {
	description = core.colorize("#00FF00", 
		modComponents.translate("Emdrive Engine")
	)
	.."\n * "..modComponents.translate("Engine for producing impulse from an electromagnetic field within a cavity, without the need to eject mass."),
	inventory_image = "obj_engine_emdrive_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:cockpit", {
	description = modComponents.translate("Cockpit"),
	inventory_image = "obj_cockpit_128.png",
})
--########################################################################################################################
minetest.register_craftitem("components:microprocessor", {
	description = modComponents.translate("Microprocessor"),
	inventory_image = "obj_microprocessor_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:power_cell", {
	description = modComponents.translate("Power Cell (Type Omega)"),
	inventory_image = "obj_power_cell_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:batery", {
	description = modComponents.translate("Batery (Type D)"),
	inventory_image = "obj_batery_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:resistance_electrical", {
	description = modComponents.translate("Electrical Resistance"),
	inventory_image = "obj_resistor_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:capacitor", {
	description = modComponents.translate("Capacitor"),
	inventory_image = "obj_capacitor_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:ram_memory", {
	description = modComponents.translate("RAM Memory"),
	inventory_image = "obj_ram_memory_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:dna_checker", {
	description = modComponents.translate("DNA Checker"),
	description = core.colorize("#00FF00", 
		modComponents.translate("DNA Checker")
	)
	.."\n * "..modComponents.translate(
		"It allows an electronic device to check its owner."
	),
	inventory_image = "obj_dna_checker_96.png",
})
--########################################################################################################################
minetest.register_craftitem("components:computer", {
	description = core.colorize("#00FF00", 
		modComponents.translate("Computer")
	)
	.."\n * "..modComponents.translate(
		"An embedded system is a microprocessor system in which the computer is completely encapsulated or dedicated to the device or system it controls."
	),
	inventory_image = "obj_computer_128.png",
})
--########################################################################################################################
minetest.register_craftitem("components:quartzo_crystal_pink", {
	description = modComponents.translate("Pink Quartzo Crystal"),
	inventory_image = "obj_quartzo_crystal_pink_64.png",
})
--########################################################################################################################
minetest.register_craftitem("components:transistor", {
	description = modComponents.translate("Transistor"),
	inventory_image = "obj_transistor_96.png",
})
--########################################################################################################################
--[[
minetest.register_craftitem("components:artif_inteligency", {
	description = core.colorize("#00FF00", 
		modComponents.translate("Upgrade - Artificial Inteligency")
	)
	.."\n * "..modComponents.translate("Allows to your UFO talk to you."),
	groups = {upgrades=1},
	inventory_image = "obj_artif_inteligency_96.png",
})
--]]
--########################################################################################################################
--[[
minetest.register_craftitem("components:ionized_bioresin", {
	--description = minetest.formspec_escape(modComponents.translate("Ionized Bioresin")),
	description = "Ionized Bioresin",
	inventory_image = "obj_ionized_bioresin_32.png",
})
minetest.register_alias("ionizedbioresin","components:ionized_bioresin")
minetest.register_alias(modComponents.translate("ionizedbioresin"),"components:ionized_bioresin")
--]]
--########################################################################################################################
