-- twi_mods/moretrains_mod_mod/init.lua
-- Modify moretrains_mod
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

for _, name in ipairs({
    "classic_coaches:corridor_coach_class1",
    "classic_coaches:corridor_coach_class2",
    "classic_coaches:open_coach_class1",
    "classic_coaches:open_coach_class2",
    "classic_coaches:bistro_coach",
}) do
    core.registered_entities[name].max_speed = math.min(twi_fx.ADVTRAINS_MAX_TRAIN_SPEED, 30)
    advtrains.wagon_prototypes[name].max_speed = math.min(twi_fx.ADVTRAINS_MAX_TRAIN_SPEED, 30)
end
