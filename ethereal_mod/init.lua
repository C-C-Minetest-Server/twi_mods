-- twi_mods/ethereal_mod/init.lua
-- Give initial stuffs to new players
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

-- place_param2 = 0
local node_list = {
    "ethereal:basandra_wood",
    "ethereal:sakura_wood",
    "ethereal:willow_wood",
    "ethereal:redwood_wood",
    "ethereal:frost_wood",
    "ethereal:yellow_wood",
    "ethereal:palm_wood",
    "ethereal:banana_wood",
    "ethereal:birch_wood",
    "ethereal:olive_wood",
}
for _, name in ipairs(node_list) do
    minetest.override_item(name, {
        place_param2 = 0
    })
end
