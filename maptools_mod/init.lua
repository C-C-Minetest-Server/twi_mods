-- twi_mods/maptools_mod/init.lua
-- modify maptools
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: Zlib

for _, name in ipairs({
    "maptools:copper_coin",
    "maptools:silver_coin",
    "maptools:gold_coin",
}) do
    twi_fx.override_group(name, {
        not_in_creative_inventory = 1,
        not_in_craft_guide = 1,
    })
end
