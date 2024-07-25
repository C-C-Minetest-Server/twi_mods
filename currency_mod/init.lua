-- twi_mods/chatroom_tutorial/init.lua
-- Tutorial of how to open chat, and hud message
-- Copyright (C) 2014-2024  currency developers
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

-- Remove bundle recipe and refund
minetest.clear_craft({
    output = "currency:minegeld_bundle",
})
minetest.register_craft({
    output = "currency:minegeld 9",
    recipe = { { "currency:minegeld_bundle" } },
})
twi_fx.override_group("currency:minegeld_bundle", {
    not_in_creative_inventory = 1,
    not_in_craft_guide = 1,
})
