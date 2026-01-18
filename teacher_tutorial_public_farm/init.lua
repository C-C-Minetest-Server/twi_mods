-- twi_mods/teacher_tutorial_public_farm/init.lua
-- Tutorial on the Public farm
-- Copyright (C) 2026  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("teacher_tutorial_public_farm")

teacher.register_turorial("teacher_tutorial_public_farm:public_farm", {
    title = S("The Public Farm"),
    show_on_unlock = true,
    show_disallow_close = true,
    {
        texture = "teacher_tutorial_public_farm_1.jpg",
        text = {
            S("To harvest crops, hold the left button of your mouse while pointing at the crop. " ..
                "To plan seeds onto a piece of farmland, right-click the farmland while holding the seeds."),
            S("Always replant the crops in a public farm for players after you to get the yields. " ..
                "This is essential for sustaining the operation of public farms. " ..
                "If you fail to do so, you may be banned from using public farms."),
        },
    },
    {
        texture = "teacher_tutorial_public_farm_2.jpg",
        text = {
            S("Usually, harvested crops drop two items: the yield, and the seed. " ..
                "However, sometimes only the yield is dropped. " ..
                "In that case, that only drop is most probably also the seed. " ..
                "Try right-clicking the farmland while holding that yield."),
            S("If that is not the case, try putting the only yield into the crafting grid. " ..
                "You may get the seed item from the output. Examples include sunflowers, garlics, and pineapples."),
        }
    },
})

local function should_trigger_tutorial(player)
    local pos = player:get_pos()
    return func_areas.is_in_func_area(pos, 2610) -- Groma Public Farm
end

modlib.minetest.register_globalstep(2, function()
    local players = core.get_connected_players()

    for _, player in ipairs(players) do
        if should_trigger_tutorial(player) then
            teacher.unlock_entry_for_player(player, "teacher_tutorial_public_farm:public_farm")
        end
    end
end)
