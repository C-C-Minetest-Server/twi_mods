-- twi_mods/func_areas_limitations/init.lua
-- func area limitations
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

local S = minetest.get_translator("func_areas_limitations")

local function rm_chat_send(pos, player, name, msg)
    minetest.chat_send_player(name, msg)
    if minetest.features.node_interaction_actor then -- https://github.com/minetest/minetest/pull/14505
        minetest.after(0, minetest.dig_node, pos, player)
    else
        if minetest.get_node(pos).name ~= "air" then
            minetest.remove_node(pos)
            return true
        end
    end
end

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if not placer:is_player() then return end
    local name = placer:get_player_name()
    local item_name = itemstack:get_name()

    -- Public Tree farm top [41]
    if func_areas.is_in_func_area(pos, 41) then
        return rm_chat_send(pos, placer, name,
            S("You can only place down apple tree saplings in the Public Tree Farm."))
    end

    -- Public Tree farm bottom [225]
    if func_areas.is_in_func_area(pos, 225) and item_name ~= "default:sapling" then
        return rm_chat_send(pos, placer, name,
            S("You can only place down apple tree saplings in the Public Tree Farm."))
    end

    -- Public farm [13]
    if func_areas.is_in_func_area(pos, 13) and minetest.get_item_group(item_name, "seed") == 0 then
        return rm_chat_send(pos, placer, name,
            S("You can only place down plant seeds in the Public Farm."))
    end

    -- Cactus Farm [136]
    if func_areas.is_in_func_area(pos, 136) then
        return rm_chat_send(pos, placer, name,
            S("You are not allowed to place blocks in the Public Cactus Farm."))
    end
end)
