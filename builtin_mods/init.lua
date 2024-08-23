-- twi_mods/builtin_mods/init.lua
-- modifiy builtin
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

minetest.registered_chatcommands.ban.description =
    "[Do not use] " .. minetest.registered_chatcommands.ban.description
minetest.registered_chatcommands.ban.privs = { server = true }

minetest.registered_chatcommands.unban.description =
    "[Do not use] " .. minetest.registered_chatcommands.unban.description
minetest.registered_chatcommands.unban.privs = { server = true }

-- Remove rollback commands if enable_rollback_recording == false
if not minetest.settings:get_bool("enable_rollback_recording") then
    minetest.unregister_chatcommand("rollback_check")
    minetest.unregister_chatcommand("rollback")
    core.registered_privileges.rollback = nil
end
