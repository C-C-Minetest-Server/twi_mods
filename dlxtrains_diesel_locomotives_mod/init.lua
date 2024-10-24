-- twi_mods/dlxtrains_diesel_locomotives_mod/init.lua
-- Modify dlxtrains_diesel_locomotives
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

for _, name in ipairs({
    "dlxtrains_diesel_locomotives:locomotive_type1",
    "dlxtrains_diesel_locomotives:locomotive_type2",
    "dlxtrains_diesel_locomotives:locomotive_type3",
}) do
    minetest.registered_entities[name].max_speed = 30
    advtrains.wagon_prototypes[name].max_speed = 30
end
