-- twi_mods/twi_cmds/init.lua
-- commands
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("twi_cmds")

local cooldowns_expire = {}

tips.register_tips("twi_cmds:basic_settime",
    S("Use @1 to set time to day, and use @2 to set time to night.", "/day", "/night"))

local chat_send_all = core.global_exists("beerchat") and beerchat.chat_send_all or core.chat_send_all

function do_settime_cmd(name, time_desc, time_value, time_sound)
    local now = os.time()
    if cooldowns_expire[name] and now < cooldowns_expire[name] then
        return false, S("Be patient! Try this command again in @1 seconds.", cooldowns_expire[name] - now)
    end

    local current_time = core.get_timeofday()
    if math.abs(current_time - time_value) < 0.042 then
        return false, S("Be patient!")
    end

    cooldowns_expire[name] = now + 60

    core.set_timeofday(time_value)
    core.sound_play(time_sound, { gain = 1.0 })

    core.log("action", name .. " set time to " .. time_desc)
    chat_send_all("*** " .. S("@1 set time to @2.", name, time_desc))

    for _, player in ipairs(core.get_connected_players()) do
        local pname = player:get_player_name()

        background_music.set_start_play_gap(pname, 2)
        background_music.decide_and_play(player, true)

        tips.unlock_tips(pname, "twi_cmds:basic_settime")
    end

    return true
end

core.register_chatcommand("day", {
    privs = { basic_settime = true },
    description = S("Set time to day"),
    func = function(name)
        return do_settime_cmd(name, "day", 0.3125, "ui_morning")
    end,
})

core.register_chatcommand("night", {
    privs = { basic_settime = true },
    description = S("Set time to night"),
    func = function(name)
        return do_settime_cmd(name, "night", 0.8958, "ui_owl")
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

modlib.minetest.register_globalstep(60, function()
    local now = os.time()
    for name, expire in pairs(cooldowns_expire) do
        if now >= expire or not core.get_player_by_name(name) then
            cooldowns_expire[name] = nil
        end
    end
end)
