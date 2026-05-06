-- twi_mods/admin_statues/init.lua
-- Add statues of admins and moderators
-- Copyright (c) 2026 1F616EMO
-- Copyright (c) 2019 Hume2
-- SPDX-License-Identifier: MIT

local S = core.get_translator("admin_statues")

local statues = {
    ["1F616EMO"] = "character.1272",
    ["RelaxingPlay"] = "character.990",
    ["y5nw"] = "character.2292",
    ["HelenasaurusRex"] = "character.1917",
}

for name, skin_name in pairs(statues) do
    core.register_node("admin_statues:statue_" .. string.lower(name), {
        description = S("Statue of @1", name),
        tiles = { skin_name .. ".png" },
        groups = { dig_immediate = 2 },

        paramtype = "light",
        drawtype = "mesh",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        mesh = "exclusive_skins_statue.obj",

        is_ground_content = false,
        collision_box = {
            type = "fixed",
            fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 },
        },
        selection_box = {
            type = "fixed",
            fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 },
        },
    })
end
