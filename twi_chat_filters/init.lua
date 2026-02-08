-- twi_mods/twi_chat_filters/init.lua
-- Hard-coded char filters with detailed explainataion
-- Copyright (C) 2026  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("twi_chat_filters")

local LIFO_WELCOME_STRING = "Welcome to Linux%-Forks! Please, read the rules at https://li%-fo%.de/rules ! " ..
    "If you would like a free apartment with free food %(take as you need%) then type /phw"

local blocked_string = {
    [LIFO_WELCOME_STRING] = S("LinuxForks default welcoming message detected. Please switch off the LIFO welcome CSM.")
}

beerchat.register_callback('on_receive', function(data)
    print(dump(data))
    print(dump(blocked_string))
    local name, message = data.name, data.message
    if not name or not message then return false end

    for pattern, warning in pairs(blocked_string) do
        if message:match(pattern) then
            if core.get_player_by_name(name) then
                core.chat_send_player(name, S("Warning: Chat message blocked: @1", warning))
            end
            return false
        end
    end

    return true
end)
