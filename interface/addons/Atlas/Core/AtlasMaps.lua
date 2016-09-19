-- $Id: AtlasMaps.lua 97 2016-09-05 14:59:04Z arith $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert@gmail.com>
	Copyright 2010 - Lothaer <lothayer@gmail.com>, Atlas Team
	Copyright 2011 ~ 2016 - Arith Hsu, Atlas Team <atlas.addon@gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

-- Atlas Map Data

--[[
# Structure of JournalInstance.dbc
Column	Field		Type		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1	ID		Integer
2	Map ID		Integer		Map ID refer to Map.dbc's 1st column
3	Area ID		Integer		Area ID refer to AreaTable.dbc's 1st column
4~6			Integer
7			Integer
8	Name		String
9	Description	String


# Structure of JournalEncounter.dbc
Column	Field		Type		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1	ID		Integer
2	Map ID?		Integer
3	Area ID?	Integer
4~5			Float
6	Selection ID	Integer
7	Instance ID	Integer		Refer to JournalInstance.dbc's 1st column
8	Index		Integer		Boss index
9
10	Name		String		Boss name
11	Description	String		Boss description


# Structure of JournalEncounterCreature.dbc
Column	Field 		Type 		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1	ID		Integer
2	encounterID	Integer
3	modelID		Integer
4	Index		Integer
5			Integer
6	name		String


# Structure of LFGDungeons.dbc
Column	Field 		Type 		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1 	ID 		Integer 		
2	Map Name	String		Dungeon Name
3	level_min 	Integer 	Minimum level to participate. 
4 	level_max 	Integer 	Maximum level when this dungeon becomes trivial. 
5	rec_level	Integer
6	rec_minlevel	Integer
7	rec_maxlevel	Integer
8 	Map ID	        Integer 	Here you must add the Map Id where you will be ported
9	difficulty	Integer
13	systemname
14	expansion

]]
local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0");
local BF = Atlas_GetLocaleLibBabble("LibBabble-Faction-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("Atlas");
local ALIL = Atlas_IngameLocales;

local BLUE = "|cff6666ff";
local GREN = "|cff66cc33";
local GREY = "|cff999999";
local LBLU = "|cff33cccc";
local _RED = "|cffcc3333";
local ORNG = "|cffcc9933";
local PINK = "|ccfcc33cc";
local PURP = "|cff9900ff";
local WHIT = "|cffffffff";
local YLOW = "|cffcccc33";
local INDENT = "      ";


AtlasMaps = {
--[[
Syntax: 
	MapName = {
		ZoneName = { "Map name" };
		Location = { "Location of this map" };
		LevelRange = "level range";
		MinLevel = "minimum level";
		PlayerLimit = "player limit";
		Acronym = "acronym";
		JournalInstanceID = "journal instance ID"; 	-- ID can be found from JournalInstance.dbc, Column 1 is the dungeon ID, column 8 is dungeon name
		DungeonID = "LFGDungeon ID"; 			-- ID can be fround from LFGDungeons.dbc.txt
		DungeonHeoricID = "LFGDungeon ID for Heroic mode";
		{ "list entry 1" };
		{ "list entry 2" };
		{ "list entry 3" };
		{ "list entry 4" };
	};
]]

--************************************************
-- Instance Entrance Maps
--************************************************

	AuchindounEnt = {
		ZoneName = { BZ["Auchindoun"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	BlackfathomDeepsEnt = {
		ZoneName = { BZ["Blackfathom Deeps"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	BlackrockMountainEnt = {
		ZoneName = { BZ["Blackrock Mountain"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Location = { BZ["Searing Gorge"]..L["Slash"]..BZ["Burning Steppes"] };
		LevelRange = "49-100+";
		MinLevel = "47";
		PlayerLimit = "5/10/25/40";
		Acronym = L["BRM"];
		{ BLUE.." A) "..BZ["Searing Gorge"], 10001 };
		{ BLUE.." B) "..BZ["Burning Steppes"], 10002 };
		{ BLUE.." C) "..BZ["Blackrock Depths"], 10003 };
		{ BLUE.." D) "..BZ["Lower Blackrock Spire"], 10004 };
		{ BLUE..INDENT..BZ["Upper Blackrock Spire"] };
		{ GREN..INDENT..L["Bodley"]..L["L-Parenthesis"]..L["Ghost"]..L["R-Parenthesis"] };
		{ BLUE.." E) "..BZ["The Molten Core"], 10005 };
		{ GREN..INDENT..L["Lothos Riftwaker"] };
		{ BLUE.." F) "..BZ["Blackwing Lair"], 10006 };
		{ GREN..INDENT..L["Orb of Command"] };
		{ BLUE.." G) "..BZ["Blackrock Caverns"], 10007 };
		{ ORNG.." 1) "..L["Scarshield Quartermaster <Scarshield Legion>"]..L["L-Parenthesis"]..L["Upper"]..L["R-Parenthesis"], 10008 };
		{ ORNG.." 2) "..L["The Behemoth"]..L["L-Parenthesis"]..L["Rare"]..L["Comma"]..L["Wanders"]..L["R-Parenthesis"], 10009 };
		{ ORNG.." 3) "..Atlas_GetBossName("Overmaster Pyron")..L["L-Parenthesis"]..L["Wanders"]..L["R-Parenthesis"], 10010 };
		{ GREN.." 1') "..L["Meeting Stone"]..L["L-Parenthesis"]..BZ["Blackrock Depths"]..L["R-Parenthesis"], 10011 };
		{ GREN.." 2') "..L["Meeting Stone"]..L["L-Parenthesis"]..BZ["Lower Blackrock Spire"]..L["Comma"]..BZ["Upper Blackrock Spire"]..L["R-Parenthesis"], 10012 };
	};
	CavernsOfTimeEnt = {
		ZoneName = { BZ["Caverns of Time"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Location = { BZ["Tanaris"] };
		LevelRange = "66-85+";
		MinLevel = "66";
		PlayerLimit = "5/10/25";
		Acronym = L["CoT"];
		{ BLUE.." A) "..L["Entrance"], 10001 };
		{ BLUE.." B) "..BZ["Hyjal Summit"], 10002 };
		{ BLUE.." C) "..BZ["Old Hillsbrad Foothills"], 10003 };
		{ BLUE.." D) "..BZ["The Black Morass"], 10004 };
		{ BLUE.." E) "..BZ["The Culling of Stratholme"], 10005 };
		{ BLUE.." F) "..BZ["Dragon Soul"], 10006 };
		{ BLUE.." G) "..BZ["End Time"], 10007 };
		{ BLUE.." H) "..BZ["Well of Eternity"], 10008 };
		{ BLUE.." I) "..BZ["Hour of Twilight"], 10009 };
		{ GREN.." 1') "..L["Steward of Time <Keepers of Time>"], 10010 };
		{ GREN.." 2') "..L["Alexston Chrome <Tavern of Time>"], 10011 };
		{ GREN.." 3') "..L["Graveyard"], 10012 };
		{ GREN.." 4') "..L["Yarley <Armorer>"], 10013 };
		{ GREN.." 5') "..L["Bortega <Reagents & Poison Supplies>"], 10014 };
		{ GREN..INDENT..L["Alurmi <Keepers of Time Quartermaster>"] };
		{ GREN..INDENT..L["Galgrom <Provisioner>"] };
		{ GREN.." 6') "..L["Zaladormu"], 10015 };
		{ GREN..INDENT..L["Soridormi <The Scale of Sands>"]..L["L-Parenthesis"]..L["Wanders"]..L["R-Parenthesis"] };
		{ GREN..INDENT..L["Arazmodu <The Scale of Sands>"]..L["L-Parenthesis"]..L["Wanders"]..L["R-Parenthesis"] };
		{ GREN.." 7') "..L["Moonwell"], 10016 };
		{ GREN.." 8') "..L["Andormu <Keepers of Time>"]..L["L-Parenthesis"]..L["Child"]..L["R-Parenthesis"], 10017 };
		{ GREN..INDENT..L["Nozari <Keepers of Time>"]..L["L-Parenthesis"]..L["Child"]..L["R-Parenthesis"] };
		{ GREN.." 9') "..L["Anachronos <Keepers of Time>"], 10018 };
		{ GREN.."10') "..L["Andormu <Keepers of Time>"]..L["L-Parenthesis"]..L["Adult"]..L["R-Parenthesis"], 10019 };
		{ GREN..INDENT..L["Nozari <Keepers of Time>"]..L["L-Parenthesis"]..L["Adult"]..L["R-Parenthesis"] };
	};
	CoTHyjalEnt = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Hyjal Summit"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	CoilfangReservoirEnt = {
		ZoneName = { BZ["Coilfang Reservoir"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	DireMaulEnt = {
		ZoneName = { BZ["Dire Maul"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	HellfireCitadelEnt = {
		ZoneName = { BZ["Hellfire Citadel"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	IcecrownEnt = {
		ZoneName = { BZ["Icecrown Citadel"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	KarazhanEnt = {
		ZoneName = { BZ["Karazhan"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	MaraudonEnt = {
		ZoneName = { BZ["Maraudon"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	ScarletMonasteryEnt = {
		ZoneName = { BZ["Scarlet Monastery"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_MistsofPandaria";
	};
	TempestKeepEnt = {
		ZoneName = { BZ["Tempest Keep"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	TheDeadminesEnt = {
		ZoneName = { BZ["The Deadmines"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_Cataclysm";
	};
	TheSunkenTempleEnt = {
		ZoneName = { BZ["Sunken Temple"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	UldamanEnt = {
		ZoneName = { BZ["Uldaman"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	UlduarEnt = {
		ZoneName = { BZ["Ulduar"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	WailingCavernsEnt = {
		ZoneName = { BZ["Wailing Caverns"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};

--************************************************
-- Kalimdor Instances (Classic)
--************************************************

	BlackfathomDeeps = {
		ZoneName = { BZ["Blackfathom Deeps"] };
		Module = "Atlas_ClassicWoW";
	};
	DireMaulEast = {
		ZoneName = { BZ["Dire Maul"]..L["L-Parenthesis"]..L["East"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	DireMaulNorth = {
		ZoneName = { BZ["Dire Maul"]..L["L-Parenthesis"]..L["North"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	DireMaulWest = {
		ZoneName = { BZ["Dire Maul"]..L["L-Parenthesis"]..L["West"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	Maraudon = {
		ZoneName = { BZ["Maraudon"] };
		Module = "Atlas_ClassicWoW";
	};
	RagefireChasm = {
		ZoneName = { BZ["Ragefire Chasm"] };
		Module = "Atlas_ClassicWoW";
	};
	RazorfenDowns = {
		ZoneName = { BZ["Razorfen Downs"] };
		Module = "Atlas_ClassicWoW";
	};
	RazorfenKraul = {
		ZoneName = { BZ["Razorfen Kraul"] };
		Module = "Atlas_ClassicWoW";
	};
	TheRuinsofAhnQiraj = {
		ZoneName = { BZ["Ahn'Qiraj"]..L["Colon"]..BZ["Ruins of Ahn'Qiraj"] };
		Module = "Atlas_ClassicWoW";
	};
	TheTempleofAhnQiraj = {
		ZoneName = { BZ["Ahn'Qiraj"]..L["Colon"]..BZ["Temple of Ahn'Qiraj"] };
		Module = "Atlas_ClassicWoW";
	};
	WailingCaverns = {
		ZoneName = { BZ["Wailing Caverns"] };
		Module = "Atlas_ClassicWoW";
	};
	ZulFarrak = {
		ZoneName = { BZ["Zul'Farrak"] };
		Module = "Atlas_ClassicWoW";
	};

--************************************************
-- Eastern Kingdoms Instances (Classic)
--************************************************
	
	BlackrockDepths = {
		ZoneName = { BZ["Blackrock Mountain"]..L["Colon"]..BZ["Blackrock Depths"] };
		Module = "Atlas_ClassicWoW";
	};
	BlackwingLair = {
		ZoneName = { BZ["Blackrock Mountain"]..L["Colon"]..BZ["Blackwing Lair"] };
		Module = "Atlas_ClassicWoW";
	};
	GnomereganEnt = {
		ZoneName = { BZ["Gnomeregan"]..L["L-Parenthesis"]..L["Entrance"]..L["R-Parenthesis"] };
		Module = "Atlas_ClassicWoW";
	};
	Gnomeregan = {
		ZoneName = { BZ["Gnomeregan"] };
		Module = "Atlas_ClassicWoW";
	};
	LowerBlackrockSpire = {
		ZoneName = { BZ["Blackrock Mountain"]..L["Colon"]..BZ["Lower Blackrock Spire"] };
		Module = "Atlas_ClassicWoW";
	};
	MoltenCore = {
		ZoneName = { BZ["Blackrock Mountain"]..L["Colon"]..BZ["The Molten Core"] };
		Module = "Atlas_ClassicWoW";
	};
	StratholmeCrusader = {
		ZoneName = { BZ["Stratholme"]..L["Hyphen"]..BZ["Crusaders' Square"] };
		Module = "Atlas_ClassicWoW";
	};
	StratholmeGauntlet = {
		ZoneName = { BZ["Stratholme"]..L["Hyphen"]..BZ["The Gauntlet"] };
		Module = "Atlas_ClassicWoW";
	};
	TheStockade = {
		ZoneName = { BZ["The Stockade"] };
		Module = "Atlas_ClassicWoW";
	};
	TheSunkenTemple = {
		ZoneName = { BZ["Sunken Temple"] };
		Module = "Atlas_ClassicWoW";
	};
	Uldaman = {
		ZoneName = { BZ["Uldaman"] };
		Module = "Atlas_ClassicWoW";
	};

--************************************************
-- Burning Crusade Instances
--************************************************

	AuchAuchenaiCrypts = {
		ZoneName = { BZ["Auchindoun"]..L["Colon"]..BZ["Auchenai Crypts"] };
		Module = "Atlas_BurningCrusade";
	};
	AuchManaTombs = {
		ZoneName = { BZ["Auchindoun"]..L["Colon"]..BZ["Mana-Tombs"] };
		Module = "Atlas_BurningCrusade";
	};
	AuchSethekkHalls = {
		ZoneName = { BZ["Auchindoun"]..L["Colon"]..BZ["Sethekk Halls"] };
		Module = "Atlas_BurningCrusade";
	};
	AuchShadowLabyrinth = {
		ZoneName = { BZ["Auchindoun"]..L["Colon"]..BZ["Shadow Labyrinth"] };
		Module = "Atlas_BurningCrusade";
	};
	BlackTempleStart = {
		ZoneName = { BZ["Black Temple"]..L["MapA"]..L["L-Parenthesis"]..L["Start"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	BlackTempleBasement = {
		ZoneName = { BZ["Black Temple"]..L["MapB"]..L["L-Parenthesis"]..L["Basement"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	BlackTempleTop = {
		ZoneName = { BZ["Black Temple"]..L["MapC"]..L["L-Parenthesis"]..L["Top"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	CFRSerpentshrineCavern = {
		ZoneName = { BZ["Coilfang Reservoir"]..L["Colon"]..BZ["Serpentshrine Cavern"] };
		Module = "Atlas_BurningCrusade";
	};
	CFRTheSlavePens = {
		ZoneName = { BZ["Coilfang Reservoir"]..L["Colon"]..BZ["The Slave Pens"] };
		Module = "Atlas_BurningCrusade";
	};
	CFRTheSteamvault = {
		ZoneName = { BZ["Coilfang Reservoir"]..L["Colon"]..BZ["The Steamvault"] };
		Module = "Atlas_BurningCrusade";
	};
	CFRTheUnderbog = {
		ZoneName = { BZ["Coilfang Reservoir"]..L["Colon"]..BZ["The Underbog"] };
		Module = "Atlas_BurningCrusade";
	};
	CoTBlackMorass = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["The Black Morass"] };
		Module = "Atlas_BurningCrusade";
	};
	CoTHyjal = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Hyjal Summit"] };
		Module = "Atlas_BurningCrusade";
	};
	CoTOldHillsbrad = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Old Hillsbrad Foothills"] };
		Module = "Atlas_BurningCrusade";
	};
	GruulsLair = {
		ZoneName = { BZ["Gruul's Lair"] };
		Module = "Atlas_BurningCrusade";
	};
	HCBloodFurnace = {
		ZoneName = { BZ["Hellfire Citadel"]..L["Colon"]..BZ["The Blood Furnace"] };
		Module = "Atlas_BurningCrusade";
	};
	HCHellfireRamparts = {
		ZoneName = { BZ["Hellfire Citadel"]..L["Colon"]..BZ["Hellfire Ramparts"] };
		Module = "Atlas_BurningCrusade";
	};
	HCMagtheridonsLair = {
		ZoneName = { BZ["Hellfire Citadel"]..L["Colon"]..BZ["Magtheridon's Lair"] };
		Module = "Atlas_BurningCrusade";
	};
	HCTheShatteredHalls = {
		ZoneName = { BZ["Hellfire Citadel"]..L["Colon"]..BZ["The Shattered Halls"] };
		Module = "Atlas_BurningCrusade";
	};
	KarazhanStart = {
		ZoneName = { BZ["Karazhan"]..L["MapA"]..L["L-Parenthesis"]..L["Start"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	KarazhanEnd = {
		ZoneName = { BZ["Karazhan"]..L["MapB"]..L["L-Parenthesis"]..L["End"]..L["R-Parenthesis"] };
		Module = "Atlas_BurningCrusade";
	};
	MagistersTerrace = {
		ZoneName = { BZ["Magisters' Terrace"] };
		Module = "Atlas_BurningCrusade";
	};
	SunwellPlateau = {
		ZoneName = { BZ["Sunwell Plateau"] };
		Module = "Atlas_BurningCrusade";
	};
	TempestKeepArcatraz = {
		ZoneName = { BZ["Tempest Keep"]..L["Colon"]..BZ["The Arcatraz"] };
		Module = "Atlas_BurningCrusade";
	};
	TempestKeepBotanica = {
		ZoneName = { BZ["Tempest Keep"]..L["Colon"]..BZ["The Botanica"] };
		Module = "Atlas_BurningCrusade";
	};
	TempestKeepMechanar = {
		ZoneName = { BZ["Tempest Keep"]..L["Colon"]..BZ["The Mechanar"] };
		Module = "Atlas_BurningCrusade";
	};
	TempestKeepTheEye = {
		ZoneName = { BZ["Tempest Keep"]..L["Colon"]..BZ["Tempest Keep"] };
		Module = "Atlas_BurningCrusade";
	};

--************************************************
-- Wrath of the Lich King Instances
--************************************************

	AhnKahet = {
		ZoneName = { BZ["Ahn'kahet: The Old Kingdom"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	AzjolNerub = {
		ZoneName = { BZ["Azjol-Nerub"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	CoTOldStratholme = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["The Culling of Stratholme"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	DrakTharonKeep = {
		ZoneName = { BZ["Drak'Tharon Keep"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	FHHallsOfReflection = {
		ZoneName = { BZ["The Frozen Halls"]..L["Colon"]..BZ["Halls of Reflection"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	FHPitOfSaron = {
		ZoneName = { BZ["The Frozen Halls"]..L["Colon"]..BZ["Pit of Saron"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	FHTheForgeOfSouls = {
		ZoneName = { BZ["The Frozen Halls"]..L["Colon"]..BZ["The Forge of Souls"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	Gundrak = {
		ZoneName = { BZ["Gundrak"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	IcecrownCitadelA = {
		ZoneName = { BZ["Icecrown Citadel"]..L["MapA"]..L["L-Parenthesis"]..L["Lower"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	IcecrownCitadelB = {
		ZoneName = { BZ["Icecrown Citadel"]..L["MapB"]..L["L-Parenthesis"]..L["Upper"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	IcecrownCitadelC = {
		ZoneName = { BZ["Icecrown Citadel"]..L["MapC"]..L["L-Parenthesis"]..BZ["The Frozen Throne"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	Naxxramas = {
		ZoneName = { BZ["Naxxramas"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	ObsidianSanctum = {
		ZoneName = { BZ["Wyrmrest Temple"]..L["Colon"]..BZ["The Obsidian Sanctum"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	OnyxiasLair = {
		ZoneName = { BZ["Onyxia's Lair"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	RubySanctum = {
		ZoneName = { BZ["Wyrmrest Temple"]..L["Colon"]..BZ["The Ruby Sanctum"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	TheEyeOfEternity = {
		ZoneName = { BZ["The Nexus"]..L["Colon"]..BZ["The Eye of Eternity"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	TheNexus = {
		ZoneName = { BZ["The Nexus"]..L["Colon"]..BZ["The Nexus"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	TheOculus = {
		ZoneName = { BZ["The Nexus"]..L["Colon"]..BZ["The Oculus"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	TrialOfTheChampion = {
		ZoneName = { L["Crusaders' Coliseum"]..L["Colon"]..BZ["Trial of the Champion"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	TrialOfTheCrusader = {
		ZoneName = { L["Crusaders' Coliseum"]..L["Colon"]..BZ["Trial of the Crusader"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UlduarA = {
		ZoneName = { BZ["Ulduar"]..L["MapA"]..L["L-Parenthesis"]..L["The Siege"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UlduarB = {
		ZoneName = { BZ["Ulduar"]..L["MapB"]..L["L-Parenthesis"]..BZ["The Antechamber"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UlduarC = {
		ZoneName = { BZ["Ulduar"]..L["MapC"]..L["L-Parenthesis"]..L["The Keepers"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UlduarD = {
		ZoneName = { BZ["Ulduar"]..L["MapD"]..L["L-Parenthesis"]..BZ["The Spark of Imagination"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UlduarE = {
		ZoneName = { BZ["Ulduar"]..L["MapE"]..L["L-Parenthesis"]..BZ["The Descent into Madness"]..L["R-Parenthesis"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UlduarHallsofLightning = {
		ZoneName = { BZ["Ulduar"]..L["Colon"]..BZ["Halls of Lightning"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UlduarHallsofStone = {
		ZoneName = { BZ["Ulduar"]..L["Colon"]..BZ["Halls of Stone"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UtgardeKeep = {
		ZoneName = { BZ["Utgarde Keep"]..L["Colon"]..BZ["Utgarde Keep"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	UtgardePinnacle = {
		ZoneName = { BZ["Utgarde Keep"]..L["Colon"]..BZ["Utgarde Pinnacle"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	VaultOfArchavon = {
		ZoneName = { BZ["Vault of Archavon"] };
		Module = "Atlas_WrathoftheLichKing";
	};
	VioletHold = {
		ZoneName = { BZ["The Violet Hold"] };
		Module = "Atlas_WrathoftheLichKing";
	};

--************************************************
-- Cataclysm Instances
--************************************************

	BaradinHold = {
		ZoneName = { BZ["Baradin Hold"] };
		Module = "Atlas_Cataclysm";
	};
	BlackrockCaverns = {
		ZoneName = { BZ["Blackrock Mountain"]..L["Colon"]..BZ["Blackrock Caverns"] };
		Module = "Atlas_Cataclysm";
	};
	BlackwingDescent = {
		ZoneName = { BZ["Blackrock Mountain"]..L["Colon"]..BZ["Blackwing Descent"] };
		Module = "Atlas_Cataclysm";
	};
	CoTDragonSoulA = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Dragon Soul"]..L["MapA"] };
		Module = "Atlas_Cataclysm";
	};
	CoTDragonSoulB = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Dragon Soul"]..L["MapB"] };
		Module = "Atlas_Cataclysm";
	};
	CoTDragonSoulC = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Dragon Soul"]..L["MapC"] };
		Module = "Atlas_Cataclysm";
	};
	CoTEndTime = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["End Time"] };
		Module = "Atlas_Cataclysm";
	};
	CoTHourOfTwilight = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Hour of Twilight"] };
		Module = "Atlas_Cataclysm";
	};
	CoTWellOfEternity = {
		ZoneName = { BZ["Caverns of Time"]..L["Colon"]..BZ["Well of Eternity"] };
		Module = "Atlas_Cataclysm";
	};
	Firelands = {
		ZoneName = { BZ["Firelands"] };
		Module = "Atlas_Cataclysm";
	};
	GrimBatol = {
		ZoneName = { BZ["Grim Batol"] };
		Module = "Atlas_Cataclysm";
	};
	HallsOfOrigination = {
		ZoneName = { BZ["Halls of Origination"] };
		Module = "Atlas_Cataclysm";
	};
	LostCityOfTolvir = {
		ZoneName = { BZ["Lost City of the Tol'vir"] };
		Module = "Atlas_Cataclysm";
	};
	ShadowfangKeep = {
		ZoneName = { BZ["Shadowfang Keep"] };
		Module = "Atlas_Cataclysm";
	};
	TheBastionOfTwilight = {
		ZoneName = { BZ["The Bastion of Twilight"] };
		Module = "Atlas_Cataclysm";
	};
	TheDeadmines = {
		ZoneName = { BZ["The Deadmines"] };
		Module = "Atlas_Cataclysm";
	};
	TheStonecore = {
		ZoneName = { BZ["The Stonecore"] };
		Module = "Atlas_Cataclysm";
	};
	TheVortexPinnacle = {
		ZoneName = { BZ["The Vortex Pinnacle"] };
		Module = "Atlas_Cataclysm";
	};
	ThroneOfTheFourWinds = {
		ZoneName = { BZ["Throne of the Four Winds"] };
		Module = "Atlas_Cataclysm";
	};
	ThroneOfTheTides = {
		ZoneName = { BZ["The Abyssal Maw"]..L["Colon"]..BZ["Throne of the Tides"] };
		Module = "Atlas_Cataclysm";
	};
	ZulAman = {
		ZoneName = { BZ["Zul'Aman"] };
		Module = "Atlas_Cataclysm";
	};	
	ZulGurub = {
		ZoneName = { BZ["Zul'Gurub"] };
		Module = "Atlas_Cataclysm";
	};

--************************************************
-- Mists of Pandaria Instances
--************************************************

	GateoftheSettingSun = {
		ZoneName = { BZ["Gate of the Setting Sun"] };
		Module = "Atlas_MistsofPandaria";
	};
	HeartofFear = {
		ZoneName = { BZ["Heart of Fear"] };
		Module = "Atlas_MistsofPandaria";
	};
	MoguShanPalace = {
		ZoneName = { BZ["Mogu'shan Palace"] };
		Module = "Atlas_MistsofPandaria";
	};
	MoguShanVaults = {
		ZoneName = { BZ["Mogu'shan Vaults"] };
		Module = "Atlas_MistsofPandaria";
	};
	ScarletHalls = {
		ZoneName = { BZ["Scarlet Monastery"]..L["Colon"]..BZ["Scarlet Halls"] };
		Module = "Atlas_MistsofPandaria";
	};
	ScarletMonastery = {
		ZoneName = { BZ["Scarlet Monastery"]..L["Colon"]..BZ["Scarlet Monastery"] };
		Module = "Atlas_MistsofPandaria";
	};
	Scholomance = {
		ZoneName = { BZ["Scholomance"] };
		Module = "Atlas_MistsofPandaria";
	};
	ShadoPanMonasteryA = {
		ZoneName = { BZ["Shado-Pan Monastery"]..L["MapA"] };
		Module = "Atlas_MistsofPandaria";
	};
	ShadoPanMonasteryB = {
		ZoneName = { BZ["Shado-Pan Monastery"]..L["MapB"] };
		Module = "Atlas_MistsofPandaria";
	};
	SiegeofNiuzaoTempleA = {
		ZoneName = { BZ["Siege of Niuzao Temple"]..L["MapA"] };
		Module = "Atlas_MistsofPandaria";
	};
	SiegeofNiuzaoTempleB = {
		ZoneName = { BZ["Siege of Niuzao Temple"]..L["MapB"] };
		Module = "Atlas_MistsofPandaria";
	};
	SiegeofOrgrimmarA = {
		ZoneName = { BZ["Siege of Orgrimmar"]..L["MapA"] };
		Module = "Atlas_MistsofPandaria";
	};
	SiegeofOrgrimmarB = {
		ZoneName = { BZ["Siege of Orgrimmar"]..L["MapB"] };
		Module = "Atlas_MistsofPandaria";
	};
	SiegeofOrgrimmarC = {
		ZoneName = { BZ["Siege of Orgrimmar"]..L["MapC"] };
		Module = "Atlas_MistsofPandaria";
	};
	SiegeofOrgrimmarD = {
		ZoneName = { BZ["Siege of Orgrimmar"]..L["MapD"] };
		Module = "Atlas_MistsofPandaria";
	};
	StormstoutBrewery = {
		ZoneName = { BZ["Stormstout Brewery"] };
		Module = "Atlas_MistsofPandaria";
	};
	TempleOfTheJadeSerpent = {
		ZoneName = { BZ["Temple of the Jade Serpent"] };
		Module = "Atlas_MistsofPandaria";
	};
	TerraceofEndlessSpring = {
		ZoneName = { BZ["Terrace of Endless Spring"] };
		Module = "Atlas_MistsofPandaria";
	};
	ThroneofThunderA = {
		ZoneName = { BZ["Throne of Thunder"]..L["MapA"] };
		Module = "Atlas_MistsofPandaria";
	};
	ThroneofThunderB = {
		ZoneName = { BZ["Throne of Thunder"]..L["MapB"] };
		Module = "Atlas_MistsofPandaria";
	};
	ThroneofThunderC = {
		ZoneName = { BZ["Throne of Thunder"]..L["MapC"] };
		Module = "Atlas_MistsofPandaria";
	};
	ThroneofThunderD = {
		ZoneName = { BZ["Throne of Thunder"]..L["MapD"] };
		Module = "Atlas_MistsofPandaria";
	};

--************************************************
-- Warlords of Draenor Instances
--************************************************
	Auchindoun = {
		ZoneName = { BZ["Auchindoun"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	BlackrockFoundryA = {
		ZoneName = { BZ["Blackrock Foundry"]..L["MapA"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	BlackrockFoundryB = {
		ZoneName = { BZ["Blackrock Foundry"]..L["MapB"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	BloodmaulSlagMines = {
		ZoneName = { BZ["Bloodmaul Slag Mines"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	TheEverbloomA = {
		ZoneName = { BZ["The Everbloom"]..L["MapA"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	TheEverbloomB = {
		ZoneName = { BZ["The Everbloom"]..L["MapB"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	GrimrailDepot = {
		ZoneName = { BZ["Grimrail Depot"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HellfireA = {
		ZoneName = { BZ["Hellfire Citadel"]..L["MapA"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HellfireB = {
		ZoneName = { BZ["Hellfire Citadel"]..L["MapB"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HellfireC = {
		ZoneName = { BZ["Hellfire Citadel"]..L["MapC"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HellfireD = {
		ZoneName = { BZ["Hellfire Citadel"]..L["MapD"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HellfireE = {
		ZoneName = { BZ["Hellfire Citadel"]..L["MapE"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HellfireF = { 
		ZoneName = { BZ["Hellfire Citadel"]..L["MapF"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HighmaulA = {
		ZoneName = { BZ["Highmaul"]..L["MapA"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	HighmaulB = {
		ZoneName = { BZ["Highmaul"]..L["MapB"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	IronDocks = {
		ZoneName = { BZ["Iron Docks"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	ShadowmoonBurialGrounds = {
		ZoneName = { BZ["Shadowmoon Burial Grounds"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	Skyreach = {
		ZoneName = { BZ["Skyreach"] };
		Module = "Atlas_WarlordsofDraenor";
	};
	UpperBlackrockSpire = {
		ZoneName = { BZ["Blackrock Mountain"]..L["Colon"]..BZ["Upper Blackrock Spire"] };
		Module = "Atlas_WarlordsofDraenor";
	};

--************************************************
-- Legion
--************************************************
	AssaultonVioletHold = {
		ZoneName = { BZ["Assault on Violet Hold"] };
		Module = "Atlas_Legion";
	};
	BlackRookHoldA = {
		ZoneName = { BZ["Black Rook Hold"]..L["MapA"] };
		Module = "Atlas_Legion";
	};
	BlackRookHoldB = {
		ZoneName = { BZ["Black Rook Hold"]..L["MapB"] };
		Module = "Atlas_Legion";
	};
	BlackRookHoldC = {
		ZoneName = { BZ["Black Rook Hold"]..L["MapC"] };
		Module = "Atlas_Legion";
	};
	CourtofStarsA = {
		ZoneName = { BZ["Court of Stars"]..L["MapA"] };
		Module = "Atlas_Legion";
	};
	CourtofStarsB = {
		ZoneName = { BZ["Court of Stars"]..L["MapB"] };
		Module = "Atlas_Legion";
	};
	DarkheartThicket = {
		ZoneName = { BZ["Darkheart Thicket"] };
		Module = "Atlas_Legion";
	};
	EyeofAzshara = {
		ZoneName = { BZ["Eye of Azshara"] };
		Module = "Atlas_Legion";
	};
	HallsofValorA = { 
		ZoneName = { BZ["Halls of Valor"]..L["MapA"] };
		Module = "Atlas_Legion";
	};
	HallsofValorB = { 
		ZoneName = { BZ["Halls of Valor"]..L["MapB"] };
		Module = "Atlas_Legion";
	};
	HallsofValorC = { 
		ZoneName = { BZ["Halls of Valor"]..L["MapC"] };
		Module = "Atlas_Legion";
	};
	MawofSoulsA = {
		ZoneName = { BZ["Maw of Souls"]..L["MapA"] };
		Module = "Atlas_Legion";
	};
	MawofSoulsB = {
		ZoneName = { BZ["Maw of Souls"]..L["MapB"] };
		Module = "Atlas_Legion";
	};
	NeltharionsLair = {
		ZoneName = { BZ["Neltharion's Lair"] };
		Module = "Atlas_Legion";
	};
	TheArcway = {
		ZoneName = { BZ["The Arcway"] };
		Module = "Atlas_Legion";
	};
	TheEmeraldNightmareA = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapA"] };
		Module = "Atlas_Legion";
	};
	TheEmeraldNightmareB = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapB"] };
		Module = "Atlas_Legion";
	};
	TheEmeraldNightmareC = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapC"] };
		Module = "Atlas_Legion";
	};
	TheEmeraldNightmareD = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapD"] };
		Module = "Atlas_Legion";
	};
	TheEmeraldNightmareE = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapE"] };
		Module = "Atlas_Legion";
	};
	TheEmeraldNightmareF = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapF"] };
		Module = "Atlas_Legion";
	};
	TheEmeraldNightmareG = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapG"] };
		Module = "Atlas_Legion";
	};
	-- Map TODO
--[[
	TheEmeraldNightmareH = {
		ZoneName = { BZ["The Emerald Nightmare"]..L["MapH"] };
		Module = "Atlas_Legion";
	};
]]
	TheNightholdA = {
		ZoneName = { BZ["The Nighthold"]..L["MapA"] };
		Module = "Atlas_Legion";
	};
	TheNightholdB = {
		ZoneName = { BZ["The Nighthold"]..L["MapB"] };
		Module = "Atlas_Legion";
	};
	TheNightholdC = {
		ZoneName = { BZ["The Nighthold"]..L["MapC"] };
		Module = "Atlas_Legion";
	};
	TheNightholdD = {
		ZoneName = { BZ["The Nighthold"]..L["MapD"] };
		Module = "Atlas_Legion";
	};
	TheNightholdE = {
		ZoneName = { BZ["The Nighthold"]..L["MapE"] };
		Module = "Atlas_Legion";
	};
	TheNightholdF = {
		ZoneName = { BZ["The Nighthold"]..L["MapF"] };
		Module = "Atlas_Legion";
	};
	-- Map TODO
--[[
	TheNightholdG = {
		ZoneName = { BZ["The Nighthold"]..L["MapG"] };
		Module = "Atlas_Legion";
	};
]]
	VaultoftheWardensA = {
		ZoneName = { BZ["Vault of the Wardens"]..L["MapA"] };
		Module = "Atlas_Legion";
	};
	VaultoftheWardensB = {
		ZoneName = { BZ["Vault of the Wardens"]..L["MapB"] };
		Module = "Atlas_Legion";
	};
	VaultoftheWardensC = {
		ZoneName = { BZ["Vault of the Wardens"]..L["MapC"] };
		Module = "Atlas_Legion";
	};
};
