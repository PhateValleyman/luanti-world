local shared = ...
local S = shared.S

local id_counter = 0
local function make_id()
	id_counter = id_counter + 1
	return id_counter
end

local fused_grenades = {}
local registered_grenades = {}

local function check_grenade(id)
	local ref = fused_grenades[id]
	fused_grenades[id] = nil
	if type(ref) == "string" then
		local player = core.get_player_by_name(ref)
		if player then
			local inv = player:get_inventory()
			for i, stack in ipairs(inv:get_list("main")) do
				local def = registered_grenades[stack:get_name()]
				if def and stack:get_meta():get_int("live") == id then
					stack:clear()
					inv:set_stack("main", i, stack)
					def.explode(player:get_pos())
					return
				end
			end
		end
	elseif type(ref) == "userdata" then
		if ref:is_valid() then
			local e = ref:get_luaentity()
			if e then
				registered_grenades[e.variant].explode(ref:get_pos())
				ref:remove()
			end
		end
	end
end

core.register_on_leaveplayer(function(player)
	local inv = player:get_inventory()
	for i, stack in ipairs(inv:get_list("main")) do
		if registered_grenades[stack:get_name()] and stack:get_meta():get_int("live") > 0 then
			stack:clear()
			inv:set_stack("main", i, stack)
			return
		end
	end
end)


local on_secondary_use = function(itemstack, user, pointed_thing)
			local meta = itemstack:get_meta()
			local id = meta:get_int("live")
			if id == 0 then
				core.sound_play("rifles_reload_a", {pos = user:get_pos()}, true)
				
				local live = registered_grenades[itemstack:get_name()].live
				meta:set_string("inventory_image",live)
				meta:set_string("wield_image",live)
				
				local new_id = make_id()
				meta:set_int("live",new_id)
				fused_grenades[new_id] = user:get_player_name()
				core.after(3, check_grenade, new_id)
				
				local pos = user:get_pos()
				local dir = user:get_look_dir()
				pos = vector.new(pos.x + dir.x * 2, pos.y + 1.5, pos.z + dir.z * 2)
				core.add_particle({
					pos = pos,
					velocity = {x=0, y=-2, z=0},
					acceleration = {x=0, y=-0.1, z=0},
					expirationtime = 1,
					size = 2,
					texture = "rifles_pin.png",
				})
				return itemstack
			end
		end
local on_use = function(itemstack, user, pointed_thing)
			local pos = user:get_pos()
			local yaw = user:get_look_horizontal()
			local meta = itemstack:get_meta()
			local id = meta:get_int("live")
			pos.y = pos.y + 1.6
			local obj = core.add_entity(pos, "rifles:grenade")
			if obj then
				obj:set_properties({ textures = { (id > 0) and meta:get_string("inventory_image") or itemstack:get_definition().inventory_image} })
				local deviated_dir = shared.deviate(user:get_look_dir(),accuracy.get(user)*0.6)
				local velocity = vector.multiply(deviated_dir, 20)
				obj:set_velocity(velocity)
				obj:set_acceleration({x = 0, y = -9.81, z = 0})
				obj:set_yaw(yaw - math.pi / 2)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
					ent.id = id
					ent.variant = itemstack:get_name()
					itemstack = ""
					if fused_grenades[id] then fused_grenades[id] = obj end
				end
			end
			return itemstack
		end


local function register_grenade(variant, desc, fn)
	local name = "rifles:"..variant
	accuracy.register(name)
	registered_grenades[name] = {
		live = "rifles_"..variant.."_live.png",
		explode = fn,
	}
	core.register_craftitem(name, {
		stack_max = 1,
		wield_scale = {x = 1.1, y = 1.1, z = 1.05},
		description = S(desc),
		range = 0,
		inventory_image = "rifles_"..variant..".png",
		on_use = on_use,
		on_secondary_use = on_secondary_use,
	})
end

core.register_entity("rifles:grenade", {
	initial_properties = {
		static_save = false,
		physical = true,
		hp_max = 420,
		visual = "sprite",
		visual_size = {x = 0.5, y = 0.5},
		textures = {"rifles_grenade_live.png"},
		collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	},
	on_death = function(self, killer)
		check_grenade(self.id)
	end,
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
		if puncher and puncher:is_player() and vector.distance(vector.new(),self.object:get_velocity()) < 0.1 then
			local inv = puncher:get_inventory()
			if inv:room_for_item("main", self.variant) then
				local item = ItemStack(self.variant)
				local meta = item:get_meta()
				meta:set_int("live",self.id)
				if self.id > 1 then
					local live = registered_grenades[self.variant].live
					meta:set_string("inventory_image",live)
					meta:set_string("wield_image",live)
				end
				if fused_grenades[self.id] then fused_grenades[self.id] = puncher:get_player_name() end
				inv:add_item("main",item)
				self.object:remove()
			end
		end
	end,
})

register_grenade("grenade", "Hand Grenade", function(pos)
	shared.boom(pos, {radius = 3})
end)
register_grenade("smoke_grenade", "Smoke Grenade", function(pos)
	pos = vector.round(pos)
	core.add_particlespawner({
		amount = 40,
		time = 5,
		pos = pos,
		minvel = {x = -1.5, y = 0, z = -1.5},
		maxvel = {x = 1.5, y = 2.4, z = 1.5},
		drag = vector.new(0.3,0.3,0.3),
		bounce = 0.6,
		minacc = {x = 0, y = -0.4, z = 0},
		maxacc = {x = 0, y = -0.4, z = 0},
		minexptime = 4,
		maxexptime = 6,
		collisiondetection = true,
		texture = {name = "rifles_smoke.png", scale = 20},
	})
end)
