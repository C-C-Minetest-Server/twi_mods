-- twi_mods/linetrack_slopes/init.lua
-- Road lines for buses on various surfaces
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

local S = core.get_translator("linetrack_slopes")

local variants_to_quantity_prices = {
    { "linetrack:roadtrack_slope1",   30, 10 },
    { "linetrack:roadtrack_slope2",   30, 10 },
    { "linetrack:roadtrack_slab",     30, 10 },

    { "linetrack:roadtrack_slab_atc", 5,  15 },
}

local shop_entries = {}

for _, name in ipairs({
    -- default
    "default:sandstone",
    "default:silver_sandstone",
    "default:desert_sandstone",

    -- moreblocks
    "moreblocks:cobble_compressed",
    "moreblocks:tar",

    -- bakedclay (omitting black)
    "bakedclay:natural",
    "bakedclay:white",
    "bakedclay:grey",
    "bakedclay:red",
    "bakedclay:yellow",
    "bakedclay:green",
    "bakedclay:cyan",
    "bakedclay:blue",
    "bakedclay:magenta",
    "bakedclay:orange",
    "bakedclay:violet",
    "bakedclay:brown",
    "bakedclay:pink",
    "bakedclay:dark_grey",
    "bakedclay:dark_green",

    -- minetest_errata
    "minetest_errata:desert_sandstone_cobble",
    "minetest_errata:sandstone_cobble",
    "minetest_errata:silver_sandstone_cobble",
}) do
    local node_def = core.registered_nodes[name]
    if node_def then
        local surface_name = string.gsub(name, ":", "_")
        local description = node_def.short_description or node_def.description or name
        local texture = node_def.tiles and node_def.tiles[1] or "blank.png"

        linetrack.regiser_roadline_for_surface(surface_name, description, texture)

        for _, data in ipairs(variants_to_quantity_prices) do
            shop_entries[#shop_entries + 1] = {
                item = ItemStack(data[1] .. "_" .. surface_name .. "_placer " .. data[2]),
                cost = data[3],
            }
        end
    end
end

shop_dialog.register_dialog("linetrack_slopes:roadline_elevated", {
    title = S("Elevated Road Lines Admin Shop"),

    entries = shop_entries,
})
