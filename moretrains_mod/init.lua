-- twi_mods/moretrains_mod_mod/init.lua
-- Modify moretrains_mod
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

for _, name in ipairs({
    "moretrains_nightline_couchette",
    "moretrains_nightline_seat_car",
    "moretrains_wagon_gondola",
    "moretrains_wagon_gondola_mese",
    "moretrains_wagon_gondola_cobble",
    "moretrains_wagon_gondola_toiletpaper",
    "moretrains_wagon_gondola_rails",
    "moretrains_wagon_tank",
    "moretrains_wagon_tank2",
    "moretrains_wagon_wood",
    "moretrains_wagon_wood_loaded",
    "moretrains_wagon_wood_acacia",
    "moretrains_wagon_wood_jungle",
    "moretrains_wagon_wood_pine",
    "moretrains_wagon_wood_aspen",
    "moretrains_wagon_box",
    "moretrains_railroad_car",
}) do
    minetest.registered_entities["advtrains:" .. name].max_speed = 30
    advtrains.wagon_prototypes["advtrains:" .. name].max_speed = 30
end
