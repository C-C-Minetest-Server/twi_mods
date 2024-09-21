-- twi_mods/twi_shops/init.lua
-- Shop dialogs
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

local S = minetest.get_translator("twi_shops")

local function check_atlatc(name)
    if minetest.check_player_privs(name, { atlatc = true }) then
        return 99
    end
    return 0
end

shop_dialog.register_dialog("twi_shops:advtrains", {
    title = S("Advanced Trains Admin Shop"),

    entries = {
        {
            item = ItemStack("advtrains_luaautomation:dtrack_placer"),
            description = S("For LuaATC operators only. Advtrains track that runs LuaATC code."),
            cost = 5,
            max_amount = check_atlatc,
        },
        {
            item = ItemStack("advtrains_luaautomation:mesecon_controller0000"),
            description = S("For LuaATC operators only. Luacontroller that runs LuaATC code."),
            cost = 5,
            max_amount = check_atlatc,
        },
        {
            item = ItemStack("advtrains_luaautomation:oppanel"),
            description = S("For LuaATC operators only. Punch-operatable panel that runs LuaATC code."),
            cost = 5,
            max_amount = check_atlatc,
        },
        {
            item = ItemStack("advtrains_luaautomation:pcnaming"),
            description = S("For LuaATC operators only. Name passive components."),
            cost = 10,
            max_amount = check_atlatc,
        },
    }
})