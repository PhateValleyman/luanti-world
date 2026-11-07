-- simple_furniture/sf_cropocalypse.lua

-- These Are The Nodes For The Benches
-- Pumpkin Bench
minetest.register_node("simple_furniture:pumpkin_bench", {
	description = ("Pumpkin Bench"),
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
		"cropocalypse_pumpkin.png"
	},
	groups = {sf_pumpkin_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pumpkin_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Watermelon Bench
minetest.register_node("simple_furniture:watermelon_bench", {
	description = ("Watermelon Bench"),
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
		"cropocalypse_watermelon.png"
	},
	groups = {sf_watermelon_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:watermelon_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The Cabinets
-- Pumpkin Cabinet
minetest.register_node("simple_furniture:pumpkin_cabinet", {
	description = ("Pumpkin Cabinet"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Base Of The Cabinet
			{0.5, -0.5, 0.5, -0.5, -0.4375, -0.375},
			-- These Are The Sides Of The Cabinet
			{0.5, -0.4375, 0.5, 0.4375, 0.4375, -0.375},
			{-0.5, -0.4375, 0.5, -0.4375, 0.4375, -0.375},
			{0.4375, -0.4375, 0.5, -0.4375, 0.4375, 0.4375},
			{0.4375, -0.4375, -0.3125, -0.4375, 0.4375, -0.375},
			-- These Are The Doors To The Cabinet
			{0.4375, -0.4375, -0.375, 0.0625, 0.375, -0.4375},
			{-0.4375, -0.4375, -0.375, -0.0625, 0.375, -0.4375},
			-- This Is The Cabinet Top
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"cropocalypse_pumpkin.png"
	},
	groups = {sf_pumpkin_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pumpkin_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Watermelon Cabinet
minetest.register_node("simple_furniture:watermelon_cabinet", {
	description = ("Watermelon Cabinet"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- This Is The Base Of The Cabinet
			{0.5, -0.5, 0.5, -0.5, -0.4375, -0.375},
			-- These Are The Sides Of The Cabinet
			{0.5, -0.4375, 0.5, 0.4375, 0.4375, -0.375},
			{-0.5, -0.4375, 0.5, -0.4375, 0.4375, -0.375},
			{0.4375, -0.4375, 0.5, -0.4375, 0.4375, 0.4375},
			{0.4375, -0.4375, -0.3125, -0.4375, 0.4375, -0.375},
			-- These Are The Doors To The Cabinet
			{0.4375, -0.4375, -0.375, 0.0625, 0.375, -0.4375},
			{-0.4375, -0.4375, -0.375, -0.0625, 0.375, -0.4375},
			-- This Is The Cabinet Top
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"cropocalypse_watermelon.png"
	},
	groups = {sf_watermelon_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:watermelon_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The Chairs
-- Pumpkin Chair
minetest.register_node("simple_furniture:pumpkin_chair", {
	description = ("Pumpkin Chair"),
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
		"cropocalypse_pumpkin.png"
	},
	groups = {sf_pumpkin_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pumpkin_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Watermelon Chair
minetest.register_node("simple_furniture:watermelon_chair", {
	description = ("Watermelon Chair"),
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
		"cropocalypse_watermelon.png"
	},
	groups = {sf_watermelon_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:watermelon_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The Dining Tables
-- Pumpkin Dining Table
minetest.register_node("simple_furniture:pumpkin_dining_table", {
	description = ("Pumpkin Dining Table"),
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
		"cropocalypse_pumpkin_top.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png"
	},
	groups = {sf_pumpkin_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pumpkin_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Watermelon Dining Table
minetest.register_node("simple_furniture:watermelon_dining_table", {
	description = ("Watermelon Dining Table"),
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
		"cropocalypse_watermelon_top_bottom.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png"
	},
	groups = {sf_watermelon_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:watermelon_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The End Tables
-- Pumpkin End Table
minetest.register_node("simple_furniture:pumpkin_end_table", {
	description = ("Pumpkin End Table"),
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
		"cropocalypse_pumpkin_top.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png"
	},
	groups = {sf_pumpkin_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pumpkin_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Watermelon End Table
minetest.register_node("simple_furniture:watermelon_end_table", {
	description = ("Watermelon End Table"),
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
		"cropocalypse_watermelon_top_bottom.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png"
	},
	groups = {sf_watermelon_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:watermelon_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Crafting Recipes For The Cropocalypse Furniture
-- Pumpkin Bench
minetest.register_craft({
	output = "simple_furniture:pumpkin_bench",
	recipe = {
		{"", "", "cropocalypse:pumpkin"},
		{"cropocalypse:pumpkin", "cropocalypse:pumpkin", "cropocalypse:pumpkin"},
		{"cropocalypse:pumpkin", "", "cropocalypse:pumpkin"},
	}
})

-- Pumpkin Cabinet
minetest.register_craft({
	output = "simple_furniture:pumpkin_cabinet",
	recipe = {
		{"cropocalypse:pumpkin", "cropocalypse:pumpkin", "cropocalypse:pumpkin"},
		{"doors:trapdoor", "cropocalypse:pumpkin", "doors:trapdoor"},
		{"cropocalypse:pumpkin", "cropocalypse:pumpkin", "cropocalypse:pumpkin"},
	}
})

-- Pumpkin Chair
minetest.register_craft({
	output = "simple_furniture:pumpkin_chair",
	recipe = {
		{"", "", "default:stick"},
		{"cropocalypse:pumpkin", "cropocalypse:pumpkin", "cropocalypse:pumpkin"},
		{"default:stick", "", "default:stick"},
	}
})

-- Pumpkin Dining Table
minetest.register_craft({
	output = "simple_furniture:pumpkin_dining_table",
	recipe = {
		{"cropocalypse:pumpkin", "cropocalypse:pumpkin", "cropocalypse:pumpkin"},
		{"", "default:stick", ""},
		{"", "cropocalypse:pumpkin", ""},
	}
})

-- Pumpkin End Table
minetest.register_craft({
	output = "simple_furniture:pumpkin_end_table",
	recipe = {
		{"cropocalypse:pumpkin", "cropocalypse:pumpkin", "cropocalypse:pumpkin"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Watermelon Bench
minetest.register_craft({
	output = "simple_furniture:watermelon_bench",
	recipe = {
		{"", "", "cropocalypse:watermelon"},
		{"cropocalypse:watermelon", "cropocalypse:watermelon", "cropocalypse:watermelon"},
		{"cropocalypse:watermelon", "", "cropocalypse:watermelon"},
	}
})

-- Watermelon Cabinet
minetest.register_craft({
	output = "simple_furniture:watermelon_cabinet",
	recipe = {
		{"cropocalypse:watermelon", "cropocalypse:watermelon", "cropocalypse:watermelon"},
		{"doors:trapdoor", "cropocalypse:watermelon", "doors:trapdoor"},
		{"cropocalypse:watermelon", "cropocalypse:watermelon", "cropocalypse:watermelon"},
	}
})

-- Watermelon Chair
minetest.register_craft({
	output = "simple_furniture:watermelon_chair",
	recipe = {
		{"", "", "default:stick"},
		{"cropocalypse:watermelon", "cropocalypse:watermelon", "cropocalypse:watermelon"},
		{"default:stick", "", "default:stick"},
	}
})

-- Watermelon Dining Table
minetest.register_craft({
	output = "simple_furniture:watermelon_dining_table",
	recipe = {
		{"cropocalypse:watermelon", "cropocalypse:watermelon", "cropocalypse:watermelon"},
		{"", "default:stick", ""},
		{"", "cropocalypse:watermelon", ""},
	}
})

-- Watermelon End Table
minetest.register_craft({
	output = "simple_furniture:watermelon_end_table",
	recipe = {
		{"cropocalypse:watermelon", "cropocalypse:watermelon", "cropocalypse:watermelon"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})