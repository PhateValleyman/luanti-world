local modpath = core.get_modpath(core.get_current_modname())
local shared = {}
local registered_rifles = {}
local S = core.get_translator(core.get_current_modname())
shared.S = S
shared.reload_animation ={}
local player_data = {}
core.register_on_joinplayer(function(player, last_login) player_data[player:get_player_name()] = {cooldown = 0} end)
core.register_on_leaveplayer(function(player, timed_out) player_data[player:get_player_name()] = nil end)
local players_gain_pitch = {}
if core.global_exists("armor") and armor.attributes then
	table.insert(armor.attributes, "bullet_res")
	table.insert(armor.attributes, "ammo_save")
	table.insert(armor.attributes, "ranged_dmg")
end

local function create_quaternion(axis, angle)
	local half_angle = angle / 2
	local sin_half_angle = math.sin(half_angle)
	local cos_half_angle = math.cos(half_angle)

	return {
		w = cos_half_angle,
		x = axis.x * sin_half_angle,
		y = axis.y * sin_half_angle,
		z = axis.z * sin_half_angle,
	}
end

local function rotate_by_quaternion(v, q)
	local xx = q.x * q.x
	local yy = q.y * q.y
	local zz = q.z * q.z
	local xy = q.x * q.y
	local xz = q.x * q.z
	local yz = q.y * q.z
	local wx = q.w * q.x
	local wy = q.w * q.y
	local wz = q.w * q.z

	return {
		x = (1 - 2 * (yy + zz)) * v.x + (2 * (xy - wz)) * v.y + (2 * (xz + wy)) * v.z,
		y = (2 * (xy + wz)) * v.x + (1 - 2 * (xx + zz)) * v.y + (2 * (yz - wx)) * v.z,
		z = (2 * (xz - wy)) * v.x + (2 * (yz + wx)) * v.y + (1 - 2 * (xx + yy)) * v.z,
	}
end

local function deviate(dir, max_deviation)
	local axis = vector.normalize(vector.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5))
	local angle = math.random() * max_deviation
	local quaternion = create_quaternion(axis, angle)
	return rotate_by_quaternion(dir, quaternion)
end

shared.deviate = deviate

local function update_ammo_counter_on_gun(gunMeta)
	gunMeta:set_string("count_meta", tostring(gunMeta:get_int("bullets")))
end
local automatic_rifles = {}
local players_shooting_automatic = {}
local function start_automatic(itemstack, user, pointed_thing)
	local name = user:get_player_name()
	for _,v in ipairs(players_shooting_automatic) do
		if v == name then return end
	end
	table.insert(players_shooting_automatic, name)
end

local function count_items(player, item_name)
	local inv = player:get_inventory()
	local count = 0
	
	for i = 1, inv:get_size("main") do
		local stack = inv:get_stack("main", i)
		if stack:get_name() == item_name then
			count = count + stack:get_count()
		end
	end
	
	return count
end

local function finish_cooling(player_name)
	local player = core.get_player_by_name(player_name)
	if player then
		local data = player_data[player_name]
		local itemstack = player:get_wielded_item()
		if itemstack:get_name() == data.is_reloading and data.is_reloading ~= "rifles:rpg" then
			itemstack:get_meta():set_string("inventory_image", "")
			itemstack:get_meta():set_string("wield_image", "")
			player:set_wielded_item(itemstack)
		end
		data.cooldown = 0
		data.is_reloading = nil
	end
end

local finish_reloading = function(player_name, single_bullet)
	local player = core.get_player_by_name(player_name)
	if player then
		local data = player_data[player_name]
		if player:get_wielded_item():get_name() == data.is_reloading then
			local inv = player:get_inventory()
			local itemstack = player:get_wielded_item()
			local GunCaps = registered_rifles[itemstack:get_name()]
			if inv:contains_item("main", GunCaps.round) then
				local gunMeta = itemstack:get_meta()
				local bullets = gunMeta:get_int("bullets")
				
				local clipSize = GunCaps.clip_size
				local available = count_items(player, GunCaps.round)
				if single_bullet then available = math.min(available, 1) end
				local to_load = math.min(available, clipSize - bullets)
				inv:remove_item("main", GunCaps.round .. " " .. to_load)
				gunMeta:set_int("bullets", bullets + to_load)
				update_ammo_counter_on_gun(gunMeta)
			end
			if itemstack:get_name() ~= "rifles:rpg" then
				itemstack:get_meta():set_string("inventory_image", "")
				itemstack:get_meta():set_string("wield_image", "")
			end
			player:set_wielded_item(itemstack)
		end
		data.is_reloading = nil
		data.cooldown = 0
		accuracy.reset(player)
	end
