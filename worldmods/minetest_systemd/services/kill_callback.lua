if not minetestd.services.kill_callback.initialized then
	minetestd.kill_callbacks = {}
end

minetestd.playerctl.register_playerstep("kill_callback", {
	func = function(player, dtime)
		if minetestd.playerctl.players[player:get_player_name()].kill_callback then
			if minetestd.playerctl.players[player:get_player_name()].kill_callback.remember > 0 then
				minetestd.playerctl.players[player:get_player_name()].kill_callback.remember = minetestd.playerctl.players[player:get_player_name()].kill_callback.remember - dtime
			else
				minetestd.playerctl.players[player:get_player_name()].kill_callback = nil
			end
		end
	end,
	save = false,
})

minetest.register_on_punchplayer(function(player, puncher)
	if player and puncher and puncher:is_player() then
		minetestd.playerctl.players[player:get_player_name()].kill_callback = {
			remember = 2,
			["puncher"] = puncher
		}
	end
end)

minetestd.register_on_killplayer = function(callback)
	table.insert(minetestd.kill_callbacks, callback)
end

minetest.register_on_dieplayer(function(victim)
	if not minetestd.services.kill_callback.enabled then return end
	if not minetestd.playerctl.players[victim:get_player_name()].kill_callback then return end
	local killer = minetestd.playerctl.players[victim:get_player_name()].kill_callback.puncher
	if not killer:is_player() then return end
	for _,call in pairs(minetestd.kill_callbacks) do 
		call(killer, victim, killer:get_wielded_item())
	end
	minetestd.playerctl.players[victim:get_player_name()].kill_callback = nil
end)