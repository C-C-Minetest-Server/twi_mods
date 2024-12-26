-- twi_mods/twi_tips/init.lua
-- Tips
--[[
    Copyright © 2024 1F616EMO

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
]]

local S = core.get_translator("twi_tips")

-- /sethome on area sale
tips.register_tips("twi_tips:sethome",
    S("Type /sethome into the chatroom while staying in your home to allow teleporting back by typing /home."))
um_area_forsale.register_on_area_tx(function(original_owner, new_owner, price, pos, list_areas, description)
    tips.unlock_tips(new_owner, "twi_tips:sethome")
end)

-- Public farm replant [13]
tips.register_tips("twi_tips:public_farm",
    S("Welcome to the Public Farm! After harvesting, don't forget to plant some seeds back for the sake of other players."))

-- Public Tree Farm [20]
tips.register_tips("twi_tips:public_tree_farm",
    S("Welcome to the Public Tree Farm! Don't forget to place down some saplings after chopping down wood."))

-- SPN Station [224]
tips.register_tips("twi_tips:train",
    S("Right-click on a train to board or leave the train. Do not walk on tracks as running trains are deadly."))

do
    local function loop()
        for _, player in ipairs(core.get_connected_players()) do
            local pos = player:get_pos()
            local name = player:get_player_name()

            -- Public farm replant [13]
            if func_areas.is_in_func_area(pos, 13) then
                tips.unlock_tips(name, "twi_tips:public_farm")
            end

            -- Public Tree Farm [20]
            if func_areas.is_in_func_area(pos, 20) then
                tips.unlock_tips(name, "twi_tips:public_tree_farm")
            end

            -- SPN Station [224]
            if func_areas.is_in_func_area(pos, 224) then
                tips.unlock_tips(name, "twi_tips:train")
            end
        end

        core.after(3, loop)
    end
    core.after(1, loop)
end
