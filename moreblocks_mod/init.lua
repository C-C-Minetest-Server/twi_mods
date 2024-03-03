-- twi_mods/moreblocks_mod/init.lua
-- Moreblocks modifications
--[[
    This code is licensed under the zlib license;
    see ./LICENSE.md for more information.
]]

-- Adopt the linuxforks way of crafting stone tiles
minetest.clear_craft({
	recipe = {
		{ "default:cobble", "default:cobble", "default:cobble" },
		{ "default:cobble", "default:stone",  "default:cobble" },
		{ "default:cobble", "default:cobble", "default:cobble" },
	}
})

minetest.register_craft({
	output = "moreblocks:stone_tile 4",
	recipe = {
		{ "default:cobble", "default:cobble" },
		{ "default:cobble", "default:cobble" },
	}
})

minetest.register_craft({
	output = "moreblocks:stone_tile 36",
	recipe = {
		{ "moreblocks:cobble_compressed", "moreblocks:cobble_compressed" },
		{ "moreblocks:cobble_compressed", "moreblocks:cobble_compressed" },
	}
})

-- Allow compressed cobbles to be smelt into stone/grind into gravel

minetest.register_craft({
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
