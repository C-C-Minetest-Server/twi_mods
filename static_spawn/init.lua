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

local S = core.get_translator("spawn")

core.register_chatcommand("spawn", {
    description = S("Teleport to the spawn point"),
    privs = {
        home = true
    },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, S("Player object not found.")
        end

        local spawn_pos = core.setting_get_pos("static_spawnpoint")
        if not spawn_pos then
            return false, S("Spawn point not set. Consult moderators to set a proper static spawnpoint.")
        end
        player:set_pos(spawn_pos)
        background_music.set_start_play_gap(name, 2)
        background_music.decide_and_play(player, true)
        return true, S("Teleported to Spawn!")
    end
})

core.register_chatcommand("setspawn", {
    description = S("Override the static spawnpoint"),
    privs = {
        server = true
    },
    param = "[<pos>]",
    func = function(name, param)
        if param == "" then
            local player = core.get_player_by_name(name)
            if not player then
                return false, S("Player object not found.")
            end
            param = core.pos_to_string(player:get_pos(), 0)
        else
            local pos = core.string_to_pos(param)
            if not pos then
                return false, S("Invalid position given.")
            end
            param = core.pos_to_string(pos)
        end

        core.settings:set("static_spawnpoint", param)

        return true, S("Static spawnpoint set to @1.", param)
    end
})

core.register_chatcommand("origin", {
    description = S("Teleport to Origin"),
    privs = {
        home = true
    },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, S("Player object not found.")
        end

        player:set_pos({ x = 37, y = 18, z = -42 })
        background_music.set_start_play_gap(name, 2)
        background_music.decide_and_play(player, true)
        return true, S("Teleported to Origin!")
    end
})

core.register_chatcommand("grapehills", {
    description = S("Teleport to Grape Hills"),
    privs = {
        home = true
    },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, S("Player object not found.")
        end

        player:set_pos({ x = -3292, y = 19, z = 1027 })
        background_music.set_start_play_gap(name, 2)
        background_music.decide_and_play(player, true)
        return true, S("Teleported to Grape Hills!")
    end
})