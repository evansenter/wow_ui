
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillInfo")
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

TradeskillInfo.vars.tradeskillspells = {
	['A'] = 2259,  -- Alchemy
	['B'] = 2018,  -- Blacksmithing
	['D'] = 7411,  -- Enchanting
	['E'] = 4036,  -- Engineering
	['J'] = 25229, -- Jewelcrafting
	['L'] = 2108,  -- Leatherworking
	['T'] = 3908,  -- Tailoring
	['W'] = 2550,  -- Cooking
	['X'] = 3273,  -- First Aid
	['Y'] = 2575,  -- Mining
	['I'] = 45357, -- Inscription
}

TradeskillInfo.vars.specializationspells = {
	['g']  = 20219,  -- Gnomish Engineer
	['b']  = 20222,  -- Goblin Engineer
	['cg'] = 124694, -- Way of the Grill
	['cw'] = 125584, -- Way of the Wok
	['cp'] = 125586, -- Way of the Pot
	['cs'] = 125587, -- Way of the Steamer
	['co'] = 125588, -- Way of the Oven
	['cb'] = 125589, -- Way of the Brew
}

TradeskillInfo.vars.sources = {
	['V'] = L["Vendor"],
	['Va'] = L["Alliance Vendor"],
	['Vh'] = L["Horde Vendor"],
	['D'] = L["Dropped"],
	['Da'] = L["Dropped for Alliance"],
	['Dh'] = L["Dropped for Horde"],
	['C'] = L["Crafted"],
	['Ca'] = L["Alchemy"],
	['Cb'] = L["Blacksmithing"],
	['Cn'] = L["Enchanting"],
	['Ce'] = L["Engineering"],
	['Cj'] = L["Jewelcrafting"],
	['Cl'] = L["Leatherworking"],
	['Ct'] = L["Tailoring"],
	['Cc'] = L["Cooking"],
	['Cf'] = L["First Aid"],
	['Cs'] = L["Smelting"],
	['M'] = L["Mining"],
	['H'] = L["Herbalism"],
	['S'] = L["Skinning"],
	['F'] = L["Fishing"],
	['E'] = L["Disenchant"],
	['G'] = L["Gathered"],
	['P'] = L["Pick Pocket"],
	['Q'] = L["Quest"],
	['Qa'] = L["Alliance Quest"],
	['Qh'] = L["Horde Quest"],
	['T'] = L["Trainer"],
	['Ts'] = L["Specialist Trainer"],
	['X'] = L["Not Currently Obtainable"],
	['R'] = L["Prospecting"],
	['U'] = L["Unknown"],
	-- New in 3.0.2
	['I'] = L["Milling"],
	['Ci'] = L["Inscription"],
}

