-- twi_mods/spam_kick/init.lua
-- Kick spammers
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local register_on_chat_message =
    minetest.global_exists("beerchat")
    and beerchat.register_on_chat_message
    or minetest.register_on_chat_message
register_on_chat_message(function(name, message)
    if string.sub(message, 1, 1) == "/" then return end

    if string.find(message, "ronwyatt%.com") and minetest.get_player_by_name(name) then
        minetest.chat_send_player(name, "Spam keyword matched. (#14)")
    end

    return true
end)