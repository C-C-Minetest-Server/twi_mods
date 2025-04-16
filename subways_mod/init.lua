-- twi_mods/subways_mod/init.lua
-- Modify subways trains
-- Copyright (c)  2025 1F616EMO
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Apply subway wagon door sound to 01700 series
advtrains.wagon_prototypes["subways_01700_series:01700_series"].doors.open.sound =
    advtrains.wagon_prototypes["advtrains:subway_wagon"].doors.open.sound
advtrains.wagon_prototypes["subways_01700_series:01700_series"].doors.close.sound =
    advtrains.wagon_prototypes["advtrains:subway_wagon"].doors.close.sound
