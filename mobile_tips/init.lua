-- twi_mods/mobile_tips/init.lua
-- Tips for mobile devices
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

local S = minetest.get_translatr("mobile_tips")

local function is_mobile(name)
    local player_info = minetest.get_player_information(name)
    local window_info = minetest.get_player_window_information(name)

    if player_info.formspec_version <= 4 and player_info.protocol_version <= 39 then
        -- These are values of MultiCraft 2.0.6
        -- Though not 100% MultiCraft or mobile, we have no way to detect
        return true
    end

    if window_info and window_info.touch_controls then
        -- This is only `true` on 5.9.0 or later, but anyway use this to detect
        return true
    end

    return false
end

local msg = table.concat({
    S("Seems like you are playing on a mobile phone."),
    S("Tap to place node, and long press to dig node."),
    S("If other players mention \"right-click\" or \"left-click\", they mean \"tap\" and \"long press\"."),
    S("Tap the \"chat box\" logo on the right-top corner if you need help."),
}, "\n")

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    if is_mobile(name) then
        minetest.after(1, function()
            if minetest.get_player_by_name(name) then
                minetest.chat_send_player(name, msg)
            end
        end)
    end
end)
