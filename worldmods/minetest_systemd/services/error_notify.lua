minetestd.error_notify = {}

if not minetestd.services.error_notify.initialized then
	minetest.register_on_joinplayer(function(player) --Annoy the admin/singleplayer if errors occur
		minetestd.error_notify.notify(player)
	end)
end
minetestd.error_notify.errors = {}
minetestd.error_notify.notify = function(player)
	if not minetestd.services.error_notify.enabled then return end
	if minetest.is_singleplayer() or 
		minetest.check_player_privs(
			player:get_player_name(), 
			{debug=true}
		)
	then
		minetest.after(3, function(name) 
				for _,message in pairs(minetestd.error_notify.errors) do
					minetest.chat_send_player(name, minetest.colorize("#FF0", message))
				end
			end,
			player:get_player_name()
		)
	end
end