-- twi_mods/twi_bgm/init.lua
-- Make background musics by area
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

-- Songs played around Spawnpoint in daytime
background_music.register_music("twi_bgm:spawn_day", {
    -- Sun Cave Village
    -- Soundworlds Histories: Chasing the Leviathan (John Oestmann)
    -- License: CC0
    {
        name = "john_leviathan_03",
        gain = 0.4,
        resend_time = 198.4,
    },

    -- Inca Pan Flute hip hop
    -- Tom Peter
    -- https://opengameart.org/content/inca-pan-flute-hip-hop
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    {
        name = "tom_inca_pan_flute",
        gain = 0.4,
        resend_time = 146.4,
    },

    -- Fluffy style
    -- Totraf
    -- https://opengameart.org/content/fluffy-style
    -- License: CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        name = "tom_fluffy_style",
        gain = 0.4,
        resend_time = 161.9,
    }
})

-- Songs played around Spawnpoint at night
background_music.register_music("twi_bgm:spawn_night", {
    -- Del Erad
    -- Radakan OST (Janne Hanhisuanto for Radakan)
    -- https://opengameart.org/content/radakan-del-erad
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    {
        name = "radakan_del_erad",
        gain = 0.4,
        resend_time = 300.8,
    },

    -- Never Grow Up
    -- Diminixed
    -- License:CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/
    {
        name = "diminixed_nevergrowup",
        gain = 0.4,
        resend_time = 71.4,
    },
})

-- Songs played in SmushyVille in daytime
background_music.register_music("twi_bgm:smushyville_day", {
    -- Little Town [TODO]
    -- bart (remixz: 1F616EMO)
    -- https://opengameart.org/content/little-town
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    -- {
    --     name = "1f616emo_little_town",
    -- },

    -- Setpping Stones (No Drums)
    -- Matthew Pablo
    -- https://opengameart.org/content/stepping-stones
    -- License: CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        name = "matthew_stepping_stones_nodrums",
        gain = 0.4,
        resend_time = 102.9,
    },

    -- Woodland Fantasy
    -- Matthew Pablo
    -- https://opengameart.org/content/woodland-fantasy
    -- License: CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        name = "matthew_woodland_fantasy",
        gain = 0.4,
        resend_time = 150.1,
    },

    -- Yuri, the Travelling Shoppe
    -- Soundworlds Histories: Duskfire (John Oestmann)
    -- License: CC0
    {
        name = "john_duskfire_07",
        gain = 0.4,
        resend_time = 100.2,
    },
})

-- Songs played in SmushyVille at night
background_music.register_music("twi_bgm:smushyville_night", {
    -- Deadlands Forest Shrine
    -- Soundworlds Datapedia: Ardune Ambient (John Oestmann)
    -- License: CC0
    {
        name = "john_ardune_07",
        gain = 0.4,
        resend_time = 193.5,
    },

    -- A New Town (RPG Theme)
    -- Pixelsphere OST (cynicmusic)
    -- https://opengameart.org/content/a-new-town-rpg-theme
    -- License: CC0
    {
        name = "pixelsphere_25_new_town",
        gain = 0.4,
        resend_time = 62.3,
    },
})

background_music.register_on_decide_music(function(player)
    local ppos = player:get_pos()
    local timeofday = minetest.get_timeofday()
    -- 0.23 < day < 0.78
    local now_day = timeofday > 0.23 and timeofday < 0.78

    if func_areas.is_in_func_area(ppos, 497) then
        -- Spawn Island
        return now_day and "twi_bgm:spawn_day" or "twi_bgm:spawn_night"
    elseif func_areas.is_in_func_area(ppos, 498) then
        -- Spawn Island
        return now_day and "twi_bgm:smushyville_day" or "twi_bgm:smushyville_night"
    end
end)
