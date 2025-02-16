-- twi_mods/beerchat_mods/init.lua
-- special channels
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = core.get_translator("beerchat_mod")

local owner = core.settings:get("name") or "$SYSTEM"

local function is_privileged(name)
    local privs = core.get_player_privs(name)
    return name == owner or privs.server or privs.privs or privs.ban or privs.role_helper or false
end

do
    local old_is_player_subscribed_to_channel = beerchat.is_player_subscribed_to_channel

    function beerchat.is_player_subscribed_to_channel(name, channel)
        if channel == "Moderators" then
            return is_privileged(name)
        elseif channel == "grounded" then
            return is_privileged(name) or old_is_player_subscribed_to_channel(name, channel)
        end

        return old_is_player_subscribed_to_channel(name, channel)
    end
end

beerchat.register_callback('before_invite', function(name, _, channel)
    if channel == "Moderators" or channel == "grounded" then
        return false, S("The members of #@1 is automatically set by the server.", channel)
    end
end)

-- Does not handle forced join
beerchat.register_callback('before_join', function(name, channel)
    if channel == "Moderators" or channel == "grounded" then
        return false, S("The members of #@1 is automatically set by the server.", channel)
    end
end)

beerchat.register_callback('before_leave', function(name, channel)
    if channel == "Moderators" then
        return false, S("The members of #@1 is automatically set by the server.", channel)
    elseif channel == "grounded" and is_privileged(name) then
        return false, S("Can't leave #@1: You're privileged.", channel)
    end
end)

beerchat.register_callback('before_delete_channel', function(name, delete)
    local channel = delete.channel
    if channel == "Moderators" or channel == "grounded" then
        return false, S("Can't delete #@1: It's a system channel.", channel)
    end
end)

-- Make sure system-handled channels are registered

beerchat.channels.Moderators = beerchat.channels.Moderators or {}
beerchat.channels.Moderators.owner = owner
beerchat.channels.Moderators.name = "Moderators"
beerchat.channels.Moderators.password = "" -- Don't worry, players can't join anyways
beerchat.channels.Moderators.color = beerchat.channels.Moderators.color or beerchat.default_channel_color

beerchat.channels.grounded = beerchat.channels.grounded or {}
beerchat.channels.grounded.owner = owner
beerchat.channels.grounded.name = "grounded"
beerchat.channels.grounded.password = "" -- Don't worry, players can't join anyways
beerchat.channels.grounded.color = beerchat.channels.grounded.color or beerchat.default_channel_color

beerchat.mod_storage:set_string("channels", core.write_json(beerchat.channels))

-- Invite owner (so they can modify the channel) and kick all others

beerchat.register_callback('after_joinplayer', function(player, last_login)
    local name = player:get_player_name()
    local meta = player:get_meta()

    if name == owner then
        beerchat.playersChannels[name].Moderators = "owner"
        beerchat.playersChannels[name].grounded = "owner"
    else
        beerchat.playersChannels[name].Moderators = nil
        if beerchat.playersChannels[name].grounded == "owner" then
            beerchat.playersChannels[name].grounded = nil
        end
    end

    if not beerchat.playersChannels[name][beerchat.currentPlayerChannel[name]] then
        beerchat.currentPlayerChannel[name] = beerchat.main_channel_name
        meta:set_string("beerchat:current_channel", beerchat.main_channel_name)
    end

    meta:set_string("beerchat:channels", core.write_json(beerchat.playersChannels[name]))
end)
