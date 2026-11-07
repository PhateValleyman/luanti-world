# minetest_systemd

*This project is not affiliated with, sponsored by, nor endorsed by Lennart Poeterring or the systemd project.*


This mod adds multiple tools for mod-makers and subgame-makers to make their mods more powerful, more efficient, and compatible.

It also features a system for mods to register services to make parts of their code toggleable or even reloadable mid-game without having to restart the server.

---

## The basics

*The minetestd global object contains all of the tools provided by minetest_systemd.*

---


### Registering a service

"Services" are reloadable, toggleable components designed to work cleanly together in an 
environment where any service on which others depend may be disabled, enabled or restarted.
Typically, if your mod registers a service, you'll want to put the register_service call in init.lua,
and the code for the service itself in a separate `service.lua`, which should be run from inside
the service's start function. This way, the code inside service.lua will be refreshed when the service
is restarted, allowing changes to be applied without restarting your server.
If your mod does not heavily depend on minetest_systemd's features, you can also check to see if
minetest_systemd is not present, and simply run service.lua on its own in init, while, of course, 
taking precautions to ensure the service can stand on its own in 
the absense of minetest_systemd without causing errors.

```lua
minetestd.register_service(service_name, { -- Example service definition table
    description = "Readable Service Name",
        -- This is printed in the chat log when the service loads successfully.
        -- That's about all it's used for.
    start = function() --Called at init, and whenever the service is started, or restarted.
        dofile(mymod.modpath.."/service.lua")
             -- Note: Make sure that the register_service call is not inside code that
             -- could be executed in start(), or you could end up with an infinite recursive loop.
        if mymod.setup_success then
            minetestd.services[service_name].enabled = true
             -- Services have to set themselves to an enabled state.
        end
        return mymod.setup_success 
             -- return value to minetestd.services[service_name].initialized 
             -- If a service fails to initialize, it can't be started.
    end,
    stop = function() 
            -- Called when this service is disabled, either because it was stopped manually,
            -- reloaded, or automatically disabled because one of its dependencies was disabled.
        minetestd.services[service_name].enabled = false
        mymod.service_active = false
    end,
    step = function(dtime)
        -- Called in globalstep.lua when both this service and core are enabled.
        mymod.minetestd_step()
    end,
    depends = {some_other_service=true}
         -- Services that need to be enabled for this service to start.
         -- If a dependency is absent when the service is registered,
         -- this service's initialization will fail, and start() will not be called.
})
```

### Chat commands

**/minetestd** *Used for managing services*

Usage:

 - /minetestd start/enable (service name or '\*' for all services)

 - /minetestd stop/disable (service name or '\*' for all services)

 - /minetestd status (service name or '\*' for all services)

 - /minetestd services (optional search pattern)

Privs: {server=true}


**/groups** *List item/node groups of held item*

Privs: {debug=true}


**/getwear** *Print wear value of held item*

Privs: {debug=true}


**/getlight** *Print details about the light where the player is standing*

Privs: {}


**/setgravity** *Set the default world gravity in physicsctl*

Usage: /setgravity (number, default is 1)

Privs: {setphysics=true}


**/setspeed** *Set the default player speed in physicsctl*

Usage: /setspeed (number, default is 1)

Privs: {setphysics=true}


**/setjump** *Set the default jump height in physicsctl*

Usage: /setjump (number, default is 1)

Privs: {setphysics=true}

---

## PlayerCTL

*This service provides tools for managing data associated with players, registering player steps, and modifying the player metatable*

---

### Player-steps

```lua
minetestd.playerctl.register_playerstep(step_name, { -- Example playerstep definition table
    
    getNewData = function(player) -- Can be nil
        --[[
            This function will be called whenever a player joins the server,
            and they don't already have saved data for this playerstep.
            minetestd.playerctl.players[player:get_player_name()][step_name] 
            will be set to the returned value.
            It can be any type, as long as you know how to handle it.
            If you plan on saving the data, don't put userdata values in here, or
            anything else that can't be serialized.
       ]] 
       return doStuff(player:get_player_name()) 
    end,
    
    func = function(player, dtime) -- Can be nil
        -- This is the function that will be called on a globalstep for each player.
        -- Put whatever code you like in here, or don't.
    end,
    
    save = true,
        --[[
            Bool or nil. If true, this step's data will be stored as part of a serialized
            copy of minetestd.playerctl.players[playername] when the
            player leaves the game. If false or nil, then
            minetestd.playerctl.players[playername][step_name] will become nil
            when the data is saved.
       ]]
    interval = 0.5 -- Can be nil
        --[[
            Number or nil. If defined, this step will be run on this interval,
            If nil, will run on the same interval as a regular global step.
            Interval can not be shorter than the world step rate
        ]]
    dt -- Used internally for tracking the interval. Do not set.
})

minetestd.playerctl.delete_step(step_name)
    -- Deletes a registered playerstep, and clears all of its data from currently logged in players.
```

