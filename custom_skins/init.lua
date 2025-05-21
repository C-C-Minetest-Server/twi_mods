-- twi_mods/custom_skins/init.lua
-- Player custom skins
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: GPL-3.0-or-later

-- player.[nick].[number or name].png
local avaliable_skins = {
    ["Vedu_0825"] = {
        "1"
    },
}

local texture_path = core.get_modpath("custom_skins") .. DIR_DELIM .. "textures" .. DIR_DELIM

for name, skinlist in pairs(avaliable_skins) do
    for _, skin_name in ipairs(skinlist) do
        local filename = "player." .. name .. "." .. skin_name .. ".png"
        skins.register_skin(texture_path, filename)
    end
end
