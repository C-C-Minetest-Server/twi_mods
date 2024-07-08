-- twi_mods/teacher_tutorial_protection_violation/init.lua
-- Tutorial on protection violation
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = minetest.get_translator("teacher_tutorial_protection_violation")

teacher.register_turorial("teacher_tutorial_protection_violation:on_violation", {
    title = S("Position is protected..."),
    show_on_unlock = true,
    show_disallow_close = true,
    {
        texture = "teacher_tutorial_protection_violation_1.png",
        text =
            S("You can't dig or build here in a protected area. " ..
                "Area protections keep unauthorized players from modifying blocks within the area.")
    },
    {
        texture = "teacher_tutorial_protection_violation_2.png",
        text =
            S("Follow the \"Are you new?\" signs from the spawn point to go to a place where you can build. " ..
                "Type /spawn to go back to the spawn point.")
    },
    {
        texture = "teacher_tutorial_protection_violation_3.png",
        text =
            S("To check whether you can build or place, check the bottom-left corner. " ..
                "If the bracket of all lines say a player name that is not you, " ..
                "where you are is protected.") .. "\n\n" ..
            S("However, if you see \"@1\" after the player's name, you can build or place blocks here, " ..
                "but you can't claim the area as yours. This usually happens in public farms and public tree farms.",
                minetest.translate("areas", ":open"))
    },
})

minetest.register_on_protection_violation(function(_, name)
    local player = minetest.get_player_by_name(name)
    if player then
        teacher.unlock_entry_for_player(player, "teacher_tutorial_protection_violation:on_violation")
    end
end)
