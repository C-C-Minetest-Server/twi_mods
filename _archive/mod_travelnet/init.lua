-- twi_mods/mod_travelnet/init.lua
-- Modify travelnet
--[[
    Copyright (C) 2024  1F616EMO

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

-- Hide elevators - Use realistic elevator instead plz
core.clear_craft({
    output = "travelnet:elevator"
})
local elevator_groups = table.copy(core.registered_nodes["travelnet:elevator"].groups)
elevator_groups.not_in_craft_guide = 1
core.override_item("travelnet:elevator", {
    groups = elevator_groups
})
