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
local internal_bucket = dofile(modpath .. "/bucket.lua")

internal_bucket.register_empty_bucket("bucket:bucket_empty")

-- Settings

if core.settings:get_bool("liquid_physics_enable_water_physics", true) then
    liquid_physics.register_liquid("default", "water_source", "water_flowing")
    internal_bucket.register_filled_bucket("bucket:bucket_water")
end
if core.settings:get_bool("liquid_physics_enable_lava_physics", true) then
    liquid_physics.register_liquid("default", "lava_source", "lava_flowing")
    internal_bucket.register_filled_bucket("bucket:bucket_lava")
end
