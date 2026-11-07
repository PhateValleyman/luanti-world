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
local internal = dofile(modpath .. "/internal.lua")
local internal_bucket = dofile(modpath .. "/bucket.lua")

-- Returns liquid_id of the node or
--  nil when the node is not a liquid
-- @param node_name string Name of the node, e.g. "default:water_source"
-- @return number ID of the liquid
function liquid_physics.get_liquid_id(node_name)
    local id = internal.get_liquid_id(node_name)
    if id == 0 then
        return nil
    end
    return id
end

-- Returns the liquid of the position specified or
--  nil when the node is not a liquid
-- @param pos table Position of the Node
-- @return    table Table with liquid_id and liquid_level
function liquid_physics.get_liquid_at(pos)
    local lpn = internal.new_lpn(core.hash_node_position(pos), pos)
    if not lpn.liquid_id or lpn.liquid_id == 0 then
        return nil
    end
    return { liquid_id = lpn.liquid_id, liquid_level = lpn.liquid_level }
end

-- Returns the node names for a liquid ordered by the corresponding liquid level
-- Useful if you want to register an ABM or LBM
-- @param liquid_id number ID of the liquid
-- @return          table  Table of liquid node names for that id
function liquid_physics.get_liquid_node_names(liquid_id)
    local nodes = {}
    for i = 2, 9 do
        table.insert(nodes, liquid_physics._registered_liquids[liquid_id][i])
    end
    return nodes
end

-- Sets the liquid at the position specified
-- Returns true if the operation was successful
-- @param pos          table  Position of the Node
-- @param liquid_id    number ID of the liquid
-- @param liquid_level number [0..8] Level of the liquid
-- @return             bool   Success
function liquid_physics.set_liquid_at(pos, liquid_id, liquid_level)
    if liquid_level < 0 or liquid_level > 8 then
        return false
    end
    local lpn = internal.new_lpn(core.hash_node_position(pos), pos)
    internal.set_lpn(liquid_id, lpn, liquid_level)
    internal.set_node(lpn)
    internal.add_node_to_check(pos)
    return true
end

-- This function will override the bucket provided to add the capapability
--  of transporting liquids of factional size
-- @param name string Name of the bucket, e.g. "bucket:bucket:water"
function liquid_physics.register_bucket(name)
    internal_bucket.register_filled_bucket(name)
end

-- Executing this function will override the nodes specified.
-- New liquid sources will be "liquid_physics:namespace_name_level_1" through 7
-- @param namespace    string Name of mod e.g. "default"
-- @param source_name  string Name of the liquid source, e.g. "water_source"
-- @param flowing_name string Name of the flowing liquid, e.g. "water_flowing"
function liquid_physics.register_liquid(namespace, source_name, flowing_name)
    --Get next id
    local id = table.getn(liquid_physics._registered_liquids) + 1

    --Get source definition
    local source_liquid_name = namespace .. ":" .. source_name
    local source_liquid_def = core.registered_nodes[source_liquid_name]

    if source_liquid_def.liquidtype ~= "source" then
        error("Liquid Physics: " ..
            source_liquid_name .. " is of type " .. source_liquid_def.drawtype .. " and not of type source")
    end

    --Get flowing definiton
    local flowing_liquid_name = namespace .. ":" .. flowing_name
    local flowing_liquid_def = core.registered_nodes[flowing_liquid_name]

    if flowing_liquid_def.liquidtype ~= "flowing" then
        error("Liquid Physics: " ..
            source_liquid_name .. " is of type " .. source_liquid_def.drawtype .. " and not of type flowing")
    end

    --Overwrite source
    source_liquid_def.liquid_range = 0
    source_liquid_def.groups.liquid_physics = 1

    core.register_node(":" .. source_liquid_name, source_liquid_def)
    liquid_physics._liquid_ids[source_liquid_name] = id

    local liquids = {}
    table.insert(liquids, "air")

    for i = 1, 7 do
        local node_name = "liquid_physics:" .. namespace .. "_" .. source_name .. "_level_" .. i

        local level_def = {
            name = node_name,
            description = source_liquid_def.description .. " Level " .. i,
            tiles = source_liquid_def.tiles,
            use_texture_alpha = source_liquid_def.use_texture_alpha,
            paramtype = source_liquid_def.paramtype,
            walkable = source_liquid_def.walkable,
            pointable = source_liquid_def.pointable,
            diggable = source_liquid_def.diggable,
            buildable_to = source_liquid_def.buildable_to,
            is_ground_content = source_liquid_def.is_ground_content,
            drawtype = "nodebox",
            drop = source_liquid_def.drop,
            drowning = source_liquid_def.drowning,
            liquidtype = "source",
            liquid_alternative_flowing = node_name,
            liquid_alternative_source = node_name,
            liquid_range = 0,
            liquid_viscosity = source_liquid_def.liquid_viscosity,
            liquid_renewable = false,
            waving = source_liquid_def.waving,
            color = source_liquid_def.color,
            node_box = {
                type = "fixed",
                fixed = {
                    { -0.5, -0.5, -0.5, 0.5, -0.375 + (0.125 * (i - 1)), 0.5 },
                },
            },
            collision_box = {
                type = "fixed",
                fixed = { { -0.5, -0.5, -0.5, 0.5, -0.375 + (0.125 * (i - 1)), 0.5 }, },
            },
            post_effect_color = source_liquid_def.post_effect_color,
            groups = source_liquid_def.groups,
            sounds = source_liquid_def.sounds,
        }

        core.register_node(":" .. node_name, level_def)
        liquid_physics._liquid_ids[node_name] = id

        table.insert(liquids, node_name)
    end

    table.insert(liquids, source_liquid_name)

    -- Finally, stop flowing
    flowing_liquid_def.groups.liquid_physics = 1
    core.override_item(flowing_liquid_name, {
        liquid_range = 0,
        liquid_renewable = false,
        groups = flowing_liquid_def.groups
    }, nil)
    liquid_physics._liquid_ids[flowing_liquid_name] = id

    liquid_physics._registered_liquids[id] = liquids
end
