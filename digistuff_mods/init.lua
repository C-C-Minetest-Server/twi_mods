-- twi_mods/digistuff_mods/init.lua
-- Modify digistuff
-- Copyright (C) 2026  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local removed_items = {
    -- Should have been removed due to lack of HTTP API, but just in case
    "digistuff:nic",

    -- Functionality already provided by floppy disks
    "digistuff:card",
    "digistuff:card_reader",

    -- Temporary disable player detectors until we decide whether to replace
    -- the default API. Enabling it now may cause compactibility issue later.
    "digistuff:camera",
    "digistuff:detector",
}

for _, name in ipairs(removed_items) do
    core.unregister_item(name)
    core.clear_craft({ output = name })
end

local removed_lbms = {
    -- Cameras
    ["digistuff:camera_update"] = true,
    ["digistuff:detector_update"] = true,
}

for i = #core.registered_lbms, 1, -1 do
    local def = core.registered_lbms[i]
    if removed_lbms[def.name] then
        table.remove(core.registered_lbms, i)
    end
end
