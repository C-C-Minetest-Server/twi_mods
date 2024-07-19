-- twi_mods/list_moderators/init.lua
-- Send list of moderators after join
--[[
    Copyright © 2024 1F616EMO

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
]]

local S = minetest.get_translator("list_moderators")

local function is_afk() return false end

if minetest.global_exists("afk_indicator") then
    is_afk = function(name)
        local duration = afk_indicator.get(name)
        return duration and duration > 5 * 60 or false
    end
end

local color = minetest.get_color_escape_sequence("DarkOrange")

local function get_chat_string(name)
    local list_moderators = {}
    for _, player in pairs(core.get_connected_players()) do
        local player_name = player:get_player_name()
        local privs = minetest.get_player_privs(player_name)
        if privs.ban == true then
            local display = player_name
            local flags = {}

            if name == player_name then
                flags[#flags+1] = S("You")
            end

            if privs.server then
                flags[#flags + 1] = S("Admin")
            end

            if is_afk(player_name) then
                flags[#flags + 1] = S("AFK")
            end

            if #flags > 0 then
                display = display .. " " ..
                    minetest.get_color_escape_sequence("DarkCyan") .. "(" .. table.concat(flags, ", ") .. ")" .. color
            end

            list_moderators[#list_moderators + 1] = display
        end
    end
    if #list_moderators > 0 then
        return color ..
            S("List of moderators online: @1", table.concat(list_moderators, ", "))
    else
        return color ..
            S("No moderators online. Seek help by typing /report in the chatroom.")
    end
end

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    minetest.after(0.5, function()
        if minetest.get_player_by_name(name) then
            minetest.chat_send_player(name, get_chat_string(name))
        end
    end)
end)

minetest.register_chatcommand("list_mods", {
    description = S("List all moderators"),
    func = function(name)
        return true, get_chat_string(name)
    end,
})