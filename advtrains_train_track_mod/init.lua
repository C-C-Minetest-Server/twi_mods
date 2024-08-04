-- twi_mods/advtrains_train_track_mod/init.lua
-- Modify Advtrains tracks
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

for _, suffix in ipairs({
    "vst1", "vst2",
    "vst31", "vst32", "vst33",
}) do
    minetest.override_item("advtrains:dtrack_" .. suffix, {
        sounds = xcompat.sounds.node_sound_gravel_defaults()
    })
end
