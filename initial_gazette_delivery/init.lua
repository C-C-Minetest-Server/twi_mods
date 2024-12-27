-- twi_mods/initial_gazette_delivery/init.lua
-- Delivery of G. 2024-12-27-02
--[[
    Copyright (C) 2024 1F616EMO

    The MIT License (MIT)

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

local gazette_content
do
    local f = io.open(core.get_modpath("initial_gazette_delivery") .. DIR_DELIM .. "gazette-2024-12-26-02.txt", "r")
    gazette_content = f:read("*a")
    f:close()
end

core.register_on_newplayer(function(player)
    local name = player:get_player_name()

    local mail_packet = {
        from = "1F616EMO",
        to = name,
        subject = "Gazette Delivery Service (G. 2024-12-26-02)",
        body = gazette_content,
    }

    mail.send(mail_packet)
end)