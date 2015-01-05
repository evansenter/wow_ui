
	--[[

		TODO:
			(- Font outline color; not possible?)
			- Test Charge logic
			- Different charge styles
			- Visibility option for when not active
			- Customizable mendingUpdateInterval
			- Localization system
			- Localizations: EN, DE, FR (RU, KR, TW, ES, IT)
			- Class based name and bar/charge coloring
			
	]]

	Mending = LibStub("AceAddon-3.0"):NewAddon("Reckoner's ProMending", "AceConsole-3.0", "AceEvent-3.0")
	MendingGUI = LibStub("AceGUI-3.0")
	local MendingMedia = LibStub("LibSharedMedia-3.0")
	local MendingCandy = LibStub("LibCandyBar-3.0")
	local db

	local defaults = {
		profile = {
			x = 0,
			y = 0,
			scale = 1.0,
			alpha = 1.0,
			dienabled = true,
			barwidth = 200,
			barheight = 19,
			baricon = true,
			barfill = false,
			bartexture = "Blizzard",
			barcolorfg = {1, 0.81, 0.25, 1},
			barcolorbg = {0.4, 0.3, 0.05, 1},
			chargesenabled = true,
			chargeheight = 8,
			chargelogic = "HEALS_LEFT",
			chargestyle = "BARS",
			chargetexture = "Blizzard",
			chargecolorfg = {1, 0.81, 0.25, 1},
			chargecolorbg = {0.4, 0.3, 0.05, 1},
			bgenabled = true,
			bgcolor = {0, 0, 0, 0.5},
			bgpadding = 2,
			font = "Friz Quadrata TT",
			fontsize = 12,
			fontcolor = {1, 1, 1, 1},
			outline = "NOOUTLINE",
			nameenabled = true,
			alignment = "LEFT",
			timeenabled = true,
		},
	}

	local options = {
	type = "group",
	childGroups = "tab",
		args = {
			parent = {
				type = "group",
				args = {
					info = {
						order = 1,
						name = "Reckoner's ProMending is a Priest addon that gives you a timer bar showing you which unit currently has your Prayer of Mending with how many charges and time left.\n\nThe addon was written by Reckoner on Blackrock-EU also known as Alasea on Aegwynn-EU.\n",
						type = 'description'
					},
					run= {
						order = 2,
						name = "Run",
						desc = "Runs the bar for testing purposes.",
						type = 'execute',
						func = function()
							Mending:RefreshConfig()
						end,
					}
				}
			},
			general = {
				type = "group",
				args = {
						generalheader = {
							order = 1,
							type = "group",
							name = "General",
							inline = true,
							args = {
								xpos = {
									order = 4,
									name = "X",
									desc = "Set the horizontal position.",
									type = 'range',
									min = -3000,
									max = 3000,
									softMin = -1000,
									softMax = 1000,
									step = 1,
									bigStep = 10,
									get = function(info) return db.x end,
									set = function(info, x) 
										db.x = x
										Mending:RefreshConfig()
									end,
								},
								ypos = {
									order = 9,
									name = "Y",
									desc = "Set the vertical position.",
									type = 'range',
									min = -3000,
									max = 3000,
									softMin = -1000,
									softMax = 1000,
									step = 1,
									bigStep = 10,
									get = function(info) return db.y end,
									set = function(info, y) 
										db.y = y
										Mending:RefreshConfig()
									end,
								},
								scale = {
									order = 13,
									name = "Scale",
									desc = "Set the scale.",
									type = 'range',
									min = 0.01,
									max = 100,
									softMin = 0.5,
									softMax = 2,
									get = function(info) return db.scale end,
									set = function(info, scale) 
										db.scale = scale
										Mending:RefreshConfig()
									end,
								},
								alpha = {
									order = 14,
									name = "Alpha",
									desc = "Set the overall alpha of the addon. Alpha values of the individual components can be set with the color pickers.",
									type = "range",
									min = 0,
									max = 1,
									get = function(info) return db.alpha end,
									set = function(info, alpha) 
										db.alpha = alpha
										Mending:RefreshConfig()
									end,					
								},
								dienabled = {
									order = 15,
									name = "Divine Insight enabled",
									desc = "Track casts under the effect of Divine Insight.",
									type = 'toggle',
									get = function(info) return db.dienabled end,
									set = function(info, dienabled) 
										db.dienabled = dienabled
										Mending:RefreshConfig()
									end,
								},
							},
						},
						barheader = {
							order = 20,
							type = "group",
							name = "Timer Bar",
							inline = true,
							args = {
								barwidth = {
									order = 30,
									name = "Width",
									desc = "Set the width of the timer bar.",
									type = 'range',
									min = 10,
									max = 600,
									step = 1,
									get = function(info) return db.barwidth end,
									set = function(info, barwidth) 
										db.barwidth = barwidth
										Mending:RefreshConfig()
									end,
								},
								barheight = {
									order = 40,
									name = "Height",
									desc = "Set the height of the timer bar.",
									type = 'range',
									min = 1,
									max = 60,
									step = 1,
									get = function(info) return db.barheight end,
									set = function(info, barheight) 
										db.barheight = barheight
										Mending:RefreshConfig()
									end,
								},
								baricon = {
									order = 45,
									width = "half",
									name = "Icon",
									desc = "Show the Prayer of Mending icon.",
									type = 'toggle',
									get = function(info) return db.baricon end,
									set = function(info, baricon) 
										db.baricon = baricon
										Mending:RefreshConfig()
									end,
								},
								bartexture = {
									order = 51,
									type = "select",
									name = "Bar texture",
									desc = "Set the timer bar texture.",
									values = MendingMedia:HashTable("statusbar"),
									dialogControl = "LSM30_Statusbar",
									get = function(info) return db.bartexture end,
									set = function(info, bartexture) 
									db.bartexture = bartexture
									Mending:RefreshConfig()
									end,
								},
								barcolorfg = {
									order = 52,
									name = "Foreground color",
									desc = "Set the foreground color of the timer bar.",
									type = "color",
									hasAlpha = true,
									get = function(info) return db.barcolorfg[1], db.barcolorfg[2], db.barcolorfg[3], db.barcolorfg[4] end,
									set = function (info, r, g, b, a)
										db.barcolorfg = {r, g, b, a}
										Mending:RefreshConfig()
									end,
								},
								barcolorbg = {
									order = 53,
									name = "Background color",
									desc = "Set the background color of the timer bar.",
									type = "color",
									hasAlpha = true,
									get = function(info) return db.barcolorbg[1], db.barcolorbg[2], db.barcolorbg[3], db.barcolorfg[4] end,
									set = function (info, r, g, b, a)
										db.barcolorbg = {r, g, b, a}
										Mending:RefreshConfig()
									end,
								},
								barfill = {
									order = 46,
									width = "half",
									name = "Enable fill",
									desc = "Disable to make the timer bar drain instead of fill.",
									type = 'toggle',
									get = function(info) return db.barfill end,
									set = function(info, barfill) 
										db.barfill = barfill
										Mending:RefreshConfig()
									end,
								},
							},
						},
						chargeheader = {
							order = 53,
							type = "group",
							name = "Charges",
							inline = true,
							args = {
								chargesenabled = {
									order = 54,
									type = "toggle",
									name = "Enable Charges",
									desc = "Show the number of charges above the timer bar.",
									get = function(info) return db.chargesenabled end,
									set = function(info, chargesenabled) 
										db.chargesenabled = chargesenabled
										Mending:RefreshConfig()
									end,
								},
								chargelogic = {
									order = 57,
									name = "Charge logic",
									desc = "Choose which logic is used to display the charges. Prayer of Mending heals one more time than it jumps (up to 6 heals and 5 jumps total if unglyphed).",
									type = "select",
									values = {["HEALS_LEFT"]="Heals left", ["JUMPS_LEFT"]="Jumps left", ["HEALS_USED"]="Heals used", ["JUMPS_USED"]="Jumps used"},
									get = function(info) return db.chargelogic end,
									set = function(info, chargelogic)
										db.chargelogic = chargelogic
										Mending:RefreshConfig()
									end,
								},
								chargestyle = {
									order = 58,
									name = "Charge style",
									desc = "Set the style of the charge graphics.",
									type = "select",
									values = {["BARS"]="Bars", ["SPARKS"]="Sparks"},
									get = function(info) return db.chargestyle end,
									set = function(info, chargestyle)
										db.chargestyle = chargestyle
										Mending:RefreshConfig()
									end,
									disabled = true,
									hidden = true,
								},
								chargeheight = {
									order = 56,
									name = "Height",
									desc = "Set the height of the charges.",
									type = 'range',
									min = 1,
									max = 60,
									step = 1,
									get = function(info) return db.chargeheight end,
									set = function(info, chargeheight) 
										db.chargeheight = chargeheight
										Mending:RefreshConfig()
									end,
								},
								chargetexture = {
									order = 60,
									type = "select",
									name = "Charge texture",
									desc = "Set the charge texture.",
									values = MendingMedia:HashTable("statusbar"),
									dialogControl = "LSM30_Statusbar",
									get = function(info) return db.chargetexture end,
									set = function(info, chargetexture) 
									db.chargetexture = chargetexture
									Mending:RefreshConfig()
									end,
								},
								chargecolorfg = {
									order = 61,
									name = "Foreground color",
									desc = "Set the color of the charges.",
									type = "color",
									hasAlpha = true,
									get = function(info) return db.chargecolorfg[1], db.chargecolorfg[2], db.chargecolorfg[3], db.chargecolorfg[4] end,
									set = function (info, r, g, b, a)
										db.chargecolorfg = {r, g, b, a}
										Mending:RefreshConfig()
									end,
								},
								chargecolorbg = {
									order = 62,
									name = "Background color",
									desc = "Set the background color of the charges.",
									type = "color",
									hasAlpha = true,
									get = function(info) return db.chargecolorbg[1], db.chargecolorbg[2], db.chargecolorbg[3], db.chargecolorbg[4] end,
									set = function (info, r, g, b, a)
										db.chargecolorbg = {r, g, b, a}
										Mending:RefreshConfig()
									end,
								},
							},
						},
						bgheader = {
							order = 70,
							type = "group",
							name = "Background",
							inline = true,
							args = {
								bgenabled = {
									order = 71,
									type = "toggle",
									name = "Enable background",
									desc = "Shows a background behind the timer and charges.",
									get = function(info) return db.bgenabled end,
									set = function(info, bgenabled) 
										db.bgenabled = bgenabled
										Mending:RefreshConfig()
									end,
								},
								bgcolor = {
									order = 72,
									name = "Background color",
									desc = "Set the color of the background frame.",
									type = "color",
									hasAlpha = true,
									get = function(info) return db.bgcolor[1], db.bgcolor[2], db.bgcolor[3], db.bgcolor[4] end,
									set = function (info, r, g, b, a)
										db.bgcolor = {r, g, b, a}
										Mending:RefreshConfig()
									end,
								},
								bgpadding = {
									order = 73,
									name = "Padding",
									desc = "Set the size of the padding.",
									type = 'range',
									min = 0,
									max = 100,
									softMin = -0,
									softMax = 10,
									get = function(info) return db.bgpadding end,
									set = function(info, bgpadding) 
										db.bgpadding = bgpadding
										Mending:RefreshConfig()
									end,
								},
							},
						},
						textheader = {
							order = 80,
							type = "group",
							name = "Text",
							inline = true,
							args = {
								font = {
									order = 100,
									type = "select",
									name = "Font",
									desc = "Set the font type for the name and time.",
									values = MendingMedia:HashTable("font"),
									dialogControl = "LSM30_Font",
									get = function(info) return db.font end,
									set = function(info, f) 
									db.font = f
									Mending:RefreshConfig()
									end,
								},
								fontsize = {
									order = 105,
									name = "Font size",
									desc = "Set the font size for the name and time.",
									type = 'range',
									min = 1,
									max = 50,
									step = 1,
									get = function(info) return db.fontsize end,
									set = function(info, fontsize) 
									db.fontsize = fontsize
									Mending:RefreshConfig()
									end,
								},
								fontcolor = {
									order = 110,
									name = "Font color",
									desc = "Set the color of the text frame.",
									type = "color",
									hasAlpha = true,
									get = function(info) return db.fontcolor[1], db.fontcolor[2], db.fontcolor[3], db.fontcolor[4] end,
									set = function (info, r, g, b, a)
										db.fontcolor = {r, g, b, a}
										Mending:RefreshConfig()
									end,
								},				
								outline = {
									order = 115,
									name = "Outline",
									desc = "Outline around the text.",
									type = 'select',
									values = {["NOOUTLINE"]="No outline", ["OUTLINE"]="Outline", ["THICKOUTLINE"]="Thick outline"},
									get = function(info) return db.outline end,
									set = function(info, outline)
									db.outline = outline
									Mending:RefreshConfig()
									end,
								},
								nameenabled = {
									order = 85,
									type = "toggle",
									name = "Show name",
									desc = "Show the name of the current unit with Prayer of Mending.",
									get = function(info) return db.nameenabled end,
									set = function(info, nameenabled) 
										db.nameenabled = nameenabled
										Mending:RefreshConfig()
									end,
								},
								alignment = {
									order = 90,
									name = "Name alignment",
									desc = "Alignment of the name on the timer bar.",
									type = 'select',
									values = {["LEFT"]="Left", ["CENTER"]="Center", ["Right"]="Right"},
									get = function(info) return db.alignment end,
									set = function(info, alignment)
									db.alignment = alignment
									Mending:RefreshConfig()
									end,
								},
								timeenabled = {
									order = 95,
									type = "toggle",
									name = "Show time",
									desc = "Show the time left on the timer bar.",
									get = function(info) return db.timeenabled end,
									set = function(info, timeenabled) 
										db.timeenabled = timeenabled
										Mending:RefreshConfig()
									end,
								},
							},
						},
				}
			
			}		
		},
	}

	function Mending:OnInitialize()
		local locClass, enClass = UnitClass("player")
		if(enClass ~= "PRIEST") then
			Mending:Disable() --Funktioniert nicht?
		end
		
		self.db = LibStub("AceDB-3.0"):New("ReckonersProMendingDB", defaults, true)
		options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
		db = self.db.profile
		LibStub("AceConfig-3.0"):RegisterOptionsTable("Reckoner's ProMending", options, {"rprom", "rpromending", "reckonerspromending", "prom", "promending", "mending"})
		
		LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Reckoner's ProMending", options.args.parent)	
		self.optionsParent = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Reckoner's ProMending", "Reckoner's ProMending") --, nil, "bar"
		LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Settings", options.args.general)
		self.optionsGeneral = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Settings", "Settings", "Reckoner's ProMending")
		LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Profiles", options.args.profiles)
		self.optionsProfile = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Profiles", "Profiles", "Reckoner's ProMending")
		
		
		self:RegisterChatCommand("rprom", "ChatCommand")
		self:RegisterChatCommand("rpromending", "ChatCommand")
		self:RegisterChatCommand("reckonerspromending", "ChatCommand")
		self:RegisterChatCommand("prom", "ChatCommand")
		self:RegisterChatCommand("promending", "ChatCommand")
		self:RegisterChatCommand("mending", "ChatCommand")
		self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
		self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
		self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
		
		
		--[[
		self.db = LibStub("AceDB-3.0"):New("Reckoner's ProMending", self.defaults, "Default");
		self.profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
		LibStub("AceConfig-3.0"):RegisterOptionsTable("MyApp Profiles", self.profileOptions);
		
		self.settingsParent = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RProM", "Reckoner's ProMending", nil);
		self.settingsGeneral = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RProM Bar Settings", "General", "Reckoner's ProMending");
		self.settingsProfile = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RProM Profiles", "Profiles", "Reckoner's ProMending");
		]]
		
		
		mendingUpdateInterval = 0.7
		mendingTimeElapsed = 0
		playerName = UnitName("player")
		mendingInfo = {GetSpellInfo(33076)}
		mendingMaxCharges = self:GetMaxCharges()
		mendingCurrentHost = nil
		mendingCurrentCharges = mendingMaxCharges
		
		local function barstopped(callback, bar)
			if MendingBar and MendingBar == bar then
				MendingBar = nil
				MendingWrapper:SetScript("OnUpdate", nil)
				mendingTimeElapsed = 0
				MendingWrapper:Hide()
			end
		end
		MendingCandy.RegisterCallback(self, "LibCandyBar_Stop", barstopped)
	end

	function Mending:OnEnable()
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:RegisterEvent("GLYPH_ADDED")
		self:RegisterEvent("GLYPH_UPDATED")
		
		if not MendingMedia:Fetch("statusbar", db.bartexture, true) then db.bartexture = "Blizzard" end
		if not MendingMedia:Fetch("font", db.font, true) then db.font = "Friz Quadrata TT" end
		
		if not MendingWrapper then
			MendingWrapper = CreateFrame("Frame", "MendingWrapper", UIParent)
			MendingWrapper:SetFrameStrata("BACKGROUND")
			MendingWrapper:SetPoint("TOPLEFT", MendingWrapper:GetParent(), "CENTER", 0, 0)
			MendingWrapper:SetSize(1, 1)
		end
		if not MendingScale then
			MendingScale = CreateFrame("Frame", "MendingScale", MendingWrapper)
			MendingScale:SetPoint("TOPLEFT", MendingScale:GetParent(), "TOPLEFT", 0, 0)
			MendingScale:SetSize(1, 1)
		end
	end
		
	function Mending:RefreshConfig()
		db = self.db.profile
		self:RunBar(3, playerName)
	end

	function Mending:CreateBackground()	
		if db.bgenabled then
			if not MendingFrame then
				MendingFrame = CreateFrame("Frame", "MendingFrame", MendingScale)
				MendingFrame:SetFrameLevel(1)
			end
			if not MendingFrameBackground then
				MendingFrameBackground = MendingFrame:CreateTexture("MendingFrameBackground")
			end
		end

		if db.chargesenabled then
			if not MendingCharge then
				MendingCharge = {}
				for i = 1, 6 do
					MendingCharge[i] = CreateFrame("Frame", "Charge", MendingScale)
					MendingCharge[i]:SetFrameLevel(3)
				end
			end
			if not MendingChargeBackground then
				MendingChargeBackground = {}
				for i = 1, 6 do
					MendingChargeBackground[i] = MendingCharge[i]:CreateTexture("MendingChargeBackground")
				end
			end
			if not MendingChargeBG then
				MendingChargeBG = {}
				for i = 1, 6 do
					MendingChargeBG[i] = CreateFrame("Frame", "ChargeBG", MendingScale)
					MendingChargeBG[i]:SetFrameLevel(2)
				end
			end
			if not MendingChargeBGBackground then
				MendingChargeBGBackground = {}
				for i = 1, 6 do
					MendingChargeBGBackground[i] = MendingChargeBG[i]:CreateTexture("MendingChargeBGBackground")
				end
			end
			if db.chargestyle == "SPARKS" and db.bgenabled then
				for i = 1, 6 do
					--SparksBackground
				end
			end
		end
	end

	function Mending:SetBackground(newCharges)
		mendingCurrentCharges = newCharges
		
		mendingChargeSubtraction = {["HEALS_LEFT"] = 0, ["HEALS_USED"] = 0, ["JUMPS_LEFT"] = 1, ["JUMPS_USED"] = 1}
		mendingChargeSubtraction = mendingChargeSubtraction[db.chargelogic]
		mendingChargesFill = {["HEALS_LEFT"] = false, ["HEALS_USED"] = true, ["JUMPS_LEFT"] = false, ["JUMPS_USED"] = true}
		mendingChargesFill = mendingChargesFill[db.chargelogic]
		
		MendingWrapper:SetPoint("TOPLEFT", MendingWrapper:GetParent(), "CENTER", db.x, db.y)
		MendingScale:SetScale(db.scale)
		
		if db.bgenabled then
			MendingFrameBackground:SetTexture(db.bgcolor[1], db.bgcolor[2], db.bgcolor[3], db.bgcolor[4])
			MendingFrame:SetWidth(db.barwidth+2*db.bgpadding)
			MendingFrame:SetHeight(db.barheight+2*db.bgpadding)
			MendingFrame:SetPoint("TOPLEFT", MendingFrame:GetParent(), "TOPLEFT", -db.bgpadding, db.bgpadding)
			
			if db.chargesenabled then
				if db.chargestyle == "SPARKS" then
					--SparksBackground
				elseif db.chargestyle == "BARS" then
					MendingFrame:SetHeight(db.barheight+db.chargeheight+3*db.bgpadding)
					MendingFrame:SetPoint("TOPLEFT", MendingFrame:GetParent(), "TOPLEFT", -db.bgpadding, 2*db.bgpadding+db.chargeheight)
				end
			end
			
			MendingFrameBackground:SetAllPoints()
		end

		MendingWrapper:Show()
		if db.chargesenabled then
			for i = 1, 6 do
				if MendingCharge[i] then MendingCharge[i]:Show() end
				if MendingChargeBG[i] then MendingChargeBG[i]:Show() end
				if db.chargestyle == "SPARKS" then
					MendingChargeBackground[i]:SetTexture("Interface\\AddOns\\ReckonersProMending\\Textures\\Spark2.tga")
					MendingCharge[i]:SetHeight(35)
					MendingCharge[i]:SetWidth(35)
					MendingCharge[i]:SetPoint("TOPLEFT", MendingCharge[i]:GetParent(), "TOPLEFT", (i-1)*db.barwidth/(mendingMaxCharges-mendingChargeSubtraction), 25)
					MendingChargeBackground[i]:SetAllPoints()
				elseif db.chargestyle == "BARS" then
					MendingChargeBGBackground[i]:SetTexture(MendingMedia:Fetch("statusbar", db.chargetexture))
					MendingChargeBGBackground[i]:SetVertexColor(db.chargecolorbg[1], db.chargecolorbg[2], db.chargecolorbg[3], db.chargecolorbg[4])
					MendingChargeBG[i]:SetHeight(db.chargeheight)
					MendingChargeBG[i]:SetWidth((db.barwidth+db.bgpadding)/(mendingMaxCharges-mendingChargeSubtraction)-db.bgpadding)
					MendingChargeBG[i]:SetPoint("TOPLEFT", MendingChargeBG[i]:GetParent(), "TOPLEFT", (i-1)*(db.barwidth+db.bgpadding)/(mendingMaxCharges-mendingChargeSubtraction), db.chargeheight+db.bgpadding)
					MendingChargeBGBackground[i]:SetAllPoints()
					MendingChargeBackground[i]:SetTexture(MendingMedia:Fetch("statusbar", db.chargetexture))
					MendingChargeBackground[i]:SetVertexColor(db.chargecolorfg[1], db.chargecolorfg[2], db.chargecolorfg[3], db.chargecolorfg[4])
					MendingCharge[i]:SetHeight(db.chargeheight)
					MendingCharge[i]:SetWidth((db.barwidth+db.bgpadding)/(mendingMaxCharges-mendingChargeSubtraction)-db.bgpadding)
					MendingCharge[i]:SetPoint("TOPLEFT", MendingCharge[i]:GetParent(), "TOPLEFT", (i-1)*(db.barwidth+db.bgpadding)/(mendingMaxCharges-mendingChargeSubtraction), db.chargeheight+db.bgpadding)
					MendingChargeBackground[i]:SetAllPoints()
				end
				if mendingChargesFill then
					if mendingMaxCharges-mendingChargeSubtraction-i >= newCharges-mendingChargeSubtraction then
						MendingCharge[i]:Show()
					else
						MendingCharge[i]:Hide()
						if i > mendingMaxCharges-mendingChargeSubtraction then MendingChargeBG[i]:Hide() end
					end
				else
					if i <= newCharges-mendingChargeSubtraction then
						MendingCharge[i]:Show()
					else
						MendingCharge[i]:Hide()
						if i > mendingMaxCharges-mendingChargeSubtraction then MendingChargeBG[i]:Hide() end
					end				
				end
			end
		else
			for i = 1, 6 do
				if MendingCharge then MendingCharge[i]:Hide() end
				if MendingChargeBG then MendingChargeBG[i]:Hide() end
			end
		end
	end

	function Mending:RunBar(currentCharges, currentHost)
		self:StopBar() -- => MendingWrapper:Hide()
		self:CreateBackground()
		self:SetBackground(currentCharges)
		if not MendingBar then
			MendingBar = MendingCandy:New(MendingMedia:Fetch("statusbar", db.bartexture), db.barwidth, db.barheight)
			MendingBar:SetParent(MendingScale)
			MendingBar:SetFrameLevel(3)
			MendingBar:SetFill(db.barfill)
		end
		self:SetBar(currentHost)
		MendingBar:SetDuration(30)
		MendingBar:Start()
	end

	function Mending:SetBar(currentHost)
		MendingBar:SetTexture(MendingMedia:Fetch("statusbar", db.bartexture))
		MendingBar:SetColor(db.barcolorfg[1], db.barcolorfg[2], db.barcolorfg[3], db.barcolorfg[4])
		MendingBar.candyBarBackground:SetVertexColor(db.barcolorbg[1], db.barcolorbg[2], db.barcolorbg[3], db.barcolorbg[4])
		MendingBar:SetSize(db.barwidth, db.barheight)
		MendingBar:SetPoint("TOPLEFT", MendingScale, "TOPLEFT", 0, 0)
		MendingBar.candyBarLabel:SetFont(MendingMedia:Fetch("font", db.font), db.fontsize, db.outline~="NOOUTLINE" and db.outline or nil)
		MendingBar.candyBarLabel:SetTextColor(db.fontcolor[1], db.fontcolor[2], db.fontcolor[3], db.fontcolor[4])
		MendingBar.candyBarLabel:SetJustifyH(db.alignment)
		MendingBar:SetTimeVisibility(db.timeenabled)
		MendingBar.candyBarDuration:SetFont(MendingMedia:Fetch("font", db.font), db.fontsize, db.outline~="NOOUTLINE" and db.outline or nil)
		MendingBar.candyBarDuration:SetTextColor(db.fontcolor[1], db.fontcolor[2], db.fontcolor[3], db.fontcolor[4])
		if db.nameenabled then MendingBar:SetLabel(currentHost)
		else MendingBar:SetLabel("") end
		if db.baricon == true then MendingBar:SetIcon(mendingInfo[3] or nil)
		else MendingBar:SetIcon(nil) end
	end

	function Mending:StopBar()
		if MendingBar then
			MendingBar:Stop()
		end
	end

	function Mending:TrimName(unitname)
		if string.find(unitname, "-") == nil then
			return unitname
		else
			return strsplit("-", unitname)
		end
	end

	function Mending:GetMaxCharges()
		for i = 1, NUM_GLYPH_SLOTS/2 do
			local enabled, glyphType, glyphTooltipIndex, glyphSpellId, icon = GetGlyphSocketInfo(2*i);
			if glyphSpellId == 55685 then
				return 5
			end
		end
		return 6
	end

	function Mending:GLYPH_ADDED()
		mendingMaxCharges = self:GetMaxCharges()
	end

	function Mending:GLYPH_UPDATED()
		mendingMaxCharges = self:GetMaxCharges()
	end

	function Mending:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overhealing, absorbed, critical)
		
		--Spell					Spell ID	Events
		--ProM cast				33076		SPELL_CAST_SUCCESS
		--ProM buff				41635		SPELL_AURA_APPLIED, SPELL_AURA_REFRESH, SPELL_AURA_REMOVED
		--ProM heal				33110		SPELL_HEAL
		--DI buff				123267		SPELL_AURA_APPLIED, SPELL_AURA_REFRESH, SPELL_AURA_REMOVED
		--ProM (/w DI) cast		123259		SPELL_CAST_SUCCESS
		--ProM (/w DI) buff		123262		SPELL_AURA_APPLIED, SPELL_AURA_REFRESH, SPELL_AURA_REMOVED
		--ProM (/w DI) heal		33110		SPELL_HEAL
		--The heal will always occur after the removal of the buff.
		--The heal will sometimes occur after the (re)application of the buff.
		--The cast will sometimes occur after the application of the buff.
		--SourceName is always the name of the casting Priest.
		--Glyphed ProM's have the same Spell ID's as unglyphed ones.
		
		--[[
		if event == "SPELL_HEAL" and spellId == 33110 and sourceName == playerName then
			self:Print((amount-overhealing)..", "..overhealing)
		end
		]]
		
		if (event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" or event == "SPELL_CAST_SUCCESS" or event == "SPELL_AURA_APPLIED_DOSE")
		and (spellId == 33076 or spellId == 41635 or (not db.dienabled and (spellId == 123259 or spellId == 123262)))
		and sourceName == playerName then
			if destName then
				buffInfo = {UnitBuff(destName, mendingInfo[1], nil, "PLAYER")}
				
				if buffInfo[8] == "player" then
					mendingCurrentHost = destName
					buffInfo[4] = buffInfo[4]+1
					if event == "SPELL_CAST_SUCCESS" then buffInfo[4] = mendingMaxCharges end
					self:RunBar(buffInfo[4], self:TrimName(destName))
				end
			end
		end
		
		if event == "SPELL_AURA_REMOVED" and spellName == mendingInfo[1] and sourceName == playerName then
			if mendingCurrentHost == destName then
				mendingCurrentHost = nil
				if mendingCurrentCharges == 1 then
					self:StopBar()
				else
					MendingWrapper:SetScript("OnUpdate", OnUpdate)
				end
			end
		end
	end

	function OnUpdate(frame, elapsed)
		mendingTimeElapsed = mendingTimeElapsed + elapsed;
		if mendingTimeElapsed > mendingUpdateInterval then
			Mending:StopBar()
		end
	end

	function Mending:ChatCommand(input)
		if not input or input:trim() == "" then
			InterfaceOptionsFrame_OpenToCategory(self.optionsParent)
		else
			LibStub("AceConfigCmd-3.0").HandleCommand("promending", "Reckoner's ProMending", input)
		end
	end


