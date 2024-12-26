-- twi_mods/signs_lib_mod/init.lua
-- Signs Lib Modifications
--[[
    Copyright (C) 2018-2024  VannessaE and contributors
    Copyright (C) 2024  1F616EMO

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

signs_lib.glow_item = "default:torch"

-- If locked, signs can be modified by both area owner (if protected) and the sign owner
local old_can_modify = signs_lib.can_modify
function signs_lib.can_modify(pos, player)
	local meta = core.get_meta(pos)
	local owner = meta:get_string("owner")

    if owner ~= "" then
        -- That means there is a owner

        local playername
        if type(player) == "userdata" then
            playername = player:get_player_name()

        elseif type(player) == "string" then
            playername = player

        else
            playername = ""
        end

        if playername == owner then
		    return true
        end

        if core.is_protected(pos, "") then
            -- The area is protected, let the owner to edit
            if not core.is_protected(pos, playername) then
                return true
            end
        end

        return false
    end

    return old_can_modify(pos, player)
end