-- twi_mods/luaatc_textline_mod/init.lua
-- luaatc_textline_mod modifications
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

local S = core.get_translator('luaatc_textline_mod')

-- facedir
for _, name in ipairs({
    'luaatc_textline:wall_textline_green',
    'luaatc_textline:wall_textline_orange',
    'luaatc_textline:hanging_textline_green',
    'luaatc_textline:hanging_textline_orange'
}) do
    core.override_item(name, {
        paramtype2 = "facedir",
    })
end

-- Restore old nodes, we don't want automatic migration
local has_font_lcd = luaatc_textline.use_font_api
	and font_api.registered_fonts.lcd
local lcd_box = {
    type = 'fixed',
    fixed = {-8/16, -8/16, 7/16, 8/16, 8/16, 8/16}
}

luaatc_textline.register_textline(':luaatc_textline:textline', {
	drawtype = 'nodebox',
	description = S('LuaATC Textline'),
	inventory_image = 'luaatc_textline_icon.png',
	wield_image = 'luaatc_textline_icon.png',
	tiles = {'luaatc_textline_any.png'},
	paramtype = 'light',
	sunlight_propagates = true,
	light_source = 0,
	paramtype2 = 'facedir', -- '4dir',
	node_box = lcd_box,
	selection_box = lcd_box,
	groups = {choppy = 3, dig_immediate = 2, not_blocking_trains = 1,
	          save_in_at_nodedb = 1},

	luaatc_textline = {
		lcd_info = {
			[0] = {delta = {x = 0, y = 0, z = 0.43},
			       rotation = {x = 0, y = 0, z = 0}},
			[1] = {delta = {x = 0.43, y = 0, z = 0},
			       rotation = {x = 0, y = -math.pi / 2, z = 0}},
			[2] = {delta = {x = 0, y = 0, z = -0.43},
			       rotation = {x = 0, y = math.pi, z = 0}},
			[3] = {delta = {x = -0.43, y = 0, z = 0},
			       rotation = {x = 0, y = math.pi / 2, z = 0}},
		},
--		properties = {visual = 'sprite'},
		visual_size = {x = 3, y = 1, z = 1},
		font = 'lcd',
		width = has_font_lcd and 162 or 243,
		height = has_font_lcd and 44 or 66,
		color = '#00C040',
		glow = 10,
	},
})

core.register_node(':luaatc_textline:background', {
	description = S('LuaATC Textline background'),
	inventory_image = 'luaatc_textline_background.png',
	wield_image = 'luaatc_textline_background.png',
	tiles = {'luaatc_textline_any.png'},
	drawtype = 'nodebox',
	node_box = lcd_box,
	selection_box = lcd_box,
	groups = {choppy = 3, dig_immediate = 2, not_blocking_trains = 1},
	paramtype = 'light',
	sunlight_propagates = true,
	light_source = 0,
	paramtype2 = 'facedir', -- '4dir',
})

-- Hide sprites for players who canot see them, reusing function from digisprite

do
	local txt_def = core.registered_entities['luaatc_textline:text']
	local sp_def = core.registered_entities['digisprite:image']

	local old_step = txt_def.on_step

	local function new_step(self, dtime)
		sp_def.on_step(self, dtime)
		return old_step(self, dtime)
	end

	txt_def.on_step = new_step
end
