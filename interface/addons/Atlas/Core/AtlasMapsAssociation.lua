-- $Id: AtlasMapsAssociation.lua 84 2016-08-29 05:33:54Z arith $
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

local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0");

--[[
	Atlas_AssocDefaults{}

	Default map to be auto-selected when no SubZone data is available.

	For example, "Dire Maul" has a subzone called "Warpwood Quarter" located in East Dirl Maul, however, there are also 
	some areas which have not been named with any subzone, and we would like to pick a proper default map in this condition.

	Define this table entries only when the instance has multiple maps.

	Table index is zone name, it need to be localized value, but we will handle the localization with BabbleSubZone library.
	The table value is map's key-name.
]]
Atlas_AssocDefaults = {
	[BZ["Blackrock Foundry"]] =		"BlackrockFoundryA";
	[BZ["Blackrock Mountain"]] =		"BlackrockMountainEnt";
	[BZ["Blackrock Spire"]] =		"LowerBlackrockSpire";
	[BZ["Hall of Blackhand"]] =		"LowerBlackrockSpire";
	[BZ["Black Temple"]] =			"BlackTempleBasement";
	[BZ["Dire Maul"]] =			"DireMaulNorth";
	[BZ["Dragon Soul"]] =			"CoTDragonSoulA";
	[BZ["Hellfire Citadel"]] =		"HellfireA";
	[BZ["Highmaul"]] =			"HighmaulA";
	[BZ["Icecrown Citadel"]] =		"IcecrownCitadelA";
	[BZ["Karazhan"]] =			"KarazhanStart";
	[BZ["Shado-Pan Monastery"]] =		"ShadoPanMonasteryA";
	[BZ["Siege of Niuzao Temple"]] =	"SiegeofNiuzaoTempleA";
	[BZ["Siege of Orgrimmar"]] =		"SiegeofOrgrimmarA";
	[BZ["Stratholme"]] =			"StratholmeGauntlet";
	[BZ["The Everbloom"]] =			"TheEverbloomA";
	[BZ["Throne of Tides"]] = 		"ThroneOfTheTides";
	[BZ["Throne of Thunder"]] = 		"ThroneofThunderB";
	[BZ["The Wailing Caverns"]] = 		"WailingCavernsEnt";
	[BZ["Ulduar"]] =			"UlduarA";
-- Legion
	[BZ["Black Rook Hold"]] = 		"BlackRookHoldA";
	[BZ["Court of Stars"]] = 		"CourtofStarsA";
	[BZ["Halls of Valor"]] = 		"HallsofValorA";
	[BZ["Maw of Souls"]] = 			"MawofSoulsA";
	[BZ["The Emerald Nightmare"]] = 	"TheEmeraldNightmareA";
	[BZ["The Nighthold"]] = 		"TheNightholdC";
	[BZ["Vault of the Wardens"]] = 		"VaultoftheWardensA";
};

