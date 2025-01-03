-- twi_mods/digtron_mod/init.lua
-- modification of digtron
--[[
    Copyright (C) 2017 FaceDeer, [technic] support added 2017 by Hans von Smacker

    The MIT License (MIT)

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

for _, name in ipairs({
    "default:dirt_with_grass",
    "default:dirt_with_dry_grass",
    "default:dirt_with_rainforest_litter",
    "default:dirt_with_snow",
    "farming:soil",
    "farming:soil_wet",
}) do
    digtron.builder_read_item_substitutions[name] = nil
end

for name, def in pairs(core.registered_nodes) do
    if def.groups and def.groups.digtron and def.groups.digtron ~= 0 then
        local groups = table.copy(def.groups)
        groups.destroy_falling_node = 1
        core.override_item(name, { groups = groups })
    end
end
