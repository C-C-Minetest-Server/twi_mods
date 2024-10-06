-- twi_mods/mailbox_mod/init.lua
-- Modify mailbox
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: GPL-3.0-or-later

local minetest, mailbox, func_areas, areas = minetest, mailbox, func_areas, areas

local S = minetest.get_translator("mailbox_mod")

local MANAGED_AREA = 1017
local AREAS = {
    [0] = { 1018, 1019 }, -- A B C D E
    [1] = { 1020, 1021 }, -- F G H I J
    [2] = { 1022, 1023 }, -- K L M N O
    [3] = { 1024, 1025 }, -- P Q R S T
    [4] = { 1026, 1027 }, -- U V W X Y Z
    [5] = { 1028, 1029 }, -- All others
}

local AREAS_INDEX = {
    A = 0,
    B = 0,
    C = 0,
    D = 0,
    E = 0,

    F = 1,
    G = 1,
    H = 1,
    I = 1,
    J = 1,

    K = 2,
    L = 2,
    M = 2,
    N = 2,
    O = 2,

    P = 3,
    Q = 3,
    R = 3,
    S = 3,
    T = 3,

    U = 4,
    V = 4,
    W = 4,
    X = 4,
    Y = 4,
    Z = 4,
}

local old_rent_mailbox = mailbox.rent_mailbox
function mailbox.rent_mailbox(pos, player)
    if func_areas.is_in_func_area(pos, MANAGED_AREA) then
        local pname = player:get_player_name()
        local first = string.upper(string.sub(pname, 1, 1))
        local areas_index = AREAS_INDEX[first] or 5
        local allowed_areas = AREAS[areas_index]

        if func_areas.is_in_func_area(pos, allowed_areas[1])
            or func_areas.is_in_func_area(pos, allowed_areas[2]) then
            for _, id in ipairs(allowed_areas) do
                local area = areas.areas[id]
                for x = area.pos1.x, area.pos2.x do
                    for y = area.pos1.y, area.pos2.y do
                        for z = area.pos1.z, area.pos2.z do
                            local npos = { x = x, y = y, z = z }
                            local nnode = minetest.get_node(npos)
                            if nnode.name == "mailbox:mailbox" or nnode.name == "mailbox:letterbox" then
                                local nmeta = minetest.get_meta(npos)
                                if nmeta:get_string("owner") == pname then
                                    minetest.chat_send_player(pname,
                                        S("You can't rent more than one mailboxes! Another one found at @1"),
                                        minetest.pos_to_string(npos))
                                    return
                                end
                            end
                        end
                    end
                end
            end
        else
            minetest.chat_send_player(pname, S("This mailbox is not for you! Please go to @1/F.",
                areas_index == 0 and "G" or tostring(areas_index)))
            return
        end
    end

    return old_rent_mailbox(pos, player)
end
