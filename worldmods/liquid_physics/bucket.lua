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

local internal_bucket  = {}

local wear_levels      = {}
wear_levels[1]         = 65535
wear_levels[2]         = 57337
wear_levels[3]         = 49146
wear_levels[4]         = 40955
wear_levels[5]         = 32764
wear_levels[6]         = 24573
wear_levels[7]         = 16382
wear_levels[8]         = 8191
wear_levels[9]         = 0

local base_mcl_buckets = core.get_modpath("mcl_buckets")
local base_default     = core.get_modpath("default")

local function check_protection(pos, name, text)
    if core.is_protected(pos, name) then
        core.log("action", (name ~= "" and name or "A mod")
            .. " tried to " .. text
            .. " at protected position "
            .. core.pos_to_string(pos)
            .. " with a bucket")
        core.record_protection_violation(pos, name)
        return true
    end
    return false
end

function internal_bucket.get_wear(liquid_level)
    return wear_levels[liquid_level + 1]
end

function internal_bucket.get_liquid_level(wear)
    for i = 1, 9 do
        if wear_levels[i] == wear then
            return i - 1
        end
    end
end

local function set_bucket_item_liquid_level(item, liquid_level)
    local meta = item:get_meta()

    meta:set_string("description",
        ItemStack(item:get_name()):get_description() .. " " .. liquid_level .. "/8")

    item:set_wear(internal_bucket.get_wear(liquid_level))
end

local function mcl_get_pointed_thing(usr)
    local start = usr:get_pos()
    start.y = start.y + usr:get_properties().eye_height
    local look_dir = usr:get_look_dir()
    local _end = vector.add(start, vector.multiply(look_dir, 5))

    local ray = core.raycast(start, _end, false, true)
    for pointed_thing in ray do
        local name = core.get_node(pointed_thing.under).name
        local def = core.registered_nodes[name]
        if not def or def.drawtype ~= "flowingliquid" then
            return pointed_thing
        end
    end
end

local function get_bucket_name_empty()
    if base_default then
        return "bucket:bucket_empty"
    elseif base_mcl_buckets then
        return "mcl_buckets:bucket_empty"
    end
    return nil
end

local function get_bucket_name_filled(source_name)
    if base_default then
        return bucket.liquids[source_name].itemname
    elseif base_mcl_buckets then
        return mcl_buckets.liquids[source_name].bucketname
    end
    return nil
end

local function get_liquid_name(bucket_name)
    if base_default then
        for source, b in pairs(bucket.liquids) do
            if b.itemname and b.itemname == bucket_name then
                return b.source
            end
        end
    elseif base_mcl_buckets then
        -- TODO: How Should I handle this then...
        return mcl_buckets.buckets[bucket_name].source_take[1]
    end
    return nil
end

local function bucket_on_use(on_use_fallback, itemstack, user, pointed_thing)
    if pointed_thing.type == "object" then
        pointed_thing.ref:punch(user, 1.0, { full_punch_interval = 1.0 }, nil)
        return user:get_wielded_item()
    elseif pointed_thing.type ~= "node" then
        return
    end

    local held_bucket_name = itemstack:get_name()

    local is_bucket_filled = held_bucket_name ~= get_bucket_name_empty()
    local bucket_contents = is_bucket_filled and get_liquid_name(held_bucket_name)
    local bucket_fill_level = internal_bucket.get_liquid_level(itemstack:get_wear())

    local liquid = liquid_physics.get_liquid_at(pointed_thing.under)

    -- Bucket is filled and pointed at liquid is not registered
    -- -> Don't scoop
    if bucket_contents and liquid == nil then
        return itemstack
    end

    -- Pointed at liquid is not registered
    -- -> Scoop via fallback
    if liquid == nil then
        return on_use_fallback(itemstack, user, pointed_thing)
    end

    -- Bucket is filled and pointed at liquid is of different kind
    -- -> Don't scoop
    local liquid_source_name = liquid_physics.get_liquid_node_names(liquid.liquid_id)[8]
    if bucket_contents and bucket_contents ~= liquid_source_name then
        return itemstack
    end

    local node = core.get_node(pointed_thing.under)

    if check_protection(pointed_thing.under,
            user:get_player_name(),
            "take " .. node.name) then
        return
    end

    local bucket_name_filled = get_bucket_name_filled(liquid_source_name)

    -- Don't know how to handle
    -- -> Fallback
    if bucket_name_filled == nil then
        return on_use_fallback(itemstack, user, pointed_thing)
    end

    local item_bucket = ItemStack(bucket_name_filled)
    if not is_bucket_filled then
        set_bucket_item_liquid_level(item_bucket, liquid.liquid_level)

        local item_count = user:get_wielded_item():get_count()
        if item_count > 1 then
            local inv = user:get_inventory()
            if inv:room_for_item("main", { name = bucket_name_filled }) then
                inv:add_item("main", item_bucket)
            else
                local pos = user:getpos()
                pos.y = math.floor(pos.y + 0.5)
                core.add_item(pos, item_bucket)
            end

            -- set to return empty buckets minus 1
            item_bucket = ItemStack(get_bucket_name_empty() .. tostring(item_count - 1))
        end

        liquid_physics.set_liquid_at(pointed_thing.under, 0, 0)
        return item_bucket
    else
        local give_amount = math.min(8 - bucket_fill_level, liquid.liquid_level)

        set_bucket_item_liquid_level(item_bucket, bucket_fill_level + give_amount)
        liquid_physics.set_liquid_at(pointed_thing.under, liquid.liquid_id, liquid.liquid_level - give_amount)

        return item_bucket
    end