end
local function try_rw_next_reload(player_name, n, dry_run) -- if n is false it's a single reload
	local player = core.get_player_by_name(player_name)
	if player then
		local itemstack = player:get_wielded_item()
		local animation = shared.reload_animation[itemstack:get_name()]
		local data = player_data[player:get_player_name()]
		if itemstack:get_name() == data.is_reloading and (not n or animation[n]) then
			local def = registered_rifles[itemstack:get_name()]
			if not n then
				if def.loaded_sound ~= nil then
					core.sound_play(def.loaded_sound, {pos = player:get_pos()}, true)
				end
				if not dry_run then
					finish_reloading(player_name, true)
					return
				end
				--don't return in order to reset the state
			else
				if animation[n].load_sound ~= nil then
					core.sound_play(animation[n].load_sound, {pos = player:get_pos()}, true)
				end
				local meta = itemstack:get_meta()
				meta:set_string("inventory_image", animation[1].inventory_image)
				meta:set_string("wield_image", animation[1].inventory_image)
				player:set_wielded_item(itemstack)
				n = n + 1
				if n > #animation then
					core.after(def.reload, finish_reloading , player_name)
					return
				else
					core.after(def.reload, try_rw_next_reload, player_name, n)
					return
				end
			end
		end
		-- abort
		if itemstack:get_name() == data.is_reloading then
			itemstack:get_meta():set_string("inventory_image", "")
			itemstack:get_meta():set_string("wield_image", "")
			player:set_wielded_item(itemstack)
		end
		data.cooldown = 0
		data.is_reloading = nil
		
	end
end

shared.start_reloading = function(player, single_bullet, rld_time, itemstack, dry_run)
	local player_name = player:get_player_name()
	local data = player_data[player_name]
	
	data.cooldown = math.huge
	
	itemstack = itemstack or player:get_wielded_item()
	data.is_reloading = itemstack:get_name()
	local def = registered_rifles[itemstack:get_name()]
	if single_bullet then
		local meta = itemstack:get_meta()
		local img = def.loaded_gun
		meta:set_string("inventory_image", img)
		meta:set_string("wield_image", img)
		player:set_wielded_item(itemstack)
		core.after(rld_time, try_rw_next_reload, player:get_player_name(), false, dry_run)
	else
		core.after(def.reload, try_rw_next_reload, player:get_player_name(),1)
	end
end


local mcl_core = core.get_modpath("mcl_core")
local has_x_player_api = core.get_modpath("x_player_api")
shared.register_rifle = function (name, def)
	if mcl_core then def.groups = {crossbow=5} end -- for player model stance in Mineclonia. Has no effect in VoxeLibre
	--x_player_api attributes
	def._wield_rotation = vector.new(-80,45,-80)
	def._wield_offset = vector.new(0,0,1)
	def._wield_scale = vector.multiply(def.wield_scale,0.8)
	
	accuracy.register(name)
	--~ assert(def._rifle_traits)
	registered_rifles[name] = def._rifle_traits
	local a = def._rifle_traits
	def._rifle_traits = nil
	def.range = 0
	def.on_secondary_use = shared.reload_gun
	def.short_description = S(def.description)
	def.description = def.short_description
	.."\n"..S("Ammunition")..": "..ItemStack(a.round):get_short_description()
	
	if a.automatic_gun then
		automatic_rifles[name] = true
		def.on_use = start_automatic
	else
		def.on_use = shared.shoot_gun
	end
	--~ assert(a.cooldown,name)
	--~ assert(a.round,name)
	--~ assert(a.clip_size,name)
	--~ assert(a.accuracy,name)
	core.register_tool(name, def)
	
	if has_x_player_api then
		x_player_api.register_item_action(name, {
		action = "bow_aim",
		shoot_action = "bow_aim",
		is_bow = true,}
	)
    
   	end
