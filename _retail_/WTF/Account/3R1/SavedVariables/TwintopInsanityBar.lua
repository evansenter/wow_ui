
TwintopInsanityBarSettings = {
	["auspiciousSpiritsTracker"] = true,
	["mindbender"] = {
		["enabled"] = true,
		["useNotification"] = {
			["enabled"] = false,
			["thresholdStacks"] = 26,
			["useVoidformStacks"] = false,
		},
		["timeMax"] = 3,
		["mode"] = "gcd",
		["swingsMax"] = 4,
		["gcdsMax"] = 2,
	},
	["displayText"] = {
		["fontSizeMiddle"] = 18,
		["fontSizeLock"] = true,
		["fontSizeRight"] = 18,
		["right"] = {
			["castingInsanity"] = true,
			["fontFace"] = "Interface\\Addons\\Skada\\media\\fonts\\ABF.ttf",
			["fontFaceName"] = "ABF",
			["passiveInsanity"] = true,
			["fontSize"] = 14,
			["inVoidformText"] = "{$casting}[$casting + ]{$passive}[$passive + ]$insanity%",
			["currentInsanity"] = true,
			["outVoidformText"] = "{$casting}[$casting + ]{$passive}[$passive + ]$insanity%",
		},
		["left"] = {
			["fontFaceName"] = "ABF",
			["voidformIncomingStacks"] = true,
			["inVoidformText"] = "$haste% - $vfStacks (+$vfIncoming) VF",
			["outVoidformText"] = "$haste%",
			["voidformStacks"] = true,
			["showHaste"] = true,
			["fontSize"] = 14,
			["fontFace"] = "Interface\\Addons\\Skada\\media\\fonts\\ABF.ttf",
			["lingeringInsanityStacks"] = false,
		},
		["fontSizeLeft"] = 18,
		["fontSize"] = 18,
		["fontFace"] = "Fonts\\FRIZQT__.TTF",
		["middle"] = {
			["fontSize"] = 14,
			["inVoidformText"] = "$vfTime sec - $vfDrain/sec ",
			["outVoidformText"] = "{$liStacks}[$liStacks LI - $liTime sec]",
			["lingeringInsanityStacks"] = true,
			["lingeringInsanityTime"] = true,
			["fontFace"] = "Interface\\Addons\\Skada\\media\\fonts\\ABF.ttf",
			["fontFaceName"] = "ABF",
			["voidformTime"] = true,
			["voidformDrain"] = true,
		},
		["fontFaceLock"] = true,
	},
	["ttd"] = {
		["numEntries"] = 50,
		["sampleRate"] = 0.2,
		["refreshRate"] = 0.2,
		["maxEntries"] = 15,
	},
	["hasteThreshold"] = 140,
	["textures"] = {
		["passiveBarName"] = "BantoBar",
		["castingBar"] = "Interface\\Addons\\SharedMedia\\statusbar\\BantoBar",
		["borderName"] = "None",
		["border"] = "",
		["insanityBar"] = "Interface\\Addons\\SharedMedia\\statusbar\\BantoBar",
		["castingBarName"] = "BantoBar",
		["textureLock"] = true,
		["insanityBarName"] = "BantoBar",
		["passiveBar"] = "Interface\\Addons\\SharedMedia\\statusbar\\BantoBar",
		["background"] = "Interface\\Buttons\\WHITE8X8",
		["backgroundName"] = "Solid",
		["bar"] = "Interface\\TargetingFrame\\UI-StatusBar",
	},
	["audio"] = {
		["s2mDeath"] = {
			["enabled"] = true,
			["sound"] = "Interface\\Addons\\TwintopInsanityBar\\wilhelm.ogg",
			["soundName"] = "Wilhelm Scream (TIB)",
		},
		["mindbender"] = {
			["sound"] = "Interface\\Addons\\TwintopInsanityBar\\BoxingArenaSound.ogg",
			["soundName"] = "Boxing Arena Gong (TIB)",
		},
	},
	["voidEruptionThreshold"] = true,
	["dataRefreshRate"] = 5,
	["displayBar"] = {
		["alwaysShow"] = false,
		["notZeroShow"] = true,
	},
	["thresholdWidth"] = 1,
	["showS2MSummary"] = true,
	["version"] = 1,
	["colors"] = {
		["threshold"] = {
			["mindbender"] = "FFFF11FF",
			["over"] = "7f00ff00",
			["under"] = "40ffffff",
		},
		["text"] = {
			["passiveInsanity"] = "FFDF00FF",
			["hasteBelow"] = "FFFFFFFF",
			["right"] = "FFFFFFFF",
			["left"] = "FFFFFFFF",
			["hasteAbove"] = "FF00FF00",
			["castingInsanity"] = "FFFFFFFF",
			["hasteApproaching"] = "FFFFFF00",
			["currentInsanity"] = "FFC2A3E0",
			["middle"] = "FFFFFFFF",
		},
		["bar"] = {
			["flashPeriod"] = 0.5,
			["inVoidform2GCD"] = "FFFFFF00",
			["enterVoidform"] = "FF5C2F89",
			["border"] = "00431863",
			["inVoidform1GCD"] = "FFFF0000",
			["inVoidform"] = "FF431863",
			["flashEnabled"] = true,
			["background"] = "66000000",
			["flashAlpha"] = 0.7,
			["casting"] = "FFFFFFFF",
			["base"] = "FF763BAF",
			["passive"] = "FFDF00FF",
		},
	},
	["hasteApproachingThreshold"] = 135,
	["hastePrecision"] = 2,
	["summary"] = {
		["show"] = false,
		["simple"] = false,
	},
	["showSummary"] = false,
	["bar"] = {
		["xPos"] = 0,
		["dragAndDrop"] = false,
		["height"] = 28,
		["yPos"] = -225,
		["border"] = 0,
		["width"] = 441,
	},
}