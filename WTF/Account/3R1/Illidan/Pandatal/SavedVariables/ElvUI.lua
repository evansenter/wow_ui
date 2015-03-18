
ElvDB = {
	["profileKeys"] = {
		["Colton - Dark Iron"] = "Colton - Dark Iron",
		["Natalan - Dark Iron"] = "Natalan - Dark Iron",
		["Natalan - Illidan"] = "Pandatal - Illidan",
		["Venala - Cho'gall"] = "Pandatal - Illidan",
		["Combustion - Illidan"] = "Pandatal - Illidan",
		["Evan - Illidan"] = "Pandatal - Illidan",
		["Pandatal - Illidan"] = "Pandatal - Illidan",
		["Natal - Illidan"] = "Default",
	},
	["gold"] = {
		["Dark Iron"] = {
			["Natalan"] = 6615513,
			["Colton"] = 7241299,
		},
		["Cho'gall"] = {
			["Venala"] = 43850,
		},
		["Illidan"] = {
			["Natal"] = 6615423,
			["Evan"] = 16413749,
			["Combustion"] = 60467821,
			["Natalan"] = 19768910,
			["Pandatal"] = 521259087,
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
						["g"] = 0.5411764705882353,
						["b"] = 0.8509803921568627,
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
		},
		["screenwidth"] = 1919.68,
		["screenheight"] = 1200,
	},
	["profiles"] = {
		["Natalan - Illidan"] = {
			["nameplate"] = {
				["fontSize"] = 8,
				["auraFontOutline"] = "OUTLINE",
				["auraFont"] = "2002",
				["healthtext"] = "PERCENT",
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["badscale"] = 1.3,
				["lowHealthWarningThreshold"] = 0.25,
				["showlevel"] = false,
				["combat"] = true,
			},
			["currentTutorial"] = 15,
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
					["colorhealthbyvalue"] = false,
					["transparentCastbar"] = true,
					["tapped"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.3215686274509804,
					},
					["castClassColor"] = true,
					["powerclass"] = true,
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.3500000238418579,
							["b"] = 1,
						},
					},
					["health"] = {
						["b"] = 0.1490196078431373,
						["g"] = 0.1490196078431373,
						["r"] = 0.1490196078431373,
					},
					["transparentPower"] = true,
					["transparentAurabars"] = true,
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
							["text_format"] = "[healthcolor][health:deficit]",
							["frequentUpdates"] = true,
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
							["yOffset"] = 1,
							["xOffset"] = 0,
							["width"] = 80,
						},
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["yOffset"] = 1,
							["width"] = 80,
						},
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
							["height"] = 18,
							["enable"] = false,
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
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["enable"] = false,
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["lowmana"] = 0,
						["pvp"] = {
							["text_format"] = "",
						},
						["buffs"] = {
							["enable"] = true,
							["fontSize"] = 16,
							["noDuration"] = false,
							["playerOnly"] = false,
						},
						["castbar"] = {
							["enable"] = false,
						},
						["aurabar"] = {
							["noDuration"] = false,
							["playerOnly"] = false,
							["height"] = 18,
							["enable"] = false,
						},
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
						["height"] = 36,
						["health"] = {
							["orientation"] = "VERTICAL",
							["text"] = true,
							["frequentUpdates"] = true,
						},
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
						["width"] = 200,
						["castbar"] = {
							["width"] = 200,
						},
					},
					["boss"] = {
						["width"] = 225,
						["power"] = {
							["text_format"] = "",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["castbar"] = {
							["width"] = 225,
						},
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
					["backdrop"] = true,
					["buttonsPerRow"] = 1,
					["point"] = "TOPRIGHT",
					["buttons"] = 12,
				},
				["noRangeColor"] = {
					["b"] = 0.2470588235294118,
					["g"] = 0.2352941176470588,
					["r"] = 0.2509803921568627,
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
			["auras"] = {
				["fontSize"] = 14,
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
				["debuffs"] = {
					["sortMethod"] = "INDEX",
				},
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
				["health_backdrop"] = {
				},
				["font"] = "ABF",
				["bottomPanel"] = false,
				["autoRoll"] = true,
				["valuecolor"] = {
					["b"] = 0.94,
					["g"] = 0.8,
					["r"] = 0.41,
				},
				["vendorGrays"] = true,
				["health"] = {
				},
				["tapped"] = {
				},
			},
		},
		["Combustion - Illidan"] = {
			["currentTutorial"] = 2,
		},
		["Natal - Illidan"] = {
			["currentTutorial"] = 1,
		},
		["Colton - Dark Iron"] = {
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
						["r"] = 0.3215686274509804,
					},
					["castClassColor"] = true,
					["powerclass"] = true,
					["transparentAurabars"] = true,
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.3500000238418579,
							["b"] = 1,
						},
					},
					["transparentPower"] = true,
					["health"] = {
						["b"] = 0.1490196078431373,
						["g"] = 0.1490196078431373,
						["r"] = 0.1490196078431373,
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
					["b"] = 0.2470588235294118,
					["g"] = 0.2352941176470588,
					["r"] = 0.2509803921568627,
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
				["auraFontOutline"] = "OUTLINE",
				["auraFont"] = "2002",
				["healthtext"] = "PERCENT",
				["auraFontSize"] = 12,
				["font"] = "ABF",
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["combat"] = true,
				["lowHealthWarningThreshold"] = 0.25,
				["showlevel"] = false,
				["badscale"] = 1.3,
			},
			["currentTutorial"] = 1,
			["general"] = {
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["mapAlpha"] = 0.75,
				["font"] = "ABF",
				["tapped"] = {
				},
				["bottomPanel"] = false,
				["health"] = {
				},
				["valuecolor"] = {
					["r"] = 0,
					["g"] = 0.44,
					["b"] = 0.87,
				},
				["topPanel"] = false,
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["health_backdrop"] = {
				},
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOMElvUIParentBOTTOM0551",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-43429",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM082",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM2604",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0350",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFTElvUIParentTOPLEFT14-8",
				["ShiftAB"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM280332",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4454",
				["ElvAB_5"] = "TOPRIGHTElvUIParentTOPRIGHT-4-395",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4551",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464151",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM043",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
			},
			["tooltip"] = {
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["castColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.3500000238418579,
							["b"] = 1,
						},
					},
					["colorhealthbyvalue"] = false,
					["transparentCastbar"] = true,
					["tapped"] = {
						["r"] = 0.3215686274509804,
						["g"] = 0,
						["b"] = 0,
					},
					["health"] = {
						["r"] = 0.1490196078431373,
						["g"] = 0.1490196078431373,
						["b"] = 0.1490196078431373,
					},
					["transparentPower"] = true,
					["transparentAurabars"] = true,
					["transparentHealth"] = true,
					["powerclass"] = true,
					["castClassColor"] = true,
				},
				["fontOutline"] = "NONE",
				["font"] = "ABF",
				["units"] = {
					["raid10"] = {
						["enable"] = false,
					},
					["pet"] = {
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["name"] = {
							["position"] = "LEFT",
						},
						["width"] = 200,
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
						["combatfade"] = true,
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["aurabar"] = {
							["enable"] = false,
							["playerOnly"] = false,
							["noDuration"] = false,
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
							["width"] = 80,
							["yOffset"] = 1,
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
							["width"] = 80,
							["xOffset"] = 0,
							["yOffset"] = 1,
						},
						["width"] = 80,
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
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 4,
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
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
						},
					},
					["boss"] = {
						["castbar"] = {
							["width"] = 225,
						},
						["power"] = {
							["text_format"] = "",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["width"] = 225,
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
					["r"] = 0.2509803921568627,
					["g"] = 0.2352941176470588,
					["b"] = 0.2470588235294118,
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
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["emotionIcons"] = false,
			},
		},
		["Venala - Cho'gall"] = {
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
						["r"] = 0.3215686274509804,
					},
					["transparentAurabars"] = true,
					["powerclass"] = true,
					["health"] = {
						["b"] = 0.1490196078431373,
						["g"] = 0.1490196078431373,
						["r"] = 0.1490196078431373,
					},
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.3500000238418579,
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
					["b"] = 0.2470588235294118,
					["g"] = 0.2352941176470588,
					["r"] = 0.2509803921568627,
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
				["health_backdrop"] = {
				},
				["tapped"] = {
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
				["font"] = "ABF",
			},
		},
		["Pandatal - Illidan"] = {
			["nameplate"] = {
				["badscale"] = 1.3,
				["auraFontSize"] = 12,
				["lowHealthWarning"] = "PLAYERS",
				["fontOutline"] = "OUTLINE",
				["healthtext"] = "PERCENT",
				["auraFont"] = "2002",
				["fontSize"] = 8,
				["lowHealthWarningThreshold"] = 0.25,
				["font"] = "ABF",
				["auraFontOutline"] = "OUTLINE",
				["showlevel"] = false,
				["combat"] = true,
			},
			["currentTutorial"] = 3,
			["general"] = {
				["interruptAnnounce"] = "SAY",
				["autoRepair"] = "GUILD",
				["mapAlpha"] = 0.75,
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["valuecolor"] = {
					["r"] = 0,
					["g"] = 1,
					["b"] = 0.59,
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
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["vendorGrays"] = true,
				["font"] = "ABF",
				["experience"] = {
					["enable"] = false,
				},
			},
			["auras"] = {
				["fontSize"] = 14,
				["font"] = "ABF",
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["fontSize"] = 12,
					["filter"] = false,
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
			["movers"] = {
				["LossControlMover"] = "BOTTOMElvUIParentBOTTOM0551",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["RaidMarkerBarAnchor"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5216",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-43429",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM082",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM2604",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-55",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM043",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFTElvUIParentTOPLEFT14-8",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT570100",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464151",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT4-219",
				["ShiftAB"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM280332",
				["TotemBarMover"] = "TOPLEFTElvUIParentTOPLEFT0-410",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4287",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT5460",
				["BossHeaderMover"] = "TOPLEFTElvUIParentTOPLEFT5-320",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["AlertFrameMover"] = "TOPElvUIParentTOP0-18",
				["ElvAB_5"] = "TOPRIGHTElvUIParentTOPRIGHT-4-395",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT160474",
			},
			["tooltip"] = {
				["healthBar"] = {
					["font"] = "ABF",
					["fontSize"] = 12,
				},
				["combathide"] = true,
				["anchor"] = "ANCHOR",
				["visibility"] = {
					["combat"] = true,
				},
			},
			["chat"] = {
				["emotionIcons"] = false,
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["tabFontSize"] = 12,
			},
			["unitframe"] = {
				["fontSize"] = 14,
				["units"] = {
					["raid10"] = {
						["enable"] = false,
					},
					["boss"] = {
						["debuffs"] = {
							["anchorPoint"] = "RIGHT",
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["castbar"] = {
							["width"] = 240,
						},
						["width"] = 240,
						["power"] = {
							["text_format"] = "",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["buffs"] = {
							["anchorPoint"] = "RIGHT",
						},
					},
					["raid40"] = {
						["name"] = {
							["position"] = "TOP",
						},
						["roleIcon"] = {
							["enable"] = true,
						},
						["healPrediction"] = true,
						["enable"] = false,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
							["text"] = true,
						},
						["height"] = 36,
					},
					["focus"] = {
						["enable"] = false,
					},
					["assist"] = {
						["enable"] = false,
					},
					["pet"] = {
						["enable"] = false,
						["width"] = 200,
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["name"] = {
							["position"] = "LEFT",
						},
					},
					["player"] = {
						["debuffs"] = {
							["fontSize"] = 16,
						},
						["portrait"] = {
							["width"] = 50,
						},
						["enable"] = false,
						["aurabar"] = {
							["noDuration"] = false,
							["playerOnly"] = false,
							["enable"] = false,
							["height"] = 18,
						},
						["restIcon"] = false,
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["fontSize"] = 16,
							["noDuration"] = false,
							["playerOnly"] = false,
							["enable"] = true,
						},
						["pvp"] = {
							["text_format"] = "",
						},
						["lowmana"] = 0,
					},
					["target"] = {
						["debuffs"] = {
							["fontSize"] = 16,
							["attachTo"] = "FRAME",
							["useFilter"] = "Whitelist",
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 4,
							["width"] = 50,
						},
						["aurabar"] = {
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
							["attachTo"] = "BUFFS",
							["height"] = 18,
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
					["targettarget"] = {
						["debuffs"] = {
							["fontSize"] = 14,
						},
						["enable"] = false,
						["width"] = 200,
						["name"] = {
							["position"] = "LEFT",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["buffs"] = {
							["fontSize"] = 14,
						},
					},
					["party"] = {
						["horizontalSpacing"] = 5,
						["debuffs"] = {
							["sizeOverride"] = 0,
							["anchorPoint"] = "BOTTOMLEFT",
							["initialAnchor"] = "TOPLEFT",
							["useFilter"] = "Blacklist",
						},
						["health"] = {
							["frequentUpdates"] = true,
							["position"] = "BOTTOM",
							["orientation"] = "VERTICAL",
							["text_format"] = "[healthcolor][health:deficit]",
						},
						["growthDirection"] = "RIGHT_UP",
						["enable"] = false,
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["width"] = 80,
							["yOffset"] = 1,
						},
						["healPrediction"] = true,
						["width"] = 80,
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["height"] = 52,
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["width"] = 80,
							["xOffset"] = 0,
							["yOffset"] = 1,
						},
					},
				},
				["font"] = "ABF",
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["colorhealthbyvalue"] = false,
					["castClassColor"] = true,
					["powerclass"] = true,
					["transparentPower"] = true,
					["castColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["transparentHealth"] = true,
					["tapped"] = {
						["r"] = 0.3215686274509804,
						["g"] = 0,
						["b"] = 0,
					},
					["health"] = {
						["r"] = 0.1490196078431373,
						["g"] = 0.1490196078431373,
						["b"] = 0.1490196078431373,
					},
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.3500000238418579,
							["b"] = 1,
						},
					},
					["transparentCastbar"] = true,
					["transparentAurabars"] = true,
				},
				["fontOutline"] = "NONE",
			},
			["datatexts"] = {
				["fontSize"] = 12,
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
				["font"] = "ABF",
				["actionbar1"] = false,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
					["buttonsPerRow"] = 12,
					["backdrop"] = true,
				},
				["enablecd"] = false,
				["fontOutline"] = "OUTLINE",
				["bar2"] = {
					["enabled"] = true,
					["backdrop"] = true,
				},
				["bar5"] = {
					["point"] = "TOPRIGHT",
					["buttons"] = 12,
					["buttonsPerRow"] = 1,
					["backdrop"] = true,
				},
				["noRangeColor"] = {
					["r"] = 0.2509803921568627,
					["g"] = 0.2352941176470588,
					["b"] = 0.2470588235294118,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["macrotext"] = true,
				["bar4"] = {
					["enabled"] = false,
					["point"] = "TOPLEFT",
					["buttons"] = 3,
					["alpha"] = 0.5,
					["buttonsPerRow"] = 3,
					["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [spec:2] hide; show",
				},
			},
			["raidcooldown"] = {
				["castannounce"] = true,
				["enable"] = false,
				["cdannounce"] = true,
			},
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Colton - Dark Iron"] = "Colton - Dark Iron",
		["Natalan - Dark Iron"] = "Natalan - Dark Iron",
		["Natalan - Illidan"] = "Natalan - Illidan",
		["Venala - Cho'gall"] = "Venala - Cho'gall",
		["Combustion - Illidan"] = "Combustion - Illidan",
		["Evan - Illidan"] = "Evan - Illidan",
		["Pandatal - Illidan"] = "Pandatal - Illidan",
		["Natal - Illidan"] = "Natal - Illidan",
	},
	["profiles"] = {
		["Colton - Dark Iron"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
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
			["unitframe"] = {
				["disableBlizzard"] = false,
			},
			["general"] = {
				["raidmarkerbar"] = {
					["enable"] = false,
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
			["equipment"] = {
				["itemlevel"] = {
					["enable"] = false,
				},
			},
			["install_complete"] = "6.991",
		},
		["Evan - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["disableBlizzard"] = false,
			},
			["general"] = {
				["minimapbar"] = {
					["backdrop"] = true,
					["mouseover"] = true,
					["buttonSize"] = 24,
				},
				["raidmarkerbar"] = {
					["enable"] = false,
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
					["pvp"] = false,
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
			["install_complete"] = "5.31",
			["addonskins"] = {
				["DBMSkin"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
		},
		["Pandatal - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["chatBubbles"] = "nobackdrop",
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["minimapbar"] = {
					["buttonSize"] = 24,
				},
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
					["losscontrol"] = false,
					["spellbook"] = false,
					["gbank"] = false,
					["socket"] = false,
					["talent"] = false,
					["achievement"] = false,
					["lfg"] = false,
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
		["Natal - Illidan"] = {
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
					["losscontrol"] = false,
				},
				["addons"] = {
					["WeakAurasSkin"] = false,
					["AlwaysTrue"] = true,
					["QuartzSkin"] = false,
					["DBMSkin"] = false,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["install_complete"] = "6.13",
		},
	},
}
