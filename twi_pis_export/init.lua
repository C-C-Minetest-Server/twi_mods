-- twi_mods/twi_pis_export/init.lua
-- Export data from PIS_v3
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

local WP = core.get_worldpath()
local export_file = WP .. "/twi_pis_export.json"

local function retrieve_data_from_pis_v3()
    local env = atlatc.envs.PIS_v3
    if not env then
        return {
            success = false,
            error = "Environment PIS_v3 not found.",
        }
    end

    local code = "if F.export_data then exported_data = F.export_data() end"
    local evtdata = {
        type = "twi_pis_export",
        twi_pis_export = true,
    }

    local succ, localenv = env:execute_code({}, code, evtdata)
    if not succ
        or not localenv.exported_data
        or type(localenv.exported_data) ~= "table" then
        return {
            success = false,
            error = "Execution of export_data failed.",
        }
    end

    localenv.exported_data.success = true
    return localenv.exported_data
end

modlib.minetest.register_globalstep(5, function()
    local data = retrieve_data_from_pis_v3()
    local data_json = core.write_json(data)
    core.safe_file_write(export_file, data_json)
end)
