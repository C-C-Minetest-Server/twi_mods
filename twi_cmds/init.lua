-- twi_mods/twi_cmds/init.lua
-- commands
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("twi_cmds")

core.register_chatcommand("day", {
    privs = { ban = true },
    description = S("Set time to day"),
    func = function()
        core.set_timeofday(0.3125)
        for _, player in ipairs(core.get_connected_players()) do
            local name = player:get_player_name()
            background_music.set_start_play_gap(name, 2)
            background_music.decide_and_play(player, true)
        end
        core.sound_play("ui_morning", { gain = 1.0 })
        return true, S("Successfully set time to day.")
    end,
})
