-- twi_mods/formspec_key_workaround/init.lua
-- Fix ${key} in formspecs
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

local RADIUS = 10
local INTERVAL = 0.5

local F = minetest.formspec_escape

local function replace_formspec(formspec, meta)
    return string.gsub(formspec, "%${(%C+)}", function(key)
        return meta:get_string(key)
    end)
end

local function fix_node(pos)
    local meta = minetest.get_meta(pos)

    local formspec = meta:get_string("formspec")
    if formspec == "" then return end

    local work_formspec

    local old_formspec = meta:get_string("old_formspec")
    if old_formspec == formspec then
        -- Mod did not modify the formspec, work on the original formspec
        work_formspec = meta:get_string("orig_formspec")
    else
        -- Mod modified the formspec, work on the normal fomrpsec
        meta:set_string("orig_formspec", formspec)
        work_formspec = formspec
    end

    local new_formspec = replace_formspec(work_formspec, meta)
    meta:set_string("formspec", new_formspec)
    meta:set_string("old_formspec", new_formspec)
end

local dtime_total = 0
minetest.register_globalstep(function(dtime)
    dtime_total = dtime_total + dtime
    if dtime_total < INTERVAL then
        return
    end
    dtime_total = 0

    local processed = {}
    for _, player in ipairs(minetest.get_connected_players()) do
        local pos = player:get_pos()
        for x = pos.x - RADIUS, pos.x + RADIUS do
            for y = pos.y - RADIUS, pos.y + RADIUS do
                for z = pos.z - RADIUS, pos.z + RADIUS do
                    local work_pos = vector.new(x,y,z)
                    local hash = minetest.hash_node_position(work_pos)
                    if not processed[hash] then
                        processed[hash] = true
                        fix_node(work_pos)
                    end
                end
            end
        end
    end
end)