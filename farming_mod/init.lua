-- twi_mods/farming_mod/init.lua
-- Handle framing redo changes
--[[
    The MIT License (MIT)

    Copyright (c) 2016  TenPlus1
    Copyright (c) 2024  1F616EMO

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

if farming.mod ~= "redo" then
    error("[twi_mods/farming_mod] Only works with Farming Redo")
end

-- Tomato red dye
core.register_craft({
    output = farming.recipe_items.dye_red,
    recipe = { { "group:food_tomato" } }
})

-- Allow planting pineapple
core.override_item("farming:pineapple", {
    on_place = function(itemstack, placer, pointed_thing)
        local under_pos = core.get_pointed_thing_position(pointed_thing)
        if not under_pos then
            return core.item_place(itemstack, placer, pointed_thing)
        end
        local under_name = core.get_node(under_pos).name
        if under_name == "farming:pineapple_1"
            or under_name == "farming:pineapple_2"
            or under_name == "farming:pineapple_3"
            or under_name == "farming:pineapple_4"
            or under_name == "farming:pineapple_5"
            or under_name == "farming:pineapple_6"
            or under_name == "farming:pineapple_7"
            or under_name == "farming:pineapple_8" then
            return itemstack
        elseif core.get_item_group(under_name, "soil") < 2 then
            return core.item_place(itemstack, placer, pointed_thing)
        end

        local old_count = itemstack:get_count()
        local itemstack2 = farming.place_seed(itemstack, placer, pointed_thing, "farming:pineapple_1")
        if not itemstack2 then return itemstack end
        local consumed = old_count - itemstack2:get_count()

        if consumed > 0 then
            local ring_stack = ItemStack({ name = "farming:pineapple_ring", count = consumed * 5 })
            if placer:is_player() then
                local inv = placer:get_inventory()
                ring_stack = inv:add_item("main", ring_stack)
            end
            local pos = core.get_pointed_thing_position(pointed_thing, true) or placer:get_pos()
            core.add_item(pos, ring_stack)
        end

        return itemstack2
    end,
})

-- Temporary remove max light limit on rhubarb
farming.registered_plants["farming:rhubarb"].maxlight = nil
for _, stage in ipairs({ 1, 2, 3 }) do
    core.override_item("farming:rhubarb_" .. stage, {
        maxlight = core.LIGHT_MAX,
    })
end

-- Slice melons and pumkins on harvest
core.override_item("farming:pumpkin_8", {
    drop = "farming:pumpkin_slice 4",
})
core.override_item("farming:melon_8", {
    drop = "farming:melon_slice 4",
})
