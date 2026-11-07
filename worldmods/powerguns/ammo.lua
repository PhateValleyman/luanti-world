local shared = ...
local S = shared.S
local bloodyness = tonumber(core.settings:get("rifles.bloodyness")) or 10

local glass_panes_doors = {
	["doors:door_glass_a"]=true,
	["xpanes:pane"]=true,
	["xpanes:pane_flat"]=true,
	["default:glass"]=true,
	["mcl_core:glass"]=true,
	["mcl_panes:pane_natural"]=true,
	["mcl_panes:pane_natural_flat"]=true,
}

local function is_node_glass_or_leaves(name, nodedef)
	if nodedef.groups and nodedef.groups.leaves then
		return true
	end

	if glass_panes_doors[name] then
		return true
	end
end

core.register_craftitem(
	"powerguns:shot_bullet_visual",
	{
		wield_scale = {x = 1.0, y = 1.0, z = 1.0},
		inventory_image = "powerguns_bulletshot.png"
	}
)

local use_particles = core.settings:get_bool("rifles.impact_particles", true)
local max_lifetime = tonumber(core.settings:get("rifles.bullet_lifetime")) or 10.0

local function play_dig_sound(node, hit_pos)
	local nodedef = minetest.registered_nodes[node.name]
	if nodedef and nodedef.sounds and (nodedef.sounds.dig or nodedef.sounds.dug) then
		core.sound_play((nodedef.sounds.dig or nodedef.sounds.dug).name, {pos = hit_pos}, true)
	end
end

local powerguns_shot_bullet = {
	timer = 0,
	initial_properties = {
		static_save = false,
		pointable = false,
		physical = false,
		glow = 100,
		visual = "wielditem",
		visual_size = {x = 0.75, y = 0.75},
		textures = {"powerguns:shot_bullet_visual"},
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

	local ignite = self.ignite or 0
	local size = self.size or 0.0025

	self.timer = self.timer + dtime

	if self.timer >= 0 then
		self.object:set_properties({collide_with_objects = true})
		self.object:set_properties({collisionbox = {-size, -size, -size, size, size, size}})
	end

	if self.timer > max_lifetime then
		self.object:remove()
		return
	end
	for pointed_thing in core.raycast(self._old_pos, self.object:get_pos(), true, true) do
		local hit_pos = pointed_thing.intersection_point
		local mobPen = self.mobPen or 0
		local door_break = self.door_break or 0

		if pointed_thing.type == "node" then
			local node_pos = pointed_thing.under
			local node = core.get_node(node_pos)
			local node_def = core.registered_nodes[node.name]
			if node_def and node_def.walkable and not is_node_glass_or_leaves(node.name, node_def) then
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
							texture = "powerguns_bullethole.png",
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

				if core.get_item_group(node.name, "level") > 1 then
					self.hit_leaves = false

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
						return
					end
					break
				else
					self.object:remove()
					return
				end
			end
		elseif pointed_thing.type == "object" and (
				(pointed_thing.ref:is_player() and (pointed_thing.ref:get_player_name() ~= self.owner or self._ricochet > 0))
				or
				(pointed_thing.ref:get_luaentity() and pointed_thing.ref:get_properties().physical and pointed_thing.ref:get_luaentity().name ~= '__builtin:item')
			) then

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
			accuracy.hit(owner)

			self.object:remove()
			return
		end
	end
	
	
	self._old_pos = self.object:get_pos()
end
}
core.register_entity("powerguns:shot_bullet", powerguns_shot_bullet)
