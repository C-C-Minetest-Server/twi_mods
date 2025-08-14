-- twi_mods/twi_welcome/init.lua
-- Welcome messages
-- Copyright (C) 2025  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local http = assert(core.request_http_api(), "HTTP API is not available for twi_welcome")

local MP = core.get_modpath("twi_welcome")

twi_welcome = {}

loadfile(MP .. "/src/news.lua")(http)
loadfile(MP .. "/src/rules.lua")(http)