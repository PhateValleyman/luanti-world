local modpath = core.get_modpath(core.get_current_modname())
local shared = {
	registered_rifles = {},
}
local player_cooldowns = {}
core.register_on_joinplayer(function(player, last_login) player_cooldowns[player:get_player_name()] = 0 end)
core.register_on_leaveplayer(function(player, timed_out) player_cooldowns[player:get_player_name()] = nil end)
local S = core.get_translator(core.get_current_modname())
shared.S = S
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

shared.register_rifle = function (name, def)
	accuracy.register(name)
	shared.registered_rifles[name] = true
	core.register_tool(name, def)
end

local function shoot_powergun(itemstack, player, pointed_thing)
	local PowerCaps = itemstack:get_definition()._rifle_traits

	local cooldown = PowerCaps.cooldown or 0
	local consumption = PowerCaps.consumption or 0

	local inv = player:get_inventory()

	if
		inv:contains_item("main", "powerguns:power " .. PowerCaps.consumption) and
			player_cooldowns[player:get_player_name()] < os.clock()
	 then
		player_cooldowns[player:get_player_name()] = os.clock() + cooldown

		local shoot_sound = PowerCaps.sound
		local initial_speed = PowerCaps.velocity or 20
		local projNum = PowerCaps.projectiles or 1
		local mobPen = PowerCaps.mob_penetration or 0
		local nodePen = PowerCaps.node_penetration or 0
		local power_durability = PowerCaps.durability or 0
		local gravity = PowerCaps.gravity or 0
		local door_breaking = PowerCaps.door_breaking or 0
		local projEnt = PowerCaps.entity or "powerguns:shot_bullet"
		local visualType = PowerCaps.visual or "wielditem"
		local texture = PowerCaps.texture or "powerguns:shot_bullet_visual"
		local ignite = PowerCaps.ignites_explosives or 0
		local size = PowerCaps.projectile_size or 0.0025


		local _rifle_traits = itemstack:get_definition()._rifle_traits
		local pos = player:get_pos()
		pos.y = pos.y + player:get_properties().eye_height
		local dir = player:get_look_dir()
		local yaw = player:get_look_horizontal()

		if pos and dir and yaw then
			core.sound_play(shoot_sound, {pos = pos, max_hear_distance = 500}, true)
			local user = player
			local projectiles = projNum or 1
			

			
			
			local deviated_dir = deviate(user:get_look_dir(),accuracy.get(player)/2)
			
			for i = 1, projectiles do
				local obj = core.add_entity(pos, "powerguns:shot_bullet")
				local ent = obj:get_luaentity()
				
				local deviated_dir = deviate(deviated_dir,(1-(PowerCaps.accuracy or 100)/100)/2)
				local velocity = vector.multiply(deviated_dir, initial_speed)

				obj:set_properties(
					{
						textures = {texture},
						visual = visualType,
						collisionbox = {-size, -size, -size, size, size, size},
						glow = 20
					}
				)
				ent.owner = player:get_player_name()
				if obj then
					ent.damage = _rifle_traits.damage
					ent.ignite = ignite
					ent.size = size
					ent.timer = 0 + (initial_speed / 2000)
					ent.wear = 0
					obj:set_velocity(velocity)
					obj:set_acceleration({x = 0, y = -gravity, z = 0})
					obj:set_rotation(vector.new(0, (math.atan2(deviated_dir.z, deviated_dir.x) - math.pi)%(math.pi*2), math.asin(deviated_dir.y)))
				end
			end
		end
		if core.settings:get_bool("rifles.gun_wear", true) then
			itemstack:add_wear(65535 / power_durability)
		end

		inv:remove_item("main", "powerguns:power " .. PowerCaps.consumption)
	end
	return itemstack
end

core.register_craftitem("powerguns:power", {
	description = S("Power Particle"),
	stack_max = 10000,
	inventory_image = "powerguns_power.png",
})

assert(loadfile(modpath .. "/ammo.lua"))(shared)
assert(loadfile(modpath .. "/crafting.lua"))(shared)

assert(loadfile(modpath .. "/forcegun.lua"))(shared)
assert(loadfile(modpath .. "/generator.lua"))(shared)

local players_shooting_automatic = {}

core.register_globalstep(function(dtime)
	for i = #players_shooting_automatic, 1, -1 do
		local playername = players_shooting_automatic[i]
		local player = core.get_player_by_name(playername)
		if player and player:get_player_control().dig and player:get_hp() > 0 then
			local itemstack = player:get_wielded_item()
			if itemstack:get_name() == "powerguns:rifle" and player_cooldowns[playername] < os.clock() then
				player:set_wielded_item(shoot_powergun(itemstack, player))
			end
		else
			table.remove(players_shooting_automatic, i)
		end
	end
end)

local function start_automatic(itemstack, user, pointed_thing)
	local name = user:get_player_name()
	for _,v in ipairs(players_shooting_automatic) do
		if v == name then return end
	end
	table.insert(players_shooting_automatic, name)
end

core.register_craftitem("powerguns:blue_ray_visual", {
	wield_scale = {x=1.75,y=1.75,z=1.75},
	inventory_image = "powerguns_blue_ray.png",
})

	shared.register_rifle("powerguns:pistol", {
	stack_max= 1,
	wield_scale = {x=1.15,y=1.15,z=1.15},
	description = S("Power Pistol"),
	range = 0,
	inventory_image = "powerguns_pistol.png",
_rifle_traits = {
		damage = {fleshy=15,knockback=0},
		velocity = 65,
		accuracy = 100,
		cooldown = 0.3,
		projectiles = 1,
		durability = 5000,
		sound = "powerguns_laser",
		door_breaking = 1,
		mob_penetration = 50,
		consumption = 10,
		visual = "wielditem",
		texture = "powerguns:blue_ray_visual",
		projectile_size = 0.1,
		ignites_explosives = 1,
	},
	on_use = shoot_powergun,
})

core.register_craftitem("powerguns:red_ray_visual", {
	wield_scale = {x=1.5,y=1.5,z=2.0},
	inventory_image = "powerguns_red_ray.png",
})

	shared.register_rifle("powerguns:rifle", {
	wield_scale = {x=1.9,y=1.9,z=2.5},
	description = S("Power Rifle"),
	range = 0,
_rifle_traits = {
		damage = {fleshy=12,knockback=0},
		velocity = 60,
		accuracy = 100,
		cooldown = 0.2,
		projectiles = 1,
		durability = 12500,
		sound = "powerguns_laser",
		door_breaking = 1,
		mob_penetration = 40,
		consumption = 8,
		visual = "wielditem",
		texture = "powerguns:red_ray_visual",
		projectile_size = 0.075,
		ignites_explosives = 1,
	},
	inventory_image = "powerguns_rifle.png",
	on_use = start_automatic,
})

shared.register_rifle("powerguns:shotgun", {
	stack_max= 1,
	wield_scale = {x=2.0,y=2.0,z=1.75},
	description = S("Power Shotgun"),
	range = 0,
	inventory_image = "powerguns_shotgun.png",
_rifle_traits = {
		damage = {fleshy=10,knockback=0},
		velocity = 55,
		accuracy = 40,
		cooldown = 0.5,
		durability = 2000,
		sound = "powerguns_laser",
		door_breaking = 1,
		mob_penetration = 40,
		consumption = 30,
		visual = "sprite",
		texture = "powerguns_green_ray.png",
		projectile_size = 0.005,
		projectiles = 6,
		ignites_explosives = 1,
	},
	on_use = shoot_powergun,
})


