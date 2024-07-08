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

-- Spread default:dry_dirt_with_dry_grass to default:dry_dirt
minetest.register_abm({
    label = "Dry Grass Dirt spread",
    nodenames = { "default:dry_dirt" },
    neighbors = {
        "default:dry_dirt_with_dry_grass",
    },
    interval = 6,
    chance = 50,
    catch_up = false,
    action = function(pos, node)
        -- Check for darkness: night, shadow or under a light-blocking node
        -- Returns if ignore above
        local above = { x = pos.x, y = pos.y + 1, z = pos.z }
        if (minetest.get_node_light(above) or 0) < 13 then
            return
        end

        minetest.set_node(pos, { name = "default:dry_dirt_with_dry_grass" })
    end
})

-- Craft two wood into one apple wood
minetest.register_craft({
    type = "shapeless",
    output = "default:wood 2",
    recipe = { "group:wood", "group:wood" }
})
