-- twi_mods/merge_slopes/init.lua
-- Merge Technic CNC slopes and moreblocks slopes
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: Zlib AND LGPL-2.0-or-later

-- circular_saw.known_nodes[recipeitem] = {modname, subname}
-- ":"..recipeitem.."_"..suffix

local function handle_single(name)
    local saw_known_nodes = circular_saw.known_nodes[name]
    if not saw_known_nodes then return end

    local cnc_node_name = name .. "_technic_cnc_slope"
    local saw_node_name = saw_known_nodes[1] .. ":slope_" .. saw_known_nodes[2]

    local cnc_node = core.registered_nodes[cnc_node_name]
    local saw_node = core.registered_nodes[saw_node_name]

    if not (cnc_node and saw_node) then return end
    core.log("action", "[merge_slopes] Merging " .. cnc_node_name .. " into " .. saw_node_name)
    core.register_alias_force(cnc_node_name, saw_node_name)
end

core.register_on_mods_loaded(function()
    for name in pairs(core.registered_nodes) do
        handle_single(name)
    end
end)
