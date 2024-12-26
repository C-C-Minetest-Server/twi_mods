-- twi_mods/builtin_mods/init.lua
-- modifiy builtin
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

core.registered_chatcommands.ban.description =
    "[Do not use] " .. core.registered_chatcommands.ban.description
core.registered_chatcommands.ban.privs = { server = true }

core.registered_chatcommands.unban.description =
    "[Do not use] " .. core.registered_chatcommands.unban.description
core.registered_chatcommands.unban.privs = { server = true }

-- Remove rollback commands if enable_rollback_recording == false
if not core.settings:get_bool("enable_rollback_recording") then
    core.unregister_chatcommand("rollback_check")
    core.unregister_chatcommand("rollback")
    core.registered_privileges.rollback = nil
end
