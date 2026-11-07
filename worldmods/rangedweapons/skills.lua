local S = minetest.get_translator("rangedweapons")

local skill_list = {
	{id = "handgun_skill", name = "Handgun"},
	{id = "mp_skill", name = "Machine Pistol"},
	{id = "smg_skill", name = "S.M.G."},
	{id = "shotgun_skill", name = "Shotgun"},
	{id = "heavy_skill", name = "Heavy MG"},
	{id = "arifle_skill", name = "A.Rifle"},
	{id = "revolver_skill", name = "Revolver/magnum"},
	{id = "rifle_skill", name = "Rifle"},
	{id = "throw_skill", name = "Throwing weapons"},
}

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()

	for _, skill in ipairs(skill_list) do
		if meta:get_int(skill.id) == 0 then
			meta:set_int(skill.id, 100)
		end
	end
end)

minetest.register_chatcommand("gunskills", {
	description = S("Show your weapon skills"),
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, S("This command can only be used by a connected player.")
		end

		local meta = player:get_meta()
		local rows = {
			"size[11,7]",
			"label[0,0;Gun efficiency: increases damage, accuracy and critical chance.]"
		}
		local positions = {
			{x = 0, y = 1, image = "handgun", id = "handgun_skill", label = "Handgun"},
			{x = 0, y = 2, image = "machinepistol", id = "mp_skill", label = "M.Pistol"},
			{x = 0, y = 3, image = "smg", id = "smg_skill", label = "S.M.G."},
			{x = 0, y = 4, image = "shotgun", id = "shotgun_skill", label = "Shotgun"},
			{x = 0, y = 5, image = "heavy", id = "heavy_skill", label = "Heavy MG"},
			{x = 0, y = 6, image = "arifle", id = "arifle_skill", label = "A.Rifle"},
			{x = 5, y = 1, image = "revolver", id = "revolver_skill", label = "Revolver"},
			{x = 5, y = 2, image = "rifle", id = "rifle_skill", label = "Rifle"},
			{x = 5, y = 3, image = "yeetable", id = "throw_skill", label = "Throwing"},
		}

		for _, entry in ipairs(positions) do
			local value = meta:get_int(entry.id)
			rows[#rows + 1] = string.format(
				"image[%d,%d;1,1;rangedweapons_%s_img.png]label[%d,%0.1f;%s efficiency: %d%%]",
				entry.x, entry.y, entry.image, entry.x + 1, entry.y + 0.2,
				entry.label, value
			)
		end

		rows[#rows + 1] = "button_exit[9,0;2,1;exit;Done]"
		minetest.show_formspec(name, "rangedweapons:gunskills_form", table.concat(rows))
		return true
	end,
})

local min_gun_efficiency = tonumber(
	minetest.settings:get("rangedweapons_min_gun_efficiency")
) or 40
local timer = 0
local degradation_interval = 60

minetest.register_globalstep(function(dtime)
	if minetest.settings:get_bool("creative_mode", false) then
		timer = 0
		return
	end

	timer = timer + dtime
	if timer < degradation_interval then
		return
	end
	timer = 0

	for _, player in ipairs(minetest.get_connected_players()) do
		local meta = player:get_meta()
		local player_name = player:get_player_name()

		for _, skill in ipairs(skill_list) do
			local value = meta:get_int(skill.id)
			if value > min_gun_efficiency and math.random(1, 40) == 1 then
				value = value - 1
				meta:set_int(skill.id, value)
				minetest.chat_send_player(
					player_name,
					minetest.colorize("#ff0000", S("@1 skill degraded!", S(skill.name)))
				)
			end
		end
	end
end)
