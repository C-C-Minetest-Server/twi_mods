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

local function is_seed(item_name)
    if item_name == "farming:beanpole"
        or item_name == "farming:trellis"
        or minetest.get_item_group(item_name, "seed") ~= 0 then
        return true
    end
    return false
end

local old_item_place_node_is_protected = extended_protection.item_place_node_is_protected
function extended_protection.item_place_node_is_protected(itemstack, placer, pointed_thing)
    if not placer:is_player() then return end
    local name = placer:get_player_name()
    local item_name = itemstack:get_name()
    local pos = extended_protection.pointed_thing_to_pos(pointed_thing)
    if not pos then return end

    if func_areas.is_in_func_area(pos, 41) then
        return true
    elseif func_areas.is_in_func_area(pos, 225) and item_name ~= "default:sapling" then
        return true
    elseif (func_areas.is_in_func_area(pos, 13)     -- Spawn Public Farm
            or func_areas.is_in_func_area(pos, 92)  -- SCL Jail Farm
            or func_areas.is_in_func_area(pos, 496) -- Eastern SmushyVille Public Farm
            or func_areas.is_in_func_area(pos, 548) -- Great SmushyVille Public Farm
        -- or func_areas.is_in_func_area(pos, 400) -- cycle's Public Farm
        ) and not is_seed(item_name) then
        return true
    elseif func_areas.is_in_func_area(pos, 136) then
        return true
    end

    return old_item_place_node_is_protected(itemstack, placer, pointed_thing)
end

extended_protection.register_on_item_place_node_protection_violation(function(itemstack, placer, pointed_thing)
    if not placer:is_player() then return end
    local name = placer:get_player_name()
    local item_name = itemstack:get_name()
    local pos = extended_protection.pointed_thing_to_pos(pointed_thing)
    if not pos then return end

    if func_areas.is_in_func_area(pos, 41) then
        minetest.chat_send_player(name, S("You can only place down apple tree saplings in the Public Tree Farm."))
    elseif func_areas.is_in_func_area(pos, 225) and item_name ~= "default:sapling" then
        minetest.chat_send_player(name, S("You can only place down apple tree saplings in the Public Tree Farm."))
    elseif (func_areas.is_in_func_area(pos, 13)     -- Spawn Public Farm
            or func_areas.is_in_func_area(pos, 92)  -- SCL Jail Farm
            or func_areas.is_in_func_area(pos, 496) -- Eastern SmushyVille Public Farm
            or func_areas.is_in_func_area(pos, 548) -- Great SmushyVille Public Farm
        -- or func_areas.is_in_func_area(pos, 400) -- cycle's Public Farm
        ) and not is_seed(item_name) then
        minetest.chat_send_player(name, S("You can only place down plant seeds in the Public Farm."))
    elseif func_areas.is_in_func_area(pos, 136) then
        minetest.chat_send_player(name, S("You are not allowed to place blocks in the Public Cactus Farm."))
    end
end)
