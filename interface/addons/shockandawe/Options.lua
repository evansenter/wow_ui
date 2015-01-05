if not ShockAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("ShockAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local _, _, _, clientVersion = GetBuildInfo()

ShockAndAwe.emptyOptions = { "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none" }
ShockAndAwe.singleOptions = { "st", "eb" ,"ue_uf" , "mw5_lb", "ss", "ll_sf5", "ue", "none" , "as_mw<2", "lb_as", "FS_UEF", "es", "sw", "none", "none", "ls_0"}
-- ShockAndAwe.singleOptions = { "st", "eb" ,"ue_uf" , "mw5_lb", "ss", "ll_sf5", "ue", "MW>3_LB_UF" , "as_mw<2", "lb_as", "FS_UEF", "es", "sw", "MW>1_LB", "none", "ls_0"}
ShockAndAwe.aoeOptions = { "st", "ue_uf", "eb", "mw5_cl", "ss", "ll_sf5", "ue", "fn", "as_mw<2", "cl_as", "fs", "es", "sw", "none", "none", "ls_0"}

ShockAndAwe.fonteffects = {
	["none"] = L["None"],
	["OUTLINE"] = L["OUTLINE"],
	["THICKOUTLINE"] = L["THICKOUTLINE"],
	["MONOCHROME"] = L["MONOCHROME"],
}

-------------------
-- Config details
-------------------
function ShockAndAwe:SetDefaultOptions()
	ShockAndAwe.defaults = {
		char = {
			disabled = false,
			specchangewarning = true,
			message = "Welcome Home!",
			movingframes = true,
			showicons = true,
			relativeTo = "UIParent",
			relativePoint = "CENTER",
			point = "CENTER",
			texture = "Blizzard",
			barfont = "Friz Quadrata TT",
			barfontsize = 12,
			barfonteffect = "none",
			msgfont = "Friz Quadrata TT",
			msgfontsize = 24,
			msgfonteffect = "none",
			border = "None",
			barborder = "Blizzard Tooltip",
			mw4sound = "Sound\\Spells\\ShootWandLaunchLightning.wav",
			mw4soundname = "SAA Maelstrom 1",
			mw5sound = "Sound\\Spells\\DynamiteExplode.wav",
			mw5soundname = "SAA Maelstrom 2",
			shieldsound = "Sound\\Doodad\\BellowIn.wav",
			shieldsoundname = "SAA Shield 1",
			weaponsound = "Sound\\Doodad\\BellowIn.wav",
			weaponsoundname = "SAA Shield 1",
			xOffset = 0,
			yOffset = -100,
			fWidth = 300,
			fHeight = 175,
			resetOn = true,
			scale = 1,
			ShockPercent = .6,
			ShearPercent = .6,
			shockshow = true,
			shearshow = false,
			windshearshow = true,
			sbtshow = false,
			wfoverlay = true,
			threatThreshold = 90,
			ssshow = true,
			firetotemshow = true,
			wfshow = true,
			fsdotshow = true,
			gcdshow = false,
			gcdfullwidth = false,
			llshow = true,
			fnshow = true,
			fsshow = true,
			unleashelementsshow = true,
			ElementalBlastShow = false,
			petshow = false,
			disablebars = false,
			maelstromTalents = 0,
			feralSpiritTalented = false,
			mw4soundplay = true,
			mw5soundplay = true,
			mw5repeat = 3,
			mwflash = true,
			shieldshow = true,
			msshow = true,
			msstacks = 0,
			arena = false,
			barstext = true,
			SSlen = 8,
			LLlen = 10,
			ShockLen = 6,
			ShearLen = 6,
			lastshock = "",
			debug = false,
			msg = { r = 1, g = .5, b = 0, },
			msgtime = 2,
			newsitem = 0,
			castweaponrebuff = false,
			MSBToutputarea = "Notification",
			colours = {
				watershield = { r=.6, g=.6,	b=1, a=.3 },
				lightningshield = { r=0, g=0, b=1, a=.5 },
				earthshield = { r=0, g=1, b=0, a=.5 },
				noshield = { r=1, g=0, b=0, a=1 },
				
				flameshock = { r=1, g=.6, b=.2, a=.9 },
				flameshockDot = { r=1, g=.6, b=.2, a=.6 },
				earthshock = { r=0, g=1, b=.3, a=.9 },
				frostshock = { r=.6, g=.6, b=1, a=.9 },
				windshear = { r=.6, g=.6, b=.6, a=.9 },
				
				maelstrom = { r=1, g=.5, b=1, a=.3 },
				msalpha = .3,
				msalphaFull = .9,

				magma = { r=.9, g=.4, b=0, a=.9 },
				unleash = { r=.6, g=.2, b=.9, a=.9 },
				ElementalBlast = { r=1, g=1, b=.2, a=.5 }, -- TODO Bertel option for this
				ElementalBlastBuff = { r=1, g=.1, b=.1, a=1 }, -- TODO Bertel option for this
				lavalash = { r=1, g=.1, b=.1, a=.9 },
				feralspirit = { r=0, g=.6, b=.95, a=.9 },
				feralspiritCD = { r=0, g=.6, b=.95, a=.9 },
				stormstrike = { r=1, g=1, b=.2, a=.9 },
				firenova = { r=1, g=.9, b=.4, a=.9 },
				windfury = { r=1, g=0, b=0, a=.5 },
				sbulwarkPrimary = { r=0, g=.44, b=.87, a=.9 },
				sbulwarkSecondary = { r=.67, g=.83, b=.45, a=.9 },
				sbulwarkDepleted = { r=1, g=.96, b=.41, a=.9 },
				sbulwarkCD = { r=.5, g=.5, b=.5, a=.9 },
			},
			uptime = {
				show = true,
				fWidth = 120,
				fHeight = 120,
				barWidth = 100,
				barHeight = 20,
				relativeTo = "UIParent",
				relativePoint = "CENTER",
				point = "CENTER",
				xOffset = -200,
				yOffset = -275,
				alpha = 0.4,
				scale = 1,
				flurry = { r = .2, g = .1, b = 1, a = 0.5, },
				ed = { r = 1, g = 1, b = .8, a = 0.5, },
				ur = { r = 1, g = .5, b = 0, a = 0.5, },
			},
			stats = {
				show = true,
				fWidth = 120,
				fHeight = 200,
				barWidth = 100,
				barHeight = 20,
				relativeTo = "ShockAndAwe.UptimeFrame",
				relativePoint = "TOPLEFT",
				point = "TOPLEFT",
				xOffset = 125,
				yOffset = 0,
				alpha = 0.4,
				scale = 1,	
				wfcalc = true,
				wfcol = { r = 1, g = .5, b = 0, a = 0.8, },
				wftime = 2,
				best = {
					ap = 0,
					spellpower = 0,
					meleehit = 0,
					spellhit = 0,
					expertise = 0,
					meleecrit = 0,
					spellcrit = 0,
					wfmh = 0,
					wfoh = 0,
					stormstrike = 0,
				},
			},
			priority = {
				show = true,
				titleshow = true,
				relativeTo = "UIParent",
				relativePoint = "CENTER",
				point = "CENTER",
				fWidth = 50,
				fHeight = 50,
				xOffset = -215,
				yOffset = -60,
				alpha = 0.4,
				scale = 1,	
				next = 1,
				cooldown = 0.5,
				fsticksleft = 2,
				totemtimeleft = 20,
				srmana = 10,
				wsmana = 0,
				shieldorbs = 0,
				magmaticks = 2,
				firetotemtime = 0,
				searingticks = 0,
				hwhealth = 25,
				chingroup = true,
				worldbossonly = true,
				hideImmune = true,
				combopoints = true,
				showpurge = true,
				showinterrupt = true,
				showcooldown = true,
				prOption = ShockAndAwe.singleOptions,
				groupnumber = 1, 
				prOptions = { 	
						ShockAndAwe.singleOptions, 
						ShockAndAwe.aoeOptions, 
						ShockAndAwe.emptyOptions, 
						ShockAndAwe.emptyOptions, 
						ShockAndAwe.emptyOptions }
			},
			binding = {
				show = true,
				relativeTo = "UIParent",
				relativePoint = "CENTER",
				point = "CENTER",
				fWidth = 200,
				fHeight = 50,
				xOffset = -200,
				yOffset = -100,
				alpha = 0.4,
				scale = 1,	
				mhspell = ShockAndAwe.constants["Windfury Weapon"],
				ohspell = ShockAndAwe.constants["Flametongue Weapon"],
				macroset = false,
			},
			warning = {
				show = true,
				duration = 3,
				shield = false,
				weapon = true,
				range = false,
				grounding = true,
				interrupt = true,
				purge = true,
				timeleft = 300, 
				colour = { r = 1, g = .5, b = 0, a = 0.5, },
				relativeTo = "UIParent",
				relativePoint = "TOP",
				point = "CENTER",
				fWidth = 400,
				fHeight = 75,
				xOffset = 0,
				yOffset = -250,
			},
		}
	}
end

function ShockAndAwe:VerifyOptions()
	ShockAndAwe.db.char.priority.option =  nil -- remove old format of options
	ShockAndAwe.db.char.priority.options = nil
	if not ShockAndAwe.db.char.priority.prOption then -- fix for corruption in v5.50
		ShockAndAwe.db.char.priority.prOption = ShockAndAwe.emptyOptions
		ShockAndAwe:Print(L["ShockAndAwe Warning : No options set"])
	end
	for index = 1, 16 do
		if not ShockAndAwe.db.char.priority.prOption[index] then
			ShockAndAwe.db.char.priority.prOption[index] = "none"
		end
	end
	for group = 1, 5 do
		for index = 1, 16 do
			if not ShockAndAwe.db.char.priority.prOptions[group][index] then
				ShockAndAwe.db.char.priority.prOptions[group][index] = "none"
			end
		end
	end
end

function ShockAndAwe:GetOptions()
	local options = { 
		name = "ShockAndAwe",
		handler = ShockAndAwe,
		type='group',
		childGroups ='tree',
		args = {
			frames = {
				name = L["Frame Options"],
				type = 'group',
				order = 1,
				args = {
					width = {
						type = 'range',
						name = L["Bar Width"],
						desc = L["help_width"],
						min = 100,
						max = 500,
						step = 10,
						get = "GetWidth",
						set = "SetWidth",
						order = 32,
					},
					scale = {
						type = 'range',
						name = L["Bar Scale"],
						desc = L["help_scale"],
						min = 0.10,
						max = 2.00,
						step = 0.05,
						get = "GetScale",
						set = "SetScale",
						order = 33,
					},
					resetbars = {
						type = 'execute',
						name = L["Reset Bars"],
						desc = L["help_reset"],
						func = "ResetBars",
						order = 34,
					},
					resetuptime = {
						type = 'execute',
						name = L["Reset Uptime"],
						desc = L["help_reset_uptime"],
						func = "ResetUptime",
						order = 35,
					},
					resetpriority = {
						type = 'execute',
						name = L["Reset Priority"],
						desc = L["help_reset_priority"],
						func = "ResetPriority",
						order = 36,
					},
				},
			},
			bars = {
				name = L["Timer Bars"],
				type = 'group',
				order = 2,
				args = {
					disable = {
						type = 'toggle',
						name = L["Disable out of combat"],
						desc = L["help_disablebars"],
						get = "disablebarsQuery",
						set = "Activatedisablebars",
						order = 1,
						},
					icons = {
						type = 'toggle',
						name = L["Show bar icons"],
						desc = L["help_baricons"],
						get = "bariconsQuery",
						set = "ActivateBarIcons",
						order = 2,
						},
					break1 = {
						type = 'header',
						name = L["Bars Section"],
						dialogHidden = true,
						order = 10,
					},
					feralspiritbar = {
						type = 'toggle',
						name = L["Feral Spirit Bar"],
						desc = L["help_feralspirit"],
						get = "feralspiritQuery",
						set = "ActivateFeralSpirit",
						order = 11,
						},
					shieldbar = {
						type = 'toggle',
						name = L["Shield Bar"],
						desc = L["help_shield"],
						get = "shieldQuery",
						set = "ActivateShield",
						order = 11,
						},
					maelstrom = {
						type = 'toggle',
						name = L["Maelstrom Bar"],
						desc = L["help_maelstrom"],
						get = "maelstromQuery",
						set = "ActivateMaelstrom",
						order = 12,
						},
					SS = {
						type = 'toggle',
						name = L["Stormstrike Bar"],
						desc = L["help_ss"],
						get = "SSQuery",
						set = "ActivateSS",
						order = 13,
					},
					magma = {
						type = 'toggle',
						name = L["Fire Totem Bar"],
						desc = L["help_magma"],
						get = "FireTotemQuery",
						set = "ActivateFireTotem",
						order = 13,
					},
					unleash = {
						type = 'toggle',
						name = L["Unleash Elements Bar"],
						desc = L["help_unleash"],
						get = "UnleashElementsQuery",
						set = "ActivateUnleashElements",
						order = 14,
					},
					ElementalBlast = {
						type = 'toggle',
						name = L["Elemental Blast Bar"],
						desc = L["help_ElementalBlast"],
						get = "ElementalBlastQuery",
						set = "ActivateElementalBlast",
						order = 15,
					},
					WF = {
						type = 'toggle',
						name = L["Windfury Bar"],
						desc = L["help_wf"],
						get = "WFQuery",
						set = "ActivateWF",
						order = 16,
					},
					shock = {
						type = 'toggle',
						name = L["Shock Bar"],
						desc = L["help_shock"],
						get = "shockQuery",
						set = "ActivateShock",
						order = 17,
					},
					fsdot = {
						type = 'toggle',
						name = L["FS Dot Bar"],
						desc = L["help_fsdot"],
						get = "fsdotbarQuery",
						set = "ActivateFSDotBar",
						order = 18,
					},
					shear = {
						type = 'toggle',
						name = L["Shear Bar"],
						desc = L["help_shear"],
						get = "shearQuery",
						set = "ActivateShear",
						order = 19,
					},
					gcd = {
						type = 'toggle',
						name = L["GCD"],
						desc = L["help_gcd"],
						get = "gcdQuery",
						set = "ActivateGCD",
						order = 20,
					},
					gcdfullwidth = {
						type = 'toggle',
						name = L["GCD full width"],
						desc = L["help_gcd_fullwidth"],
						get = "gcdFullwidthQuery",
						set = "ActivateGCDfullwidth",
						order = 21,
					},
					lavalash = {
						type = 'toggle',
						name = ShockAndAwe.constants["Lava Lash"],
						desc = L["help_lavalash"],
						get = "lavalashQuery",
						set = "ActivateLavaLash",
						order = 22,
					},
					firenova = {
						type = 'toggle',
						name = ShockAndAwe.constants["Fire Nova"],
						desc = L["help_firenova"],
						get = "firenovaQuery",
						set = "ActivateFireNova",
						order = 23,
					},
					break4 = {
						type = 'header',
						name = L["Misc Options"],
						dialogHidden = true,
						order = 40,
					},
					arena = {
						type = 'toggle',
						name = L["4 piece arena bonus"],
						desc = L["help_arena"],
						get = "arenaQuery",
						set = "ActivateArena",
						order = 42,
					},
					text = {
						type = 'toggle',
						name = L["Text Display"],
						desc = L["help_textonbars"],
						get = "textOnBarsQuery",
						set = "ActivateTextOnBars",
						order = 43,
					},
					mw4sound = {
						type = 'toggle',
						name = L["Maelstrom Sound 4"],
						desc = L["help_mw4soundplay"],
						get = "mw4soundplayQuery",
						set = "ActivateMW4sound",
						order = 44,
					},
					mw5sound = {
						type = 'toggle',
						name = L["Maelstrom Sound 5"],
						desc = L["help_mw5soundplay"],
						get = "mw5soundplayQuery",
						set = "ActivateMW5sound",
						order = 45,
					},
					mwflash = {
						type = 'toggle',
						name = L["Maelstrom Flash"],
						desc = L["help_mw5flash"],
						get = "mw5flashQuery",
						set = "ActivateMW5flash",
						order = 46,
					},
					StoneBulwark = {
						type = 'toggle',
						name = L["Stone Bulwark Totem Bar"],
						desc = L["help_stonebulwark"],
						get = "StoneBulwarkQuery",
						set = "ActivateStoneBulwark",
						order = 47,
					},
					WfOverlay = {
						type = 'toggle',
						name = L["Windfury Bar Overlay"],
						desc = L["help_wfOverlay"],
						get = "WfOverlayQuery",
						set = "ActivateWfOverlay",
						order = 47,
					},
				},
			},
			barcolours = {
				name = L["Bar Colours"],
				type = 'group',
				order = 3, 
				args = {
					break1 = {
						type = 'header',
						name = L["Shields"],
						dialogHidden = true,
						order = 1,
					},
					watershield = {
						type = 'color',
						name = L["Water Shield Colour"],
						desc = L["colWaterShield"],
						get = "getWaterShieldColour",
						set = "setWaterShieldColour",
						hasAlpha = true,
						order = 2,
					},
					lightningshield = {
						type = 'color',
						name = L["Lightning Shield Colour"],
						desc = L["colLightningShield"],
						get = "getLightningShieldColour",
						set = "setLightningShieldColour",
						hasAlpha = true,
						order = 3,
					},
					earthshield = {
						type = 'color',
						name = L["Earth Shield Colour"],
						desc = L["colEarthShield"],
						get = "getEarthShieldColour",
						set = "setEarthShieldColour",
						hasAlpha = true,
						order = 4,
					},
					noshield = {
						type = 'color',
						name = L["Shield Down Colour"],
						desc = L["colNoShield"],
						get = "getNoShieldColour",
						set = "setNoShieldColour",
						hasAlpha = false,
						order = 5,
					},
					break2 = {
						type = 'header',
						name = L["Shocks"],
						dialogHidden = true,
						order = 6,
					},
					flameshock = {
						type = 'color',
						name = L["Flame Shock Colour"],
						desc = L["colFlameShock"],
						get = "getFlameShockColour",
						set = "setFlameShockColour",
						hasAlpha = true,
						order = 7,
					},
					flameshockdot = {
						type = 'color',
						name = L["FS Dot Colour"],
						desc = L["colFlameShockDot"],
						get = "getFlameShockDotColour",
						set = "setFlameShockDotColour",
						hasAlpha = true,
						order = 8,
					},
					earthshock = {
						type = 'color',
						name = L["Earth Shock Colour"],
						desc = L["colEarthShock"],
						get = "getEarthShockColour",
						set = "setEarthShockColour",
						hasAlpha = true,
						order = 9,
					},
					frostshock = {
						type = 'color',
						name = L["Frost Shock Colour"],
						desc = L["colFrostShock"],
						get = "getFrostShockColour",
						set = "setFrostShockColour",
						hasAlpha = true,
						order = 10,
					},
					windshear = {
						type = 'color',
						name = L["Wind Shear Colour"],
						desc = L["colWindShear"],
						get = "getWindShearColour",
						set = "setWindShearColour",
						hasAlpha = true,
						order = 11,
					},
					break3 = {
						type = 'header',
						name = L["Maelstrom Bar"],
						dialogHidden = true,
						order = 12,
					},
					maelstrom = {
						type = 'color',
						name = L["Maelstrom Bar Colour"],
						desc = L["colMaelstrom"],
						get = "getMaelstromColour",
						set = "setMaelstromColour",
						hasAlpha = false,
						order = 13,
					},
					msalpha = {
						type = 'range',
						name = L["Maelstrom Alpha"],
						desc = L["colMaelstromAlpha"],
						min = 0,
						max = 1,
						isPercent = true,
						get = "GetMSalpha",
						set = "SetMSalpha",
						order = 14,
					},
					msalphaFull = {
						type = 'range',
						name = L["Maelstrom Full Alpha"],
						desc = L["colMaelstromFullAlpha"],
						min = 0,
						max = 1,
						isPercent = true,
						get = "GetMSalphaFull",
						set = "SetMSalphaFull",
						order = 15,
					},
					break4 = {
						type = 'header',
						name = L["Other Bars"],
						dialogHidden = true,
						order = 20,
					},
					stormstrike = {
						type = 'color',
						name = L["Stormstrike Bar Colour"],
						desc = L["colStormstrike"],
						get = "getStormstrikeColour",
						set = "setStormstrikeColour",
						hasAlpha = true,
						order = 21,
					},
					windfury = {
						type = 'color',
						name = L["Windfury Bar Colour"],
						desc = L["colWindfury"],
						get = "getWindfuryColour",
						set = "setWindfuryColour",
						hasAlpha = true,
						order = 22,
					},
					lavalash = {
						type = 'color',
						name = L["Lava Lash Bar Colour"],
						desc = L["colLavaLash"],
						get = "getLavaLashColour",
						set = "setLavaLashColour",
						hasAlpha = true,
						order = 23,
					},
					firenova = {
						type = 'color',
						name = L["Fire Nova Bar Colour"],
						desc = L["colFireNova"],
						get = "getFireNovaColour",
						set = "setFireNovaColour",
						hasAlpha = true,
						order = 24,
					},
					magma = {
						type = 'color',
						name = L["Fire Bar Colour"],
						desc = L["colMagma"],
						get = "getMagmaColour",
						set = "setMagmaColour",
						hasAlpha = true,
						order = 25,
					},
					unleash = {
						type = 'color',
						name = L["Unleash Elements Bar Colour"],
						desc = L["colUnleash"],
						get = "getUnleashColour",
						set = "setUnleashColour",
						hasAlpha = true,
						order = 26,
					},
					feralspirit = {
						type = 'color',
						name = L["Feral Spirit Bar Colour"],
						desc = L["colFeralSpirit"],
						get = "getFeralSpiritColour",
						set = "setFeralSpiritColour",
						hasAlpha = true,
						order = 27,
					},
					feralspiritCD = {
						type = 'color',
						name = L["Feral Spirit CD Bar Colour"],
						desc = L["colFeralSpiritCD"],
						get = "getFeralSpiritCDColour",
						set = "setFeralSpiritCDColour",
						hasAlpha = true,
						order = 28,
					},
					sbulwarkPrimary = {
						type = 'color',
						name = L["Primary Shield Stone Bulwark Totem"],
						desc = L["primarySBTDesc"],
						get = "getPrimarySBTShield",
						set = "setPrimarySBTShield",
						hasAlpha = true,
						order = 29,
					},
					sbulwarkSecondary = {
						type = 'color',
						name = L["Secondary Shield Stone Bulwark Totem"],
						desc = L["secondarySBTDesc"],
						get = "getSecondarySBTShield",
						set = "setSecondarySBTShield",
						hasAlpha = true,
						order = 30,
					},
					sbulwarkDepleted = {
						type = 'color',
						name = L["Depleted Stone Bulwark Totem"],
						desc = L["depletedSBTDesc"],
						get = "getDepletedSBTShield",
						set = "setDepletedSBTShield",
						hasAlpha = true,
						order = 31,
					},
					sbulwarkCD = {
						type = 'color',
						name = L["CD Stone Bulwark Totem"],
						desc = L["cdSBTDesc"],
						get = "getCDSBTShield",
						set = "setCDSBTShield",
						hasAlpha = true,
						order = 32,
					},
				},
			},
			priority = {
				name = L["Priority Frame"],
				type = 'group',
				order = 4, 
				args = {
					priority = {
						type = 'toggle',
						name = L["Priority Frame"],
						desc = L["help_priority"],
						get = "priorityQuery",
						set = "ActivatePriority",
						order = 21,
					},
					title = {
						type = 'toggle',
						name = L["Display frame title"],
						get = "priorityTitleQuery",
						set = "ActivatePriorityTitle",
						order = 22,
					},
					combopoints = {
						type = 'toggle',
						name = L["Combo Points"],
						desc = L["help_combopoints"],
						get = "combopointsQuery",
						set = "ActivateComboPoints",
						order = 23,
					},
					priorityscale = {
						type = 'range',
						name = L["Priority Bar Scale"],
						desc = L["help_priority_scale"],
						min = 0.50,
						max = 2.00,
						step = 0.01,
						get = "GetPriorityScale",
						set = "SetPriorityScale",
						order = 24,
					},
					windshear = {
						type = 'toggle',
						name = ShockAndAwe.constants["Wind Shear"],
						desc = L["help_windshear"],
						get = "windshearQuery",
						set = "ActivateWindShear",
						order = 25,
					},
					worldbossonly = {
						type = 'toggle',
						name = L["World Boss Only"],
						desc = L["help_worldbossonly"],
						get = "worldbossQuery",
						set = "ActivateWorldBoss",
						order = 25,
					},
					hideImmuneSpells = {
						type = 'toggle',
						name = L["Hide Immune Spells"],
						desc = L["help_hideimmunespells"],
						get = "hideImmuneQuery",
						set = "ActivateHideImmune",
						order = 26,
					},
					showinterrupt = {
						type = 'toggle',
						name = L["Show Interrupt"],
						desc = L["help_showinterrupt"],
						get = "showinterruptQuery",
						set = "ActivateShowInterrupt",
						order = 27,
					},
					showpurge = {
						type = 'toggle',
						name = L["Show Purge"],
						desc = L["help_showpurge"],
						get = "showpurgeQuery",
						set = "ActivateShowPurge",
						order = 28,
					},
					showcooldown = {
						type = 'toggle',
						name = L["Show Cooldown"],
						desc = L["help_showcooldown"],
						get = "showcooldownQuery",
						set = "ActivateShowCooldown",
						order = 29,
					},
					threat = {
						type = 'range',
						name = L["Threat Threshold"],
						desc = L["help_threat"],
						min = 75,
						max = 110,
						step = 1,
						get = "GetThreatThreshold",
						set = "SetThreatThreshold",
						order = 50,
					},
					cooldown = {
						type = 'range',
						name = L["Cooldown Threshold"],
						desc = L["help_cooldown"],
						min = 0,
						max = 1.5,
						step = 0.05,
						get = "GetCooldownThreshold",
						set = "SetCooldownThreshold",
						order = 51,
					},
					fsticksleft = {
						type = 'range',
						name = L["Flame Shock Ticks Left"],
						desc = L["help_fsticksleft"],
						min = 0,
						max = 6,
						step = 1,
						get = "GetFSTicksLeft",
						set = "SetFSTicksLeft",
						order = 52,
					},
--~ 					totemtimeleft = {
--~ 						type = 'range',
--~ 						name = L["Totem Time Left"],
--~ 						desc = L["help_totemtimeleft"],
--~ 						min = 0,
--~ 						max = 300,
--~ 						step = 5,
--~ 						get = "GetTotemTimeLeft",
--~ 						set = "SetTotemTimeLeft",
--~ 						order = 35,
--~ 					},
					hwhealth = {
						type = 'range',
						name = L["Healing Surge Health%"],
						desc = L["help_hwhealth"],
						min = 1,
						max = 100,
						step = 1,
						get = "GetHWHealth",
						set = "SetHWHealth",
						order = 53,
					},
					chingroup = {
						type = 'toggle',
						name = L["Chain Heal in group"],
						desc = L["help_chingroup"],
						get = "GetCHInGroup",
						set = "SetCHInGroup",
						order = 54,
					},
					srmana = {
						type = 'range',
						name = L["Shamanistic Rage Level%"],
						desc = L["help_srmana"],
						min = 0,
						max = 50,
						step = 1,
						get = "GetSRMana",
						set = "SetSRMana",
						order = 55,
					},
					wsmana = {
						type = 'range',
						name = L["Water Shield Level%"],
						desc = L["help_wsmana"],
						min = 0,
						max = 100,
						step = 1,
						get = "GetWSMana",
						set = "SetWSMana",
						order = 56,
					},
					shieldorbs = {
						type = 'range',
						name = L["Shield orbs left"],
						desc = L["help_shieldorbs"],
						min = 0,
						max = 9,
						step = 1,
						get = "GetShieldOrbs",
						set = "SetShieldOrbs",
						order = 57,
					},
					magmaticks = {
						type = 'range',
						name = L["Magma ticks left"],
						desc = L["help_magmaticks"],
						min = 0,
						max = 9,
						step = 1,
						get = "GetMagmaTicks",
						set = "SetMagmaTicks",
						order = 58,
					},
					searingticks = {
						type = 'range',
						name = L["Searing ticks left"],
						desc = L["help_searingticks"],
						min = 0,
						max = 9,
						step = 1,
						get = "GetSearingTicks",
						set = "SetSearingTicks",
						order = 58,
					},
				},
			},
			warning = {
				name = L["Warning Options"],
				type = 'group',
				order = 6, 
				args = {
					show = {
						type = 'toggle',
						name = L["Use Warning Frame"],
						desc = L["help_warningframe"],
						get = "WarningFrameQuery",
						set = "ActivateWarningFrame",
						order = 1,
					},
					shield = {
						type = 'toggle',
						name = L["Shield Warning"],
						desc = L["help_shieldwarning"],
						get = "shieldWarnQuery",
						set = "ActivateShieldWarn",
						order = 2,
					},
					weapons = {
						type = 'toggle',
						name = L["Weapon Inbue Warning"],
						desc = L["help_weaponwarning"],
						get = "weaponWarnQuery",
						set = "ActivateWeaponWarn",
						order = 3,
					},
					range = {
						type = 'toggle',
						name = L["Out of range"],
						desc = L["help_outofrange"],
						get = "rangeWarnQuery",
						set = "ActivateRangeWarn",
						order = 4,
					},
					grounding = {
						type = 'toggle',
						name = L["Grounding Warning"],
						desc = L["help_groundingwarning"],
						get = "groundingWarnQuery",
						set = "ActivateGroundingWarn",
						order = 5,
					},
					interrupt = {
						type = 'toggle',
						name = L["Interrupt Warning"],
						desc = L["help_interruptwarning"],
						get = "interruptWarnQuery",
						set = "ActivateInterruptWarn",
						order = 6,
					},
					purge = {
						type = 'toggle',
						name = L["Purge Warning"],
						desc = L["help_purgewarning"],
						get = "purgeWarnQuery",
						set = "ActivatePurgeWarn",
						order = 7,
					},
					mainhand = {
						type = 'select',
						name = L["Main Hand Imbue"],
						get = "GetMainHandImbue",
						set = "SetMainHandImbue",
						values = ShockAndAwe.bindings.imbues,
						order = 8,
					},
					offhand = {
						type = 'select',
						name = L["Off Hand Imbue"],
						get = "GetOffHandImbue",
						set = "SetOffHandImbue",
						values = ShockAndAwe.bindings.imbues,
						order = 9,
					},
					colour = {
						type = 'color',
						name = L["Warning Msg Colour"],
						desc = L["colWarningMessage"],
						get = "getWarningColour",
						set = "setWarningColour",
						hasAlpha = true,
						order = 10,
					},
					duration = {
						type = 'range',
						name = L["Warning Message Duration"],
						min = 1,
						max = 10,
						step = .2,
						get = "GetWarningDuration",
						set = "SetWarningDuration",
						order = 11,
					},
--~					msbt = {
--~						type = 'select',
--~						name = L["MSBT output area"],
--~						get = "GetMSBTareas",
--~						set = "SetMSBTareas",
--~						values = ShockAndAwe.MSBT.areas,
--~						order = 12,
--~					},
--~ 					rebuff = {
--~ 						type = 'range',
--~ 						name = L["Weapon Rebuff time"],
--~ 						desc = L["help_weaponrebuff"],
--~ 						min = 0,
--~ 						max = 900,
--~ 						step = 10,
--~ 						get = "GetRebuffTime",
--~ 						set = "SetRebuffTime",
--~ 						order = 6,
--~ 					},
				},
			},
			media = {
				name = L["Media Options"],
				type = 'group',
				order = 7, 
				args = {
					texture = {
						type = 'select',
						name = L["Bar Texture"],
						get = "GetBarTexture",
						set = "SetBarTexture",
						values = ShockAndAwe.textures,
						order = 1,
					},
					border = {
						type = 'select',
						name = L["Border Texture"],
						get = "GetBorderTexture",
						set = "SetBorderTexture",
						values = ShockAndAwe.borders,
						order = 2,
					},
					barborder = {
						type = 'select',
						name = L["Bar Border Texture"],
						get = "GetBarBorderTexture",
						set = "SetBarBorderTexture",
						values = ShockAndAwe.borders,
						order = 3,
					},
					barfont = {
						type = 'select',
						name = L["Bar Font"],
						get = "GetBarFont",
						set = "SetBarFont",
						values = ShockAndAwe.fonts,
						order = 4,
					},
					barfonteffect = {
						name = L["Bar Font Effect"],
						type = "select",
						get = "GetBarFontEffect",
						set = "SetBarFontEffect",
						values = ShockAndAwe.fonteffects,
						order = 5,
					},
					barfontsize = {
						type = 'range',
						name = L["Bar Font Size"],
						min = 6,
						max = 32,
						step = 1,
						get = "GetBarFontSize",
						set = "SetBarFontSize",
						order = 6,
					},
					msgfont = {
						type = 'select',
						name = L["Message Font"],
						get = "GetMsgFont",
						set = "SetMsgFont",
						values = ShockAndAwe.fonts,
						order = 7,
					},
					msgfonteffect = {
						name = L["Message Font Effect"],
						type = "select",
						get = "GetMsgFontEffect",
						set = "SetMsgFontEffect",
						values = ShockAndAwe.fonteffects,
						order = 8,
					},
					msgfontsize = {
						type = 'range',
						name = L["Message Font Size"],
						min = 6,
						max = 32,
						step = 1,
						get = "GetMsgFontSize",
						set = "SetMsgFontSize",
						order = 9,
					},
					mw4sound = {
						type = 'select',
						name = L["Maelstrom Sound 4"],
						get = "GetMW4sound",
						set = "SetMW4sound",
						values = ShockAndAwe.sounds,
						order = 10,
					},
					mw5sound = {
						type = 'select',
						name = L["Maelstrom Sound 5"],
						get = "GetMW5sound",
						set = "SetMW5sound",
						values = ShockAndAwe.sounds,
						order = 11,
					},
					mw5repeat = {
						type = 'range',
						name = L["Sound Repeat Interval"],
						desc = L["help_mw5repeat"],
						min = 1,
						max = 10,
						step = 0.1,
						get = "GetMW5repeat",
						set = "SetMW5repeat",
						order = 12,
					},
					shieldsound = {
						type = 'select',
						name = L["Shield Sound"],
						get = "GetShieldSound",
						set = "SetShieldSound",
						values = ShockAndAwe.sounds,
						order = 13,
					},
					weaponsound = {
						type = 'select',
						name = L["Weapon Sound"],
						get = "GetWeaponSound",
						set = "SetWeaponSound",
						values = ShockAndAwe.sounds,
						order = 14,
					},
				},
			},
			uptime = {
				name = L["Uptime Frame"],
				type = 'group',
				order = 8,
				args = {
					break1 = {
						type = 'header',
						name = L["Bar Colours"],
						dialogHidden = true,
						order = 1,
					},
					flurry = {
						type = 'color',
						name = L["Flurry Colour"],
						desc = L["colFlurry"],
						get = "getFlurryColour",
						set = "setFlurryColour",
						hasAlpha = true,
						order = 2,
					},										
					break2 = {
						type = 'header',
						name = L["Misc Options"],
						dialogHidden = true,
						order = 10,
					},
					show = {
						type = 'toggle',
						name = L["Show Frame"],
						desc = L["help_showuptime"],
						get = "showUptimeQuery",
						set = "ActivateShowUptime",
						order = 11,
					},			
				},			
			},
			stats = {
				name = L["Stats Frame"],
				type = 'group',
				order = 9,
				args = {
					showWFtotals = {
						type = 'toggle',
						name = L["Show Windfury Totals"],
						desc = L["help_showwftotals"],
						get = "GetShowWFTotals",
						set = "SetShowWFTotals",
						order = 1,
					},
					wfcol = {
						type = 'color',
						name = L["Windfury Totals Colour"],
						desc = L["colWFTotals"],
						get = "getWFTotalsColour",
						set = "setWFTotalsColour",
						hasAlpha = true,
						order = 7,
					},
				},
			},				
			specchangewarning = {
				type = 'toggle',
				name = L["Warn on Spec Change"],
				desc = L["help_specchangewarning"],
				get = "specchangewarningQuery",
				set = "Activatespecchangewarning",
				order = 19,
			},			
			debug = {
				type = 'toggle',
				name = L["Debug mode"],
				desc = L["help_debug"],
				get = "debugQuery",
				set = "ActivateDebug",
				order = 20,
			},
			moveframes = {
				type = 'toggle',
				name = L["Move Frames"],
				desc = L["help_display"],
				get = "MovingFramesQuery",
				set = "ShowHideBars",
				order = 21,
			},
			testbar = {
				type = 'execute',
				name = L["Display Test Bar"],
				desc = L["help_testbar"],
				func = "WFProcBar",
				order = 22,
			},
			export = {
				type = 'execute',
				name = L["Export to Sim"],
				desc = L["help_export"],
				func = "ExportToSim",
				order = 23,
			},
			config = {
				type = 'execute',
				name = L["Configure Options"],
				desc = L["help_config"],
				func = "OpenConfig",
				order = 24,
			},
			news = {
				type = 'execute',
				name = L["Display News"],
				desc = L["help_news"],
				func = function() ShockAndAwe:News(true); end,
				order = 25,
			},
			enable = {
				type = 'execute',
				name = L["Enable/Disable"],
				desc = L["help_disable"],
				func = "EnableDisable",
				order = 26,
			},
			disable = {
				type = 'execute',
				name = L["Enable/Disable"],
				desc = L["help_disable"],
				func = "EnableDisable",
				guiHidden = true,
				order = 27,
			},
			resetimmunity = {
				type = 'execute',
				name = L["Reset Immunity"],
				desc = L["help_resetImmunity"],
				func = "ResetImmunity",
				order = 28,
			},
			version = {
				type = 'execute',
				name = L["Version"],
				desc = L["help_version"],
				func = "DisplayVersion",
				order = 29,
			},
			help = {
				type = 'description',
				name = L["help"],
				guiHidden = true,
				order = 30,
			},
			priorities = { 
				name = L["Set Priorities"],
				type='group',
				childGroups ='tree',
				order = 5,
				args = {			
					prioritygroup = {
						type = 'select',
						name = L["Priority Group"],
						get = "GetPriorityGroup",
						set = "SetPriorityGroup",
						values = { L["Priority Group One"],  L["Priority Group Two"], L["Priority Group Three"], L["Priority Group Four"], L["Priority Group Five"] },
						order = 1,
					},
					priority1 = {
						type = 'select',
						name = L["First Priority"],
						get = ShockAndAwe:GetPriority(1),
						set = ShockAndAwe:SetPriority(1),
						values = ShockAndAwe.priorityTable.name,
						order = 31,
					},
					priority2 = {
						type = 'select',
						name = L["Second Priority"],
						get = ShockAndAwe:GetPriority(2),
						set = ShockAndAwe:SetPriority(2),
						values = ShockAndAwe.priorityTable.name,
						order = 32,
					},
					priority3 = {
						type = 'select',
						name = L["Third Priority"],
						get = ShockAndAwe:GetPriority(3),
						set = ShockAndAwe:SetPriority(3),
						values = ShockAndAwe.priorityTable.name,
						order = 33,
					},
					priority4 = {
						type = 'select',
						name = L["Fourth Priority"],
						get = ShockAndAwe:GetPriority(4),
						set = ShockAndAwe:SetPriority(4),
						values = ShockAndAwe.priorityTable.name,
						order = 34,
					},
					priority5 = {
						type = 'select',
						name = L["Fifth Priority"],
						get = ShockAndAwe:GetPriority(5),
						set = ShockAndAwe:SetPriority(5),
						values = ShockAndAwe.priorityTable.name,
						order = 35,
					},
					priority6 = {
						type = 'select',
						name = L["Sixth Priority"],
						get = ShockAndAwe:GetPriority(6),
						set = ShockAndAwe:SetPriority(6),
						values = ShockAndAwe.priorityTable.name,
						order = 36,
					},
					priority7 = {
						type = 'select',
						name = L["Seventh Priority"],
						get = ShockAndAwe:GetPriority(7),
						set = ShockAndAwe:SetPriority(7),
						values = ShockAndAwe.priorityTable.name,
						order = 37,
					},
					priority8 = {
						type = 'select',
						name = L["Eighth Priority"],
						get = ShockAndAwe:GetPriority(8),
						set = ShockAndAwe:SetPriority(8),
						values = ShockAndAwe.priorityTable.name,
						order = 38,
					},
					priority9 = {
						type = 'select',
						name = L["Ninth Priority"],
						get = ShockAndAwe:GetPriority(9),
						set = ShockAndAwe:SetPriority(9),
						values = ShockAndAwe.priorityTable.name,
						order = 39,
					},
					priority10 = {
						type = 'select',
						name = L["Tenth Priority"],
						get = ShockAndAwe:GetPriority(10),
						set = ShockAndAwe:SetPriority(10),
						values = ShockAndAwe.priorityTable.name,
						order = 40,
					},
					priority11 = {
						type = 'select',
						name = L["Eleventh Priority"],
						get = ShockAndAwe:GetPriority(11),
						set = ShockAndAwe:SetPriority(11),
						values = ShockAndAwe.priorityTable.name,
						order = 41,
					},
					priority12 = {
						type = 'select',
						name = L["Twelfth Priority"],
						get = ShockAndAwe:GetPriority(12),
						set = ShockAndAwe:SetPriority(12),
						values = ShockAndAwe.priorityTable.name,
						order = 42,
					},
					priority13 = {
						type = 'select',
						name = L["Thirteenth Priority"],
						get = ShockAndAwe:GetPriority(13),
						set = ShockAndAwe:SetPriority(13),
						values = ShockAndAwe.priorityTable.name,
						order = 43,
					},
					priority14 = {
						type = 'select',
						name = L["Fourteenth Priority"],
						get = ShockAndAwe:GetPriority(14),
						set = ShockAndAwe:SetPriority(14),
						values = ShockAndAwe.priorityTable.name,
						order = 44,
					},
					priority15 = {
						type = 'select',
						name = L["Fifteenth Priority"],
						get = ShockAndAwe:GetPriority(15),
						set = ShockAndAwe:SetPriority(15),
						values = ShockAndAwe.priorityTable.name,
						order = 45,
					},
					priority16 = {
						type = 'select',
						name = L["Sixteenth Priority"],
						get = ShockAndAwe:GetPriority(16),
						set = ShockAndAwe:SetPriority(16),
						values = ShockAndAwe.priorityTable.name,
						order = 46,
					},
				}
			}
		}
	}
	return options
end

function ShockAndAwe:ActivateSS()
	ShockAndAwe.db.char.ssshow = not ShockAndAwe.db.char.ssshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.ssshow) then
		ShockAndAwe:Print(L["config_SS_on"])
	else
		ShockAndAwe:Print(L["config_SS_off"])
	end
