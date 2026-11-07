local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local formname = "mystart:rules"
local accepted_key = "mystart:rules_accepted"

local rules_file = io.open(modpath .. "/rules.txt", "r")
local rules_text

if rules_file then
	rules_text = rules_file:read("*all") or ""
	rules_file:close()
else
	rules_text = "Server rules are currently unavailable. Please contact an administrator."
	minetest.log("error", "[mystart] Unable to read " .. modpath .. "/rules.txt")
end

local function show_rules(player)
	local player_name = player:get_player_name()
	local formspec = table.concat({
		"formspec_version[4]",
		"size[12,9]",
		"bgcolor[#0E1AD8;true]",
		"textarea[0.5,0.5;11,6.5;rules;;",
		minetest.formspec_escape(rules_text),
		"]",
		"label[3,7.3;Do you agree to follow the rules?]",
		"button_exit[2,8;3,0.8;yes;YES]",
		"button_exit[7,8;3,0.8;no;NO]"
	})
	minetest.show_formspec(player_name, formname, formspec)
end

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	if meta:get_string(accepted_key) == "true" then
		return
	end

	-- Remove interaction until the player explicitly accepts the rules.
	local player_name = player:get_player_name()
	local privileges = minetest.get_player_privs(player_name)
	privileges.interact = nil
	minetest.set_player_privs(player_name, privileges)

	show_rules(player)
end)

minetest.register_on_player_receive_fields(function(player, received_formname, fields)
	if received_formname ~= formname then
		return false
	end

	local player_name = player:get_player_name()

	if fields.yes then
		local privileges = minetest.get_player_privs(player_name)
		privileges.shout = true
		privileges.interact = true
		privileges.home = true
		privileges.fast = true
		privileges.creative = true
		player:get_meta():set_string(accepted_key, "true")
		minetest.set_player_privs(player_name, privileges)
		minetest.chat_send_player(player_name, "Rules accepted. Creative mode is enabled.")
		return true
	end

	if fields.no then
		minetest.kick_player(player_name, "You need to agree to the rules to play!")
		return true
	end

	return false
end)
