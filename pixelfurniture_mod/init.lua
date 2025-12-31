-- twi_mods/pixelfurniture_mod/init.lua
-- Modify pixelfurniture_mod
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: MIT

-- Opt out from nodes
for _, name in ipairs({
    "pixelfurniture:sign_arrow", -- We have nicer signs

    -- Temporary disable upholstered chairs / sofas - off-centered meshes
    "pixelfurniture:upholstered_chair_red",
    "pixelfurniture:upholstered_chair_white",
    "pixelfurniture:upholstered_chair_grey",
    "pixelfurniture:upholstered_chair_dark_grey",
    "pixelfurniture:upholstered_chair_black",
    "pixelfurniture:upholstered_chair_violet",
    "pixelfurniture:upholstered_chair_blue",
    "pixelfurniture:upholstered_chair_cyan",
    "pixelfurniture:upholstered_chair_dark_green",
    "pixelfurniture:upholstered_chair_green",
    "pixelfurniture:upholstered_chair_yellow",
    "pixelfurniture:upholstered_chair_brown",
    "pixelfurniture:upholstered_chair_orange",
    "pixelfurniture:upholstered_chair_magenta",
    "pixelfurniture:upholstered_chair_pink",
    "pixelfurniture:sofa_chair_red",
    "pixelfurniture:sofa_chair_white",
    "pixelfurniture:sofa_chair_grey",
    "pixelfurniture:sofa_chair_dark_grey",
    "pixelfurniture:sofa_chair_black",
    "pixelfurniture:sofa_chair_violet",
    "pixelfurniture:sofa_chair_blue",
    "pixelfurniture:sofa_chair_cyan",
    "pixelfurniture:sofa_chair_dark_green",
    "pixelfurniture:sofa_chair_green",
    "pixelfurniture:sofa_chair_yellow",
    "pixelfurniture:sofa_chair_brown",
    "pixelfurniture:sofa_chair_orange",
    "pixelfurniture:sofa_chair_magenta",
    "pixelfurniture:sofa_chair_pink",
    "pixelfurniture:wooden_bench",
    "pixelfurniture:wooden_chair",
}) do
    core.unregister_item(name)
    core.clear_craft({
        output = name,
    })
end

-- Node box overrides

-- {x1, y1, z1, x2, y2, z2}

local food_on_a_board_box = {
    type = "fixed",
    fixed = { { -7 / 16, -8 / 16, -7 / 16, 7 / 16, -4 / 16, 7 / 16 } },
}

local regular_box = {
    type = "regular",
}

for name, box in pairs({
    ["pixelfurniture:bread_on_a_board"] = food_on_a_board_box,
    ["pixelfurniture:chicken_on_a_board"] = food_on_a_board_box,
    ["pixelfurniture:broom"] = {
        -- 2x the height of original
        type = "fixed",
        fixed = { { -0.2, -0.5, -0, 0.2, 1.0, 0.5 } },
    },
    ["pixelfurniture:cookie_jar"] = {
        -- A slightly larger hitbox like other vessels
        type = "fixed",
        fixed = { { -6 / 16, -0.5, -6 / 16, 6 / 16, 5 / 16, 6 / 16 } },
    },
    ["pixelfurniture:doormat"] = {
        -- Fit the whole size
        type = "fixed",
        fixed = { { -7 / 16, -0.5, -5 / 16, 7 / 16, -7 / 16, 5 / 16 } },
    },
    ["pixelfurniture:globe"] = {
        -- Extend the hitbox to cover the whole height
        type = "fixed",
        fixed = { { -0.3, -0.5, -0.3, 0.3, 7 / 16, 0.3 } },
    },
    ["pixelfurniture:hourglass"] = {
        -- Fit the whole size
        type = "fixed",
        fixed = { { -4 / 16, -0.5, -4 / 16, 4 / 16, 0.5, 4 / 16 } },
    },
    ["pixelfurniture:item_shelf"] = {
        -- Fit the whole size
        type = "fixed",
        fixed = {
            { -0.5,  6 / 16, -1 / 16, 1.5, 0.5, 0.5 },
            { -6 / 16, -2 / 16, 0, -4 / 16, 6 / 16, 0.5 },
            { 20 / 16, -2 / 16, 0, 22 / 16, 6 / 16, 0.5 },
        }
    },
    ["pixelfurniture:lantern"] = {
        -- Fit the whole size
        type = "fixed",
        fixed = { { -3 / 16, -0.5, -3 / 16, 3 / 16, 3 / 16, 3 / 16 } },
    },
    ["pixelfurniture:small_vase"] = {
        -- Shrink to fit
        type = "fixed",
        fixed = { { -2 / 16, -0.5, -2 / 16, 2 / 16, 0, 2 / 16 } },
    },
    ["pixelfurniture:statue"] = {
        -- Fit the whole size
        type = "fixed",
        fixed = { { -4 / 16, -0.5, -3 / 16, 4 / 16, 6 / 16, 3 / 16 } },
    },
    ["pixelfurniture:stool"] = {
        -- Fit the whole size
        type = "fixed",
        fixed = { { -6 / 16, -0.5, -5 / 16, 6 / 16, -1 / 16, 5 / 16 } },
    },
    ["pixelfurniture:wooden_closet"] = regular_box,
    ["pixelfurniture:wooden_counter"] = regular_box,
    ["pixelfurniture:wooden_table"] = {
        -- Fit the whole size
        type = "fixed",
        fixed = {
            { -0.5, 6 / 16, -0.5, 0.5, 0.5,  0.5 },   -- surface
            { -0.5, -0.5, -0.5, -5 / 16, 6 / 16, -5 / 16 }, -- leg 1
            { 5 / 16, -0.5, -0.5, 0.5, 6 / 16, -5 / 16 }, -- leg 2
            { -0.5, -0.5, 5 / 16, -5 / 16, 6 / 16, 0.5 }, -- leg 3
            { 5 / 16, -0.5, 5 / 16, 0.5, 6 / 16, 0.5 }, -- leg 4
        }
    }
}) do
    core.override_item(name, {
        node_box = table.copy(box),
        selection_box = table.copy(box),
        collision_box = table.copy(box),
    })
end

-- Other overrides

-- Add cooke jar to vessels
do
    local groups = table.copy(core.registered_items["pixelfurniture:cookie_jar"].groups)
    groups.vessel = 1
    core.override_item("pixelfurniture:cookie_jar", {
        groups = groups,
    })
end

-- Disable rightclick function of the globe
core.override_item("pixelfurniture:globe", {}, {
    "on_rightclick"
})

-- Override crate resipe so it aligns with dlxtrains crates
core.clear_craft({
    output = "pixelfurniture:crate",
})

core.register_craft({
    output = "pixelfurniture:crate",
    recipe = {
        { "group:stick", "group:wood", "group:stick" },
        { "group:wood",  "",           "group:wood" },
        { "group:wood",  "group:wood", "group:wood" },
    },
})