end

shared.reload_gun = function(itemstack, player)
	local gunMeta = itemstack:get_meta()
	if gunMeta:get_int("uld") == 1 then
		return shared.eject_shell(itemstack, player)
	end
	local GunCaps = registered_rifles[itemstack:get_name()]

	local unload_sound = ""
	if GunCaps ~= nil then
		unload_sound = GunCaps.unload_sound or ""
	end

	core.sound_play(unload_sound, {pos = player:get_pos()}, true)

	local clip_size = GunCaps.clip_size
	local inv = player:get_inventory()
	if
		player_data[player:get_player_name()].cooldown < os.clock() and
		inv:contains_item("main", GunCaps.round) and
		gunMeta:get_int("bullets") < clip_size
	then
		if GunCaps.load_single_bullet then
			return shared.start_reloading(player, true, GunCaps.reload, itemstack)
		else
			--~ if GunCaps.magazine ~= nil then
				--~ local pos = player:get_pos()
				--~ local dir = player:get_look_dir()
				--~ local yaw = player:get_look_horizontal()
				--~ if pos and dir and yaw then
					--~ pos.y = pos.y + 1.4
					--~ local obj = core.add_entity(pos, "rifles:mag")
					--~ if obj then
						--~ obj:set_properties({textures = {GunCaps.magazine}})
						--~ obj:set_velocity({x = dir.x * 2, y = dir.y * 2, z = dir.z * 2})
						--~ obj:set_acceleration({x = 0, y = -5, z = 0})
						--~ obj:set_rotation({x = 0, y = yaw - math.pi / 2, z = 0})
					--~ end
				--~ end
			--~ end

			shared.start_reloading(player)
		end
	end
end