TradeskillInfo.vars.zones = {
	[1] = BZ["Alterac Mountains"],
	[2] = BZ["Arathi Highlands"],
	[3] = BZ["Ashenvale"],
	[4] = BZ["Azshara"],
	[5] = BZ["Badlands"],
	[6] = BZ["Blackrock Depths"],
	[7] = BZ["Blasted Lands"],
	[8] = BZ["Burning Steppes"],
	[9] = BZ["Darkshore"],
	[10] = BZ["Darnassus"],
	[11] = BZ["Desolace"],
	[12] = BZ["Dire Maul"],
	[13] = BZ["Dun Morogh"],
	[14] = BZ["Durotar"],
	[15] = BZ["Duskwood"],
	[16] = BZ["Dustwallow Marsh"],
	[17] = BZ["Eastern Plaguelands"],
	[18] = BZ["Elwynn Forest"],
	[19] = BZ["Felwood"],
	[20] = BZ["Feralas"],
	[21] = BZ["Gnomeregan"],
	[22] = BZ["Hillsbrad Foothills"],
	[23] = BZ["Ironforge"],
	[24] = BZ["Loch Modan"],
	[25] = BZ["Moonglade"],
	[26] = BZ["Mulgore"],
	[27] = BZ["Naxxramas"],
	[28] = BZ["Orgrimmar"],
	[29] = BZ["Redridge Mountains"],
	[30] = BZ["Ruins of Ahn'Qiraj"],
	[31] = BZ["Silithus"],
	[32] = BZ["Silverpine Forest"],
	[33] = BZ["Stonetalon Mountains"],
	[34] = BZ["Stormwind City"],
	[35] = BZ["Stranglethorn Vale"],
	[36] = BZ["Swamp of Sorrows"],
	[37] = BZ["Tanaris"],
	[38] = BZ["Teldrassil"],
	[39] = BZ["The Barrens"],
	[40] = BZ["The Hinterlands"],
	[41] = BZ["Thousand Needles"],
	[42] = BZ["Thunder Bluff"],
	[43] = BZ["Tirisfal Glades"],
	[44] = BZ["Un'Goro Crater"],
	[45] = BZ["Undercity"],
	[46] = BZ["Wailing Caverns"],
	[47] = BZ["Western Plaguelands"],
	[48] = BZ["Westfall"],
	[49] = BZ["Wetlands"],
	[50] = BZ["Winterspring"],
	[51] = BZ["Stratholme"],
	[52] = BZ["Scholomance"],
-- Burning Crusade
	[53] = BZ["Hellfire Peninsula"],
	[54] = BZ["Eversong Woods"],
	[55] = BZ["Silvermoon City"],
	[56] = BZ["Karazhan"],
	[57] = BZ["Azuremyst Isle"],
	[58] = BZ["The Exodar"],
	[59] = BZ["Blade's Edge Mountains"],
	[60] = BZ["Shattrath City"],
	[61] = BZ["Netherstorm"],
	[62] = BZ["Ghostlands"],
	[63] = BZ["Old Hillsbrad Foothills"],
	[64] = BZ["Bloodmyst Isle"],
	[65] = BZ["Shadowmoon Valley"],
	[66] = BZ["Terokkar Forest"],
	[67] = BZ["Zangarmarsh"],
	[68] = BZ["Deadwind Pass"],
	[69] = BZ["Nagrand"],
	[70] = BZ["Black Temple"],
	[71] = BZ["Hyjal Summit"],
	[72] = BZ["Isle of Quel'Danas"],
-- WotLK
	[73] = BZ["Dalaran"],
	[74] = BZ["Borean Tundra"],
	[75] = BZ["Howling Fjord"],
	[76] = BZ["Sholazar Basin"],
	[77] = BZ["Icecrown"],
	[78] = BZ["Dragonblight"],
	[79] = BZ["The Storm Peaks"],
	[80] = BZ["Wintergrasp"],
	[81] = BZ["Icecrown Citadel"],
-- Cata 4.2
	[82] = BZ["Molten Front"],
	[83] = BZ["Firelands"],
-- Cata 4.3
	[84] = BZ["Dragon Soul"],
}

TradeskillInfo.vars.factions = {
	[1] = FACTION_ALLIANCE,
	[2] = FACTION_HORDE,
	[3] = "",
	[4] = BF["Argent Dawn"],
	[5] = BF["Cenarion Circle"],
	[6] = BF["Thorium Brotherhood"],
	[7] = BF["Timbermaw Hold"],
	[8] = BF["Zandalar Tribe"],
-- Burning Crusade
	[9] = BF["Keepers of Time"],
	[10] = BF["The Scale of the Sands"],
	[11] = BF["The Violet Eye"],
	[12] = BF["Cenarion Expedition"],
	[13] = BF["Sporeggar"],
	[14] = BF["Thrallmar"],
	[15] = BF["Honor Hold"],
	[16] = BF["The Mag'har"],
	[17] = BF["Kurenai"],
	[18] = BF["The Consortium"],
	[19] = BF["The Scryers"],
	[20] = BF["The Aldor"],
	[21] = BF["The Sha'tar"],
	[22] = BF["Lower City"],
	[23] = BF["Ashtongue Deathsworn"],
	[24] = BF["Shattered Sun Offensive"],
-- WotLK
	[25] = BF["Kirin Tor"],
	[26] = BF["The Sunreavers"],
	[27] = BF["Warsong Offensive"],
	[28] = BF["Valiance Expedition"],
	[29] = BF["Frenzyheart Tribe"],
	[30] = BF["Knights of the Ebon Blade"],
	[31] = BF["The Oracles"],
	[32] = BF["The Kalu'ak"],
	[33] = BF["The Sons of Hodir"],
	[34] = BF["The Wyrmrest Accord"],
	[35] = BF["Argent Crusade"],
	[36] = BF["The Ashen Verdict"],
-- Cata 4.2
	[37] = BF["Guardians of Hyjal"],
}
-- Kurenai / The Mag'har
-- Honor Hold / Thrallmar
-- The Scryers / The Aldor

