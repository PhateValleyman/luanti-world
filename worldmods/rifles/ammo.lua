local shared = ...
local S = shared.S

if core.get_modpath("tnt") then
	shared.boom = function(pos, data, player_name)
		if not player_name then player_name = "" end
		if not core.is_protected(pos, player_name) then
			core.set_node(pos, {name = "tnt:tnt"})
			local meta = core.get_meta(pos)
			meta:set_string("owner", player_name or "")
			tnt.boom(pos, data)
		end
	end
elseif core.get_modpath("mcl_core") then
	shared.boom = function(pos, data, player_name)
		local e = core.add_entity(pos, "mcl_tnt:tnt")
		if e then
			e:get_luaentity().timer = tnt.BOOMTIMER
		end
	end
else
	shared.boom = function(pos, data, player_name)
	end
end


local glass_nodes = {} -- do not insert glass that isn't guaranteed to be there because it's used for reversing too
local mod_vessels = core.get_modpath("vessels")
do
	local full_glass = {
		"default:glass",
		"mcl_core:glass"
	}
	for _,v in ipairs(full_glass) do
		local olddef
		if core.registered_nodes[v] then
			glass_nodes[v] = "rifles:broken_glass"
			olddef = core.registered_nodes[v]
		end
		if olddef then
			local def = table.copy(olddef)
			def.damage_per_second = 2
			def.walkable = false
			def.drop = mod_vessels and "vessels:glass_fragments" or ""
			def.tiles = {"rifles_broken_glass.png"}
			def.groups.not_in_creative_inventory = 1
			core.register_node("rifles:broken_glass", def)
		end
	end
	
	local panes = {
		"xpanes:pane",
		"xpanes:pane_flat",
		"xpanes:pane_natural",
		"xpanes:pane_natural_flat",
		"mcl_panes:pane_natural",
		"mcl_panes:pane_natural_flat",
	}
	local function add_broken_pane(pane)
		local newname = "rifles:broken_"..pane:gsub("^.*:","")
		local olddef = core.registered_nodes[pane]
		local def = table.copy(olddef)
		def.damage_per_second = 2
		def.walkable = false
		def.tiles = {"rifles_broken_glass.png"}
		def.groups.not_in_creative_inventory = 1
		def.drop = mod_vessels and {
			max_items = 1,
			items = {
				{
					items = {"vessels:glass_fragments"},
					rarity = 3,
				},
			},
		} or "",
		core.register_node(newname,def)
		glass_nodes[pane] = newname
	end
	for _,v in ipairs(panes) do
		if core.registered_nodes[v] then add_broken_pane(v) end
	end
end

local function swap_multiple_nodes_by_name(player_name, node_mappings, radius)
	local player = core.get_player_by_name(player_name)
	if not player then
		core.chat_send_player(player_name, "Player not found.")
		return
	end
	local pos = player:get_pos()
	for dx = -radius, radius do
		for dy = -radius, radius do
			for dz = -radius, radius do
				local target_pos = vector.new(pos.x + dx, pos.y + dy, pos.z + dz)
				local old_node = core.get_node(target_pos)
				local new_node_name = node_mappings[old_node.name]
				if new_node_name then
					old_node.name = new_node_name
					core.set_node(target_pos, old_node)
				end
			end
		end
	end
end

core.register_chatcommand("glassrepair", {
	description = S("Repairs glass destroyed by weapons from the Rifles mod."),
	privs = {server = true},
	func = function(name, param)
		local undo_glass = {}
		for k,v in pairs(glass_nodes) do undo_glass[v] = k end
		swap_multiple_nodes_by_name(name, undo_glass,50)
	end,
})

core.register_craftitem(
	"rifles:shot_bullet_visual",
	{
		wield_scale = {x = 1.0, y = 1.0, z = 1.0},
		inventory_image = "rifles_bulletshot.png"
	}
)

local use_particles = core.settings:get_bool("rifles.impact_particles", true)
local max_lifetime = tonumber(core.settings:get("rifles.bullet_lifetime")) or 10.0

