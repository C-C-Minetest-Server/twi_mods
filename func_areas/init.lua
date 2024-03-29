-- twi_mods/func_areas/init.lua
-- 1F616EMO_func owned areas
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

func_areas = {}
local func_account = "1F616EMO_func"

function func_areas.is_in_func_area(pos, id)
    local area = areas.areas[id]
    if not area then return false end
    if area.owner ~= func_account then return end
    return pos.x >= area.pos1.x
       and pos.y >= area.pos1.y
       and pos.z >= area.pos1.z
       and pos.x <= area.pos2.x
       and pos.y <= area.pos2.y
       and pos.z <= area.pos2.z
end

minetest.register_on_prejoinplayer(function(name)
    if name == func_account then
        return "This username is reserved."
    end
end)
