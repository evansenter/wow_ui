
ElvDB = {
	["profileKeys"] = {
		["Cometstorm - Illidan"] = "Comet - Illidan",
		["Venala - Cho'gall"] = "Pandatal - Illidan",
		["Cometron - Illidan"] = "Cometron - Illidan",
		["Combustion - Illidan"] = "Comet - Illidan",
		["Pandatal - Illidan"] = "Comet - Illidan",
		["Colton - Dark Iron"] = "Colton - Dark Iron",
		["Natalan - Dark Iron"] = "Natalan - Dark Iron",
		["Metal - Illidan"] = "Comet - Illidan",
		["Comet - Illidan"] = "Comet - Illidan",
		["Natalan - Illidan"] = "Pandatal - Illidan",
		["Evan - Illidan"] = "Comet - Illidan",
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
			["Cometron"] = 11330625,
			["Evan"] = 2406978646,
			["Comet"] = 222286975,
			["Cometstorm"] = 161641526,
			["Combustion"] = 506078957,
			["Pandatal"] = 404400,
			["Natal"] = 6615423,
			["Natalan"] = 19768910,
			["Metal"] = 25524979,
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
			["filters"] = {
				["Boss"] = {
					["actions"] = {
						["frameLevel"] = 0,
						["color"] = {
							["borderColor"] = {
								["a"] = 1,
								["b"] = 1,
								["g"] = 1,
								["r"] = 1,
							},
							["nameColor"] = {
								["a"] = 1,
								["b"] = 1,
								["g"] = 1,
								["r"] = 1,
							},
							["health"] = false,
							["power"] = false,
							["healthColor"] = {
								["a"] = 1,
								["b"] = 1,
								["g"] = 1,
								["r"] = 1,
							},
							["name"] = false,
							["border"] = false,
							["powerColor"] = {
								["a"] = 1,
								["b"] = 1,
								["g"] = 1,
								["r"] = 1,
							},
						},
						["nameOnly"] = false,
						["alpha"] = -1,
						["flash"] = {
							["speed"] = 4,
							["enable"] = false,
							["color"] = {
								["a"] = 1,
								["b"] = 1,
								["g"] = 1,
								["r"] = 1,
							},
						},
						["hide"] = false,
						["texture"] = {
							["enable"] = false,
							["texture"] = "ElvUI Norm",
						},
					},
					["triggers"] = {
						["debuffs"] = {
							["minTimeLeft"] = 0,
							["mustHaveAll"] = false,
							["missing"] = false,
							["maxTimeLeft"] = 0,
							["names"] = {
							},
						},
						["instanceType"] = {
							["party"] = false,
							["scenario"] = false,
							["pvp"] = false,
							["raid"] = false,
							["arena"] = false,
							["none"] = false,
						},
						["inCombatUnit"] = false,
						["class"] = {
						},
						["powerThreshold"] = false,
						["maxlevel"] = 0,
						["notTarget"] = false,
						["nameplateType"] = {
							["healer"] = false,
							["neutral"] = false,
							["friendlyPlayer"] = false,
							["enemyPlayer"] = false,
							["friendlyNPC"] = false,
						},
						["underHealthThreshold"] = 0,
						["reactionType"] = {
							["enabled"] = false,
							["reputation"] = false,
							["friendly"] = false,
							["revered"] = false,
							["honored"] = false,
							["hostile"] = false,
							["unfriendly"] = false,
							["exalted"] = false,
							["neutral"] = false,
							["hated"] = false,
						},
						["buffs"] = {
							["minTimeLeft"] = 0,
							["mustHaveAll"] = false,
							["missing"] = false,
							["maxTimeLeft"] = 0,
							["names"] = {
							},
						},
						["inCombat"] = false,
						["healthThreshold"] = false,
						["names"] = {
						},
						["isTarget"] = false,
						["priority"] = 1,
						["outOfCombat"] = false,
						["targetMe"] = false,
						["classification"] = {
							["elite"] = false,
							["normal"] = false,
							["trivial"] = false,
							["minus"] = false,
							["worldboss"] = false,
							["rareelite"] = false,
							["rare"] = false,
						},
						["underPowerThreshold"] = 0,
						["instanceDifficulty"] = {
							["dungeon"] = {
								["normal"] = false,
								["mythic+"] = false,
								["heroic"] = false,
								["timewalking"] = false,
								["mythic"] = false,
							},
							["raid"] = {
								["normal"] = false,
								["legacy25normal"] = false,
								["heroic"] = false,
								["legacy10normal"] = false,
								["legacy10heroic"] = false,
								["legacy25heroic"] = false,
								["lfr"] = false,
								["timewalking"] = false,
								["mythic"] = false,
							},
						},
						["minlevel"] = 0,
						["outOfCombatUnit"] = false,
						["powerUsePlayer"] = false,
						["healthUsePlayer"] = false,
						["questBoss"] = false,
						["overPowerThreshold"] = 0,
						["role"] = {
							["tank"] = false,
							["damager"] = false,
							["healer"] = false,
						},
						["cooldowns"] = {
							["mustHaveAll"] = false,
							["names"] = {
							},
						},
						["casting"] = {
							["spells"] = {
							},
							["interruptible"] = false,
						},
						["talent"] = {
							["tier7enabled"] = false,
							["tier7"] = {
								["missing"] = false,
								["column"] = 0,
							},
							["tier2enabled"] = false,
							["tier1"] = {
								["missing"] = false,
								["column"] = 0,
							},
							["tier4"] = {
								["missing"] = false,
								["column"] = 0,
							},
							["enabled"] = false,
							["type"] = "normal",
							["tier2"] = {
								["missing"] = false,
								["column"] = 0,
							},
							["tier4enabled"] = false,
							["tier3"] = {
								["missing"] = false,
								["column"] = 0,
							},
							["tier5enabled"] = false,
							["tier5"] = {
								["missing"] = false,
								["column"] = 0,
							},
							["tier1enabled"] = false,
							["requireAll"] = false,
							["tier6enabled"] = false,
							["tier3enabled"] = false,
							["tier6"] = {
								["missing"] = false,
								["column"] = 0,
							},
						},
						["overHealthThreshold"] = 0,
					},
				},
			},
		},
		["general"] = {
			["showMissingTalentAlert"] = true,
			["mapAlphaWhenMoving"] = 0.25,
		},
		["uiScale"] = "0.64",
		["screenwidth"] = 1919.68,
		["unitframe"] = {
			["buffwatchBackup"] = {
				["DEATHKNIGHT"] = {
					[49016] = {
					},
				},
				["WARRIOR"] = {
					[114030] = {
					},
					[3411] = {
					},
					[114029] = {
					},
				},
				["SHAMAN"] = {
					[61295] = {
					},
					[51945] = {
					},
					[974] = {
					},
				},
				["MAGE"] = {
					[111264] = {
					},
				},
				["PRIEST"] = {
					[47788] = {
					},
					[17] = {
					},
					[6788] = {
					},
					[33206] = {
					},
					[139] = {
					},
					[123258] = {
					},
					[10060] = {
					},
					[41635] = {
					},
				},
				["ROGUE"] = {
					[57934] = {
					},
				},
				["HUNTER"] = {
				},
				["PET"] = {
					[19615] = {
					},
					[136] = {
					},
				},
				["DRUID"] = {
					[33763] = {
					},
					[8936] = {
					},
					[774] = {
					},
					[48438] = {
					},
				},
				["MONK"] = {
					[119611] = {
					},
					[132120] = {
					},
					[116849] = {
					},
					[124081] = {
					},
				},
				["PALADIN"] = {
					[53563] = {
					},
					[1022] = {
					},
					[1038] = {
					},
					[156322] = {
					},
					[6940] = {
					},
					[114039] = {
					},
					[1044] = {
					},
					[148039] = {
					},
				},
			},
			["ChannelTicks"] = {
				["Insanity"] = 3,
				["Mind Flay"] = 3,
				["Penance"] = 3,
			},
		},
		["screenheight"] = 1200,
		["userInformedNewChanges1"] = true,
	},
	["profiles"] = {
		["Cometstorm - Illidan"] = {
			["currentTutorial"] = 2,
			["general"] = {
				["valuecolor"] = {
					["b"] = 0.92,
					["g"] = 0.78,
					["r"] = 0.25,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,432",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,1171",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,42",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,427",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,38",
				["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,110",
				["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,150",
				["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,0,195",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,195",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-278,110",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736",
				["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,278,110",
			},
			["layoutSet"] = "dpsCaster",
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.92,
						["g"] = 0.78,
						["r"] = 0.25,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["player"] = {
						["castbar"] = {
							["height"] = 28,
							["insideInfoPanel"] = false,
							["width"] = 406,
						},
					},
				},
			},
			["thinBorderColorSet"] = true,
			["actionbar"] = {
				["backdropSpacingConverted"] = true,
			},
		},
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
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
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
						["r"] = 0.32156862745098,
					},
					["transparentAurabars"] = true,
					["powerclass"] = true,
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
					["health"] = {
						["b"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["r"] = 0.149019607843137,
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
		["Cometron - Illidan"] = {
			["currentTutorial"] = 12,
			["general"] = {
				["afk"] = false,
				["font"] = "ABF",
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["vendorGrays"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "GUILD",
				["valuecolor"] = {
					["b"] = 0.79,
					["g"] = 0.19,
					["r"] = 0.64,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,432",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,1196",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,195",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,427",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,38",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736",
			},
			["bags"] = {
				["countFontSize"] = 12,
				["countFont"] = "ABF",
				["itemLevelFont"] = "ABF",
				["ignoreItems"] = "",
				["itemLevelFontSize"] = 12,
			},
			["auras"] = {
				["font"] = "ABF",
				["fontSize"] = 12,
			},
			["chat"] = {
				["tabFont"] = "ABF",
				["font"] = "Arial Narrow",
				["tapFontSize"] = 12,
				["fontSize"] = 12,
			},
			["layoutSet"] = "dpsMelee",
			["unitframe"] = {
				["statusbar"] = "BantoBar",
				["font"] = "ABF",
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.79,
						["g"] = 0.19,
						["r"] = 0.64,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["party"] = {
						["rdebuffs"] = {
							["font"] = "ABF",
						},
					},
					["raid40"] = {
						["rdebuffs"] = {
							["font"] = "ABF",
						},
					},
					["target"] = {
						["aurabar"] = {
							["enable"] = false,
						},
						["smartAuraDisplay"] = "DISABLED",
					},
					["raid"] = {
						["rdebuffs"] = {
							["font"] = "ABF",
						},
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
						},
						["buffs"] = {
							["enable"] = true,
							["attachTo"] = "FRAME",
							["noDuration"] = false,
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
				},
			},
			["datatexts"] = {
				["font"] = "ABF",
			},
			["actionbar"] = {
				["backdropSpacingConverted"] = true,
				["font"] = "ABF",
			},
			["nameplates"] = {
				["font"] = "ABF",
			},
			["bossAuraFiltersConverted"] = true,
			["tooltip"] = {
				["font"] = "ABF",
				["healthBar"] = {
					["font"] = "ABF",
				},
				["fontSize"] = 12,
			},
			["bagSortIgnoreItemsReset"] = true,
		},
		["Combustion - Illidan"] = {
			["currentTutorial"] = 2,
		},
		["Natal - Illidan"] = {
			["currentTutorial"] = 1,
		},
		["Minimalistic"] = {
			["nameplate"] = {
				["debuffs"] = {
					["font"] = "Expressway",
				},
				["buffs"] = {
					["font"] = "Expressway",
				},
				["font"] = "Expressway",
			},
			["currentTutorial"] = 2,
			["general"] = {
				["font"] = "Expressway",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["a"] = 0.80000001192093,
					["b"] = 0.058823529411765,
					["g"] = 0.058823529411765,
					["r"] = 0.058823529411765,
				},
				["reputation"] = {
					["orientation"] = "HORIZONTAL",
					["textFormat"] = "PERCENT",
					["height"] = 16,
					["width"] = 200,
				},
				["bordercolor"] = {
					["b"] = 0.30588235294118,
					["g"] = 0.30588235294118,
					["r"] = 0.30588235294118,
				},
				["fontSize"] = 11,
				["valuecolor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
			},
			["movers"] = {
				["PetAB"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-50,-428",
				["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,51,120",
				["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,50,50",
				["GMMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,250,-50",
				["BossButton"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-117,-298",
				["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,249,-216",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,50,827",
				["MicrobarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-52",
				["VehicleSeatMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,51,-87",
				["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,143",
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,392,1073",
				["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,50",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,90",
				["ElvAB_4"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-50,-394",
				["AltPowerBarMover"] = "TOP,ElvUIParent,TOP,0,-186",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,305,50",
				["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-305,50",
				["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,51,937",
				["ReputationBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-50,-228",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,133",
				["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-122,-393",
				["BNETMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,50,232",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,50,1150",
				["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-50,50",
				["ElvUF_BodyGuardMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-651,-586",
				["ElvAB_6"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-488,330",
				["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-50,50",
				["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,50,995",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-230,140",
				["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,200",
				["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,463,50",
				["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,184,773",
				["AlertFrameMover"] = "TOP,ElvUIParent,TOP,0,-50",
				["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,230,140",
				["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-50,-50",
			},
			["bossAuraFiltersConverted"] = true,
			["hideTutorial"] = true,
			["auras"] = {
				["consolidatedBuffs"] = {
					["font"] = "Expressway",
				},
				["font"] = "Expressway",
				["fontSize"] = 11,
				["buffs"] = {
					["maxWraps"] = 2,
				},
			},
			["tooltip"] = {
				["textFontSize"] = 11,
				["font"] = "Expressway",
				["healthBar"] = {
					["font"] = "Expressway",
				},
				["headerFontSize"] = 11,
				["fontSize"] = 11,
				["smallTextFontSize"] = 11,
			},
			["unitframe"] = {
				["statusbar"] = "ElvUI Blank",
				["fontOutline"] = "THICKOUTLINE",
				["smoothbars"] = true,
				["fontSize"] = 9,
				["font"] = "Expressway",
				["units"] = {
					["tank"] = {
						["enable"] = false,
					},
					["assist"] = {
						["enable"] = false,
					},
					["pet"] = {
						["infoPanel"] = {
							["enable"] = true,
							["height"] = 14,
						},
						["debuffs"] = {
							["enable"] = true,
						},
						["threatStyle"] = "NONE",
						["castbar"] = {
							["width"] = 122,
						},
						["height"] = 50,
						["portrait"] = {
							["camDistanceScale"] = 2,
						},
						["width"] = 122,
					},
					["arena"] = {
						["spacing"] = 26,
						["castbar"] = {
							["width"] = 246,
						},
					},
					["bodyguard"] = {
						["enable"] = false,
					},
					["party"] = {
						["horizontalSpacing"] = 3,
						["debuffs"] = {
							["numrows"] = 4,
							["anchorPoint"] = "BOTTOM",
							["perrow"] = 1,
						},
						["power"] = {
							["text_format"] = "",
							["height"] = 5,
						},
						["enable"] = false,
						["rdebuffs"] = {
							["font"] = "Expressway",
						},
						["growthDirection"] = "RIGHT_DOWN",
						["infoPanel"] = {
							["enable"] = true,
						},
						["width"] = 110,
						["health"] = {
							["attachTextTo"] = "InfoPanel",
							["orientation"] = "VERTICAL",
							["text_format"] = "[healthcolor][health:current]",
							["position"] = "RIGHT",
						},
						["name"] = {
							["attachTextTo"] = "InfoPanel",
							["text_format"] = "[namecolor][name:short]",
							["position"] = "LEFT",
						},
						["height"] = 59,
						["verticalSpacing"] = 0,
						["healPrediction"] = true,
						["roleIcon"] = {
							["position"] = "TOPRIGHT",
						},
					},
					["raid40"] = {
						["enable"] = false,
						["rdebuffs"] = {
							["font"] = "Expressway",
						},
					},
					["focus"] = {
						["infoPanel"] = {
							["height"] = 17,
							["enable"] = true,
						},
						["threatStyle"] = "NONE",
						["castbar"] = {
							["iconSize"] = 26,
							["width"] = 122,
						},
						["height"] = 56,
						["name"] = {
							["attachTextTo"] = "InfoPanel",
							["position"] = "LEFT",
						},
						["health"] = {
							["attachTextTo"] = "InfoPanel",
							["text_format"] = "[healthcolor][health:current]",
						},
						["width"] = 189,
					},
					["target"] = {
						["debuffs"] = {
							["perrow"] = 7,
						},
						["power"] = {
							["attachTextTo"] = "InfoPanel",
							["hideonnpc"] = false,
							["text_format"] = "[powercolor][power:current-max]",
							["height"] = 15,
						},
						["infoPanel"] = {
							["enable"] = true,
						},
						["name"] = {
							["attachTextTo"] = "InfoPanel",
							["text_format"] = "[namecolor][name]",
						},
						["health"] = {
							["attachTextTo"] = "InfoPanel",
							["text_format"] = "[healthcolor][health:current-max]",
						},
						["height"] = 80,
						["buffs"] = {
							["perrow"] = 7,
						},
						["smartAuraPosition"] = "DEBUFFS_ON_BUFFS",
						["castbar"] = {
							["iconSize"] = 54,
							["iconAttached"] = false,
						},
					},
					["raid"] = {
						["roleIcon"] = {
							["position"] = "RIGHT",
						},
						["debuffs"] = {
							["enable"] = true,
							["sizeOverride"] = 27,
							["perrow"] = 4,
						},
						["rdebuffs"] = {
							["enable"] = false,
							["font"] = "Expressway",
						},
						["growthDirection"] = "UP_RIGHT",
						["health"] = {
							["yOffset"] = -6,
						},
						["groupsPerRowCol"] = 5,
						["height"] = 28,
						["name"] = {
							["position"] = "LEFT",
						},
						["visibility"] = "[nogroup] hide;show",
						["width"] = 140,
					},
					["player"] = {
						["debuffs"] = {
							["perrow"] = 7,
						},
						["power"] = {
							["attachTextTo"] = "InfoPanel",
							["text_format"] = "[powercolor][power:current-max]",
							["height"] = 15,
						},
						["combatfade"] = true,
						["infoPanel"] = {
							["enable"] = true,
						},
						["health"] = {
							["attachTextTo"] = "InfoPanel",
							["text_format"] = "[healthcolor][health:current-max]",
						},
						["height"] = 80,
						["name"] = {
							["attachTextTo"] = "InfoPanel",
							["text_format"] = "[namecolor][name]",
						},
						["classbar"] = {
							["height"] = 15,
							["autoHide"] = true,
						},
						["castbar"] = {
							["iconAttached"] = false,
							["iconSize"] = 54,
							["height"] = 35,
							["width"] = 478,
						},
					},
					["targettarget"] = {
						["infoPanel"] = {
							["enable"] = true,
						},
						["debuffs"] = {
							["enable"] = false,
						},
						["name"] = {
							["attachTextTo"] = "InfoPanel",
							["position"] = "TOP",
							["yOffset"] = -2,
						},
						["height"] = 50,
						["width"] = 122,
					},
				},
			},
			["datatexts"] = {
				["minimapPanels"] = false,
				["fontSize"] = 11,
				["panelTransparency"] = true,
				["goldFormat"] = "SHORT",
				["leftChatPanel"] = false,
				["font"] = "Expressway",
				["panels"] = {
					["BottomMiniPanel"] = "Time",
					["RightMiniPanel"] = "",
					["RightChatDataPanel"] = {
						["right"] = "",
						["left"] = "",
						["middle"] = "",
					},
					["LeftMiniPanel"] = "",
					["LeftChatDataPanel"] = {
						["right"] = "",
						["left"] = "",
						["middle"] = "",
					},
				},
				["rightChatPanel"] = false,
			},
			["actionbar"] = {
				["bar3"] = {
					["inheritGlobalFade"] = true,
					["buttonsize"] = 38,
					["buttonsPerRow"] = 3,
				},
				["fontSize"] = 9,
				["bar2"] = {
					["enabled"] = true,
					["inheritGlobalFade"] = true,
					["buttonsize"] = 38,
				},
				["bar1"] = {
					["heightMult"] = 2,
					["inheritGlobalFade"] = true,
					["buttonsize"] = 38,
				},
				["bar5"] = {
					["inheritGlobalFade"] = true,
					["buttonsize"] = 38,
					["buttonsPerRow"] = 3,
				},
				["globalFadeAlpha"] = 0.87,
				["stanceBar"] = {
					["inheritGlobalFade"] = true,
				},
				["bar6"] = {
					["buttonsize"] = 38,
				},
				["bar4"] = {
					["enabled"] = false,
					["backdrop"] = false,
					["buttonsize"] = 38,
				},
			},
			["nameplates"] = {
				["filters"] = {
				},
			},
			["chat"] = {
				["chatHistory"] = false,
				["fontSize"] = 11,
				["tabFont"] = "Expressway",
				["fadeUndockedTabs"] = false,
				["editBoxPosition"] = "ABOVE_CHAT",
				["fadeTabsNoBackdrop"] = false,
				["font"] = "Expressway",
				["tapFontSize"] = 11,
				["panelBackdrop"] = "HIDEBOTH",
			},
			["bags"] = {
				["itemLevelFontSize"] = 9,
				["countFontSize"] = 9,
			},
			["layoutSet"] = "dpsMelee",
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
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
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
					["health"] = {
						["b"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["r"] = 0.149019607843137,
					},
					["powerclass"] = true,
					["transparentAurabars"] = true,
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
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
						},
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
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
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
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
					["colorhealthbyvalue"] = false,
					["transparentCastbar"] = true,
					["tapped"] = {
						["r"] = 0.32156862745098,
						["g"] = 0,
						["b"] = 0,
					},
					["castClassColor"] = true,
					["transparentPower"] = true,
					["transparentAurabars"] = true,
					["transparentHealth"] = true,
					["powerclass"] = true,
					["health"] = {
						["r"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["b"] = 0.149019607843137,
					},
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
		["Metal - Illidan"] = {
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,195",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,195",
				["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,195",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-464",
			},
			["bossAuraFiltersConverted"] = true,
		},
		["Comet - Illidan"] = {
			["databars"] = {
				["artifact"] = {
					["mouseover"] = true,
					["hideInCombat"] = true,
				},
				["experience"] = {
					["mouseover"] = true,
					["font"] = "ABF",
				},
				["honor"] = {
					["enable"] = false,
				},
				["reputation"] = {
					["enable"] = true,
					["mouseover"] = true,
					["font"] = "ABF",
					["hideInCombat"] = true,
				},
			},
			["currentTutorial"] = 11,
			["general"] = {
				["totems"] = {
					["size"] = 31,
				},
				["interruptAnnounce"] = "SAY",
				["mapAlpha"] = 0.75,
				["backdropfadecolor"] = {
					["a"] = 0.650000005960465,
					["b"] = 0.0588235294117647,
					["g"] = 0.0588235294117647,
					["r"] = 0.0588235294117647,
				},
				["valuecolor"] = {
					["a"] = 1,
					["r"] = 0.99,
					["g"] = 0.99,
					["b"] = 0.99,
				},
				["topPanel"] = false,
				["bordercolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["font"] = "ABF",
				["experience"] = {
					["enable"] = false,
				},
				["autoAcceptInvite"] = true,
				["afk"] = false,
				["autoRepair"] = "GUILD",
				["minimap"] = {
					["locationFont"] = "ABF",
					["locationText"] = "HIDE",
					["resetZoom"] = {
						["enable"] = true,
					},
					["size"] = 170,
				},
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["vendorGrays"] = true,
				["health"] = {
				},
				["autoRoll"] = true,
				["tapped"] = {
				},
				["reputation"] = {
					["enable"] = false,
				},
			},
			["bossAuraFiltersConverted"] = true,
			["hideTutorial"] = true,
			["auras"] = {
				["debuffs"] = {
					["countFontSize"] = 12,
					["sortMethod"] = "INDEX",
					["durationFontSize"] = 12,
				},
				["font"] = "ABF",
				["fontOutline"] = "OUTLINE",
				["consolidatedBuffs"] = {
					["fontSize"] = 12,
					["durations"] = false,
					["filter"] = false,
				},
				["buffs"] = {
					["countFontSize"] = 12,
					["sortMethod"] = "INDEX",
					["durationFontSize"] = 12,
				},
			},
			["layoutSet"] = "healer",
			["thinBorderColorSet"] = true,
			["bagSortIgnoreItemsReset"] = true,
			["movers"] = {
				["LossControlMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,551",
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,861,459",
				["RaidMarkerBarAnchor"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-521,6",
				["PetAB"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-43,429",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,427",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,82",
				["ElvUF_AssistMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,160,474",
				["TalkingHeadFrameMover"] = "TOP,ElvUIParent,TOP,0,-120",
				["ElvUF_Raid10Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,150",
				["AltPowerBarMover"] = "TOP,ElvUIParent,TOP,0,-55",
				["BossButton"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,570,100",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,14,-8",
				["ElvAB_5"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-395",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,43",
				["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,4",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-464,151",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,981",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,1171",
				["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,464,151",
				["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,280,332",
				["TotemBarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-45",
				["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,287",
				["ElvUF_TankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,5,460",
				["BossHeaderMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,5,-320",
				["ElvUF_PlayerMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,464,242",
				["ElvUF_Raid25Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,150",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,857,150",
				["AlertFrameMover"] = "TOP,ElvUIParent,TOP,0,-18",
				["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,260,4",
				["ElvUF_TargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-464,242",
			},
			["tooltip"] = {
				["anchor"] = "ANCHOR",
				["healthBar"] = {
					["fontSize"] = 12,
					["font"] = "ABF",
				},
				["font"] = "ABF",
				["combathide"] = true,
				["fontSize"] = 12,
				["visibility"] = {
					["combat"] = true,
				},
			},
			["raidcooldown"] = {
				["enable"] = false,
				["castannounce"] = true,
				["cdannounce"] = true,
			},
			["unitframe"] = {
				["fontSize"] = 14,
				["font"] = "ABF",
				["units"] = {
					["raid10"] = {
						["enable"] = false,
					},
					["boss"] = {
						["debuffs"] = {
							["anchorPoint"] = "RIGHT",
						},
						["castbar"] = {
							["width"] = 240,
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
						},
						["width"] = 240,
						["health"] = {
							["position"] = "RIGHT",
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
						},
						["buffs"] = {
							["anchorPoint"] = "RIGHT",
						},
						["power"] = {
							["text_format"] = "",
						},
					},
					["raid40"] = {
						["healPrediction"] = true,
						["name"] = {
							["position"] = "TOP",
						},
						["height"] = 36,
						["enable"] = false,
						["rdebuffs"] = {
							["font"] = "ABF",
						},
						["roleIcon"] = {
							["enable"] = true,
						},
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
							["text"] = true,
						},
					},
					["focus"] = {
						["enable"] = false,
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
						["enable"] = false,
						["aurabar"] = {
							["useWhitelist"] = {
								["friendly"] = true,
								["enemy"] = true,
							},
							["enable"] = false,
							["noDuration"] = {
								["enemy"] = false,
							},
							["playerOnly"] = {
								["friendly"] = false,
							},
							["height"] = 18,
							["attachTo"] = "BUFFS",
						},
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
					["raid"] = {
						["rdebuffs"] = {
							["font"] = "ABF",
						},
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
						["enable"] = false,
						["aurabar"] = {
							["noDuration"] = false,
							["enable"] = false,
							["playerOnly"] = false,
							["height"] = 18,
						},
						["RestIcon"] = {
							["enable"] = false,
						},
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["portrait"] = {
							["width"] = 50,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["fontSize"] = 16,
							["enable"] = true,
							["playerOnly"] = false,
							["noDuration"] = false,
						},
						["lowmana"] = 0,
						["pvp"] = {
							["text_format"] = "",
						},
					},
					["targettarget"] = {
						["debuffs"] = {
							["fontSize"] = 14,
						},
						["enable"] = false,
						["health"] = {
							["text_format"] = "[healthcolor][health:percent]",
						},
						["width"] = 200,
						["name"] = {
							["position"] = "LEFT",
						},
						["buffs"] = {
							["fontSize"] = 14,
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
						["width"] = 200,
						["castbar"] = {
							["width"] = 200,
						},
					},
					["party"] = {
						["debuffs"] = {
							["sizeOverride"] = 0,
							["anchorPoint"] = "BOTTOMLEFT",
							["useFilter"] = "Blacklist",
							["initialAnchor"] = "TOPLEFT",
						},
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["width"] = 80,
							["yOffset"] = 1,
						},
						["healPrediction"] = true,
						["name"] = {
							["position"] = "TOP",
							["text_format"] = "[namecolor][name:medium]",
						},
						["height"] = 52,
						["horizontalSpacing"] = 5,
						["enable"] = false,
						["rdebuffs"] = {
							["font"] = "ABF",
						},
						["growthDirection"] = "RIGHT_UP",
						["width"] = 80,
						["health"] = {
							["frequentUpdates"] = true,
							["position"] = "BOTTOM",
							["orientation"] = "VERTICAL",
							["text_format"] = "[healthcolor][health:deficit]",
						},
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["width"] = 80,
							["enable"] = true,
							["yOffset"] = 1,
						},
					},
					["assist"] = {
						["enable"] = false,
					},
				},
				["statusbar"] = "BantoBar",
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["colorhealthbyvalue"] = false,
					["castClassColor"] = true,
					["transparentPower"] = true,
					["castColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["transparentHealth"] = true,
					["tapped"] = {
						["r"] = 0.32156862745098,
						["g"] = 0,
						["b"] = 0,
					},
					["transparentAurabars"] = true,
					["health"] = {
						["r"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["b"] = 0.149019607843137,
					},
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
					["transparentCastbar"] = true,
					["powerclass"] = true,
				},
				["fontOutline"] = "NONE",
			},
			["datatexts"] = {
				["goldFormat"] = "SHORTINT",
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
				["bar3"] = {
					["buttons"] = 12,
					["backdrop"] = true,
					["buttonsPerRow"] = 12,
				},
				["fontOutline"] = "OUTLINE",
				["enablecd"] = false,
				["noRangeColor"] = {
					["r"] = 0.250980392156863,
					["g"] = 0.235294117647059,
					["b"] = 0.247058823529412,
				},
				["bar2"] = {
					["enabled"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["bar5"] = {
					["buttons"] = 12,
					["point"] = "TOPRIGHT",
					["backdrop"] = true,
					["buttonsPerRow"] = 1,
				},
				["font"] = "ABF",
				["bar4"] = {
					["enabled"] = false,
					["buttons"] = 3,
					["point"] = "TOPLEFT",
					["alpha"] = 0.5,
					["buttonsPerRow"] = 3,
					["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [spec:2] hide; show",
				},
				["macrotext"] = true,
				["backdropSpacingConverted"] = true,
			},
			["nameplates"] = {
				["font"] = "ABF",
			},
			["chat"] = {
				["timeStampFormat"] = "%H:%M ",
				["font"] = "ABF",
				["tapFontSize"] = 12,
				["useCustomTimeColor"] = false,
				["fontSize"] = 12,
				["emotionIcons"] = false,
				["tabFont"] = "ABF",
				["keywords"] = "%MYNAME%",
			},
			["cooldown"] = {
				["enable"] = false,
			},
			["bags"] = {
				["countFontSize"] = 12,
				["itemLevelFont"] = "ABF",
				["ignoreItems"] = "",
				["itemLevelFontSize"] = 12,
				["sortInverted"] = false,
				["junkIcon"] = true,
				["countFont"] = "ABF",
				["clearSearchOnClose"] = true,
				["countFontOutline"] = "OUTLINE",
				["itemLevelFontOutline"] = "OUTLINE",
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
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464151",
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
					["castClassColor"] = true,
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
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
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
			["databars"] = {
				["artifact"] = {
					["mouseover"] = true,
					["hideInCombat"] = true,
				},
				["reputation"] = {
					["enable"] = true,
					["hideInCombat"] = true,
					["mouseover"] = true,
				},
				["experience"] = {
					["enable"] = false,
				},
				["honor"] = {
					["enable"] = false,
				},
			},
			["currentTutorial"] = 13,
			["general"] = {
				["totems"] = {
					["size"] = 35,
				},
				["interruptAnnounce"] = "SAY",
				["afk"] = false,
				["autoRepair"] = "GUILD",
				["mapAlpha"] = 0.75,
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["a"] = 0.650000005960465,
					["r"] = 0.0588235294117647,
					["g"] = 0.0588235294117647,
					["b"] = 0.0588235294117647,
				},
				["valuecolor"] = {
					["a"] = 1,
					["r"] = 0.25,
					["g"] = 0.78,
					["b"] = 0.92,
				},
				["threat"] = {
					["enable"] = false,
				},
				["topPanel"] = false,
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["minimap"] = {
					["size"] = 170,
				},
				["font"] = "ABF",
				["experience"] = {
					["enable"] = false,
				},
				["tapped"] = {
				},
				["health"] = {
				},
				["reputation"] = {
					["enable"] = false,
				},
				["vendorGrays"] = true,
				["autoRoll"] = true,
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,551",
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,861,459",
				["RaidMarkerBarAnchor"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-521,6",
				["PetAB"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-43,429",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,427",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,82",
				["ElvUF_TargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-464,242",
				["TalkingHeadFrameMover"] = "TOP,ElvUIParent,TOP,0,-120",
				["ElvUF_Raid10Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,150",
				["AltPowerBarMover"] = "TOP,ElvUIParent,TOP,0,-55",
				["BossButton"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,570,100",
				["ElvAB_5"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-395",
				["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,260,4",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,43",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,857,150",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-464,151",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,981",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4",
				["ElvUF_PlayerMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,464,242",
				["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,280,332",
				["TotemBarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-45",
				["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,287",
				["ElvUF_TankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,5,460",
				["BossHeaderMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,5,-320",
				["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,464,151",
				["ElvUF_Raid25Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,150",
				["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,4",
				["AlertFrameMover"] = "TOP,ElvUIParent,TOP,0,-18",
				["ElvUI_Raidcooldowns_Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,14,-8",
				["ElvUF_AssistMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,160,474",
			},
			["bossAuraFiltersConverted"] = true,
			["bags"] = {
				["countFontSize"] = 12,
				["countFont"] = "ABF",
				["itemLevelFont"] = "ABF",
				["countFontOutline"] = "OUTLINE",
				["ignoreItems"] = "",
				["itemLevelFontSize"] = 12,
				["itemLevelFontOutline"] = "OUTLINE",
				["sortInverted"] = false,
				["junkIcon"] = true,
			},
			["tooltip"] = {
				["fontSize"] = 12,
				["healthBar"] = {
					["font"] = "ABF",
					["fontSize"] = 12,
				},
				["anchor"] = "ANCHOR",
				["font"] = "ABF",
				["visibility"] = {
					["combat"] = true,
				},
				["combathide"] = true,
			},
			["auras"] = {
				["fontSize"] = 12,
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
			["raidcooldown"] = {
				["castannounce"] = true,
				["enable"] = false,
				["cdannounce"] = true,
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
					["transparentCastbar"] = true,
					["colorhealthbyvalue"] = false,
					["transparentAurabars"] = true,
					["tapped"] = {
						["r"] = 0.32156862745098,
						["g"] = 0,
						["b"] = 0,
					},
					["health"] = {
						["r"] = 0.149019607843137,
						["g"] = 0.149019607843137,
						["b"] = 0.149019607843137,
					},
					["powerclass"] = true,
					["healPrediction"] = {
						["absorbs"] = {
							["a"] = 0.350000023841858,
							["b"] = 1,
						},
					},
					["transparentHealth"] = true,
					["transparentPower"] = true,
					["castClassColor"] = true,
				},
				["fontOutline"] = "NONE",
				["font"] = "ABF",
				["statusbar"] = "BantoBar",
				["units"] = {
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
					["raid10"] = {
						["enable"] = false,
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
						["lowmana"] = 0,
						["aurabar"] = {
							["enable"] = false,
							["playerOnly"] = false,
							["noDuration"] = false,
							["height"] = 18,
						},
						["buffs"] = {
							["enable"] = true,
							["fontSize"] = 16,
							["noDuration"] = false,
							["playerOnly"] = false,
						},
						["power"] = {
							["text_format"] = "[powercolor][power:percent]",
						},
						["pvp"] = {
							["text_format"] = "",
						},
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
					["raid"] = {
						["rdebuffs"] = {
							["font"] = "ABF",
						},
					},
					["assist"] = {
						["enable"] = false,
					},
					["boss"] = {
						["debuffs"] = {
							["anchorPoint"] = "RIGHT",
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
						},
						["castbar"] = {
							["width"] = 240,
						},
						["power"] = {
							["text_format"] = "",
						},
						["buffs"] = {
							["anchorPoint"] = "RIGHT",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent][powercolor][power:current]",
							["position"] = "RIGHT",
						},
						["width"] = 240,
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
						["rdebuffs"] = {
							["font"] = "ABF",
						},
						["height"] = 36,
						["healPrediction"] = true,
						["name"] = {
							["position"] = "TOP",
						},
						["enable"] = false,
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
							["initialAnchor"] = "TOPLEFT",
							["useFilter"] = "Blacklist",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["growthDirection"] = "RIGHT_UP",
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["width"] = 80,
							["yOffset"] = 1,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["height"] = 52,
						["width"] = 80,
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["width"] = 80,
							["xOffset"] = 0,
							["yOffset"] = 1,
						},
						["rdebuffs"] = {
							["font"] = "ABF",
						},
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
				},
			},
			["datatexts"] = {
				["font"] = "ABF",
				["panelTransparency"] = true,
				["time24"] = true,
				["panels"] = {
					["RightChatDataPanel"] = {
						["left"] = "Durability",
					},
					["LeftChatDataPanel"] = {
						["right"] = "System",
						["left"] = "O Item Level",
						["middle"] = "Talent/Loot Specialization",
					},
				},
				["actionbar1"] = false,
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
				["font"] = "ABF",
				["backdropSpacingConverted"] = true,
				["noRangeColor"] = {
					["r"] = 0.250980392156863,
					["g"] = 0.235294117647059,
					["b"] = 0.247058823529412,
				},
				["macrotext"] = true,
				["fontOutline"] = "OUTLINE",
				["bar5"] = {
					["backdrop"] = true,
					["buttonsPerRow"] = 1,
					["point"] = "TOPRIGHT",
					["buttons"] = 12,
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
			["nameplates"] = {
				["font"] = "ABF",
			},
			["layoutSet"] = "healer",
			["chat"] = {
				["font"] = "Arial Narrow",
				["emotionIcons"] = false,
				["tabFont"] = "ABF",
				["tapFontSize"] = 12,
				["fontSize"] = 12,
			},
			["bagSortIgnoreItemsReset"] = true,
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Cometstorm - Illidan"] = "Cometstorm - Illidan",
		["Venala - Cho'gall"] = "Venala - Cho'gall",
		["Cometron - Illidan"] = "Cometron - Illidan",
		["Combustion - Illidan"] = "Combustion - Illidan",
		["Pandatal - Illidan"] = "Pandatal - Illidan",
		["Colton - Dark Iron"] = "Colton - Dark Iron",
		["Natalan - Dark Iron"] = "Natalan - Dark Iron",
		["Metal - Illidan"] = "Metal - Illidan",
		["Comet - Illidan"] = "Comet - Illidan",
		["Natalan - Illidan"] = "Natalan - Illidan",
		["Evan - Illidan"] = "Evan - Illidan",
		["Natal - Illidan"] = "Natal - Illidan",
	},
	["profiles"] = {
		["Cometstorm - Illidan"] = {
			["general"] = {
				["chatBubbleFontSize"] = 12,
				["normTex"] = "BantoBar",
				["chatBubbles"] = "nobackdrop",
				["dmgfont"] = "ABF",
				["namefont"] = "ABF",
				["chatBubbleFont"] = "ABF",
				["glossTex"] = "BantoBar",
			},
			["bags"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["actionbar"] = {
				["enable"] = false,
			},
			["nameplates"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
			},
			["cooldown"] = {
				["enable"] = false,
			},
			["install_complete"] = "10.52",
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
		["Cometron - Illidan"] = {
			["install_complete"] = "10.14",
			["unitframe"] = {
				["enable"] = false,
			},
			["general"] = {
				["normTex"] = "BantoBar",
				["chatBubbles"] = "nobackdrop",
				["dmgfont"] = "ABF",
				["namefont"] = "ABF",
				["chatBubbleFont"] = "ABF",
				["glossTex"] = "BantoBar",
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["nameplates"] = {
				["enable"] = false,
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["auras"] = {
				["enable"] = false,
			},
		},
		["Combustion - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["chatBubbleFontSize"] = 12,
				["normTex"] = "BantoBar",
				["glossTex"] = "BantoBar",
				["chatBubbles"] = "nobackdrop",
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["chatBubbleFont"] = "ABF",
				["dmgfont"] = "ABF",
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
			["nameplates"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["achievement"] = false,
					["tradeskill"] = false,
					["pvp"] = false,
					["lfg"] = false,
					["enable"] = false,
					["losscontrol"] = false,
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
			["bags"] = {
				["enable"] = false,
			},
			["install_complete"] = "10.41",
		},
		["Pandatal - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["chatBubbleFontSize"] = 12,
				["chatBubbles"] = "nobackdrop",
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "ABF",
				["normTex"] = "BantoBar",
				["dmgfont"] = "ABF",
				["chatBubbleFont"] = "ABF",
				["minimapbar"] = {
					["buttonSize"] = 24,
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
					["socket"] = false,
					["talent"] = false,
					["enable"] = false,
					["garrison"] = false,
					["spellbook"] = false,
					["achievement"] = false,
					["character"] = false,
					["tradeskill"] = false,
					["lfg"] = false,
					["auctionhouse"] = false,
					["gbank"] = false,
					["quest"] = false,
					["losscontrol"] = false,
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
		["Metal - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["chatBubbles"] = "nobackdrop",
				["chatBubbleFont"] = "ABF",
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["enable"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["socket"] = false,
					["talent"] = false,
					["enable"] = false,
					["garrison"] = false,
					["spellbook"] = false,
					["achievement"] = false,
					["character"] = false,
					["auctionhouse"] = false,
					["lfg"] = false,
					["quest"] = false,
					["losscontrol"] = false,
				},
			},
			["nameplates"] = {
				["enable"] = false,
			},
			["install_complete"] = "8.52",
		},
		["Comet - Illidan"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["general"] = {
				["chatBubbleFontSize"] = 16,
				["normTex"] = "BantoBar",
				["chatBubbles"] = "nobackdrop",
				["glossTex"] = "BantoBar",
				["namefont"] = "ABF",
				["chatBubbleFont"] = "ABF",
				["dmgfont"] = "ABF",
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["enable"] = false,
			},
			["bags"] = {
				["enable"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["nameplates"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["talent"] = false,
					["enable"] = false,
					["encounterjournal"] = false,
					["garrison"] = false,
					["spellbook"] = false,
					["achievement"] = false,
					["character"] = false,
					["auctionhouse"] = false,
					["quest"] = false,
					["lfg"] = false,
				},
			},
			["cooldown"] = {
				["enable"] = false,
			},
			["install_complete"] = "8.51",
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
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["normTex"] = "BantoBar",
				["chatBubbleFont"] = "ABF",
				["dmgfont"] = "ABF",
				["minimapbar"] = {
					["backdrop"] = true,
					["mouseover"] = true,
					["buttonSize"] = 24,
				},
				["chatBubbleName"] = true,
				["chatBubbleFontSize"] = 12,
				["chatBubbles"] = "backdrop_noborder",
				["namefont"] = "ABF",
				["glossTex"] = "BantoBar",
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["auras"] = {
				["enable"] = false,
			},
			["unitframe"] = {
				["enable"] = false,
				["disableBlizzard"] = false,
			},
			["addonskins"] = {
				["DBMSkin"] = false,
			},
			["actionbar"] = {
				["enable"] = false,
			},
			["nameplates"] = {
				["enable"] = false,
			},
			["bags"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["socket"] = false,
					["tradeskill"] = false,
					["talent"] = false,
					["achievement"] = false,
					["mail"] = false,
					["spellbook"] = false,
					["pvp"] = false,
					["enable"] = false,
					["auctionhouse"] = false,
					["quest"] = false,
					["character"] = false,
					["encounterjournal"] = false,
					["lfg"] = false,
					["losscontrol"] = false,
					["garrison"] = false,
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