--[[
	Atlas_SubZoneData{}

	Define SubZone data for default map to be selected for instance which has multiple maps.
	Subzone data should be able to be pulled out from WMOAreaTable for indoor areas, or from AreaTable for outdoor areas.

	Array Syntax: 
	["localized zone name"] = {
		["atlas map name"] = {
			["localized subzone name 1"],
			["localized subzone name 2"],
		},
	},
]]
Atlas_SubZoneData = {
	-- Blackrock Foundry
	[BZ["Blackrock Foundry"]] = {
		-- Blackrock Foundry A
		["BlackrockFoundryA"] = {
			BZ["The Workshop"],
			BZ["Slagworks"],
			BZ["Gruul's Lair"],
			BZ["Blackrock Depository"],
			BZ["Iron Assembly"],
			BZ["The Breaking Grounds"],
			BZ["Foundry Terminus"],
			BZ["The Blast Furnace"],
			BZ["The Crucible"],
			BZ["The Iron Crucible"], --check
		},
		-- Blackrock Foundry B
		["BlackrockFoundryB"] = {
			BZ["The Black Forge"],
			BZ["Burning Font"],
			BZ["Slagmill Press"],
			BZ["The Great Anvil"],
			BZ["Dread Grotto"],
		},
	},
	-- Blackrock Spire
	[BZ["Hall of Blackhand"]] = {
		-- Lower Blackrock Spire
		["LowerBlackrockSpire"] = {
			BZ["Hordemar City"],
			BZ["Mok'Doom"],
			BZ["Tazz'Alor"],
			BZ["Skitterweb Tunnels"],
			BZ["The Storehouse"],
			BZ["Halycon's Lair"],
			BZ["Chamber of Battle"],
		},
		-- Upper Blackrock Spire
		["UpperBlackrockSpire"] = {
			BZ["Dragonspire Hall"],
			BZ["Hall of Binding"],
			BZ["The Rookery"],
			BZ["Hall of Blackhand"],
			BZ["Blackrock Stadium"],
			BZ["The Furnace"],
			BZ["Spire Throne"],
			BZ["The Molten Span"],
		},
	},
	-- Black Temple
	[BZ["Black Temple"]] = {
		-- Black Temple, Start
		["BlackTempleStart"] = {
			BZ["Karabor Sewers"],
			BZ["Illidari Training Grounds"],
			BZ["Sanctuary of Shadows"],
			BZ["The Refectory"],
		},
		-- Black Temple, Basement
		["BlackTempleBasement"] = {
			BZ["Gorefiend's Vigil"],
			BZ["Halls of Anguish"],
			BZ["Shrine of Lost Souls"],
		},
		-- Black Temple, Top
		["BlackTempleTop"] = {
			BZ["Den of Mortal Delights"],
			BZ["Grand Promenade"],
			BZ["Chamber of Command"],
			BZ["Temple Summit"],
		},
	},
	-- Dire Maul
	[BZ["Dire Maul"]] = {
		-- Dire Maul, Entrance
		["DireMaulEnt"] = {
			BZ["Broken Commons"],
			-- Comment out below as they are currently redundant due to the Zone is Feralas
			--BZ["Eldreth Row"],
			--BZ["The Maul"],
		},
		-- Dire Maul, North
		["DireMaulNorth"] = {
			BZ["Halls of Destruction"],
			BZ["Gordok's Seat"],
		},
		-- Dire Maul, East
		["DireMaulEast"] = {
			BZ["Warpwood Quarter"],
			BZ["The Hidden Reach"],
			BZ["The Conservatory"],
			BZ["The Shrine of Eldretharr"],
		},
		-- Dire Maul, West
		["DireMaulWest"] = {
			BZ["Capital Gardens"],
			BZ["Court of the Highborne"],
			BZ["Prison of Immol'thar"],
			BZ["The Athenaeum"],
		},
	},
	-- Dragon Soul
	[BZ["Dragon Soul"]] = {
		-- Dragon Soul A
		["CoTDragonSoulA"] = {
			BZ["Path of the Titans"],
			BZ["The Dragon Wastes"],
			BZ["Wyrmrest Temple"],
			BZ["Wyrmrest Summit"],
		},
		-- Dragon Soul B
		["CoTDragonSoulB"] = {
			BZ["Maw of Go'rath"],
			BZ["Maw of Shu'ma"],
			BZ["Eye of Eternity"],
		},
		-- Dragon Soul C
		["CoTDragonSoulC"] = {
			BZ["Above the Frozen Sea"],
			BZ["The Skyfire"],
			BZ["Deathwing"],
			BZ["The Maelstrom"],
		},
	},
	-- Hellfire Citadel
	[BZ["Hellfire Citadel"]] = {
		-- HellfireA
		["HellfireA"] = {
			BZ["The Iron Bulwark"],
		},
		-- HellfireB
		["HellfireB"] = {
			BZ["Hellfire Antechamber"],
			BZ["Hellfire Passage"],
			BZ["Court of Blood"],
		},
		-- HellfireC
		["HellfireC"] = {
			BZ["Pits of Mannoroth"],
		},
		-- HellfireD
		["HellfireD"] = {
			BZ["Grommash's Torment"],
			BZ["The Felborne Breach"],
			BZ["Halls of the Sargerei"],
		},
		-- HellfireE
		["HellfireE"] = {
			BZ["Destructor's Rise"],
		},
		-- HellfireF
		["HellfireF"] = {
			BZ["The Black Gate"],
		},
	},
	-- Highmaul
	[BZ["Highmaul"]] = {
		-- Highmaul A
		["HighmaulA"] = {
			BZ["Gladiator's Rest"],
			BZ["The Coliseum"],
			BZ["Path of Victors"],
			BZ["The Underbelly"],
			BZ["The Imperator's Favor"],
			BZ["Market District"],
			BZ["Gorian Strand"],

		},
		-- Highmaul B
		["HighmaulB"] = {
			BZ["The Gorthenon"],
			BZ["Chamber of Nullification"],
			BZ["Imperator's Rise"],
			BZ["Throne of the Imperator"],
		},
	},
	-- Icecrown Citadell
	[BZ["Icecrown Citadel"]] = {
		-- Icecrown Citadell, Lower
		["IcecrownCitadelA"] = {
			BZ["Light's Hammer"],	
			BZ["Oratory of the Damned"],
			BZ["Rampart of Skulls"],
			BZ["Deathbringer's Rise"],
		},
		-- Icecrown Citadell, Upper
		["IcecrownCitadelB"] = {
			BZ["The Plagueworks"],
			BZ["Putricide's Laboratory of Alchemical Horrors and Fun"],
			BZ["The Crimson Hall"],
			BZ["The Sanctum of Blood"],
			BZ["The Frostwing Halls"],
			BZ["The Frost Queen's Lair"],
		},
		-- Icecrown Citadell, Frozen Throne
		["IcecrownCitadelC"] = {
			BZ["The Frozen Throne"],
			BZ["Frostmourne"],
		},
	},
	-- Karazhan
	[BZ["Karazhan"]] = {
		-- Karazhan, Start
		["KarazhanStart"] = {
			BZ["The Gatehouse"],
			BZ["Livery Stables"],
			BZ["The Guardhouse"],
			BZ["The Scullery"],
			BZ["Servants' Quarters"],
			BZ["The Grand Ballroom"],
			BZ["The Banquet Hall"],
			BZ["The Guest Chambers"],
			BZ["The Opera Hall"],
			BZ["The Broken Stair"],
			BZ["Master's Terrace"],
		},
		-- Karazhan, End
		["KarazhanEnd"] = {
			BZ["The Menagerie"],
			BZ["Guardian's Library"],
			BZ["The Repository"],
			BZ["The Celestial Watch"],
			BZ["Gamesman's Hall"],
			BZ["Medivh's Chambers"],
			BZ["Master's Terrace"],
			BZ["Netherspace"],
		},
	},
	-- Shado-Pan Monastery
	[BZ["Shado-Pan Monastery"]] = {
		-- Shado-Pan Monastery A
		["ShadoPanMonasteryA"] = {
			BZ["Cloudstrike Dojo"],
			BZ["Grove of Falling Blossoms"],
		},
		-- Shado-Pan Monastery B
		["ShadoPanMonasteryB"] = {
			BZ["Snowdrift Dojo"],
			BZ["Sealed Chambers"],
		},
	},
	-- Siege of Niuzao Temple
	[BZ["Siege of Niuzao Temple"]] = {
		-- Siege of Niuzao Temple A
		["SiegeofNiuzaoTempleA"] = {
			BZ["Hollowed Out Tree"],
		},
		-- Siege of Niuzao Temple B
		["SiegeofNiuzaoTempleB"] = {
			BZ["Rear Staging Area"],
			BZ["Forward Assault Camp"],
		},
	},
	-- Siege of Orgrimmar
	[BZ["Siege of Orgrimmar"]] = {
		-- Siege of Orgrimmar A
		["SiegeofOrgrimmarA"] = {
			BZ["Pools of Power"],
			BZ["Ruined Passage"],
			BZ["Big Blossom Mine"],
			BZ["Chamber of Purification"],
			BZ["Vault of Y'Shaarj"],
		},
		-- Siege of Orgrimmar B
		["SiegeofOrgrimmarB"] = {
			BZ["Scarred Vale"],
		},
		-- Siege of Orgrimmar C
		["SiegeofOrgrimmarC"] = {
			BZ["Bladefist Bay"],
			BZ["Dranosh'ar Landing"],
			BZ["The Darkspear Offensive"],
			BZ["Before the Gates"],
			BZ["Gates of Orgrimmar"],
			BZ["Valley of Strength"],
			BZ["The Drag"],
		},
		-- Siege of Orgrimmar D
		["SiegeofOrgrimmarD"] = {
			BZ["Cleft of Shadow"],
			BZ["Ragefire Chasm"],
			BZ["The Descent"],
			BZ["Rough-Hewn Passage"],
			BZ["Kor'kron Barracks"],
			BZ["Underhold Nexus"],
			BZ["Artifact Storage"],
			BZ["The Menagerie"],
			BZ["The Siegeworks"],
			BZ["Chamber of the Paragons"],
			BZ["The Inner Sanctum"],
			BZ["Terrace of Endless Spring"],
			BZ["Temple of the Jade Serpent"],
			BZ["Temple of the Red Crane"],
		},
	},
	-- Stratholme
	[BZ["Stratholme"]] = {
		-- Stratholme - Crusader's Square
		["StratholmeCrusader"] = {
			BZ["King's Square"],
			BZ["Festival Lane"],
			BZ["Market Row"],
			BZ["Crusaders' Square"],
			BZ["The Scarlet Bastion"],
			BZ["The Hall of Lights"],
			BZ["The Hoard"],
			BZ["The Crimson Throne"],
		},
		-- Stratholme - The Gauntlet
		["StratholmeGauntlet"] = {
			BZ["Elders' Square"],
			BZ["The Gauntlet"],
			BZ["Slaughter Square"],
			BZ["The Slaughter House"],
		},
	},
	-- The Everbloom
	[BZ["The Everbloom"]] = {
		-- The Everbloom A
		["TheEverbloomA"] = {
			BZ["Pools of Life"],
			BZ["Verdant Grove"],
			BZ["Xeri'tac's Burrow"],
			BZ["The Violet Bluff"],
		},
		-- The Everbloom B
		["TheEverbloomB"] = {
			BZ["Stormwind"],
		},
	},
	-- The Stockade
	[BZ["The Stockade"]] = {
		-- The Stockade
		["TheStockade"] = {
			BZ["Stormwind Stockade"],
		},
	},
	-- Throne of Thunder
	[BZ["Throne of Thunder"]] = {
		-- Throne of Thunder A
		["ThroneofThunderA"] = {
			BZ["Ruined Approach"],
			BZ["Overgrown Statuary"],
			BZ["Grand Overlook"],
			BZ["Royal Amphitheater"],
			BZ["Lightning Promenade"],
			BZ["The Stormbridge"],
		},
		-- Throne of Thunder B
		["ThroneofThunderB"] = {
			BZ["Lair of Tortos"],
			BZ["Forgotten Depths"],
			BZ["Roost of Ji-Kun"],
			BZ["Refuse Disposal"],
		},
		-- Throne of Thunder C
		["ThroneofThunderC"] = {
			BZ["Watcher's Sanctum"],
			BZ["Halls of Flesh-Shaping"],
			BZ["Saurok Creation Pit"],
			BZ["Sewer Access Point"],
		},
		-- Throne of Thunder D
		["ThroneofThunderD"] = {
			BZ["Grand Courtyard"],
			BZ["Hall of Kings"],
			BZ["Celestial Enclave"],
			BZ["Lightning Ascent"],
			BZ["Pinnacle of Storms"],
			BZ["Hidden Cell"],
		},
	},
	-- Ulduar
	[BZ["Ulduar"]] = {
		-- Ulduar, The Siege
		["UlduarA"] = {
			BZ["Expedition Base Camp"],
			BZ["Iron Concourse"],
			BZ["Formation Grounds"],
			BZ["Razorscale's Aerie"],
			BZ["The Colossal Forge"],
			BZ["The Scrapyard"],
		},
		-- Ulduar, The Antechamber
		["UlduarB"] = {
			BZ["The Antechamber"],
			BZ["The Assembly of Iron"],
			BZ["The Archivum"],
			BZ["The Celestial Planetarium"],
			BZ["The Shattered Walkway"],
		},
		-- Ulduar, The Keepers
		["UlduarC"] = {
			BZ["The Observation Ring"],
			BZ["The Halls of Winter"],
			BZ["The Clash of Thunder"],
			BZ["The Conservatory of Life"],
			BZ["The Corridors of Ingenuity"],
			BZ["Hall of Memories"],
		},
		-- Ulduar, Spark of Imagination
		["UlduarD"] = {
			BZ["The LMS Mark II"],
			BZ["The Spark of Imagination"],
		},
		-- Ulduar, Descent into Madness
		["UlduarE"] = {
			BZ["The Descent into Madness"],
			BZ["The Prison of Yogg-Saron"],
			BZ["The Mind's Eye"],
		},
	},
	-- Wailing Caverns
	[BZ["Wailing Caverns"]] = {
		-- Wailing Caverns, Entrance
		["WailingCavernsEnt"] = {
			BZ["Cavern of Mists"],
		},
		-- Wailing Caverns
		["WailingCaverns"] = {
			BZ["Screaming Gully"],
			BZ["Dreamer's Rock"],
			BZ["Pit of Fangs"],
			BZ["Crag of the Everliving"],
			BZ["Pit of Fangs"],
		},
	},
	-- /////////////////////////////////////////////
	-- Legion instances
	-- /////////////////////////////////////////////
	[BZ["Black Rook Hold"]] = {
		["BlackRookHoldA"] = {
			BZ["The Ravenscrypt"],
			BZ["The Grand Sepulcher"],
			BZ["The Mausoleum of Lady Velandras"],
			BZ["The Mausoleum of Lord Etheldrin"],
			BZ["The Chamber of War"],
			BZ["Hidden Passageway"],
		},
		["BlackRookHoldB"] = {
			BZ["The Grand Hall"],
			BZ["Ravenswatch"],
			BZ["Ravenshold"],
			BZ["Rook's Rise"],
			BZ["Lord Ravencrest's Chamber"],
		},
		["BlackRookHoldC"] = {
			BZ["The Rook's Roost"],
			BZ["The Raven's Crown"],
		},
	},
	[BZ["Court of Stars"]] = {
		["CourtofStarsA"] = {
			BZ["Moonlit Landing"],
			BZ["Midnight Court"],
			BZ["The Gilded Market"],
		},
		["CourtofStarsB"] = {
			BZ["The Jeweled Estate"],
		},
	},
	[BZ["Halls of Valor"]] = {
		["HallsofValorA"] = {
			BZ["The High Gate"],
			BZ["Hearth of Revelry"],
			BZ["Seat of Ascension"],
			BZ["The Ephemeral Way"],
		},
		["HallsofValorB"] = {
			BZ["Fields of the Eternal Hunt"],
		},
		["HallsofValorC"] = {
			BZ["Hall of Glory"],
			BZ["Halls of Valor"],
		},
	},
	[BZ["Maw of Souls"]] = {
		["MawofSoulsA"] = {
			BZ["Helmouth Cliffs"],
		},
		["MawofSoulsB"] = {
			BZ["The Naglfar"],
		},
	},
	[BZ["The Emerald Nightmare"]] = {
		["TheEmeraldNightmareA"] = {
			BZ["Clutch of Corruption"],
		},
		["TheEmeraldNightmareB"] = {
			BZ["Core of the Nightmare"],
		},
		["TheEmeraldNightmareC"] = {
			BZ["Un'goro Crater"],
		},
		["TheEmeraldNightmareD"] = {
			BZ["Mulgore"],
		},
		["TheEmeraldNightmareE"] = {
			BZ["Grizzly Hills"],
		},
		["TheEmeraldNightmareF"] = {
			BZ["The Emerald Dreamway"],
		},
		["TheEmeraldNightmareG"] = {
			BZ["Moonglade"],
		},
--[[
		["TheEmeraldNightmareH"] = {
			BZ["Rift of Aln"],
		},
]]
			-- BZ["The Emerald Dream"],
			-- BZ["Bough Shadow"],
			-- BZ["Seradane"],
			-- BZ["Twilight Grove"],
			-- BZ["Dream Bough"],
	},
	[BZ["The Nighthold"]] = {
		-- Skorpyron
		["TheNightholdA"] = {
			BZ["Arcing Depths"],
			BZ["Crystal Breach"],
		},
		-- Chronomatic Anomaly, Trilliax
		["TheNightholdB"] = {
			BZ["The Nightwell"],
		},
		-- Spellblade Aluriel, Krosus, High Botanist Tel'arn
		["TheNightholdC"] = {
			BZ["Shal'dorei Terrace"],
			BZ["The Shattered Walkway"],
		},
		-- Tichondrius
		["TheNightholdD"] = {
			BZ["Captain's Quarters"],
		},
		-- Star Augur Etraeus
		["TheNightholdE"] = {
			BZ["Astromancer's Rise"],
			BZ["Eternal Observatory"],
		},
		-- Grand Magistrix Elisande
		["TheNightholdF"] = {
			BZ["Elisande's Reach"],
			BZ["Elisande's Secret Quarters"],
			BZ["The Nightspire"], -- upper floor
		},
		-- Gul'dan
--[[
		["TheNightholdG"] = {
		},
]]
			-- BZ["The Font of Night"],
	},
	[BZ["Vault of the Wardens"]] = {
		["VaultoftheWardensA"] = {
			BZ["Chamber of Night"],
			BZ["The Warden's Court"],
		},
		["VaultoftheWardensB"] = {
			BZ["The Demon Ward"],
			BZ["Vault of Law"], -- though we did not show this room as there is nothing
			BZ["Fallen Passage"],
			BZ["Vault of Mirrors"],
			BZ["Vault of Ice"],
		},
		["VaultoftheWardensC"] = {
			BZ["Tomb of the Penitent"],
			BZ["Vault of the Betrayer"],
		},
	},
};