local function play_dig_sound(node, hit_pos)
	local nodedef = core.registered_nodes[node.name]
	if nodedef and nodedef.sounds and (nodedef.sounds.dig or nodedef.sounds.dug) then
		core.sound_play((nodedef.sounds.dig or nodedef.sounds.dug).name, {pos = hit_pos}, true)
	end
end

local tool_caps = {
	full_punch_interval = 1.4, -- default hand punch interval
	max_drop_level = 0,
	groupcaps = {
		crumbly = {times = {[2]=1, [3]=1/2}},
		cracky = {times = {[3]=4}},
		snappy = {times = {[3]=1/2}},
		choppy = {times = {[3]=1}},
		
		axey = {times = {[1]=1}},
		shovely = {times = {[1]=1}},
		hoey = {times = {[1]=1}},
		pickaxey = {times = {[1]=4}},
		swordy = {times = {[1]=1/2}},
		swordy_cobweb = {times = {[1]=1/2}},
		shearsy = {times = {[1]=1/2}},
		shearsy_wool = {times = {[1]=1/2}},
		shearsy_cobweb = {times = {[1]=1/2}},
	},
	damage_groups = {fleshy=1},
}
local function node_penetration_chance(node_def)
	--~ dump2(node_def.groups)
	local diggable = core.get_dig_params(node_def.groups, tool_caps)
	--~ core.chat_send_all("Mining time for " .. node_def.name .. " with no tool: " .. (1/diggable.time))
	return 1/diggable.time
end

local function add_penetration_particle(pos, dir)
	core.add_particle({
		pos = pos,
		velocity = vector.new(0.5*dir.x, 1, 0.5*dir.z),
		expirationtime = 1.25,
		size = math.random(3,6),
		texture = "rifles_smoke.png",
		glow = 2,
	})
end