end

function ShockAndAwe:ActivateFireTotem()
	ShockAndAwe.db.char.firetotemshow = not ShockAndAwe.db.char.firetotemshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.firetotemshow) then
		ShockAndAwe:Print(L["config_magma_on"])
	else
		ShockAndAwe:Print(L["config_magma_off"])
	end
end

function ShockAndAwe:ActivateUnleashElements()
	ShockAndAwe.db.char.unleashelementsshow = not ShockAndAwe.db.char.unleashelementsshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.unleashelementsshow) then
		ShockAndAwe:Print(L["config_Unleash_on"])
	else
		ShockAndAwe:Print(L["config_Unleash_off"])
	end
end

function ShockAndAwe:ActivateElementalBlast()
	ShockAndAwe.db.char.ElementalBlastShow = not ShockAndAwe.db.char.ElementalBlastShow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.ElementalBlastShow) then
		ShockAndAwe:Print(L["config_ElementalBlast_on"])
	else
		ShockAndAwe:Print(L["config_ElementalBlast_off"])
	end
end

function ShockAndAwe:ActivateWF()
	ShockAndAwe.db.char.wfshow = not ShockAndAwe.db.char.wfshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.wfshow) then
		ShockAndAwe:Print(L["config_WF_on"])
	else
		ShockAndAwe:Print(L["config_WF_off"])
	end
