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

-- A table of offsets for ease of use
local offsets = {
    { x = 0,  z = 1, },
    { x = 0,  z = -1, },
    { x = 1,  z = 0, },
    { x = -1, z = 0, }
}
-- Store number of offsets for less calculations
local number_of_offsets = table.getn(offsets)

-- Adds offset to pos
-- @param pos    table Position
-- @param offset table Offset
-- @return       table Position with added offset
local function add_offset_to_pos(pos, offset)
    return {
        x = pos.x + offset.x,
        z = pos.z + offset.z,
        y = pos.y
    }
end

-- Get a LPN from either the buffer or create a new one
--  and add it to the buffer
-- @param b   table Buffered LPN
-- @param pos table Positon of the node
-- @return    table LPN
local function get_lpn_buffered(b, pos)
    local h = core.hash_node_position(pos)
    if b[h] ~= nil then
        return b[h]
    end
    b[h] = internal.new_lpn(h, pos)
    return b[h]
end

-- Checks if liquid_id of curr and lpn are the same.
-- Checks if the liquid_level is above -1
-- @param curr table The current LPN
-- @param lpn  table The LPN to compare against
-- @return     bool  Is this LPN relevant
local function is_lpn_relevant(curr, lpn)
    return lpn.liquid_level >= 0 and (lpn.liquid_level == 0 or curr.liquid_id == lpn.liquid_id)
end

-- Gets all adjacent liquid nodes with the same liquid_id as curr
-- Gets all adjacent air nodes
-- @param b     table  Buffered LPN
-- @param curr  table  The current LPN
-- @return      table  Table of neighboring LPN
-- @return      number Number of neighbors
local function get_valid_neighbors(b, curr)
    local neighbors = {}
    local number_of_neighbors = 0
    for i = 1, number_of_offsets do
        local pos = add_offset_to_pos(curr.pos, offsets[i])
        local lpn = get_lpn_buffered(b, pos)

        if is_lpn_relevant(curr, lpn) then
            number_of_neighbors = number_of_neighbors + 1
            table.insert(neighbors, math.random(number_of_neighbors, 1), lpn)
        end
    end
    return neighbors, number_of_neighbors
end

-- Gets neighbors of curr and calculates the pressure
-- This function combines get_valid_neighbors and get_pressure_straight
-- @param b    table Buffered LPN
-- @param curr table The current LPN
-- @return     float Pressure of curr calculated from valid neighbors
local function get_valid_neigbor_pressure(b, curr)
    local number_of_neighbors = 0
    local total_liquid_level = curr.liquid_level
    for i = 1, number_of_offsets do
        local pos = add_offset_to_pos(curr.pos, offsets[i])
        local lpn = get_lpn_buffered(b, pos)

        if is_lpn_relevant(curr, lpn) then
            total_liquid_level = total_liquid_level + lpn.liquid_level / 2
            number_of_neighbors = number_of_neighbors + 1
        end
    end
    return total_liquid_level / (number_of_neighbors + 1)
end

-- Gets the pressure of curr from the neighbors given
-- @param b                   table  Buffered LPN
-- @param neighbors           table  Table of neighboring LPN
-- @param number_of_neighbors number Number of neighbors
-- @param curr                table  The current LPN
-- @return                    float  Pressure of curr calculated from neighbors
local function get_pressure_straight(b, neighbors, number_of_neighbors, curr)
    local total_liquid_level = curr.liquid_level

    for i = 1, number_of_neighbors do
        total_liquid_level = total_liquid_level + neighbors[i].liquid_level / 2
    end
    return total_liquid_level / (number_of_neighbors + 1)
end

