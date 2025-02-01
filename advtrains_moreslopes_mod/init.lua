-- twi_mods/advtrains_moreslopes_mod/init.lua
-- Modify advtrains_moreslopes
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

core.register_craft({
    type = "shapeless",
    recipe = { "advtrains:dtrack_more_slopeplacer" },
    output = "advtrains:dtrack_slopeplacer",
})

core.register_craft({
    type = "shapeless",
    recipe = { "advtrains:dtrack_slopeplacer" },
    output = "advtrains:dtrack_more_slopeplacer",
})

core.override_item("advtrains:dtrack_slopeplacer", {
    description = ">= 1:3 " .. core.registered_items["advtrains:dtrack_slopeplacer"].description,
})

core.override_item("advtrains:dtrack_more_slopeplacer", {
    description = "<= 1:4 " .. core.registered_items["advtrains:dtrack_more_slopeplacer"].description,
})

for i = 4, 8 do
    for j = 1, i do
        local name = "advtrains:dtrack_more_vst" .. i .. j

        core.override_item(name, {
            walkable = true,
            collision_box = core.registered_items[name].selection_box,
        })
    end
end