end

function ShockAndAwe:ActivateShock()
	ShockAndAwe.db.char.shockshow = not ShockAndAwe.db.char.shockshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.shockshow) then
		ShockAndAwe:Print(L["config_Shock_on"])
	else
		ShockAndAwe:Print(L["config_Shock_off"])
	end
end

function ShockAndAwe:ActivateFSDotBar()
	ShockAndAwe.db.char.fsdotshow = not ShockAndAwe.db.char.fsdotshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.fsdotshow) then
		ShockAndAwe:Print(L["config_FSDotShow_on"])
	else
		ShockAndAwe:Print(L["config_FSDotShow_off"])
	end
end

function ShockAndAwe:ActivateShear()
	ShockAndAwe.db.char.shearshow = not ShockAndAwe.db.char.shearshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.shearshow) then
		ShockAndAwe:Print(L["config_Shear_on"])
	else
		ShockAndAwe:Print(L["config_Shear_off"])
	end
end

function ShockAndAwe:ActivateStoneBulwark()
	ShockAndAwe.db.char.sbtshow = not ShockAndAwe.db.char.sbtshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.sbtshow) then
		ShockAndAwe:Print(L["config_sb_on"])
	else
		ShockAndAwe:Print(L["config_sb_off"])
	end
end

