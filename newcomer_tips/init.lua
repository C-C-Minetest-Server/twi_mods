-- twi_mods/newcomer_tips/init.lua
-- Tips for newcomers
--[[
    The MIT License (MIT)

    Copyright © 2024 1F616EMO

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
    of the Software, and to permit persons to whom the Software is furnished to do
    so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

local S = core.get_translator("newcomer_tips")
local C = core.colorize

local time_joined = {}

local msg = table.concat({
    S("Welcome to 1F616EMO Survival Server!"),
    S("Read the rules at @1, or TL;DR: respect others.", "https://wiki-twi.1f616emo.xyz/wiki/Project:Rules"),
    S("You can ask for help in the chatroom. Type \"/report\" if you want to contact the moderation team."),
    S("Have fun!"),
}, "\n") 

core.register_on_newplayer(function(player)
    local meta = player:get_meta()
    meta:set_int("newcomer_tips_send", 1)
end)

core.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local meta = player:get_meta()
    if meta:get_int("newcomer_tips_send") == 1 then
        time_joined[name] = os.time()
        core.after(0.5, function()
            if core.get_player_by_name(name) then
                core.chat_send_all(C("yellow", S("Welcome our new player, @1!", name)))
                core.chat_send_player(name, msg)
            end
        end)
    end
end)

local TIME_NEEDED = 2 * 60

core.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    if time_joined[name] and os.time() - time_joined[name] > TIME_NEEDED then
        local meta = player:get_meta()
        meta:set_int("newcomer_tips_send", 0)
    end
    time_joined[name] = nil
end)

local function loop()
    local now = os.time()
    for name, time in pairs(time_joined) do
        if now - time > TIME_NEEDED then
            local player = core.get_player_by_name(name)
            local meta = player:get_meta()
            meta:set_int("newcomer_tips_send", 0)
            time_joined[name] = nil
        end
    end

    core.after(30, loop)
end

core.after(5, loop)

twi_fx.register_on_chat_message(function(name, message)
    local player = core.get_player_by_name(name)
    local spawn_pos = core.setting_get_pos("static_spawnpoint")
    if not (player and spawn_pos) then return end
    local meta = player:get_meta()
    if meta:get_int("newcomer_tips_send") ~= 1 then return end
    message = string.lower(message)

    if string.find(message, "spawn") then
        core.after(0, function()
            if core.get_player_by_name(name) then
                core.chat_send_player(name, core.colorize("orange",
                    S("Tip! Type \"/spawn\" (without the quotes but with the slash) to get back tp the spawnpoint.")))
            end
        end)
    elseif string.find(message, "escape") or string.find(message, "stuck") then
        core.after(0, function()
            if core.get_player_by_name(name) then
                core.chat_send_player(name, core.colorize("orange",
                    S("Tip! Type \"/spawn\" (without the quotes but with the slash) to escape.")))
            end
        end)
    end
end)
