local shared = ...
local S = shared.S
core.register_craftitem("rifles:shell_shotgundrop", {
	wield_scale = {x=2.5,y=1.5,z=1.0},
	inventory_image = "rifles_shelldrop_shotgun.png",
})

core.register_craftitem("rifles:shell_whitedrop", {
	wield_scale = {x=2.5,y=1.5,z=1.0},
	inventory_image = "rifles_shelldrop_white.png",
})

core.register_craftitem("rifles:shell_grenadedrop", {
	wield_scale = {x=2.5,y=1.5,z=3.0},
	inventory_image = "rifles_shelldrop_grenade.png",
})

core.register_craftitem("rifles:shelldrop", {
	wield_scale = {x=2.5,y=1.5,z=1.0},
	inventory_image = "rifles_shelldrop.png",
})
