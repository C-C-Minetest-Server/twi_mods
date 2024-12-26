-- twi_mods/spam_kick/init.lua
-- Kick spammers
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

twi_fx.register_on_chat_message(function(name, message)
    if string.sub(message, 1, 1) == "/" then return end

    if string.find(message, "ronwyatt%.com") and core.get_player_by_name(name) then
        core.chat_send_player(name, "Spam keyword matched. (#14)")
        return true
    end
end)