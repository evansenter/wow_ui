
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
		["MoneyFrame"] = {
		},
		["DataSource"] = {
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
						["Illustrious Jewelcrafter's Token"] = false,
						["Curious Coin"] = false,
						["Order Resources"] = false,
						["Veiled Argunite"] = false,
						["Warforged Seal"] = false,
						["Seal of Broken Fate"] = false,
						["Mogu Rune of Fate"] = false,
						["Timewarped Badge"] = false,
						["Oil"] = false,
						["Garrison Resources"] = false,
						["Seal of Inevitable Fate"] = false,
						["Lesser Charm of Good Fortune"] = false,
						["Seal of Tempered Fate"] = false,
						["Timeless Coin"] = false,
						["Sightless Eye"] = false,
						["Wakening Essence"] = false,
						["Essence of Corrupted Deathwing"] = false,
						["Apexis Crystal"] = false,
						["Ironpaw Token"] = false,
						["Mote of Darkness"] = false,
						["Tol Barad Commendation"] = false,
						["Ancient Mana"] = false,
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
		["Junk"] = {
		},
		["Equipment"] = {
		},
	},
	["profileKeys"] = {
		["Cometstorm - Illidan"] = "Comet - Illidan",
		["Ereinion - Dark Iron"] = "Default",
		["Comet - Illidan"] = "Comet - Illidan",
		["Plane - Illidan"] = "Default",
		["Evan - Illidan"] = "Comet - Illidan",
		["Combustion - Illidan"] = "Comet - Illidan",
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
				["BackpackColor"] = {
					nil, -- [1]
					nil, -- [2]
					nil, -- [3]
					0.754109442234039, -- [4]
				},
				["BankColor"] = {
					nil, -- [1]
					nil, -- [2]
					0.501960784313726, -- [3]
					0.75, -- [4]
				},
				["border"] = "None",
				["insets"] = 0,
			},
			["bagFont"] = {
				["name"] = "ABF",
			},
			["compactLayout"] = true,
			["rightClickConfig"] = false,
			["autoDeposit"] = true,
			["qualityOpacity"] = 0.75,
			["sectionFont"] = {
				["name"] = "ABF",
			},
		},
	},
}