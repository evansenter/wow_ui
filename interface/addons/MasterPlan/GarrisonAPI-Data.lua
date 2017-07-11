local _, T = ...
if T.Mark ~= 50 then return end

T.Affinities = {} do
	local ht, hp = [[3Ѵ1#t<.�C�%���p�6��]�11���!Ѳ6GAڼ�w�NH|pȑ���<�+��q!����,��đ{.���oXO{�}�T�hT���$0�G�v�P��Q�ݚ���q�2�Ɇg�4����҃jҴX�	P^�3&U,@��HV\���;d�Q�)*<�-v�!'@�x�v��iG���v��H������E���Q}��nY�N虩gc.��,T�t<�%���Ì�u[��.8�x�2O?��W2JFI�d`ɽlT�D(J���idf�9*��BcRb<E��"ٰ�q����z1�A����&,�睄�Ȳ�ri���A� ��:o2"t���Ĳ#���$�"F)�2Iӛ�Ḧ�Ȇ%�K�C��9�-3JHù�C��L�tRòH%4J"��4�E&&qJ���y�0��ȵ��J^סʣ��@�;(B�E�t�%G�{���9㺃���-4u�(�Θ�(c��9�)d#Q+td��!�"6D��Jd�¦Ib�C��� 7�,L���Q;�8ͧ;�:n�$���]], [[((�h��nip(qj�krgolms]]
	local p, G, V, Vp, by, hk, ak = {}, 127, 487, 255, ht.byte, UnitFactionGroup('player') == 'Horde' and 6724 or 60788, 31516
	for i=1,#hp do p[i] = by(hp, i) p[i] = p[i] + (p[i] > 128 and 80 or -40) end
	setmetatable(T.Affinities, {__index=function(t, k)
		local k, c, a, v, r, b, d, e = k or false, k, type(k)
		if a == "string" then
			a, c = "number", tonumber(k:match("^0x0*(%x*)$") or "z", 16) or false
		end
		if a == "number" and c then
			c = c * hk
			a = 2*(((c * ak) % 2147483629) % G)
			a, b = by(ht, a+1, a+2)
			v = ((c * (a*256+b) + ak) % 2147483629) % V
			v, r = Vp + (v - v % 8)*5/8, v % 8
			a, b, c, d, e = by(ht, v, v + 4)
			v = a * 4294967296 + b * 16777216 + c * 65536 + d * 256 + e
			v = ((v - v % 32^r) / 32^r % 32)
		end
		t[k] = p[v] or 0
		return t[k]
	end})
end

T.UsableAffinities = UnitFactionGroup('player') == 'Horde' and {70,71,72,73,74,75,69,252,253,254,255} or {63,64,65,66,67,68,69,252,253,254,255}

T.MissionExpire = {} do
	local expire = T.MissionExpire
	for n, r in ("000210611621id2e56516c16o17i0ed3ei1ho3i31jxnkq1:0ga6b:0me10ea2:0o2103rz4rz5r86136716e26q37ji9549eja23ai0am1aq4ax0b40cq0dcedx1kp0:102zd3h86vm82maj2ao1av1ay5b51bicc0dczcdr1dz0ife:1ch51h82kv0:1y9a39y3dt3:20050100190cr7:4of57iu9:7pe40:9b8pfb7abv3ceb:e0ek5etbfdzgdrh70hbbhs4hz0i11i59j4bjhfkl1ku0kw0"):gmatch("(%w%w)(%w+)") do
		local n = tonumber(n, 36)
		for s, l in r:gmatch("(%w%w)(%w)") do
			local s = tonumber(s, 36)
			for i=s, s+tonumber(l, 36) do
				expire[i] = n
			end
		end
	end
end

T.EnvironmentCounters = {[11]=4, [12]=38, [13]=42, [14]=43, [15]=37, [16]=36, [17]=40, [18]=41, [19]=42, [20]=39, [21]=7, [22]=9, [23]=8, [24]=45, [25]=46, [26]=44, [28]=48, [29]=49, [60]=54, [61]=55, [62]=56, [63]=57, [67]=58, [64]=59, [65]=60, [66]=61,}
T.EquipmentCounters = {[73]=263, [74]=261, [75]=262, [76]=264, [77]=265, [78]=266, [79]=267, [80]=268, [81]=269, [82]=270, [83]=271, [84]=272, [87]=260, [88]=306}
T.EquipmentTraitItems = {[269]=127882, [270]=127883, [272]=127884, [271]=127663, [266]=125787, [267]=127662, [265]=127880, [268]=127881, [305]=127894, [275]=127886, [306]=127895}
T.EquipmentTraitQuests = {[269]=39368, [270]=39360, [272]=39366, [271]=39355, [266]=38932, [267]=39356, [265]=39363, [268]=39364, [305]=39359, [275]=39358, [306]=39365}
T.EnvironmentBonus = {[324]={[11]=3,[12]=3,[14]=3,[15]=3,[16]=3,[17]=3,[18]=3,[19]=3,[20]=3}}
T.EnvironmentGhosts = {[128313]=12, [127748]=11, [128316]=15, [128312]=14}

T.SpecCounters = { nil, {1,2,7,8,10}, {1,4,7,8,10}, {1,2,7,8,10}, {6,7,9,10}, nil, {1,2,6,10}, {1,2,6,9}, {3,4,7,9}, {1,6,7,9,10}, nil, {6,7,8,9,10}, {2,6,7,9,10}, {6,8,9,10}, {6,7,8,9,10}, {2,7,8,9,10}, {1,2,3,6,9}, {3,4,6,8}, {1,6,8,9,10}, {3,4,8,9}, {1,2,4,8,9}, {2,7,8,9,10}, {3,4,6,9}, {3,4,6,7}, {4,6,7,9,10}, {2,6,8,9,10}, {6,7,8,9,10}, {2,6,7,8,9}, {3,7,8,9,10}, {3,6,7,9,10}, {3,4,7,8}, {4,7,8,9,10}, {2,7,8,10,10}, {3,8,9,10,10}, {1,6,7,8,10}, nil, {2,6,7,8,10}, {1,2,6,7,8} }
T.SpecIcons = {nil, 135770, 135773, 135775, 136096, nil, 132115, 132276, 136041, 461112, nil, 236179, 461113, 135932, 135810, 135846, 608951, 608952, 608953, 135920, 236264, 135873, 135940, 237542, 136207, 132292, 132090, 132320, 136048, 237581, 136052, 136145, 136172, 136186, 132355, nil, 132347, 132341}

T.EquivTrait = {[244]=4, [250]=221, [228]=48, [227]=48, [303]=202, [286]=283, [293]=292}

T.TraitCost = {[47]=4, [248]=3, [256]=3, [79]=2, [80]=1, [236]=1, [287]=-5, [290]=-5, [305]=-3, [315]=1, [327]=1, [275]=-1, [283]=2, [286]=2}

T.AlwaysTraits = {__index={[221]=1, [201]=1, [202]=1, [47]=1}}
T.LockTraits = {[47]=1, [231]=1, [227]=1, [228]=1, [244]=1, [248]=1, [324]=1, [325]=1, [326]=1, [201]=1, [303]=1}

T.XPMissions = {[5]=0, [173]=275000, [215]=0, [364]=0,}

T.FOLLOWER_ITEM_LEVEL_CAP = 675
T.ItemLevelUpgrades = {
	WEAPON={114128, 675, 114129, 672, 114131, 669, 114616, 615, 114081, 630, 114622, 645, 128307, 645},
	ARMOR={114745, 675, 114808, 672, 114822, 669, 114807, 615, 114806, 630, 114746, 645, 128308, 645}
}
T.MENTOR_FOLLOWER = 465
T.MinorRewards = {[114128]=1, [114129]=1, [114131]=1, [114616]=1, [114081]=1, [114622]=1, [128307]=1, [120301]=1, [120302]=1, [114745]=1, [114808]=1, [114822]=1, [114807]=1, [114806]=1, [114746]=1, [128308]=1, [122595]=1, [128373]=1, [122594]=1, [122307]=1, [122596]=1, [122590]=1, [122592]=1, [122593]=1, [122502]=1, [122503]=1, [122591]=1, [122487]=1, [122576]=1, [122490]=1, [122501]=1, [122500]=1, [122497]=1, [122491]=1, [122496]=1,
	[122584]=1, [122580]=1, [122582]=1, [118474]=1, [122583]=1, [118475]=1,
	[26045]=0, [26044]=0,}

T.MissionLocationBanners = { [101]="GarrMissionLocation-FrostfireRidge", [102]="GarrMissionLocation-TannanJungle", [103]="GarrMissionLocation-Gorgrond", [104]="GarrMissionLocation-Nagrand", [105]="GarrMissionLocation-Talador", [106]="GarrMissionLocation-ShadowmoonValley", [107]="GarrMissionLocation-SpiresofArak", [164]="_GarrMissionLocation-BlackrockMountain", }

T.InterestPool = {
	{313, 104,   1,  3, s={645, 3, 28800, 118529, 28, 1, 2, 6, 8, 9, 10}}, -- Highmaul Raid
	{314, 104,   1,  3, s={645, 3, 28800, 118529, 17, 1, 3, 3, 4, 6, 7}}, -- Highmaul Raid
	{315, 104,   1,  3, s={645, 3, 28800, 118529, 12, 2, 4, 7, 9, 10, 10}}, -- Highmaul Raid
	{316, 104,   1,  3, s={645, 3, 28800, 118529, 29, 1, 6, 8, 9, 9, 10}}, -- Highmaul Raid
	{427, 103,   1,  3, s={660, 3, 28800, 122484, 18, 1, 2, 3, 6, 7, 9, 10}}, -- Slagworks
	{428, 103,   1,  3, s={660, 3, 28800, 122484, 21, 1, 2, 3, 3, 6, 8, 10}}, -- Black Forge
	{429, 103,   1,  3, s={660, 3, 28800, 122484, 24, 3, 4, 4, 6, 7, 7, 8}}, -- Iron Assembly
	{430, 103,   1,  3, s={660, 3, 28800, 122484, 11, 1, 2, 3, 6, 8, 9, 10}}, -- Blackhand's Crucible
	{312, 104, 300,  3, s={630, 3, 21600, 824, 25, 2, 4, 8, 10}}, -- Magical Mystery Tour
	{311, 103, 300,  3, s={630, 3, 21600, 824, 11, 2, 3, 6, 10}}, -- Can't Go Home This Way
	{214, 104, 275,  3, s={99, 3, 7200, 824, 11, 3, 10, 10}}, -- A Way Out
	{334, 104, 250,  3, s={100, 3, 36000, 824, 12, 1, 2, 2}}, -- Mogor's Dilemma
	{213, 104, 250,  3, s={98, 3, 7200, 824, 11, 1, 2, 8}}, -- Fired Up
	{269, 104, 225,  3, s={615, 2, 14400, 824, 20, 1, 6, 10}}, -- Griefing with the Enemy
	{268, 103, 225,  3, s={615, 2, 14400, 824, 22, 2, 3, 7}}, -- Who's the Boss?
	{212, 107, 225,  3, s={97, 3, 6750, 824, 15, 1, 2, 10}}, -- Cat Scratch Fever
	{288, 107, 200, 35, s={100, 3, 21600, 824, 14, 2, 6, 8, 9}}, -- The Golden Halls of Skyreach
	{211, 107, 200,  3, s={96, 3, 6750, 824, 19, 1, 3, 10}}, -- Peace unto You
	{210, 105, 175,  3, s={95, 3, 5400, 824, 14, 4, 8, 10}}, -- Flock Together
	{133, 101, 175,  3, s={100, 2, 21600, 824, 18, 3, 8}}, -- Elemental Territory
	{132, 107, 175,  3, s={100, 2, 21600, 824, 15, 4, 6}}, -- The Basilisk's Stare
	{209, 105, 150,  3, s={94, 3, 5400, 824, 11, 1, 3, 10}}, -- Lending a Hand
	{208, 103, 125,  3, s={93, 3, 5400, 824, 12, 6, 6, 7}}, -- Elements of Surprise
	{207, 103, 110,  3, s={92, 3, 5400, 824, 20, 1, 2, 9}}, -- Environmental Hazard
	{289, 106, 100, 35, s={100, 2, 21600, 824, 26, 1, 2}}, -- Profitable Machinations
	{287, 103, 100, 35, s={100, 2, 21600, 824, 22, 2, 6}}, -- Blackrock Munitions
	{286, 103, 100, 35, s={100, 2, 21600, 824, 11, 2, 9}}, -- Lost in the Foundry
	{285, 106, 100, 35, s={100, 2, 21600, 824, 20, 7, 8}}, -- The One True Brambleking
	{284, 101, 100, 35, s={100, 2, 21600, 824, 23, 4, 8}}, -- Ug'lok the Incompetent
	{677, 105, 150,  3, s={675, 2, 36000, 1101, 13, 2, 4, 6, 7, 9, 10}}, -- Death's Bite Again?
	{675, 101,  75,  3, s={660, 2, 28800, 1101, 23, 2, 4, 7, 10}}, -- Resources at the Ridge
	{676, 106,  75,  3, s={660, 2, 28800, 1101, 19, 1, 4, 8, 9, 10}}, -- Vile Bloods
	{673, 103,  50,  3, s={630, 3, 28800, 1101, 28, 1, 3, 4, 7}}, -- Every Rose
	{672, 164,  50,  3, s={630, 3, 28800, 1101, 27, 1, 2, 7}}, -- Eye of the Beast
	{674, 107,  50,  3, s={630, 3, 28800, 1101, 13, 2, 3, 6, 10}}, -- Foul Feeders
	{668, 105,  40,  3, s={615, 3, 28800, 1101, 24, 8, 9, 10}}, -- Crystal Power
	{670, 101,  40,  3, s={615, 3, 28800, 1101, 23, 1, 8, 9}}, -- Super Slag Siblings
	{671, 106,  40,  3, s={615, 3, 28800, 1101, 19, 2, 6, 10}}, -- Visions of the Void
	{669, 103,  40,  3, s={615, 3, 28800, 1101, 18, 3, 4, 6}}, -- Watery Woes
	{503, 105,   1,  3, s={675, 2, 21600, 123858, 11, 1, 2, 3, 6, 10}}, -- Lessons of the Blade
	{381, 105,  30,  3, s={675, 2, 36000, 120945, 24, 2, 3, 6, 7}}, -- What's Mine Is A Mine
	{396, 106,  30,  3, s={675, 2, 28800, 120945, 20, 1, 7, 7, 10}}, -- Night of the Primals
	{496, 104,  20,  3, s={660, 2, 28800, 120945, 18, 4, 6, 6, 8}}, -- Prime Directive
	{394, 103,  20,  3, s={660, 2, 28800, 120945, 25, 1, 2, 7, 9}}, -- Mulch Ado about Nothing
	{395, 103,  20,  3, s={660, 2, 28800, 120945, 15, 1, 2, 7, 10}}, -- Lunch Breakers
	{401, 104,  20,  3, s={660, 2, 28800, 120945, 18, 3, 6, 7, 8}}, -- Bucket Brigade
	{391, 107, 600,  3, s={675, 2, 28800, 823, 22, 7, 8, 9, 9}}, -- Spring Preening
	{399, 105, 600,  3, s={675, 2, 36000, 823, 16, 2, 2, 8, 10}}, -- Felraiser
	{445, 106, 400,  3, s={660, 2, 28800, 823, 26, 2, 4, 9, 9}}, -- Socrethar Sabotage
	{398, 105, 400,  3, s={660, 2, 28800, 823, 16, 2, 8, 9, 10}}, -- Highway to Fel
	{444, 101, 400,  3, s={660, 2, 28800, 823, 23, 3, 4, 6, 8}}, -- Emancipation
	{495, 107, 400,  3, s={660, 2, 28800, 823, 22, 2, 3, 4, 8}}, -- Apexis Nexus
	{684, 105,   1,  3, s={675, 3, 43200, 128315, 26, 1, 2, 3, 4, 7, 8}}, -- Eldritch Horrors
	{687, 106,   1,  3, s={675, 3, 43200, 128430, 28, 3, 4, 6, 6, 9, 10}}, -- The Botani Stirr
	{678, 103,   1,  3, s={675, 3, 43200, 127748, 27, 2, 3, 7, 8, 9, 10}}, -- Fiery Friends
	{682, 101,   1,  3, s={675, 3, 43200, 128313, 23, 1, 1, 2, 9, 9, 10}}, -- Ogrecoming Adversity
	{685, 102,   1,  3, s={675, 3, 43200, 128316, 25, 1, 2, 7, 8, 9, 10}}, -- Monstrous Menagerie
	{681, 107,   1,  3, s={675, 3, 43200, 128312, 28, 2, 3, 4, 6, 7, 8}}, -- Arakkoa Ancestry
	{358, 103,   1,  3, s={100, 3, 36000, 994, 22, 2, 3, 6}}, -- Drov the Ruiner
	{359, 107,   1,  3, s={100, 3, 36000, 994, 21, 1, 3, 7}}, -- Rukhmar
}

T.InterestMask = {
	[118529]=1, [122484]=2, [824]=3, [0]=4,
	[120945]=5, [994]=6, [115280]=7, [115510]=7, [823]=8, [1101]=9,
	[128315]=10, [128430]=11, [128313]=12, [128316]=13, [127748]=14, [128312]=15,
}

T.ShipInterestPool = {
	{643, 165,   1, 40, s={100, 2, 14400, 128391, 30, 75, 76, 81, 81, 82, 84}}, -- All Fel Breaks Loose
	{705, 165,   1, 40, s={100, 2, 14400, 128391, 30, 74, 74, 82, 83, 83, 85}}, -- All Fel Breaks Loose
	{706, 165,   1, 40, s={100, 2, 14400, 128391, 30, 73, 76, 80, 82, 83, 83, 84}}, -- All Fel Breaks Loose
	{707, 165,   1, 40, s={100, 2, 14400, 128391, 30, 73, 74, 80, 81, 82, 83, 85}}, -- All Fel Breaks Loose
	{708, 165,   1, 40, s={100, 2, 14400, 128391, 30, 73, 74, 82, 83, 83, 84}}, -- All Fel Breaks Loose
	{618, 205, 5e3, 40, s={100, 2, 172800, 823, 30, 73, 73, 82, 83, 87, 88, 88}}, -- Blood, Gold, and Regret
	{622, 205, 1e3, 40, s={100, 2, 64800, 1101, 30, 75, 75, 78, 82, 84, 88, 88}}, -- Nothing Gold Can Stay
	{621, 165, 1e3, 40, s={100, 2, 64800, 1101, 30, 73, 76, 82, 82, 87, 88, 88}}, -- Unafraid of Ghosts
	{620, 165, 1e3, 40, s={100, 2, 64800, 1101, 30, 73, 76, 82, 83, 87, 88, 88}}, -- Gold in Their Holds
	{540, 205,  50, 40, s={100, 2, 64800, 120945, 30, 73, 75, 81, 83, 83, 84, 87}}, -- False Economy
	{539, 205,  30, 40, s={100, 2, 64800, 120945, 30, 73, 74, 81, 83, 83}}, -- Glittering Prize
	{650, 165,   1, 40, s={100, 2, 172800, 128173, 30, 73, 76, 80, 82, 84, 88, 88}}, -- The House Always Wins
	{616, 165,   1, 40, s={100, 2, 172800, 128169, 30, 73, 76, 78, 82, 84, 88, 88}}, -- The Wave Mistress
	{649, 165,   1, 40, s={100, 2, 172800, 128172, 30, 73, 76, 79, 82, 84, 88, 88}}, -- For Hate's Sake
	{647, 205,   1, 40, s={100, 2, 64800, 127989, 30, 74, 76, 78, 81, 81, 82, 84}}, -- Black Market Journal
	{619, 205,   1, 40, s={100, 2, 64800, 127856, 30, 73, 75, 78, 83, 84}}, -- Orphaned Aquatic Animal Rescue
	{615, 205,   1, 40, s={100, 2, 64800, 116769, 30, 73, 75, 81, 82, 84, 85}}, -- It's a Boat, It's a Plane, It's... Just a Riverbeast.
}

T.MissionRewardSets = {
	[118529]={
		{118531,15,9285,9289,9294,9300,9304,9311,9315},
		{118531,15,9284,9288,9293,9298,9303,9310,9314},
		{118530,15,9282,9287,9292,9297,9302,9308,9313},
	},
	[122484]={
		{122486,8,9285,9289,9294,9300,9304,9311,9315},
		{122486,11,9319,9323,9329,9333,9338,9342,9353,9357,9361,9365},
		{122486,21,9318,9322,9328,9332,9337,9341,9351,9356,9360,9364},
		{122485,21,9317,9321,9327,9331,9336,9340,9349,9355,9359,9363},
	},
}

T.MissionCoalescing = {
	[118529]={4,8,12},
	[122484]={19,23,27},
}

T.ShipMissionReplacements = {
	{127855, 644, 709, 710, 711, 712},
	{127854, 642, 701, 702, 703, 704},
	{127853, 562, 713, 714, 715, 716},
	{128391, 643, 705, 706, 707, 708}
}

T.TrackedMissionSets = {
	{
		{118531, 321, 322, 323, 324, 325, 326, 327, 328},
		{118530, 317, 318, 319, 320},
		{118529, 313, 314, 315, 316}
	},
	{
		{122486, 450, 451, 452, 453, 454, 455, 456, 457},
		{122485, 446, 447, 448, 449},
		{122484, 427, 428, 429, 430}
	},
	T.ShipMissionReplacements,
}

T.TraitStack = {[824]=79, [1101]=314, [823]=326}
T.MoreTraitStack = {[824]=256}
T.ShipTraitStack = {}
T.UniqueTraits = {[326]=1}
T.MaxTraitStack = {[824]=3}

T.TokenSlots = {} do
	local b, s, m, d = 114e3, 1, T.TokenSlots, "62:56424e:553f644b::533a46:65:63:543b6047:52395e45:3561:34::57446950:::706e6d6c"
	for i, a in d:gmatch("(%x%x)(:*)") do
		m[b+tonumber(i,16)], s = s, s + #a
	end
end

T.CrateLevels = {[118529]=655, [118530]=670, [118531]=685, [122484]=670, [122485]=685, [122486]=700}

T.StrongNavalThreats = {[73]=20, [74]=20, [75]=20, [76]=20, [87]=20}
T.ShipAffinityMap = {[261]=281, [262]=278, [263]=279, [264]=277, [260]=280, [323]=280}

T.TraitDisplayMap = UnitFactionGroup('player') == 'Horde' and {[283]=286} or nil