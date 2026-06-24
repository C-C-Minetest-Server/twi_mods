-- twi_mods/custom_fachwerk/init.lua
-- More fachwerk nodes
-- Copyright (c) 2026 1F616EMO
-- SPDX-License-Identifier: CC0-1.0

local nodes = {
    -- The bricks
    "default:desert_sandstone_brick",
    "default:desert_stonebrick",
    "default:obsidianbrick",
    "default:sandstonebrick",
    "default:silver_sandstone_brick",
    "moreblocks:cactus_brick",
    "moreblocks:coal_stone_bricks",
    "moreblocks:grey_bricks",
    "moreblocks:iron_stone_bricks",
    "technic:granite_bricks",
    "technic:marble_bricks",

    -- Compressed blocks
    "moreblocks:cobble_compressed",
    "moreblocks:desert_cobble_compressed",
    "moreblocks:dirt_compressed",

    -- Other solid blocks
    "default:mossycobble",
    "minetest_errata:mossy_stone_tile",
    "minetest_errata:mossystone",
    "moreblocks:tar",
}

local function get_block_texture(def)
    local tiles = def.tiles
    local first_tile = tiles and tiles[1]

    if type(first_tile) == "table" then
        return first_tile.name or first_tile.image
    end

    return first_tile
end

for _, node in ipairs(nodes) do
    local def = core.registered_nodes[node]
    local texture = def and get_block_texture(def)

    if texture then
        local basename = string.gsub(node, ":", "_")
        local description = def.short_description or def.description

        fachwerk.register_fachwerk(basename, texture, description, node)
    end
end