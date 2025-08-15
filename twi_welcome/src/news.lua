-- twi_mods/twi_welcome/src/news.lua
-- Server news
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local http = ...

local hud = mhud.init()

local S = core.get_translator("twi_welcome")
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local function fetch_news(callback)
    return html_to_luanti.helpers.parse_mediawiki_page(
        http,
        "https://wiki-twi.1f616emo.xyz/api.php",
        "Template:News",
        function(fs_hypertext, revid)
            return callback(fs_hypertext and {
                fs_hypertext = fs_hypertext,
                revid = revid,
            } or nil)
        end)
end

local news_cache = nil
local news_cache_revid = nil

local function player_check(player)
    local pname = player:get_player_name()
    local meta = player:get_meta()

    if news_cache_revid ~= meta:get_string("twi_welcome:news_revid") then
        core.chat_send_player(pname, core.colorize("green", S("There are news updates, type /news to see them")))

        if not hud:exists(player, "text") and not hud:exists(player, "bg") then
            hud:add(player, "text", {
                hud_elem_type = "text",
                position = { x = 1, y = 1 },
                offset = { x = -24, y = -22 },
                alignment = { x = "left", y = "up" },
                text = S("There are news updates, type /news to see them"),
                color = 0x00FF00,
                z_index = 100
            })
            hud:add(player, "bg", {
                hud_elem_type = "image",
                position = { x = 1, y = 1 },
                alignment = { x = "left", y = "up" },
                texture = "twi_welcome_news_gui_formbg.png",
                image_scale = 0.8,
                z_index = 99
            })

            core.after(60, function()
                if hud:exists(pname, "text") then
                    hud:clear(pname)
                end
            end)
        end
    end
end

function twi_welcome.update_news(callback)
    return fetch_news(function(news)
        if news then
            news_cache = news.fs_hypertext
            news_cache_revid = tostring(news.revid)

            for _, player in pairs(core.get_connected_players()) do
                player_check(player)
            end

            if callback then
                return callback(true)
            end
        elseif callback then
            return callback(false)
        end
    end)
end

function twi_welcome.get_news()
    return news_cache, news_cache_revid
end

do
    local time = 0
    core.register_globalstep(function(dtime)
        time = time + dtime
        if time >= (60 * 5) then
            time = 0
        else
            return
        end

        twi_welcome.update_news()
    end)
end

function twi_welcome.show_news_formspec(name)
    local player = core.get_player_by_name(name)
    if not player then
        return
    end

    local news = twi_welcome.get_news()

    if not news then
        return false
    end

    local formspec = "formspec_version[5]" ..
        "size[13,12]" ..
        "style_type[label;font_size=*2]" ..
        "label[0.2,0.7;" .. FS("Server News") .. "]" ..
        "style_type[label;font_size=]" ..
        "button_exit[5,11;3,0.9;exit;OK]" ..
        "hypertext[0.2,1.2;12.8,9.4;news;" .. F(news) .. "]"

    core.show_formspec(name, "twi_welcome:news", formspec)

    return true
end

function twi_welcome.register_check_news(pname)
    local player = core.get_player_by_name(pname)
    if not player then return end
    local meta = player:get_meta()

    meta:set_string("twi_welcome:news_revid", news_cache_revid)
    if hud:exists(pname, "text") then
        hud:clear(pname)
    end
end

core.register_on_joinplayer(player_check)

twi_welcome.update_news()

core.register_chatcommand("news", {
    description = S("Show the latest news"),
    func = function(name)
        twi_welcome.register_check_news(name)
        if twi_welcome.show_news_formspec(name) then
            return true, S("News shown.")
        else
            return false, S("Failed to fetch news.")
        end
    end,
})

core.register_chatcommand("update_news", {
    description = S("Update the news cache"),
    privs = { server = true },
    func = function(name)
        twi_welcome.update_news(function(news)
            if news then
                core.chat_send_player(name, S("News cache updated."))
            else
                core.chat_send_player(name, S("Failed to update news cache."))
            end
        end)
        return true
    end,
})
