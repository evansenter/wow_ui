
ElvDB = {
	["profileKeys"] = {
		["Venala - Cho'gall"] = "Pandatal - Illidan",
		["Combustion - Illidan"] = "Pandatal - Illidan",
		["Centromere - Dark Iron"] = "Pandatal - Illidan",
		["Pandatal - Illidan"] = "Pandatal - Illidan",
		["Plane - Illidan"] = "Pandatal - Illidan",
		["Colton - Dark Iron"] = "Colton - Dark Iron",
		["Natalan - Dark Iron"] = "Natalan - Dark Iron",
		["Ereinion - Dark Iron"] = "Ereinion - Dark Iron",
		["Natal - Illidan"] = "Pandatal - Illidan",
		["Comet - Illidan"] = "Pandatal - Illidan",
		["Natalan - Illidan"] = "Pandatal - Illidan",
		["Evan - Illidan"] = "Pandatal - Illidan",
		["Metal - Illidan"] = "Pandatal - Illidan",
	},
	["gold"] = {
		["Dark Iron"] = {
			["Centromere"] = 229053,
			["Colton"] = 9570,
			["Ereinion"] = 2181,
		},
		["Illidan"] = {
			["Comet"] = 2217812300,
			["Evan"] = 51916597,
			["Combustion"] = 3728207,
			["Natal"] = 272625,
			["Plane"] = 498891,
			["Metal"] = 57557229,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["global"] = {
		["nameplate"] = {
			["filter"] = {
				["Bloodworm"] = {
					["hide"] = true,
					["color"] = {
						["r"] = 0.407843137254902,
						["g"] = 0.541176470588235,
						["b"] = 0.850980392156863,
					},
					["enable"] = true,
					["customScale"] = 1,
					["customColor"] = false,
				},
			},
		},
		["unitframe"] = {
			["aurafilters"] = {
				["Whitelist"] = {
					["type"] = "Blacklist",
				},
			},
			["ChannelTicks"] = {
				["Insanity"] = 3,
				["Mind Flay"] = 3,
			},
		},
		["general"] = {
			["smallerWorldMap"] = false,
		},
		["ignoreIncompatible"] = true,
		["screenwidth"] = 1920,
		["screenheight"] = 1200,
	},
	["profiles"] = {
		["Natalan - Illidan"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["combat"] = true,
				["auraFont"] = "2002",
				["healthtext"] = "PERCENT",
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["lowHealthWarningThreshold"] = 0.25,
				["auraFontOutline"] = "OUTLINE",
				["showlevel"] = false,
				["badscale"] = 1.3,
			},
			["currentTutorial"] = 15,
			["general"] = {
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["autoRepair"] = "GUILD",
				["mapAlpha"] = 0.75,
				["health_backdrop"] = {
				},
				["font"] = "ABF",
				["bottomPanel"] = false,
				["health"] = {
				},
				["valuecolor"] = {
					["b"] = 0.04,
					["g"] = 0.49,
					["r"] = 1,
				},
				["topPanel"] = false,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["tapped"] = {
				},
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOMElvUIParentBOTTOM0551",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-43429",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM082",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM2604",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM043",
				["ElvAB_5"] = "TOPRIGHTElvUIParentTOPRIGHT-4-395",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4454",
				["ShiftAB"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFTElvUIParentTOPLEFT14-8",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM280332",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464151",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4287",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4551",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0350",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
			},
			["tooltip"] = {
				["anchor"] = "ANCHOR",
				["combathide"] = true,
			},
			["auras"] = {
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["fontSize"] = 12,
					["durations"] = false,
					["filter"] = false,
				},
				["buffs"] = {
					["sortMethod"] = "INDEX",
				},
				["font"] = "ABF",
				["fontSize"] = 14,
			},
			["unitframe"] = {
				["fontSize"] = 14,
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["castColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["transparentCastbar"] = true,
					["colorhealthbyvalue"] = false,
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
					["tapped"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.32156862745098,
					},
					["castClassColor"] = true,
					["transparentPower"] = true,
					["health"] = {
						["b"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["r"] = 0.149019607843137,
					},
					["transparentAurabars"] = true,
					["powerclass"] = true,
					["transparentHealth"] = true,
				},
				["fontOutline"] = "NONE",
				["font"] = "ABF",
				["units"] = {
					["raid10"] = {
						["enable"] = false,
					},
					["targettarget"] = {
						["debuffs"] = {
							["fontSize"] = 14,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["enable"] = false,
						["buffs"] = {
							["fontSize"] = 14,
						},
						["name"] = {
							["position"] = "LEFT",
						},
						["width"] = 200,
					},
					["party"] = {
						["horizontalSpacing"] = 5,
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 0,
							["initialAnchor"] = "TOPLEFT",
							["useFilter"] = "Blacklist",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["growthDirection"] = "RIGHT_UP",
						["health"] = {
							["orientation"] = "VERTICAL",
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["yOffset"] = 1,
							["width"] = 80,
						},
						["height"] = 52,
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["yOffset"] = 1,
							["xOffset"] = 0,
							["width"] = 80,
						},
						["width"] = 80,
					},
					["target"] = {
						["debuffs"] = {
							["attachTo"] = "FRAME",
							["fontSize"] = 16,
							["useFilter"] = "Whitelist",
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 4,
							["width"] = 50,
						},
						["enable"] = false,
						["buffs"] = {
							["noConsolidated"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["fontSize"] = 16,
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["noDuration"] = {
								["friendly"] = true,
							},
							["playerOnly"] = {
								["enemy"] = true,
							},
							["attachTo"] = "DEBUFFS",
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["enable"] = false,
							["playerOnly"] = {
								["friendly"] = false,
							},
							["noDuration"] = {
								["enemy"] = false,
							},
							["height"] = 18,
						},
					},
					["player"] = {
						["restIcon"] = false,
						["debuffs"] = {
							["fontSize"] = 16,
						},
						["portrait"] = {
							["width"] = 50,
						},
						["castbar"] = {
							["enable"] = false,
						},
						["enable"] = false,
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["aurabar"] = {
							["noDuration"] = false,
							["playerOnly"] = false,
							["enable"] = false,
							["height"] = 18,
						},
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["buffs"] = {
							["noDuration"] = false,
							["fontSize"] = 16,
							["playerOnly"] = false,
							["enable"] = true,
						},
						["lowmana"] = 0,
						["pvp"] = {
							["text_format"] = "",
						},
					},
					["raid40"] = {
						["roleIcon"] = {
							["enable"] = true,
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["text"] = true,
							["frequentUpdates"] = true,
						},
						["enable"] = false,
						["healPrediction"] = true,
						["name"] = {
							["position"] = "TOP",
						},
						["height"] = 36,
					},
					["focus"] = {
						["enable"] = false,
					},
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
						},
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["boss"] = {
						["power"] = {
							["text_format"] = "",
						},
						["castbar"] = {
							["width"] = 225,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["width"] = 225,
					},
					["pet"] = {
						["enable"] = false,
						["name"] = {
							["position"] = "LEFT",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["width"] = 200,
					},
				},
			},
			["datatexts"] = {
				["time24"] = true,
				["panels"] = {
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "WeakAuras",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["font"] = "ABF",
			},
			["actionbar"] = {
				["bar3"] = {
					["buttonsPerRow"] = 12,
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["bar2"] = {
					["enabled"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["enablecd"] = false,
				["fontOutline"] = "OUTLINE",
				["macrotext"] = true,
				["bar5"] = {
					["point"] = "TOPRIGHT",
					["buttonsPerRow"] = 1,
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["noRangeColor"] = {
					["b"] = 0.247058823529412,
					["g"] = 0.235294117647059,
					["r"] = 0.250980392156863,
				},
				["bar4"] = {
					["enabled"] = false,
					["point"] = "TOPLEFT",
					["buttons"] = 3,
					["buttonsPerRow"] = 3,
					["alpha"] = 0.5,
					["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [spec:2] hide; show",
				},
			},
			["layoutSet"] = "healer",
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["emotionIcons"] = false,
			},
			["raidcooldown"] = {
				["enable"] = false,
				["castannounce"] = true,
				["cdannounce"] = true,
			},
		},
		["Combustion - Illidan"] = {
			["bagsOffsetFixed"] = true,
			["currentTutorial"] = 2,
		},
		["Plane - Illidan"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["badscale"] = 1.3,
				["auraFont"] = "2002",
				["lowHealthWarningThreshold"] = 0.25,
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["auraFontOutline"] = "OUTLINE",
				["healthtext"] = "PERCENT",
				["showlevel"] = false,
				["combat"] = true,
			},
			["currentTutorial"] = 3,
			["general"] = {
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["autoRepair"] = "GUILD",
				["mapAlpha"] = 0.75,
				["health"] = {
				},
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["tapped"] = {
				},
				["valuecolor"] = {
					["r"] = 1,
					["g"] = 0.49,
					["b"] = 0.04,
				},
				["topPanel"] = false,
				["font"] = "ABF",
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOMElvUIParentBOTTOM0551",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-43429",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM082",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM2604",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM043",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFTElvUIParentTOPLEFT14-8",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
				["ShiftAB"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT565100",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM280332",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4287",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4551",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464151",
				["ElvAB_5"] = "TOPRIGHTElvUIParentTOPRIGHT-4-395",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4454",
			},
			["tooltip"] = {
				["anchor"] = "ANCHOR",
				["healthBar"] = {
					["font"] = "ABF",
					["fontSize"] = 12,
				},
				["combathide"] = true,
			},
			["auras"] = {
				["fontSize"] = 14,
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["durations"] = false,
					["filter"] = false,
				},
				["buffs"] = {
					["sortMethod"] = "INDEX",
				},
				["font"] = "ABF",
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
			},
			["unitframe"] = {
				["fontSize"] = 14,
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["castColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["transparentHealth"] = true,
					["colorhealthbyvalue"] = false,
					["health"] = {
						["r"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["b"] = 0.149019607843137,
					},
					["tapped"] = {
						["r"] = 0.32156862745098,
						["g"] = 0,
						["b"] = 0,
					},
					["castClassColor"] = true,
					["powerclass"] = true,
					["transparentCastbar"] = true,
					["transparentAurabars"] = true,
					["transparentPower"] = true,
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
				},
				["fontOutline"] = "NONE",
				["font"] = "ABF",
				["units"] = {
					["raid10"] = {
						["enable"] = false,
					},
					["targettarget"] = {
						["debuffs"] = {
							["fontSize"] = 14,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["enable"] = false,
						["buffs"] = {
							["fontSize"] = 14,
						},
						["name"] = {
							["position"] = "LEFT",
						},
						["width"] = 200,
					},
					["pet"] = {
						["enable"] = false,
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["name"] = {
							["position"] = "LEFT",
						},
						["width"] = 200,
					},
					["party"] = {
						["horizontalSpacing"] = 5,
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 0,
							["useFilter"] = "Blacklist",
							["initialAnchor"] = "TOPLEFT",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["growthDirection"] = "RIGHT_UP",
						["health"] = {
							["orientation"] = "VERTICAL",
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["width"] = 80,
						["height"] = 52,
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["width"] = 80,
							["xOffset"] = 0,
							["yOffset"] = 1,
						},
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["width"] = 80,
							["yOffset"] = 1,
						},
					},
					["boss"] = {
						["castbar"] = {
							["width"] = 225,
						},
						["width"] = 225,
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["power"] = {
							["text_format"] = "",
						},
					},
					["raid40"] = {
						["roleIcon"] = {
							["enable"] = true,
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["text"] = true,
							["frequentUpdates"] = true,
						},
						["enable"] = false,
						["healPrediction"] = true,
						["name"] = {
							["position"] = "TOP",
						},
						["height"] = 36,
					},
					["focus"] = {
						["enable"] = false,
					},
					["target"] = {
						["debuffs"] = {
							["attachTo"] = "FRAME",
							["fontSize"] = 16,
							["useFilter"] = "Whitelist",
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
							["camDistanceScale"] = 4,
							["width"] = 50,
						},
						["enable"] = false,
						["buffs"] = {
							["noConsolidated"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["fontSize"] = 16,
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["noDuration"] = {
								["friendly"] = true,
							},
							["playerOnly"] = {
								["enemy"] = true,
							},
							["attachTo"] = "DEBUFFS",
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["enable"] = false,
							["playerOnly"] = {
								["friendly"] = false,
							},
							["noDuration"] = {
								["enemy"] = false,
							},
							["height"] = 18,
						},
					},
					["arena"] = {
						["width"] = 200,
						["castbar"] = {
							["width"] = 200,
						},
					},
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
						},
					},
					["player"] = {
						["restIcon"] = false,
						["debuffs"] = {
							["fontSize"] = 16,
						},
						["portrait"] = {
							["width"] = 50,
						},
						["castbar"] = {
							["enable"] = false,
						},
						["enable"] = false,
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["aurabar"] = {
							["enable"] = false,
							["playerOnly"] = false,
							["noDuration"] = false,
							["height"] = 18,
						},
						["lowmana"] = 0,
						["buffs"] = {
							["noDuration"] = false,
							["fontSize"] = 16,
							["playerOnly"] = false,
							["enable"] = true,
						},
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["pvp"] = {
							["text_format"] = "",
						},
					},
				},
			},
			["datatexts"] = {
				["time24"] = true,
				["panels"] = {
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "WeakAuras",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["font"] = "ABF",
			},
			["actionbar"] = {
				["bar3"] = {
					["buttonsPerRow"] = 12,
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["bar2"] = {
					["enabled"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["enablecd"] = false,
				["fontOutline"] = "OUTLINE",
				["macrotext"] = true,
				["bar5"] = {
					["point"] = "TOPRIGHT",
					["buttonsPerRow"] = 1,
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["noRangeColor"] = {
					["r"] = 0.250980392156863,
					["g"] = 0.235294117647059,
					["b"] = 0.247058823529412,
				},
				["bar4"] = {
					["point"] = "TOPLEFT",
					["buttons"] = 3,
					["buttonsPerRow"] = 3,
					["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [spec:2] hide; show",
					["alpha"] = 0.5,
				},
			},
			["layoutSet"] = "healer",
			["raidcooldown"] = {
				["castannounce"] = true,
				["enable"] = false,
				["cdannounce"] = true,
			},
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["emotionIcons"] = false,
			},
		},
		["Centromere - Dark Iron"] = {
			["currentTutorial"] = 2,
		},
		["Natal - Illidan"] = {
			["currentTutorial"] = 1,
		},
		["Venala - Cho'gall"] = {
		},
		["Colton - Dark Iron"] = {
			["currentTutorial"] = 1,
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT4424",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41196",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4427",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
			},
		},
		["Natalan - Dark Iron"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["badscale"] = 1.3,
				["auraFont"] = "2002",
				["healthtext"] = "PERCENT",
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["combat"] = true,
				["lowHealthWarningThreshold"] = 0.25,
				["showlevel"] = false,
				["auraFontOutline"] = "OUTLINE",
			},
			["currentTutorial"] = 1,
			["general"] = {
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["mapAlpha"] = 0.75,
				["font"] = "ABF",
				["bottomPanel"] = false,
				["health"] = {
				},
				["valuecolor"] = {
					["b"] = 0.87,
					["g"] = 0.44,
					["r"] = 0,
				},
				["tapped"] = {
				},
				["topPanel"] = false,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOMElvUIParentBOTTOM0551",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-43429",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM082",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM2604",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM043",
				["ElvAB_5"] = "TOPRIGHTElvUIParentTOPRIGHT-4-395",
				["ShiftAB"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM280332",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4454",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFTElvUIParentTOPLEFT14-8",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4551",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464151",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0350",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
			},
			["tooltip"] = {
				["combathide"] = true,
			},
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["emotionIcons"] = false,
			},
			["unitframe"] = {
				["fontSize"] = 14,
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["castColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["transparentHealth"] = true,
					["transparentCastbar"] = true,
					["tapped"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.32156862745098,
					},
					["castClassColor"] = true,
					["powerclass"] = true,
					["transparentAurabars"] = true,
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
					["transparentPower"] = true,
					["health"] = {
						["b"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["r"] = 0.149019607843137,
					},
				},
				["fontOutline"] = "NONE",
				["font"] = "ABF",
				["units"] = {
					["raid10"] = {
						["enable"] = false,
					},
					["pet"] = {
						["name"] = {
							["position"] = "LEFT",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["width"] = 200,
					},
					["player"] = {
						["restIcon"] = false,
						["debuffs"] = {
							["fontSize"] = 16,
						},
						["castbar"] = {
							["enable"] = false,
						},
						["combatfade"] = true,
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["aurabar"] = {
							["noDuration"] = false,
							["playerOnly"] = false,
							["enable"] = false,
							["height"] = 18,
						},
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["buffs"] = {
							["enable"] = true,
							["fontSize"] = 16,
							["playerOnly"] = false,
							["noDuration"] = false,
						},
						["pvp"] = {
							["text_format"] = "",
						},
						["lowmana"] = 0,
					},
					["party"] = {
						["horizontalSpacing"] = 5,
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 0,
							["initialAnchor"] = "TOPLEFT",
							["useFilter"] = "Blacklist",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["growthDirection"] = "RIGHT_UP",
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["yOffset"] = 1,
							["width"] = 80,
						},
						["height"] = 52,
						["health"] = {
							["orientation"] = "VERTICAL",
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["yOffset"] = 1,
							["xOffset"] = 0,
							["width"] = 80,
						},
						["width"] = 80,
					},
					["raid40"] = {
						["roleIcon"] = {
							["enable"] = true,
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["text"] = true,
							["frequentUpdates"] = true,
						},
						["enable"] = false,
						["healPrediction"] = true,
						["name"] = {
							["position"] = "TOP",
						},
						["height"] = 36,
					},
					["target"] = {
						["debuffs"] = {
							["attachTo"] = "FRAME",
							["fontSize"] = 16,
						},
						["buffs"] = {
							["attachTo"] = "DEBUFFS",
							["fontSize"] = 16,
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["noDuration"] = {
								["friendly"] = true,
							},
							["playerOnly"] = {
								["enemy"] = true,
							},
							["noConsolidated"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
						},
						["portrait"] = {
							["width"] = 50,
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["enable"] = false,
							["playerOnly"] = {
								["friendly"] = false,
							},
							["noDuration"] = {
								["enemy"] = false,
							},
							["height"] = 18,
						},
					},
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
						},
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["boss"] = {
						["power"] = {
							["text_format"] = "",
						},
						["castbar"] = {
							["width"] = 225,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["width"] = 225,
					},
					["targettarget"] = {
						["debuffs"] = {
							["fontSize"] = 14,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["buffs"] = {
							["fontSize"] = 14,
						},
						["name"] = {
							["position"] = "LEFT",
						},
						["width"] = 200,
					},
				},
			},
			["datatexts"] = {
				["time24"] = true,
				["panels"] = {
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "WeakAuras",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["font"] = "ABF",
			},
			["actionbar"] = {
				["bar3"] = {
					["buttonsPerRow"] = 12,
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["bar2"] = {
					["enabled"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["enablecd"] = false,
				["fontOutline"] = "OUTLINE",
				["macrotext"] = true,
				["bar5"] = {
					["enabled"] = false,
					["point"] = "TOPRIGHT",
					["buttons"] = 12,
					["buttonsPerRow"] = 1,
					["backdrop"] = true,
				},
				["noRangeColor"] = {
					["b"] = 0.247058823529412,
					["g"] = 0.235294117647059,
					["r"] = 0.250980392156863,
				},
				["bar4"] = {
					["enabled"] = false,
					["point"] = "TOPLEFT",
					["buttons"] = 3,
					["buttonsPerRow"] = 3,
					["alpha"] = 0.5,
					["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [spec:2] hide; show",
				},
			},
			["layoutSet"] = "healer",
			["raidcooldown"] = {
				["enable"] = false,
				["castannounce"] = true,
				["cdannounce"] = true,
			},
			["auras"] = {
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["durations"] = false,
					["filter"] = false,
				},
				["buffs"] = {
					["sortMethod"] = "INDEX",
				},
				["fontSize"] = 14,
				["font"] = "ABF",
			},
		},
		["Default"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["badscale"] = 1.3,
				["auraFont"] = "2002",
				["lowHealthWarningThreshold"] = 0.25,
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["combat"] = true,
				["healthtext"] = "PERCENT",
				["showlevel"] = false,
				["auraFontOutline"] = "OUTLINE",
			},
			["currentTutorial"] = 8,
			["general"] = {
				["interruptAnnounce"] = "SAY",
				["autoRepair"] = "GUILD",
				["mapAlpha"] = 0.75,
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["a"] = 0.597886353731155,
					["b"] = 0.0588235294117647,
					["g"] = 0.0588235294117647,
					["r"] = 0.0588235294117647,
				},
				["valuecolor"] = {
					["a"] = 1,
					["b"] = 0.474509803921569,
					["g"] = 1,
					["r"] = 0.12156862745098,
				},
				["threat"] = {
					["enable"] = false,
				},
				["topPanel"] = false,
				["autoRoll"] = true,
				["tapped"] = {
				},
				["health"] = {
				},
				["reputation"] = {
					["enable"] = false,
				},
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 150,
				},
				["experience"] = {
					["enable"] = false,
				},
				["font"] = "ABF",
				["vendorGrays"] = true,
			},
			["movers"] = {
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4389",
				["BossHeaderMover"] = "TOPLEFTElvUIParentTOPLEFT4-375",
				["ElvUF_RaidpetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0217",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_AssistMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-267249",
				["TotemBarMover"] = "TOPLEFTElvUIParentTOPLEFT4-50",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-3280",
			},
			["tooltip"] = {
				["anchor"] = "ANCHOR",
				["visibility"] = {
					["combat"] = true,
				},
				["healthBar"] = {
					["height"] = 2,
					["text"] = false,
					["fontSize"] = 12,
					["font"] = "ABF",
				},
				["combathide"] = true,
			},
			["hideTutorial"] = 1,
			["auras"] = {
				["fontSize"] = 16,
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["font"] = "ABF",
					["fontSize"] = 16,
					["fontOutline"] = "OUTLINE",
				},
				["buffs"] = {
					["sortMethod"] = "INDEX",
				},
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
				["font"] = "ABF",
			},
			["unitframe"] = {
				["hideroleincombat"] = true,
				["fontSize"] = 14,
				["colors"] = {
					["customhealthbackdrop"] = true,
					["health_backdrop"] = {
						["b"] = 0.0666666666666667,
						["g"] = 0.0666666666666667,
						["r"] = 0.0666666666666667,
					},
					["colorhealthbyvalue"] = false,
					["transparentHealth"] = true,
				},
				["fontOutline"] = "NONE",
				["statusbar"] = "BantoBar",
				["font"] = "ABF",
				["autoRoleSet"] = true,
				["units"] = {
					["tank"] = {
						["enable"] = false,
					},
					["raid10"] = {
						["enable"] = false,
					},
					["targettarget"] = {
						["enable"] = false,
					},
					["player"] = {
						["enable"] = false,
					},
					["target"] = {
						["enable"] = false,
					},
					["party"] = {
						["enable"] = false,
					},
					["raid40"] = {
						["enable"] = false,
					},
					["focus"] = {
						["enable"] = false,
					},
					["assist"] = {
						["enable"] = false,
					},
					["raid25"] = {
						["enable"] = false,
					},
					["boss"] = {
						["debuffs"] = {
							["anchorPoint"] = "RIGHT",
							["sizeOverride"] = 26,
							["perrow"] = 4,
							["clickThrough"] = true,
							["xOffset"] = 2,
							["fontSize"] = 14,
							["numrows"] = 1,
							["yOffset"] = -14,
						},
						["portrait"] = {
							["overlay"] = true,
							["camDistanceScale"] = 3,
						},
						["castbar"] = {
							["height"] = 20,
							["width"] = 310,
						},
						["width"] = 310,
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
							["position"] = "RIGHT",
						},
						["power"] = {
							["height"] = 3,
						},
						["height"] = 60,
						["buffs"] = {
							["anchorPoint"] = "RIGHT",
							["sizeOverride"] = 26,
							["clickThrough"] = true,
							["xOffset"] = 2,
							["perrow"] = 4,
							["fontSize"] = 14,
							["yOffset"] = 13,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:long]",
						},
						["threatStyle"] = "BORDERS",
					},
					["pet"] = {
						["enable"] = false,
					},
				},
			},
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ABF",
				["panelTransparency"] = true,
				["time24"] = true,
				["panels"] = {
					["RightChatDataPanel"] = {
						["left"] = "Durability",
					},
					["LeftChatDataPanel"] = {
						["right"] = "System",
						["left"] = "WeakAuras",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["actionbar1"] = false,
			},
			["actionbar"] = {
				["enablecd"] = false,
			},
			["layoutSet"] = "healer",
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow TTF",
				["tabFontSize"] = 12,
				["emotionIcons"] = false,
			},
			["raidcooldown"] = {
				["enable"] = false,
				["castannounce"] = true,
				["cdannounce"] = true,
			},
		},
		["Pandatal - Illidan"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["combat"] = true,
				["auraFontSize"] = 12,
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["badscale"] = 1.3,
				["healthtext"] = "PERCENT",
				["auraFont"] = "2002",
				["lowHealthWarningThreshold"] = 0.25,
				["font"] = "ABF",
				["auraFontOutline"] = "OUTLINE",
				["showlevel"] = false,
			},
			["currentTutorial"] = 9,
			["general"] = {
				["totems"] = {
					["size"] = 32,
				},
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["afk"] = false,
				["autoRepair"] = "GUILD",
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 150,
				},
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["backdropcolor"] = {
					["b"] = 0.101960784313725,
					["g"] = 0.101960784313725,
					["r"] = 0.101960784313725,
				},
				["topPanel"] = false,
				["autoRoll"] = true,
				["tapped"] = {
				},
				["health"] = {
				},
				["vendorGrays"] = true,
				["font"] = "ABF",
				["mapAlpha"] = 0.75,
				["reputation"] = {
					["enable"] = false,
				},
				["experience"] = {
					["enable"] = false,
				},
			},
			["hideTutorial"] = 1,
			["auras"] = {
				["fontSize"] = 16,
				["font"] = "ABF",
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["font"] = "ABF",
					["fontSize"] = 16,
					["fontOutline"] = "OUTLINE",
					["durations"] = false,
				},
				["buffs"] = {
					["sortMethod"] = "INDEX",
				},
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
			},
			["layoutSet"] = "healer",
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ObjectiveFrameMover"] = "TOPLEFTElvUIParentTOPLEFT135-300",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1757392",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4427",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-3285",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4389",
				["BossHeaderMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4350",
				["TotemBarMover"] = "TOPLEFTElvUIParentTOPLEFT4-45",
				["ElvUF_AssistMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-267249",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT4424",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-4",
			},
			["tooltip"] = {
				["healthBar"] = {
					["height"] = 2,
					["fontSize"] = 12,
					["text"] = false,
					["font"] = "ABF",
				},
				["combathide"] = true,
				["anchor"] = "ANCHOR",
				["visibility"] = {
					["combat"] = true,
				},
			},
			["unitframe"] = {
				["hideroleincombat"] = true,
				["fontSize"] = 14,
				["units"] = {
					["tank"] = {
						["enable"] = false,
					},
					["party"] = {
						["enable"] = false,
					},
					["raid40"] = {
						["enable"] = false,
					},
					["focus"] = {
						["enable"] = false,
					},
					["assist"] = {
						["enable"] = false,
					},
					["pet"] = {
						["enable"] = false,
					},
					["targettarget"] = {
						["enable"] = false,
					},
					["player"] = {
						["enable"] = false,
					},
					["arena"] = {
						["enable"] = false,
					},
					["boss"] = {
						["debuffs"] = {
							["sizeOverride"] = 21,
							["yOffset"] = -12,
							["anchorPoint"] = "RIGHT",
							["clickThrough"] = true,
							["numrows"] = 1,
							["perrow"] = 4,
							["fontSize"] = 14,
							["xOffset"] = 3,
						},
						["portrait"] = {
							["overlay"] = true,
							["camDistanceScale"] = 3,
						},
						["castbar"] = {
							["height"] = 15,
							["width"] = 310,
						},
						["enable"] = false,
						["threatStyle"] = "BORDERS",
						["width"] = 310,
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
							["yOffset"] = -2,
						},
						["power"] = {
							["yOffset"] = 1,
							["height"] = 3,
						},
						["height"] = 45,
						["buffs"] = {
							["sizeOverride"] = 21,
							["anchorPoint"] = "RIGHT",
							["clickThrough"] = true,
							["perrow"] = 4,
							["fontSize"] = 14,
							["xOffset"] = 3,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:long]",
						},
					},
					["target"] = {
						["enable"] = false,
					},
				},
				["statusbar"] = "BantoBar",
				["colors"] = {
					["colorhealthbyvalue"] = false,
					["customhealthbackdrop"] = true,
					["health_backdrop"] = {
						["r"] = 0.0666666666666667,
						["g"] = 0.0666666666666667,
						["b"] = 0.0666666666666667,
					},
					["transparentHealth"] = true,
				},
				["fontOutline"] = "NONE",
				["autoRoleSet"] = true,
				["font"] = "ABF",
			},
			["datatexts"] = {
				["fontSize"] = 12,
				["panelTransparency"] = true,
				["time24"] = true,
				["panels"] = {
					["RightChatDataPanel"] = {
						["left"] = "Durability",
					},
					["LeftChatDataPanel"] = {
						["right"] = "System",
						["left"] = "Simple iLevel",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["font"] = "ABF",
				["actionbar1"] = false,
			},
			["actionbar"] = {
				["enablecd"] = false,
			},
			["chat"] = {
				["tabFontSize"] = 12,
				["keywords"] = "%MYNAME%",
				["font"] = "Arial Narrow",
				["tabFont"] = "ABF",
				["emotionIcons"] = false,
			},
			["raidcooldown"] = {
				["castannounce"] = true,
				["enable"] = false,
				["cdannounce"] = true,
			},
		},
		["Comet - Illidan"] = {
			["currentTutorial"] = 1,
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4427",
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT4424",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
			},
		},
		["Ereinion - Dark Iron"] = {
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT4424",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41196",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4427",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
			},
		},
		["Evan - Illidan"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["badscale"] = 1.3,
				["auraFont"] = "2002",
				["healthtext"] = "PERCENT",
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["lowHealthWarningThreshold"] = 0.25,
				["combat"] = true,
				["showlevel"] = false,
				["auraFontOutline"] = "OUTLINE",
			},
			["currentTutorial"] = 3,
			["raidcooldown"] = {
				["enable"] = false,
				["castannounce"] = true,
				["cdannounce"] = true,
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOMElvUIParentBOTTOM0551",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-43429",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM082",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM2604",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM043",
				["ElvAB_5"] = "TOPRIGHTElvUIParentTOPRIGHT-4-395",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4454",
				["ShiftAB"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFTElvUIParentTOPLEFT14-8",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM280332",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464151",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4287",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4551",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT565100",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
			},
			["tooltip"] = {
				["anchor"] = "ANCHOR",
				["healthBar"] = {
					["font"] = "ABF",
					["fontSize"] = 12,
				},
				["combathide"] = true,
			},
			["auras"] = {
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["durations"] = false,
					["filter"] = false,
				},
				["buffs"] = {
					["sortMethod"] = "INDEX",
				},
				["font"] = "ABF",
				["fontSize"] = 14,
			},
			["unitframe"] = {
				["fontSize"] = 14,
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["castColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["transparentCastbar"] = true,
					["colorhealthbyvalue"] = false,
					["transparentHealth"] = true,
					["tapped"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.32156862745098,
					},
					["transparentAurabars"] = true,
					["powerclass"] = true,
					["health"] = {
						["b"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["r"] = 0.149019607843137,
					},
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
					["transparentPower"] = true,
					["castClassColor"] = true,
				},
				["fontOutline"] = "NONE",
				["font"] = "ABF",
				["units"] = {
					["raid10"] = {
						["enable"] = false,
					},
					["pet"] = {
						["enable"] = false,
						["name"] = {
							["position"] = "LEFT",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["width"] = 200,
					},
					["player"] = {
						["restIcon"] = false,
						["debuffs"] = {
							["fontSize"] = 16,
						},
						["portrait"] = {
							["width"] = 50,
						},
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["enable"] = false,
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["aurabar"] = {
							["enable"] = false,
							["playerOnly"] = false,
							["noDuration"] = false,
							["height"] = 18,
						},
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["enable"] = true,
							["fontSize"] = 16,
							["playerOnly"] = false,
							["noDuration"] = false,
						},
						["pvp"] = {
							["text_format"] = "",
						},
						["lowmana"] = 0,
					},
					["target"] = {
						["debuffs"] = {
							["attachTo"] = "FRAME",
							["fontSize"] = 16,
							["useFilter"] = "Whitelist",
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 4,
							["width"] = 50,
						},
						["enable"] = false,
						["buffs"] = {
							["noConsolidated"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["fontSize"] = 16,
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["noDuration"] = {
								["friendly"] = true,
							},
							["playerOnly"] = {
								["enemy"] = true,
							},
							["attachTo"] = "DEBUFFS",
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["noDuration"] = {
								["enemy"] = false,
							},
							["playerOnly"] = {
								["friendly"] = false,
							},
							["enable"] = false,
							["height"] = 18,
						},
					},
					["boss"] = {
						["power"] = {
							["text_format"] = "",
						},
						["castbar"] = {
							["width"] = 225,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["width"] = 225,
					},
					["raid40"] = {
						["roleIcon"] = {
							["enable"] = true,
						},
						["name"] = {
							["position"] = "TOP",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["orientation"] = "VERTICAL",
							["text"] = true,
							["frequentUpdates"] = true,
						},
						["height"] = 36,
					},
					["focus"] = {
						["enable"] = false,
					},
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
						},
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["party"] = {
						["horizontalSpacing"] = 5,
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 0,
							["useFilter"] = "Blacklist",
							["initialAnchor"] = "TOPLEFT",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["growthDirection"] = "RIGHT_UP",
						["health"] = {
							["orientation"] = "VERTICAL",
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["yOffset"] = 1,
							["width"] = 80,
						},
						["height"] = 52,
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["yOffset"] = 1,
							["xOffset"] = 0,
							["width"] = 80,
						},
						["width"] = 80,
					},
					["targettarget"] = {
						["debuffs"] = {
							["fontSize"] = 14,
						},
						["name"] = {
							["position"] = "LEFT",
						},
						["enable"] = false,
						["buffs"] = {
							["fontSize"] = 14,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["width"] = 200,
					},
				},
			},
			["datatexts"] = {
				["time24"] = true,
				["panels"] = {
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "WeakAuras",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["font"] = "ABF",
			},
			["actionbar"] = {
				["bar3"] = {
					["buttonsPerRow"] = 12,
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["bar2"] = {
					["enabled"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["enablecd"] = false,
				["fontOutline"] = "OUTLINE",
				["macrotext"] = true,
				["bar5"] = {
					["point"] = "TOPRIGHT",
					["buttonsPerRow"] = 1,
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["noRangeColor"] = {
					["b"] = 0.247058823529412,
					["g"] = 0.235294117647059,
					["r"] = 0.250980392156863,
				},
				["bar4"] = {
					["point"] = "TOPLEFT",
					["buttons"] = 3,
					["buttonsPerRow"] = 3,
					["alpha"] = 0.5,
					["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [spec:2] hide; show",
				},
			},
			["layoutSet"] = "healer",
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["emotionIcons"] = false,
			},
			["general"] = {
				["topPanel"] = false,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "GUILD",
				["mapAlpha"] = 0.75,
				["font"] = "ABF",
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["health"] = {
				},
				["valuecolor"] = {
					["b"] = 0.99,
					["g"] = 0.99,
					["r"] = 0.99,
				},
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["tapped"] = {
				},
			},
		},
		["Metal - Illidan"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["badscale"] = 1.3,
				["auraFont"] = "2002",
				["lowHealthWarningThreshold"] = 0.25,
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["combat"] = true,
				["healthtext"] = "PERCENT",
				["showlevel"] = false,
				["auraFontOutline"] = "OUTLINE",
			},
			["currentTutorial"] = 9,
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ObjectiveFrameMover"] = "TOPLEFTElvUIParentTOPLEFT135-300",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1757392",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4427",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-3285",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4389",
				["BossHeaderMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4350",
				["TotemBarMover"] = "TOPLEFTElvUIParentTOPLEFT4-45",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-4",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT4424",
				["ElvUF_AssistMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-267249",
			},
			["tooltip"] = {
				["anchor"] = "ANCHOR",
				["healthBar"] = {
					["height"] = 2,
					["text"] = false,
					["font"] = "ABF",
					["fontSize"] = 12,
				},
				["visibility"] = {
					["combat"] = true,
				},
				["combathide"] = true,
			},
			["hideTutorial"] = 1,
			["auras"] = {
				["fontSize"] = 16,
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["font"] = "ABF",
					["fontSize"] = 16,
					["fontOutline"] = "OUTLINE",
				},
				["buffs"] = {
					["sortMethod"] = "INDEX",
				},
				["font"] = "ABF",
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
			},
			["unitframe"] = {
				["hideroleincombat"] = true,
				["fontSize"] = 14,
				["colors"] = {
					["customhealthbackdrop"] = true,
					["health_backdrop"] = {
						["r"] = 0.0666666666666667,
						["g"] = 0.0666666666666667,
						["b"] = 0.0666666666666667,
					},
					["colorhealthbyvalue"] = false,
					["transparentHealth"] = true,
				},
				["fontOutline"] = "NONE",
				["statusbar"] = "BantoBar",
				["font"] = "ABF",
				["autoRoleSet"] = true,
				["units"] = {
					["tank"] = {
						["enable"] = false,
					},
					["targettarget"] = {
						["enable"] = false,
					},
					["player"] = {
						["enable"] = false,
					},
					["assist"] = {
						["enable"] = false,
					},
					["boss"] = {
						["debuffs"] = {
							["anchorPoint"] = "RIGHT",
							["sizeOverride"] = 21,
							["yOffset"] = -12,
							["clickThrough"] = true,
							["xOffset"] = 3,
							["numrows"] = 1,
							["fontSize"] = 14,
							["perrow"] = 4,
						},
						["portrait"] = {
							["overlay"] = true,
							["camDistanceScale"] = 3,
						},
						["castbar"] = {
							["height"] = 15,
							["width"] = 310,
						},
						["enable"] = false,
						["width"] = 310,
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
							["yOffset"] = -2,
						},
						["threatStyle"] = "BORDERS",
						["height"] = 45,
						["buffs"] = {
							["anchorPoint"] = "RIGHT",
							["sizeOverride"] = 21,
							["clickThrough"] = true,
							["xOffset"] = 3,
							["fontSize"] = 14,
							["perrow"] = 4,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:long]",
						},
						["power"] = {
							["height"] = 3,
							["yOffset"] = 1,
						},
					},
					["raid40"] = {
						["enable"] = false,
					},
					["focus"] = {
						["enable"] = false,
					},
					["target"] = {
						["enable"] = false,
					},
					["arena"] = {
						["enable"] = false,
					},
					["party"] = {
						["enable"] = false,
					},
					["pet"] = {
						["enable"] = false,
					},
				},
			},
			["datatexts"] = {
				["font"] = "ABF",
				["panelTransparency"] = true,
				["actionbar1"] = false,
				["time24"] = true,
				["panels"] = {
					["RightChatDataPanel"] = {
						["left"] = "Durability",
					},
					["LeftChatDataPanel"] = {
						["right"] = "System",
						["left"] = "Simple iLevel",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["fontSize"] = 12,
			},
			["actionbar"] = {
				["enablecd"] = false,
			},
			["layoutSet"] = "healer",
			["raidcooldown"] = {
				["enable"] = false,
				["castannounce"] = true,
				["cdannounce"] = true,
			},
			["general"] = {
				["totems"] = {
					["size"] = 32,
				},
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["afk"] = false,
				["autoRepair"] = "GUILD",
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 150,
				},
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["backdropcolor"] = {
					["r"] = 0.101960784313725,
					["g"] = 0.101960784313725,
					["b"] = 0.101960784313725,
				},
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["tapped"] = {
				},
				["health"] = {
				},
				["mapAlpha"] = 0.75,
				["topPanel"] = false,
				["font"] = "ABF",
				["experience"] = {
					["enable"] = false,
				},
				["reputation"] = {
					["enable"] = false,
				},
			},
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["emotionIcons"] = false,
				["tabFontSize"] = 12,
			},
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Venala - Cho'gall"] = "Venala - Cho'gall",
		["Combustion - Illidan"] = "Combustion - Illidan",
		["Centromere - Dark Iron"] = "Centromere - Dark Iron",
		["Pandatal - Illidan"] = "Pandatal - Illidan",
		["Plane - Illidan"] = "Plane - Illidan",
		["Colton - Dark Iron"] = "Colton - Dark Iron",
		["Natalan - Dark Iron"] = "Natalan - Dark Iron",
		["Ereinion - Dark Iron"] = "Ereinion - Dark Iron",
		["Natal - Illidan"] = "Natal - Illidan",
		["Comet - Illidan"] = "Comet - Illidan",
		["Natalan - Illidan"] = "Natalan - Illidan",
		["Evan - Illidan"] = "Evan - Illidan",
		["Metal - Illidan"] = "Metal - Illidan",
	},
	["profiles"] = {
		["Venala - Cho'gall"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
			},
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["install_complete"] = "6.2",
		},
		["Combustion - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["normTex"] = "BantoBar",
				["dmgfont"] = "ABF",
				["chatBubbles"] = "nobackdrop",
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["minimapbar"] = {
					["mouseover"] = true,
				},
				["glossTex"] = "BantoBar",
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["equipment"] = {
				["itemlevel"] = {
					["enable"] = false,
				},
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
				["enable"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["achievement"] = false,
					["tradeskill"] = false,
					["spellbook"] = false,
					["lfg"] = false,
					["losscontrol"] = false,
					["talent"] = false,
					["enable"] = false,
					["pvp"] = false,
				},
				["addons"] = {
					["WeakAurasSkin"] = false,
					["AlwaysTrue"] = true,
					["QuartzSkin"] = false,
					["DBMSkin"] = false,
				},
			},
			["install_complete"] = "6.991",
		},
		["Centromere - Dark Iron"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["enable"] = false,
			},
			["general"] = {
				["normTex"] = "BantoBar",
				["chatBubbles"] = "nobackdrop",
				["namefont"] = "ABF",
				["dmgfont"] = "ABF",
				["glossTex"] = "BantoBar",
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.02",
		},
		["Pandatal - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["minimapbar"] = {
					["buttonSize"] = 24,
				},
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["chatBubbles"] = "nobackdrop",
				["dmgfont"] = "ABF",
			},
			["auras"] = {
				["enable"] = false,
			},
			["equipment"] = {
				["durability"] = {
					["onlydamaged"] = true,
				},
				["primary"] = "Partial DPS Tank",
				["itemlevel"] = {
					["enable"] = false,
				},
				["secondary"] = "Deeps",
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
			},
			["addonskins"] = {
				["DBMSkin"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["achievement"] = false,
					["socket"] = false,
					["lfg"] = false,
					["losscontrol"] = false,
					["gbank"] = false,
					["talent"] = false,
					["spellbook"] = false,
				},
				["addons"] = {
					["WeakAurasSkin"] = false,
					["AlwaysTrue"] = true,
					["QuartzSkin"] = false,
					["DBMSkin"] = false,
				},
			},
			["cooldown"] = {
				["enable"] = false,
			},
			["install_complete"] = "6.991",
		},
		["Plane - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
			},
			["general"] = {
				["minimapbar"] = {
					["mouseover"] = true,
				},
				["namefont"] = "ABF",
				["chatBubbles"] = "nobackdrop",
				["dmgfont"] = "ABF",
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["achievement"] = false,
					["tradeskill"] = false,
					["lfg"] = false,
					["losscontrol"] = false,
					["spellbook"] = false,
					["talent"] = false,
					["pvp"] = false,
				},
			},
			["auras"] = {
				["enable"] = false,
			},
			["install_complete"] = "6.994",
		},
		["Colton - Dark Iron"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["install_complete"] = "7.79",
		},
		["Natalan - Dark Iron"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["namefont"] = "ABF",
				["dmgfont"] = "ABF",
			},
			["skins"] = {
				["addons"] = {
					["WeakAurasSkin"] = false,
					["AlwaysTrue"] = true,
					["QuartzSkin"] = false,
					["DBMSkin"] = false,
				},
			},
			["theme"] = "class",
			["install_complete"] = "6.12",
		},
		["Ereinion - Dark Iron"] = {
		},
		["Natal - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["normTex"] = "BantoBar",
				["glossTex"] = "BantoBar",
				["minimapbar"] = {
					["mouseover"] = true,
				},
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["chatBubbles"] = "nobackdrop",
				["dmgfont"] = "ABF",
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
				["enable"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["auctionhouse"] = false,
					["tradeskill"] = false,
					["pvp"] = false,
					["lfg"] = false,
					["losscontrol"] = false,
					["talent"] = false,
					["achievement"] = false,
					["spellbook"] = false,
				},
				["addons"] = {
					["WeakAurasSkin"] = false,
					["AlwaysTrue"] = true,
					["QuartzSkin"] = false,
					["DBMSkin"] = false,
				},
			},
			["theme"] = "class",
			["install_complete"] = "6.99995",
		},
		["Comet - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["chatBubbles"] = "nobackdrop",
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["normTex"] = "BantoBar",
				["minimapbar"] = {
					["mouseover"] = true,
				},
				["glossTex"] = "BantoBar",
				["dmgfont"] = "ABF",
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
				["enable"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["farmer"] = {
				["enabled"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["losscontrol"] = false,
					["lfg"] = false,
					["spellbook"] = false,
					["trade"] = false,
					["pvp"] = false,
					["enable"] = false,
					["talent"] = false,
					["achievement"] = false,
				},
			},
			["install_complete"] = "6.992",
		},
		["Natalan - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
			},
			["general"] = {
				["namefont"] = "ABF",
				["dmgfont"] = "ABF",
			},
			["skins"] = {
				["blizzard"] = {
					["achievement"] = false,
					["tradeskill"] = false,
					["lfg"] = false,
					["losscontrol"] = false,
					["spellbook"] = false,
					["talent"] = false,
					["pvp"] = false,
				},
				["addons"] = {
					["WeakAurasSkin"] = false,
					["AlwaysTrue"] = true,
					["QuartzSkin"] = false,
					["DBMSkin"] = false,
				},
			},
			["auras"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["install_complete"] = "6.2",
		},
		["Evan - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["normTex"] = "BantoBar",
				["glossTex"] = "BantoBar",
				["chatBubbles"] = "nobackdrop",
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["minimapbar"] = {
					["backdrop"] = true,
					["mouseover"] = true,
					["buttonSize"] = 24,
				},
				["dmgfont"] = "ABF",
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
				["enable"] = false,
			},
			["addonskins"] = {
				["DBMSkin"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["achievement"] = false,
					["tradeskill"] = false,
					["talent"] = false,
					["lfg"] = false,
					["losscontrol"] = false,
					["enable"] = false,
					["pvp"] = false,
					["spellbook"] = false,
				},
				["addons"] = {
					["WeakAurasSkin"] = false,
					["AlwaysTrue"] = true,
					["QuartzSkin"] = false,
					["DBMSkin"] = false,
				},
			},
			["install_complete"] = "5.31",
		},
		["Metal - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["enable"] = false,
			},
			["general"] = {
				["normTex"] = "BantoBar",
				["chatBubbles"] = "nobackdrop",
				["namefont"] = "ABF",
				["dmgfont"] = "ABF",
				["glossTex"] = "BantoBar",
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.62",
			["auras"] = {
				["enable"] = false,
			},
		},
	},
}