--[[
	Atlas_OutdoorZoneToAtlas{}

	Maps to auto-select to from outdoor zones.

	Table index is sub-zone name, it need to be localized value, but we will handle
	the localization with BabbleSubZone library.
	The table value is map's key-name.

	Duplicates are commented out.
	Not for localization.
]]
Atlas_OutdoorZoneToAtlas = {
	[BZ["Talador"]] =	 		"Auchindoun";
	[BZ["Terokkar Forest"]] = 		"AuchindounEnt";
	[BZ["Tol Barad"]] = 			"BaradinHold";
	[BZ["Ashenvale"]] = 			"BlackfathomDeepsEnt";
	[BZ["Gorgrond"]] =	 		"BlackrockFoundryA";
	[BZ["Burning Steppes"]] = 		"BlackrockMountainEnt";
	[BZ["Searing Gorge"]] = 		"BlackrockMountainEnt";
	[BZ["Shadowmoon Valley"]] = 		"BlackTempleStart";
	[BZ["Frostfire Ridge"]] =	 	"BloodmaulSlagMines";
	[BZ["Tanaris"]] = 			"CavernsOfTimeEnt";
	[BZ["Zangarmarsh"]] = 			"CoilfangReservoirEnt";
	[BZ["The Dragon Wastes"]] = 		"CoTDragonSoulA";
	[BZ["Feralas"]] = 			"DireMaulEnt";
	[BZ["Mount Hyjal"]] = 			"Firelands";
	[BZ["Dun Morogh"]] = 			"GnomereganEnt";
	[BZ["Blade's Edge Mountains"]] = 	"GruulsLair";
	[BZ["Dread Wastes"]] =			"HeartofFear";
	[BZ["Tanaan Jungle"]] = 		"HellfireA";
	[BZ["Hellfire Peninsula"]] = 		"HellfireCitadelEnt";
	[BZ["Nagrand"]] =		 	"HighmaulA";
	[BZ["Icecrown"]] = 			"IcecrownEnt";
	[BZ["Deadwind Pass"]] = 		"KarazhanEnt";
	[BZ["Desolace"]] = 			"MaraudonEnt";
	[BZ["Kun-Lai Summit"]] = 		"MoguShanVaults";
	[BZ["Orgrimmar"]] = 			"RagefireChasm";
	[BZ["Thousand Needles"]] = 		"RazorfenDowns";
	[BZ["Southern Barrens"]] = 		"RazorfenKraul";
	[BZ["Dragonblight"]] = 			"RubySanctum";
	[BZ["Tirisfal Glades"]] = 		"ScarletMonasteryEnt";
	[BZ["Western Plaguelands"]] = 		"Scholomance";
	[BZ["Silverpine Forest"]] = 		"ShadowfangKeep";
	[BZ["Townlong Steppes"]] = 		"SiegeofNiuzaoTempleA";
	[BZ["Vale of Eternal Blossoms"]] = 	"SiegeofOrgrimmarA";
	[BZ["Spires of Arak"]] =	 	"Skyreach";
	[BZ["Valley of the Four Winds"]] = 	"StormstoutBrewery";
	[BZ["Eastern Plaguelands"]] = 		"StratholmeGauntlet";
	[BZ["Isle of Quel'Danas"]] = 		"SunwellPlateau";
	[BZ["Netherstorm"]] = 			"TempestKeepEnt";
	[BZ["The Jade Forest"]] = 		"TempleOfTheJadeSerpent";
	[BZ["The Veiled Stair"]] = 		"TerraceofEndlessSpring";
	[BZ["Twilight Highlands"]] = 		"TheBastionOfTwilight";
	[BZ["Westfall"]] = 			"TheDeadminesEnt";
	[BZ["Borean Tundra"]] = 		"TheEyeOfEternity";
	[BZ["Stormwind City"]] = 		"TheStockade";
	[BZ["Deepholm"]] = 			"TheStonecore";
	[BZ["Swamp of Sorrows"]] = 		"TheSunkenTempleEnt";
	[BZ["Ahn'Qiraj: The Fallen Kingdom"]] = "TheTempleofAhnQiraj";
	[BZ["Silithus"]] = 			"TheTempleofAhnQiraj";
	[BZ["Uldum"]] = 			"ThroneOfTheFourWinds";
	[BZ["Abyssal Depths"]] = 		"ThroneOfTheTides";
	[BZ["Abyssal Breach"]] = 		"ThroneOfTheTides";
	[BZ["Isle of Thunder"]] = 		"ThroneofThunderA";
	[BZ["Badlands"]] = 			"UldamanEnt";
	[BZ["The Storm Peaks"]] = 		"UlduarEnt";
	[BZ["Dalaran"]] = 			"VioletHold";
	[BZ["Northern Barrens"]] = 		"WailingCavernsEnt";
	[BZ["Ghostlands"]] = 			"ZulAman";
	[BZ["Northern Stranglethorn"]] = 	"ZulGurub";
-- Legion
	[BZ["Dalaran"]] = 			"AssaultonVioletHold";
	[BZ["Azsuna"]] = 			"VaultoftheWardensA";
	[BZ["Val'sharah"]] = 			"BlackRookHoldA";
	[BZ["Highmountain"]] = 			"NeltharionsLair";
	[BZ["Stormheim"]] = 			"HallsofValorA";
	[BZ["Suramar"]] = 			"TheNightholdA";
};

