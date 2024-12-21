-- twi_mods/rubber_cherrypick/init.lua
-- Cherry-pick rubber tree from moretrees
-- Copyright (C) 2013  Vanessa Ezekowitz <vanessaezekowitz@gmail.com>
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

-- Textures:
-- Copyright (C) 2013  Vanessa Ezekowitz <vanessaezekowitz@gmail.com>
-- CC BY-SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0/deed.en>

local S = minetest.get_translator("rubber_cherrypick")

minetest.override_item("moretrees:rubber_tree_trunk", {
    description = S("Rubber Tree Trunk"),
    tiles = {
        "moretrees_rubber_tree_trunk_top.png",
        "moretrees_rubber_tree_trunk_top.png",
        "technic_rubber_tree_full.png"
    },
    paramtype2 = "facedir",
    is_ground_content = false,
    on_place = minetest.rotate_node,
})

twi_fx.override_group("moretrees:rubber_tree_trunk", {
    rubber_tree = 1,
})

minetest.override_item("moretrees:rubber_tree_trunk_empty", {
    description = S("Rubber Tree Trunk (Empty)"),
    tiles = {
        "moretrees_rubber_tree_trunk_top.png",
        "moretrees_rubber_tree_trunk_top.png",
        "technic_rubber_tree_empty.png"
    },
    paramtype2 = "facedir",
    is_ground_content = false,
    on_place = minetest.rotate_node,
})

twi_fx.override_group("moretrees:rubber_tree_trunk_empty", {
    rubber_tree = 1,
})

minetest.override_item("moretrees:rubber_tree_leaves", {
    description = S("Rubber Tree Leaves"),
    drop = {
        max_items = 1,
        items = {
            { items = { "moretrees:rubber_tree_sapling" }, rarity = 100 },
            { items = { "moretrees:rubber_tree_leaves" } }
        }
    },
})

minetest.override_item("moretrees:rubber_tree_sapling", {
    description = S("Rubber Tree Sapling"),
    on_place = function(itemstack, placer, pointed_thing)
        return default.sapling_on_place(itemstack, placer, pointed_thing,
            "moretrees:rubber_tree_sapling",
            -- minp, maxp to be checked, relative to sapling pos
            -- minp_relative.y = 1 because sapling pos has been checked
            { x = -3, y = 1, z = -3 },
            { x = 3, y = 6, z = 3 },
            -- maximum interval of interior volume check
            4)
    end,
    selection_box = {
        type = "fixed",
        fixed = { -4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16 }
    },
})

minetest.register_node(":moretrees:rubber_tree_planks", {
    description = S("Rubber Tree Planks"),
    tiles = { "moretrees_rubber_tree_wood.png" },
    is_ground_content = false,
    groups = { snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1 },
    sounds = xcompat.sounds.node_sound_wood_defaults(),
})

minetest.register_craft({
    type = "shapeless",
    output = "moretrees:rubber_tree_planks 4",
    recipe = { "moretrees:rubber_tree_trunk" }
})

local planks_name = "moretrees:rubber_tree_planks"
local planks_tile = "moretrees_rubber_tree_wood.png"
default.register_fence(":moretrees:rubber_tree_fence", {
    description = S("Rubber Tree Fence"),
    texture = planks_tile,
    inventory_image = "default_fence_overlay.png^" .. planks_tile ..
        "^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^" .. planks_tile ..
        "^default_fence_overlay.png^[makealpha:255,126,126",
    material = planks_name,
    groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
    sounds = xcompat.sounds.node_sound_wood_defaults()
})
default.register_fence_rail(":moretrees:rubber_tree_fence_rail", {
    description = S("Rubber Tree Fence Rail"),
    texture = planks_tile,
    inventory_image = "default_fence_rail_overlay.png^" .. planks_tile ..
        "^default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^" .. planks_tile ..
        "^default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = planks_name,
    groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
    sounds = xcompat.sounds.node_sound_wood_defaults()
})
doors.register_fencegate("moretrees:rubber_tree_gate", {
    description = S("Rubber Tree Fence Gate"),
    texture = planks_tile,
    material = planks_name,
    groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 }
})
minetest.register_alias(":moretrees:rubber_tree_gate_closed", "moretrees:rubber_tree_gate_closed")
minetest.register_alias(":moretrees:rubber_tree_gate_open", "moretrees:rubber_tree_gate_open")

stairsplus:register_all(
    "moretrees",
    "rubber_tree_trunk",
    "moretrees:rubber_tree_trunk",
    {
        groups = { snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
        tiles = {
            "moretrees_rubber_tree_trunk_top.png",
            "moretrees_rubber_tree_trunk_top.png",
            "technic_rubber_tree_full.png"
        },
        description = S("Rubber Tree Trunk"),
        drop = "rubber_tree_trunk",
    }
)

stairsplus:register_all(
    "moretrees",
    "rubber_tree_planks",
    "moretrees:rubber_tree_planks",
    {
        groups = { snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3 },
        tiles = { "moretrees_rubber_tree_wood.png" },
        description = S("Rubber Tree Planks"),
        drop = "rubber_tree_planks",
    }
)

minetest.register_node(":moretrees_all_faces:all_faces_rubber_tree_trunk", {
    description = S("All-faces Rubber Tree Trunk"),
    tiles = { "moretrees_rubber_tree_trunk_top.png" },
    groups = { tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 1 },
    sounds = xcompat.sounds.node_sound_wood_defaults(),
})

minetest.register_craft({
    output = "moretrees_all_faces:all_faces_rubber_tree_trunk 8",
    recipe = {
        { "group:rubber_tree", "group:rubber_tree", "group:rubber_tree" },
        { "group:rubber_tree", "",                  "group:rubber_tree" },
        { "group:rubber_tree", "group:rubber_tree", "group:rubber_tree" }
    }
})

stairsplus:register_all(
    "moretrees_all_faces",
    "all_faces_rubber_tree_trunk",
    "moretrees_all_faces:all_faces_rubber_tree_trunk",
    {
        description = S("All-faces Rubber Tree Trunk"),
        tiles = { "moretrees_rubber_tree_trunk_top.png" },
        groups = { tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 1 },
        sounds = xcompat.sounds.node_sound_wood_defaults(),
    })

choppy.api.register_tree("moretrees:rubber", {
    shape = { type = "box", box = vector.new(17, 13, 17) },
    nodes = {
        ["moretrees:rubber_tree_trunk"] = "trunk",
        ["moretrees:rubber_tree_trunk_empty"] = "trunk",
        ["moretrees:rubber_tree_leaves"] = "leaves",
    },
})

if minetest.get_modpath("logspikes") then
    logspikes.register_log_spike("logspikes:moretrees_rubber_spike", "moretrees:rubber_tree_trunk")
end

if minetest.get_modpath("banisters") then
    banisters.register("banisters", "rubber_tree", "moretrees:rubber_tree_planks")
end