-- Tries to move amount from "from" to "to"
-- Actual amount moved may not be the same as "amount"
--  therefore the actual amount moved is returned
-- @param from table  LPN from which amount is deducted
-- @param to   table  LPN to which amount is added
-- @return     number Actual amount moved
local function try_move(from, to, amount)
    if to.liquid_level >= 8 then
        return 0
    end
    local max_allowed = amount + 8 - (to.liquid_level + amount)
    local max_allowed_clamped = math.min(max_allowed, amount, from.liquid_level)

    internal.set_lpn(from.liquid_id, from, from.liquid_level - max_allowed_clamped)
    internal.set_lpn(from.liquid_id, to, to.liquid_level + max_allowed_clamped)

    if max_allowed_clamped ~= amount then
        return max_allowed_clamped
    end
    return amount
end

-- Calculates how to move curr_pos
-- @param b        table Buffered LPN
-- @param curr_pos table Current position
local function move(b, curr_pos)
    local curr_nbs
    local curr_nnbs
    local up_lpn

    --check down first
    local down_lpn = get_lpn_buffered(b, { x = curr_pos.x, y = curr_pos.y - 1, z = curr_pos.z })
    local curr_lpn = get_lpn_buffered(b, curr_pos)

    if curr_lpn.liquid_level <= 0 then
        internal.remove_node_to_check(curr_lpn.pos)
        return
    end

    curr_nbs, curr_nnbs = get_valid_neighbors(b, curr_lpn)

    if is_lpn_relevant(curr_lpn, down_lpn) then
        local moved = try_move(curr_lpn, down_lpn, curr_lpn.liquid_level)
        if moved > 0 then
            up_lpn = get_lpn_buffered(b, { x = curr_pos.x, y = curr_pos.y + 1, z = curr_pos.z })
            if up_lpn.liquid_level >= 0 then
                internal.add_node_to_check(up_lpn.pos)
            end
            internal.add_node_to_check(down_lpn.pos)
        end
        if moved == curr_lpn.liquid_level then
            internal.remove_node_to_check(curr_lpn.pos)
            for i = 1, curr_nnbs do
                internal.add_node_to_check(curr_nbs[i].pos)
            end
            return
        end
    end

    -- Every neighbor will be higher (except for air) so processing is done
    if curr_lpn.liquid_level <= 1 then
        internal.remove_node_to_check(curr_lpn.pos)
        return
    end

    local curr_prs = get_pressure_straight(b, curr_nbs, curr_nnbs, curr_lpn)

    if curr_prs >= 4.8 then --4.8 == ((8*4/2)+8)/5 -> meaning maximum pressure, implies no way to move
        internal.remove_node_to_check(curr_lpn.pos)
        return
    end

    -- TODO: Understand what is happening here and optimize
    local number_of_swaps = 0
    for i = 1, curr_nnbs do
        local next_lpn = curr_nbs[i]
        local next_prs = get_valid_neigbor_pressure(b, next_lpn)
        if curr_prs > next_prs and next_lpn.liquid_level < curr_lpn.liquid_level then
            if try_move(curr_lpn, next_lpn, 1) > 0 then
                internal.add_node_to_check(next_lpn.pos)
                internal.add_node_to_check(
                    get_lpn_buffered(b, { x = curr_pos.x, y = curr_pos.y + 1, z = curr_pos.z }).pos
                )
                number_of_swaps = number_of_swaps + 1
            end
        elseif curr_lpn.liquid_level < next_lpn.liquid_level then
            internal.add_node_to_check(next_lpn.pos)
        end
    end

    if number_of_swaps == 0 then
        internal.remove_node_to_check(curr_lpn.pos)
    end
end

core.register_on_mapblocks_changed(function(modified_blocks, modified_blocks_count)
    -- Buffered LPN
    local b = {}
    for hpos, pos in pairs(liquid_physics._nodes_to_check) do
        if core.compare_block_status(pos, "active") then
            move(b, pos)
        else
            internal.remove_node_to_check(pos)
        end
    end
    -- Update only changed nodes from buffer
    for _, lpn in pairs(b) do
        if lpn.init_liquid_level ~= lpn.liquid_level then
            internal.set_node(lpn)
        end
    end
end)
