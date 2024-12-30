-- twi_mods/babelfish_redo_mods/init.lua
-- Additional roles indicators
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

-- Allow helpers to get and set other's preferred language

core.registered_chatcommands["bbset"].privs = { role_helper = true }
