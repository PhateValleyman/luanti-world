-- simple_furniture/sf_dynamic_trees.lua

-- These Are The Nodes For The Benches
-- Bamboo Bundle Bench
minetest.register_node("simple_furniture:bamboo_bundle_bench", {
	description = ("Bamboo Bundle Bench"),
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
		"dt_bamboo_bundle_side.png"
	},
	groups = {sf_bamboo_bundle_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_bundle_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Bamboo Planks Bench
minetest.register_node("simple_furniture:bamboo_planks_bench", {
	description = ("Bamboo Planks Bench"),
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
		"dt_bamboo_planks.png"
	},
	groups = {sf_bamboo_planks_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_planks_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Dry Planks Bench
minetest.register_node("simple_furniture:dry_planks_bench", {
	description = ("Dry Planks Bench"),
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
		"dt_dry_planks.png"
	},
	groups = {sf_dry_planks_bench = 1, bench = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:dry_planks_bench",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The Cabinets
-- Bamboo Bundle Cabinet
minetest.register_node("simple_furniture:bamboo_bundle_cabinet", {
	description = ("Bamboo Bundle Cabinet"),
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
		"dt_bamboo_bundle_side.png",
		"dt_bamboo_bundle_side.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"dt_bamboo_bundle_side.png"
	},
	groups = {sf_bamboo_bundle_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_bundle_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Bamboo Planks Cabinet
minetest.register_node("simple_furniture:bamboo_planks_cabinet", {
	description = ("Bamboo Planks Cabinet"),
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
		"dt_bamboo_planks.png",
		"dt_bamboo_planks.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"dt_bamboo_planks.png"
	},
	groups = {sf_bamboo_planks_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_planks_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Dry Planks Cabinet
minetest.register_node("simple_furniture:dry_planks_cabinet", {
	description = ("Dry Planks Cabinet"),
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
		"dt_dry_planks.png",
		"dt_dry_planks.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"dt_dry_planks.png"
	},
	groups = {sf_dry_planks_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:dry_planks_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The Chairs
-- Bamboo Bundle Chair
minetest.register_node("simple_furniture:bamboo_bundle_chair", {
	description = ("Bamboo Bundle Chair"),
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
		"dt_bamboo_bundle_side.png"
	},
	groups = {sf_bamboo_bundle_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_bundle_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Bamboo Planks Chair
minetest.register_node("simple_furniture:bamboo_planks_chair", {
	description = ("Bamboo Planks Chair"),
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
		"dt_bamboo_planks.png"
	},
	groups = {sf_bamboo_planks_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_planks_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Dry Planks Chair
minetest.register_node("simple_furniture:dry_planks_chair", {
	description = ("Dry Planks Chair"),
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
		"dt_dry_planks.png"
	},
	groups = {sf_dry_planks_chair = 1, chair = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:dry_planks_chair",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The Dining Tables
-- Bamboo Bundle Dining Table
minetest.register_node("simple_furniture:bamboo_bundle_dining_table", {
	description = ("Bamboo Bundle Dining Table"),
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
		"dt_bamboo_bundle_side.png"
	},
	groups = {sf_bamboo_bundle_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_bundle_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Bamboo Planks Dining Table
minetest.register_node("simple_furniture:bamboo_planks_dining_table", {
	description = ("Bamboo Planks Dining Table"),
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
		"dt_bamboo_planks.png"
	},
	groups = {sf_bamboo_planks_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_planks_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Dry Planks Dining Table
minetest.register_node("simple_furniture:dry_planks_dining_table", {
	description = ("Dry Planks Dining Table"),
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
		"dt_dry_planks.png"
	},
	groups = {sf_dry_planks_dining_table = 1, dining_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:dry_planks_dining_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Nodes For The End Tables
-- Bamboo Bundle End Table
minetest.register_node("simple_furniture:bamboo_bundle_end_table", {
	description = ("Bamboo Bundle End Table"),
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
		"dt_bamboo_bundle_side.png"
	},
	groups = {sf_bamboo_bundle_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_bundle_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Bamboo Planks End Table
minetest.register_node("simple_furniture:bamboo_planks_end_table", {
	description = ("Bamboo Planks End Table"),
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
		"dt_bamboo_planks.png"
	},
	groups = {sf_bamboo_planks_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:bamboo_planks_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Dry Planks End Table
minetest.register_node("simple_furniture:dry_planks_end_table", {
	description = ("Dry Planks End Table"),
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
		"dt_dry_planks.png"
	},
	groups = {sf_dry_planks_end_table = 1, end_table = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:dry_planks_end_table",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- These Are The Crafting Recipes For The Dynamic Trees Furniture
-- Bamboo Bundle Bench
minetest.register_craft({
	output = "simple_furniture:bamboo_bundle_bench",
	recipe = {
		{"", "", "stairs:slab_bamboo_bundle"},
		{"stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle"},
		{"stairs:slab_bamboo_bundle", "", "stairs:slab_bamboo_bundle"},
	}
})

-- Bamboo Bundle Cabinet
minetest.register_craft({
	output = "simple_furniture:bamboo_bundle_cabinet",
	recipe = {
		{"stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle"},
		{"doors:trapdoor", "stairs:slab_bamboo_bundle", "doors:trapdoor"},
		{"stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle"},
	}
})

-- Bamboo Bundle Chair
minetest.register_craft({
	output = "simple_furniture:bamboo_bundle_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle"},
		{"default:stick", "", "default:stick"},
	}
})

-- Bamboo Bundle Dining Table
minetest.register_craft({
	output = "simple_furniture:bamboo_bundle_dining_table",
	recipe = {
		{"stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle"},
		{"", "default:stick", ""},
		{"", "stairs:slab_bamboo_bundle", ""},
	}
})

-- Bamboo Bundle End Table
minetest.register_craft({
	output = "simple_furniture:bamboo_bundle_end_table",
	recipe = {
		{"stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle", "stairs:slab_bamboo_bundle"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Bamboo Planks Bench
minetest.register_craft({
	output = "simple_furniture:bamboo_planks_bench",
	recipe = {
		{"", "", "stairs:slab_bamboo_planks"},
		{"stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks"},
		{"stairs:slab_bamboo_planks", "", "stairs:slab_bamboo_planks"},
	}
})

-- Bamboo Planks Cabinet
minetest.register_craft({
	output = "simple_furniture:bamboo_planks_cabinet",
	recipe = {
		{"stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks"},
		{"doors:trapdoor", "stairs:slab_bamboo_planks", "doors:trapdoor"},
		{"stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks"},
	}
})

-- Bamboo Planks Chair
minetest.register_craft({
	output = "simple_furniture:bamboo_planks_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks"},
		{"default:stick", "", "default:stick"},
	}
})

-- Bamboo Planks Dining Table
minetest.register_craft({
	output = "simple_furniture:bamboo_planks_dining_table",
	recipe = {
		{"stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks"},
		{"", "default:stick", ""},
		{"", "stairs:slab_bamboo_planks", ""},
	}
})

-- Bamboo Planks End Table
minetest.register_craft({
	output = "simple_furniture:bamboo_planks_end_table",
	recipe = {
		{"stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks", "stairs:slab_bamboo_planks"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

-- Dry Planks Bench
minetest.register_craft({
	output = "simple_furniture:dry_planks_bench",
	recipe = {
		{"", "", "stairs:slab_dry_planks"},
		{"stairs:slab_dry_planks", "stairs:slab_dry_planks", "stairs:slab_dry_planks"},
		{"stairs:slab_dry_planks", "", "stairs:slab_dry_planks"},
	}
})

-- Dry Planks Cabinet
minetest.register_craft({
	output = "simple_furniture:dry_planks_cabinet",
	recipe = {
		{"stairs:slab_dry_planks", "stairs:slab_dry_planks", "stairs:slab_dry_planks"},
		{"doors:trapdoor", "stairs:slab_dry_planks", "doors:trapdoor"},
		{"stairs:slab_dry_planks", "stairs:slab_dry_planks", "stairs:slab_dry_planks"},
	}
})

-- Dry Planks Chair
minetest.register_craft({
	output = "simple_furniture:dry_planks_chair",
	recipe = {
		{"", "", "default:stick"},
		{"stairs:slab_dry_planks", "stairs:slab_dry_planks", "stairs:slab_dry_planks"},
		{"default:stick", "", "default:stick"},
	}
})

-- Dry Planks Dining Table
minetest.register_craft({
	output = "simple_furniture:dry_planks_dining_table",
	recipe = {
		{"stairs:slab_dry_planks", "stairs:slab_dry_planks", "stairs:slab_dry_planks"},
		{"", "default:stick", ""},
		{"", "stairs:slab_dry_planks", ""},
	}
})

-- Dry Planks End Table
minetest.register_craft({
	output = "simple_furniture:dry_planks_end_table",
	recipe = {
		{"stairs:slab_dry_planks", "stairs:slab_dry_planks", "stairs:slab_dry_planks"},
		{"default:stick", "", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})