function ShockAndAwe:ActivateWfOverlay()
	ShockAndAwe.db.char.wfoverlay = not ShockAndAwe.db.char.wfoverlay
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.wfoverlay) then
		ShockAndAwe:Print(L["config_wfoverlay_on"])
	else
		ShockAndAwe:Print(L["config_wfoverlay_off"])
	end
end

function ShockAndAwe:ActivateFeralSpirit()
	ShockAndAwe.db.char.fsshow = not ShockAndAwe.db.char.fsshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.fsshow) then
		ShockAndAwe:Print(L["config_feralspirit_on"])
	else
		ShockAndAwe.frames["FeralSpirit"]:Hide()
		ShockAndAwe:Print(L["config_feralspirit_off"])
	end
end

function ShockAndAwe:ActivateShield()
	ShockAndAwe.db.char.shieldshow = not ShockAndAwe.db.char.shieldshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.shieldshow) then
		ShockAndAwe:Print(L["config_Sheild_on"])
	else
		ShockAndAwe.frames["Shield"]:Hide()
		ShockAndAwe:Print(L["config_Sheild_off"])
	end
end

function ShockAndAwe:ActivateArena()
	ShockAndAwe.db.char.arena = not ShockAndAwe.db.char.arena
	ShockAndAwe:SetTalentEffects()
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.arena) then
		ShockAndAwe:Print(L["config_Arena_on"])
	else
		ShockAndAwe:Print(L["config_Arena_off"])
	end
end

function ShockAndAwe:ActivateShowUptime()
	ShockAndAwe.db.char.uptime.show = not ShockAndAwe.db.char.uptime.show
	if (ShockAndAwe.db.char.uptime.show) then
		ShockAndAwe.UptimeFrame:Show()
		ShockAndAwe:Print(L["config_Uptime_on"])
	else
		ShockAndAwe.UptimeFrame:Hide()
		ShockAndAwe:Print(L["config_Uptime_off"])
	end
end

function ShockAndAwe:ActivateMaelstrom()
	ShockAndAwe.db.char.msshow = not ShockAndAwe.db.char.msshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.msshow) then
		ShockAndAwe:MaelstromBar()
		ShockAndAwe.db.char.msstacks = ShockAndAwe:GetMaelstromInfo()
		ShockAndAwe:Print(L["config_MW_on"])
	else
		ShockAndAwe.frames["Maelstrom"]:Hide()
		ShockAndAwe:Print(L["config_MW_off"])
	end
end

function ShockAndAwe:ActivateLavaLash()
	ShockAndAwe.db.char.llshow = not ShockAndAwe.db.char.llshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.llshow) then
		ShockAndAwe:Print(L["config_LL_on"])
	else
		ShockAndAwe.frames["LavaLash"]:Hide()
		ShockAndAwe:Print(L["config_LL_off"])
	end
end

function ShockAndAwe:ActivateFireNova()
	ShockAndAwe.db.char.fnshow = not ShockAndAwe.db.char.fnshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.fnshow) then
		ShockAndAwe:Print(L["config_FN_on"])
	else
		ShockAndAwe.frames["FireNova"]:Hide()
		ShockAndAwe:Print(L["config_FN_off"])
	end
end

function ShockAndAwe:ActivateGCD()
	ShockAndAwe.db.char.gcdshow = not ShockAndAwe.db.char.gcdshow
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.gcdshow) then
		ShockAndAwe.frames["GCD"]:Show()
		ShockAndAwe:Print(L["config_GCD_on"])
	else
		ShockAndAwe.frames["GCD"]:Hide()
		ShockAndAwe:Print(L["config_GCD_off"])
	end
end

function ShockAndAwe:ActivateGCDfullwidth()
	ShockAndAwe.db.char.gcdfullwidth = not ShockAndAwe.db.char.gcdfullwidth
	ShockAndAwe:SetTalentEffects()
	ShockAndAwe:CreateBaseFrame()
	if (ShockAndAwe.db.char.gcdfullwidth) then
		ShockAndAwe:Print(L["config_GCD_fullwidth_on"])
	else
		ShockAndAwe:Print(L["config_GCD_fullwidth_off"])
	end
end

