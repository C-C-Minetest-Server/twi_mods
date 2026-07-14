-- twi_mods/glass_stained_mod/init.lua
-- Modifications of glass_stained_mods
-- Copyright (c) 2026  1F616EMO
-- SPDX-License-Identifier: MIT

local has_minetest_errata = core.get_modpath("minetest_errata") and true or false

for name, def in pairs(core.registered_nodes) do
    if has_minetest_errata and string.sub(name, 1, 25) == "glass_stained:pane_glass_" then
        -- Duplicated item as minetest_errata
        core.unregister_item(name)
    elseif string.sub(name, 1, 14) == "glass_stained:" then
        -- Add thickness to nodes so that players won't glitch through
        local node_box = def.collision_box or def.node_box or nil

        if node_box and node_box.fixed then
            core.log("action", "[glass_stained_mod] Adding thickness to " .. name)
            node_box = table.copy(node_box)

            for _, box in ipairs(node_box.fixed) do
                if box[3] == box[6] then
                    box[3] = box[3] - 1/32
                    box[6] = box[6] + 1/32
                end
            end

            core.override_item(name, {
                collision_box = node_box,
            })
        end

        -- Use texture alpha
        core.override_item(name, {
            use_texture_alpha = "blend",
        })
    end
end

-- Iron bars are just iron bars
core.register_alias_force("glass_stained:pane_bar_single", "xpanes:bar_flat")
core.clear_craft({
    recipe = {
        { "xpanes:bar_flat", "xpanes:bar_flat" },
        { "xpanes:bar_flat", "xpanes:bar_flat" },
    },
})

-- Recipe conflict with errata due to the change above
if has_minetest_errata then
    core.clear_craft({
        output = "doors:door_iron_bar",
    })

    core.register_craft({
        output = "doors:door_iron_bar",
        recipe = {
            { "default:steel_ingot" },
            { "xpanes:bar_flat" },
            { "xpanes:bar_flat" },
        },
    })
end
