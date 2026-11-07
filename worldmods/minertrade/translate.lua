local ngettext

if minetest.get_translator ~= nil and minetest.get_current_modname ~= nil and minetest.get_modpath(minetest.get_current_modname()) then
	modMinerTrade.translate = minetest.get_translator(minetest.get_current_modname())
else
	modMinerTrade.translate = function(s) return s end
end
