_G["LWB"] = _G["LWB"] or {}

local LWB = _G["LWB"]
local L = LibStub("AceLocale-3.0"):GetLocale("LWB")

_G["LWB"].dbDefaults = {
	profile = {
		enabled = true,
		messagingEnabled = true,
		lightspringSupport = false,
		alert = true,
		talkToStrangers = true,
		talkOutOfCombat = false,
		msgOnLastUse = true,
		blackList = {[1] = L["Un-blacklist player"] ,
		},
		summonChannel = "SMART",
		summonRate = 1,
		summonCD = 0,
		summonPhrases = {},
		useChannel = "SMART",
		useRate = 1,
		useCD = 0,
		usePhrases = {},
		wasteCutOff = 1,
		wasteChannel = "SMART",
		wasteRate = 1,
		wasteCD = 0,
		wastePhrases = {},
		emptyChannel = "SMART",
		emptyRate = 1,
		emptyCD = 0,
		emptyPhrases = {},
		expireChannel = "SMART",
		expireRate = 1,
		expireCD = 0,
		expirePhrases = {},
		disappearChannel = "SMART",
		disappearRate = 1,
		disappearCD = 0,
		disappearPhrases = {},
		multiconsumptionChannel = "WHISPER",
		multiconsumptionRate = 1,
		multiconsumptionCD = 0,
		multiconsumptionPhrases = {},
		idleChannel = "EMOTE",
		idleRate = 1,
		idleMaxTime = 60,
		idleCD = 0,
		idlePhrases = {},
		personalLists = {
			["name"] = {
				[L["Default"]] = L["Default"],
				},
			["persons"] = {
				[L["Default"]] = { },
				},
			["channel"] = {
				[L["Default"]] = "WHISPER",
				},
			["rate"] = {
				[L["Default"]] = 1,
				},
			["cd"] = {
				[L["Default"]] = 0,
				},
			["phrases"] = {
				[L["Default"]] = { "" },
				},
			
		},
		counterHideCombat = false,
		counterHideDown = false,
		counterLockPosition = false,
		counterEnable = true,
		counterBarR = 1,
		counterBarG = 1,
		counterBarB = 0,
		counterBeginPulsing = 10.5,
		counterBarTexture = "Blizzard",
		counterSkin = "Blizzard Dialog Background",
		counterFont = nil,
		counterBorder = "Blizzard Dialog",
		counterBorderSize = 32,
		counterSkinInset = 3,
	},
}

