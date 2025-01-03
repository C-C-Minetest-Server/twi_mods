-- twi_mods/twi_cmds/init.lua
-- commands
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("twi_cmds")

core.register_chatcommand("day", {
    privs = { basic_settime = true },
    description = S("Set time to day"),
    func = function(name)
        local current_time = core.get_timeofday()
        local new_time = 0.3125
        if math.abs(current_time - new_time) < 0.042 then
            return false, S("Be patient!")
        end
        core.set_timeofday(new_time)
        core.log("action", name .. " set time to day")
        for _, player in ipairs(core.get_connected_players()) do
            local name = player:get_player_name()
            background_music.set_start_play_gap(name, 2)
            background_music.decide_and_play(player, true)
        end
        core.sound_play("ui_morning", { gain = 1.0 })
        return true, S("Successfully set time to day.")
    end,
})

core.register_privilege("basic_settime", {
    description = S("Can set time to day using /day"),
    give_to_singleplayer = true,
})

core.register_on_newplayer(function(player)
    -- Assume new players have privs properly set
    local meta = player:get_meta()
    meta:set_int("twi_cmds_basic_settime", 1)
end)

core.register_on_joinplayer(function(player)
    local meta = player:get_meta()
    if meta:get_int("twi_cmds_basic_settime") == 1 then
        return
    end

    local name = player:get_player_name()
    local privs = core.get_player_privs(name)
    if not privs.basic_settime then
        privs.basic_settime = true
        core.set_player_privs(name, privs)
    end
    meta:set_int("twi_cmds_basic_settime", 1)
end)
