minetest.register_globalstep(function(dtime)
	if not minetestd.services["core"].enabled then return end
	for _,service in pairs(minetestd.services) do
		if service.enabled and service.step then service.step(dtime) end
	end
end)