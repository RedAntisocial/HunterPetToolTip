-- HunterPetToolTip_Locale.lua
-- Localization strings for HunterPetToolTip
-- To add a language: copy the enUS block, change the key to the locale string,
-- and translate the values. Send me the block via CurseForge or GitHub and I'll check it and add it.
-- GetLocale() returns e.g. "deDE", "frFR", "zhCN", etc.
-- Falls back to enUS if the client locale has no entry.
-- I might try my hand at adding a few by using Wowhead in different languages

local L = {

    ["enUS"] = {
        FAMILY          = "Pet Family: ",
        EXOTIC          = "Exotic (Beast Mastery only)",
        NOTE_UNDEAD     = "Undead require: Simple Tome of Bone-Binding",
        NOTE_OTTUK      = "Ottuk require: Ottuk Taming",
        NOTE_VORQUIN    = "Vorquin require: How to Train a Dragonkin",
        NOTE_SPIRIT     = "Spirit Beast",
        NOTE_GARGON     = "Gargon require: Gargon Training Manual",
        NOTE_BLOOD      = "Requires: Blood-Soaked Tome of Dark Whispers",
        NOTE_DINOMANCY  = "Requires: Ancient Tome of Dinomancy",
        NOTE_FEATHER    = "Requires: Tome of the Hybrid Beast",
        NOTE_DRAGONKIN  = "Requires: How to Train a Dragonkin",
        NOTE_DRAGONKIN2 = "Cloud Serpents also require: How to School Your Serpent",
        NOTE_MECHA      = "Requires: Mecha-Bond Imprint Matrix",
		NOTE_FIREOWL    = "Nah'qi (Fire Owl) requires: Mythic Fyrakk Mount",
    },

}

HunterPetTip_L = L[GetLocale()] or L["enUS"]