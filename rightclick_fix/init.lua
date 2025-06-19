-- twi_mods/rightclick_fix/init.lua
-- Fix node interaction on on_place tols
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

local fix_tools = {
    -- Screwdrivers
    "screwdriver:screwdriver",
    "technic:sonic_screwdriver",

    -- Advtrains tools
    "advtrains:trackworker",
    "advtrains:copytool",
    "advtrains_interlocking:tool",
    "advtrains_luaautomation:pcnaming",

    -- Advtrains track placers
    "advtrains:dtrack_atc_placer",
    "advtrains:dtrack_bumper_placer",
    "advtrains:dtrack_detector_off_placer",
    "advtrains:dtrack_load_placer",
    "advtrains:dtrack_placer",
    "advtrains:dtrack_s3_placer",
    "advtrains:dtrack_slopeplacer",
    "advtrains:dtrack_sy_placer",
    "advtrains:dtrack_unload_placer",
    "advtrains:dtrack_xing90plusx_placer",
    "advtrains:dtrack_xing_placer",
    "advtrains:dtrack_xingdiag_placer",
    "advtrains_interlocking:dtrack_npr_placer",
    "advtrains_line_automation:dtrack_stop_placer",
    "advtrains_luaautomation:dtrack_placer",
}

local function is_function_node(pos)
    -- 1. Formspec meta check
    local meta = core.get_meta(pos)
    if meta:get("formspec") ~= nil then
        return true
    end

    -- 2. Check on_rightclick
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return ndef and ndef.on_rightclick and true or false
end

local function on_place(itemstack, placer, pointed_thing, old_on_place)
    local pos = pointed_thing.under

    if is_function_node(pos) then
        local control = placer:get_player_control()
        if control.sneak then
            -- Do node function instead
            local node = core.get_node(pos)
            local ndef = core.registered_nodes[node.name]
            if not ndef.on_rightclick then
                return ndef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
            end
            return itemstack
        end
    end

    return old_on_place(itemstack, placer, pointed_thing)
end

-- on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

for _, name in ipairs(fix_tools) do
    local def = core.registered_items[name]
    local old_on_place = def.on_place
    if old_on_place then
        core.override_item(name, {
            on_place = function(itemstack, placer, pointed_thing)
                return on_place(itemstack, placer, pointed_thing, old_on_place)
            end,
        })
    end
end
