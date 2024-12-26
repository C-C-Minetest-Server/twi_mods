-- twi_mods/moreblocks_mod/init.lua
-- Moreblocks modifications
--[[
    This code is licensed under the zlib license;
    see ./LICENSE.md for more information.
]]

-- Adopt the linuxforks way of crafting stone tiles
core.clear_craft({
	recipe = {
		{ "default:cobble", "default:cobble", "default:cobble" },
		{ "default:cobble", "default:stone",  "default:cobble" },
		{ "default:cobble", "default:cobble", "default:cobble" },
	}
})

core.register_craft({
	output = "moreblocks:stone_tile 4",
	recipe = {
		{ "default:cobble", "default:cobble" },
		{ "default:cobble", "default:cobble" },
	}
})

core.register_craft({
	output = "moreblocks:stone_tile 36",
	recipe = {
		{ "moreblocks:cobble_compressed", "moreblocks:cobble_compressed" },
		{ "moreblocks:cobble_compressed", "moreblocks:cobble_compressed" },
	}
})

-- Allow compressed cobbles to be smelt into stone/grind into gravel

core.register_craft({
	type = "cooking",
	output = "default:stone 9",
	recipe = "moreblocks:cobble_compressed",
	cooktime = 3 * 8,
})

technic.register_grinder_recipe({
	input = { "moreblocks:cobble_compressed" },
	time = 3 * 8,
	output = "default:gravel 9"
})

-- Hide deprecated nodes from crafting recipies
local nodes = {
	"moreblocks:wood_tile_flipped",
	"moreblocks:wood_tile_down",
	"moreblocks:wood_tile_left",
	"moreblocks:wood_tile_right",
}
for _, name in ipairs(nodes) do
	local groups = table.copy(core.registered_nodes[name].groups or {})
	groups.not_in_creative_inventory = 1
	groups.not_in_craft_guide = 1
	core.override_item(name, {
		groups = groups
	})
end
