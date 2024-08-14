-- twi_mods/initial_stuff/init.lua
-- Give initial stuffs to new players
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

local stuffs_list = {
    "default:pick_steel",
    "default:shovel_steel",
    "default:axe_steel",
    "default:sword_steel",
    "default:torch 99",
    "animalia:beef_cooked 50"
}

minetest.register_on_newplayer(function(player)
    local name = player:get_player_name()
    local inv = player:get_inventory()
    for _, item in ipairs(stuffs_list) do
        inv:add_item("main", ItemStack(item))
    end

    unified_money.add_balance_safe(name, 30)
end)