function ShockAndAwe:Activatedisablebars()
	ShockAndAwe.db.char.disablebars = not ShockAndAwe.db.char.disablebars
	if (ShockAndAwe.db.char.disablebars) then
		if not InCombatLockdown() then
			ShockAndAwe.BaseFrame:Hide()
		end
		ShockAndAwe:Print(L["config_disable_on"])
	else
		ShockAndAwe.BaseFrame:Show()
		ShockAndAwe:Print(L["config_disable_off"])
	end
end

function ShockAndAwe:ActivateBarIcons()
	ShockAndAwe.db.char.showicons = not ShockAndAwe.db.char.showicons
	if (ShockAndAwe.db.char.showicons) then
		ShockAndAwe:Print(L["config_baricons_on"])
	else
		ShockAndAwe:Print(L["config_baricons_off"])
	end
end

function ShockAndAwe:ActivateDebug()
	ShockAndAwe.db.char.debug = not ShockAndAwe.db.char.debug
	if (ShockAndAwe.db.char.debug) then
		ShockAndAwe:Print(L["config_debug_on"])
	else
		ShockAndAwe:Print(L["config_debug_off"])
	end
end

function ShockAndAwe:Activatespecchangewarning()
	ShockAndAwe.db.char.specchangewarning = not ShockAndAwe.db.char.specchangewarning
	if (ShockAndAwe.db.char.specchangewarning) then
		ShockAndAwe:Print(L["config_specchangewarning_on"])
	else
		ShockAndAwe:Print(L["config_specchangewarning_off"])
	end
end

function ShockAndAwe:ActivateWindShear()
	ShockAndAwe.db.char.windshearshow = not ShockAndAwe.db.char.windshearshow
	if (ShockAndAwe.db.char.windshearshow) then
		ShockAndAwe:Print(L["config_WSicon_on"])
	else
		ShockAndAwe:Print(L["config_WSicon_off"])
	end
end

function ShockAndAwe:ActivateComboPoints()
	ShockAndAwe.db.char.priority.combopoints = not ShockAndAwe.db.char.priority.combopoints
	if (ShockAndAwe.db.char.priority.combopoints) then
		for index = 1, 5 do
			ShockAndAwe.PriorityFrame.combo[index].frame:Show()
		end
		ShockAndAwe:Print(L["config_combopoints_on"])
	else
		for index = 1, 5 do
			ShockAndAwe.PriorityFrame.combo[index].frame:Hide()
		end
		ShockAndAwe:Print(L["config_combopoints_off"])
	end
end

function ShockAndAwe:ActivateWorldBoss()
	ShockAndAwe.db.char.priority.worldbossonly = not ShockAndAwe.db.char.priority.worldbossonly
	if (ShockAndAwe.db.char.priority.worldbossonly) then
		ShockAndAwe:Print(L["config_worldboss_on"])
	else
		ShockAndAwe:Print(L["config_worldboss_off"])
	end
end

function ShockAndAwe:ActivateHideImmune()
	ShockAndAwe.db.char.priority.hideImmune = not ShockAndAwe.db.char.priority.hideImmune
	if (ShockAndAwe.db.char.priority.hideImmune) then
		ShockAndAwe:Print(L["config_hideimmune_on"])
	else
		ShockAndAwe:Print(L["config_hideimmune_off"])
	end
end

function ShockAndAwe:ActivateShowInterrupt()
	ShockAndAwe.db.char.priority.showinterrupt = not ShockAndAwe.db.char.priority.showinterrupt
	if (ShockAndAwe.db.char.priority.showinterrupt) then
		ShockAndAwe.PriorityFrame.interrupt.frame:Show()
		ShockAndAwe:Print(L["config_showinterrupt_on"])
	else
		ShockAndAwe.PriorityFrame.interrupt.frame:Hide()
		ShockAndAwe:Print(L["config_showinterrupt_off"])
	end
end

function ShockAndAwe:ActivateShowPurge()
	ShockAndAwe.db.char.priority.showpurge = not ShockAndAwe.db.char.priority.showpurge
	if (ShockAndAwe.db.char.priority.showpurge) then
		ShockAndAwe.PriorityFrame.purge.frame:Show()
		ShockAndAwe:Print(L["config_showpurge_on"])
	else
		ShockAndAwe.PriorityFrame.purge.frame:Hide()
		ShockAndAwe:Print(L["config_showpurge_off"])
	end
end

function ShockAndAwe:ActivateShowCooldown()
	ShockAndAwe.db.char.priority.showcooldown = not ShockAndAwe.db.char.priority.showcooldown
	if (ShockAndAwe.db.char.priority.showcooldown) then
		ShockAndAwe:Print(L["config_showcooldown_on"])
	else
		ShockAndAwe:Print(L["config_showcooldown_off"])
	end
end

function ShockAndAwe:ActivateTextOnBars()
	ShockAndAwe.db.char.barstext = not ShockAndAwe.db.char.barstext
	ShockAndAwe:UpdateShieldBar()
	if (ShockAndAwe.db.char.barstext) then
		ShockAndAwe:Print(L["config_Barstext_on"])
	else
		ShockAndAwe:Print(L["config_Barstext_off"])
	end
end

function ShockAndAwe:ActivateMW5sound()
	ShockAndAwe.db.char.mw5soundplay = not ShockAndAwe.db.char.mw5soundplay
	if (ShockAndAwe.db.char.mw5soundplay) then
		ShockAndAwe:Print(L["config_mw5soundplay_on"])
	else
		ShockAndAwe:Print(L["config_mw5soundplay_off"])
	end
end

function ShockAndAwe:ActivateMW4sound()
	ShockAndAwe.db.char.mw4soundplay = not ShockAndAwe.db.char.mw4soundplay
	if (ShockAndAwe.db.char.mw4soundplay) then
		ShockAndAwe:Print(L["config_mw4soundplay_on"])
	else
		ShockAndAwe:Print(L["config_mw4soundplay_off"])
	end
end

function ShockAndAwe:ActivateMW5flash()
	ShockAndAwe.db.char.mw5flash = not ShockAndAwe.db.char.mw5flash
	if (ShockAndAwe.db.char.mw5flash) then
		ShockAndAwe:Print(L["config_mw5flash_on"])
	else
		UIFrameFlashStop(ShockAndAwe.frames["Maelstrom"])
		ShockAndAwe:SetMaelstromAlpha(ShockAndAwe.db.char.colours.msalpha)
		ShockAndAwe:Print(L["config_mw5flash_off"])
	end
end

function ShockAndAwe:ShowPetFrame()
	ShockAndAwe.db.char.petframeshow = not ShockAndAwe.db.char.petframeshow
	if ShockAndAwe.db.char.petframeshow then
		ShockAndAwe:EnablePetFrame()
		ShockAndAwe:Print(L["Enabled display of Feral Spirit Pet frame"])
	else
		ShockAndAwe:Print(L["Disabled display of Feral Spirit Pet frame"])
	end
end

function ShockAndAwe:ShowHideBars()
	ShockAndAwe.db.char.movingframes = not ShockAndAwe.db.char.movingframes
	if ShockAndAwe.db.char.movingframes then
		ShockAndAwe.PriorityFrame:EnableMouse(1)
		ShockAndAwe.PriorityFrame:SetBackdropColor(0, 0, 0, 1)
		ShockAndAwe.PriorityFrame:Show()
		ShockAndAwe.UptimeFrame:EnableMouse(1)
		ShockAndAwe.UptimeFrame:SetBackdropColor(0, 0, 0, 1)
		ShockAndAwe.UptimeFrame:Show()
		ShockAndAwe.msgFrame:EnableMouse(1)
		ShockAndAwe.msgFrame:SetBackdropColor(0, 0, 0, 1)
		ShockAndAwe.msgFrame:Show()
		ShockAndAwe.BaseFrame:EnableMouse(1)
		ShockAndAwe.BaseFrame:SetBackdropColor(0, 0, 0, 1);
		ShockAndAwe.frames["Maelstrom"]:Show()
		ShockAndAwe.frames["Stormstrike"]:Show()
		ShockAndAwe.frames["Shock"]:Show()
		ShockAndAwe.frames["Windfury"]:Show()
		ShockAndAwe.frames["Shield"]:Show()
		ShockAndAwe.frames["LavaLash"]:Show()
		ShockAndAwe.frames["FeralSpirit"]:Show()
		ShockAndAwe.frames["GCD"]:Show()
		ShockAndAwe.frames["fireTotem"]:Show()
		ShockAndAwe.frames["FireNova"]:Show()
	else
		ShockAndAwe.PriorityFrame:EnableMouse(0);
		ShockAndAwe.PriorityFrame:SetBackdropColor(1, 1, 1, 0);
		ShockAndAwe.BaseFrame:EnableMouse(0);
		ShockAndAwe.BaseFrame:SetBackdropColor(1, 1, 1, 0);
		ShockAndAwe.UptimeFrame:EnableMouse(0)
		ShockAndAwe.UptimeFrame:SetBackdropColor(0, 0, 0, 0.3);
		ShockAndAwe.msgFrame:EnableMouse(0)
		ShockAndAwe.msgFrame:SetBackdropColor(1, 1, 1, 0);
		-- ShockAndAwe.BaseFrame:Hide()
		ShockAndAwe.frames["Maelstrom"]:Hide()
		ShockAndAwe.frames["Stormstrike"]:Hide()
		ShockAndAwe.frames["Shock"]:Hide()
		ShockAndAwe.frames["Windfury"]:Hide()
		ShockAndAwe.frames["LavaLash"]:Hide()
		ShockAndAwe.frames["GCD"]:Hide()
		ShockAndAwe.frames["fireTotem"]:Hide()
		ShockAndAwe.frames["FireNova"]:Hide()
		ShockAndAwe:UpdateShieldBar()
		if ShockAndAwe.db.char.priority.show and InCombatLockdown() then
			ShockAndAwe.PriorityFrame:Show()
		else
			ShockAndAwe.PriorityFrame:Hide()
		end
		if ShockAndAwe.db.char.fsshow and InCombatLockdown() then
			ShockAndAwe.frames["FeralSpirit"]:Show()
		else
			ShockAndAwe.frames["FeralSpirit"]:Hide()
		end
		if ShockAndAwe.db.char.uptime.show then
			ShockAndAwe.UptimeFrame:Show()
		else
			ShockAndAwe.UptimeFrame:Hide()
		end
	end
	ShockAndAwe:SetPriorityUpdateScript()
end

function ShockAndAwe:FinishedMoving(var, frame)
	local point, relativeTo, relativePoint, xOffset, yOffset = frame:GetPoint();
	var.point = point
	var.relativeTo = relativeTo
	var.relativePoint = relativePoint
	var.xOffset = xOffset
	var.yOffset = yOffset
end

function ShockAndAwe:SetShowWFTotals(info, newValue)
	ShockAndAwe.db.char.stats.wfcalc = newValue
	if (ShockAndAwe.db.char.stats.wfcalc) then
		ShockAndAwe:Print(L["config_wfcalc_on"])
	else
		ShockAndAwe:Print(L["config_wfcalc_off"])
	end
end

function ShockAndAwe:MovingFramesQuery()
	return ShockAndAwe.db.char.movingframes
end

function ShockAndAwe:PetFrameQuery()
	return ShockAndAwe.db.char.petframeshow
end

function ShockAndAwe:SSQuery()
	return ShockAndAwe.db.char.ssshow
end

function ShockAndAwe:FireTotemQuery()
	return ShockAndAwe.db.char.firetotemshow
end

function ShockAndAwe:UnleashElementsQuery()
	return ShockAndAwe.db.char.unleashelementsshow
end

function ShockAndAwe:ElementalBlastQuery()
	return ShockAndAwe.db.char.ElementalBlastShow
end

function ShockAndAwe:WFQuery()
	return ShockAndAwe.db.char.wfshow
end

function ShockAndAwe:shockQuery()
	return ShockAndAwe.db.char.shockshow
end

function ShockAndAwe:fsdotbarQuery()
	return ShockAndAwe.db.char.fsdotshow
end

function ShockAndAwe:shearQuery()
	return ShockAndAwe.db.char.shearshow
end

function ShockAndAwe:StoneBulwarkQuery()
	return ShockAndAwe.db.char.sbtshow
end

function ShockAndAwe:WfOverlayQuery()
	return ShockAndAwe.db.char.wfoverlay
end

function ShockAndAwe:gcdQuery()
	return ShockAndAwe.db.char.gcdshow
end

function ShockAndAwe:gcdFullwidthQuery()
	return ShockAndAwe.db.char.gcdfullwidth
end

function ShockAndAwe:windshearQuery()
	return ShockAndAwe.db.char.windshearshow
