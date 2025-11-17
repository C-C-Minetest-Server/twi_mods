-- twi_mods/twi_billboards/init.lua
-- Static billboards (e.g. train maps)
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

local S = core.get_translator("twi_billboards")

local billboards = {
    -- Grape Hills Railway Map (2025-11-16)
    -- Source: https://metromapmaker.com/map/mRL-j0Zq
    -- Copyright (C) 2025  1F616EMO
    -- License: CC0 https://creativecommons.org/publicdomain/zero/1.0/
    ["gh_railway_map"] = {
        description = S("Grape Hills Railway Map"),
        texture = "twi_billboards_gh_railway_map.jpg",
        scales = { 1.0, 2.0, 2.5, 3.0 },
        use_texture_alpha = "clip",
        light_source = 1,
        shop_item_cost = 5,
        shop_item_count = 1,
    },

    -- Origin Railway Map (2025-11-16)
    -- Source: https://metromapmaker.com/map/KfHj__im
    -- Copyright (C) 2025  1F616EMO
    -- License: CC0 https://creativecommons.org/publicdomain/zero/1.0/
    ["spn_railway_map"] = {
        description = S("Origin Railway Map"),
        texture = "twi_billboards_spn_railway_map.jpg",
        scales = { 1.0, 2.0, 2.5, 3.0 },
        use_texture_alpha = "clip",
        light_source = 1,
        shop_item_cost = 5,
        shop_item_count = 1,
    },

    -- Grape Hills Line 2 Map
    -- Source: ./textures_src/twi_billboards_line_map_grh2.svg
    -- Copyright (C) 2025  1F616EMO
    -- License: CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/deed.en
    ["line_map_grh2"] = {
        description = S("Grape Hills Line 2 Map"),
        texture = "twi_billboards_line_map_grh2.png",
        natural_scale = 3.0,
        scales = { 1.0, },
        use_texture_alpha = "clip",
        light_source = 1,
        shop_item_cost = 5,
        shop_item_count = 1,
    },

    -- Grape Hills Line 2 Map (white text)
    -- Source: ./textures_src/twi_billboards_line_map_grh2_white_text.svg
    -- Copyright (C) 2025  1F616EMO
    -- License: CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/deed.en
    ["line_map_grh2_white_text"] = {
        description = S("Grape Hills Line 2 Map (white text)"),
        texture = "twi_billboards_line_map_grh2_white_text.png",
        natural_scale = 3.0,
        scales = { 1.0, },
        use_texture_alpha = "clip",
        light_source = 1,
        shop_item_cost = 5,
        shop_item_count = 1,
    },

    -- Grape Hills Line 2 Map (flipped)
    -- Source: ./textures_src/twi_billboards_line_map_grh2.svg
    -- Copyright (C) 2025  1F616EMO
    -- License: CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/deed.en
    ["line_map_grh2_flipped"] = {
        description = S("Grape Hills Line 2 Map (flipped)"),
        texture = "twi_billboards_line_map_grh2_flipped.png",
        natural_scale = 3.0,
        scales = { 1.0, },
        use_texture_alpha = "clip",
        light_source = 1,
        shop_item_cost = 5,
        shop_item_count = 1,
    },

    -- Grape Hills Line 2 Map (white text, flipped)
    -- Source: ./textures_src/twi_billboards_line_map_grh2_white_text.svg
    -- Copyright (C) 2025  1F616EMO
    -- License: CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/deed.en
    ["line_map_grh2_white_text_flipped"] = {
        description = S("Grape Hills Line 2 Map (white text, flipped)"),
        texture = "twi_billboards_line_map_grh2_white_text_flipped.png",
        natural_scale = 3.0,
        scales = { 1.0, },
        use_texture_alpha = "clip",
        light_source = 1,
        shop_item_cost = 5,
        shop_item_count = 1,
    },


    -- Twemoji v13: confounded face
    -- Source: https://commons.wikimedia.org/wiki/File:Twemoji13_1f616.svg
    -- Copyright (C) 2019 Twitter, Inc and other contributors
    -- License: CC BY-SA 4.0 https://creativecommons.org/licenses/by/4.0/deed.en
    ["twemoji13_1f616"] = {
        description = S("Confounded Face"),
        texture = "twi_billboards_twemoji13_1f616.png",
        scales = { 0.5, 0.7, 1.0, 2.5, 3.0 },
        use_texture_alpha = "blend",
        light_source = 1,
        shop_item_cost = 5,
        shop_item_count = 1,
    },
}

local shop_entries = {}

for name, data in pairs(billboards) do
    if not data.scales then
        data.scales = { 1.0 }
    end
    data.description = data.description or S("Billboard @1", name)

    assert(data.texture)
    local basic_definition = {
        drawtype = "signlike",
        tiles = { data.texture },
        inventory_image = data.texture,
        wield_image = data.texture,
        paramtype = "light",
        paramtype2 = "wallmounted",
        wallmounted_rotate_vertical = true,
        sunlight_propagates = true,
        is_ground_content = false,
        walkable = false,
        light_source = data.light_source or 0,
        selection_box = {
            type = "wallmounted",
        },
        groups = { choppy = 2, dig_immediate = 3, attached_node = 1, picture = 1, billboard = 1 },
        use_texture_alpha = data.use_texture_alpha or "none",
    }

    for _, scale in ipairs(data.scales) do
        assert(type(scale) == "number" and scale > 0)
        local node_name = "twi_billboards:" .. name .. "_" .. string.gsub(tostring(scale), "%.", "_")
        local def = table.copy(basic_definition)
        def.description = S("@1 (Scale: @2)", data.description, tostring(scale))
        def.visual_scale = scale * (data.natural_scale or 1.0)

        core.register_node(node_name, def)

        if core.global_exists("shop_dialog") and data.shop_item_cost then
            table.insert(shop_entries, {
                item = ItemStack(node_name .. " " ..
                    (data.shop_item_count and tostring(data.shop_item_count) or 1)),
                cost = data.shop_item_cost,
                max_amount = function() return 99 end,
            })
        end
    end
end

if core.global_exists("shop_dialog") then
    shop_dialog.register_dialog("twi_billboards:main", {
        title = S("Billboards Shop"),
        entries = shop_entries,
    })
end
