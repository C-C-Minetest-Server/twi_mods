-- twi_mods/crash_workaround/init.lua
-- Avoid the cause of segfault
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

-- Autocrafter psudo-item
-- For unknwon reason this is identical to flux's, but trust me, I wrote this without his
-- https://discord.com/channels/369122544273588224/369123275877384192/1193075939903553669
local ndef                              = minetest.registered_nodes["pipeworks:autocrafter"]
local old_allow_metadata_inventory_put  = ndef.allow_metadata_inventory_put
local old_allow_metadata_inventory_take = ndef.allow_metadata_inventory_take
local old_allow_metadata_inventory_move = ndef.allow_metadata_inventory_move
minetest.override_item("pipeworks:autocrafter", {
    allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
        if listname == "output" then
            return 0
        end
        return old_allow_metadata_inventory_put(pos, listname, index, stack, player)
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        if listname == "output" then
            return 0
        end
        return old_allow_metadata_inventory_take(pos, listname, index, stack, player)
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        if from_list == "output" or to_list == "output" then
            return 0
        end
        return old_allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
    end,
})
minetest.log("action", "[crash_workaround] Autocrafter workaround loaded")
