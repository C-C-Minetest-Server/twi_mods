-- twi_mods/shutdown_notice/init.lua
-- shutdown notice
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

-- 2025年1月22日星期三 12:30:00 GMT+08:00
local target_time = 1737520200
local target_time_desc = "on 2025/01/22 at 12:30 UTC+8"
local last_for = "8 hours, i.e. 2025/01/22 at 19:30 UTC+8"

-- 2025年1月22日星期三 00:00:00 GMT+08:00
local start_show = 1737475200

-- local start_show = 0

local gui = flow.widgets

local function format_second(sec)
    if sec < 0 then return "now" end
    return string.format("in %d hours %d minutes %d seconds",
        math.floor(sec / 3600), math.floor((sec % 3600) / 60), sec % 60)
end

local flow_gui = flow.make_gui(function()
    return gui.Vbox {
        max_w = 15,
        gui.Label {
            w = 15, h = 1.2,
            expand = true, align_h = "centre",
            label = "IMPORTANT NOTICE",
            style = {
                font_size = "*6",
            },
        },
        gui.Box { w = 0.25, h = 0.25, color = "grey" },
        gui.Textarea {
            w = 15, h = 5,
            default =
                "To upgrade server hardware and move the data center, " ..
                "the server will shut down " .. target_time_desc .. ", i.e. " ..
                format_second(target_time - os.time()) .. ". The maintenance will last " ..
                last_for .. ". Sorry for the inconvenience.",
            style = {
                font_size = "*2",
            },
        },
        gui.ButtonExit {
            w = 5, h = 2,
            expand = true, align_h = "centre",
            label = "OK",
            style = {
                font_size = "*2",
            },
        },
    }
end)

core.register_on_joinplayer(function(a_player)
    if os.time() > start_show then
        core.after(0.3, function(name)
            local player = core.get_player_by_name(name)
            if player then
                flow_gui:show(player)
            end
        end, a_player:get_player_name())
    end
end)