shared.shoot_gun = function(itemstack, player)
	local gunMeta = itemstack:get_meta()
	if gunMeta:get_int("uld") == 1 then
		core.sound_play("rifles_empty", {to_player = player:get_player_name()}, true)
		return
	end
	local GunCaps = registered_rifles[itemstack:get_name()]
	
	local ammo_save = GunCaps.ammo_saving or 0
	local clock = os.clock()
	local player_name = player:get_player_name()
	if gunMeta:get_int("bullets") > 0 and player_data[player_name].cooldown < clock then
		local cooldown = GunCaps.cooldown or 0
		local endcooldown = clock + cooldown
		if cooldown > 0 then player_data[player_name].cooldown = endcooldown end

		if math.random(1, 100) > ammo_save then
			gunMeta:set_int("bullets", gunMeta:get_int("bullets") - 1)
		end

		update_ammo_counter_on_gun(gunMeta)

		local OnCollision = function()
		end

		local bulletStack = ItemStack({name = registered_rifles[itemstack:get_name()].round})
		local AmmoCaps = bulletStack:get_definition()._rifle_traits

		local bullet_damage = {fleshy = 0}
		local bullet_velocity = 0
		local bullet_ent = "rifles:shot_bullet"
		local bullet_visual = "wielditem"
		local bullet_texture = "rifles:shot_bullet_visual"
		local bullet_projMult = 1
		local bullet_mobPen = 0
		local bullet_nodePen = 0
		local bullet_shell_ent = "rifles:empty_shell"
		local bullet_shell_visual = "wielditem"
		local bullet_shell_texture = "rifles:shelldrop"
		local bullet_dps = 0
		local bullet_gravity = 0
		local bullet_particles = {}
		local bullet_size = 0
		local bullet_glow = 20

		local gun_damage = GunCaps.damage or {fleshy = 1}
		local gun_sound = GunCaps.sound or "rifles_glock"
		local gun_velocity = GunCaps.velocity or 20
		local gun_accuracy = GunCaps.accuracy or 100
		local gun_projectiles = GunCaps.projectiles or 1
		local gun_mobPen = GunCaps.mob_penetration or 0
		local gun_nodePen = GunCaps.node_penetration or 0
		local gun_shell = GunCaps.has_shell or 0
		local gun_durability = GunCaps.durability or 0
		local gun_dps = GunCaps.dps or 0
		local gun_gravity = GunCaps.gravity or 0
		local gun_smokeSize = GunCaps.smokeSize or 0

		if AmmoCaps ~= nil then
			OnCollision = AmmoCaps.OnCollision or function()
				end
			bullet_damage = AmmoCaps.ammo_damage or {fleshy = 1}
			bullet_velocity = AmmoCaps.ammo_velocity or 0
			bullet_ent = AmmoCaps.ammo_entity or "rifles:shot_bullet"
			bullet_visual = AmmoCaps.ammo_visual or "wielditem"
			bullet_texture = AmmoCaps.ammo_texture or "rifles:shot_bullet_visual"
			bullet_projMult = AmmoCaps.ammo_projectile_multiplier or 1
			bullet_mobPen = AmmoCaps.ammo_mob_penetration or 0
			bullet_nodePen = AmmoCaps.ammo_node_penetration or 0
			bullet_shell_ent = AmmoCaps.shell_entity or "rifles:empty_shell"
			bullet_shell_visual = AmmoCaps.shell_visual or "wielditem"
			bullet_shell_texture = AmmoCaps.shell_texture or "rifles:shelldrop"
			bullet_dps = AmmoCaps.ammo_dps or 0
			bullet_gravity = AmmoCaps.ammo_gravity or 0
			bullet_particles = AmmoCaps.ammo_particles or nil
			bullet_size = AmmoCaps.ammo_projectile_size or 0.0025
			bullet_glow = AmmoCaps.ammo_projectile_glow or 20
		end

		local initial_speed = gun_velocity + bullet_velocity
		local projNum = math.ceil(gun_projectiles * bullet_projMult)
		local mobPen = gun_mobPen + bullet_mobPen
		local nodePen = gun_nodePen + bullet_nodePen
		local dps = gun_dps + bullet_dps
		local dmg = {}
		local gravity = gun_gravity + bullet_gravity

		for k, gunDmg in pairs(gun_damage) do
			if bullet_damage[k] ~= nil then
				dmg[k] = gun_damage[k] + bullet_damage[k]
			else
				dmg[k] = gun_damage[k]
			end
		end
		for k, bulletDmg in pairs(bullet_damage) do
			if gun_damage[k] == nil then
				dmg[k] = bullet_damage[k]
			end
		end

		local pos = player:get_pos()
		pos.y = pos.y + player:get_properties().eye_height
		local dir = player:get_look_dir()
		local yaw = player:get_look_horizontal()
		local svertical = player:get_look_vertical()

		core.sound_play(gun_sound, {pos = pos, max_hear_distance = 500}, true)

		--~ if gun_shell > 0 and core.settings:get_bool("rifles.animate_empty_shells", true) then
			--~ local shl = core.add_entity(pos, bullet_shell_ent)
			--~ shl:set_rotation({x = 0, y = yaw - math.pi / 2, z = -svertical})
			--~ shl:set_properties(
				--~ {
					--~ textures = {bullet_shell_texture},
					--~ visual = bullet_shell_visual
				--~ }
			--~ )
		--~ end
		
		local projectiles = projNum or 1
		--increase pitch when shooting
		--~ local increment = math.rad(-10)*projectiles
		--~ table.insert(players_gain_pitch,{player_name,projNum and clock+0.1 or endcooldown,increment})


		if gun_smokeSize > 0 then
			core.add_particle(
				{
					pos = pos,
					velocity = {
						x = (dir.x * 3) + (math.random(-10, 10) / 10),
						y = (dir.y * 3) + (math.random(-10, 10) / 10),
						z = (dir.z * 3) + (math.random(-10, 10) / 10)
					},
					acceleration = {x = dir.x * -3, y = 2, z = dir.z * -3},
					expirationtime = math.random(5, 10) / 10,
					bullet_size = gun_smokeSize / 2,
					collisiondetection = false,
					vertical = false,
					texture = "rifles_smoke.png",
					glow = 5
				}
			)
		end

		local user = player
		
		local deviated_dir = deviate(user:get_look_dir(),accuracy.get(player)/2)
		
		accuracy.add(player, (1-(gun_accuracy or 100)/100)/2,(1-(gun_accuracy or 100)/100)/2*math.pi, endcooldown+0.1)
		
		for i = 1, projectiles do
			local obj = core.add_entity(pos, bullet_ent)
			local ent = obj:get_luaentity()
			local deviated_dir = deviated_dir
			if projectiles > 1 then
				deviated_dir = deviate(deviated_dir,(1-(gun_accuracy or 100)/100)/2)
			end
			local velocity = vector.multiply(deviated_dir, initial_speed)

			obj:set_properties(
				{
					textures = {bullet_texture},
					visual = bullet_visual,
					collisionbox = {-bullet_size, -bullet_size, -bullet_size, bullet_size, bullet_size, bullet_size},
					glow = bullet_glow
				}
			)
			ent.owner = player:get_player_name()
			if obj then
				ent.damage = dmg
				ent.OnCollision = OnCollision
				ent.mobPen = mobPen/100 or 0
				ent.nodePen = nodePen/100 or 0
				ent.dps = dps
				ent.bullet_particles = bullet_particles
				ent.size = bullet_size
				ent.timer = 0 + (initial_speed / 2000)
				ent.wear = 0
				--~ core.chat_send_all((1 - gun_accuracy/100))
				obj:set_velocity(velocity)
				obj:set_acceleration({x = 0, y = -gravity, z = 0})
				obj:set_rotation(vector.new(0, (math.atan2(deviated_dir.z, deviated_dir.x) - math.pi)%(math.pi*2), math.asin(deviated_dir.y)))
			end
		end

		if not core.is_creative_enabled(player_name,"creative") then
			itemstack:add_wear(65535 / gun_durability)
		end

		if GunCaps.cooling then
			if GunCaps.cooling == "uld" then
				gunMeta:set_int("uld", 1)
			elseif GunCaps.cooling:find("%.png$") then
				local data = player_data[player_name]
				data.cooldown = math.huge
				data.is_reloading = itemstack:get_name()
				local img = GunCaps.cooling
				gunMeta:set_string("inventory_image", img)
				gunMeta:set_string("wield_image", img)
				core.after(cooldown, finish_cooling, player:get_player_name() )
			else
				itemstack:set_name(GunCaps.cooling)
			end
		end
	end
	return itemstack
