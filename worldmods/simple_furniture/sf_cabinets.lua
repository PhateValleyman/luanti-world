-- simple_furniture/sf_cabinets.lua

-- These Are The Nodes For The Cabinets
-- Apple Wood Cabinet
minetest.register_node("simple_furniture:apple_wood_cabinet", {
	description = ("Apple Wood Cabinet"),
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
		"default_wood.png",
		"default_wood.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"default_wood.png"
	},
	groups = {sf_apple_wood_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:apple_wood_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Aspen Wood Cabinet
minetest.register_node("simple_furniture:aspen_wood_cabinet", {
	description = ("Aspen Wood Cabinet"),
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
		"default_aspen_wood.png",
		"default_aspen_wood.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"default_aspen_wood.png"
	},
	groups = {sf_aspen_wood_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:aspen_wood_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Pine Wood Cabinet
minetest.register_node("simple_furniture:pine_wood_cabinet", {
	description = ("Pine Wood Cabinet"),
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
		"default_pine_wood.png",
		"default_pine_wood.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"default_pine_wood.png"
	},
	groups = {sf_pine_wood_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:pine_wood_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Jungle Wood Cabinet
minetest.register_node("simple_furniture:jungle_wood_cabinet", {
	description = ("Jungle Wood Cabinet"),
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
		"default_junglewood.png",
		"default_junglewood.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"default_junglewood.png"
	},
	groups = {sf_jungle_wood_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:jungle_wood_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Acacia Wood Cabinet
minetest.register_node("simple_furniture:acacia_wood_cabinet", {
	description = ("Acacia Wood Cabinet"),
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
		"default_acacia_wood.png",
		"default_acacia_wood.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"default_acacia_wood.png"
	},
	groups = {sf_acacia_wood_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:acacia_wood_cabinet",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Stone Cabinet
minetest.register_node("simple_furniture:stone_cabinet", {
	description = ("Stone Cabinet"),
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
		"default_stone.png",
		"default_stone.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_stone.png"
	},
	groups = {sf_stone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:stone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Stone Cabinet
minetest.register_node("simple_furniture:desert_stone_cabinet", {
	description = ("Desert Stone Cabinet"),
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
		"default_desert_stone.png",
		"default_desert_stone.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_desert_stone.png"
	},
	groups = {sf_desert_stone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_stone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Sandstone Cabinet
minetest.register_node("simple_furniture:sandstone_cabinet", {
	description = ("Sandstone Cabinet"),
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
		"default_sandstone.png",
		"default_sandstone.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_sandstone.png"
	},
	groups = {sf_sandstone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:sandstone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Sandstone Cabinet
minetest.register_node("simple_furniture:desert_sandstone_cabinet", {
	description = ("Desert Sandstone Cabinet"),
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
		"default_desert_sandstone.png",
		"default_desert_sandstone.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_desert_sandstone.png"
	},
	groups = {sf_desert_sandstone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_sandstone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Silver Sandstone Cabinet
minetest.register_node("simple_furniture:silver_sandstone_cabinet", {
	description = ("Silver Sandstone Cabinet"),
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
		"default_silver_sandstone.png",
		"default_silver_sandstone.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_silver_sandstone.png"
	},
	groups = {sf_silver_sandstone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:silver_sandstone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Cobblestone Cabinet
minetest.register_node("simple_furniture:cobblestone_cabinet", {
	description = ("Cobblestone Cabinet"),
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
		"default_cobble.png",
		"default_cobble.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_cobble.png"
	},
	groups = {sf_cobblestone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:cobblestone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Mossy Cobblestone Cabinet
minetest.register_node("simple_furniture:mossy_cobblestone_cabinet", {
	description = ("Mossy Cobblestone Cabinet"),
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
		"default_mossycobble.png",
		"default_mossycobble.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_mossycobble.png"
	},
	groups = {sf_mossy_cobblestone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:mossy_cobblestone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Desert Cobblestone Cabinet
minetest.register_node("simple_furniture:desert_cobblestone_cabinet", {
	description = ("Desert Cobblestone Cabinet"),
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
		"default_desert_cobble.png",
		"default_desert_cobble.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_desert_cobble.png"
	},
	groups = {sf_desert_cobblestone_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:desert_cobblestone_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Brick Cabinet
minetest.register_node("simple_furniture:brick_cabinet", {
	description = ("Brick Cabinet"),
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
		"default_brick.png",
		"default_brick.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_brick.png"
	},
	groups = {sf_brick_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:brick_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Obsidian Cabinet
minetest.register_node("simple_furniture:obsidian_cabinet", {
	description = ("Obsidian Cabinet"),
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
		"default_obsidian.png",
		"default_obsidian.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_obsidian.png"
	},
	groups = {sf_obsidian_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:obsidian_cabinet",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Snow Cabinet
minetest.register_node("simple_furniture:snow_cabinet", {
	description = ("Snow Cabinet"),
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
		"default_snow.png",
		"default_snow.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_snow.png"
	},
	groups = {sf_snow_cabinet = 1, cabinet = 1, crumbly = 3, oddly_breakable_by_hand = 2},
	drop = "simple_furniture:snow_cabinet",
	sounds = default.node_sound_snow_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Ice Cabinet
minetest.register_node("simple_furniture:ice_cabinet", {
	description = ("Ice Cabinet"),
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
		"default_ice.png",
		"default_ice.png",
		"default_furnace_top.png",
		"default_furnace_top.png",
		"default_furnace_side.png",
		"default_ice.png"
	},
	groups = {sf_ice_cabinet = 1, cabinet = 1, cracky = 3, oddly_breakable_by_hand = 2, cools_lava = 1, slippery = 3},
	drop = "simple_furniture:ice_cabinet",
	sounds = default.node_sound_ice_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

-- Straw Cabinet
minetest.register_node("simple_furniture:straw_cabinet", {
	description = ("Straw Cabinet"),
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
		"farming_straw.png",
		"farming_straw.png",
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"farming_straw.png"
	},
	groups = {sf_straw_cabinet = 1, cabinet = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	drop = "simple_furniture:straw_cabinet",
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})