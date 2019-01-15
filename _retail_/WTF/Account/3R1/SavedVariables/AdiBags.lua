
AdiBagsDB = {
	["namespaces"] = {
		["ItemLevel"] = {
		},
		["FilterOverride"] = {
			["profiles"] = {
				["Default"] = {
					["version"] = 3,
				},
				["Comet - Illidan"] = {
					["version"] = 3,
					["overrides"] = {
						[141446] = "Equipment#Armor",
						[142117] = "Quest#Quest",
					},
				},
			},
		},
		["ItemCategory"] = {
		},
		["NewItem"] = {
			["profiles"] = {
				["Comet - Illidan"] = {
					["ignoreJunk"] = true,
				},
			},
		},
		["AdiBags_TooltipInfo"] = {
		},
		["Equipment"] = {
		},
		["ItemSets"] = {
		},
		["CurrencyFrame"] = {
			["profiles"] = {
				["Comet - Illidan"] = {
					["shown"] = {
						["Mark of the World Tree"] = false,
						["Elder Charm of Good Fortune"] = false,
						["Nethershard"] = false,
						["Valor"] = false,
						["Seafarer's Dubloon"] = false,
						["Illustrious Jewelcrafter's Token"] = false,
						["Curious Coin"] = false,
						["Order Resources"] = false,
						["Veiled Argunite"] = false,
						["Warforged Seal"] = false,
						["Honorbound Service Medal"] = false,
						["Seal of Broken Fate"] = false,
						["Mogu Rune of Fate"] = false,
						["Timewarped Badge"] = false,
						["Ancient Mana"] = false,
						["Tol Barad Commendation"] = false,
						["Mote of Darkness"] = false,
						["Ironpaw Token"] = false,
						["Seal of Tempered Fate"] = false,
						["Wakening Essence"] = false,
						["Sightless Eye"] = false,
						["Timeless Coin"] = false,
						["Essence of Corrupted Deathwing"] = false,
						["Apexis Crystal"] = false,
						["Lesser Charm of Good Fortune"] = false,
						["Seal of Inevitable Fate"] = false,
						["Garrison Resources"] = false,
						["Oil"] = false,
						["Lingering Soul Fragment"] = false,
						["Legionfall War Supplies"] = false,
					},
					["text"] = {
						["name"] = "ABF",
						["size"] = 15,
					},
				},
			},
		},
		["DataSource"] = {
		},
		["Junk"] = {
		},
		["MoneyFrame"] = {
		},
	},
	["profileKeys"] = {
		["Cometstorm - Illidan"] = "Comet - Illidan",
		["Ereinion - Dark Iron"] = "Default",
		["Comet - Illidan"] = "Comet - Illidan",
		["Combustion - Illidan"] = "Comet - Illidan",
		["Evan - Illidan"] = "Comet - Illidan",
		["Plane - Illidan"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["bagFont"] = {
				["name"] = "ABF",
				["size"] = 15,
			},
			["sectionFont"] = {
				["name"] = "ABF",
			},
			["autoDeposit"] = true,
			["skin"] = {
				["BackpackColor"] = {
					nil, -- [1]
					nil, -- [2]
					nil, -- [3]
					0.759052589535713, -- [4]
				},
			},
		},
		["Comet - Illidan"] = {
			["virtualStacks"] = {
				["incomplete"] = true,
			},
			["scale"] = 0.9,
			["skin"] = {
				["ReagentBankColor"] = {
					nil, -- [1]
					0.501960784313726, -- [2]
					nil, -- [3]
					0.75, -- [4]
				},
				["BankColor"] = {
					nil, -- [1]
					nil, -- [2]
					0.501960784313726, -- [3]
					0.75, -- [4]
				},
				["border"] = "Details BarBorder 1",
				["insets"] = 0,
			},
			["bagFont"] = {
				["name"] = "Arial Narrow",
			},
			["compactLayout"] = true,
			["rightClickConfig"] = false,
			["autoDeposit"] = true,
			["qualityOpacity"] = 0.5,
			["sectionFont"] = {
				["name"] = "Arial Narrow",
			},
		},
	},
}
