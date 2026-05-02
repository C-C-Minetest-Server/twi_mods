-- twi_mods/ethereal_mod/mapgen.lua
-- Ethereal modifications: mapgen environment
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

local CONTENT_QUICKSAND = core.get_content_id("ethereal:quicksand2")
local CONTENT_SAND = core.get_content_id("default:sand")

local buf = {}

core.register_on_generated(function(vmanip, minp, maxp)
    -- Replace all quicksand2 beneath sand with regular sand
    -- Search from top to down to replace stacked layers of quicksand2 under sand

    vmanip:get_data(buf)
    local area = VoxelArea(minp, maxp)

    for y = maxp.y, minp.y, -1 do
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                local pos = area:index(x, y, z)
                local content_id = buf[pos]
                if content_id == CONTENT_SAND then
                    local below_pos = area:index(x, y - 1, z)
                    local below_content_id = buf[below_pos]
                    if below_content_id == CONTENT_QUICKSAND then
                        buf[below_pos] = CONTENT_SAND
                    end
                end
            end
        end
    end

    vmanip:set_data(buf)
    vmanip:calc_lighting()
end)