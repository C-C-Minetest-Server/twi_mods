-- twi_mods/twi_bgm/init.lua
-- Make background musics by area
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local MP = core.get_modpath("twi_bgm")

-- Songs played around Grape Hills Spawnpoint in daytime
background_music.register_music("twi_bgm:gh_spawn_day", {
    -- Sun Cave Village
    -- Soundworlds Histories: Chasing the Leviathan (John Oestmann)
    -- https://johnoestmannmusic.com/
    -- License: CC0 https://creativecommons.org/publicdomain/zero/1.0/
    {
        file = MP .. "/bgms/john_leviathan_03.ogg",
        gain = 0.4,
        resend_time = 198.4,

        -- Attribution information
        title = "Sun Cave Village",
        author = "John Oestmann",
        author_link = "https://johnoestmannmusic.com/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Inca Pan Flute hip hop
    -- Tom Peter
    -- https://opengameart.org/content/inca-pan-flute-hip-hop
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    {
        file = MP .. "/bgms/tom_inca_pan_flute.ogg",
        gain = 0.4,
        resend_time = 146.4,

        -- Attribution information
        title = "Inca Pan Flute Hip Hop",
        author = "Tom Peter",
        author_link = "https://opengameart.org/content/inca-pan-flute-hip-hop",
        license = "CC BY-SA 3.0",
        license_link = "https://creativecommons.org/licenses/by-sa/3.0/",
    },

    -- Fluffy style
    -- Totraf
    -- https://opengameart.org/content/fluffy-style
    -- License: CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        file = MP .. "/bgms/tom_fluffy_style.ogg",
        gain = 0.4,
        resend_time = 161.9,

        -- Attribution information
        title = "Fluffy Style",
        author = "Totraf",
        author_link = "https://opengameart.org/content/fluffy-style",
        license = "CC BY 3.0",
        license_link = "https://creativecommons.org/licenses/by/3.0/",
    },

    -- Town Themne
    -- Pixelsphere OST? (cynicmusic)
    -- https://opengameart.org/content/town-theme-rpg
    -- License: CC0
    {
        file = MP .. "/bgms/cynicmusic_town_theme.ogg",
        gain = 0.4,
        resend_time = 97.5,

        -- Attribution information
        title = "Town Theme",
        author = "cynicmusic",
        author_link = "https://opengameart.org/content/town-theme-rpg",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Yuri, the Travelling Shoppe
    -- Soundworlds Histories: Duskfire (John Oestmann)
    -- https://johnoestmannmusic.com/
    -- License: CC0
    {
        file = MP .. "/bgms/john_duskfire_07.ogg",
        gain = 0.4,
        resend_time = 100.2,

        -- Attribution information
        title = "Yuri, The Travelling Shoppe",
        author = "John Oestmann",
        author_link = "https://johnoestmannmusic.com/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Stepping Pebbles (No Drums)
    -- Matthew Pablo
    -- https://opengameart.org/content/stepping-stones
    -- License: CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        file = MP .. "/bgms/pablo_stepping_pebbles_nodrums.ogg",
        gain = 0.4,
        resend_time = 64.4,

        -- Attribution information
        title = "Stepping Pebbles (No Drums)",
        author = "Matthew Pablo",
        author_link = "https://opengameart.org/content/stepping-stones",
        license = "CC BY 3.0",
        license_link = "https://creativecommons.org/licenses/by/3.0/",
    },

    -- Little Town [TODO]
    -- bart (remix: 1F616EMO)
    -- https://opengameart.org/content/little-town
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    -- {
    --     file = MP .. "/bgms/1f616emo_little_town",
    -- },
})

-- Songs played around Grape Hills Spawnpoint at night
background_music.register_music("twi_bgm:gh_spawn_night", {
    -- Del Erad
    -- Radakan OST (Janne Hanhisuanto for Radakan)
    -- https://opengameart.org/content/radakan-del-erad
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    {
        file = MP .. "/bgms/radakan_del_erad.ogg",
        gain = 0.4,
        resend_time = 300.8,

        -- Attribution information
        title = "Del Erad",
        author = "Janne Hanhisuanto",
        author_link = "https://opengameart.org/content/radakan-del-erad",
        license = "CC BY-SA 3.0",
        license_link = "https://creativecommons.org/licenses/by-sa/3.0/",
    },

    -- Never Grow Up
    -- Diminixed
    -- License:CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/
    {
        file = MP .. "/bgms/diminixed_nevergrowup.ogg",
        gain = 0.4,
        resend_time = 71.4,

        -- Attribution information
        title = "Never Grow Up",
        author = "Diminixed",
        author_link = "",
        license = "CC BY-SA 4.0",
        license_link = "https://creativecommons.org/licenses/by-sa/4.0/",
    },

    -- A New Town (RPG Theme)
    -- Pixelsphere OST (cynicmusic)
    -- https://pixelsphere.org/
    -- License: CC0
    {
        file = MP .. "/bgms/pixelsphere_25_new_town.ogg",
        gain = 0.4,
        resend_time = 62.3,

        -- Attribution information
        title = "A New Town (RPG Theme)",
        author = "cynicmusic",
        author_link = "https://pixelsphere.org/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Deadlands Forest Shrine
    -- Soundworlds Datapedia: Ardune Ambient (John Oestmann)
    -- https://johnoestmannmusic.com/
    -- License: CC0
    {
        file = MP .. "/bgms/john_ardune_07.ogg",
        gain = 0.4,
        resend_time = 193.5,

        -- Attribution information
        title = "Deadlands Forest Shrine",
        author = "John Oestmann",
        author_link = "https://johnoestmannmusic.com/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Path to Lake Land
    -- Alexandr Zhelanov
    -- License: CC-BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        file = MP .. "/bgms/zhelanov_path_lake_land.ogg",
        gain = 0.4,
        resend_time = 254.8,

        -- Attribution information
        title = "Path to Lake Land",
        author = "Alexandr Zhelanov",
        author_link = "",
        license = "CC BY 3.0",
        license_link = "https://creativecommons.org/licenses/by/3.0/",
    },
})

-- Songs played around Spawnpoint in daytime
background_music.register_music("twi_bgm:spawn_day", {
    -- Sun Cave Village
    -- Soundworlds Histories: Chasing the Leviathan (John Oestmann)
    -- https://johnoestmannmusic.com/
    -- License: CC0
    {
        file = MP .. "/bgms/john_leviathan_03.ogg",
        gain = 0.4,
        resend_time = 198.4,

        -- Attribution information
        title = "Sun Cave Village",
        author = "John Oestmann",
        author_link = "https://johnoestmannmusic.com/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Inca Pan Flute hip hop
    -- Tom Peter
    -- https://opengameart.org/content/inca-pan-flute-hip-hop
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    {
        file = MP .. "/bgms/tom_inca_pan_flute.ogg",
        gain = 0.4,
        resend_time = 146.4,

        -- Attribution information
        title = "Inca Pan Flute Hip Hop",
        author = "Tom Peter",
        author_link = "https://opengameart.org/content/inca-pan-flute-hip-hop",
        license = "CC BY-SA 3.0",
        license_link = "https://creativecommons.org/licenses/by-sa/3.0/",
    },

    -- Fluffy style
    -- Totraf
    -- https://opengameart.org/content/fluffy-style
    -- License: CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        file = MP .. "/bgms/tom_fluffy_style.ogg",
        gain = 0.4,
        resend_time = 161.9,

        -- Attribution information
        title = "Fluffy Style",
        author = "Totraf",
        author_link = "https://opengameart.org/content/fluffy-style",
        license = "CC BY 3.0",
        license_link = "https://creativecommons.org/licenses/by/3.0/",
    },

    -- Town Themne
    -- Pixelsphere OST? (cynicmusic)
    -- https://opengameart.org/content/town-theme-rpg
    -- License: CC0
    {
        file = MP .. "/bgms/cynicmusic_town_theme.ogg",
        gain = 0.4,
        resend_time = 97.5,

        -- Attribution information
        title = "Town Theme",
        author = "cynicmusic",
        author_link = "https://opengameart.org/content/town-theme-rpg",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Yuri, the Travelling Shoppe
    -- Soundworlds Histories: Duskfire (John Oestmann)
    -- https://johnoestmannmusic.com/
    -- License: CC0
    {
        file = MP .. "/bgms/john_duskfire_07.ogg",
        gain = 0.4,
        resend_time = 100.2,

        -- Attribution information
        title = "Yuri, The Travelling Shoppe",
        author = "John Oestmann",
        author_link = "https://johnoestmannmusic.com/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Stepping Pebbles (No Drums)
    -- Matthew Pablo
    -- https://opengameart.org/content/stepping-stones
    -- License: CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        file = MP .. "/bgms/pablo_stepping_pebbles_nodrums.ogg",
        gain = 0.4,
        resend_time = 64.4,

        -- Attribution information
        title = "Stepping Pebbles (No Drums)",
        author = "Matthew Pablo",
        author_link = "https://opengameart.org/content/stepping-stones",
        license = "CC BY 3.0",
        license_link = "https://creativecommons.org/licenses/by/3.0/",
    },
})

-- Songs played around Spawnpoint at night
background_music.register_music("twi_bgm:spawn_night", {
    -- Del Erad
    -- Radakan OST (Janne Hanhisuanto for Radakan)
    -- https://opengameart.org/content/radakan-del-erad
    -- License: CC BY-SA 3.0 https://creativecommons.org/licenses/by-sa/3.0/
    {
        file = MP .. "/bgms/radakan_del_erad.ogg",
        gain = 0.4,
        resend_time = 300.8,

        -- Attribution information
        title = "Del Erad",
        author = "Janne Hanhisuanto",
        author_link = "https://opengameart.org/content/radakan-del-erad",
        license = "CC BY-SA 3.0",
        license_link = "https://creativecommons.org/licenses/by-sa/3.0/",
    },

    -- Never Grow Up
    -- Diminixed
    -- License:CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/
    {
        file = MP .. "/bgms/diminixed_nevergrowup.ogg",
        gain = 0.4,
        resend_time = 71.4,

        -- Attribution information
        title = "Never Grow Up",
        author = "Diminixed",
        author_link = "",
        license = "CC BY-SA 4.0",
        license_link = "https://creativecommons.org/licenses/by-sa/4.0/",
    },

    -- A New Town (RPG Theme)
    -- Pixelsphere OST (cynicmusic)
    -- https://pixelsphere.org/
    -- License: CC0
    {
        file = MP .. "/bgms/pixelsphere_25_new_town.ogg",
        gain = 0.4,
        resend_time = 62.3,

        -- Attribution information
        title = "A New Town (RPG Theme)",
        author = "cynicmusic",
        author_link = "https://pixelsphere.org/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Deadlands Forest Shrine
    -- Soundworlds Datapedia: Ardune Ambient (John Oestmann)
    -- https://johnoestmannmusic.com/
    -- License: CC0
    {
        file = MP .. "/bgms/john_ardune_07.ogg",
        gain = 0.4,
        resend_time = 193.5,

        -- Attribution information
        title = "Deadlands Forest Shrine",
        author = "John Oestmann",
        author_link = "https://johnoestmannmusic.com/",
        license = "CC0-1.0",
        license_link = "https://creativecommons.org/publicdomain/zero/1.0/",
    },

    -- Path to Lake Land
    -- Alexandr Zhelanov
    -- License: CC-BY 3.0 https://creativecommons.org/licenses/by/3.0/
    {
        file = MP .. "/bgms/zhelanov_path_lake_land.ogg",
        gain = 0.4,
        resend_time = 254.8,

        -- Attribution information
        title = "Path to Lake Land",
        author = "Alexandr Zhelanov",
        author_link = "",
        license = "CC BY 3.0",
        license_link = "https://creativecommons.org/licenses/by/3.0/",
    },
})

background_music.register_on_decide_music(function(player)
    local ppos = player:get_pos()
    local timeofday = core.get_timeofday()
    -- 0.23 < day < 0.78
    local now_day = timeofday > 0.23 and timeofday < 0.78

    if func_areas.is_in_func_area(ppos, 2207) then
        -- Grape Hills Spawn
        return now_day and "twi_bgm:gh_spawn_day" or "twi_bgm:gh_spawn_night"
    end

    if func_areas.is_in_func_area(ppos, 497) then
        -- Spawn Island
        return now_day and "twi_bgm:spawn_day" or "twi_bgm:spawn_night"
    end
end)
