-- twi_mods/digilines_mod/init.lua
-- modify digilines
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-only

local new_tiles = {}
for i, tile in ipairs(minetest.registered_nodes["digilines:chest"].tiles) do
    new_tiles[i] = tile .. "^digilines_mod_chest_overlay.png"
end
minetest.override_item("digilines:chest", {
    tiles = new_tiles
})
