-- twi_mods/smartshop_mod/init.lua
-- Modify smartshop
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

-- Do not use unlimited inventory unless in creative mode
local old_initialize_metadata = smartshop.shop_class.initialize_metadata
function smartshop.shop_class:initialize_metadata(player)
    old_initialize_metadata(self, player)

	local player_name
	if type(player) == "string" then
		player_name = player
	else
		player_name = player:get_player_name()
	end

    if not minetest.is_creative_enabled(player_name) then
        self:set_unlimited(false)
    end
end
