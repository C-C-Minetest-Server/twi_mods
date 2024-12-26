-- twi_mods/teacher_tutorial_public_mine/init.lua
-- Tutorial on the Public Mine
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("teacher_tutorial_public_mine")

teacher.register_turorial("teacher_tutorial_public_mine:public_mine", {
    title = S("The Public Mine"),
    {
        texture = "teacher_tutorial_public_mine_1.jpg",
        text =
            S("Are you struggling to find iron and diamond ores? You can use the public mine, " ..
                "located 3 km below sea level. For most minerals, the deeper you go, the more you get.")
    },
    {
        texture = "teacher_tutorial_public_mine_2.jpg",
        text =
            S("To access the public mine, go to the spawn point by typing /spawn in the chatroom. " ..
                "Then, turn left and follow the sign reading \"Public Mine\". " ..
                "Right-click or tap on the travelnet box and select a destination.")
    },
})

local stone_counter = {}
local old_on_dig = core.registered_nodes["default:stone"].on_dig or core.node_dig

core.override_item("default:stone", {
    on_dig = function(pos, node, player)
        if old_on_dig(pos, node, player) == false then
            return false
        elseif not player or not player:is_player() or player.is_fake_player then
            return true
        end
        local name = player:get_player_name()
        if pos.y < -200 then
            teacher.unlock_entry_for_player(player, "teacher_tutorial_public_mine:public_mine")
            stone_counter[name] = false
            return true
        elseif stone_counter[name] == false then
            return true
        elseif stone_counter[name] == nil then
            stone_counter[name] = {1, os.time()}
        elseif stone_counter[name][1] > 50 then
            teacher.unlock_entry_for_player(player, "teacher_tutorial_public_mine:public_mine")
            teacher.simple_show(player, "teacher_tutorial_public_mine:public_mine")
            stone_counter[name] = false
        else
            stone_counter[name][1] = stone_counter[name][1] + 1
            stone_counter[name][2] = os.time()
        end
        return true
    end,
})

core.register_on_joinplayer(function(player)
    local data = teacher.get_player_data(player)
    if data["teacher_tutorial_public_mine:public_mine"] then
        stone_counter[player:get_player_name()] = false
    end
end)

core.register_on_leaveplayer(function(player)
    stone_counter[player:get_player_name()] = nil
end)

modlib.minetest.register_globalstep(31, function()
    local now = os.time()
    for name, data in pairs(stone_counter) do
        if data ~= false and now - data[2] > 60 then
            stone_counter[name] = nil
        end
    end
end)