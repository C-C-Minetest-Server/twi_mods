-- twi_mods/advtrains_train_jre231_mod/init.lua
-- Modify advtrains_train_jre231
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

for _, name in ipairs({
    "KuHa_E231",
    "MoHa_E231",
    "SaHa_E231",
    "MoHa_E230",
}) do
    core.registered_entities["advtrains:" .. name].max_speed = twi_fx.ADVTRAINS_MAX_TRAIN_SPEED
    advtrains.wagon_prototypes["advtrains:" .. name].max_speed = twi_fx.ADVTRAINS_MAX_TRAIN_SPEED
end
