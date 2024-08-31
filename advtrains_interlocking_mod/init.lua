-- twi_mods/advtrains_interlocking_mod/init.lua
-- Modify advtrains_interlocking
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

for _, name in ipairs({
    "advtrains_interlocking:ds_danger",
    "advtrains_interlocking:ds_free",
    "advtrains_interlocking:ds_slow"
}) do
    twi_fx.override_group(name, {
        not_in_creative_inventory = 1,
        not_in_craft_guide = 1,
    })
end
