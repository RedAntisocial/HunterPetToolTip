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
    [7]   = {}, -- Carrion Bird
    [2]   = {}, -- Cat
    [299] = {}, -- Courser
    [8]   = {}, -- Crab
    [6]   = {}, -- Crocolisk
    [30]  = {}, -- Dragonhawk
    [50]  = {}, -- Fox
    [9]   = { note = "NOTE_UNDEAD" }, -- Gorilla
    [129] = {}, -- Gruffhorn
    [291] = {}, -- Hopper
    [52]  = { note = "NOTE_UNDEAD" }, -- Hound
    [68]  = {}, -- Hydra
    [25]  = {}, -- Hyena
    [288] = {}, -- Lizard
    [300] = { note = "NOTE_UNDEAD" }, -- Mammoth
    [51]  = {}, -- Monkey
    [37]  = {}, -- Moth
    [157] = {}, -- Oxen
    [11]  = { note = "NOTE_UNDEAD" }, -- Raptor
    [31]  = {}, -- Ravager
    [34]  = {}, -- Ray
    [150] = {}, -- Riverbeast
    [127] = { note = "NOTE_OTTUK" }, -- Rodent
    [156] = {}, -- Scalehide
    [20]  = {}, -- Scorpid
    [35]  = {}, -- Serpent
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
    [39]  = { exotic = true, note = "NOTE_UNDEAD" }, -- Devilsaur
    [290] = { exotic = true }, -- Pterrordax
    [55]  = { exotic = true }, -- Shale Beast
    [128] = { exotic = true, note = "NOTE_GARGON" }, -- Stone Hound
    [126] = { exotic = true }, -- Water Strider
    [42]  = { exotic = true }, -- Worm
	-- [???] = { exotic = true }, -- Whiptail (Midnight, ID unknown)

	-- Spirit Beast: exotic + rare world spawn
    [46]  = { exotic = true, note = "NOTE_SPIRIT" }, -- Spirit Beast

	-- Skill requirements
    [296] = { note = "NOTE_BLOOD" }, -- Blood Beast
    [138] = { note = "NOTE_DINOMANCY" }, -- Direhorn
    [160] = { note = "NOTE_FEATHER" }, -- Feathermane
    [303] = { note = "NOTE_DRAGONKIN", note2 = "NOTE_DRAGONKIN2" }, -- Lesser Dragonkin
    [154] = { note = "NOTE_MECHA" }, -- Mechanical

}

-- Tooltip line colors
local COLOR_FAMILY  = "|cFFFFD100" -- gold
local COLOR_EXOTIC  = "|cFFFF6600" -- orange
local COLOR_NOTE    = "|cFF00CCFF" -- blue
local COLOR_RESET   = "|r"

-- Returns true if the unit is a potential hunter pet
local function IsLikelyHunterPet(unit)
    if not unit then return false end
    if UnitIsPlayer(unit) then return false end
    return UnitCreatureFamily(unit) ~= nil
end

-- Hook the game tooltip
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(self, data)
    local unit = "mouseover"

	-- print("Mouseover family:", UnitCreatureFamily("mouseover")) -- Pet Family Debug
	-- print("CreatureType:", UnitCreatureType("mouseover")) -- Creature Type Debug
	
    if not unit then return end
    if not IsLikelyHunterPet(unit) then return end

    local familyName, familyID = UnitCreatureFamily(unit)
	
	-- print("familyName:", familyName, "familyID:", familyID) -- Debug Family ID
	if not familyName or not familyID then return end

    local petData = PetFamilyData[familyID]
    if not petData then return end

    local L = HunterPetTip_L

	-- Family line (familyName is already localized by the client)
    self:AddLine(COLOR_FAMILY .. L.FAMILY .. familyName .. COLOR_RESET)

	-- Exotic flag
    if petData.exotic then
        self:AddLine(COLOR_EXOTIC .. L.EXOTIC .. COLOR_RESET)
    end

	-- Special taming notes
    if petData.note then
        self:AddLine(COLOR_NOTE .. L[petData.note] .. COLOR_RESET)
    end
    if petData.note2 then
        self:AddLine(COLOR_NOTE .. L[petData.note2] .. COLOR_RESET)
    end

end)
