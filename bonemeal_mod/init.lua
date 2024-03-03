-- twi_mods/bonemeal_mod/init.lua
-- Modify bonemeal mod
--[[
    The MIT License (MIT)

    Copyright (c) 2016 TenPlus1
    Copyright (c) 2024 1F616EMO

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

-- 1. Remove shaped recipies and replace them with shapeless one

--- 1a. Mulch from one tree and 8 leaves
minetest.clear_craft({
    recipe = {
        { "group:tree",   "group:leaves", "group:leaves" },
        { "group:leaves", "group:leaves", "group:leaves" },
        { "group:leaves", "group:leaves", "group:leaves" }
    }
})
minetest.register_craft({
    type = "shapeless",
    output = "bonemeal:mulch 4",
    recipe = {
        "group:tree", "group:leaves", "group:leaves",
        "group:leaves", "group:leaves", "group:leaves",
        "group:leaves", "group:leaves", "group:leaves"
    }
})

--- 1b. Fertiliser from both type of bonemeal
minetest.clear_craft({
    recipe = { { "bonemeal:bonemeal", "bonemeal:mulch" } }
})
minetest.register_craft({
    type = "shapeless",
    output = "bonemeal:fertiliser 2",
    recipe = { "bonemeal:bonemeal", "bonemeal:mulch" },
})

-- 2. Add craft recipe for bonemeal
minetest.register_craft({
    type = "shapeless",
    output = "bonemeal:bonemeal 2",
    recipe = { "group:bone" }
})
