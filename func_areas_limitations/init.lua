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

local S = core.get_translator("func_areas_limitations")

core.register_privilege("public_farm", {
    description = S("Can use public farms"),
    give_to_singleplayer = true,
})

core.register_on_newplayer(function(player)
    -- Assume new players have privs properly set
    local meta = player:get_meta()
    meta:set_int("func_areas_limitations_public_farm", 1)
end)

core.register_on_joinplayer(function(player)
    local meta = player:get_meta()
    if meta:get_int("func_areas_limitations_public_farm") == 1 then
        return
    end

    local name = player:get_player_name()
    local privs = core.get_player_privs(name)
    if not privs.public_farm then
        privs.public_farm = true
        core.set_player_privs(name, privs)
    end
    meta:set_int("func_areas_limitations_public_farm", 1)
end)

local function is_seed(item_name)
    if item_name == "farming:beanpole"
        or item_name == "farming:trellis"
        or core.get_item_group(item_name, "seed") ~= 0 then
        return true
    end
    return false
end

local function is_in_public_farm(pos)
    return func_areas.is_in_func_area(pos, 13)  -- Spawn Public Farm
        or func_areas.is_in_func_area(pos, 92)  -- SCL Jail Farm
        or func_areas.is_in_func_area(pos, 496) -- Eastern SmushyVille Public Farm
        or func_areas.is_in_func_area(pos, 548) -- Great SmushyVille Public Farm
    --  or func_areas.is_in_func_area(pos, 400) -- cycle's Public Farm
end

local old_is_protected = core.is_protected
function core.is_protected(pos, name)
    if is_in_public_farm(pos) and not core.check_player_privs(name, { public_farm = true }) then
        return true
    end
    return old_is_protected(pos, name)
end

core.register_on_protection_violation(function(pos, name)
    if is_in_public_farm(pos) and not core.check_player_privs(name, { public_farm = true }) then
        if core.get_player_by_name(name) then
            core.chat_send_player(name, S("You are banned from using Public Farms. " ..
                "Contact moderators for more information."))
        end
    end
end)

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
    elseif is_in_public_farm(pos) and not is_seed(item_name) then
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
        core.chat_send_player(name, S("You can only place down apple tree saplings in the Public Tree Farm."))
    elseif func_areas.is_in_func_area(pos, 225) and item_name ~= "default:sapling" then
        core.chat_send_player(name, S("You can only place down apple tree saplings in the Public Tree Farm."))
    elseif is_in_public_farm(pos) and not is_seed(item_name) then
        core.chat_send_player(name, S("You can only place down plant seeds in the Public Farm."))
    elseif func_areas.is_in_func_area(pos, 136) then
        core.chat_send_player(name, S("You are not allowed to place blocks in the Public Cactus Farm."))
    end
end)
