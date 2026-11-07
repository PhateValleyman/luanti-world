if not minetestd.services.physicsctl.initialized then
minetestd.physicsctl = {}

minetestd.physicsctl.worldPhysics = {gravity=1,speed=1,jump=1} -- Base
minetestd.physicsctl.effectOrder = {} 
minetestd.physicsctl.effectOrder[1] = {} 
minetestd.physicsctl.effectOrder[2] = {} 
minetestd.physicsctl.effectOrder[3] = {}
minetestd.physicsctl.effectOrder[4] = {}
minetestd.physicsctl.effectOrder[5] = {}
minetestd.physicsctl.effectOrder[6] = {}  
minetestd.physicsctl.effectOrder[7] = {} 
minetestd.physicsctl.effectOrder[8] = {}  
minetestd.physicsctl.effectOrder[9] = {}
minetestd.physicsctl.effectOrder[10] = {} 
minetestd.physicsctl.effectOrder[11] = {}

end

minetestd.physicsctl.raiseOrder = function(newMax) -- If you must, you may.
	if not type(newMax) == "number" then return end
	while #(minetestd.physicsctl.effectOrder) < newMax do
		minetestd.physicsctl.effectOrder[#(minetestd.physicsctl.effectOrder)+1] = {}
	end
	
end
minetestd.physicsctl.register_physics_effect = function(name, checkFunction--[[player]], blendFunction--[[physics_before_blend, player]], order)
	if not minetestd.physicsctl.effectOrder[order] then return end
	minetestd.physicsctl.effectOrder[order][name] = {
		check=checkFunction,
		blend=blendFunction
	}
end

minetestd.playerctl.register_playerstep("physicsctl", {
	getNewData = function() return {gravity=1,speed=1,jump=1} end,
	func = function(player) 
		local phys = table.copy(minetestd.physicsctl.worldPhysics)
		for _,order in pairs(minetestd.physicsctl.effectOrder) do
			for _,effect in pairs(order) do
				if effect.check(player) then
					effect.blend(phys, player)
				end
			end
		end
		local name = player:get_player_name()
		for k,v in pairs(phys) do
			if minetestd.playerctl.players[name][k] ~= phys[k] then
				player:set_physics_override(phys)
				--minetest.chat_send_player(name, k.." changed to "..tostring(phys[k])..", physics will update.")
				minetestd.playerctl.players[name] = minetestd.tables.merge_tables(
					minetestd.playerctl.players[name], 
					phys
				)
				break
			end
		end
	end,
	save = false
})

-- Deprecated gravityctl stuff

minetestd.gravityctl = {}
minetestd.gravityctl.register_gravity_effect = function(name, checkFunction--[[player]], blendFunction--[[gravity_before_blend, player]], order)
	minetest.log("deprecated", "minetestd.gravityctl is deprecated. Please use physicsctl instead, which can control speed and jump as well.")
	order = order or 11
	minetestd.physicsctl.register_physics_effect(name, checkFunction, 
	function(phys, player)
		phys.gravity = blendFunction(phys.gravity, player)
	end,
	order)
	
end

minetestd.services["physicsctl"].enabled = true

minetestd.physicsctl.register_physics_effect("sitting",
	function(player)
		return (default and default.player_attached[player:get_player_name()])
	end,
	function(phys)
		phys.jump = 0
		phys.gravity = 0
		phys.speed = 0
	end,
	11
)
return