
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
						[141446] = "Consumable#Consumable",
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
		["CurrencyFrame"] = {
			["profiles"] = {
				["Comet - Illidan"] = {
					["shown"] = {
						["Elder Charm of Good Fortune"] = false,
						["Valor"] = false,
						["Illustrious Jewelcrafter's Token"] = false,
						["Curious Coin"] = false,
						["Warforged Seal"] = false,
						["Timewarped Badge"] = false,
						["Ironpaw Token"] = false,
						["Seal of Tempered Fate"] = false,
						["Sightless Eye"] = false,
						["Timeless Coin"] = false,
						["Essence of Corrupted Deathwing"] = false,
						["Apexis Crystal"] = false,
						["Lesser Charm of Good Fortune"] = false,
						["Seal of Inevitable Fate"] = false,
						["Garrison Resources"] = false,
						["Oil"] = false,
						["Lingering Soul Fragment"] = false,
						["Mogu Rune of Fate"] = false,
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
		["ItemSets"] = {
		},
		["Junk"] = {
		},
		["MoneyFrame"] = {
		},
	},
	["profileKeys"] = {
		["Combustion - Illidan"] = "Comet - Illidan",
		["Cometstorm - Illidan"] = "Comet - Illidan",
		["Comet - Illidan"] = "Comet - Illidan",
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
