-- twi_mods/additional_role/init.lua
-- Additional roles indicators
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("additional_role")

core.register_privilege("role_helper", {
    description = S("Marked as helper in the chatroom"),
    give_to_singleplayer = false,
})

beerchat_roles.register_role({
    name = S("Helper"),
    color = "#20F99F",
    func = function(name)
        return core.check_player_privs(name, { role_helper = true })
    end,
    sort = 8900,
})

local auth
mail.register_recipient_handler(function(sender, name)
    if name ~= "additional_role:helper" then return nil end

    auth = auth or core.get_auth_handler()
    local list_dest = {}
    for i_name in auth.iterate() do
        local privs = core.get_player_privs(i_name)
        if i_name ~= sender and (privs.server or privs.ban or privs.role_helper) then
            list_dest[#list_dest+1] = i_name
        end
    end

    return true, list_dest
end)