-- Yes, the following two tables are redundant, but they're both here in case there's ever more than one entrance map for an instance
-- Entrance maps to instance maps
Atlas_EntToInstMatches = {
	["AuchindounEnt"] =			{"AuchManaTombs","AuchAuchenaiCrypts","AuchSethekkHalls","AuchShadowLabyrinth"};
	["BlackfathomDeepsEnt"] =		{"BlackfathomDeeps"};
	["BlackrockMountainEnt"] =		{"BlackrockCaverns","BlackrockDepths","BlackwingDescent","BlackwingLair","LowerBlackrockSpire","MoltenCore","UpperBlackrockSpire"};
	["CoilfangReservoirEnt"] =		{"CFRTheSlavePens","CFRTheUnderbog","CFRTheSteamvault","CFRSerpentshrineCavern"};
	["CavernsOfTimeEnt"] =			{"CoTBlackMorass","CoTDragonSoulA","CoTDragonSoulB","CoTDragonSoulC","CoTEndTime","CoTHyjal","CoTHyjalEnt","CoTHourOfTwilight","CoTOldHillsbrad","CoTOldStratholme","CoTWellOfEternity"};
	["DireMaulEnt"] =			{"DireMaulEast","DireMaulNorth","DireMaulWest"};
	["GnomereganEnt"] =			{"Gnomeregan"};
	["HellfireCitadelEnt"] = 		{"HCBloodFurnace", "HCHellfireRamparts", "HCMagtheridonsLair", "HCTheShatteredHalls"};
	["IcecrownEnt"] =			{"FHHallsOfReflection", "FHPitOfSaron", "FHTheForgeOfSouls", "IcecrownCitadelA", "IcecrownCitadelB", "IcecrownCitadelC"};
	["KarazhanEnt"] =			{"KarazhanStart","KarazhanEnd"};
	["MaraudonEnt"] =			{"Maraudon"};
	["ScarletMonasteryEnt"] =		{"ScarletHalls","ScarletMonastery"};
	["TempestKeepEnt"] = 			{"TempestKeepArcatraz", "TempestKeepBotanica", "TempestKeepMechanar", "TempestKeepTheEye"};
	["TheDeadminesEnt"] =			{"TheDeadmines"};
	["TheSunkenTempleEnt"] =		{"TheSunkenTemple"};
	["UldamanEnt"] =			{"Uldaman"};
	["UlduarEnt"] = 			{"UlduarHallsofStone", "UlduarHallsofLightning", "UlduarA", "UlduarB", "UlduarC", "UlduarD", "UlduarE"};
	["WailingCavernsEnt"] =			{"WailingCaverns"};
};

