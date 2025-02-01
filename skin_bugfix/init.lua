-- twi_mods/skin_bugfix/init.lua
-- Fix missing textures in player skins
-- SPDX-License-Identifier: LGPL-3.0-or-later

local expected_length = 5

modlib.minetest.register_globalstep(5, function()
    for _, player in ipairs(core.get_connected_players()) do
        local skin = player:get_properties().textures

        if #skin < expected_length then
            for i = #skin + 1, expected_length do
                skin[i] = "blank.png"
            end

            core.log("action", "Fixing missing textures in player skin for player " .. player:get_player_name())
            player:set_properties({ textures = skin })
        end
    end
end)
