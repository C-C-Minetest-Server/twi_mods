-- twi_mods/default_mod/init.lua
-- modification of default
--[[
    Copyright (C) 2010-2012  celeron55, Perttu Ahola <celeron55@gmail.com>
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

-- Coral group
for _, name in ipairs({
    "default:coral_green",
    "default:coral_pink",
    "default:coral_cyan",
    "default:coral_brown",
    "default:coral_orange",
    -- "default:coral_skeleton",
}) do
    local groups = table.copy(minetest.registered_nodes[name].groups or {})
    groups.coral = 1
    minetest.override_item(name, {
        groups = groups
    })
end