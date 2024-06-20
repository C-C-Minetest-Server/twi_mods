-- twi_mods/random_tips/init.lua
-- Tips for 1F616EMO Server
--[[
    Copyright (C) 2024  1F616EMO

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
    USA
]]

local S = minetest.get_translator("random_tips")

--[[
    Chinese translations guidelines:
    1. Use TA (pinyin of 他/她) when translating gender-neutral third-person pronouns.
       Spaces are not required on both sides of TA.
       Use 你 (gender-neutral/male/traditional) when translating gender-neutral second-person pronouns,
       as using NI seems odd.
    2. Use 「」 for Traditional Chinese, and “” for Simplified, as pointed out by y5nw in minetest-mods/areas#71.
]]

random_messages_api.from_table({
    -- teleport commands
    S("Type in /spawn to go back to the spawn point, where you can access numerous useful locations and facilities."),
    S("Type in /sethome at where you want to set up your home coordinates, and then type in /home to go back."),
    S("To request teleporting to another player's location, type in /tpr <their name>."),

    -- Communications
    S("To seek help, click the top-right speech bubble icon to open the chatroom. On PC, press T."),
    S("Type in /mail to open the mail dialog, where you can communicate with other players without them being online."),
    S("Type in /report if you want to contact our moderation team to report misbehavior or suggest changes."),

    -- In-game POI
    S("The public farm at Spawn provides an early-game food source. " ..
        "Remember to replant the crops after harvesting them."),
    S("The public tree farm at Spawn can be an easy way to get wood. " ..
        "Don't forget to plant the saplings after chopping down wood."),
    S("Visit Spawn South via train or by walk from Spawn for places to settle down."),

    -- Advtrains
    S("Do not walk on tracks. The damage from a running train is deadly."),
    S("Right-click a train with an opened door to go onto it."),

    -- Technic
    S("Using machines from the technic mod speeds up your crafting workflows."),
    S("Visit a technic station to use machines from the technic mod without crafting them yourself."),
    S("Tools from the technic mod may require charging. Place them in the \"charging\" slot of a battery box."),
    S("Crafting a mining drill can be very helpful in bulk digging tasks."),
    S("Use a chainsaw to chop down an entire tree at once."),

    -- Pipeworks
    S("Autocrafters are useful in freeing your hand from repeated crafting tasks."),
    S("Item ejectors take items from a container into the pneumatic tube system."),
    S("Connect containers to a pneumatic tube system for items to flow in."),
    S("Always add trash cans at the end of pneumatic tube systems having the risk of overflowing " ..
        "to avoid breaking them."),

    -- Digtron
    S("The digtron mod helps construct automated tunnel-boring machines. " ..
        "It is very useful in mining or building repeating patterns."),

    -- Farming
    S("Punch a grown crop with a mithril scythe to re-plant it while obtaining its drops."),
    S("Punch a dirt block with a hoe to turn it into farmlands. Do so near water for the farmland to work."),
    S("Discover different crops around the world, and plant them in farmlands by right-clicking."),

    -- Bonemeal
    S("Bones are dropped by chance when digging dirt blocks. " ..
        "They can be ground into bone meal for fertilizing crops and plants."),
    S("Using bonemeal on dirt blocks to obtain flowers and grasses naturally found on that type of dirt."),

    -- Economy (smartshop/atm/wtt)
    S("Click on the selling items icon of a smart shop interface to buy them."),
    S("Right-click an ATM to withdraw or deposit money."),
    S("Right-click a wire transfer terminal to start a digital transaction. " ..
        "The receiver will be notified via in-game mail."),

    -- For Sale Sign
    S("Vacant plots are indicated by a \"SALE\" sign. Right-click it to buy the plot."),
})
