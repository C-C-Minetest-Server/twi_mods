-- twi_mods/teacher_tutorial_post_buying_plot/init.lua
-- Tutorials shown after buying first plot
--[[
    Copyright (C) 2024  1F616EMO

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local S = minetest.get_translator("teacher_tutorial_post_buying_plot")

teacher.register_turorial("teacher_tutorial_post_buying_plot:post_buy", {
    title = S("After buying a plot..."),
    show_on_unlock = true,

    {
        texture = "teacher_tutorial_post_buying_plot_1.jpg",
        text =
            S("Congratulations! You bought your first plot on the 1F616EMO Survival Server! " ..
                "You can build your dream house here.") .. "\n\n" ..
            S("You should start your construction in 4 days, and make it feel like a building in 30 days.")
    },
    {
        texture = "teacher_tutorial_post_buying_plot_2.jpg",
        text =
            S("To start building, chop down the tree on your plot's land. " ..
                "Craft the tree trunks into wood planks in your inventory.")
    },
    {
        texture = "teacher_tutorial_post_buying_plot_3.jpg",
        text =
            S("If you want more wood, visit the public tree farm next to the Spawnpoint. " ..
                "Don't forget to replant the saplings!") .. "\n\n" ..
            S("For more variants, step on the teleport pad next to the entrance of the public tree farm.")
    },
})

um_area_forsale.register_on_area_tx(function(original_owner, new_owner, price, pos, list_areas, description)
    minetest.after(1, function()
        local player = minetest.get_player_by_name(new_owner)
        if player then
            teacher.unlock_entry_for_player(player, "teacher_tutorial_post_buying_plot:post_buy")
        end
    end)
end)
