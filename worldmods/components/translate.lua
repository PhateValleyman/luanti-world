local ngettext

if minetest.get_translator ~= nil and minetest.get_current_modname ~= nil and minetest.get_modpath(minetest.get_current_modname()) then
	modComponents.translate = minetest.get_translator(minetest.get_current_modname())
elseif minetest.get_modpath("intllib") then
	if intllib.make_gettext_pair then
		-- New method using gettext.
		modComponents.translate, ngettext = intllib.make_gettext_pair()
	else
		-- Old method using text files.
		modComponents.translate = intllib.Getter()
	end
else
	modComponents.translate = function(s) return s end
end
