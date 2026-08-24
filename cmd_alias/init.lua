-- twi_mods/cmd_alias/init.lua
-- Register command alias
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

local S = core.get_translator("cmd_alias")

local cmd_alias = {
    ca        = "centralauth",
    d         = "day",
    doc       = "helpform",
    snp       = "snippets",
    tp        = "teleport",
    lua       = "/lua",
    t         = "tutorial",
    p1        = "area_pos1",
    p2        = "area_pos2",
    pt        = "protect",
    ["?"]     = "tutorial",
    gh        = "grapehills",

    h         = "home",
    sh        = "sethome",


    reports   = "report",
    feedback  = "report",
    feedbacks = "report",
}

for from, to in pairs(cmd_alias) do
    if core.registered_chatcommands[to] then
        local def = table.copy(core.registered_chatcommands[to])
        def.description = S("Alias of /@1: @2", to, def.description or "")

        core.register_chatcommand(from, def)
    end
end

-- Custom alias: /area_pos {get,set,set1,set2}

if core.registered_chatcommands.area_pos then
    local cdef = core.registered_chatcommands.area_pos
    for alias, part in pairs({
        g      = "get",
        s      = "set",
        ["s1"] = "set1",
        ["s2"] = "set2",
    }) do
        core.register_chatcommand("p" .. alias, {
            description = S("Alias of /@1: @2", "area_pos " .. part, cdef.description or ""),
            privs = table.copy(cdef.privs),
            func = function(name, params)
                if params ~= "" then
                    params = " " .. params
                end
                params = part .. params

                return cdef.func(name, params)
            end,
        })
    end
end
