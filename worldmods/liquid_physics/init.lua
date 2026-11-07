-- Copyright (C) 2025  snoutie
-- Authors: snoutie (copyright@achtarmig.org)
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published
-- by the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.

-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

local modpath = core.get_modpath(core.get_current_modname())

liquid_physics = {}

-- INTERNAL USE ONLY - Stores all nodes which need to checked
liquid_physics._nodes_to_check = {}
-- INTERNAL USE ONLY - Stores liquid_id and the corresponding liquid node names
liquid_physics._registered_liquids = {}
-- INTERNAL USE ONLY - Stores all liquid node names and their corresponding liquid_id
liquid_physics._liquid_ids = {}

local internal = dofile(modpath .. "/internal.lua")

dofile(modpath .. "/api.lua")

if core.get_modpath("default") then
    dofile(modpath .. "/game/default.lua")
elseif core.get_modpath("mcl_core") then
    dofile(modpath .. "/game/voxelibre.lua")
else
    error("Liquid Physics only supports VoxeLibre or Minetest")
end

core.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if internal.get_liquid_id(core.get_node(pos).name) ~= nil then
        internal.add_node_to_check(pos)
    end
end)

core.register_lbm {
    name = "liquid_physics:update",
    nodenames = "group:liquid_physics",
    run_at_every_load = true,
    action = function(pos, node, dtime_s)
        internal.add_node_to_check(pos)
    end,
}

core.register_abm({
    nodenames = "group:liquid_physics",
    neighbors = { "air" },
    interval  = 0.2,
    chance    = 0,
    action    = function(pos, node, active_object_count, active_object_count_wider)
        internal.add_node_to_check(pos)
    end
})

dofile(modpath .. "/physics.lua")
