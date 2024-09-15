-- twi_mods/username_restrictions/init.lua
-- Ban some usernames
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

local banned_parts = {}

for _, part in ipairs({"admin", "moderator"}) do
    banned_parts[part] = antispoof.normalize(part)
end

local auth
minetest.register_on_prejoinplayer(function(name)
    if name == "singleplayer" or name == minetest.settings:get("name") then return end
    auth = auth or minetest.get_auth_handler()
    if not auth.get_auth(name) then
        if string.find(name, "L+O+L+") then
            -- As unclear as possible yet give some useful message
            return "This username is banned."
        end

        local normalized_name = antispoof.normalize(name)
        for orig_part, norm_part in pairs(banned_parts) do
            if string.find(normalized_name, norm_part) then
                return string.format(
                    "Invalid username %s: Username cannt conain \"%s\"",
                    name, orig_part
                )
            end
        end
    end
end)