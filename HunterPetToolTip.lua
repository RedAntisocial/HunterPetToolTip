-- HunterPetToolTip.lua
-- Adds hunter pet family and taming requirement info to unit tooltips
-- Family name display is localized automatically via UnitCreatureFamily()
-- Notes are localized via HunterPetToolTip_Locale.lua

-- Family data table
-- Keys are WoW API internal family IDs (second return value of UnitCreatureFamily()) gleaned from https://www.wowhead.com/hunter-pets
-- exotic = true  : requires Beast Mastery specialization to tame
-- note, note2    : locale string keys resolved at display time via HunterPetTip_L to describe extra requirements for taming.

local PetFamilyData = {

	-- Standard families
    [130] = {}, -- Basilisk
    [24]  = {}, -- Bat
    [4]   = {}, -- Bear
    [53]  = {}, -- Beetle
    [26]  = { note = "NOTE_UNDEAD" }, -- Bird of Prey
    [5]   = {}, -- Boar
    [298] = {}, -- Camel
    [7]   = { note = "NOTE_FLORAFAUN" }, -- Carrion Bird
    [2]   = {}, -- Cat
    [299] = {}, -- Courser
    [8]   = {}, -- Crab
    [6]   = {}, -- Crocolisk
    [30]  = {}, -- Dragonhawk
    [50]  = {}, -- Fox
    [9]   = { note = "NOTE_UNDEAD" }, -- Gorilla
    [129] = {}, -- Gruffhorn
    [291] = { note = "NOTE_FLORAFAUN" }, -- Hopper
    [52]  = { note = "NOTE_UNDEAD" }, -- Hound
    [68]  = { note = "NOTE_FLORAFAUN" }, -- Hydra
    [25]  = {}, -- Hyena
    [288] = {}, -- Lizard
    [300] = { note = "NOTE_UNDEAD" }, -- Mammoth
    [51]  = {}, -- Monkey
    [37]  = {}, -- Moth
    [157] = {}, -- Oxen
    [11]  = { note = "NOTE_UNDEAD", note2 = "NOTE_FLORAFAUN" }, -- Raptor
    [31]  = {}, -- Ravager
    [34]  = {}, -- Ray
    [150] = {}, -- Riverbeast
    [127] = { note = "NOTE_OTTUK" }, -- Rodent
    [156] = { note = "NOTE_FLORAFAUN" }, -- Scalehide
    [20]  = {}, -- Scorpid
    [35]  = { note = "NOTE_FLORAFAUN" }, -- Serpent
    [3]   = {}, -- Spider
    [33]  = {}, -- Sporebat
    [151] = { note = "NOTE_VORQUIN" }, -- Stag
    [12]  = {}, -- Tallstrider
    [21]  = {}, -- Turtle
    [32]  = {}, -- Warp Stalker
    [44]  = {}, -- Wasp
    [125] = {}, -- Waterfowl
    [27]  = { note = "NOTE_UNDEAD" }, -- Wind Serpent
    [1]   = {}, -- Wolf

	-- Exotic families (require Beast Mastery)
    [41]  = { exotic = true }, -- Aqiri
    [292] = { exotic = true }, -- Carapid
    [38]  = { exotic = true }, -- Chimaera
    [43]  = {}, -- Clefthoof (not exotic)
    [45]  = { exotic = true }, -- Core Hound
    [39]  = { exotic = true, note = "NOTE_UNDEAD", note2 = "NOTE_FLORAFAUN" }, -- Devilsaur
    [290] = { exotic = true }, -- Pterrordax
    [55]  = { exotic = true }, -- Shale Beast
    [128] = { exotic = true, note = "NOTE_GARGON" }, -- Stone Hound
    [126] = { exotic = true }, -- Water Strider
    [42]  = { exotic = true }, -- Worm
	[315] = { exotic = true }, -- Whiptail

	-- Spirit Beast: exotic + rare world spawn
    [46] = { exotic = true, note = "NOTE_SPIRIT", note2 = "NOTE_FIREOWL" }, -- Spirit Beast

	-- Skill requirements
    [296] = { note = "NOTE_BLOOD" }, -- Blood Beast
    [138] = { note = "NOTE_DINOMANCY", note2 = "NOTE_FLORAFAUN" }, -- Direhorn
    [160] = { note = "NOTE_FEATHER" }, -- Feathermane
    [303] = { note = "NOTE_DRAGONKIN", note2 = "NOTE_DRAGONKIN2" }, -- Lesser Dragonkin
    [154] = { note = "NOTE_MECHA" }, -- Mechanical

}

