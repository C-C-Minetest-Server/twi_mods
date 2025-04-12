-- twi_mods/twi_fx/init.lua
-- Common functions
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

twi_fx = {}

function twi_fx.register_all_stairsplus(modname, name)
    local nodename = modname .. ":" .. name
    local def = table.copy(core.registered_nodes[nodename])

    def.is_ground_content = false
    def.sunlight_propagates = true

    stairsplus:register_all(modname, name, nodename, def)
end

function twi_fx.override_group(name, new_groups)
    assert(core.registered_items[name], "Item " .. name .. " does not exist")
    local groups = table.copy(core.registered_items[name].groups or {})
    for k, v in pairs(new_groups) do
        groups[k] = v == 0 and nil or v
    end
    core.override_item(name, {
        groups = groups,
    })
end

twi_fx.register_on_chat_message =
    core.global_exists("beerchat")
    and beerchat.register_on_chat_message
    or core.register_on_chat_message

-- Limit that out hardware can bear
twi_fx.ADVTRAINS_MAX_TRAIN_SPEED = 30