end

shared.eject_shell = function(itemstack, player) --always called from _uld weapons and turns them into _rld
	local rifle_def = registered_rifles[itemstack:get_name()]
	local rld_time = rifle_def.rld_time
	local rldsound = rifle_def.rld_sound
	
	itemstack:get_meta():set_string("uld", "")

	player_data[player:get_player_name()].cooldown = os.clock() + rld_time

	local bulletStack = ItemStack({name = rifle_def.round})

	local pos = player:get_pos()
	core.sound_play(rldsound, {pos = pos}, true)
	local dir = player:get_look_dir()
	local yaw = player:get_look_horizontal()
	if pos and dir and yaw then
		pos.y = pos.y + 1.6
		local obj = core.add_entity(pos, "rifles:empty_shell")

		if bulletStack ~= "" then
			local AmmoCaps = bulletStack:get_definition()._rifle_traits

			local bullet_shell_visual = AmmoCaps.shell_visual or "wielditem"
			local bullet_shell_texture = AmmoCaps.shell_texture or "rifles:shelldrop"

			obj:set_properties({textures = {bullet_shell_texture}})
			obj:set_properties({visual = bullet_shell_visual})
		end
		if obj then
			obj:set_velocity({x = dir.x * -10, y = dir.y * -10, z = dir.z * -10})
			obj:set_acceleration({x = dir.x * -5, y = -10, z = dir.z * -5})
			obj:set_yaw(yaw - math.pi / 2)
		end
	end
	return shared.start_reloading(player, true, rld_time, itemstack, true)
