local shared = ...
local S = shared.S
local proj_dir

shared.register_rifle(
	"powerguns:forcegun",
	{
		description = S("Force Gun"),
		range = 0,
		wield_scale = {x = 2.0, y = 2.0, z = 1.75},
		inventory_image = "powerguns_forcegun.png",
		on_use = function(itemstack, user, pointed_thing)
			local pos = user:get_pos()
			pos.y = pos.y + user:get_properties().eye_height
			local dir = user:get_look_dir()
			local yaw = user:get_look_horizontal()
			local inv = user:get_inventory()
			if inv:contains_item("main", "powerguns:power 25") then
				inv:remove_item("main", "powerguns:power 25")
				local obj = core.add_entity(pos, "powerguns:forceblast")
				if obj then
					local deviated_dir = shared.deviate(user:get_look_dir(),accuracy.get(user)/2)
					local velocity = vector.multiply(deviated_dir, 60)
					core.sound_play("powerguns_rocket", {object = obj}, true)
					obj:set_velocity(velocity)

					obj:set_yaw(yaw - math.pi / 2)
					proj_dir = dir
					local ent = obj:get_luaentity()
					if ent then
						ent.player = user
					end
				end
			end
		end
	}
)

core.register_entity("powerguns:forceblast", {
	timer = 0,
	initial_properties = {
		static_save = false,
		pointable = false,
		physical = false,
		glow = 30,
		visual = "sprite",
		visual_size = {x = 0.4, y = 0.4},
		textures = {"powerguns_force_bullet.png"},
	},
	on_activate = function (self, staticdata, dtime_s)
		self._old_pos = self.object:get_pos()
	end,
	on_step = function(self, dtime, moveresult)
		self.timer = self.timer + dtime
		proj_dir = proj_dir or ({x = 0, y = 0, z = 0})

		if self.timer > 10 then
			self.object:remove()
			return
		end

		if self.timer > 0.05 then
			self.object:set_properties({collide_with_objects = true})
		end

		for pointed_thing in core.raycast(self._old_pos, self.object:get_pos()) do
			local pos = pointed_thing.intersection_point
			if pointed_thing ~= nil then
				if pointed_thing.type == "object" and (not pointed_thing.ref:is_player() or (pointed_thing.ref ~= self.player)) then
					local o = pointed_thing.ref
					local v = o:get_luaentity()
					if o:is_player() or (v and (v.name == "__builtin:item" or v.is_mob or v._creatura_mob or v._cmi_is_mob)) then
						o:add_velocity(
							vector.new(proj_dir.x * 20, 5 + (proj_dir.y * 20), proj_dir.z * 20)
						)
					end
					core.add_particle(
						{
							pos = ({x = pos.x, y = pos.y, z = pos.z}),
							velocity = {x = 0, y = 0, z = 0},
							acceleration = {x = 0, y = 0, z = 0},
							expirationtime = 0.20,
							size = 16,
							collisiondetection = true,
							collision_removal = false,
							vertical = false,
							texture = "powerguns_force_blast.png",
							glow = 20,
							animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 0.20}
						}
					)
					self.object:remove()
					return
				end

				if pointed_thing.type == "node" then
					local node_pos = pointed_thing.under
					local node = core.get_node(node_pos)
					local node_def = core.registered_nodes[node.name]
					if node_def and node_def.walkable then
						local objs = core.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 7)
						for k, obj in pairs(objs) do
							local posd_x = 1
							local posd_y = 1
							local posd_z = 1

							if obj:get_pos() then
								posd_x = pos.x - obj:get_pos().x
								posd_y = pos.y - obj:get_pos().y
								posd_z = pos.z - obj:get_pos().z
							end

							if posd_y < 0 and posd_y > -1 then
								posd_y = -1
							end
							if posd_y > 0 and posd_y < 1 then
								posd_y = 1
							end

							if posd_y > 0 then
								posd_y = posd_y * 3
							end

							posd_y = (posd_y + 0.5) * (((math.abs(posd_x) + 0.5) + (math.abs(posd_z) + 0.5)) / 2)

							if posd_y > -1.0 and posd_y < 0 then
								posd_y = -1.0
							end

							local v = obj:get_luaentity()
							if v and v.name ~= "powerguns:forceblast" and (v.name == "__builtin:item" or v.is_mob or v._creatura_mob or v._cmi_is_mob) then
								obj:add_velocity({x = 10 * (-posd_x), y = 30 * (-1 / posd_y), z = 10 * (-posd_z)})
							elseif obj:is_player() then
								obj:add_velocity(
									{
										x = 30 * ((-posd_x) / (1 + math.abs(posd_x))),
										y = 25 * (-1 / posd_y),
										z = 30 * ((-posd_z) / (1 + math.abs(posd_z)))
									}
								)
							end
						end

						core.add_particle(
							{
								pos = ({x = pos.x, y = pos.y, z = pos.z}),
								velocity = {x = 0, y = 0, z = 0},
								acceleration = {x = 0, y = 0, z = 0},
								expirationtime = 0.20,
								size = 128,
								collisiondetection = true,
								collision_removal = false,
								vertical = false,
								texture = "powerguns_force_blast.png",
								glow = 20,
								animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 0.20}
							}
						)
						self.object:remove()
						return
					end
				end
			end
		end
		self._old_pos = self.object:get_pos()
	end
})
