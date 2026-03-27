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

	if not core.is_creative_enabled(player_name) then
		self:set_unlimited(false)
	end
end

-- Handle player names early, as futil is not happy with fake players
-- But that's essensial on using item injectors
-- Not gonna override futil.is_player as god knows where else it is used.
local old_is_owner = smartshop.node_class.is_owner
function smartshop.node_class:is_owner(player)
	local player_name
	if type(player) == "string" then
		player_name = player
	elseif type(player.get_player_name) == "function" then
		local func_player_name = player:get_player_name()
		if type(func_player_name) == "string" then
			player_name = func_player_name
		end
	end

	if type(player_name) ~= "string" then
		return false
	end

	return old_is_owner(self, player_name)
end
