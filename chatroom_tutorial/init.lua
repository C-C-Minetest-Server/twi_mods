-- twi_mods/chatroom_tutorial/init.lua
-- Tutorial of how to open chat, and hud message
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = minetest.get_translator("chatroom_tutorial")
local hud = mhud.init()

teacher.register_turorial("chatroom_tutorial:chatroom", {
    title = S("How to find help?"),
    {
        texture = "chat_grant_interact_teacher_1.jpg",
        text = {
            S("If you need help in non-English languages, type in the chatroom with your mother language, " ..
                "or use a translator (e.g. Google Translate) to communicate."),
            S("To seek help, use the chatroom. To start chatting:"),
            S("On Mobile Phones or iPads: Look at the top right corner of your screen. " ..
                "Tap the chat box icon."),
            S("On PC or Mac: Press the \"T\" key on your keyboard to open the chat box."),
        }
    },
})

local function show_to(name)
    local player = minetest.get_player_by_name(name)
    if player then
        teacher.unlock_and_show(player, "chatroom_tutorial:chatroom", nil)
    end
end

minetest.register_on_newplayer(function(player)
    player:get_meta():set_int("chatroom_tutorial_show_msg", 1)
    minetest.after(-1, show_to, player:get_player_name())
end)

minetest.register_on_joinplayer(function(player)
    if player:get_meta():get_int("chatroom_tutorial_show_msg") ~= 0 then
        hud:add(player, "chatroom_tutorial_show_msg", {
            hud_elem_type = "text",
            position = { x = 0.5, y = 0.5 },
            offset = { x = 0, y = 42 },
            text = S("Click on the top-right speech bubble icon to get help. (T on PC)"),
            text_scale = 1,
            color = 0xFFD700,
        })
    end
end)

twi_fx.register_on_chat_message(function(name, message)
    if string.sub(message, 1, 1) == "/" then return end

    local player = minetest.get_player_by_name(name)
    if not player then return end

    if hud:exists(player, "chatroom_tutorial_show_msg") then
        player:get_meta():set_int("chatroom_tutorial_show_msg", 0)
        hud:remove(player, "chatroom_tutorial_show_msg")
    end
end)
