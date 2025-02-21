-- twi_mods/twi_signs/init.lua
-- Cherry-picked signs
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later
-- Media: CC-by-SA 4.0, Vanessa Dannenberg (VanessaE)

local S = core.get_translator("twi_signs")

local standard_steel_groups = { cracky = 2 }
local standard_steel_sign_sounds = default.node_sound_metal_defaults()

local function noop() end

local flip_facedir = {
	[0] = 1,
	[2] = 1,
}

local has_screwdriver_mod = core.get_modpath("screwdriver")
local function rotate(pos, node, user, mode)
    if not signs_lib.can_modify(pos, user) or (has_screwdriver_mod and mode ~= screwdriver.ROTATE_FACE) then
        return false
    end
    core.swap_node(pos, { name = node.name, param2 = flip_facedir[node.param2] or 0 })
    signs_lib.delete_objects(pos)
    signs_lib.update_sign(pos)
    return true
end

signs_lib.register_sign("street_signs:sign_basic_top_only", {
    description = S("Generic intersection street name sign"),
    paramtype2 = "facedir",
    selection_box = {
        type = "fixed",
        fixed = {
            { -1 / 32, 7 / 16,  -1 / 32, 1 / 32, 8 / 16,  1 / 32 },
            { -1 / 32, 2 / 16,  -8 / 16, 1 / 32, 7 / 16,  8 / 16 },
            { -1 / 32, 1 / 16,  -1 / 32, 1 / 32, 2 / 16,  1 / 32 },
            { -8 / 16, -4 / 16, -1 / 32, 8 / 16, 1 / 16,  1 / 32 },
            { -1 / 16, -8 / 16, -1 / 16, 1 / 16, -4 / 16, 1 / 16 },
        }
    },
    mesh = "street_signs_basic_top_only.obj",
    tiles = { "street_signs_basic.png" },
    groups = signs_lib.standard_steel_groups,
    sounds = signs_lib.standard_steel_sign_sounds,
    default_color = "f",
    number_of_lines = 2,
    horiz_scaling = 0.8,
    vert_scaling = 1,
    line_spacing = 9,
    font_size = 31,
    x_offset = 7,
    y_offset = 4,
    chars_per_line = 40,
    entity_info = {
        mesh = "street_signs_basic_top_only_entity.obj",
        yaw = signs_lib.standard_yaw
    },
    allow_widefont = true,
    after_place_node = noop,
    on_rotate = rotate
})

core.register_craft({
    output = "street_signs:sign_basic_top_only",
    recipe = {
        { "signs:sign_wall_green" },
        { "default:steel_ingot" },
    }
})

core.register_node("twi_signs:sign_basic_pole", {
    description = S("Generic intersection street sign pole"),
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    node_box = {
        type = "fixed",
        fixed = {
            { -1 / 16, -0.5, -1 / 16, 1 / 16, 0.5, 1 / 16 },
        },
    },
    use_texture_alpha = "opaque",
    tiles = {
        "street_signs_pole_top.png",
        "street_signs_pole_top.png",
        "street_signs_pole.png^[transformFX",
        "street_signs_pole.png",
        "street_signs_pole.png",
        "street_signs_pole.png^[transformFX",
    },
    groups = signs_lib.standard_steel_groups,
    sounds = signs_lib.standard_steel_sign_sounds,
    on_rotate = rotate
})

core.register_craft({
	output = "twi_signs:sign_basic_pole 3",
	recipe = {
		{ "dye:white", "default:steel_ingot", "" },
		{ "dye:white", "default:steel_ingot", "" },
		{ "dye:white", "default:steel_ingot", "" },
	}
})

local big_sign_sizes = {
    --    "size",   lines, chars, hscale, vscale, xoffs, yoffs, box
    { "small",  3, 50, 1.3, 1.05, 7, 5, { -0.5, -0.5, -0.5, -0.4, 0.5, 1.5 } },
    { "medium", 6, 50, 1.3, 1.05, 7, 5, { -0.5, -0.5, -0.5, -0.4, 1.5, 1.5 } },
    { "large",  6, 80, 1,   1.05, 7, 5, { -0.5, -0.5, -0.5, -0.4, 1.5, 2.5 } }
}

local big_sign_colors = {
    { "green",  "f", "dye:green",  "dye:white" },
    { "blue",   "f", "dye:blue",   "dye:white" },
    { "yellow", "0", "dye:yellow", "dye:black" },
    { "orange", "0", "dye:orange", "dye:black" }
}

for _, s in ipairs(big_sign_sizes) do
    local size = s[1]
    local nlines = s[2]
    local nchars = s[3]
    local hscale = s[4]
    local vscale = s[5]
    local xoffs = s[6]
    local yoffs = s[7]

    for _, c in ipairs(big_sign_colors) do
        local color = c[1]
        local defc = c[2]

        signs_lib.register_sign("street_signs:sign_highway_" .. size .. "_" .. color, {
            description = S("Generic highway sign (@1-line, @2, @3)", nlines, size, color),
            inventory_image = "street_signs_generic_highway_" .. size .. "_" .. color .. "_inv.png",
            selection_box = {
                type = "wallmounted",
                wall_side = s[8],
                wall_top = { -s[8][3], -s[8][1], s[8][2], -s[8][6], -s[8][4], s[8][5] },
                wall_bottom = { s[8][3], s[8][1], s[8][2], s[8][6], s[8][4], s[8][5] }
            },
            mesh = "street_signs_generic_highway_" .. size .. "_wall.obj",
            tiles = {
                "street_signs_generic_highway_" .. size .. "_" .. color .. ".png",
                "street_signs_generic_highway_edges.png"
            },
            default_color = def,
            groups = signs_lib.standard_steel_groups,
            sounds = signs_lib.standard_steel_sign_sounds,
            number_of_lines = nlines,
            chars_per_line = nchars,
            horiz_scaling = hscale,
            vert_scaling = vscale,
            line_spacing = 2,
            font_size = 31,
            x_offset = xoffs,
            y_offset = yoffs,
            entity_info = {
                mesh = "street_signs_generic_highway_" .. size .. "_entity_wall.obj",
                yaw = signs_lib.wallmounted_yaw
            },
            allow_widefont = true,
            allow_onpole = true
        })

        core.register_alias("street_signs:sign_highway_widefont_" .. size .. "_" .. color,
            "street_signs:sign_highway_" .. size .. "_" .. color .. "_widefont")
    end
end

for _, c in ipairs(big_sign_colors) do

    local color = c[1]

    core.register_craft({
        output = "street_signs:sign_highway_small_"..color,
        recipe = {
            { "signs:sign_wall_"..color, "signs:sign_wall_"..color },
        }
    })

    core.register_craft({
        output = "street_signs:sign_highway_medium_"..color,
        recipe = {
            { "signs:sign_wall_"..color, "signs:sign_wall_"..color },
            { "signs:sign_wall_"..color, "signs:sign_wall_"..color }
        }
    })

    core.register_craft({
        output = "street_signs:sign_highway_large_"..color,
        recipe = {
            { "signs:sign_wall_"..color, "signs:sign_wall_"..color, "signs:sign_wall_"..color },
            { "signs:sign_wall_"..color, "signs:sign_wall_"..color, "signs:sign_wall_"..color }
        }
    })

end
