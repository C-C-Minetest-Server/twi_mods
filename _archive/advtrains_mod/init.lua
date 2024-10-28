-- twi_mods/advtrains_mod/init.lua
-- Modify advtrains_interlocking
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

if not core.instrument_function then return end

for _, name in ipairs({
    "train_ensure_init",
    "train_step_b",
    "train_step_c",
}) do
    advtrains[name] = core.instrument_function({
        func = advtrains[name],
        class = "Trainlogic",
        label = name
    })
end