-- Tooltip line colors
local COLOR_FAMILY  = "|cFFFFD100" -- gold
local COLOR_EXOTIC  = "|cFFFF6600" -- orange
local COLOR_NOTE    = "|cFF00CCFF" -- blue
local COLOR_RESET   = "|r"

-- Spell IDs taught by taming tomes, for known/unknown check on local player
local NoteSpellIDs = {
    NOTE_UNDEAD     = { method = "quest",  id = 62255 },
    NOTE_BLOOD      = { method = "quest",  id = 54753 },
    NOTE_DRAGONKIN2 = { method = "quest",  id = 62254 },
    NOTE_GARGON     = { method = "quest",  id = 61160 },
    NOTE_OTTUK      = { method = "quest",  id = 66444 },
    NOTE_DRAGONKIN  = { method = "quest",  id = 72094 },
    NOTE_VORQUIN    = { method = "quest",  id = 72094 },
	NOTE_FIREOWL    = { method = "quest",  id = 78842 },
    NOTE_FLORAFAUN  = { method = "quest",  id = 87421 },
    NOTE_DINOMANCY  = { method = "spell",  id = 138430 },
    NOTE_MECHA      = { method = "spell",  id = 205154 },
    NOTE_FEATHER    = { method = "spell",  id = 242155 },
}

-- Hook the game tooltip
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(self, data)
    local unit = "mouseover"

	-- print("Mouseover family:", UnitCreatureFamily("mouseover")) -- Pet Family Debug
	-- print("CreatureType:", UnitCreatureType("mouseover")) -- Creature Type Debug
	-- print("UnitClass:", UnitClassification("mouseover")) -- Unit Classification Debug
	
	-- Early exit for things that contain secrets.
    if not unit or UnitIsPlayer(unit) or UnitClassification(unit) == "minus" then return end

    local familyName, familyID = UnitCreatureFamily(unit)
	-- print("familyName:", familyName, "familyID:", familyID) -- Debug Family ID
	if not familyName or not familyID then return end
    if not familyID then return end
    local petData = PetFamilyData[familyID]
    if not petData then return end
    local L = HunterPetTip_L
	-- Family line (familyName is already localized by the client)
    self:AddLine(COLOR_FAMILY .. L.FAMILY .. familyName .. COLOR_RESET)
	-- Exotic flag
    if petData.exotic then
        self:AddLine(COLOR_EXOTIC .. L.EXOTIC .. COLOR_RESET)
    end
	
	local function GetKnownSuffix(noteKey)
		local entry = NoteSpellIDs[noteKey]
		if not entry then return "" end
		local known
		if entry.method == "quest" then
			known = C_QuestLog.IsQuestFlaggedCompleted(entry.id)
        elseif entry.method == "spell" then
            known = C_SpellBook.IsSpellKnown(entry.id)
		end
		return known and " |cFF00FF00[Known]|r" or " |cFFFF0000[Unknown]|r"
	end
	
	if petData.note then
		self:AddLine(COLOR_NOTE .. L[petData.note] .. GetKnownSuffix(petData.note))
	end
	if petData.note2 then
		self:AddLine(COLOR_NOTE .. L[petData.note2] .. GetKnownSuffix(petData.note2))
	end
end)