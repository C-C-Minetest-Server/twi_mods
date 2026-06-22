-- twi_mods/sign_observers/init.lua
-- Set sign observers by distance
-- Copyright (c) 2026 1F616EMO
-- SPDX-License-Idenfier: LGPL-3.0-or-later

local SHORT_OBSERVER_DISTANCE = 30
local LONG_OBSERVER_DISTANCE = 60
local MAX_OBSERVER_DISTANCE = 100

-- Set of node names
local LARGE_SIGNS = {
    ["signs_roal:large_street_sign"] = true,
    ["street_signs:sign_highway_small_green"] = true,
    ["street_signs:sign_highway_medium_green"] = true,
    ["street_signs:sign_highway_large_green"] = true,
    ["street_signs:sign_highway_small_blue"] = true,
    ["street_signs:sign_highway_medium_blue"] = true,
    ["street_signs:sign_highway_large_blue"] = true,
    ["street_signs:sign_highway_small_yellow"] = true,
    ["street_signs:sign_highway_medium_yellow"] = true,
    ["street_signs:sign_highway_large_yellow"] = true,
    ["street_signs:sign_highway_small_orange"] = true,
    ["street_signs:sign_highway_medium_orange"] = true,
    ["street_signs:sign_highway_large_orange"] = true,
}

local function observer_on_step(self, dtime)
    self._observer_dtime = (self._observer_dtime or 0) + dtime
    if self._observer_dtime < 1 then return end
    self._observer_dtime = 0

    local pos = self.object:get_pos()
    local npos = vector.round(pos)
    local node = core.get_node(npos)
    local basic_radius = LARGE_SIGNS[node.name] and LONG_OBSERVER_DISTANCE or SHORT_OBSERVER_DISTANCE

    local observers = {}
    for _, player in ipairs(core.get_connected_players()) do
        local pname = player:get_player_name()
        local ppos = player:get_pos()
        local distance = vector.distance(pos, ppos)

        if distance < basic_radius then
            observers[pname] = true
        elseif distance < MAX_OBSERVER_DISTANCE then
            local rc = core.raycast(ppos, pos, false, false)
            local blocks = false
            for pt in rc do
                if pt.type == "node" then
                    local rnpos = pt.under
                    local rnode = core.get_node(rnpos)
                    local rndef = core.registered_nodes[rnode.name]

                    if not rndef.sunlight_propagates then
                        blocks = true
                        break
                    end
                end
            end

            if not blocks then
                observers[pname] = true
            end
        end
    end

    self.object:set_observers(observers)
end

for _, name in ipairs({
    "signs_lib:text",
    "signs:display_text",
}) do
    local def = core.registered_entities[name]

    if def.on_step then
        local old_on_step = def.on_step
        def.on_step = function(self, dtime)
            observer_on_step(self, dtime)
            return old_on_step(self, dtime)
        end
    else
        def.on_step = observer_on_step
    end
end
