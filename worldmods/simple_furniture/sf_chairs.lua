-- simple_furniture/sf_chairs.lua

-- These Are The Nodes For The Chairs
-- Apple Wood Chair
minetest.register_node("simple_furniture:apple_wood_chair", {
	description = ("Apple Wood Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_wood.png"
	},
	groups = {sf_apple_wood_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:apple_wood_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Aspen Wood Chair
minetest.register_node("simple_furniture:aspen_wood_chair", {
	description = ("Aspen Wood Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_aspen_wood.png"
	},
	groups = {sf_aspen_wood_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:aspen_wood_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Pine Wood Chair
minetest.register_node("simple_furniture:pine_wood_chair", {
	description = ("Pine Wood Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_pine_wood.png"
	},
	groups = {sf_pine_wood_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pine_wood_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Jungle Wood Chair
minetest.register_node("simple_furniture:jungle_wood_chair", {
	description = ("Jungle Wood Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_junglewood.png"
	},
	groups = {sf_jungle_wood_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:jungle_wood_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Acacia Wood Chair
minetest.register_node("simple_furniture:acacia_wood_chair", {
	description = ("Acacia Wood Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_acacia_wood.png"
	},
	groups = {sf_acacia_wood_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:acacia_wood_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Stone Chair
minetest.register_node("simple_furniture:stone_chair", {
	description = ("Stone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_stone.png"
	},
	groups = {sf_stone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:stone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Stone Chair
minetest.register_node("simple_furniture:desert_stone_chair", {
	description = ("Desert Stone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_desert_stone.png"
	},
	groups = {sf_desert_stone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_stone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Sandstone Chair
minetest.register_node("simple_furniture:sandstone_chair", {
	description = ("Sandstone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_sandstone.png"
	},
	groups = {sf_sandstone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:sandstone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Sandstone Chair
minetest.register_node("simple_furniture:desert_sandstone_chair", {
	description = ("Desert Sandstone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_desert_sandstone.png"
	},
	groups = {sf_desert_sandstone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_sandstone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Silver Sandstone Chair
minetest.register_node("simple_furniture:silver_sandstone_chair", {
	description = ("Silver Sandstone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_silver_sandstone.png"
	},
	groups = {sf_silver_sandstone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:silver_sandstone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Cobblestone Chair
minetest.register_node("simple_furniture:cobblestone_chair", {
	description = ("Cobblestone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_cobble.png"
	},
	groups = {sf_cobblestone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:cobblestone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Mossy Cobblestone Chair
minetest.register_node("simple_furniture:mossy_cobblestone_chair", {
	description = ("Mossy Cobblestone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_mossycobble.png"
	},
	groups = {sf_mossy_cobblestone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:mossy_cobblestone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Cobblestone Chair
minetest.register_node("simple_furniture:desert_cobblestone_chair", {
	description = ("Desert Cobblestone Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_desert_cobble.png"
	},
	groups = {sf_desert_cobblestone_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_cobblestone_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Brick Chair
minetest.register_node("simple_furniture:brick_chair", {
	description = ("Brick Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_brick.png"
	},
	groups = {sf_brick_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:brick_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Obsidian Chair
minetest.register_node("simple_furniture:obsidian_chair", {
	description = ("Obsidian Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_obsidian.png"
	},
	groups = {sf_obsidian_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:obsidian_chair",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Snow Chair
minetest.register_node("simple_furniture:snow_chair", {
	description = ("Snow Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_snow.png"
	},
	groups = {sf_snow_chair = 1, chair = 1, crumbly = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:snow_chair",
	sounds = default.node_sound_snow_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Ice Chair
minetest.register_node("simple_furniture:ice_chair", {
	description = ("Ice Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"default_ice.png"
	},
	groups = {sf_ice_chair = 1, chair = 1, cracky = 3, oddly_breakable_by_hand = 2, cools_lava = 1, slippery = 3},
	drop = "simple_furniture:ice_chair",
	sounds = default.node_sound_ice_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Straw Chair
minetest.register_node("simple_furniture:straw_chair", {
	description = ("Straw Chair"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- These Are The Legs
			{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
			{-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
			{0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
			{0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
			-- This Is The Seat
			{-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
			-- These Are The Backrest Posts
			{-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
			{0.375, 0, 0.375, 0.3125, 0.5, 0.25},
			-- This Is The Backrest
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"farming_straw.png"
	},
	groups = {sf_straw_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:straw_chair",
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})