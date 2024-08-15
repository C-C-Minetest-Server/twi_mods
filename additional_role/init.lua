-- twi_mods/additional_role/init.lua
-- Additional roles indicators
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = minetest.get_translator("additional_role")

minetest.register_privilege("role_helper", {
    description = S("Marked as helper in the chatroom"),
    give_to_singleplayer = false,
})

beerchat_roles.register_role({
    name = S("Helper"),
    color = "#20F99F",
    func = function(name)
        return minetest.check_player_privs(name, { role_helper = true })
    end,
    sort = 8900,
})
