minetestd.register_service("error_notify", {
	description = "Chat-based error notification system",
	stop = function() 
		minetestd.services.error_notify.enabled = false
	end,
	start = function() 
		minetestd.services.error_notify.enabled = dofile(minetestd.modpath.."/services/error_notify.lua")
		minetestd.services.error_notify.enabled = true
		return true
	end,
})
minetestd.register_service("playerctl", {
	description = "Player-step and simplified player data storage",
	stop = function() 
		if minetestd.services.playerctl.initialized then
			for _,player in pairs(minetest.get_connected_players()) do 
				minetestd.playerctl.on_leave(player)
			end
		end
		minetestd.services["playerctl"].enabled = false
	end,
	start = function() 
		minetestd.services.playerctl.enabled = dofile(minetestd.modpath.."/services/playerctl.lua")
		return true
	end,
})

minetestd.register_service("teleport_callback", {
	description = "register_on_teleportplayer callback handler",
	stop = function()
		minetestd.services["teleport_callback"].enabled = false
	end,
	start = function()
		dofile(minetestd.modpath.."/services/teleport_callback.lua")
		minetestd.services["teleport_callback"].enabled = true
		return true
	end,
	depends = {playerctl=true}
	
})

minetestd.register_service("kill_callback", {
	description = "register_on_killplayer callback handler",
	stop = function()
		minetestd.playerctl.steps["kill_callback"] = nil
		minetestd.services["kill_callback"].enabled = false
	end,
	start = function()
		dofile(minetestd.modpath.."/services/kill_callback.lua")
		minetestd.services["kill_callback"].enabled = true
		return true
	end,
	depends = {playerctl=true}
})

minetestd.register_service("extras", {
	description = "Extra utilities and functions",
	start = function() 
		dofile(minetestd.modpath.."/services/extras.lua")
		return true
	end,
})


minetestd.register_service("physicsctl", {
	description = "Player Physics Daemon (physicsctl)",
	stop = function() 
		minetestd.services["physicsctl"].enabled = false
		minetestd.playerctl.steps["physicsctl"] = nil
		for _,player in pairs(minetest.get_connected_players()) do 
			player:set_physics_override({gravity=1,speed=1,jump=1})
		end
	end,
	start = function() 
		dofile(minetestd.modpath.."/services/physicsctl.lua")
		return true
	end,
	depends = {playerctl=true}
})

minetestd.register_service("gravityctl", {
	description = "Dummy service for deprecated gravityctl system",
	start = function() minetestd.services["gravityctl"].enabled = true; return true end,
	stop = function() minetestd.services["gravityctl"].enabled = false end,
	depends = {physicsctl=true},
})
