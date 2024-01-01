-- twi_mods/spawn/init.lua
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
            return false
        end

        local spawn_pos = minetest.setting_get_pos("static_spawnpoint")
        if not spawn_pos then
            return false, S("Spawn point not set. Consult moderators to set a proper static_spawnpoint.")
        end
        player:set_pos(spawn_pos)
        return true, S("Teleported to Spawn!")
    end
})