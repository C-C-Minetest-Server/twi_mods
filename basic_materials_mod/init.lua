-- twi_mods/basic_materials_mod/init.lua
-- Basic Materials Modifications
--[[
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

local S = core.get_translator("basic_materials_mod")

-- Eliminate the need of padlocks, use steel ingot instead
core.register_alias_force("basic_materials:padlock", "default:steel_ingot")
core.clear_craft({
    recipe = {
        { "basic_materials:steel_bar" },
        { "default:steel_ingot" },
        { "default:steel_ingot" },
    },
})

core.override_item("basic_materials:oil_extract", {
    inventory_image = "twi_oil_extract.png", -- From pipeworks not homedecor
})

-- Remove the intermediate process of oil -> paraffin -> plastic
core.register_alias_force("basic_materials:paraffin", "basic_materials:plastic_sheet")
core.clear_craft({
    type = "cooking",
    recipe = "basic_materials:paraffin",
})
core.clear_craft({
    type = "cooking",
    output = "basic_materials:paraffin",
})
core.register_craft({
    type = "cooking",
    output = "basic_materials:plastic_sheet",
    recipe = "basic_materials:oil_extract",
    cooktime = 6, -- Double the original
})
core.override_item("basic_materials:oil_extract", {
    _doc_items_longdesc = S("Oil extracted from leaves."),
    _doc_items_usagehelp = S("Crafted from 6 leaves. This can be processed into plastic by smelting.")
})
core.override_item("basic_materials:plastic_sheet", {
    _doc_items_longdesc = S("Plastic for machine crafting."),
    _doc_items_usagehelp = S("Produced by smelting oil extracts. This is useful in crafting high-tech items.")
})

-- Remove the need of wire spool
local wire_ingot_pair = {
    -- default
    ["basic_materials:steel_wire"] = "default:steel_ingot",
    ["basic_materials:copper_wire"] = "default:copper_ingot",
    ["basic_materials:gold_wire"] = "default:gold_ingot",

    -- technic
    ["basic_materials:stainless_steel_wire"] = "technic:stainless_steel_ingot",

    -- moreores
    ["basic_materials:silver_wire"] = "moreores:silver_ingot",
}
core.clear_craft({
    recipe = {
        { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
        { "",                              "basic_materials:plastic_sheet", "" },
        { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
    },
})
for wire, ingot in pairs(wire_ingot_pair) do
    core.register_alias_force(wire, ingot)
    core.clear_craft({
        type = "shapeless",
        recipe = {
            ingot,
            "basic_materials:empty_spool",
            "basic_materials:empty_spool",
        },
    })
end
core.register_alias_force("basic_materials:empty_spool", "")

-- Replace simple Energy Crystal with torch
core.clear_craft({
    recipe = {
        { "default:mese_crystal_fragment", "default:torch",      "default:mese_crystal_fragment" },
        { "default:diamond",               "default:gold_ingot", "default:diamond" }
    },
})
core.register_alias_force("basic_materials:energy_crystal_simple", "default:torch")
