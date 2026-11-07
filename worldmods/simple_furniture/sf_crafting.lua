-- simple_furniture/sf_crafting.lua

-- These Are The Crafting Recipes For The Mod
-- Apple Wood Bench
minetest.register_craft({
	output = "simple_furniture:apple_wood_bench",
	recipe = {
		{"", "", "stairs:slab_wood"},
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood"},
		{"stairs:slab_wood", "", "stairs:slab_wood"},
	}
})

-- Apple Wood Cabinet
minetest.register_craft({
	output = "simple_furniture:apple_wood_cabinet",
	recipe = {
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood"},
		{"doors:trapdoor", "stairs:slab_wood", "doors:trapdoor"},
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood"},
	}
})

-- Apple Wood Chair
minetest.register_craft({
	output = "simple_furniture:apple_wood_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood"},
		{"default:stick", "", "default:stick"},
	}
})

-- Apple Wood Dining Table
minetest.register_craft({
	output = "simple_furniture:apple_wood_dining_table",
	recipe = {
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood"},
		{"", "default:stick", ""},
		{"", "stairs:slab_wood", ""},
	}
})

-- Apple Wood End Table
minetest.register_craft({
	output = "simple_furniture:apple_wood_end_table",
	recipe = {
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Aspen Wood Bench
minetest.register_craft({
	output = "simple_furniture:aspen_wood_bench",
	recipe = {
		{"", "", "stairs:slab_aspen_wood"},
		{"stairs:slab_aspen_wood", "stairs:slab_aspen_wood", "stairs:slab_aspen_wood"},
		{"stairs:slab_aspen_wood", "", "stairs:slab_aspen_wood"},
	}
})

-- Aspen Wood Cabinet
minetest.register_craft({
	output = "simple_furniture:aspen_wood_cabinet",
	recipe = {
		{"stairs:slab_aspen_wood", "stairs:slab_aspen_wood", "stairs:slab_aspen_wood"},
		{"doors:trapdoor", "stairs:slab_aspen_wood", "doors:trapdoor"},
		{"stairs:slab_aspen_wood", "stairs:slab_aspen_wood", "stairs:slab_aspen_wood"},
	}
})

-- Aspen Wood Chair
minetest.register_craft({
	output = "simple_furniture:aspen_wood_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_aspen_wood", "stairs:slab_aspen_wood", "stairs:slab_aspen_wood"},
		{"default:stick", "", "default:stick"},
	}
})

-- Aspen Wood Dining Table
minetest.register_craft({
	output = "simple_furniture:aspen_wood_dining_table",
	recipe = {
		{"stairs:slab_aspen_wood", "stairs:slab_aspen_wood", "stairs:slab_aspen_wood"},
		{"", "default:stick", ""},
		{"", "stairs:slab_aspen_wood", ""},
	}
})

-- Aspen Wood End Table
minetest.register_craft({
	output = "simple_furniture:aspen_wood_end_table",
	recipe = {
		{"stairs:slab_aspen_wood", "stairs:slab_aspen_wood", "stairs:slab_aspen_wood"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Pine Wood Bench
minetest.register_craft({
	output = "simple_furniture:pine_wood_bench",
	recipe = {
		{"", "", "stairs:slab_pine_wood"},
		{"stairs:slab_pine_wood", "stairs:slab_pine_wood", "stairs:slab_pine_wood"},
		{"stairs:slab_pine_wood", "", "stairs:slab_pine_wood"},
	}
})

-- Pine Wood Cabinet
minetest.register_craft({
	output = "simple_furniture:pine_wood_cabinet",
	recipe = {
		{"stairs:slab_pine_wood", "stairs:slab_pine_wood", "stairs:slab_pine_wood"},
		{"doors:trapdoor", "stairs:slab_pine_wood", "doors:trapdoor"},
		{"stairs:slab_pine_wood", "stairs:slab_pine_wood", "stairs:slab_pine_wood"},
	}
})

-- Pine Wood Chair
minetest.register_craft({
	output = "simple_furniture:pine_wood_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_pine_wood", "stairs:slab_pine_wood", "stairs:slab_pine_wood"},
		{"default:stick", "", "default:stick"},
	}
})

-- Pine Wood Dining Table
minetest.register_craft({
	output = "simple_furniture:pine_wood_dining_table",
	recipe = {
		{"stairs:slab_pine_wood", "stairs:slab_pine_wood", "stairs:slab_pine_wood"},
		{"", "default:stick", ""},
		{"", "stairs:slab_pine_wood", ""},
	}
})

-- Pine Wood End Table
minetest.register_craft({
	output = "simple_furniture:pine_wood_end_table",
	recipe = {
		{"stairs:slab_pine_wood", "stairs:slab_pine_wood", "stairs:slab_pine_wood"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Jungle Wood Bench
minetest.register_craft({
	output = "simple_furniture:jungle_wood_bench",
	recipe = {
		{"", "", "stairs:slab_junglewood"},
		{"stairs:slab_junglewood", "stairs:slab_junglewood", "stairs:slab_junglewood"},
		{"stairs:slab_junglewood", "", "stairs:slab_junglewood"},
	}
})

-- Jungle Wood Cabinet
minetest.register_craft({
	output = "simple_furniture:jungle_wood_cabinet",
	recipe = {
		{"stairs:slab_junglewood", "stairs:slab_junglewood", "stairs:slab_junglewood"},
		{"doors:trapdoor", "stairs:slab_junglewood", "doors:trapdoor"},
		{"stairs:slab_junglewood", "stairs:slab_junglewood", "stairs:slab_junglewood"},
	}
})

-- Jungle Wood Chair
minetest.register_craft({
	output = "simple_furniture:jungle_wood_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_junglewood", "stairs:slab_junglewood", "stairs:slab_junglewood"},
		{"default:stick", "", "default:stick"},
	}
})

-- Jungle Wood Dining Table
minetest.register_craft({
	output = "simple_furniture:jungle_wood_dining_table",
	recipe = {
		{"stairs:slab_junglewood", "stairs:slab_junglewood", "stairs:slab_junglewood"},
		{"", "default:stick", ""},
		{"", "stairs:slab_junglewood", ""},
	}
})

-- Jungle Wood End Table
minetest.register_craft({
	output = "simple_furniture:jungle_wood_end_table",
	recipe = {
		{"stairs:slab_junglewood", "stairs:slab_junglewood", "stairs:slab_junglewood"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Acacia Wood Bench
minetest.register_craft({
	output = "simple_furniture:acacia_wood_bench",
	recipe = {
		{"", "", "stairs:slab_acacia_wood"},
		{"stairs:slab_acacia_wood", "stairs:slab_acacia_wood", "stairs:slab_acacia_wood"},
		{"stairs:slab_acacia_wood", "", "stairs:slab_acacia_wood"},
	}
})

-- Acacia Wood Cabinet
minetest.register_craft({
	output = "simple_furniture:acacia_wood_cabinet",
	recipe = {
		{"stairs:slab_acacia_wood", "stairs:slab_acacia_wood", "stairs:slab_acacia_wood"},
		{"doors:trapdoor", "stairs:slab_acacia_wood", "doors:trapdoor"},
		{"stairs:slab_acacia_wood", "stairs:slab_acacia_wood", "stairs:slab_acacia_wood"},
	}
})

-- Acacia Wood Chair
minetest.register_craft({
	output = "simple_furniture:acacia_wood_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_acacia_wood", "stairs:slab_acacia_wood", "stairs:slab_acacia_wood"},
		{"default:stick", "", "default:stick"},
	}
})

-- Acacia Wood Dining Table
minetest.register_craft({
	output = "simple_furniture:acacia_wood_dining_table",
	recipe = {
		{"stairs:slab_acacia_wood", "stairs:slab_acacia_wood", "stairs:slab_acacia_wood"},
		{"", "default:stick", ""},
		{"", "stairs:slab_acacia_wood", ""},
	}
})

-- Acacia Wood End Table
minetest.register_craft({
	output = "simple_furniture:acacia_wood_end_table",
	recipe = {
		{"stairs:slab_acacia_wood", "stairs:slab_acacia_wood", "stairs:slab_acacia_wood"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Stone Bench
minetest.register_craft({
	output = "simple_furniture:stone_bench",
	recipe = {
		{"", "", "stairs:slab_stone"},
		{"stairs:slab_stone", "stairs:slab_stone", "stairs:slab_stone"},
		{"stairs:slab_stone", "", "stairs:slab_stone"},
	}
})

-- Stone Cabinet
minetest.register_craft({
	output = "simple_furniture:stone_cabinet",
	recipe = {
		{"stairs:slab_stone", "stairs:slab_stone", "stairs:slab_stone"},
		{"doors:trapdoor", "stairs:slab_stone", "doors:trapdoor"},
		{"stairs:slab_stone", "stairs:slab_stone", "stairs:slab_stone"},
	}
})

-- Stone Chair
minetest.register_craft({
	output = "simple_furniture:stone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_stone", "stairs:slab_stone", "stairs:slab_stone"},
		{"default:stick", "", "default:stick"},
	}
})

-- Stone Dining Table
minetest.register_craft({
	output = "simple_furniture:stone_dining_table",
	recipe = {
		{"stairs:slab_stone", "stairs:slab_stone", "stairs:slab_stone"},
		{"", "default:stick", ""},
		{"", "stairs:slab_stone", ""},
	}
})

-- Stone End Table
minetest.register_craft({
	output = "simple_furniture:stone_end_table",
	recipe = {
		{"stairs:slab_stone", "stairs:slab_stone", "stairs:slab_stone"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Desert Stone Bench
minetest.register_craft({
	output = "simple_furniture:desert_stone_bench",
	recipe = {
		{"", "", "stairs:slab_desert_stone"},
		{"stairs:slab_desert_stone", "stairs:slab_desert_stone", "stairs:slab_desert_stone"},
		{"stairs:slab_desert_stone", "", "stairs:slab_desert_stone"},
	}
})

-- Desert Stone Cabinet
minetest.register_craft({
	output = "simple_furniture:desert_stone_cabinet",
	recipe = {
		{"stairs:slab_desert_stone", "stairs:slab_desert_stone", "stairs:slab_desert_stone"},
		{"doors:trapdoor", "stairs:slab_desert_stone", "doors:trapdoor"},
		{"stairs:slab_desert_stone", "stairs:slab_desert_stone", "stairs:slab_desert_stone"},
	}
})

-- Desert Stone Chair
minetest.register_craft({
	output = "simple_furniture:desert_stone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_desert_stone", "stairs:slab_desert_stone", "stairs:slab_desert_stone"},
		{"default:stick", "", "default:stick"},
	}
})

-- Desert Stone Dining Table
minetest.register_craft({
	output = "simple_furniture:desert_stone_dining_table",
	recipe = {
		{"stairs:slab_desert_stone", "stairs:slab_desert_stone", "stairs:slab_desert_stone"},
		{"", "default:stick", ""},
		{"", "stairs:slab_desert_stone", ""},
	}
})

-- Desert Stone End Table
minetest.register_craft({
	output = "simple_furniture:desert_stone_end_table",
	recipe = {
		{"stairs:slab_desert_stone", "stairs:slab_desert_stone", "stairs:slab_desert_stone"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Sandstone Bench
minetest.register_craft({
	output = "simple_furniture:sandstone_bench",
	recipe = {
		{"", "", "stairs:slab_sandstone"},
		{"stairs:slab_sandstone", "stairs:slab_sandstone", "stairs:slab_sandstone"},
		{"stairs:slab_sandstone", "", "stairs:slab_sandstone"},
	}
})

-- Sandstone Cabinet
minetest.register_craft({
	output = "simple_furniture:sandstone_cabinet",
	recipe = {
		{"stairs:slab_sandstone", "stairs:slab_sandstone", "stairs:slab_sandstone"},
		{"doors:trapdoor", "stairs:slab_sandstone", "doors:trapdoor"},
		{"stairs:slab_sandstone", "stairs:slab_sandstone", "stairs:slab_sandstone"},
	}
})

-- Sandstone Chair
minetest.register_craft({
	output = "simple_furniture:sandstone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_sandstone", "stairs:slab_sandstone", "stairs:slab_sandstone"},
		{"default:stick", "", "default:stick"},
	}
})

-- Sandstone Dining Table
minetest.register_craft({
	output = "simple_furniture:sandstone_dining_table",
	recipe = {
		{"stairs:slab_sandstone", "stairs:slab_sandstone", "stairs:slab_sandstone"},
		{"", "default:stick", ""},
		{"", "stairs:slab_sandstone", ""},
	}
})

-- Sandstone End Table
minetest.register_craft({
	output = "simple_furniture:sandstone_end_table",
	recipe = {
		{"stairs:slab_sandstone", "stairs:slab_sandstone", "stairs:slab_sandstone"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Desert Sandstone Bench
minetest.register_craft({
	output = "simple_furniture:desert_sandstone_bench",
	recipe = {
		{"", "", "stairs:slab_desert_sandstone"},
		{"stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone"},
		{"stairs:slab_desert_sandstone", "", "stairs:slab_desert_sandstone"},
	}
})

-- Desert Sandstone Cabinet
minetest.register_craft({
	output = "simple_furniture:desert_sandstone_cabinet",
	recipe = {
		{"stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone"},
		{"doors:trapdoor", "stairs:slab_desert_sandstone", "doors:trapdoor"},
		{"stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone"},
	}
})

-- Desert Sandstone Chair
minetest.register_craft({
	output = "simple_furniture:desert_sandstone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone"},
		{"default:stick", "", "default:stick"},
	}
})

-- Desert Sandstone Dining Table
minetest.register_craft({
	output = "simple_furniture:desert_sandstone_dining_table",
	recipe = {
		{"stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone"},
		{"", "default:stick", ""},
		{"", "stairs:slab_desert_sandstone", ""},
	}
})

-- Desert Sandstone End Table
minetest.register_craft({
	output = "simple_furniture:desert_sandstone_end_table",
	recipe = {
		{"stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone", "stairs:slab_desert_sandstone"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Silver Sandstone Bench
minetest.register_craft({
	output = "simple_furniture:silver_sandstone_bench",
	recipe = {
		{"", "", "stairs:slab_silver_sandstone"},
		{"stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone"},
		{"stairs:slab_silver_sandstone", "", "stairs:slab_silver_sandstone"},
	}
})

-- Silver Sandstone Cabinet
minetest.register_craft({
	output = "simple_furniture:silver_sandstone_cabinet",
	recipe = {
		{"stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone"},
		{"doors:trapdoor", "stairs:slab_silver_sandstone", "doors:trapdoor"},
		{"stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone"},
	}
})

-- Silver Sandstone Chair
minetest.register_craft({
	output = "simple_furniture:silver_sandstone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone"},
		{"default:stick", "", "default:stick"},
	}
})

-- Silver Sandstone Dining Table
minetest.register_craft({
	output = "simple_furniture:silver_sandstone_dining_table",
	recipe = {
		{"stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone"},
		{"", "default:stick", ""},
		{"", "stairs:slab_silver_sandstone", ""},
	}
})

-- Silver Sandstone End Table
minetest.register_craft({
	output = "simple_furniture:silver_sandstone_end_table",
	recipe = {
		{"stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone", "stairs:slab_silver_sandstone"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Cobblestone Bench
minetest.register_craft({
	output = "simple_furniture:cobblestone_bench",
	recipe = {
		{"", "", "stairs:slab_cobble"},
		{"stairs:slab_cobble", "stairs:slab_cobble", "stairs:slab_cobble"},
		{"stairs:slab_cobble", "", "stairs:slab_cobble"},
	}
})

-- Cobblestone Cabinet
minetest.register_craft({
	output = "simple_furniture:cobblestone_cabinet",
	recipe = {
		{"stairs:slab_cobble", "stairs:slab_cobble", "stairs:slab_cobble"},
		{"doors:trapdoor", "stairs:slab_cobble", "doors:trapdoor"},
		{"stairs:slab_cobble", "stairs:slab_cobble", "stairs:slab_cobble"},
	}
})

-- Cobblestone Chair
minetest.register_craft({
	output = "simple_furniture:cobblestone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_cobble", "stairs:slab_cobble", "stairs:slab_cobble"},
		{"default:stick", "", "default:stick"},
	}
})

-- Cobblestone Dining Table
minetest.register_craft({
	output = "simple_furniture:cobblestone_dining_table",
	recipe = {
		{"stairs:slab_cobble", "stairs:slab_cobble", "stairs:slab_cobble"},
		{"", "default:stick", ""},
		{"", "stairs:slab_cobble", ""},
	}
})

-- Cobblestone End Table
minetest.register_craft({
	output = "simple_furniture:cobblestone_end_table",
	recipe = {
		{"stairs:slab_cobble", "stairs:slab_cobble", "stairs:slab_cobble"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Mossy Cobblestone Bench
minetest.register_craft({
	output = "simple_furniture:mossy_cobblestone_bench",
	recipe = {
		{"", "", "stairs:slab_mossycobble"},
		{"stairs:slab_mossycobble", "stairs:slab_mossycobble", "stairs:slab_mossycobble"},
		{"stairs:slab_mossycobble", "", "stairs:slab_mossycobble"},
	}
})

-- Mossy Cobblestone Cabinet
minetest.register_craft({
	output = "simple_furniture:mossy_cobblestone_cabinet",
	recipe = {
		{"stairs:slab_mossycobble", "stairs:slab_mossycobble", "stairs:slab_mossycobble"},
		{"doors:trapdoor", "stairs:slab_mossycobble", "doors:trapdoor"},
		{"stairs:slab_mossycobble", "stairs:slab_mossycobble", "stairs:slab_mossycobble"},
	}
})

-- Mossy Cobblestone Chair
minetest.register_craft({
	output = "simple_furniture:mossy_cobblestone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_mossycobble", "stairs:slab_mossycobble", "stairs:slab_mossycobble"},
		{"default:stick", "", "default:stick"},
	}
})

-- Mossy Cobblestone Dining Table
minetest.register_craft({
	output = "simple_furniture:mossy_cobblestone_dining_table",
	recipe = {
		{"stairs:slab_mossycobble", "stairs:slab_mossycobble", "stairs:slab_mossycobble"},
		{"", "default:stick", ""},
		{"", "stairs:slab_mossycobble", ""},
	}
})

-- Mossy Cobblestone End Table
minetest.register_craft({
	output = "simple_furniture:mossy_cobblestone_end_table",
	recipe = {
		{"stairs:slab_mossycobble", "stairs:slab_mossycobble", "stairs:slab_mossycobble"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Desert Cobblestone Bench
minetest.register_craft({
	output = "simple_furniture:desert_cobblestone_bench",
	recipe = {
		{"", "", "stairs:slab_desert_cobble"},
		{"stairs:slab_desert_cobble", "stairs:slab_desert_cobble", "stairs:slab_desert_cobble"},
		{"stairs:slab_desert_cobble", "", "stairs:slab_desert_cobble"},
	}
})

-- Desert Cobblestone Cabinet
minetest.register_craft({
	output = "simple_furniture:desert_cobblestone_cabinet",
	recipe = {
		{"stairs:slab_desert_cobble", "stairs:slab_desert_cobble", "stairs:slab_desert_cobble"},
		{"doors:trapdoor", "stairs:slab_desert_cobble", "doors:trapdoor"},
		{"stairs:slab_desert_cobble", "stairs:slab_desert_cobble", "stairs:slab_desert_cobble"},
	}
})

-- Desert Cobblestone Chair
minetest.register_craft({
	output = "simple_furniture:desert_cobblestone_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_desert_cobble", "stairs:slab_desert_cobble", "stairs:slab_desert_cobble"},
		{"default:stick", "", "default:stick"},
	}
})

-- Desert Cobblestone Dining Table
minetest.register_craft({
	output = "simple_furniture:desert_cobblestone_dining_table",
	recipe = {
		{"stairs:slab_desert_cobble", "stairs:slab_desert_cobble", "stairs:slab_desert_cobble"},
		{"", "default:stick", ""},
		{"", "stairs:slab_desert_cobble", ""},
	}
})

-- Desert Cobblestone End Table
minetest.register_craft({
	output = "simple_furniture:desert_cobblestone_end_table",
	recipe = {
		{"stairs:slab_desert_cobble", "stairs:slab_desert_cobble", "stairs:slab_desert_cobble"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Brick Bench
minetest.register_craft({
	output = "simple_furniture:brick_bench",
	recipe = {
		{"", "", "stairs:slab_brick"},
		{"stairs:slab_brick", "stairs:slab_brick", "stairs:slab_brick"},
		{"stairs:slab_brick", "", "stairs:slab_brick"},
	}
})

-- Brick Cabinet
minetest.register_craft({
	output = "simple_furniture:brick_cabinet",
	recipe = {
		{"stairs:slab_brick", "stairs:slab_brick", "stairs:slab_brick"},
		{"doors:trapdoor", "stairs:slab_brick", "doors:trapdoor"},
		{"stairs:slab_brick", "stairs:slab_brick", "stairs:slab_brick"},
	}
})

-- Brick Chair
minetest.register_craft({
	output = "simple_furniture:brick_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_brick", "stairs:slab_brick", "stairs:slab_brick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Brick Dining Table
minetest.register_craft({
	output = "simple_furniture:brick_dining_table",
	recipe = {
		{"stairs:slab_brick", "stairs:slab_brick", "stairs:slab_brick"},
		{"", "default:stick", ""},
		{"", "stairs:slab_brick", ""},
	}
})

-- Brick End Table
minetest.register_craft({
	output = "simple_furniture:brick_end_table",
	recipe = {
		{"stairs:slab_brick", "stairs:slab_brick", "stairs:slab_brick"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Obsidian Bench
minetest.register_craft({
	output = "simple_furniture:obsidian_bench",
	recipe = {
		{"", "", "stairs:slab_obsidian"},
		{"stairs:slab_obsidian", "stairs:slab_obsidian", "stairs:slab_obsidian"},
		{"stairs:slab_obsidian", "", "stairs:slab_obsidian"},
	}
})

-- Obsidian Cabinet
minetest.register_craft({
	output = "simple_furniture:obsidian_cabinet",
	recipe = {
		{"stairs:slab_obsidian", "stairs:slab_obsidian", "stairs:slab_obsidian"},
		{"doors:trapdoor", "stairs:slab_obsidian", "doors:trapdoor"},
		{"stairs:slab_obsidian", "stairs:slab_obsidian", "stairs:slab_obsidian"},
	}
})

-- Obsidian Chair
minetest.register_craft({
	output = "simple_furniture:obsidian_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_obsidian", "stairs:slab_obsidian", "stairs:slab_obsidian"},
		{"default:stick", "", "default:stick"},
	}
})

-- Obsidian Dining Table
minetest.register_craft({
	output = "simple_furniture:obsidian_dining_table",
	recipe = {
		{"stairs:slab_obsidian", "stairs:slab_obsidian", "stairs:slab_obsidian"},
		{"", "default:stick", ""},
		{"", "stairs:slab_obsidian", ""},
	}
})

-- Obsidian End Table
minetest.register_craft({
	output = "simple_furniture:obsidian_end_table",
	recipe = {
		{"stairs:slab_obsidian", "stairs:slab_obsidian", "stairs:slab_obsidian"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Snow Bench
minetest.register_craft({
	output = "simple_furniture:snow_bench",
	recipe = {
		{"", "", "stairs:slab_snowblock"},
		{"stairs:slab_snowblock", "stairs:slab_snowblock", "stairs:slab_snowblock"},
		{"stairs:slab_snowblock", "", "stairs:slab_snowblock"},
	}
})

-- Snow Cabinet
minetest.register_craft({
	output = "simple_furniture:snow_cabinet",
	recipe = {
		{"stairs:slab_snowblock", "stairs:slab_snowblock", "stairs:slab_snowblock"},
		{"doors:trapdoor", "stairs:slab_snowblock", "doors:trapdoor"},
		{"stairs:slab_snowblock", "stairs:slab_snowblock", "stairs:slab_snowblock"},
	}
})

-- Snow Chair
minetest.register_craft({
	output = "simple_furniture:snow_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_snowblock", "stairs:slab_snowblock", "stairs:slab_snowblock"},
		{"default:stick", "", "default:stick"},
	}
})

-- Snow Dining Table
minetest.register_craft({
	output = "simple_furniture:snow_dining_table",
	recipe = {
		{"stairs:slab_snowblock", "stairs:slab_snowblock", "stairs:slab_snowblock"},
		{"", "default:stick", ""},
		{"", "stairs:slab_snowblock", ""},
	}
})

-- Snow End Table
minetest.register_craft({
	output = "simple_furniture:snow_end_table",
	recipe = {
		{"stairs:slab_snowblock", "stairs:slab_snowblock", "stairs:slab_snowblock"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Ice Bench
minetest.register_craft({
	output = "simple_furniture:ice_bench",
	recipe = {
		{"", "", "stairs:slab_ice"},
		{"stairs:slab_ice", "stairs:slab_ice", "stairs:slab_ice"},
		{"stairs:slab_ice", "", "stairs:slab_ice"},
	}
})

-- Ice Cabinet
minetest.register_craft({
	output = "simple_furniture:ice_cabinet",
	recipe = {
		{"stairs:slab_ice", "stairs:slab_ice", "stairs:slab_ice"},
		{"doors:trapdoor", "stairs:slab_ice", "doors:trapdoor"},
		{"stairs:slab_ice", "stairs:slab_ice", "stairs:slab_ice"},
	}
})

-- Ice Chair
minetest.register_craft({
	output = "simple_furniture:ice_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_ice", "stairs:slab_ice", "stairs:slab_ice"},
		{"default:stick", "", "default:stick"},
	}
})

-- Ice Dining Table
minetest.register_craft({
	output = "simple_furniture:ice_dining_table",
	recipe = {
		{"stairs:slab_ice", "stairs:slab_ice", "stairs:slab_ice"},
		{"", "default:stick", ""},
		{"", "stairs:slab_ice", ""},
	}
})

-- Ice End Table
minetest.register_craft({
	output = "simple_furniture:ice_end_table",
	recipe = {
		{"stairs:slab_ice", "stairs:slab_ice", "stairs:slab_ice"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Straw Bench
minetest.register_craft({
	output = "simple_furniture:straw_bench",
	recipe = {
		{"", "", "stairs:slab_straw"},
		{"stairs:slab_straw", "stairs:slab_straw", "stairs:slab_straw"},
		{"stairs:slab_straw", "", "stairs:slab_straw"},
	}
})

-- Straw Cabinet
minetest.register_craft({
	output = "simple_furniture:straw_cabinet",
	recipe = {
		{"stairs:slab_straw", "stairs:slab_straw", "stairs:slab_straw"},
		{"doors:trapdoor", "stairs:slab_straw", "doors:trapdoor"},
		{"stairs:slab_straw", "stairs:slab_straw", "stairs:slab_straw"},
	}
})

-- Straw Chair
minetest.register_craft({
	output = "simple_furniture:straw_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_straw", "stairs:slab_straw", "stairs:slab_straw"},
		{"default:stick", "", "default:stick"},
	}
})

-- Straw Dining Table
minetest.register_craft({
	output = "simple_furniture:straw_dining_table",
	recipe = {
		{"stairs:slab_straw", "stairs:slab_straw", "stairs:slab_straw"},
		{"", "default:stick", ""},
		{"", "stairs:slab_straw", ""},
	}
})

-- Straw End Table
minetest.register_craft({
	output = "simple_furniture:straw_end_table",
	recipe = {
		{"stairs:slab_straw", "stairs:slab_straw", "stairs:slab_straw"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})