TradeskillInfo.vars.vendors = {
-- "name|zone|faction|location|comment"
	[1] =  L["Abigail Shiel"] .. "|43|2|61,52",
	[2] =  L["Aendel Windspear"] .. "|31|5|63,50",
	[3] =  L["Alchemist Pestlezugg"] .. "|37|3|51,27",
	[4] =  L["Alexandra Bolero"] .. "|34|1|43,74",
	[5] =  L["Algernon"] .. "|45|2|52,74",
	[6] =  L["Amy Davenport"] .. "|29|1|29,47",
	[7] =  L["Andrew Hilbert"] .. "|32|2|43,40",
	[8] =  L["Androd Fadran"] .. "|2|1|45,47",
	[9] =  L["Argent Quartermaster Hasana"] .. "|43|4|83,68",
	[10] =  L["Argent Quartermaster Lightspark"] .. "|47|4|43,84",
	[11] =  L["Balai Lok'Wein"] .. "|16|2|36,31",
	[12] =  L["Bale"] .. "|19|2|35,53",
	[13] =  L["Banalash"] .. "|36|2|45,57",
	[14] =  L["Blimo Gadgetspring"] .. "|4|3|46,90",
	[15] =  L["Blixrez Goodstitch"] .. "|35|3|28,77",
	[16] =  L["Blizrik Buckshot"] .. "|37|3|52,28",
	[17] =  L["Bliztik"] .. "|15|3|18,54",
	[18] =  L["Bombus Finespindle"] .. "|23|1|40,34",
	[19] =  L["Borya"] .. "|28|2|63,51",
	[20] =  L["Brienna Starglow"] .. "|20|1|89,46",
	[21] =  L["Bro'kin"] .. "|1|3|38,39",
	[22] =  L["Bronk"] .. "|20|2|76,43",
	[23] =  L["Catherine Leland"] .. "|34|1|55,69",
	[24] =  L["Christoph Jeffcoat"] .. "|22|2|63,19",
	[25] =  L["Clyde Ranthal"] .. "|29|1|89,70",
	[26] =  L["Constance Brisboise"] .. "|43|2|52,55",
	[27] =  L["Corporal Bluth"] .. "|35|1|38,3",
	[28] =  L["Cowardly Crosby"] .. "|35|3|27,83",
	[29] =  L["Crazk Sparks"] .. "|35|3|28,77",
	[30] =  L["Dalria"] .. "|3|1|36,52",
	[31] =  L["Daniel Bartlett"] .. "|45|2|64,38",
	[32] =  L["Danielle Zipstitch"] .. "|15|1|76,46",
	[33] =  L["Darian Singh"] .. "|34|1|30,68",
	[34] =  L["Darnall"] .. "|25|3|52,33",
	[35] =  L["Defias Profiteer"] .. "|48|1|44,68",
	[36] =  L["Deneb Walker"] .. "|2|1|27,59",
	[37] =  L["Derak Nightfall"] .. "|22|2|62,20",
	[38] =  L["Dirge Quikcleave"] .. "|37|3|53,28",
	[39] =  L["Drac Roughcut"] .. "|24|1|36,49",
	[40] =  L["Drake Lindgren"] .. "|18|1|83,67",
	[41] =  L["Drovnar Strongbrew"] .. "|2|1|46,47",
	[42] =  L["Elynna"] .. "|10|1|64,22",
	[43] =  L["Emrul Riknussun"] .. "|23|1|60,38",
	[44] =  L["Erika Tate"] .. "|34|1|76,37",
	[45] =  L["Evie Whirlbrew"] .. "|50|3|61,38",
	[46] =  L["Fradd Swiftgear"] .. "|49|1|26,26",
	[47] =  L["Fyldan"] .. "|10|1|48,21",
	[48] =  L["Gagsprocket"] .. "|39|3|63,36",
	[49] =  L["Gearcutter Cogspinner"] .. "|23|1|68,43",
	[50] =  L["George Candarte"] .. "|22|2|91,39",
	[51] =  L["Gharash"] .. "|36|2|46,52",
	[52] =  L["Ghok'kah"] .. "|16|2|36,31",
	[53] =  L["Gigget Zipcoil"] .. "|40|3|35,39",
	[54] =  L["Gikkix"] .. "|37|3|67,22",
	[55] =  L["Gina MacGregor"] .. "|48|1|57,54",
	[56] =  L["Gloria Femmel"] .. "|29|1|27,44",
	[57] =  L["Glyx Brewright"] .. "|35|3|28,77",
	[58] =  L["Gnaz Blunderflame"] .. "|35|3|51,35",
	[59] =  L["Gretta Ganter"] .. "|13|1|31,44",
	[60] =  L["Grimtak"] .. "|14|2|51,42",
	[61] =  L["Hagrus"] .. "|28|2|46,46",
	[62] =  L["Hammon Karwn"] .. "|2|1|47,48",
	[63] =  L["Harggan"] .. "|40|1|14,45",
	[64] =  L["Harklan Moongrove"] .. "|3|1|51,67",
	[65] =  L["Harlown Darkweave"] .. "|3|1|18,59",
	[66] =  L["Harn Longcast"] .. "|26|2|48,55",
	[67] =  L["Heldan Galesong"] .. "|9|1|37,56",
	[68] =  L["Helenia Olden"] .. "|16|1|66,52",
	[69] =  L["Himmik"] .. "|50|3|61,39",
	[70] =  L["Hula'mahi"] .. "|39|2|52,30",
	[71] =  L["Jabbey"] .. "|37|3|67,22",
	[72] =  L["Jandia"] .. "|41|2|46,51",
	[73] =  L["Janet Hommers"] .. "|11|1|66,7",
	[74] =  L["Jangdor Swiftstrider"] .. "|20|2|74,43",
	[75] =  L["Jannos Ironwill"] .. "|2|1|46,48",
	[76] =  L["Jaquilina Dramet"] .. "|35|3|36,11",
	[77] =  L["Jase Farlane"] .. "|17|3|81,58",
	[78] =  L["Jazzrik"] .. "|5|3|42,53",
	[79] =  L["Jeeda"] .. "|33|2|47,62",
	[80] =  L["Jennabink Powerseam"] .. "|49|1|8,56",
	[81] =  L["Jessara Cordell"] .. "|34|1|44,64",
	[82] =  L["Jinky Twizzlefixxit"] .. "|41|3|77,76",
	[83] =  L["Joseph Moore"] .. "|45|2|71,59",
	[84] =  L["Jubie Gadgetspring"] .. "|4|3|45,91",
	[85] =  L["Jun'ha"] .. "|2|2|73,36",
	[86] =  L["Jutak"] .. "|35|3|27,77",
	[87] =  L["Kaita Deepforge"] .. "|34|1|56,17",
	[88] =  L["Kalldan Felmoon"] .. "|46|3|",
	[89] =  L["Kania"] .. "|31|5|52,40",
	[90] =  L["Keena"] .. "|2|2|74,33",
	[91] =  L["Kelsey Yance"] .. "|35|3|28,74",
	[92] =  L["Kendor Kabonka"] .. "|34|1|77,53",
	[93] =  L["Khara Deepwater"] .. "|24|1|40,39",
	[94] =  L["Khole Jinglepocket"] .. "|34|1|56,60|" .. L["Seasonal"],
	[95] =  L["Kiknikle"] .. "|39|3|42,38",
	[96] =  L["Killian Sanatha"] .. "|32|2|33,18",
	[97] =  L["Kilxx"] .. "|39|3|63,38",
	[98] =  L["Kireena"] .. "|11|2|51,54",
	[99] =  L["Kithas"] .. "|28|2|53,37",
	[100] =  L["Knaz Blunderflame"] .. "|35|3|51,35",
	[101] =  L["Kor'geld"] .. "|28|2|56,34",
	[102] =  L["Kriggon Talsone"] .. "|48|1|37,89",
	[103] =  L["Krinkle Goodsteel"] .. "|37|3|52,29",
	[104] =  L["Kulwia"] .. "|33|2|46,60",
	[105] =  L["Kzixx"] .. "|15|3|81,21",
	[106] =  L["Laird"] .. "|9|1|37,44",
	[107] =  L["Lardan"] .. "|3|1|34,49",
	[108] =  L["Leo Sarn"] .. "|32|2|54,82",
	[109] =  L["Leonard Porter"] .. "|47|1|43,84",
	[110] =  L["Lieutenant General Andorov"] .. "|30|5|",
	[111] =  L["Lilly"] .. "|32|2|43,50",
	[112] =  L["Lindea Rabonne"] .. "|22|1|51,61",
	[113] =  L["Lizbeth Cromwell"] .. "|45|2|81,31",
	[114] =  L["Logannas"] .. "|20|1|33,44",
	[115] =  L["Lokhtos Darkbargainer"] .. "|6|6|",
	[116] =  L["Lorelae Wintersong"] .. "|25|3|48,40",
	[117] =  L["Magnus Frostwake"] .. "|47|3|68,77|" .. L["Quest"],
	[118] =  L["Mahu"] .. "|42|2|44,45",
	[119] =  L["Mallen Swain"] .. "|22|2|62,21",
	[120] =  L["Malygen"] .. "|19|1|62,26",
	[121] =  L["Maria Lumere"] .. "|34|1|46,78",
	[122] =  L["Martine Tramblay"] .. "|43|2|66,59",
	[123] =  L["Masat T'andr"] .. "|36|3|25,31",
	[124] =  L["Master Craftsman Omarion"] .. "|27|3|",
	[125] =  L["Mavralyn"] .. "|9|1|37,41",
	[126] =  L["Mazk Snipeshot"] .. "|35|3|28,75",
	[127] =  L["Meilosh"] .. "|19|7|66,3",
	[128] =  L["Micha Yance"] .. "|22|1|49,55",
	[129] =  L["Millie Gregorian"] .. "|45|2|71,30",
	[130] =  L["Mishta"] .. "|31|5|50,36",
	[131] =  L["Montarr"] .. "|41|2|45,50",
	[132] =  L["Muuran"] .. "|11|2|56,56",
	[133] =  L["Mythrin'dir"] .. "|10|1|61,18",
	[134] =  L["Naal Mistrunner"] .. "|42|2|52,52",
	[135] =  L["Namdo Bizzfizzle"] .. "|21|1|",
	[136] =  L["Nandar Branson"] .. "|22|1|50,57",
	[137] =  L["Nardstrum Copperpinch"] .. "|45|2|69,40|" .. L["Seasonal"],
	[138] =  L["Narj Deepslice"] .. "|2|1|46,48",
	[139] =  L["Narkk"] .. "|35|3|28,74",
	[140] =  L["Nata Dawnstrider"] .. "|42|2|45,40",
	[141] =  L["Nergal"] .. "|44|3|43,8",
	[142] =  L["Nerrist"] .. "|35|2|32,29",
	[143] =  L["Nessa Shadowsong"] .. "|38|1|54,90",
	[144] =  L["Nina Lightbrew"] .. "|7|1|67,18",
	[145] =  L["Nioma"] .. "|40|1|13,43",
	[146] =  L["Nyoma"] .. "|38|1|57,60",
	[147] =  L["Ogg'marr"] .. "|16|2|36,31",
	[148] =  L["Old Man Heming"] .. "|35|3|27,77",
	[149] =  L["Otho Moji'ko"] .. "|40|2|80,80",
	[150] =  L["Outfitter Eric"] .. "|23|1|43,29",
	[151] =  L["Penney Copperpinch"] .. "|28|2|53,67|" .. L["Seasonal"],
	[152] =  L["Plugger Spazzring"] .. "|6|3|",
	[153] =  L["Pratt McGrubben"] .. "|20|1|30,42",
	[154] =  L["Qia"] .. "|50|3|61,37",
	[155] =  L["Quartermaster Miranda Breechlock"] .. "|17|4|82,60",
	[156] =  L["Ranik"] .. "|39|3|62,39",
	[157] =  L["Rann Flamespinner"] .. "|24|1|36,46",
	[158] =  L["Rartar"] .. "|36|2|45,57",
	[159] =  L["Rikqiz"] .. "|35|3|28,76",
	[160] =  L["Rin'wosho the Trader"] .. "|35|8|15,16",
	[161] =  L["Rizz Loosebolt"] .. "|1|3|47,35",
	[162] =  L["Ronald Burch"] .. "|45|2|63,44",
	[163] =  L["Ruppo Zipcoil"] .. "|40|3|34,38",
	[164] =  L["Saenorion"] .. "|10|1|63,22",
	[165] =  L["Seersa Copperpinch"] .. "|42|2|44,59|" .. L["Seasonal"],
	[166] =  L["Sewa Mistrunner"] .. "|42|2|56,48",
	[167] =  L["Shandrina"] .. "|3|1|50,67",
	[168] =  L["Shankys"] .. "|28|2|69,30",
	[169] =  L["Sheendra Tallgrass"] .. "|20|2|74,43",
	[170] =  L["Shen'dralar Provisioner"] .. "|12|3|",
	[171] =  L["Sheri Zipstitch"] .. "|15|1|76,46",
	[172] =  L["Smudge Thunderwood"] .. "|22|3|84,19",
	[173] =  L["Soolie Berryfizz"] .. "|23|1|67,55",
	[174] =  L["Sovik"] .. "|28|2|75,25",
	[175] =  L["Stuart Fleming"] .. "|49|1|8,58",
	[176] =  L["Sumi"] .. "|28|2|82,23",
	[177] =  L["Super-Seller 680"] .. "|11|3|41,79|" .. L["Intermittent"],
	[178] =  L["Tamar"] .. "|28|2|63,44",
	[179] =  L["Tansy Puddlefizz"] .. "|23|1|48,6",
	[180] =  L["Tarban Hearthgrain"] .. "|39|2|56,32",
	[181] =  L["Tari'qa"] .. "|39|2|52,31",
	[182] =  L["Thaddeus Webb"] .. "|45|2|62,61",
	[183] =  L["Tharynn Bouden"] .. "|18|1|42,67",
	[184] =  L["Tilli Thistlefuzz"] .. "|23|1|61,44",
	[185] =  L["Truk Wildbeard"] .. "|40|1|14,42",
	[186] =  L["Tunkk"] .. "|2|2|74,35",
	[187] =  L["Ulthaan"] .. "|3|1|50,67",
	[188] =  L["Ulthir"] .. "|10|1|56,24",
	[189] =  L["Uthok"] .. "|35|2|31,28",
	[190] =  L["Vaean"] .. "|10|1|58,15",
	[191] =  L["Valdaron"] .. "|9|1|38,41",
	[192] =  L["Vargus"] .. "|31|5|51,39",
	[193] =  L["Veenix"] .. "|33|3|58,52",
	[194] =  L["Vendor-Tron 1000"] .. "|11|3|61,38|" .. L["Intermittent"],
	[195] =  L["Vharr"] .. "|35|2|32,29",
	[196] =  L["Vivianna"] .. "|20|1|31,43",
	[197] =  L["Vizzklick"] .. "|37|3|51,27",
	[198] =  L["Wenna Silkbeard"] .. "|49|1|26,26",
	[199] =  L["Werg Thickblade"] .. "|43|2|83,70",
	[200] =  L["Wik'Tar"] .. "|3|2|12,34",
	[201] =  L["Worb Strongstitch"] .. "|20|2|74,43",
	[202] =  L["Wrahk"] .. "|39|2|53,31",
	[203] =  L["Wulan"] .. "|11|2|27,70",
	[204] =  L["Wulmort Jinglepocket"] .. "|23|1|33,67|" .. L["Seasonal"],
	[205] =  L["Wunna Darkmane"] .. "|26|2|46,58",
	[206] =  L["Xandar Goodbeard"] .. "|24|1|83,63",
	[207] =  L["Xen'to"] .. "|28|2|57,53",
	[208] =  L["Xizk Goodstitch"] .. "|35|3|28,76",
	[209] =  L["Xizzer Fizzbolt"] .. "|50|3|61,39",
	[210] =  L["Yonada"] .. "|39|2|45,60",
	[211] =  L["Yuka Screwspigot"] .. "|8|3|66,23",
	[212] =  L["Zan Shivsproket"] .. "|22|3|84,18",
	[213] =  L["Zannok Hidepiercer"] .. "|31|3|82,18",
	[214] =  L["Zansoa"] .. "|14|2|57,73",
	[215] =  L["Zarena Cromwind"] .. "|35|3|28,75",
	[216] =  L["Zargh"] .. "|39|2|53,30",
	[217] =  L["Zixil"] .. "|22|3|61,21|" .. L["Roving"],
	[218] =  L["Zorbin Fandazzle"] .. "|20|3|45,43|" .. L["Quest"],
	[219] =  L["Crimson Battle Mage"] .. "|51|3",
	[220] =  L["Spectral Researcher"] .. "|52|3",
	[221] =  L["Scholomance Dark Summoner"] .. "|52|3",
	[222] =  L["Blackrock Battlemaster"] .. "|8|3",
	[223] =  L["Ghoul Ravener"] .. "|51|3",
-- Burning Crusade
	[224] =  L["Deynna"] .. "|55|2|56,50",
	[225] =  L["Eiin"] .. "|60|3|66,68",
	[226] =  L["Neii"] .. "|58|1|64,68",
	[227] =  L["Borto"] .. "|69|1|53,72",
	[228] =  L["Mathar G'ochar"] .. "|69|2|55,37",
	[229] =  L["Andrion Darkspinner"] .. "|60|3|66,68",
	[230] =  L["Arrond"] .. "|65|2|56,58",
	[231] =  L["Nasmara Moonsong"] .. "|60|3|66,69",
	[232] =  L["Gidge Spellweaver"] .. "|60|3|66,69",
	[233] =  L["Karaaz"] .. "|61|18|44,34",
	[234] =  L["Nakodu"] .. "|60|22|62,69",
	[235] =  L["Quartermaster Endarin"] .. "|60|20|48,26",
	[236] =  L["Quartermaster Enuril"] .. "|60|19|61,64",
	[237] =  L["Fedryen Swiftspear"] .. "|67|12|79,64",
	[238] =  L["Muheru the Weaver"] .. "|67|1|41,28",
	[239] =  L["Zurai"] .. "|67|2|85,55",
	[240] =  L["Koren"] .. "|56|11|",
	[241] =  L["Krek Cragcrush"] .. "|65|2|29,31",
	[242] =  L["Loolruna"] .. "|67|1|69,50",
	[243] =  L["Aaron Hollman"] .. "|60|3|64,71",
	[244] =  L["Arras"] .. "|58|1|61,90",
	[245] =  L["Eriden"] .. "|55|2|80,36",
	[246] =  L["Mari Stonehand"] .. "|65|1|37,55",
	[247] =  L["Rohok"] .. "|53|2|53,38",
	[248] =  L["Quartermaster Urgronn"] .. "|53|14|55,38",
	[249] =  L["Logistics Officer Ulrike"] .. "|53|15|57,63",
	[250] =  "", -- Haalrun was here as Halruun, probably an old typo
	[251] =  L["Haalrun"] .. "|67|1|68,48",
	[252] =  L["Seer Janidi"] .. "|67|2|32,52",
	[253] =  L["Daga Ramba"] .. "|59|2|51,58",
	[254] =  L["Alurmi"] .. "|37|9|64,58",
	[255] =  L["Almaador"] .. "|60|21|50,42",
	[256] =  L["Mycah"] .. "|67|3|18,51",
	[257] =  L["Trader Narasu"] .. "|69|17|55,75",
	[258] =  L["Altaa"] .. "|58|1|28,63",
	[259] =  L["Melaris"] .. "|55|2|67,20",
	[260] =  L["Skreah"] .. "|60|3|46,20",
	[261] =  L["Alchemist Gribble"] .. "|53|1|54,66",
	[262] =  L["Apothecary Antonivich"] .. "|53|2|52,37",
	[263] =  L["Leeli Longhaggle"] .. "|66|1|58,53",
	[264] =  L["Burko"] .. "|53|1|22,39",
	[265] =  L["Aresella"] .. "|53|2|26,62",
	[266] =  L["Baxter"] .. "|53|2|56,41|" .. L["Roving"],
	[267] =  L["Gaston"] .. "|53|1|54,64",
	[268] =  L["Naka"] .. "|67|3|79,63",
	[269] =  L["Landraelanis"] .. "|54|2|49,47",
	[270] =  L["Master Chef Mouldier"] .. "|62|2|48,31",
	[271] =  L["Innkeeper Grilka"] .. "|66|2|49,45",
	[272] =  L["Supply Officer Mills"] .. "|66|1|56,53",
	[273] =  L["Doba"] .. "|67|1|42,28",
	[274] =  L["Gambarinka"] .. "|67|2|32,49",
	[275] =  L["Fazu"] .. "|64|1|54,56",
	[276] =  L["Innkeeper Biribi"] .. "|66|1|57,53",
	[277] =  L["Rungor"] .. "|66|2|49,46",
	[278] =  L["Nula the Butcher"] .. "|69|2|58,36",
	[279] =  L["Uriku"] .. "|69|1|56,73",
	[280] =  L["Cookie One-Eye"] .. "|53|2|55,41",
	[281] =  L["Sid Limbardi"] .. "|53|1|54,64",
	[282] =  L["Arred"] .. "|58|1|45,26",
	[283] =  L["Gelanthis"] .. "|55|2|91,74",
	[284] =  L["Neal Allen"] .. "|49|1|11,57",
	[285] =  L["Felika"] .. "|28|2|51,36|" .. L["Roving"],
	[286] =  L["Edna Mullby"] .. "|34|1|58,61",
	[287] =  L["Burbik Gearspanner"] .. "|23|1|47,27",
	[288] =  L["Felicia Doan"] .. "|45|2|64,50",
	[289] =  L["Shadi Mistrunner"] .. "|42|2|40,64",
	[290] =  L["Apprentice Darius"] .. "|68|11|47,75",
	[291] =  L["Kalaen"] .. "|53|2|57,38",
	[292] =  L["Tatiana"] .. "|53|1|55,64",
	[293] =  L["Feera"] .. "|58|1|54,91",
	[294] =  L["Viggz Shinesparked"] .. "|60|3|65,69",
	[295] =  L["Yatheon"] .. "|55|2|76,40",
	[296] =  L["Daggle Ironshaper"] .. "|65|1|37,54",
	[297] =  L["Mixie Farshot"] .. "|53|2|61,82",
	[298] =  L["Wind Trader Lathrai"] .. "|60|3|72,30",
	[299] =  L["Lebowski"] .. "|53|1|56,66",
	[300] =  L["Captured Gnome"] .. "|67|2|33,48",
	[301] =  L["Provisioner Nasela"] .. "|69|16|54,37",
	[302] =  L["Haferet"] .. "|58|1|66,75",
	[303] =  L["Zaralda"] .. "|55|2|84,79",
	[304] =  L["Cro Threadstrong"] .. "|60|3|67,67",
	[305] =  L["Thomas Yance"] .. "|63|3|",
	[306] =  L["Juno Dufrain"] .. "|67|3|78,66",
	[307] =  L["Vodesiin"] .. "|53|1|24,38",
	[308] =  L["Andormu"] .. "|37|10|58,59",
	[309] =  L["Aged Dalaran Wizard"] .. "|63|3|",
	[310] =  L["Madame Ruby"] .. "|60|3|63,70",
	[311] =  L["Egomis"] .. "|58|1|39,40",
	[312] =  L["Lyna"] .. "|55|2|69,24",
	[313] =  L["Okuno"] .. "|70|23",
	[314] =  L["Indormi"] .. "|71|10",
	[315] =  L["Eldara Dawnrunner"] .. "|72|24",
	[316] =  L["Shaani"] .. "|72|24",
	[317] =  L["Arille Azuregaze"] .. "|73|25|48,38",
	[318] =  L["Derek Odds"] .. "|73|25|41,65",
	[319] =  L["Misensi"] .. "|73|26|70,38",
	[320] =  L["Haughty Modiste"] .. "|37|3|67,22",
	-- TODO: Add to locales
	[321] =  L["Quartermaster Davian Vaclav"] .. "|69|1|41,44",
	[322] =  L["Quartermaster Jaffrey Noreliqe"] .. "|69|2|41,44",
	[322] =  L["Karaaz"] .. "|61|18|44,34",
	[323] =  L["Paulsta'ats"] .. "|69|18|30,57",
	[324] =  L["Vanessa Sellers"] .. "|73|25|39,41",
	[325] =  L["Gara Skullcrush"] .. "|74|27|41,54",
	[326] =  L["Sebastian Crane"] .. "|75|27|80,31",
	[327] =  L["Logistics Officer Brighton"] .. "|75|28|60,64",
	[328] =  L["Logistics Officer Silverstone"] .. "|74|28|58,67",
	[329] =  L["Ontuvo"] .. "|60|24|49,41",
	[330] =  L["Tanak"] .. "|76|29|55,69",
	[331] =  L["Duchess Mynx"] .. "|77|30|43,21",
	[332] =  L["Geen"] .. "|76|31|55,56",
	[333] =  L["Sairuk"] .. "|78|32|49,76",
	[334] =  L["Tanaika"] .. "|75|32|25,59",
	[335] =  L["Tiffany Cartier"] .. "|73|25|41,35",
	[336] =  L["Archmage Alvareaux"] .. "|73|25|26,48",
	[337] =  L["Lillehoff"] .. "|79|33|66,61",
	[338] =  L["Cielstrasza"] .. "|78|34|60,53",
	[339] =  L["Veteran Crusader Aliocha Segard"] .. "|77|35|88,76",
	[340] =  L["Knight Dameron"] .. "|80|28|52,17",
	[341] =  nil, -- "Morgan Day" R.I.P
	[342] =  L["Stone Guard Mukar"] .. "|80|27|52,17",
	[343] =  L["Braeg Stoutbeard"] .. "|73|25|38,38",
	[344] =  L["Bryan Landers"] .. "|73|25|38.9,25.2",
	[345] =  L["Captain O'Neal"] .. "|34|1|75.1,66.8",
	[346] =  L["Lady Palanseer"] .. "|28|2|37.0,64.9",
	[347] =  L["Timothy Jones"] .. "|73|25|40.5,35.2",
	[348] =  L["Alchemist Finklestein"] .. "|81|36|36.2,20.4",
	[349] =  L["Larana Drome"] .. "|73|25|42.3,37.5",
	[350] =  L["Frozo the Renowned"] .. "|73|25|40.0,28.3",
-- Cata 4.2
	[351] =  L["Damek Bloombeard"] .. "|82|6|47.0,90.6",
	[352] =  L["Ayla Shadowstorm"] .. "|82|37|44.6,85.4",
	[353] =  L["Varlan Highbough"] .. "|82|37|44.6,88.6",
-- Cata 4.3
	[354] =  L["Farrah Facet"] .. "|34|1|63.8,61.6",
	[355] =  L["Taryssa Lazuria"] .. "|28|2|72.4,36.4",
}
