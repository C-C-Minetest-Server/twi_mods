-- twi_mods/unified_inventory_mod/init.lua
-- Modifiications of unified_inventory
--[[
    Unified Inventory for Minetest
    Copyright (C) 2012-2014 Maciej Kasatkin (RealBadAngel)
    Copyright (C) 2024 1F616EMO

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
]]

-- Unregister some buttons
for _, name in ipairs({
    "misc_set_day",
    "misc_set_night",
    "clear_inv",
}) do
    for i, def in ipairs(unified_inventory.buttons) do
        if def.name == name then
            table.remove(unified_inventory.buttons, i)
            break
        end
    end
end
