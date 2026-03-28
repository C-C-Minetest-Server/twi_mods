-- twi_mods/twi_welcome/src/chatroom_tutorial/init.lua
-- Tutorial of how to open chat, and hud message
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("twi_welcome")
local hud = mhud.init()

--[[
Override chain of on-join tutorials:
1. Wang Fuk Court mourning message (26-28 of each month, shown once per month, or after executing /wfc_message_test)
2. MultiCraft Deprecation Notice (2026-03 to 2026-05-15, for all outdated clients)
3. Chatroom tutorial (default, for all new players)
]]


-- Chatroom tutorial
teacher.register_tutorial("chatroom_tutorial:chatroom", {
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


-- MultiCraft Deprecation notice
-- To be replaced by code that blocks players on old clients in 2026-05-15
-- Note: We support the latest dev version, latest stable version, and one version before the stable.
local min_protocol_version = 50 -- 5.14.0
local min_formspec_version = 10 -- 5.13.0

teacher.register_tutorial("chatroom_tutorial:multicraft_deprecation", {
    title = S("MultiCraft Deprecation Notice"),
    {
        texture = "twi_welcome_multicraft_deprecation.jpg",
        text = {
            S(
                "To better utilize new client-side features, MultiCraft, " ..
                "which is the only approved client on iOS, will be " ..
                "deprecated, and players will soon be unable to join the " ..
                "server with it. MultiCraft is based on Luanti 5.4.1, " ..
                "a version released 5 years ago, and is missing various " ..
                "client-side rendering features. It's not Luanti's fault, " ..
                "but due to Apple's evilness for imposing restrictions " ..
                "going against free software."
            ),
            S(
            "The change will happen in mid-May 2026. To continue playing " ..
                "on the server, iOS players are advised to switch to a PC " ..
                "or use an Android phone."
            ),
            S("If you are not playing on MultiCraft but still received this " ..
                "message, it means your client is outdated and also lacks " ..
                "necessary features. Please update to the latest official " ..
                "client (Luanti @1), which can be downloaded from @2.",
                "5.15.0", "https://luanti.org/"
            ),
        }
    },
})

-- Should be the w.wiki short link of the language.
local WFC_WIKILINK = S("https://w.wiki/GSeT")

-- Translation guide: BOTH English and Chinese (Traditional) should be seen as the source languages.
teacher.register_tutorial("chatroom_tutorial:wfc_fire", {
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
            S(
                "\"If human error causes a catastrophe, the lesson is not " ..
                "that it's the person's fault, it's that the system is " ..
                "unsafe and lacks guardrails to prevent the same thing " ..
                "happening again in the future.\" - by Mlkj, when talking " ..
                "about a Wikipedia incident, @1", "https://w.wiki/KJS4"
            ),
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
    local this_month = twi_fx.is_wang_fuk_court_mourning()
    if
        (this_month and meta:get_int("chatroom_tutorial_wfc_message_last") < this_month)
        or meta:get_int("chatroom_tutorial_wfc_message_test") ~= 0
    then
        meta:set_int("chatroom_tutorial_wfc_message_test", 0)
        meta:set_int("chatroom_tutorial_wfc_message_last", this_month)

        -- Show regardless of whether this have been unlocked before
        teacher.unlock_entry_for_player(player, "chatroom_tutorial:wfc_fire")
        teacher.simple_show(player, "chatroom_tutorial:wfc_fire")
        return
    end

    -- Deprecation notice logics
    local pname = player:get_player_name()
    local pinfo = core.get_player_information(pname)
    local protocol_version = pinfo.protocol_version or 0
    local formspec_version = pinfo.formspec_version or 0
    if protocol_version < min_protocol_version or formspec_version < min_formspec_version then
        teacher.unlock_entry_for_player(player, "chatroom_tutorial:multicraft_deprecation")
        teacher.simple_show(player, "chatroom_tutorial:multicraft_deprecation")
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
