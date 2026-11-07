minetestd.register_on_teleportplayer = function(func)--function(player, oldpos, newpos)
	table.insert(minetestd.teleport_callbacks, func)
end

if not minetestd.services.teleport_callback.initialized then
	minetestd.teleport_callbacks = {}
	minetestd.playerctl.register_metatable_change(
		function(metatable)
			local mto = metatable.move_to
			local sps = metatable.set_pos
			metatable.set_pos_nc = sps
			metatable.move_to_nc = mto
			 --[[
			  _nc = No-callbacks. 
			  Should only be used if you REALLY need default functions. If you do, but don't want to use these, 
			  toggle off minetestd.services.teleport_callback.enabled just before your call, 
			  then set it to its original value right afterward. 
			 
			  If you're just having issues with a callback behavior defined in your mod,
			  you may want to create a local variable to toogle suppression of your specific call.
			 ]]
			metatable.move_to = function(self, pos, ...)
				if minetestd.services.teleport_callback.enabled and self:is_player() then
					for _,call in pairs(minetestd.teleport_callbacks) do
						if call(self, self:get_pos(), pos) then return end
					end
				end
				mto(self,pos,...)
			end
			metatable.moveto = metatable.move_to --???
		
			metatable.set_pos = function(self, pos, ...)
				if minetestd.services.teleport_callback.enabled and self:is_player() then
					for _,call in pairs(minetestd.teleport_callbacks) do
						if call(self, self:get_pos(), pos) then return end
					end
				end
				sps(self,pos,...)
			end
		
			metatable.setpos = metatable.set_pos
		end
	)
end