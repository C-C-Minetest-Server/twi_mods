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

local S = minetest.get_translator("newcomer_tips")
local C = minetest.colorize

local time_joined = {}

local msg = table.concat({
    S("Welcome to 1F616EMO Survival Server!"),
    S("Read the rules at @1, or TL;DR: respect others.", "https://wiki-twi.1f616emo.xyz/wiki/Project:Rules"),
    S("You can ask for help in the chatroom. Type \"/report\" if you want to contact the moderation team."),
    S("Have fun!"),
}, "\n") 

minetest.register_on_newplayer(function(player)
    local meta = player:get_meta()
    meta:set_int("newcomer_tips_send", 1)
end)

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local meta = player:get_meta()
    if meta:get_int("newcomer_tips_send") == 1 then
        time_joined[name] = os.time()
        minetest.after(0.5, function()
            if minetest.get_player_by_name(name) then
                minetest.chat_send_all(C("yellow", S("Welcome our new player, @1!", name)))
                minetest.chat_send_player(name, msg)
            end
        end)
    end
end)

local TIME_NEEDED = 2 * 60

minetest.register_on_leaveplayer(function(player)
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
            local player = minetest.get_player_by_name(name)
            local meta = player:get_meta()
            meta:set_int("newcomer_tips_send", 0)
            time_joined[name] = nil
        end
    end

    minetest.after(30, loop)
end

minetest.after(5, loop)