end

function ShockAndAwe:combopointsQuery()
	return ShockAndAwe.db.char.priority.combopoints
end

function ShockAndAwe:worldbossQuery()
	return ShockAndAwe.db.char.priority.worldbossonly
end

function ShockAndAwe:hideImmuneQuery()
	return ShockAndAwe.db.char.priority.hideImmune
end

function ShockAndAwe:showinterruptQuery()
	return ShockAndAwe.db.char.priority.showinterrupt
end

function ShockAndAwe:showpurgeQuery()
	return ShockAndAwe.db.char.priority.showpurge
end

function ShockAndAwe:showcooldownQuery()
	return ShockAndAwe.db.char.priority.showcooldown
end

function ShockAndAwe:feralspiritQuery()
	return ShockAndAwe.db.char.fsshow
end

function ShockAndAwe:shieldQuery()
	return ShockAndAwe.db.char.shieldshow
end

function ShockAndAwe:disablebarsQuery()
	return ShockAndAwe.db.char.disablebars
end

function ShockAndAwe:bariconsQuery()
	return ShockAndAwe.db.char.showicons
end

function ShockAndAwe:arenaQuery()
	return ShockAndAwe.db.char.arena
end

function ShockAndAwe:showUptimeQuery()
	return ShockAndAwe.db.char.uptime.show
end

function ShockAndAwe:maelstromQuery()
	return ShockAndAwe.db.char.msshow
end

function ShockAndAwe:lavalashQuery()
	return ShockAndAwe.db.char.llshow
end

function ShockAndAwe:firenovaQuery()
	return ShockAndAwe.db.char.fnshow
end

function ShockAndAwe:textOnBarsQuery()
    return ShockAndAwe.db.char.barstext
end

function ShockAndAwe:mw5soundplayQuery()
    return ShockAndAwe.db.char.mw5soundplay
end

function ShockAndAwe:mw4soundplayQuery()
    return ShockAndAwe.db.char.mw4soundplay
end

function ShockAndAwe:mw5flashQuery()
    return ShockAndAwe.db.char.mw5flash
end

function ShockAndAwe:debugQuery()
	return ShockAndAwe.db.char.debug
end

function ShockAndAwe:specchangewarningQuery()
	return ShockAndAwe.db.char.specchangewarning
end

function ShockAndAwe:GetBarTexture()
    return ShockAndAwe.db.char.texture
end

function ShockAndAwe:GetBorderTexture()
    return ShockAndAwe.db.char.border
end

function ShockAndAwe:GetBarBorderTexture()
    return ShockAndAwe.db.char.barborder
end

function ShockAndAwe:GetBarFont()
    return ShockAndAwe.db.char.barfont
end

function ShockAndAwe:GetBarFontSize()
    return ShockAndAwe.db.char.barfontsize
end

function ShockAndAwe:GetBarFontEffect()
    return ShockAndAwe.db.char.barfonteffect
end

function ShockAndAwe:GetMsgFont()
    return ShockAndAwe.db.char.msgfont
end

function ShockAndAwe:GetMsgFontSize()
    return ShockAndAwe.db.char.msgfontsize
end

function ShockAndAwe:GetMsgFontEffect()
    return ShockAndAwe.db.char.msgfonteffect
end

function ShockAndAwe:GetWidth()
    return ShockAndAwe.db.char.fWidth
end

function ShockAndAwe:GetScale()
    return ShockAndAwe.db.char.scale
end

function ShockAndAwe:GetPriorityScale()
    return ShockAndAwe.db.char.priority.scale
end

function ShockAndAwe:GetMSalpha()
    return ShockAndAwe.db.char.colours.msalpha
end

function ShockAndAwe:GetMSalphaFull()
    return ShockAndAwe.db.char.colours.msalphaFull
end

function ShockAndAwe:GetShieldSound()
    return ShockAndAwe.db.char.shieldsoundname
end

function ShockAndAwe:GetWeaponSound()
    return ShockAndAwe.db.char.weaponsoundname
end

function ShockAndAwe:GetMW5sound()
    return ShockAndAwe.db.char.mw5soundname
end

function ShockAndAwe:GetMW5repeat()
    return ShockAndAwe.db.char.mw5repeat
end

function ShockAndAwe:GetMW4sound()
    return ShockAndAwe.db.char.mw4soundname
end

function ShockAndAwe:GetThreatThreshold()
    return ShockAndAwe.db.char.threatThreshold
end

function ShockAndAwe:GetCooldownThreshold()
    return ShockAndAwe.db.char.priority.cooldown
end

function ShockAndAwe:GetFSTicksLeft()
    return ShockAndAwe.db.char.priority.fsticksleft
end

function ShockAndAwe:GetTotemTimeLeft()
    return ShockAndAwe.db.char.priority.totemtimeleft
end

function ShockAndAwe:GetSRMana()
    return ShockAndAwe.db.char.priority.srmana
end

function ShockAndAwe:GetWSMana()
    return ShockAndAwe.db.char.priority.wsmana
end

function ShockAndAwe:GetShieldOrbs()
    return ShockAndAwe.db.char.priority.shieldorbs
end

function ShockAndAwe:GetMagmaTicks()
    return ShockAndAwe.db.char.priority.magmaticks
end

function ShockAndAwe:GetSearingTicks()
    return ShockAndAwe.db.char.priority.searingticks
end

function ShockAndAwe:GetHWHealth()
    return ShockAndAwe.db.char.priority.hwhealth
end

function ShockAndAwe:GetCHInGroup()
	return ShockAndAwe.db.char.priority.chingroup 
end

function ShockAndAwe:GetRebuffTime()
    return ShockAndAwe.db.char.warning.timeleft
end

function ShockAndAwe:GetShowWFTotals()
	return ShockAndAwe.db.char.stats.wfcalc
end

function ShockAndAwe:SetCHInGroup()
	ShockAndAwe.db.char.priority.chingroup = not ShockAndAwe.db.char.priority.chingroup
	if (ShockAndAwe.db.char.priority.chingroup) then
		ShockAndAwe:Print(L["config_chingroup_on"])
	else
		ShockAndAwe:Print(L["config_chingroup_off"])
	end
end

function ShockAndAwe:SetBarFont(info, newValue)
	ShockAndAwe.db.char.barfont = newValue
	ShockAndAwe:RedrawFrames()
end

function ShockAndAwe:SetBarFontSize(info, newValue)
	ShockAndAwe.db.char.barfontsize = newValue
	ShockAndAwe:RedrawFrames()
end

function ShockAndAwe:SetBarFontEffect(info, newValue)
	ShockAndAwe.db.char.barfonteffect = newValue
	ShockAndAwe:RedrawFrames()
end

function ShockAndAwe:SetMsgFont(info, newValue)
	ShockAndAwe.db.char.msgfont = newValue
	ShockAndAwe:CreateMsgFrame()
end

function ShockAndAwe:SetMsgFontSize(info, newValue)
	ShockAndAwe.db.char.msgfontsize = newValue
	ShockAndAwe:CreateMsgFrame()
end

function ShockAndAwe:SetMsgFontEffect(info, newValue)
	ShockAndAwe.db.char.msgfonteffect = newValue
	ShockAndAwe:CreateMsgFrame()
end

function ShockAndAwe:SetBarTexture(info, newValue)
	ShockAndAwe.db.char.texture = newValue
	local barTexture = media:Fetch('statusbar', newValue)
	ShockAndAwe.frames["FeralSpirit"].statusbar:SetStatusBarTexture(barTexture)
	ShockAndAwe.frames["Shield"].statusbar:SetStatusBarTexture(barTexture)
	ShockAndAwe.frames["Maelstrom"].statusbar:SetStatusBarTexture(barTexture)
	ShockAndAwe.frames["LavaLash"].statusbar:SetStatusBarTexture(barTexture)
	ShockAndAwe.frames["Stormstrike"].statusbar:SetStatusBarTexture(barTexture)
	ShockAndAwe.frames["Shock"].statusbar:SetStatusBarTexture(barTexture)
	ShockAndAwe.frames["Windfury"].statusbar:SetStatusBarTexture(barTexture)
	ShockAndAwe.frames["GCD"].statusbar:SetStatusBarTexture(barTexture)
end

function ShockAndAwe:SetBorderTexture(info, newValue)
	ShockAndAwe.db.char.border = newValue
	local newTexture = media:Fetch("border", ShockAndAwe.db.char.border)
	if newTexture then
		ShockAndAwe.frameBackdrop.edgeFile = newTexture
		ShockAndAwe:RedrawFrames()
	else
		if ShockAndAwe.db.char.debug then
			ShockAndAwe:Print("border texture not found. Trying to set "..ShockAndAwe.db.char.border)
		end
	end
end

