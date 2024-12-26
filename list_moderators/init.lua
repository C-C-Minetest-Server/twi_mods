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

local S = core.get_translator("list_moderators")

local function is_afk() return false end

if core.global_exists("afk_indicator") then
    is_afk = function(name)
        local duration = afk_indicator.get(name)
        return duration and duration > 5 * 60 or false
    end
end

local color = core.get_color_escape_sequence("DarkOrange")
local alt_color = core.get_color_escape_sequence("DarkCyan")

local busy_mods = {}

local function get_chat_string(name)
    local list_moderators = {}
    local list_helpers = {}
    for _, player in pairs(core.get_connected_players()) do
        local player_name = player:get_player_name()
        local privs = core.get_player_privs(player_name)
        local list
        if privs.ban == true then
            list = list_moderators
        elseif privs.role_helper == true then
            list = list_helpers
        end
        if list then
            local display = player_name
            local flags = {}

            if name == player_name then
                flags[#flags + 1] = S("You")
            end

            if privs.server then
                flags[#flags + 1] = S("Admin")
            end

            if is_afk(player_name) then
                flags[#flags + 1] = S("AFK")
            end

            if busy_mods[player_name] then
                flags[#flags + 1] = S("Busy")
            end

            if #flags > 0 then
                display = display .. " " ..
                    alt_color .. "(" .. table.concat(flags, ", ") .. ")" .. color
            end

            list[#list + 1] = display
        end
    end
    local rtn
    if #list_moderators > 0 then
        rtn = color ..
            S("List of moderators online: @1", table.concat(list_moderators, ", "))
    else
        rtn = color ..
            S("No moderators online. Seek help by typing /report in the chatroom.")
    end
    if #list_helpers > 0 then
        rtn = rtn .. "\n" .. color .. S("List of helpers online: @1", table.concat(list_helpers, ", "))
    end
    return rtn
end

core.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    core.after(0.5, function()
        if core.get_player_by_name(name) then
            core.chat_send_player(name, get_chat_string(name))
        end
    end)
end)

core.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    busy_mods[name] = nil
end)

core.register_on_priv_revoke(function(name, _, priv)
    local privs = core.get_player_privs(name)
    if priv == "ban" and not privs.role_helper
        or privs == "role_helper" and not privs.ban then
        busy_mods[name] = nil
    end
end)

core.register_chatcommand("mods_busy", {
    description = S("Set yourself as busy on the moderator list"),
    func = function(name)
        local privs = core.get_player_privs(name)
        if not (privs.ban or privs.role_helper) then
            return false, S("Insufficant privileges!")
        end
        local prev_status = busy_mods[name]
        busy_mods[name] = prev_status == nil and true or nil
        return true, prev_status and S("Set to normal.") or S("Set to busy.")
    end,
})

core.register_chatcommand("list_mods", {
    description = S("List all moderators and helpers"),
    func = function(name)
        return true, get_chat_string(name)
    end,
})
