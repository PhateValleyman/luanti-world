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

local internal = {}

-- Returns liquid_id when node is a liquid
--    0 when node is air and
--  nil when node is anything else
-- Note: 0 is not a valid ID
-- @param node_name string The name of the node
-- @return          number The ID of the liquid
function internal.get_liquid_id(node_name)
    if node_name == "air" then
        return 0
    end
    return liquid_physics._liquid_ids[node_name]
end

-- Returns name of liquid node or
--  "air" for a liquid level of 0
-- @param liquid_id    number The ID of the liquid
-- @param liquid_level number The level of the liquid
-- @return             string Name of the liquid node
function internal.get_liquid_node_name(liquid_id, liquid_level)
    if liquid_level == 0 then
        return "air"
    end

    return liquid_physics._registered_liquids[liquid_id][liquid_level + 1]
end

-- Returns the liquid level of the current node, where:
--   0 will be returned for air and
--  -1 will be returned for non-liquids.
-- @param liquid_id number The ID of the liquid
-- @param node_name string The name of the node
-- @returns         number Level of liquid
function internal.get_liquid_level(liquid_id, node_name)
    if node_name == "air" then
        return 0
    end
    if liquid_physics._registered_liquids[liquid_id] == nil then
        error("Invalid liquid_id: " .. liquid_id)
    end
    for i = 1, 9 do
        if node_name == liquid_physics._registered_liquids[liquid_id][i] then
            return i - 1
        end
    end

    return -1
end

-- Returns new Liquid Physics Node (LPN)
-- A LPN contains all necessary information for processing
-- A liquid_level of -1 or liquid_id of nil means, this node is not a liquid
-- @param hash string Hashed position of the node
-- @param pos  table  Position of the node
-- @return     table  LPN
function internal.new_lpn(hash, pos)
    local node = core.get_node(pos)
    local liquid_id = internal.get_liquid_id(node.name)
    local liquid_level = -1
    if liquid_id then
        liquid_level = internal.get_liquid_level(liquid_id, node.name)
    end
    return {
        hash = hash,
        pos = pos,
        node_name = node.name,
        liquid_id = liquid_id,
        init_liquid_level = liquid_level,
        liquid_level = liquid_level,
    }
end

-- Sets liquid_level and liquid_id of LPN
-- Change liquid_id for transmution
-- @param liquid_id    number The new ID of the liquid
-- @param lpn          table  Liquid Physics Node
-- @param liquid_level number The new level of the liquid
function internal.set_lpn(liquid_id, lpn, liquid_level)
    lpn.liquid_level = liquid_level
    lpn.liquid_id = liquid_id
end

-- Sets liquid node from LPN
-- @param lpn table Liquid Physics Node
function internal.set_node(lpn)
    core.set_node(lpn.pos, { name = internal.get_liquid_node_name(lpn.liquid_id, lpn.liquid_level) })
end

-- This node will be checked in the next cycle
-- @param pos table Position of the node
function internal.add_node_to_check(pos)
    local h = core.hash_node_position(pos)
    liquid_physics._nodes_to_check[h] = pos
end

-- This node will no longer be checked
-- @param pos table Position of the node
function internal.remove_node_to_check(pos)
    local h = core.hash_node_position(pos)
    liquid_physics._nodes_to_check[h] = nil
end

return internal