### Editing offline playerdata
```lua
minetestd.playerctl.edit_offline(function(player_name, func, param, moreparams, ...))
    --[[
        Syntax for this is the same as minetest.after, except the first parameter,
        which is the name of the player to load, edit, save, and then unload.
        This will briefly conjure minetestd.playerctl.players[player_name] 
        into existence for you to modify with the function passed as parameter 2.
        Note that this will NOT call any step's getNewData functions,
        because the player isn't actually here.
        You will have to account for the possibility of a step's data being nil.
    ]]
```

### Simply queue changes to the player object metatable
```lua
minetestd.playerctl.register_metatable_change(function(metatable))
    -- Schedules a change to the player object metatable, once it becomes available.
```

---

## Extra tools and utilities

*minetestd.math, minetestd.tables and minetestd.utils contain some useful functions that are missing from minetest's global object*

---

### minetestd.math
```lua
minetestd.math.sortp(minp, maxp)
    -- Returns a pair (minp,maxp) with all of the lower coordinates in minp and the higher in maxp.

minetestd.math.volume_in_volume(minp1,maxp1,minp2,maxp2)
    -- Returns true if the volumes defined by (minp1,maxp1) and (minp2,maxp2) intersect.
    -- Positions do not have to be sorted, this uses minetestd.math.sortp.

minetestd.math.get_volume_in_volume(minp1,maxp1,minp2,maxp2)
    -- Returns a minp, maxp pair of the volume where the volumes 
    -- defined by (minp1,maxp1) and (minp2,maxp2) intersect.
    -- If they do not interserct, nil is returned.

minetestd.math.pos_in_volume(pos,minp,maxp)
    -- Returns true if pos is in the volume defined by (minp,maxp)
    -- Volume positions do not have to be sorted, this uses minetestd.math.sortp.
```

### minetestd.tables
```lua
minetestd.tables.get_keytable(t)
    -- Returns a numbered list of the keys in table t

minetestd.tables.merge_tables(t1, t2, func, ...)
    -- Merges t1 and t2 into a new, combined table, which is then returned.
    -- When both tables have a value for a key, func will be called
    -- with t1's value as the first parameter, 
    -- t2's as the second, the shared key third, followed by ...
    -- If func is nil, values from t2 will be given priority over t1's.

minetestd.tables.smart_merge_values(v1, v2, unused, shallow_tables)
    -- A function for "intelligently" merging two values.
    -- Designed for use as parameter 3 of minetestd.tables.merge_tables,
    -- but can be used anywhere.
    
    -- parameter 3 is unused. In merge_tables, it would recieve the key.
    
    -- If used on two positions, it will act about the same as vector.add (unless shallow_tables is true)
    -- Can also be used to merge tables, or compose functions.
    
    -- Exact behavior (in order of priority):
    -- Table and table: merge using smart_merge_values as the merge function, 
    -- unless shallow_tables is true, in which case, no function will be used.
    -- Table and other: other will be inserted into table using lua's table.insert.
    -- Userdata and anything: Return v2.
    -- Function and function: return composed function v1(v2(...))
    -- Function and other: Return v2.
    -- String and string: Concatenate
    -- String and other: Concatenate
    -- Number and number: Add
    -- Number and bool: Add (bool to 1 or 0)
    -- Bool and bool: logical or operator
    -- Other: Return v2
```

