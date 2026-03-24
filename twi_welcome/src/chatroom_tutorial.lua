-- twi_mods/twi_welcome/src/chatroom_tutorial/init.lua
-- Tutorial of how to open chat, and hud message
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("twi_welcome")
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

-- Should be the w.wiki short link of the language.
local WFC_WIKILINK = S("https://w.wiki/GSeT")

teacher.register_turorial("chatroom_tutorial:wfc_fire", {
    title = S("The Wang Fuk Court fire"),
    {
        texture = "twi_welcome_wfc.jpg",
        text = {
            S(
                "On 26 November 2025, a large fire broke out at the " ..
                "Wang Fuk Court apartment complex in Hong Kong and burned " ..
                "for two days. 168 lives were lost in this tragedy. " ..
                "Improper use of combustible safety nets and expanded " ..
                "polystyrene foam boards accelerated the spread of the " ..
                "fire, and multiple opportunities to prevent the fire have " ..
                "been missed due to governmental oversight."
            ),
            S("The calamity, as well as all the losses of lives and " ..
                "suffers, shall not be forgotten."),
            S("Learn more: @1", WFC_WIKILINK),
        },
    },
})

local function show_to(name)
    local player = core.get_player_by_name(name)
    if player then
        teacher.unlock_and_show(player, "chatroom_tutorial:chatroom", nil)
    end
end

core.register_on_newplayer(function(player)
    local meta = player:get_meta()
    meta:set_int("chatroom_tutorial_show_msg", 1)
    meta:set_int("chatroom_tutorial_show_tutorial", 1)
end)

core.register_on_joinplayer(function(player)
    local meta = player:get_meta()

    if meta:get_int("chatroom_tutorial_show_msg") ~= 0 then
        hud:add(player, "chatroom_tutorial_show_msg", {
            hud_elem_type = "text",
            position = { x = 0.5, y = 0.5 },
            offset = { x = 0, y = 42 },
            text = S("Click on the top-right speech bubble icon to get help. (Press T on PC)"),
            text_scale = 1,
            color = 0xFFD700,
        })
    else
        meta:set_int("chatroom_tutorial_show_tutorial", 0)
    end

    -- Wang Fuk Court fire mourning
    -- Show every month between 26 and 28 server time
    -- Or after executing /wfc_message_test on last login
    -- Abort showing chatroom tutorial when WFC is shown
    local this_month = tonumber(os.date("%Y%m"))
    local this_date = tonumber(os.date("%d"))
    if
        (
            this_date >= 26 and this_date <= 28
            and meta:get_int("chatroom_tutorial_wfc_message_last") < this_month
        )
        or meta:get_int("chatroom_tutorial_wfc_message_test") ~= 0
    then
        meta:set_int("chatroom_tutorial_wfc_message_test", 0)
        meta:set_int("chatroom_tutorial_wfc_message_last", this_month)

        -- Show regardless of whether this have been unlocked before
        teacher.unlock_entry_for_player(player, "chatroom_tutorial:wfc_fire")
        teacher.simple_show(player, "chatroom_tutorial:wfc_fire")
        return
    end

    if meta:get_int("chatroom_tutorial_show_tutorial") ~= 0 then
        teacher.unlock_and_show(player, "chatroom_tutorial:chatroom", nil)
    end
end)

twi_fx.register_on_chat_message(function(name, message)
    if string.sub(message, 1, 1) == "/" then return end

    local player = core.get_player_by_name(name)
    if not player then return end

    if hud:exists(player, "chatroom_tutorial_show_msg") then
        local meta = player:get_meta()
        meta:set_int("chatroom_tutorial_show_msg", 0)
        meta:set_int("chatroom_tutorial_show_tutorial", 0)
        hud:remove(player, "chatroom_tutorial_show_msg")
    end
end)

core.register_chatcommand("wfc_message_test", {
    description = S("Show Wang Fuk Court mourning message on next re-login"),
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, S("You must be online to run this command.")
        end

        local meta = player:get_meta()
        meta:set_int("chatroom_tutorial_wfc_message_test", 1)
        return true, S("Mourning message will be shown on next login.")
    end,
})
