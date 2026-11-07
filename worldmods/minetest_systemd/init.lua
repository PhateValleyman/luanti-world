
-- A work-in-progress universal minetest utility
minetestd = {}
minetestd.modpath = minetest.get_modpath("minetest_systemd")
minetestd.services = {}
minetestd.service_load_order = {}

minetestd.register_service = function(name, service)
	minetestd.services[name] = service
	minetestd.services[name].initialized = false
	minetestd.services[name].enabled = false
	minetestd.services[name].depends = service.depends or {}
	for depend,_ in pairs(service.depends) do
		if not minetestd.services[depend] or not minetestd.services[depend].enabled then
			print("[ Failed ] Service "..name.." could not be initialized. (Missing dependency: \""..depend.."\").")
			return
		end
	end
	if minetestd.services[name].start then 
		minetestd.services[name].initialized = minetestd.services[name].start() 
		if not minetestd.services[name].initialized then 
			print("[ Failed ] Service "..name.." could not be initialized. (Start call failed).") 
			return 
		else
			print("[   OK   ] "..(minetestd.services[name].description or name).." loaded.")
			table.insert((minetestd.service_load_order), name)
		end
		
		
	else
		print("[  Warn  ] Service "..name.." has no start call, initializing with default.")
		minetestd.services[name].start = function() minetestd.services[name].enabled = true; return true end
		minetestd.services[name].initialized = minetestd.services[name].start()
	end
end

dofile(minetestd.modpath.."/globalstep.lua")

minetestd.register_service("core", {
	description = "Minetestd core service",
	--allows minetestd to be handled as a service, to some extent
	start = function() 
		dofile(minetestd.modpath.."/chatcommands.lua")
		dofile(minetestd.modpath.."/basic_services.lua")
		minetestd.services["core"].enabled = true
		return true
	end,
	stop = function()
		minetestd.services["core"].enabled = false
	end
})