function ShockAndAwe:SetBarBorderTexture(info, newValue)
	ShockAndAwe.db.char.barborder = newValue
	local newTexture = media:Fetch("border", ShockAndAwe.db.char.barborder)
	if newTexture then
		ShockAndAwe.barBackdrop.edgeFile = newTexture
		ShockAndAwe.frames["FeralSpirit"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe.frames["Shield"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe.frames["Maelstrom"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe.frames["LavaLash"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe.frames["Stormstrike"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe.frames["Shock"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe.frames["Windfury"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe.frames["GCD"]:SetBackdrop(ShockAndAwe.barBackdrop)
		ShockAndAwe:RedrawFrames()
	else
		if ShockAndAwe.db.char.debug then
			ShockAndAwe:Print("bar border texture not found. Trying to set "..ShockAndAwe.db.char.barborder)
		end
	end
end

function ShockAndAwe:SetShieldSound(info, newValue)
	local newSound = media:Fetch("sound", newValue)
	ShockAndAwe.db.char.shieldsoundname = newValue
	if newSound then
		ShockAndAwe.db.char.shieldsound = newSound
		PlaySoundFile(newSound)
	else
		if ShockAndAwe.db.char.debug then
			ShockAndAwe:Print("Sound not found. Trying to set "..newSound)
		end
	end
end

function ShockAndAwe:SetWeaponSound(info, newValue)
	local newSound = media:Fetch("sound", newValue)
	ShockAndAwe.db.char.weaponsoundname = newValue
	if newSound then
		ShockAndAwe.db.char.weaponsound = newSound
		PlaySoundFile(newSound)
	else
		if ShockAndAwe.db.char.debug then
			ShockAndAwe:Print("Sound not found. Trying to set "..newSound)
		end
	end
end

function ShockAndAwe:SetMW5sound(info, newValue)
	local newSound = media:Fetch("sound", newValue)
	ShockAndAwe.db.char.mw5soundname = newValue
	if newSound then
		ShockAndAwe.db.char.mw5sound = newSound
		PlaySoundFile(newSound)
	else
		if ShockAndAwe.db.char.debug then
			ShockAndAwe:Print("Sound not found. Trying to set "..newSound)
		end
	end
end

function ShockAndAwe:SetMW5repeat(info, newValue)
	ShockAndAwe.db.char.mw5repeat = newValue
end

function ShockAndAwe:SetMW4sound(info, newValue)
	local newSound = media:Fetch("sound", newValue)
	ShockAndAwe.db.char.mw4soundname = newValue
	if newSound then
		ShockAndAwe.db.char.mw4sound = newSound
		PlaySoundFile(newSound)
	else
		if ShockAndAwe.db.char.debug then
			ShockAndAwe:Print("Sound not found. Trying to set "..newSound)
		end
	end
end

function ShockAndAwe:SetThreatThreshold(info, newValue)
	ShockAndAwe.db.char.threatThreshold = newValue
	ShockAndAwe:Print(L["config_Threat"]..newValue)
end

function ShockAndAwe:SetCooldownThreshold(info, newValue)
	ShockAndAwe.db.char.priority.cooldown = newValue
	ShockAndAwe:Print(L["config_Cooldown"]..newValue)
end

function ShockAndAwe:SetFSTicksLeft(info, newValue)
	ShockAndAwe.db.char.priority.fsticksleft = newValue
	ShockAndAwe:Print(L["config_FSTicksLeft"]..newValue..L["config_ticksleft"])
end

function ShockAndAwe:SetTotemTimeLeft(info, newValue)
	ShockAndAwe.db.char.priority.totemtimeleft = newValue
	ShockAndAwe:Print(L["config_TotemTimeLeft"]..newValue)
end

function ShockAndAwe:SetSRMana(info, newValue)
	ShockAndAwe.db.char.priority.srmana = newValue
	ShockAndAwe:Print(L["config_srmana"]..newValue)
end

function ShockAndAwe:SetShieldOrbs(info, newValue)
	ShockAndAwe.db.char.priority.shieldorbs = newValue
	ShockAndAwe:Print(L["config_shieldorbs"]..newValue)
end

function ShockAndAwe:SetMagmaTicks(info, newValue)
	ShockAndAwe.db.char.priority.magmaticks = newValue
	ShockAndAwe:Print(string.format(L["config_magmaticks"],newValue))
end

function ShockAndAwe:SetSearingTicks(info, newValue)
	ShockAndAwe.db.char.priority.searingticks = newValue
	ShockAndAwe:Print(string.format(L["config_searingticks"],newValue))
end

function ShockAndAwe:SetWSMana(info, newValue)
	ShockAndAwe.db.char.priority.wsmana = newValue
	ShockAndAwe:Print(L["config_wsmana"]..newValue)
end

function ShockAndAwe:SetHWHealth(info, newValue)
	ShockAndAwe.db.char.priority.hwhealth = newValue
	ShockAndAwe:Print(L["config_hwhealth"]..newValue)
end

function ShockAndAwe:SetRebuffTime(info, newValue)
	ShockAndAwe.db.char.warning.timeleft = newValue
end

function ShockAndAwe:SetWidth(info,newValue)
	if InCombatLockdown() then
		ShockAndAwe:Print(L["Cannot change bar width in combat"])
		return
	end
	local wasMoving = ShockAndAwe.db.char.movingframes
	ShockAndAwe.db.char.fWidth = newValue
	ShockAndAwe:RedrawFrames()
	if wasMoving then
		ShockAndAwe:ShowHideBars()
	end
	ShockAndAwe:DebugPrint(L["Frame width set to : "]..ShockAndAwe.db.char.fWidth)	
end

function ShockAndAwe:SetScale(info,newValue)
	if InCombatLockdown() then
		ShockAndAwe:Print(L["Cannot change scale in combat"])
		return
	end
	local wasMoving = ShockAndAwe.db.char.movingframes
	ShockAndAwe.db.char.scale = newValue
	ShockAndAwe.BaseFrame:SetScale(ShockAndAwe.db.char.scale)
	ShockAndAwe:RedrawFrames()
	if wasMoving then
		ShockAndAwe:ShowHideBars()
	end
	ShockAndAwe:DebugPrint(L["Scale set to : "]..ShockAndAwe.db.char.scale)
end

function ShockAndAwe:SetPriorityScale(info,newValue)
	if InCombatLockdown() then
		ShockAndAwe:Print(L["Cannot change scale in combat"])
	end
	ShockAndAwe.db.char.priority.scale = newValue
	ShockAndAwe.PriorityFrame:SetScale(ShockAndAwe.db.char.priority.scale)
	ShockAndAwe:DebugPrint(L["Priority Scale set to : "]..ShockAndAwe.db.char.priority.scale)
end

function ShockAndAwe:SetMSalpha(info,newValue)
	if ShockAndAwe.db.char.msshow then
		ShockAndAwe.db.char.colours.msalpha = newValue
		ShockAndAwe:SetMaelstromAlpha(ShockAndAwe.db.char.colours.msalpha)
		ShockAndAwe:Print(L["config_MSAlpha_ooc"]..ShockAndAwe.db.char.colours.msalpha)
	end
end

function ShockAndAwe:SetMSalphaFull(info,newValue)
	if ShockAndAwe.db.char.msshow then
		ShockAndAwe.db.char.colours.msalphaFull = newValue
		ShockAndAwe:SetMaelstromAlpha(ShockAndAwe.db.char.colours.msalphaFull)
		ShockAndAwe:Print(L["config_MSAlpha_combat"]..ShockAndAwe.db.char.colours.msalphaFull)
	end
end

function ShockAndAwe:SetMaelstromAlpha(alphaValue)
	ShockAndAwe.frames["Maelstrom"]:SetBackdropColor(0, 0, 0, alphaValue * .2)
	ShockAndAwe.frames["Maelstrom"]:SetBackdropBorderColor( 1, 1, 1, alphaValue)
	local colours = ShockAndAwe.db.char.colours.maelstrom
	ShockAndAwe.frames["Maelstrom"].statusbar:SetStatusBarColor( colours.r, colours.g, colours.b, alphaValue)
end

-----------------------------------------
-- Colour choices getter/setters
-----------------------------------------

function ShockAndAwe:getWaterShieldColour(info)
	local colours = ShockAndAwe.db.char.colours.watershield
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setWaterShieldColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.watershield.r = r
	ShockAndAwe.db.char.colours.watershield.g = g
	ShockAndAwe.db.char.colours.watershield.b = b
	ShockAndAwe.db.char.colours.watershield.a = a
	ShockAndAwe:UpdateShieldBar()
end

function ShockAndAwe:getLightningShieldColour(info)
	local colours = ShockAndAwe.db.char.colours.lightningshield
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setLightningShieldColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.lightningshield.r = r
	ShockAndAwe.db.char.colours.lightningshield.g = g
	ShockAndAwe.db.char.colours.lightningshield.b = b
	ShockAndAwe.db.char.colours.lightningshield.a = a
	ShockAndAwe:UpdateShieldBar()
end

function ShockAndAwe:getEarthShieldColour(info)
	local colours = ShockAndAwe.db.char.colours.earthshield
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setEarthShieldColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.earthshield.r = r
	ShockAndAwe.db.char.colours.earthshield.g = g
	ShockAndAwe.db.char.colours.earthshield.b = b
	ShockAndAwe.db.char.colours.earthshield.a = a
	ShockAndAwe:UpdateShieldBar()
end

function ShockAndAwe:getNoShieldColour(info)
	local colours = ShockAndAwe.db.char.colours.noshield
	return colours.r, colours.g, colours.b, 0.2 -- use out of combat alpha
end

function ShockAndAwe:setNoShieldColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.noshield.r = r
	ShockAndAwe.db.char.colours.noshield.g = g
	ShockAndAwe.db.char.colours.noshield.b = b
	ShockAndAwe.db.char.colours.noshield.a = a
	ShockAndAwe:UpdateShieldBar()
end

function ShockAndAwe:getEarthShockColour(info)
	local colours = ShockAndAwe.db.char.colours.earthshock
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setEarthShockColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.earthshock.r = r
	ShockAndAwe.db.char.colours.earthshock.g = g
	ShockAndAwe.db.char.colours.earthshock.b = b
	ShockAndAwe.db.char.colours.earthshock.a = a
	ShockAndAwe:ShockBar(ShockAndAwe.db.char.colours.earthshock)
end

function ShockAndAwe:getFlameShockColour(info)
	local colours = ShockAndAwe.db.char.colours.flameshock
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setFlameShockColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.flameshock.r = r
	ShockAndAwe.db.char.colours.flameshock.g = g
	ShockAndAwe.db.char.colours.flameshock.b = b
	ShockAndAwe.db.char.colours.flameshock.a = a
	ShockAndAwe:ShockBar(ShockAndAwe.db.char.colours.flameshock)
end

function ShockAndAwe:getFlameShockDotColour(info)
	local colours = ShockAndAwe.db.char.colours.flameshockDot
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setFlameShockDotColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.flameshockDot.r = r
	ShockAndAwe.db.char.colours.flameshockDot.g = g
	ShockAndAwe.db.char.colours.flameshockDot.b = b
	ShockAndAwe.db.char.colours.flameshockDot.a = a
	FSDotTime = GetTime() + 18
	ShockAndAwe:FlameShockDotBar(true) 
end

function ShockAndAwe:getFrostShockColour(info)
	local colours = ShockAndAwe.db.char.colours.frostshock
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setFrostShockColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.frostshock.r = r
	ShockAndAwe.db.char.colours.frostshock.g = g
	ShockAndAwe.db.char.colours.frostshock.b = b
	ShockAndAwe.db.char.colours.frostshock.a = a
	ShockAndAwe:ShockBar(ShockAndAwe.db.char.colours.frostshock)
end

function ShockAndAwe:getWindShearColour(info)
	local colours = ShockAndAwe.db.char.colours.windshear
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setWindShearColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.windshear.r = r
	ShockAndAwe.db.char.colours.windshear.g = g
	ShockAndAwe.db.char.colours.windshear.b = b
	ShockAndAwe.db.char.colours.windshear.a = a
	ShockAndAwe:ShearBar()
end

function ShockAndAwe:getMaelstromColour(info)
	local colours = ShockAndAwe.db.char.colours.maelstrom
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setMaelstromColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.maelstrom.r = r
	ShockAndAwe.db.char.colours.maelstrom.g = g
	ShockAndAwe.db.char.colours.maelstrom.b = b
	ShockAndAwe.db.char.colours.maelstrom.a = a
	ShockAndAwe:MaelstromBar()
end

function ShockAndAwe:getStormstrikeColour(info)
	local colours = ShockAndAwe.db.char.colours.stormstrike
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setStormstrikeColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.stormstrike.r = r
	ShockAndAwe.db.char.colours.stormstrike.g = g
	ShockAndAwe.db.char.colours.stormstrike.b = b
	ShockAndAwe.db.char.colours.stormstrike.a = a
	ShockAndAwe:StormstrikeBar()
end

function ShockAndAwe:getWindfuryColour(info)
	local colours = ShockAndAwe.db.char.colours.windfury
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setWindfuryColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.windfury.r = r
	ShockAndAwe.db.char.colours.windfury.g = g
	ShockAndAwe.db.char.colours.windfury.b = b
	ShockAndAwe.db.char.colours.windfury.a = a
	ShockAndAwe:WFProcBar()
end

function ShockAndAwe:getLavaLashColour(info)
	local colours = ShockAndAwe.db.char.colours.lavalash
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setLavaLashColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.lavalash.r = r
	ShockAndAwe.db.char.colours.lavalash.g = g
	ShockAndAwe.db.char.colours.lavalash.b = b
	ShockAndAwe.db.char.colours.lavalash.a = a
	ShockAndAwe:LavaLashBar()
end

function ShockAndAwe:getFireNovaColour(info)
	local colours = ShockAndAwe.db.char.colours.firenova
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setFireNovaColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.firenova.r = r
	ShockAndAwe.db.char.colours.firenova.g = g
	ShockAndAwe.db.char.colours.firenova.b = b
	ShockAndAwe.db.char.colours.firenova.a = a
	ShockAndAwe:FireNovaBar()
end

function ShockAndAwe:getMagmaColour(info)
	local colours = ShockAndAwe.db.char.colours.magma
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setMagmaColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.magma.r = r
	ShockAndAwe.db.char.colours.magma.g = g
	ShockAndAwe.db.char.colours.magma.b = b
	ShockAndAwe.db.char.colours.magma.a = a
	ShockAndAwe:FireTotemBar()
end

function ShockAndAwe:getUnleashColour(info)
	local colours = ShockAndAwe.db.char.colours.unleash
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setUnleashColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.unleash.r = r
	ShockAndAwe.db.char.colours.unleash.g = g
	ShockAndAwe.db.char.colours.unleash.b = b
	ShockAndAwe.db.char.colours.unleash.a = a
	ShockAndAwe:UnleashBar()
end

function ShockAndAwe:getFeralSpiritCDColour(info)
	local colours = ShockAndAwe.db.char.colours.feralspiritCD
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setFeralSpiritCDColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.feralspiritCD.r = r
	ShockAndAwe.db.char.colours.feralspiritCD.g = g
	ShockAndAwe.db.char.colours.feralspiritCD.b = b
	ShockAndAwe.db.char.colours.feralspiritCD.a = a
	local colours = ShockAndAwe.db.char.colours.feralspiritCD
	ShockAndAwe.frames["FeralSpiritCD"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
end

function ShockAndAwe:getPrimarySBTShield(info)
	local colours = ShockAndAwe.db.char.colours.sbulwarkPrimary
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setPrimarySBTShield(info,r,g,b,a)
	ShockAndAwe.db.char.colours.sbulwarkPrimary.r = r
	ShockAndAwe.db.char.colours.sbulwarkPrimary.g = g
	ShockAndAwe.db.char.colours.sbulwarkPrimary.b = b
	ShockAndAwe.db.char.colours.sbulwarkPrimary.a = a
	local colours = ShockAndAwe.db.char.colours.sbulwarkPrimary
	ShockAndAwe.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
end

function ShockAndAwe:getSecondarySBTShield(info)
	local colours = ShockAndAwe.db.char.colours.sbulwarkSecondary
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setSecondarySBTShield(info,r,g,b,a)
	ShockAndAwe.db.char.colours.sbulwarkSecondary.r = r
	ShockAndAwe.db.char.colours.sbulwarkSecondary.g = g
	ShockAndAwe.db.char.colours.sbulwarkSecondary.b = b
	ShockAndAwe.db.char.colours.sbulwarkSecondary.a = a
	local colours = ShockAndAwe.db.char.colours.sbulwarkSecondary
	ShockAndAwe.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
end

function ShockAndAwe:getDepletedSBTShield(info)
	local colours = ShockAndAwe.db.char.colours.sbulwarkDepleted
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setDepletedSBTShield(info,r,g,b,a)
	ShockAndAwe.db.char.colours.sbulwarkDepleted.r = r
	ShockAndAwe.db.char.colours.sbulwarkDepleted.g = g
	ShockAndAwe.db.char.colours.sbulwarkDepleted.b = b
	ShockAndAwe.db.char.colours.sbulwarkDepleted.a = a
	local colours = ShockAndAwe.db.char.colours.sbulwarkDepleted
	ShockAndAwe.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
end

function ShockAndAwe:getCDSBTShield(info)
	local colours = ShockAndAwe.db.char.colours.sbulwarkCD
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setCDSBTShield(info,r,g,b,a)
	ShockAndAwe.db.char.colours.sbulwarkCD.r = r
	ShockAndAwe.db.char.colours.sbulwarkCD.g = g
	ShockAndAwe.db.char.colours.sbulwarkCD.b = b
	ShockAndAwe.db.char.colours.sbulwarkCD.a = a
	local colours = ShockAndAwe.db.char.colours.sbulwarkCD
	ShockAndAwe.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
end

function ShockAndAwe:getFeralSpiritColour(info)
	local colours = ShockAndAwe.db.char.colours.feralspirit
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setFeralSpiritColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.feralspirit.r = r
	ShockAndAwe.db.char.colours.feralspirit.g = g
	ShockAndAwe.db.char.colours.feralspirit.b = b
	ShockAndAwe.db.char.colours.feralspirit.a = a
	local colours = ShockAndAwe.db.char.colours.feralspirit
	ShockAndAwe.frames["FeralSpirit"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
end

function ShockAndAwe:getLavaBurstColour(info)
	local colours = ShockAndAwe.db.char.colours.lavaburst
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setLavaBurstColour(info,r,g,b,a)
	ShockAndAwe.db.char.colours.lavaburst.r = r
	ShockAndAwe.db.char.colours.lavaburst.g = g
	ShockAndAwe.db.char.colours.lavaburst.b = b
	ShockAndAwe.db.char.colours.lavaburst.a = a
	ShockAndAwe:LavaBurstBar()
end

function ShockAndAwe:getFlurryColour(info)
	local colours = ShockAndAwe.db.char.uptime.flurry
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setFlurryColour(info,r,g,b,a)
	ShockAndAwe.db.char.uptime.flurry.r = r
	ShockAndAwe.db.char.uptime.flurry.g = g
	ShockAndAwe.db.char.uptime.flurry.b = b
	ShockAndAwe.db.char.uptime.flurry.a = a
	local buffColours = ShockAndAwe.db.char.uptime.flurry
	ShockAndAwe.uptime.session.buffs["Flurry"].barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
	ShockAndAwe.uptime.lastfight.buffs["Flurry"].barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
end

function ShockAndAwe:getWFTotalsColour(info)
	local colours = ShockAndAwe.db.char.stats.wfcol
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setWFTotalsColour(info,r,g,b,a)
	ShockAndAwe.db.char.stats.wfcol.r = r
	ShockAndAwe.db.char.stats.wfcol.g = g
	ShockAndAwe.db.char.stats.wfcol.b = b
	ShockAndAwe.db.char.stats.wfcol.a = a
end

-----------------------------------------
-- Priority Choices
-----------------------------------------

function ShockAndAwe:GetPriorityGroup(info)
	return ShockAndAwe.db.char.priority.groupnumber
end

function ShockAndAwe:SetPriorityGroup(info, groupnumber)
	ShockAndAwe.db.char.priority.groupnumber = groupnumber
	ShockAndAwe:SelectPrioritySet(groupnumber)
end

function ShockAndAwe:GetPriority(index)
	return 	
		function(info) 
			return ShockAndAwe.db.char.priority.prOption[index]  
		end
end

function ShockAndAwe:SetPriority(index)
	return 		
		function(info, priorityValue)
			ShockAndAwe:DebugPrint("setting priority "..index.." to "..priorityValue)
			ShockAndAwe.db.char.priority.prOption[index] = priorityValue
			ShockAndAwe.db.char.priority.prOptions[ShockAndAwe.db.char.priority.groupnumber] = ShockAndAwe.db.char.priority.prOption
		end
end

function ShockAndAwe:priorityQuery()
	return ShockAndAwe.db.char.priority.show
end

function ShockAndAwe:ActivatePriority()
	ShockAndAwe.db.char.priority.show = not ShockAndAwe.db.char.priority.show
	if (ShockAndAwe.db.char.priority.show) then
		ShockAndAwe:Print(L["config_priority_on"])
	else
		ShockAndAwe.PriorityFrame:Hide()
		ShockAndAwe:Print(L["config_priority_off"])
	end
end

function ShockAndAwe:priorityTitleQuery()
	return ShockAndAwe.db.char.priority.titleshow
end

function ShockAndAwe:ActivatePriorityTitle()
	ShockAndAwe.db.char.priority.titleshow = not ShockAndAwe.db.char.priority.titleshow
	if ShockAndAwe.db.char.priority.titleshow then
		ShockAndAwe.PriorityFrame.topText:Show()
		ShockAndAwe:Print(L["config_prioritytitle_on"])
	else
		ShockAndAwe.PriorityFrame.topText:Hide()
		ShockAndAwe:Print(L["config_prioritytitle_off"])
	end
end

---------------
-- Warnings
---------------

function ShockAndAwe:WarningFrameQuery()
	return ShockAndAwe.db.char.warning.show
end

function ShockAndAwe:ActivateWarningFrame()
	ShockAndAwe.db.char.warning.show = not ShockAndAwe.db.char.warning.show
	if (ShockAndAwe.db.char.warning.show) then
		ShockAndAwe:Print(L["config_warnframe_on"])
	else
		ShockAndAwe:Print(L["config_warnframe_off"])
	end
end

function ShockAndAwe:shieldWarnQuery()
	return ShockAndAwe.db.char.warning.shield
end

function ShockAndAwe:ActivateShieldWarn()
	ShockAndAwe.db.char.warning.shield = not ShockAndAwe.db.char.warning.shield
	if (ShockAndAwe.db.char.warning.shield) then
		ShockAndAwe:Print(L["config_shieldwarn_on"])
	else
		ShockAndAwe:Print(L["config_shieldwarn_off"])
	end
end

function ShockAndAwe:weaponWarnQuery()
	return ShockAndAwe.db.char.warning.weapon
end

function ShockAndAwe:ActivateWeaponWarn()
	ShockAndAwe.db.char.warning.weapon = not ShockAndAwe.db.char.warning.weapon
	if (ShockAndAwe.db.char.warning.weapon) then
		ShockAndAwe:Print(L["config_weaponwarn_on"])
	else
		ShockAndAwe:Print(L["config_weaponwarn_off"])
	end
end

function ShockAndAwe:rangeWarnQuery()
	return ShockAndAwe.db.char.warning.range
end

function ShockAndAwe:ActivateRangeWarn()
	ShockAndAwe.db.char.warning.range = not ShockAndAwe.db.char.warning.range
	if (ShockAndAwe.db.char.warning.range) then
		ShockAndAwe:Print(L["config_rangewarn_on"])
	else
		ShockAndAwe:Print(L["config_rangewarn_off"])
	end
end

function ShockAndAwe:groundingWarnQuery()
	return ShockAndAwe.db.char.warning.grounding
end

function ShockAndAwe:ActivateGroundingWarn()
	ShockAndAwe.db.char.warning.grounding = not ShockAndAwe.db.char.warning.grounding
	if (ShockAndAwe.db.char.warning.grounding) then
		ShockAndAwe:Print(L["config_groundingwarn_on"])
	else
		ShockAndAwe:Print(L["config_groundingwarn_off"])
	end
end

function ShockAndAwe:interruptWarnQuery()
	return ShockAndAwe.db.char.warning.interrupt
end

function ShockAndAwe:ActivateInterruptWarn()
	ShockAndAwe.db.char.warning.interrupt = not ShockAndAwe.db.char.warning.interrupt
	if (ShockAndAwe.db.char.warning.interrupt) then
		ShockAndAwe:Print(L["config_interruptwarn_on"])
	else
		ShockAndAwe:Print(L["config_interruptwarn_off"])
	end
end

function ShockAndAwe:purgeWarnQuery()
	return ShockAndAwe.db.char.warning.purge
end

function ShockAndAwe:ActivatePurgeWarn()
	ShockAndAwe.db.char.warning.purge = not ShockAndAwe.db.char.warning.purge
	if (ShockAndAwe.db.char.warning.purge) then
		ShockAndAwe:Print(L["config_purgewarn_on"])
	else
		ShockAndAwe:Print(L["config_purgewarn_off"])
	end
end

function ShockAndAwe:EnableDisable()
	if InCombatLockdown() then
		ShockAndAwe:Print(L["Cannot enable/disable addon in combat"])
		return
	end
	ShockAndAwe.db.char.disabled = not ShockAndAwe.db.char.disabled
	if (ShockAndAwe.db.char.disabled) then
		ShockAndAwe:OnDisable()
		ShockAndAwe.BaseFrame:Hide()
		ShockAndAwe.PriorityFrame:Hide()
		ShockAndAwe.UptimeFrame:Hide()
		ShockAndAwe:Print(L["config_disabled_on"])
	else
		ShockAndAwe:OnEnable()
		ShockAndAwe:RedrawFrames()
		ShockAndAwe.db.char.movingframes = true -- forces false in ShowHideBars to re-enable frames
		ShockAndAwe:ShowHideBars()
		ShockAndAwe:Print(L["config_disabled_off"])
	end
end

function ShockAndAwe:ResetImmunity()
	ShockAndAwe.db.char.immuneTargets = {}
	ShockAndAwe:Print(L["config_resetImmunity"])
end

function ShockAndAwe:GetMainHandImbue(info)
	return ShockAndAwe.db.char.binding.mhspell 
end

function ShockAndAwe:SetMainHandImbue(info, value)
	ShockAndAwe.db.char.binding.mhspell = value
	ShockAndAwe:UpdateBindings()
end

function ShockAndAwe:GetOffHandImbue(info)
	return ShockAndAwe.db.char.binding.ohspell 
end

function ShockAndAwe:SetOffHandImbue(info, value)
	ShockAndAwe.db.char.binding.ohspell = value
	ShockAndAwe:UpdateBindings()
end

function ShockAndAwe:GetMSBTareas(info)
	return ShockAndAwe.db.char.MSBToutputarea
end

function ShockAndAwe:SetMSBTareas(info, value)
	ShockAndAwe.db.char.MSBToutputarea = value
end

function ShockAndAwe:getWarningColour(info)
	local colours = ShockAndAwe.db.char.warning.colour
	return colours.r, colours.g, colours.b, colours.a
end

function ShockAndAwe:setWarningColour(info,r,g,b,a)
	ShockAndAwe.db.char.warning.colour.r = r
	ShockAndAwe.db.char.warning.colour.g = g
	ShockAndAwe.db.char.warning.colour.b = b
	ShockAndAwe.db.char.warning.colour.a = a
end

function ShockAndAwe:GetWarningDuration(info)
	return ShockAndAwe.db.char.warning.duration 
end

function ShockAndAwe:SetWarningDuration(info, priorityValue)
	ShockAndAwe.db.char.warning.duration = priorityValue
end

function ShockAndAwe:OpenConfig()
	if InterfaceOptionsFrame_OpenToCategory then
		InterfaceOptionsFrame_OpenToCategory("ShockAndAwe");
	else
		InterfaceOptionsFrame_OpenToFrame("ShockAndAwe");
	end
end

function ShockAndAwe:GetMSBTAreaDefaults()
    local i = 0;
	ShockAndAwe.MSBT = {}
	ShockAndAwe.MSBT.areas = {}
    if MikSBT ~= nil and MikSBT.IterateScrollAreas ~= nil then
        for scrollAreaKey, scrollAreaName in MikSBT.IterateScrollAreas() do
            i = i + 1
            ShockAndAwe.MSBT.areas[i] = scrollAreaName
        end
    end
end