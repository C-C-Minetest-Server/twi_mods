-- twi_mods/technic_mod/init.lua
-- Modifications on technic mods
--[[
    Copyright (C) 2012-2024  Technic contributors
    Copyright (C) 2024  1F616EMO
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
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
]]

-- Disable technic:music_player
minetest.clear_craft({
    output = "technic:music_player",
})
do
    local groups = minetest.registered_nodes["technic:music_player"].groups
    groups.not_in_creative_inventory = 1
    groups.not_in_craft_guide = 1
    minetest.override_item("technic:music_player",{
        groups = groups,
    })
end