-- Instance maps to entrance maps
Atlas_InstToEntMatches = {
	["AuchManaTombs"] =			{"AuchindounEnt"};
	["AuchAuchenaiCrypts"] =		{"AuchindounEnt"};
	["AuchSethekkHalls"] =			{"AuchindounEnt"};
	["AuchShadowLabyrinth"] =		{"AuchindounEnt"};
	["BlackfathomDeeps"] =			{"BlackfathomDeepsEnt"};
	["BlackrockCaverns"] =			{"BlackrockMountainEnt"};
	["BlackrockDepths"] =			{"BlackrockMountainEnt"};
	["BlackwingDescent"] =			{"BlackrockMountainEnt"};
	["BlackwingLair"] =			{"BlackrockMountainEnt"};
	["LowerBlackrockSpire"] =		{"BlackrockMountainEnt"};
	["MoltenCore"] =			{"BlackrockMountainEnt"};
	["UpperBlackrockSpire"] =		{"BlackrockMountainEnt"};
	["CFRTheSlavePens"] =			{"CoilfangReservoirEnt"};
	["CFRTheUnderbog"] =			{"CoilfangReservoirEnt"};
	["CFRTheSteamvault"] =			{"CoilfangReservoirEnt"};
	["CFRSerpentshrineCavern"] =		{"CoilfangReservoirEnt"};
	["CoTBlackMorass"] =			{"CavernsOfTimeEnt"};
	["CoTDragonSoulA"] =			{"CavernsOfTimeEnt"};
	["CoTDragonSoulB"] =			{"CavernsOfTimeEnt"};
	["CoTDragonSoulC"] =			{"CavernsOfTimeEnt"};
	["CoTEndTime"] =			{"CavernsOfTimeEnt"};
	["CoTHyjal"] =				{"CavernsOfTimeEnt"};
	["CoTHyjalEnt"] =			{"CavernsOfTimeEnt"};
	["CoTHourOfTwilight"] =			{"CavernsOfTimeEnt"};
	["CoTOldHillsbrad"] =			{"CavernsOfTimeEnt"};
	["CoTOldStratholme"] =			{"CavernsOfTimeEnt"};
	["CoTWellOfEternity"] =			{"CavernsOfTimeEnt"};
	["DireMaulEast"] =			{"DireMaulEnt"};
	["DireMaulNorth"] =			{"DireMaulEnt"};
	["DireMaulWest"] =			{"DireMaulEnt"};
	["Gnomeregan"] =			{"GnomereganEnt"};
	["HCBloodFurnace"] = 			{"HellfireCitadelEnt"};
	["HCHellfireRamparts"] = 		{"HellfireCitadelEnt"};
	["HCMagtheridonsLair"] = 		{"HellfireCitadelEnt"};
	["HCTheShatteredHalls"] = 		{"HellfireCitadelEnt"};
	["FHHallsOfReflection"] =		{"IcecrownEnt"};
	["FHPitOfSaron"] =			{"IcecrownEnt"};
	["FHTheForgeOfSouls"] =			{"IcecrownEnt"};
	["IcecrownCitadelA"] =			{"IcecrownEnt"};
	["IcecrownCitadelB"] =			{"IcecrownEnt"};
	["IcecrownCitadelC"] =			{"IcecrownEnt"};
	["KarazhanStart"] =			{"KarazhanEnt"};
	["KarazhanEnd"] =			{"KarazhanEnt"};
	["Maraudon"] =				{"MaraudonEnt"};
	["ScarletHalls"] =			{"ScarletMonasteryEnt"};
	["ScarletMonastery"] =			{"ScarletMonasteryEnt"};
	["TempestKeepArcatraz"] = 		{"TempestKeepEnt"};
	["TempestKeepBotanica"] = 		{"TempestKeepEnt"}; 
	["TempestKeepMechanar"] = 		{"TempestKeepEnt"}; 
	["TempestKeepTheEye"] = 		{"TempestKeepEnt"};
	["TheDeadmines"] =			{"TheDeadminesEnt"};
	["TheSunkenTemple"] =			{"TheSunkenTempleEnt"};
	["Uldaman"] =				{"UldamanEnt"};
	["UlduarHallsofStone"] = 		{"UlduarEnt"}; 
	["UlduarHallsofLightning"] = 		{"UlduarEnt"};
	["UlduarA"] = 				{"UlduarEnt"};
	["UlduarB"] = 				{"UlduarEnt"};
	["UlduarC"] = 				{"UlduarEnt"};
	["UlduarD"] = 				{"UlduarEnt"};
	["UlduarE"] = 				{"UlduarEnt"};
	["WailingCaverns"] =			{"WailingCavernsEnt"};
};

