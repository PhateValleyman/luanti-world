-- simple_furniture/sf_end_tables.lua

-- These Are The Nodes For The End Tables
-- Apple Wood End Table
minetest.register_node("simple_furniture:apple_wood_end_table", {
	description = ("Apple Wood End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_wood.png"
	},
	groups = {sf_apple_wood_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:apple_wood_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Aspen Wood End Table
minetest.register_node("simple_furniture:aspen_wood_end_table", {
	description = ("Aspen Wood End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_aspen_wood.png"
	},
	groups = {sf_aspen_wood_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:aspen_wood_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Pine Wood End Table
minetest.register_node("simple_furniture:pine_wood_end_table", {
	description = ("Pine Wood End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_pine_wood.png"
	},
	groups = {sf_pine_wood_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pine_wood_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Jungle Wood End Table
minetest.register_node("simple_furniture:jungle_wood_end_table", {
	description = ("Jungle Wood End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_junglewood.png"
	},
	groups = {sf_jungle_wood_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:jungle_wood_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Acacia Wood End Table
minetest.register_node("simple_furniture:acacia_wood_end_table", {
	description = ("Acacia Wood End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_acacia_wood.png"
	},
	groups = {sf_acacia_wood_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:acacia_wood_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Stone End Table
minetest.register_node("simple_furniture:stone_end_table", {
	description = ("Stone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_stone.png"
	},
	groups = {sf_stone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:stone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Stone End Table
minetest.register_node("simple_furniture:desert_stone_end_table", {
	description = ("Desert Stone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_desert_stone.png"
	},
	groups = {sf_desert_stone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_stone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Sandstone End Table
minetest.register_node("simple_furniture:sandstone_end_table", {
	description = ("Sandstone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_sandstone.png"
	},
	groups = {sf_sandstone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:sandstone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Sandstone End Table
minetest.register_node("simple_furniture:desert_sandstone_end_table", {
	description = ("Desert Sandstone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_desert_sandstone.png"
	},
	groups = {sf_desert_sandstone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_sandstone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Silver Sandstone End Table
minetest.register_node("simple_furniture:silver_sandstone_end_table", {
	description = ("Silver Sandstone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_silver_sandstone.png"
	},
	groups = {sf_silver_sandstone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:silver_sandstone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Cobblestone End Table
minetest.register_node("simple_furniture:cobblestone_end_table", {
	description = ("Cobblestone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_cobble.png"
	},
	groups = {sf_cobblestone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:cobblestone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Mossy Cobblestone End Table
minetest.register_node("simple_furniture:mossy_cobblestone_end_table", {
	description = ("Mossy Cobblestone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_mossycobble.png"
	},
	groups = {sf_mossy_cobblestone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:mossy_cobblestone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Cobblestone End Table
minetest.register_node("simple_furniture:desert_cobblestone_end_table", {
	description = ("Desert Cobblestone End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_desert_cobble.png"
	},
	groups = {sf_desert_cobblestone_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_cobblestone_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Brick End Table
minetest.register_node("simple_furniture:brick_end_table", {
	description = ("Brick End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_brick.png"
	},
	groups = {sf_brick_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:brick_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Obsidian End Table
minetest.register_node("simple_furniture:obsidian_end_table", {
	description = ("Obsidian End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_obsidian.png"
	},
	groups = {sf_obsidian_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:obsidian_end_table",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Snow End Table
minetest.register_node("simple_furniture:snow_end_table", {
	description = ("Snow End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_snow.png"
	},
	groups = {sf_snow_end_table = 1, end_table = 1, crumbly = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:snow_end_table",
	sounds = default.node_sound_snow_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Ice End Table
minetest.register_node("simple_furniture:ice_end_table", {
	description = ("Ice End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"default_ice.png"
	},
	groups = {sf_ice_end_table = 1, end_table = 1, cracky = 3, oddly_breakable_by_hand = 2, cools_lava = 1, slippery = 3},
	drop = "simple_furniture:ice_end_table",
	sounds = default.node_sound_ice_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Straw End Table
minetest.register_node("simple_furniture:straw_end_table", {
	description = ("Straw End Table"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
			{-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
			{0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
			{0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
			-- These Are The Stretchers
			{-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
			{0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
			-- This Is The Table Top
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"farming_straw.png"
	},
	groups = {sf_straw_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:straw_end_table",
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})