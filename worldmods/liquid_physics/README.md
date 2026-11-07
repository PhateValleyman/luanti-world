# Liquid Physics

This Luanti mod adds physics to liquids.

This mod is in early alpha.

## What NOT to expect

- Proper water equalization and water pressure *
- Removing weeds and other wall mounted items *
- Interaction of different liquid types, e.g. lava and water *
- Interaction with pistons or pipes
- Perfect performance
- Integration with any other mods *
- A smooth liquid surface
- Viscosity for different liquid types

* to an extend

## What to expect

- Water leveling for flat surfaces
- Settling water
- Multi-level liquids from 1 to 8
- Draining all oceans in a jiffy

## API

- Other developers may chose to support this mod by using the API.
```lua
--Example: Register default:water_source
liquid_physics.register_liquid("default", "water_source", "water_flowing")

--Example: Register bucket:bucket_water to scoop up liquids
liquid_physics.register_bucket("bucket:bucket_water")

--Example: Check if block underneath is liquid and then proceed to reduce its level
local id_water = liquid_physics.get_liquid_id("default:water_source")
local liquid = liquid_physics.get_liquid_at(pos)

if liquid and liquid.liquid_id == id_water then
    liquid_physics.set_liquid_at(pos, id_water, liquid.liquid_level - 1)
end
```
