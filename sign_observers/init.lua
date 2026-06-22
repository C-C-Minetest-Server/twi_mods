-- twi_mods/sign_observers/init.lua
-- Set sign observers by distance
-- Copyright (c) 2026 1F616EMO
-- SPDX-License-Idenfier: LGPL-3.0-or-later

local SHORT_OBSERVER_DISTANCE = 30
local LONG_OBSERVER_DISTANCE = 60
local MAX_OBSERVER_DISTANCE = 100
local MAX_NEW_SIGNS_PER_SECOND = 30

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

local this_step_player_new_signs = {}

do
    local cleanup_dtime = 0

    core.register_globalstep(function(dtime)
        cleanup_dtime = cleanup_dtime + dtime
        if cleanup_dtime < 1 then return end
        cleanup_dtime = 0
        this_step_player_new_signs = {}
    end)
end

local function observer_on_step(self, dtime)
    if self._observer_dtime == nil then
        self._observer_dtime = 0
    else
        self._observer_dtime = self._observer_dtime + dtime
        if self._observer_dtime < 1 then return end
        self._observer_dtime = 0
    end

    local pos = self.object:get_pos()
    local npos = vector.round(pos)
    local node = core.get_node(npos)
    local basic_radius = LARGE_SIGNS[node.name] and LONG_OBSERVER_DISTANCE or SHORT_OBSERVER_DISTANCE

    local existing_observers = self.object:get_observers()
    local observers = {}
    for _, player in ipairs(core.get_connected_players()) do
        local pname = player:get_player_name()
        if
            (existing_observers and existing_observers[pname])
            or not this_step_player_new_signs[pname]
            or this_step_player_new_signs[pname] < MAX_NEW_SIGNS_PER_SECOND
        then
            local ppos = player:get_pos()
            local distance = vector.distance(pos, ppos)

            local shows = true
            if distance > MAX_OBSERVER_DISTANCE then
                shows = false
            elseif distance > basic_radius then
                local rc = core.raycast(ppos, pos, false, false)
                for pt in rc do
                    if pt.type == "node" then
                        local rnpos = pt.under
                        local rnode = core.get_node(rnpos)
                        local rndef = core.registered_nodes[rnode.name]

                        if rndef and not rndef.sunlight_propagates then
                            shows = false
                            break
                        end
                    end
                end
            end

            if shows then
                observers[pname] = true

                if not existing_observers or not existing_observers[pname] then
                    this_step_player_new_signs[pname] = (this_step_player_new_signs[pname] or 0) + 1
                end
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