### minetestd.utils
```lua
minetestd.utils.check_item_match(item_name, match)
    -- Checks for a match between an item name, and 
    -- (another item name, a group name, or a list of mixed names and groups)
    -- Returns the string that successfully matched. 
    -- If a table is given, it will return the first match it finds.
    -- minetest:node can also be used to check if the item is a node.
    -- This function is NOT PERFECT. Also, it will search tables recursively, 
    -- as deep as it can go, to find a match, but will only return a value from the top-level table.
    -- Does not serch keys, only values.
    -- This is what minetestd.tables.get_keytable is for.

minetestd.utils.is_solid_block(pos)
    --Returns true if the node at pos is a regular, solid, one-meter cube.
    --Returns true for unknown nodes as well, since they behave this way.
    --Returns true for CONTENT_IGNORE

minetestd.utils.get_artificial_light(pos)
    -- Returns the light value from light_source nodes at pos
    -- A temporary substitute for https://github.com/minetest/minetest/pull/5680, 
    -- until it is merged into an official release.
    
minetestd.utils.get_sky_light_fast(pos)
    -- Returns the light value from the sky (at noon) at pos.
    -- Because of the weird way that light is stored in param1, 
    -- this may not always be accurate.
    -- You will have to do day/night calculations on your own.
    -- A temporary substitute for https://github.com/minetest/minetest/pull/5680, 
    -- until it is merged into an official release.

minetestd.utils.get_natural_light(pos, max_steps)
    -- Returns the light value from the sky (at noon) at pos.
    -- You will have to do day/night calculations on your own.
    -- max_steps is optional, and will default to 6, which should be 
    -- more than enough for most purposes.
    -- This function performs a search to find all possible sources of sky light
    -- outward from the given position. By default, it will only perform its search-loop
    -- 6 times, unless max_steps is specified. be warned that this function is
    -- significantly slower than minetestd.utils.get_sky_light_fast, 
    -- and increasing the value of max_steps can increase the calculation load up to quadratically.
    -- A temporary substitute for https://github.com/minetest/minetest/pull/5680, 
    -- until it is merged into an official release.

minetestd.utils.parse_chatargs(argstring)
    -- Splits argstring on each whitespace character.
    -- Returns a pair of (args,argc), where args is a table containing the separated arguments,
    -- and argc is the number of arguments.

minetestd.utils.pos_to_shorthand(pos)
    -- Convert a position to a filename-friendly, 
    -- but still semi-readable shorthand format containing only characters [0-9_].

minetestd.utils.shorthand_to_pos(str)
    -- Translate shorthand string back to a position vector.

```

---

## Error notification system

*For when something goes wrong, and someone REALLY needs to know about it*

---

Normally, when you have an error in your mod that isn't crash-worthy, but needs to be mentioned, 
your only options for letting players know about it are to either put a message in the terminal 
(Which average users may never see), or use a chat message, which, if you're running a server, 
is tricky to implement,  with some methods resulting in everyone on the server seeing your 
error (Fufufu, how embarrassing), or even just resulting in the message being printed 
when no one's online, into a total void where no one can hear it scream...

minetestd.error_notify is a simple tool you can use to add messages that will be printed 
upon joining, to players with the "debug" privilege only, or to singleplayer
(i.e. the people who can and should do something about them).

To add a notification to the error notifier, simply insert the string to be printed in the table
`minetestd.error_notify.errors`, at a key that you'll remember, so that you can remove the error
when the user is able to correct it and reload the service.

To remove a notification, just remove it from `minetestd.error_notify.errors`, either by setting
its key to `nil`, or by using `table.remove`, or however you prefer.

---

## Teleport and Playerkill callbacks

*More useful stuff that's missing from minetest's global object*

---

```lua
minetestd.register_on_teleportplayer(function(player, old_pos, new_pos))
    -- Registers a function to be called whenever a player is moved with set_pos or move_to.
    -- If the function returns anything other than false/nil, the teleport is cancelled.

minetestd.register_on_killplayer(function(killer, victim, weapon))
    -- Registers a function to be called whenever one player kills another player. 
    -- 'weapon' is killer:get_wielded_item().

```
---

## PhysicsCTL

*This service organizes player physics modifiers and combines them in a way that allows effects to coexist, blend, or cancel each other out in a linear order that makes sense*

---

### Defining a physics modifier
```lua
minetestd.physicsctl.register_physics_effect(name, checkfunction, blendfunction, order)
--[[
    name: The name of this effect
    checkfunction(player): 
        A function that should return true if the modifier should be applied.
    blendfunction(physics, player): 
        A function that should modify its physics parameter to apply the effect.
        It does not need to return anything. 
        The physics table is fresh with each globalstep, and all of the effects are re-applied, 
        so it is safe to interact with its old values without worrying about some number going crazy.
    order: 
        A number value that determines when in the effect-order the effect will be applied.
        Lower numbers will be applied before higher ones. By default, there are 11 orders.
        This should be enough for most purposes.
        If you need more for some reason, use minetestd.physicsctl.raiseOrder(new maximum)
]]
```

**Recommended effect order:**

1: Environment (outer space, in certain nodes/areas)

Even numbers: In-between, do what you will with it.

3: Any kind of permanent effect specific to one player

5: Equipment/armor effects

7: Other equipment/held item effects

9: Potion or entity effects

11: Total physics override (for whatever reason)

### Changing the default physics

minetestd.physicsctl.worldPhysics contains the "default" physics table,

that all registered effects are given to modify in order, until all effects have

been checked (and applied if applicable), and then the final result

is set to the player's physics.

This process is repeated every globalstep, for every player.

As a result, changing minetestd.physicsctl.worldPhysics will

instantly change the physics of all connected players accordingly.

/setgravity, /setjump and /setspeed all work by modifying this.

In most cases, it is probably cleaner and more reliable to just register an effect with an order of 1.
