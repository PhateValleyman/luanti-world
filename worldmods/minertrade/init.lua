modMinerTrade = {
	modName = core.get_current_modname(),
	modPath = core.get_modpath(core.get_current_modname()),
	save_compressed = (core.settings:get_bool("minertrade.save_compressed") ~= false),
	bank = {
		accounts = 0,
		last_pay = 0,
		player = { },
	},
}

dofile(modMinerTrade.modPath.."/translate.lua") -- <== Antes de 'api.lua'!
dofile(modMinerTrade.modPath.."/api.lua")
dofile(modMinerTrade.modPath.."/item_paper_written.lua")
dofile(modMinerTrade.modPath.."/item_exchange_table.lua")
dofile(modMinerTrade.modPath.."/item_dispensing_machine.lua")
dofile(modMinerTrade.modPath.."/item_atm.lua")
--dofile(modMinerTrade.modPath.."/item_strongbox.lua")
--dofile(modMinerTrade.modPath.."/item_strongbox_old.lua")
dofile(modMinerTrade.modPath.."/item_minercash.lua")
dofile(modMinerTrade.modPath.."/item_computing_app.lua")
--dofile(path.."/item_rent_door.lua")
dofile(modMinerTrade.modPath.."/api_payday.lua")
--dofile(modMinerTrade.modPath.."/commands.lua")

--if modMinerTrade.doBankLoad ~= nil then
	modMinerTrade.doBankLoad()
--end

core.log('action',"["..modMinerTrade.modName:upper().."] Loaded!")