end

assert(loadfile(modpath .. "/misc.lua"))(shared)
assert(loadfile(modpath .. "/ammo.lua"))(shared)
assert(loadfile(modpath .. "/crafting.lua"))(shared)

assert(loadfile(modpath .. "/rifles.lua"))(shared)

assert(loadfile(modpath .. "/grenade.lua"))(shared)

core.register_entity("rifles:empty_shell", {
		initial_properties = {
			static_save = false,
			pointable = false,
			physical = false,
			visual = "wielditem",
			visual_size = {x = 0.3, y = 0.3},
			textures = {"rifles:shelldrop"},
		},
		timer = 0,
		on_activate = function (self, staticdata, dtime_s)
			self.lastpos = self.object:get_pos()
			self.object:set_acceleration(vector.new(0,-9.81,0))
		end,
		on_step = function(self, dtime, moveresult)
			self.timer = self.timer + dtime
			local pos = self.object:get_pos()
			
			if self.timer > 1.7 then
				core.sound_play("rifles_bulletdrop", {pos = self.lastpos, gain = 0.8}, true)
				self.object:remove()
				return
			end
			
			for pointed_thing in core.raycast(self.lastpos, self.object:get_pos(), false) do
				local node_pos = pointed_thing.under
				local node = core.get_node(node_pos)
				local node_def = core.registered_nodes[node.name]
				if node_def and node_def.walkable then
					core.sound_play("rifles_shellhit", {pos = pointed_thing.intersection_point, gain = 0.8}, true)
					self.object:set_acceleration(vector.new())
					self.object:set_velocity(vector.new())
					self.object:set_pos(vector.add(pointed_thing.intersection_point,vector.new(0,0.3,0)))
				end
			end
			
			self.lastpos = pos
		end
	})

local max_pitch = math.rad(90)
core.register_globalstep(function(dtime)
	local clock = os.clock()
	for i = #players_shooting_automatic, 1, -1 do
		local playername = players_shooting_automatic[i]
		local player = core.get_player_by_name(playername)
		if player and player:get_player_control().dig and player:get_hp() > 0 then
			local itemstack = player:get_wielded_item()
			if automatic_rifles[itemstack:get_name()] and player_data[playername].cooldown < clock then
				player:set_wielded_item(shared.shoot_gun(itemstack, player))
			end
		else
			table.remove(players_shooting_automatic, i)
		end
	end
	--~ for i = #players_gain_pitch, 1, -1 do
		--~ local t = players_gain_pitch[i]
		--~ local name = t[1]
		--~ local endtime = t[2]
		--~ local increment = t[3]
		--~ local player = core.get_player_by_name(name)
		--~ if player then
			--~ local current_pitch = player:get_look_vertical()
			--~ current_pitch = current_pitch + dtime * increment
			--~ if current_pitch > max_pitch then
				--~ current_pitch = max_pitch
			--~ end
			--~ player:set_look_vertical(current_pitch)
		--~ end
		--~ if clock > endtime then
			--~ table.remove(players_gain_pitch,i)
		--~ end
	--~ end
	for _, player in pairs(core.get_connected_players()) do
		local data = player_data[player:get_player_name()]
		if player:get_player_control().zoom and player:get_wielded_item():get_definition().weapon_zoom then
			if not data.original_zoom then
				if not data.scope then
					data.scope = player:hud_add({
						type = "image",
						position = { x=0.5, y=0.5 },
						scale = { x=-100, y=-100 },
						text = "rifles_scopehud.png",
					})
				end
				local wpn_zoom = player:get_wielded_item():get_definition().weapon_zoom
				data.original_zoom = player:get_properties().zoom_fov
				player:set_properties({zoom_fov = wpn_zoom})
			end
		elseif data.original_zoom then
			if data.scope then
				player:hud_remove(data.scope)
				data.scope = nil
			end
			player:set_properties({zoom_fov = data.original_zoom})
			data.original_zoom = nil
		end
	end
end)

for k,_ in pairs(registered_rifles) do
	assert(registered_rifles[k].reload,k)
end