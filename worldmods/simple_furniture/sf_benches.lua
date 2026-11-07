-- simple_furniture/sf_benches.lua

-- These Are The Nodes For The Benches
-- Apple Wood Bench
minetest.register_node("simple_furniture:apple_wood_bench", {
	description = ("Apple Wood Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_wood.png"
	},
	groups = {sf_apple_wood_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:apple_wood_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Aspen Wood Bench
minetest.register_node("simple_furniture:aspen_wood_bench", {
	description = ("Aspen Wood Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_aspen_wood.png"
	},
	groups = {sf_aspen_wood_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:aspen_wood_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Pine Wood Bench
minetest.register_node("simple_furniture:pine_wood_bench", {
	description = ("Pine Wood Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_pine_wood.png"
	},
	groups = {sf_pine_wood_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pine_wood_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Jungle Wood Bench
minetest.register_node("simple_furniture:jungle_wood_bench", {
	description = ("Jungle Wood Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_junglewood.png"
	},
	groups = {sf_jungle_wood_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:jungle_wood_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Acacia Wood Bench
minetest.register_node("simple_furniture:acacia_wood_bench", {
	description = ("Acacia Wood Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_acacia_wood.png"
	},
	groups = {sf_acacia_wood_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:acacia_wood_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Stone Bench
minetest.register_node("simple_furniture:stone_bench", {
	description = ("Stone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_stone.png"
	},
	groups = {sf_stone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:stone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Stone Bench
minetest.register_node("simple_furniture:desert_stone_bench", {
	description = ("Desert Stone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_desert_stone.png"
	},
	groups = {sf_desert_stone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_stone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Sandstone Bench
minetest.register_node("simple_furniture:sandstone_bench", {
	description = ("Sandstone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_sandstone.png"
	},
	groups = {sf_sandstone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:sandstone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Sandstone Bench
minetest.register_node("simple_furniture:desert_sandstone_bench", {
	description = ("Desert Sandstone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_desert_sandstone.png"
	},
	groups = {sf_desert_sandstone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_sandstone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Silver Sandstone Bench
minetest.register_node("simple_furniture:silver_sandstone_bench", {
	description = ("Silver Sandstone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_silver_sandstone.png"
	},
	groups = {sf_silver_sandstone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:silver_sandstone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Cobblestone Bench
minetest.register_node("simple_furniture:cobblestone_bench", {
	description = ("Cobblestone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_cobble.png"
	},
	groups = {sf_cobblestone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:cobblestone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Mossy Cobblestone Bench
minetest.register_node("simple_furniture:mossy_cobblestone_bench", {
	description = ("Mossy Cobblestone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_mossycobble.png"
	},
	groups = {sf_mossy_cobblestone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:mossy_cobblestone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Cobblestone Bench
minetest.register_node("simple_furniture:desert_cobblestone_bench", {
	description = ("Desert Cobblestone Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_desert_cobble.png"
	},
	groups = {sf_desert_cobblestone_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_cobblestone_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Brick Bench
minetest.register_node("simple_furniture:brick_bench", {
	description = ("Brick Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_brick.png"
	},
	groups = {sf_brick_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:brick_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Obsidian Bench
minetest.register_node("simple_furniture:obsidian_bench", {
	description = ("Obsidian Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_obsidian.png"
	},
	groups = {sf_obsidian_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:obsidian_bench",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Snow Bench
minetest.register_node("simple_furniture:snow_bench", {
	description = ("Snow Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_snow.png"
	},
	groups = {sf_snow_bench = 1, bench = 1, crumbly = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:snow_bench",
	sounds = default.node_sound_snow_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Ice Bench
minetest.register_node("simple_furniture:ice_bench", {
	description = ("Ice Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"default_ice.png"
	},
	groups = {sf_ice_bench = 1, bench = 1, cracky = 3, oddly_breakable_by_hand = 2, cools_lava = 1, slippery = 3},
	drop = "simple_furniture:ice_bench",
	sounds = default.node_sound_ice_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Straw Bench
minetest.register_node("simple_furniture:straw_bench", {
	description = ("Straw Bench"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
			{-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
			{0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
			{0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
			-- This Is The Seat
			{-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
			{-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
			{-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
			-- This Is The Backrest Post
			{0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
			-- This Is The Backrest
			{-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
		}
	},
	tiles = {
		"farming_straw.png"
	},
	groups = {sf_straw_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:straw_bench",
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})