core.register_entity("rifles:shot_bullet", {
	timer = 0,
	initial_properties = {
		static_save = false,
		pointable = false,
		physical = false,
		hp_max = 420,
		glow = 100,
		visual = "wielditem",
		visual_size = {x = 0.75, y = 0.75},
		textures = {"rifles:shot_bullet_visual"},
		lastpos = {},
		collide_with_objects = true,
		collisionbox = {-0.0025, -0.0025, -0.0025, 0.0025, 0.0025, 0.0025}
	},
	_ricochet = 0,
	on_activate = function (self, staticdata, dtime_s)
		self._old_pos = self.object:get_pos()
	end,
on_step = function(self, dtime, moveresult)
	if self.owner == nil then
		self.object:remove()
		return
	end

	local size = self.size or 0.0025
	local pos = self.object:get_pos()
	local SBP = self.bullet_particles
	if SBP ~= nil then
		for i = 1, math.random(SBP.amount[1], SBP.amount[2]) do
			core.add_particle(
				{
					pos = {
						x = pos.x + (math.random(-SBP.pos_randomness, SBP.pos_randomness) / 100),
						y = pos.y + (math.random(-SBP.pos_randomness, SBP.pos_randomness) / 100),
						z = pos.z + (math.random(-SBP.pos_randomness, SBP.pos_randomness) / 100)
					},
					velocity = {
						x = math.random(-SBP.velocity.x, SBP.velocity.x),
						y = math.random(-SBP.velocity.y, SBP.velocity.y),
						z = math.random(-SBP.velocity.z, SBP.velocity.z)
					},
					acceleration = {
						x = math.random(-SBP.acceleration.x, SBP.acceleration.x),
						y = math.random(-SBP.acceleration.y, SBP.acceleration.y) - SBP.gravity,
						z = math.random(-SBP.acceleration.z, SBP.acceleration.z)
					},
					expirationtime = SBP.lifetime,
					size = math.random(SBP.minsize, SBP.maxsize) / 10,
					collisiondetection = SBP.collisiondetection,
					vertical = false,
					texture = SBP.texture,
					animation = {type = "vertical_frames", aspect_w = 8, aspect_h = 8, length = SBP.lifetime + 0.1},
					glow = SBP.glow
				}
			)
		end
	end

	self.timer = self.timer + dtime

	if self.timer >= 0 then
		self.object:set_properties({collide_with_objects = true})
		self.object:set_properties({collisionbox = {-size, -size, -size, size, size, size}})
	end

	if self.timer > max_lifetime then
		self.object:remove()
		return
	end
	local hit_anything = false
	for pointed_thing in core.raycast(self._old_pos, self.object:get_pos(), true, true) do
		hit_anything = true
		local hit_pos = pointed_thing.intersection_point

		if pointed_thing.type == "node" and (not self.penetrated_pos or not (vector.distance(self.penetrated_pos,pointed_thing.under) < 1.74) ) then
			local node_pos = pointed_thing.under
			local node = core.get_node(node_pos)
			local node_def = core.registered_nodes[node.name]
			if node_def and node_def.walkable then
				core.check_for_falling(node_pos)

				if use_particles and node_def and node_def.tiles and node_def.tiles[1] then
					local hit_texture =	node_def.tiles[1]

					if hit_texture.name ~= nil then
						hit_texture = hit_texture.name
					end

					-- does not face the right direction because of a limitation in the current particle system
					-- https://github.com/minetest/minetest/issues/15574
					core.add_particle(
						{
							pos = hit_pos,
							expirationtime = 30,
							size = math.random(10, 20) / 10,
							texture = "rifles_bullethole.png",
						}
					)

					for i = 1, math.random(4, 8) do
						core.add_particle(
							{
								pos = hit_pos,
								velocity = {
									x = math.random(-3.0, 3.0),
									y = math.random(2.0, 5.0),
									z = math.random(-3.0, 3.0)
								},
								acceleration = {
									x = math.random(-3.0, 3.0),
									y = math.random(-10.0, -15.0),
									z = math.random(-3.0, 3.0)
								},
								expirationtime = 0.5,
								size = math.random(10, 20) / 10,
								collisiondetection = true,
								vertical = false,
								texture = "" .. hit_texture .. "^[resize:4x4" .. "",
								glow = 0
							}
						)
					end
				end

				play_dig_sound(node, hit_pos)

				if node.name == "tnt:tnt" and not core.is_protected(node_pos, self.owner) then
					core.set_node(node_pos,{name="tnt:tnt_burning"})
					core.get_node_timer(node_pos):start(0)
				elseif node.name == "mcl_tnt:tnt" and not core.is_protected(node_pos, self.owner) then
					local e = tnt.ignite(node_pos)
					if e then
						e:get_luaentity().timer = tnt.BOOMTIMER
					end
				end

				if glass_nodes[node.name] and not core.is_protected(node_pos, self.owner) then
					node.name = glass_nodes[node.name]
					core.swap_node(node_pos, node)
					if node_def.sounds and node_def.sounds.dug then
						core.sound_play(node_def.sounds.dug, {pos = node_pos}, true)
					end
				end

				local function make_sparks(pos)
					core.sound_play("rifles_ricochet", {pos = pos, gain = 0.75}, true)
					for i = 1, 9 do
						core.add_particle(
							{
								pos = pos,
								velocity = {
									x = math.random(-6.0, 6.0),
									y = math.random(-10.0, 15.0),
									z = math.random(-6.0, 6.0)
								},
								acceleration = {
									x = math.random(-9.0, 9.0),
									y = math.random(-15.0, -3.0),
									z = math.random(-9.0, 9.0)
								},
								expirationtime = 1.0,
								size = math.random(1, 2),
								collisiondetection = true,
								vertical = false,
								texture = "rifles_spark.png",
								glow = 25
							}
						)
					end
				end

				if core.get_item_group(node.name, "level") > 1 then
					self.hit_leaves = false
					make_sparks(hit_pos)

					local node_pos = node_pos
					local node = core.get_node(node_pos)

					local normal = vector.new(0, 0, 0)
					if pointed_thing.intersection_normal then normal = pointed_thing.intersection_normal end 

					-- Reflect the bullet
					local incoming_vec = self.object:get_velocity()
					local reflected_vec = vector.subtract(incoming_vec, vector.multiply(normal, 2 * vector.dot(incoming_vec, normal)))

					-- Set new velocity
					self.object:set_velocity(reflected_vec)

					-- Update rotation to match new velocity
					local yaw = math.atan2(reflected_vec.z, reflected_vec.x)
					local pitch = math.asin(-reflected_vec.y / vector.length(reflected_vec))
					self.object:set_rotation({x = pitch, y = yaw, z = 0})

					-- Move the bullet slightly above the hit position
					local new_pos = vector.add(hit_pos, vector.multiply(normal, 0.001))
					self.object:set_pos(new_pos)
					self._ricochet = self._ricochet + 1
					if self._ricochet > 2 then
						self.object:remove()
					end
					
					break
				else
					
					if not self.penetrated_pos and math.random() < self.nodePen*node_penetration_chance(node_def) then
						self.penetrated_pos = hit_pos
						play_dig_sound(node, hit_pos)
						add_penetration_particle(hit_pos, vector.direction(hit_pos, self._old_pos))
					else
						if core.get_item_group(node.name, "leaves") > 0 then
							if not self.hit_leaves then
								self.hit_leaves = true
								play_dig_sound(node, hit_pos)
								for i = 1, math.random(3, 6) do
									core.add_particle(
										{
											pos = hit_pos,
											velocity = {
												x = math.random(-2, 2),
												y = math.random(3, 6),
												z = math.random(-2, 2)
											},
											acceleration = {
												x = math.random(-2, 2),
												y = math.random(-3, -6),
												z = math.random(-2, 2)
											},
											expirationtime = math.random(2, 4),
											size = math.random(6, 9),
											collisiondetection = true,
											collision_removal = false,
											vertical = false,
											texture = "rifles_leaf.png",
											animation = {
												type = "vertical_frames",
												aspect_w = 8,
												aspect_h = 8,
												length = 0.8
											},
											glow = 15
										}
									)
								end
							end

							--~ self.object:set_properties({collisionbox = {0, 0, 0, 0, 0, 0}})
							--~ self.object:set_velocity(pointed_thing.old_velocity)
						else
							if self.OnCollision then
								self.OnCollision(self.owner, self, pointed_thing)
							end
							self.object:remove()
							break
						end
					end
				end
			end
		elseif pointed_thing.type == "object" and (
				(pointed_thing.ref:is_player() and (pointed_thing.ref:get_player_name() ~= self.owner or self._ricochet > 0))
				or
				(pointed_thing.ref:get_luaentity() and pointed_thing.ref:get_properties().physical and pointed_thing.ref:get_luaentity().name ~= '__builtin:item')
			) and
			(not self.penetrated_obj or (self.penetrated_obj:is_valid() and self.penetrated_obj ~= pointed_thing.ref) )
		then
			local owner = core.get_player_by_name(self.owner)

			-- put bullet in front of object before punching in order to get correct engine knockback
			self.object:set_pos(self._old_pos)
			pointed_thing.ref:punch(
				self.object,
				1.0,
				{
					full_punch_interval = 1.0,
					damage_groups = self.damage
				},
				nil
			)
			if owner then accuracy.hit(owner) end

			if not self.penetrated_obj and pointed_thing.ref:get_hp() > 0 and math.random() < self.mobPen then
				self.penetrated_obj = pointed_thing.ref
				add_penetration_particle(hit_pos, vector.direction(hit_pos, self._old_pos))
				--~ play_dig_sound(node, hit_pos)
			else
				if self.OnCollision then
					self.OnCollision(self.owner, self, pointed_thing)
				end
				self.object:remove()
				break
			end
		end
	end
	
	
	self._old_pos = self.object:get_pos()
end
})

