-- simple_furniture/sf_dining_tables.lua

-- These Are The Nodes For The Dining Tables
-- Apple Wood Dining Table
minetest.register_node("simple_furniture:apple_wood_dining_table", {
	description = ("Apple Wood Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_wood.png"
	},
	groups = {sf_apple_wood_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:apple_wood_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Aspen Wood Dining Table
minetest.register_node("simple_furniture:aspen_wood_dining_table", {
	description = ("Aspen Wood Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_aspen_wood.png"
	},
	groups = {sf_aspen_wood_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:aspen_wood_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Pine Wood Dining Table
minetest.register_node("simple_furniture:pine_wood_dining_table", {
	description = ("Pine Wood Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_pine_wood.png"
	},
	groups = {sf_pine_wood_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pine_wood_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Jungle Wood Dining Table
minetest.register_node("simple_furniture:jungle_wood_dining_table", {
	description = ("Jungle Wood Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_junglewood.png"
	},
	groups = {sf_jungle_wood_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:jungle_wood_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Acacia Wood Dining Table
minetest.register_node("simple_furniture:acacia_wood_dining_table", {
	description = ("Acacia Wood Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_acacia_wood.png"
	},
	groups = {sf_acacia_wood_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:acacia_wood_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Stone Dining Table
minetest.register_node("simple_furniture:stone_dining_table", {
	description = ("Stone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_stone.png"
	},
	groups = {sf_stone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:stone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Stone Dining Table
minetest.register_node("simple_furniture:desert_stone_dining_table", {
	description = ("Desert Stone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_desert_stone.png"
	},
	groups = {sf_desert_stone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_stone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Sandstone Dining Table
minetest.register_node("simple_furniture:sandstone_dining_table", {
	description = ("Sandstone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_sandstone.png"
	},
	groups = {sf_sandstone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:sandstone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Sandstone Dining Table
minetest.register_node("simple_furniture:desert_sandstone_dining_table", {
	description = ("Desert Sandstone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_desert_sandstone.png"
	},
	groups = {sf_desert_sandstone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_sandstone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Silver Sandstone Dining Table
minetest.register_node("simple_furniture:silver_sandstone_dining_table", {
	description = ("Silver Sandstone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_silver_sandstone.png"
	},
	groups = {sf_silver_sandstone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:silver_sandstone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Cobblestone Dining Table
minetest.register_node("simple_furniture:cobblestone_dining_table", {
	description = ("Cobblestone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_cobble.png"
	},
	groups = {sf_cobblestone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:cobblestone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Mossy Cobblestone Dining Table
minetest.register_node("simple_furniture:mossy_cobblestone_dining_table", {
	description = ("Mossy Cobblestone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_mossycobble.png"
	},
	groups = {sf_mossy_cobblestone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:mossy_cobblestone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Cobblestone Dining Table
minetest.register_node("simple_furniture:desert_cobblestone_dining_table", {
	description = ("Desert Cobblestone Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_desert_cobble.png"
	},
	groups = {sf_desert_cobblestone_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_cobblestone_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Brick Dining Table
minetest.register_node("simple_furniture:brick_dining_table", {
	description = ("Brick Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_brick.png"
	},
	groups = {sf_brick_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:brick_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Obsidian Dining Table
minetest.register_node("simple_furniture:obsidian_dining_table", {
	description = ("Obsidian Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_obsidian.png"
	},
	groups = {sf_obsidian_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:obsidian_dining_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Snow Dining Table
minetest.register_node("simple_furniture:snow_dining_table", {
	description = ("Snow Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_snow.png"
	},
	groups = {sf_snow_dining_table = 1, dining_table = 1, crumbly = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:snow_dining_table",
	sounds = default.node_sound_snow_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Ice Dining Table
minetest.register_node("simple_furniture:ice_dining_table", {
	description = ("Ice Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_ice.png"
	},
	groups = {sf_ice_dining_table = 1, dining_table = 1, cracky = 3, oddly_breakable_by_hand = 2, cools_lava = 1, slippery = 3},
	drop = "simple_furniture:ice_dining_table",
	sounds = default.node_sound_ice_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Straw Dining Table
minetest.register_node("simple_furniture:straw_dining_table", {
	description = ("Straw Dining Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Pedestal
			{-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"farming_straw.png"
	},
	groups = {sf_straw_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:straw_dining_table",
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})