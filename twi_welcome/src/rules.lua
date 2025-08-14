-- twi_mods/twi_welcome/src/rules.lua
-- Server rules
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local http = ...

local S = core.get_translator("twi_welcome")
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local rules_cache = nil

local function fetch_rules(callback)
    return html_to_luanti.helpers.parse_mediawiki_page(
        http,
        "https://wiki-twi.1f616emo.xyz/api.php",
        "Administration:Rules",
        function(fs_hypertext, revid)
            return callback(fs_hypertext)
        end)
end

function twi_welcome.update_rules(callback)
    return fetch_rules(function(rules)
        if rules then
            rules_cache = rules
            if callback then
                return callback(true)
            end
            return
        end
        if callback then
            return callback(false)
        end
    end)
end

function twi_welcome.get_rules()
    return rules_cache
end

function twi_welcome.show_rules_formspec(player_name)
    local rules = twi_welcome.get_rules()
    if not rules then
        return false, S("Rules are not available at the moment.")
    end

    local formspec ="formspec_version[5]" ..
        "size[13,12]" ..
        "style_type[label;font_size=*2]" ..
        "label[0.2,0.7;" .. FS("Server Rules") .. "]" ..
        "style_type[label;font_size=]" ..
        "button_exit[5,11;3,0.9;exit;OK]" ..
        "hypertext[0.2,1.2;12.8,9.4;rules;" .. F(rules) .. "]"

    core.show_formspec(player_name, "twi_welcome:rules", formspec)
    return true
end

twi_welcome.update_rules()

core.register_chatcommand("rules", {
    description = S("Show the rules"),
    func = function(name)
        if twi_welcome.show_rules_formspec(name) then
            return true, S("Rules shown.")
        else
            return false, S("Failed to fetch rules.")
        end
    end,
})

core.register_chatcommand("update_rules", {
    description = S("Update the rules cache"),
    privs = { server = true },
    func = function(name)
        twi_welcome.update_rules(function(news)
            if news then
                core.chat_send_player(name, S("Rules cache updated."))
            else
                core.chat_send_player(name, S("Failed to update rules cache."))
            end
        end)
        return true
    end,
})