---
--- actual mags
---

---
--- visual drop mags
---

core.register_craftitem(
	"rifles:drum_mag",
	{
		wield_scale = {x = 1.0, y = 1.0, z = 1.5},
		inventory_image = "rifles_drum_mag.png"
	}
)

core.register_craftitem(
	"rifles:handgun_mag_black",
	{
		wield_scale = {x = 0.6, y = 0.6, z = 0.8},
		inventory_image = "rifles_magazine_handgun.png"
	}
)
local rifles_mag = {
	initial_properties = {
		static_save = false,
		physical = false,
		visual = "wielditem",
		visual_size = {x = 0.3, y = 0.3},
		textures = {"rifles:handgun_mag_black"},
		collisionbox = {0, 0, 0, 0, 0, 0},
	},
	lastpos = {},
	timer = 0,
}
rifles_mag.on_step = function(self, dtime, moveresult)
	self.timer = self.timer + dtime
	local pos = self.object:get_pos()
	local node = core.get_node(pos)
	if self.lastpos.y ~= nil then
		if core.registered_nodes[node.name] ~= nil then
			if core.registered_nodes[node.name].walkable then
				local vel = self.object:get_velocity()
				local acc = self.object:get_acceleration()
				self.object:set_velocity({x = 0, y = 0, z = 0})
				self.object:set_acceleration({x = 0, y = 0, z = 0})
			end
		end
	end
	if self.timer > 2.0 then
		self.object:remove()
	end
	self.lastpos = {x = pos.x, y = pos.y, z = pos.z}
