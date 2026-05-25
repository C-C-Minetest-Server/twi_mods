-- twi_mods/elevator_mod/init.lua
-- Modify elevator
--[[
    ISC License

    Copyright (c) 2017 Beha

    Permission to use, copy, modify, and/or distribute this software for any
    purpose with or without fee is hereby granted, provided that the above
    copyright notice and this permission notice appear in all copies.

    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
    REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
    AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
    INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
    LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
    OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
    PERFORMANCE OF THIS SOFTWARE.
]]

-- 1. Override tiles to use Technic's iron texture
for _, name in ipairs({
    "elevator:motor",
    "elevator:elevator_box",
    "elevator:elevator_on"
}) do
    local tiles = table.copy(core.registered_nodes[name].tiles or {})
    for i, texture in ipairs(tiles) do
        if texture == "default_steel_block.png" then
            tiles[i] = "technic_wrought_iron_block.png"
        end
    end
    core.override_item(name, {
        tiles = tiles,
    })
end

-- 2. Restore farming redo-based recipes

core.register_craft({
    output = "elevator:elevator_off",
    recipe = {
        { "technic:cast_iron_ingot",       "farming:hemp_rope",    "technic:cast_iron_ingot" },
        { "technic:cast_iron_ingot",       "default:mese_crystal", "technic:cast_iron_ingot" },
        { "technic:stainless_steel_ingot", "default:glass",        "technic:stainless_steel_ingot" },
    },
})

core.register_craft({
    output = "elevator:shaft",
    recipe = {
        { "technic:cast_iron_ingot", "default:glass" },
        { "default:glass",           "farming:hemp_rope" },
    },
})

core.register_craft({
    output = "elevator:motor",
    recipe = {
        { "default:diamond",    "technic:control_logic_unit", "default:diamond" },
        { "default:steelblock", "technic:motor",              "default:steelblock" },
        { "farming:hemp_rope",  "default:diamond",            "farming:hemp_rope" }
    },
})

-- 3. Open elevator interface on walk in
local ELEVATOR_ITEMS = {
    ["elevator:elevator_off"] = true,
    ["elevator:shaft"] = true,
    ["elevator:motor"] = true,
}

local player_last_pos = {}
local counter = 0
core.register_globalstep(function(dtime)
    counter = counter + dtime
    if counter < 0.4 then return end
    counter = 0

    for _, player in ipairs(core.get_connected_players()) do
        local name = player:get_player_name()
        local pos = player:get_pos()

        if elevator.riding[name] then
            -- Prevent triggering on arrival by setting the last position to the target
            player_last_pos[name] = elevator.riding[name].target
        else
            local rounded_pos = vector.round(pos)
            local node = core.get_node(rounded_pos)
            if
                node.name == "elevator:elevator_on"
                and player_last_pos[name]
                and not vector.equals(player_last_pos[name], rounded_pos)
            then
                -- HACK: If the player is holding elevator items, temporary clear it
                local wielded_item = player:get_wielded_item()
                if ELEVATOR_ITEMS[wielded_item:get_name()] then
                    player:set_wielded_item(ItemStack())
                else
                    wielded_item = nil
                end

                core.registered_items["elevator:elevator_on"].on_rightclick(rounded_pos, node, player)

                if wielded_item then
                    player:set_wielded_item(wielded_item)
                end
            end

            player_last_pos[name] = rounded_pos
        end
    end
end)

core.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    player_last_pos[name] = nil
end)
