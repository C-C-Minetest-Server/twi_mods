-- twi_mods/luaatc_textline_mod/init.lua
-- luaatc_textline_mod modifications
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

-- facedir
for _, name in ipairs({
    'luaatc_textline:textline',
    'luaatc_textline:background',
    'luaatc_textline:hanging_textline_green',
    'luaatc_textline:hanging_textline_orange'
}) do
    core.override_item(name, {
        paramtype2 = "facedir",
    })
end