end

core.register_entity("rifles:mag", rifles_mag)

core.register_craftitem(
	"rifles:handgun_mag_white",
	{
		wield_scale = {x = 0.6, y = 0.6, z = 0.8},
		inventory_image = "rifles_handgun_mag_white.png"
	}
)

core.register_craftitem(
	"rifles:machinepistol_mag",
	{
		wield_scale = {x = 0.6, y = 0.6, z = 0.8},
		inventory_image = "rifles_machinepistol_mag.png"
	}
)

core.register_craftitem(
	"rifles:assaultrifle_mag",
	{
		wield_scale = {x = 0.6, y = 0.6, z = 0.8},
		inventory_image = "rifles_assaultrifle_mag.png"
	}
)

core.register_craftitem(
	"rifles:rifle_mag",
	{
		wield_scale = {x = 0.6, y = 0.6, z = 0.8},
		inventory_image = "rifles_rifle_mag.png"
	}
)

local function register_round(name, def)
	def.description = S(def.description)
	core.register_craftitem(name, def)
end
register_round("rifles:9mm",
	{
		stack_max = 500,
		wield_scale = {x = 0.4, y = 0.4, z = 1.2},
		description = "9 × 19 mm",
		inventory_image = "rifles_9mm.png",
		_rifle_traits = {
			ammo_damage = {fleshy = 1, knockback = 1},
			ammo_critEffc = 0.25,
			ammo_crit = 1,
			ammo_velocity = 25,
			ammo_entity = "rifles:shot_bullet",
			ammo_visual = "wielditem",
			ammo_texture = "rifles:shot_bullet_visual",
			shell_entity = "rifles:empty_shell",
			shell_visual = "wielditem",
			shell_texture = "rifles:shelldrop",
			ammo_projectile_size = 0.0025,
		}
	}
)
register_round("rifles:762mm",
	{
		stack_max = 250,
		wield_scale = {x = 0.4, y = 0.4, z = 1.2},
		description = "7.62 × 51 mm",
		inventory_image = "rifles_762mm.png",
		_rifle_traits = {
			ammo_damage = {fleshy = 4, knockback = 4},
			ammo_critEffc = 0.5,
			ammo_crit = 2,
			ammo_velocity = 40,
			ammo_entity = "rifles:shot_bullet",
			ammo_visual = "wielditem",
			ammo_texture = "rifles:shot_bullet_visual",
			shell_entity = "rifles:empty_shell",
			shell_visual = "wielditem",
			shell_texture = "rifles:shelldrop",
			ammo_mob_penetration = 5,
			ammo_projectile_size = 0.0025,
		}
	}
)
register_round("rifles:556mm",
	{
		stack_max = 300,
		wield_scale = {x = 0.4, y = 0.4, z = 1.2},
		description = "5.56 × 45 mm",
		inventory_image = "rifles_556mm.png",
		_rifle_traits = {
			ammo_damage = {fleshy = 3, knockback = 3},
			ammo_critEffc = 0.4,
			ammo_crit = 2,
			ammo_velocity = 35,
			ammo_entity = "rifles:shot_bullet",
			ammo_visual = "wielditem",
			ammo_texture = "rifles:shot_bullet_visual",
			shell_entity = "rifles:empty_shell",
			shell_visual = "wielditem",
			shell_texture = "rifles:shelldrop",
			ammo_projectile_size = 0.0025,
		}
	}
)
register_round("rifles:shell",
	{
		stack_max = 50,
		wield_scale = {x = 0.4, y = 0.4, z = 1.2},
		description = "12 Gauge Shell",
		inventory_image = "rifles_shell.png",
		_rifle_traits = {
			ammo_damage = {fleshy = 2, knockback = 4},
			ammo_projectile_multiplier = 1.5,
			ammo_critEffc = 0.15,
			ammo_crit = 1,
			ammo_velocity = 20,
			ammo_entity = "rifles:shot_bullet",
			ammo_visual = "sprite",
			ammo_texture = "rifles_buckball.png",
			shell_entity = "rifles:empty_shell",
			shell_visual = "wielditem",
			shell_texture = "rifles:shell_shotgundrop",
			ammo_gravity = 5,
			ammo_projectile_size = 0.00175,
			ammo_projectile_glow = 0,
		}
	}
)
register_round("rifles:408ct",
	{
		stack_max = 40,
		wield_scale = {x = 0.65, y = 0.65, z = 1.5},
		description = ".408 chey tac",
		inventory_image = "rifles_408ct.png",
		_rifle_traits = {
			ammo_damage = {fleshy = 10, knockback = 15},
			ammo_critEffc = 0.8,
			ammo_crit = 5,
			ammo_velocity = 70,
			ammo_entity = "rifles:shot_bullet",
			ammo_visual = "wielditem",
			ammo_texture = "rifles:shot_bullet_visual",
			shell_entity = "rifles:empty_shell",
			shell_visual = "wielditem",
			shell_texture = "rifles:shelldrop",
			ammo_mob_penetration = 45,
			ammo_node_penetration = 20,
			ammo_projectile_size = 0.0025,
			ammo_dps = 80,
		}
	}
)
register_round("rifles:40mm",
	{
		stack_max = 25,
		wield_scale = {x = 0.8, y = 0.8, z = 2.4},
		description = "40mm Grenade",
		inventory_image = "rifles_40mm.png",
		_rifle_traits = {
			ammo_damage = {fleshy = 10, knockback = 15},
			ammo_critEffc = 1.0,
			ammo_crit = 1,
			ammo_velocity = 15,
			ammo_entity = "rifles:shot_bullet",
			ammo_visual = "sprite",
			ammo_texture = "rifles_rocket_fly.png",
			shell_entity = "rifles:empty_shell",
			shell_visual = "wielditem",
			shell_texture = "rifles:shell_grenadedrop",
			ammo_projectile_size = 0.15,
			ammo_gravity = 5,
			OnCollision = function(player, bullet, target)
				shared.boom(bullet.object:get_pos(), {radius = 2}, bullet.owner)
			end,
			ammo_particles = {
				velocity = {x = 1, y = 1, z = 1},
				acceleration = {x = 1, y = 1, z = 1},
				collisiondetection = true,
				lifetime = 1,
				texture = "rifles_smoke.png",
				minsize = 50,
				maxsize = 75,
				pos_randomness = 50,
				glow = 20,
				gravity = 10,
				amount = {1, 1}
			}
		}
	}
)
register_round("rifles:rocket",
	{
		stack_max = 15,
		wield_scale = {x = 1.2, y = 1.2, z = 2.4},
		description = "Rocket",
		inventory_image = "rifles_rocket.png",
		_rifle_traits = {
			ammo_damage = {fleshy = 15, knockback = 20},
			ammo_critEffc = 1.0,
			ammo_crit = 1,
			ammo_velocity = 20,
			ammo_entity = "rifles:shot_bullet",
			ammo_visual = "sprite",
			ammo_texture = "rifles_rocket_fly.png",
			ammo_projectile_size = 0.15,
			OnCollision = function(player, bullet, target)
				shared.boom(bullet.object:get_pos(), {radius = 3}, bullet.owner)
			end,
			ammo_particles = {
				velocity = {x = 1, y = 1, z = 1},
				acceleration = {x = 1, y = 1, z = 1},
				collisiondetection = true,
				lifetime = 1,
				texture = "rifles_smoke.png",
				minsize = 50,
				maxsize = 75,
				pos_randomness = 50,
				glow = 20,
				gravity = 10,
				amount = {1, 1}
			}
		}
	}
)