-- Defines the instance which have multiple maps
-- Added only when the Entrance map is not available, for example, Ulduar do have entrance map, so no need to add it here
Atlas_MapSeries = {
	["BlackrockFoundryA"] = 		{"BlackrockFoundryA", "BlackrockFoundryB" };
	["BlackrockFoundryB"] = 		{"BlackrockFoundryA", "BlackrockFoundryB" };
	["BlackTempleStart"] = 			{"BlackTempleStart", "BlackTempleBasement", "BlackTempleTop" };
	["BlackTempleBasement"] = 		{"BlackTempleStart", "BlackTempleBasement", "BlackTempleTop" };
	["BlackTempleTop"] = 			{"BlackTempleStart", "BlackTempleBasement", "BlackTempleTop" };
	["HellfireA"] = 			{"HellfireA", "HellfireB", "HellfireC", "HellfireD", "HellfireE", "HellfireF" };
	["HellfireB"] = 			{"HellfireA", "HellfireB", "HellfireC", "HellfireD", "HellfireE", "HellfireF" };
	["HellfireC"] = 			{"HellfireA", "HellfireB", "HellfireC", "HellfireD", "HellfireE", "HellfireF" };
	["HellfireD"] = 			{"HellfireA", "HellfireB", "HellfireC", "HellfireD", "HellfireE", "HellfireF" };
	["HellfireE"] = 			{"HellfireA", "HellfireB", "HellfireC", "HellfireD", "HellfireE", "HellfireF" };
	["HellfireF"] = 			{"HellfireA", "HellfireB", "HellfireC", "HellfireD", "HellfireE", "HellfireF" };
	["HighmaulA"] = 			{"HighmaulA", "HighmaulB" };
	["HighmaulB"] = 			{"HighmaulA", "HighmaulB" };
	["ShadoPanMonasteryA"] = 		{"ShadoPanMonasteryA", "ShadoPanMonasteryB" };
	["ShadoPanMonasteryB"] = 		{"ShadoPanMonasteryA", "ShadoPanMonasteryB" };
	["SiegeofNiuzaoTempleA"] = 		{"SiegeofNiuzaoTempleA", "SiegeofNiuzaoTempleB" };
	["SiegeofNiuzaoTempleB"] = 		{"SiegeofNiuzaoTempleA", "SiegeofNiuzaoTempleB" };
	["SiegeofOrgrimmarA"] = 		{"SiegeofOrgrimmarA", "SiegeofOrgrimmarB", "SiegeofOrgrimmarC", "SiegeofOrgrimmarD" };
	["SiegeofOrgrimmarB"] = 		{"SiegeofOrgrimmarA", "SiegeofOrgrimmarB", "SiegeofOrgrimmarC", "SiegeofOrgrimmarD" };
	["SiegeofOrgrimmarC"] = 		{"SiegeofOrgrimmarA", "SiegeofOrgrimmarB", "SiegeofOrgrimmarC", "SiegeofOrgrimmarD" };
	["SiegeofOrgrimmarD"] = 		{"SiegeofOrgrimmarA", "SiegeofOrgrimmarB", "SiegeofOrgrimmarC", "SiegeofOrgrimmarD" };
	["TheEverbloomA"] = 			{"TheEverbloomA", "TheEverbloomB" };
	["TheEverbloomB"] = 			{"TheEverbloomA", "TheEverbloomB" };
	["ThroneofThunderA"] = 			{"ThroneofThunderA", "ThroneofThunderB", "ThroneofThunderC", "ThroneofThunderD" };
	["ThroneofThunderB"] = 			{"ThroneofThunderA", "ThroneofThunderB", "ThroneofThunderC", "ThroneofThunderD" };
	["ThroneofThunderC"] = 			{"ThroneofThunderA", "ThroneofThunderB", "ThroneofThunderC", "ThroneofThunderD" };
	["ThroneofThunderD"] = 			{"ThroneofThunderA", "ThroneofThunderB", "ThroneofThunderC", "ThroneofThunderD" };
	-- Legion
	["BlackRookHoldA"] = 			{"BlackRookHoldA", "BlackRookHoldB", "BlackRookHoldC" };
	["BlackRookHoldB"] = 			{"BlackRookHoldA", "BlackRookHoldB", "BlackRookHoldC" };
	["BlackRookHoldC"] = 			{"BlackRookHoldA", "BlackRookHoldB", "BlackRookHoldC" };
	["CourtofStarsA"] = 			{"CourtofStarsA", "CourtofStarsB" };
	["CourtofStarsB"] = 			{"CourtofStarsA", "CourtofStarsB" };
	["HallsofValorA"] = 			{"HallsofValorA", "HallsofValorB", "HallsofValorC" };
	["HallsofValorB"] = 			{"HallsofValorA", "HallsofValorB", "HallsofValorC" };
	["HallsofValorC"] = 			{"HallsofValorA", "HallsofValorB", "HallsofValorC" };
	["MawofSoulsA"] = 			{"MawofSoulsA", "MawofSoulsB" };
	["MawofSoulsB"] = 			{"MawofSoulsA", "MawofSoulsB" };
	["TheEmeraldNightmareA"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG"--[[, "TheEmeraldNightmareH"]] };
	["TheEmeraldNightmareB"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG"--[[, "TheEmeraldNightmareH"]] };
	["TheEmeraldNightmareC"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG"--[[, "TheEmeraldNightmareH"]] };
	["TheEmeraldNightmareD"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG"--[[, "TheEmeraldNightmareH"]] };
	["TheEmeraldNightmareE"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG"--[[, "TheEmeraldNightmareH"]] };
	["TheEmeraldNightmareF"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG"--[[, "TheEmeraldNightmareH"]] };
	["TheEmeraldNightmareG"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG"--[[, "TheEmeraldNightmareH"]] };
-- 	["TheEmeraldNightmareH"] = 		{"TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" };
	["TheNightholdA"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF"--[[, "TheNightholdG"]] };
	["TheNightholdB"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF"--[[, "TheNightholdG"]] };
	["TheNightholdC"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF"--[[, "TheNightholdG"]] };
	["TheNightholdD"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF"--[[, "TheNightholdG"]] };
	["TheNightholdE"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF"--[[, "TheNightholdG"]] };
	["TheNightholdF"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF"--[[, "TheNightholdG"]] };
-- 	["TheNightholdG"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightholdG" };
	["VaultoftheWardensA"] = 		{"VaultoftheWardensA", "VaultoftheWardensB", "VaultoftheWardensC" };
	["VaultoftheWardensB"] = 		{"VaultoftheWardensA", "VaultoftheWardensB", "VaultoftheWardensC" };
	["VaultoftheWardensC"] = 		{"VaultoftheWardensA", "VaultoftheWardensB", "VaultoftheWardensC" };
};

-- Links maps together that are part of the same instance
Atlas_SubZoneAssoc = {
	["BlackrockFoundryA"] =			BZ["Blackrock Foundry"];
	["BlackrockFoundryB"] =			BZ["Blackrock Foundry"];
	["BlackTempleStart"] =			BZ["Black Temple"];
	["BlackTempleBasement"] =		BZ["Black Temple"];
	["BlackTempleTop"] =			BZ["Black Temple"];
	["CoTDragonSoulA"] =			BZ["Dragon Soul"];
	["CoTDragonSoulB"] =			BZ["Dragon Soul"];
	["CoTDragonSoulC"] =			BZ["Dragon Soul"];
	["DireMaulNorth"] =			BZ["Dire Maul"];
	["DireMaulEast"] =			BZ["Dire Maul"];
	["DireMaulWest"] =			BZ["Dire Maul"];
	["DireMaulEnt"] =			BZ["Dire Maul"];
	["HellfireA"] = 			BZ["Hellfire Citadel"];
	["HellfireB"] = 			BZ["Hellfire Citadel"];
	["HellfireC"] = 			BZ["Hellfire Citadel"];
	["HellfireD"] = 			BZ["Hellfire Citadel"];
	["HellfireE"] = 			BZ["Hellfire Citadel"];
	["HellfireF"] = 			BZ["Hellfire Citadel"];
	["HighmaulA"] =				BZ["Highmaul"];
	["HighmaulB"] =				BZ["Highmaul"];
	["IcecrownCitadelA"] =			BZ["Icecrown Citadel"];
	["IcecrownCitadelB"] =			BZ["Icecrown Citadel"];
	["IcecrownCitadelC"] =			BZ["Icecrown Citadel"];
	["IcecrownEnt"] =			BZ["Icecrown Citadel"];
	["KarazhanStart"] =			BZ["Karazhan"];
	["KarazhanEnd"] =			BZ["Karazhan"];
	["KarazhanEnt"] =			BZ["Karazhan"];
	["ShadoPanMonasteryA"] =		BZ["Shado-Pan Monastery"];
	["ShadoPanMonasteryB"] =		BZ["Shado-Pan Monastery"];
	["SiegeofNiuzaoTempleA"] =		BZ["Siege of Niuzao Temple"];
	["SiegeofNiuzaoTempleB"] =		BZ["Siege of Niuzao Temple"];
	["SiegeofOrgrimmarA"] =			BZ["Siege of Orgrimmar"];
	["SiegeofOrgrimmarB"] =			BZ["Siege of Orgrimmar"];
	["SiegeofOrgrimmarC"] =			BZ["Siege of Orgrimmar"];
	["SiegeofOrgrimmarD"] =			BZ["Siege of Orgrimmar"];
	["StratholmeCrusader"] =		BZ["Stratholme"];
	["StratholmeGauntlet"] =		BZ["Stratholme"];
	["TheEverbloomA"] =			BZ["The Everbloom"];
	["TheEverbloomB"] =			BZ["The Everbloom"];
	["ThroneofThunderA"] =			BZ["Throne of Thunder"];
	["ThroneofThunderB"] =			BZ["Throne of Thunder"];
	["ThroneofThunderC"] =			BZ["Throne of Thunder"];
	["ThroneofThunderD"] =			BZ["Throne of Thunder"];
	["UlduarA"] =				BZ["Ulduar"];
	["UlduarB"] =				BZ["Ulduar"];
	["UlduarC"] =				BZ["Ulduar"];
	["UlduarD"] =				BZ["Ulduar"];
	["UlduarE"] =				BZ["Ulduar"];
	-- Legion
	["BlackRookHoldA"] = 			BZ["Black Rook Hold"];
	["BlackRookHoldB"] = 			BZ["Black Rook Hold"];
	["BlackRookHoldC"] = 			BZ["Black Rook Hold"];
	["CourtofStarsA"] = 			BZ["Court of Stars"];
	["CourtofStarsB"] = 			BZ["Court of Stars"];
	["HallsofValorA"] = 			BZ["Halls of Valor"];
	["HallsofValorB"] = 			BZ["Halls of Valor"];
	["HallsofValorC"] = 			BZ["Halls of Valor"];
	["MawofSoulsA"] = 			BZ["Maw of Souls"];
	["MawofSoulsB"] = 			BZ["Maw of Souls"];
	["TheEmeraldNightmareA"] = 		BZ["The Emerald Nightmare"];
	["TheEmeraldNightmareB"] = 		BZ["The Emerald Nightmare"];
	["TheEmeraldNightmareC"] = 		BZ["The Emerald Nightmare"];
	["TheEmeraldNightmareD"] = 		BZ["The Emerald Nightmare"];
	["TheEmeraldNightmareE"] = 		BZ["The Emerald Nightmare"];
	["TheEmeraldNightmareF"] = 		BZ["The Emerald Nightmare"];
	["TheEmeraldNightmareG"] = 		BZ["The Emerald Nightmare"];
	["TheEmeraldNightmareH"] = 		BZ["The Emerald Nightmare"];
	["TheNightholdA"] = 			BZ["The Nighthold"];
	["TheNightholdB"] = 			BZ["The Nighthold"];
	["TheNightholdC"] = 			BZ["The Nighthold"];
	["TheNightholdD"] = 			BZ["The Nighthold"];
	["TheNightholdE"] = 			BZ["The Nighthold"];
	["TheNightholdF"] = 			BZ["The Nighthold"];
-- 	["TheNightholdG"] = 			BZ["The Nighthold"];
	["VaultoftheWardensA"] = 		BZ["Vault of the Wardens"];
	["VaultoftheWardensB"] = 		BZ["Vault of the Wardens"];
	["VaultoftheWardensC"] = 		BZ["Vault of the Wardens"];
};