end

local function bucket_on_place(on_place_fallback, bucket_liquid_id, source_name, itemstack, user, pointed_thing)
    -- Must be pointing to node
    if pointed_thing.type ~= "node" then
        return
    end

    local node = core.get_node(pointed_thing.under)
    local node_def = core.registered_nodes[node.name]

    if not node_def then
        return itemstack
    end

    -- Call on_rightclick if the pointed node defines it
    if node_def.on_rightclick and
        not (user and user:is_player() and
            user:get_player_control().sneak) then
        return node_def.on_rightclick(
            pointed_thing.under,
            node, user,
            itemstack)
    end

    -- Where to place the liquid at
    local place_at_pos

    if node_def.buildable_to then
        place_at_pos = pointed_thing.under
    else
        place_at_pos = pointed_thing.above

        node = core.get_node(place_at_pos)

        local node_above_def = core.registered_nodes[node.name]

        if not node_above_def or not node_above_def.buildable_to then
            return itemstack
        end
    end

    if check_protection(place_at_pos, user
            and user:get_player_name()
            or "", "place " .. source_name) then
        return
    end

    local liquid_level = internal_bucket.get_liquid_level(itemstack:get_wear())
    local liquid = liquid_physics.get_liquid_at(place_at_pos)

    if liquid == nil then
        if liquid_physics.set_liquid_at(place_at_pos, bucket_liquid_id, liquid_level) then
            return ItemStack(get_bucket_name_empty())
        end
        return itemstack
    end

    if liquid.liquid_id == bucket_liquid_id then
        local give_amount = math.min(8 - liquid.liquid_level, liquid_level)
        if liquid_physics.set_liquid_at(place_at_pos, bucket_liquid_id, liquid.liquid_level + give_amount) then
            if give_amount == liquid_level then
                return ItemStack(get_bucket_name_empty())
            end
            set_bucket_item_liquid_level(itemstack, liquid_level - give_amount)
            return itemstack
        end
        return itemstack
    end
end

function internal_bucket.register_empty_bucket(bucket_name)
    local bucket_tool = core.registered_items[bucket_name]

    if base_default then
        local on_use_fallback = bucket_tool.on_use
        core.override_item(bucket_name, {
            on_use = function(itemstack, user, pointed_thing)
                return bucket_on_use(on_use_fallback, itemstack, user, pointed_thing)
            end
        }, nil)
    elseif base_mcl_buckets then
        local on_use_fallback = bucket_tool.on_place
        if core.settings:get_bool("liquid_physics_voxelibre_enable_scooping_via_use", true) then
            core.override_item(bucket_name, {
                on_use = function(itemstack, user, pointed_thing)
                    return bucket_on_use(on_use_fallback, itemstack, user, pointed_thing)
                end
            }, nil)
        end
        core.override_item(bucket_name, {
            on_place = function(itemstack, user, pointed_thing)
                local use_select_box = core.settings:get_bool("mcl_buckets_use_select_box", false)
                if use_select_box == false then
                    -- TODO: Understand why this is nil
                    if user.get_pos == nil then
                        return itemstack
                    end
                    pointed_thing = mcl_get_pointed_thing(user)
                end
                return bucket_on_use(on_use_fallback, itemstack, user, pointed_thing)
            end
        }, nil)
    end
end

function internal_bucket.register_filled_bucket(name)
    local bucket_tool = core.registered_items[name]

    local source_name = get_liquid_name(name)
    if source_name == nil then
        error("Liquid Physics: Could not register bucket. Liquid for bucket " .. name .. " was not found")
    end
    local bucket_liquid_id = liquid_physics.get_liquid_id(source_name)
    if bucket_liquid_id == nil then
        error("Liquid Physics: Could not register bucket. Liquid " ..
            source_name .. " was not registered with liquid physics.")
    end

    if base_default then
        local on_place_fallback = bucket_tool.on_place
        local on_use_fallback = bucket_tool.on_place
        core.override_item(name, {
            on_use     = function(itemstack, user, pointed_thing)
                return bucket_on_use(on_use_fallback, itemstack, user, pointed_thing)
            end,
            on_place   = function(itemstack, user, pointed_thing)
                return bucket_on_place(on_place_fallback, bucket_liquid_id, source_name, itemstack, user, pointed_thing)
            end,
            wear_color = {
                blend = "linear",
                color_stops = {
                    [0.0] = "#ff0000",
                    [0.5] = "slateblue",
                    [1.0] = { r = 0, g = 255, b = 0, a = 150 },
                }
            },
        }, nil)

        core.register_tool(":" .. name, core.registered_items[name])
    elseif base_mcl_buckets then
        local on_place_fallback = bucket_tool.on_place
        if core.settings:get_bool("liquid_physics_voxelibre_enable_scooping_via_use", true) then
            local on_use_fallback = bucket_tool.on_use
            core.override_item(name, {
                on_use = function(itemstack, user, pointed_thing)
                    return bucket_on_use(on_use_fallback, itemstack, user, pointed_thing)
                end
            }, nil)
        end
        core.override_item(name, {
            on_place = function(itemstack, user, pointed_thing)
                return bucket_on_place(on_place_fallback, bucket_liquid_id, source_name, itemstack, user, pointed_thing)
            end,
            wear_color = {
                blend = "linear",
                color_stops = {
                    [0.0] = "#ff0000",
                    [0.5] = "slateblue",
                    [1.0] = { r = 0, g = 255, b = 0, a = 150 },
                }
            },
        }, nil)

        core.register_tool(":" .. name, core.registered_items[name])
    end
end

return internal_bucket
