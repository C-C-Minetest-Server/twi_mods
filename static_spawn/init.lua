-- twi_mods/static_spawn/init.lua
--[[
    Copyright (C) 2014-2021 AndrejIT, spfar, mightyjoe781
    Copyright (C) 2024 1F616EMO

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
    USA
]]

S = minetest.get_translator("spawn")

minetest.register_chatcommand("spawn", {
    description = S("Teleport to spawnpoint"),
    privs = {
        home = true
    },
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, S("Player object not found.")
        end

        local spawn_pos = minetest.setting_get_pos("static_spawnpoint")
        if not spawn_pos then
            return false, S("Spawn point not set. Consult moderators to set a proper static spawnpoint.")
        end
        player:set_pos(spawn_pos)
        background_music.set_start_play_gap(name, 2)
        background_music.decide_and_play(player, true)
        return true, S("Teleported to Spawn!")
    end
})

minetest.register_chatcommand("setspawn", {
    description = S("Override the static spawnpoint"),
    privs = {
        server = true
    },
    param = "[<pos>]",
    func = function(name, param)
        if param == "" then
            local player = minetest.get_player_by_name(name)
            if not player then
                return false, S("Player object not found.")
            end
            param = minetest.pos_to_string(player:get_pos(), 0)
        else
            local pos = core.string_to_pos(param)
            if not pos then
                return false, S("Invalid position given.")
            end
            param = minetest.pos_to_string(pos)
        end

        minetest.settings:set("static_spawnpoint", param)

        return true, S("Static spawnpoint set to @1.", param)
    end
})

local last_shouted_spawn = {}

twi_fx.register_on_chat_message(function(name, message)
    local player = minetest.get_player_by_name(name)
    local spawn_pos = minetest.setting_get_pos("static_spawnpoint")
    if not (player and spawn_pos) then return end
    message = string.trim(message)
    message = string.lower(message)

    if message == "spawn" then
        local now = os.time()
        if last_shouted_spawn[name]
            and now - last_shouted_spawn[name] < 30 then
            player:set_pos(spawn_pos)
            background_music.decide_and_play(player, true)
            last_shouted_spawn[name] = nil
        else
            last_shouted_spawn[name] = now
        end
        minetest.after(0, function()
            if minetest.get_player_by_name(name) then
                minetest.chat_send_player(name, minetest.colorize("orange",
                    S("Tips! Put a slash (/) before \"spawn\" (i.e. /spawn) to teleport back Spawn instantly.")))
            end
        end)
    else
        last_shouted_spawn[name] = nil
    end
end)

minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    last_shouted_spawn[name] = nil
end)
