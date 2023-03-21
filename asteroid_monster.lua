
local S = mobs.intllib_monster

local stone_types = {

	{	nodes = {"asteroid:redstone"},
		skins = {"mobs_stone_monster3.png"},
		drops = {
			{name = "asteroid:redcobble", chance = 1, min = 0, max = 2},
			{name = "default:copper_lump", chance = 5, min = 0, max = 2},
			{name = "default:coal_lump", chance = 5, min = 0, max = 2}
		}
	}
}


-- Asteroid Monster by SeqSEE

mobs:register_mob("mobs_monster:asteroid_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 3,
	hp_min = 12,
	hp_max = 35,
	armor = 80,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.b3d",
	textures = {
		{"mobs_asteroid_monster.png"},
		{"mobs_asteroid_monster2.png"} -- by AMMOnym
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_stonemonster"
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump_height = 0,
	stepheight = 1.1,
	floats = 0,
	view_range = 10,
	drops = {
		{name = "asteroid:redcobble", chance = 1, min = 0, max = 2},
		{name = "default:coal_lump", chance = 3, min = 0, max = 2},
		{name = "default:iron_lump", chance = 5, min = 0, max = 2}
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63
	},
	immune_to = {
		{"default:pick_wood", 0}, -- wooden pick doesnt hurt stone monster
		{"default:pick_stone", 4}, -- picks deal more damage to stone monster
		{"default:pick_bronze", 5},
		{"default:pick_steel", 5},
		{"default:pick_mese", 6},
		{"default:pick_diamond", 7}
	},

	-- check surrounding nodes and spawn a specific spider
	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1
		local tmp

		for n = 1, #stone_types do

			tmp = stone_types[n]

			if minetest.find_node_near(pos, 1, tmp.nodes) then

				self.base_texture = tmp.skins
				self.object:set_properties({textures = tmp.skins})

				if tmp.drops then
					self.drops = tmp.drops
				end

				return true
			end
		end

		return true -- run only once, false/nil runs every activation
	end
})


if not mobs.custom_spawn_monster then

	mobs:spawn({
		name = "mobs_monster:asteroid_monster",
		nodes = {"asteroid:reddust", "asteroid:redstone", "asteroid:redgravel"},
		min_light = 3,
		max_light = 8,
		chance = 7000,
		min_height = 5000,
		max_height = 31000
	})
end


mobs:register_egg("mobs_monster:asteroid_monster", S("Asteroid Monster"), "default_stone.png", 1)


mobs:alias_mob("mobs:asteroid_monster", "mobs_monster:asteroid_monster") -- compatibility
