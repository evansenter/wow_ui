local GlobalAddonName, ExRT = ...

local max = max
local ceil = ceil
local UnitCombatlogname = ExRT.F.UnitCombatlogname
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitGetTotalAbsorbs = UnitGetTotalAbsorbs
local UnitPower = UnitPower
local UnitGUID = UnitGUID
local UnitName = UnitName
local AntiSpam = ExRT.F.AntiSpam
local GetUnitInfoByUnitFlag = ExRT.F.GetUnitInfoByUnitFlag
local UnitInRaid = UnitInRaid
local UnitIsPlayerOrPet = ExRT.F.UnitIsPlayerOrPet
local GUIDtoID = ExRT.F.GUIDtoID
local GetUnitTypeByGUID = ExRT.F.GetUnitTypeByGUID
local pairs = pairs
local GetTime = GetTime
local UnitIsFriendlyByUnitFlag = ExRT.F.UnitIsFriendlyByUnitFlag
local wipe = wipe

local VExRT = nil

local module = ExRT.mod:New("BossWatcher",ExRT.L.BossWatcher)

module.db.data = {
	{
		guids = {},
		reaction = {},
		fight = {},
		pets = {},
		encounterName = nil,
		encounterStartGlobal = time(),
		encounterStart = GetTime(),
		encounterEnd = GetTime()+1,
		graphData = {},
		fightID = 0,
	},
}
module.db.nowData = {}
module.db.nowNum = 1
local fightData,guidData,graphData,reactionData = nil

module.db.lastFightID = 0
module.db.timeFix = nil

module.db.spellsSchool = {}
local spellsSchool = module.db.spellsSchool

local deathLog = {}
module.db.deathLog = deathLog

local raidGUIDs = {}

module.db.buffsFilters = {
[1] = {[-1]=ExRT.L.BossWatcherFilterOnlyBuffs,}, --> Only buffs
[2] = {[-1]=ExRT.L.BossWatcherFilterOnlyDebuffs,}, --> Only debuffs
[3] = {[-1]=ExRT.L.BossWatcherFilterBySpellID,}, --> By spellID
[4] = {[-1]=ExRT.L.BossWatcherFilterBySpellName,}, --> By spellName
[5] = {
	[-1]=ExRT.L.BossWatcherFilterTaunts,
	[-2]={62124,130793,17735,97827,56222,51399,49560,6795,355,115546,116189},
},
[6] = {
	[-1]=ExRT.L.BossWatcherFilterStun,
	[-2]={853,105593,91797,408,119381,89766,118345,46968,107570,5211,44572,119392,122057,113656,108200,108194,30283,118905,20549,119072,115750},
},
[7] = {
	[-1]=ExRT.L.BossWatcherFilterPersonal,
	[-2]={148467,31224,110788,55694,47585,31850,115610,122783,642,5277,118038,104773,115176,48707,1966,61336,120954,871,106922,30823,6229,22812,498},
},
[8] = {
	[-1]=ExRT.L.BossWatcherFilterRaidSaves,
	[-2]={145629,114192,114198,81782,108281,97463,31821,15286,115213,44203,64843,76577},
},
[9] = {
	[-1]=ExRT.L.BossWatcherFilterPotions,
	[-2]={105702,105697,105706,105701,105707,105698,125282,
		156426,156423,156428,156432,156430},
},
[10] = {
	[-1]=ExRT.L.BossWatcherFilterPandaria,
	[-2]={148010,146194,146198,146200,137593,137596,137590,137288,137323,137326,137247,137331},
},
[11] = {
	[-1]=ExRT.L.BossWatcherFilterTier16,
	[-2]={143524,143460,143459,143198,143434,143023,143840,143564,143959,146022,144452,144351,144358,146594,144359,144364,145215,144574,144683,144684,144636,146822,147029,147068,146899,
		144467,144459,146325,144330,144089,143494,143638,143480,143882,143589,143594,143593,143536,142990,143919,142913,143385,144236,143856,144466,145987,145747,143442,143411,143445,
		143791,146589,142534,142532,142533,142671,142948,143337,143701,143735,145213,147235,147209,144762,148994,148983,144817,145171,145065,147324},
},
[12] = {
	[-1]=ExRT.L.RaidLootT17Highmaul,
	[-2]={
		159178,159113,159947,158986,
		156151,156152,156160,
		162346,162475,
		163242,159280,163663,159253,159426,
		158241,159709,155569,167200,163372,163297,158200,157943,
		162184,162186,172813,161345,162185,161242,156803,160734,
		157763,156225,164004,164005,164006,164176,164178,
	},
},
[13] = {
	[-1]=ExRT.L.RaidLootT17BF,
	[-2]={
		-- Gruul: ???
		173471,155900,156834,
		155236,154960,155061,154981,
		154952,154932,
		-- Hans'gar and Franzok: ???
		159481,
		155196,155225,155192,174716,
		157059,161923,161839,
		156006,
		156653,156096,
	}
},
}
module.db.buffsFilterStatus = {}

module.db.raidIDs = {
	[543]=true, 	--wotlk
	[535]=true, 	--wotlk
	[529]=true, 	--wotlk
	[527]=true, 	--wotlk
	[532]=true, 	--wotlk
	[531]=true, 	--wotlk
	[604]=true, 	--wotlk
	[609]=true, 	--wotlk
	[718]=true,	--wotlk

	[752]=true,	--BH
	[754]=true,	--BD
	[758]=true,	--BoT
	[774]=true,	--TotFW
	[800]=true,	--FL
	[824]=true,	--DS
	
	[896]=true,	--MV
	[897]=true,	--HoF
	[886]=true,	--ToES
	[930]=true,	--ToT
	[953]=true,	--SoO
	
	[988]=true,	--BF
	[994]=true,	--H
}

module.db.autoSegmentEvents = {"UNIT_SPELLCAST_SUCCEEDED","SPELL_AURA_REMOVED","SPELL_AURA_APPLIED","UNIT_DIED","CHAT_MSG_RAID_BOSS_EMOTE"}
module.db.autoSegmentEventsL = {
	["UNIT_SPELLCAST_SUCCEEDED"] = ExRT.L.BossWatcherSegmentEventsUSS,
	["SPELL_AURA_REMOVED"] = ExRT.L.BossWatcherSegmentEventsSAR,
	["SPELL_AURA_APPLIED"] = ExRT.L.BossWatcherSegmentEventsSAA,
	["UNIT_DIED"] = ExRT.L.BossWatcherSegmentEventsUD,
	["CHAT_MSG_RAID_BOSS_EMOTE"] = ExRT.L.BossWatcherSegmentEventsCMRBE,
}
module.db.autoSegments = {
	["UNIT_DIED"] = {},
	["SPELL_AURA_APPLIED"] = {},
	["SPELL_AURA_REMOVED"] = {},
	["UNIT_SPELLCAST_SUCCEEDED"] = {},
	["CHAT_MSG_RAID_BOSS_EMOTE"] = {},
}
module.db.segmentsLNames = {
	["UNIT_SPELLCAST_SUCCEEDED"] = ExRT.L.BossWatcherSegmentNamesUSS,
	["SPELL_AURA_REMOVED"] = ExRT.L.BossWatcherSegmentNamesSAR,
	["SPELL_AURA_APPLIED"] = ExRT.L.BossWatcherSegmentNamesSAA,
	["UNIT_DIED"] = ExRT.L.BossWatcherSegmentNamesUD,
	['ENCOUNTER_START'] = ExRT.L.BossWatcherSegmentNamesES,
	["SLASH"] = ExRT.L.BossWatcherSegmentNamesSC,
	["CHAT_MSG_RAID_BOSS_EMOTE"] = ExRT.L.BossWatcherSegmentNamesCMRBE,
}
module.db.registerOtherEvents = {}

module.db.raidTargets = {0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80}
module.db.energyLocale = {
	[0] = "|cff69ccf0"..ExRT.L.BossWatcherEnergyType0,
	[1] = "|cffedc294"..ExRT.L.BossWatcherEnergyType1,
	[2] = "|cffd1fa99"..ExRT.L.BossWatcherEnergyType2,
	[3] = "|cffffff8f"..ExRT.L.BossWatcherEnergyType3,
	[4] = "|cfffff569"..(COMBO_POINTS or "Combo Points"),
	[5] = "|cffeb4561"..ExRT.L.BossWatcherEnergyType5,
	[6] = "|cffeb4561"..ExRT.L.BossWatcherEnergyType6,
	[7] = "|cff9482c9"..ExRT.L.BossWatcherEnergyType7,
	[8] = "|cffffa330"..ExRT.L.BossWatcherEnergyType8,
	[9] = "|cffffb3e0"..ExRT.L.BossWatcherEnergyType9,
	[10] = "|cffffffff"..ExRT.L.BossWatcherEnergyType10,
	[12] = "|cff4DbB98"..ExRT.L.BossWatcherEnergyType12,
	[13] = "|cffd9d9d9"..ExRT.L.BossWatcherEnergyType13,
	[14] = "|cffeb4561"..ExRT.L.BossWatcherEnergyType14,
	[15] = "|cff9482c9"..ExRT.L.BossWatcherEnergyType15,
}

module.db.schoolsDefault = {0x1,0x2,0x4,0x8,0x10,0x20,0x40}
module.db.schoolsColors = {
	[SCHOOL_MASK_NONE]	= {r=.8,g=.8,b=.8},
	[SCHOOL_MASK_PHYSICAL]	= {r=1,g=.64,b=.19},
	[SCHOOL_MASK_HOLY] 	= {r=1,g=1,b=.56},
	[SCHOOL_MASK_FIRE] 	= {r=.92,g=.27,b=.38},
	[SCHOOL_MASK_NATURE] 	= {r=.6,g=1,b=.4},	--r=.82,g=.98,b=.6
	[SCHOOL_MASK_FROST] 	= {r=.29,g=.50,b=1},
	[SCHOOL_MASK_SHADOW] 	= {r=.72,g=.66,b=.94},
	[SCHOOL_MASK_ARCANE] 	= {r=.56,g=.95,b=1},
	
	[0x1C] = {r=1,g=.3,b=1},	--Elemental
	[0x7C] = {r=.6,g=0,b=0},	--Chromatic
	[0x7E] = {r=1,g=0,b=0},		--Magic
	[0x7F] = {r=.25,g=.25,b=.25},	--Chaos
}
module.db.schoolsNames = {
	[SCHOOL_MASK_NONE]	= ExRT.L.BossWatcherSchoolUnknown,
	[SCHOOL_MASK_PHYSICAL]	= ExRT.L.BossWatcherSchoolPhysical,
	[SCHOOL_MASK_HOLY] 	= ExRT.L.BossWatcherSchoolHoly,
	[SCHOOL_MASK_FIRE] 	= ExRT.L.BossWatcherSchoolFire,
	[SCHOOL_MASK_NATURE] 	= ExRT.L.BossWatcherSchoolNature,
	[SCHOOL_MASK_FROST] 	= ExRT.L.BossWatcherSchoolFrost,
	[SCHOOL_MASK_SHADOW] 	= ExRT.L.BossWatcherSchoolShadow,
	[SCHOOL_MASK_ARCANE] 	= ExRT.L.BossWatcherSchoolArcane,
	
	[0x1C] = ExRT.L.BossWatcherSchoolElemental,	--Elemental
	[0x7C] = ExRT.L.BossWatcherSchoolChromatic,	--Chromatic
	[0x7E] = ExRT.L.BossWatcherSchoolMagic,		--Magic
	[0x7F] = ExRT.L.BossWatcherSchoolChaos,		--Chaos
}

local function UpdateNewSegmentEvents(clear)
	wipe(module.db.autoSegments.UNIT_DIED)
	wipe(module.db.autoSegments.SPELL_AURA_APPLIED)
	wipe(module.db.autoSegments.SPELL_AURA_REMOVED)
	wipe(module.db.autoSegments.UNIT_SPELLCAST_SUCCEEDED)
	wipe(module.db.autoSegments.CHAT_MSG_RAID_BOSS_EMOTE)
	wipe(module.db.registerOtherEvents)
	if clear then
		return
	end
	for i=1,10 do
		if VExRT.BossWatcher.autoSegments[i] and VExRT.BossWatcher.autoSegments[i][1] and VExRT.BossWatcher.autoSegments[i][2] then
			module.db.autoSegments[ VExRT.BossWatcher.autoSegments[i][2] ][ VExRT.BossWatcher.autoSegments[i][1] ] = true
			if VExRT.BossWatcher.autoSegments[i][2] == 'UNIT_SPELLCAST_SUCCEEDED' then
				module.db.registerOtherEvents['UNIT_SPELLCAST_SUCCEEDED'] = true
			end
			if VExRT.BossWatcher.autoSegments[i][2] == 'CHAT_MSG_RAID_BOSS_EMOTE' then
				module.db.registerOtherEvents['CHAT_MSG_RAID_BOSS_EMOTE'] = true
			end
		end
	end
end

local graphDataMetaTable = {__index = function(self, index)
	local new = {
		dps={},
		hps={},
		health={},
		absorbs={},
		power={},
		name={},
	}
	self[index] = new
	return new
end}

local AddSegmentToData = nil
local _graphSectionTimer,_graphSectionTimerRounded,_graphRaidSnapshot = 0,0,{}

local _BW_Start,_BW_End = nil

function module:Enable()
	VExRT.BossWatcher.enabled = true
	
	module:RegisterEvents('ZONE_CHANGED_NEW_AREA','PLAYER_REGEN_DISABLED','PLAYER_REGEN_ENABLED','ENCOUNTER_START','ENCOUNTER_END')
	module.main:ZONE_CHANGED_NEW_AREA()
	module:RegisterSlash()
	
	UpdateNewSegmentEvents()
	
	if UnitAffectingCombat("player") then
		_BW_Start()
	end
end

function module:Disable()
	VExRT.BossWatcher.enabled = nil
	
	if fightData then
		_BW_End()
	end
	
	module.main:UnregisterAllEvents()
	module:UnregisterSlash()
end

local BWInterfaceFrame = nil
local BWInterfaceFrameLoad,isBWInterfaceFrameLoaded,BWInterfaceFrameLoadFunc = nil
do
	local isAdded = nil
	function BWInterfaceFrameLoadFunc()
		if not isBWInterfaceFrameLoaded then
			BWInterfaceFrameLoad()
		end
		if isBWInterfaceFrameLoaded then
			InterfaceOptionsFrame:Hide()
			BWInterfaceFrame:Show()
		end
		CloseDropDownMenus() 
	end
	function module:miniMapMenu()
		if isAdded then
			return
		end
		local subMenu = {
			{text = ExRT.L.BossWatcher, func = BWInterfaceFrameLoadFunc, notCheckable = true},
			{text = ExRT.L.BossWatcherTabMobs, func = ExRT.F.FightLog_OpenTab, arg1 = 1, notCheckable = true},
			{text = ExRT.L.BossWatcherTabHeal, func = ExRT.F.FightLog_OpenTab, arg1 = 2, notCheckable = true},
			{text = ExRT.L.BossWatcherTabBuffsAndDebuffs, func = ExRT.F.FightLog_OpenTab, arg1 = 3, notCheckable = true},
			{text = ExRT.L.BossWatcherTabEnemy, func = ExRT.F.FightLog_OpenTab, arg1 = 4, notCheckable = true},
			{text = ExRT.L.BossWatcherTabPlayersSpells, func = ExRT.F.FightLog_OpenTab, arg1 = 5, notCheckable = true},
			{text = ExRT.L.BossWatcherTabEnergy, func = ExRT.F.FightLog_OpenTab, arg1 = 6, notCheckable = true},
			{text = ExRT.L.BossWatcherTabInterruptAndDispel, func = ExRT.F.FightLog_OpenTab, arg1 = 7, notCheckable = true},
			{text = ExRT.L.BossWatcherTabGraphics, func = ExRT.F.FightLog_OpenTab, arg1 = 8, notCheckable = true},
			{text = ExRT.L.BossWatcherDeath, func = ExRT.F.FightLog_OpenTab, arg1 = 9, notCheckable = true},
		}
		ExRT.F.MinimapMenuAdd(ExRT.L.BossWatcher, BWInterfaceFrameLoadFunc,subMenu)
	end
	module:RegisterMiniMapMenu()
end
ExRT.F.FightLog_Open = BWInterfaceFrameLoadFunc

function ExRT.F:FightLog_OpenTab(tabID)
	if not isBWInterfaceFrameLoaded then
		BWInterfaceFrameLoad()
	end
	BWInterfaceFrame.tab:SelectTab(tabID)
	BWInterfaceFrame:Show()
	
	CloseDropDownMenus()
end

function module.options:Load()
	self:CreateTilte()

	self.checkEnabled = ExRT.lib.CreateCheckBox(self,nil,15,-35,ExRT.L.senable,VExRT.BossWatcher.enabled,nil,nil,"ExRTCheckButtonModernTemplate")
	self.checkEnabled:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			module:Enable()
		else
			module:Disable()
		end
	end)
	self.checkImproved = ExRT.lib.CreateCheckBox(self,nil,15,-60,ExRT.L.BossWatcherOptionImproved,VExRT.BossWatcher.Improved,ExRT.L.BossWatcherOptionImprovedTooltip,nil,"ExRTCheckButtonModernTemplate")
	self.checkImproved:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.Improved = true
		else
			VExRT.BossWatcher.Improved = nil
		end
	end)
	
	self.checkShowGUIDs = ExRT.lib.CreateCheckBox(self,nil,15,-86,ExRT.L.BossWatcherChkShowGUIDs,VExRT.BossWatcher.GUIDs,nil,nil,"ExRTCheckButtonModernTemplate")
	self.checkShowGUIDs:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.GUIDs = true
		else
			VExRT.BossWatcher.GUIDs = nil
		end
	end)
	
	self.checkSpellID = ExRT.lib.CreateCheckBox(self,nil,15,-110,ExRT.L.BossWatcherOptionSpellID,VExRT.BossWatcher.timeLineSpellID,nil,nil,"ExRTCheckButtonModernTemplate")
	self.checkSpellID:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.timeLineSpellID = true
		else
			VExRT.BossWatcher.timeLineSpellID = nil
		end
	end)
	
	self.checkNoGraphic = ExRT.lib.CreateCheckBox(self,nil,15,-135,ExRT.L.BossWatcherOptionNoGraphic,VExRT.BossWatcher.noGraphics,nil,nil,"ExRTCheckButtonModernTemplate")
	self.checkNoGraphic:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.noGraphics = true
		else
			VExRT.BossWatcher.noGraphics = nil
		end
	end)
	self.checkNoBuffs = ExRT.lib.CreateCheckBox(self,nil,15,-160,ExRT.L.BossWatcherOptionNoBuffs,VExRT.BossWatcher.noBuffs,ExRT.L.BossWatcherOptionNoBuffsTooltip,nil,"ExRTCheckButtonModernTemplate")
	self.checkNoBuffs:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.noBuffs = true
		else
			VExRT.BossWatcher.noBuffs = nil
		end
	end)
	self.checkNoDeath = ExRT.lib.CreateCheckBox(self,nil,15,-185,ExRT.L.BossWatcherDisableDeath,VExRT.BossWatcher.noDeath,nil,nil,"ExRTCheckButtonModernTemplate")
	self.checkNoDeath:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.noDeath = true
		else
			VExRT.BossWatcher.noDeath = nil
		end
	end)
	
	self.sliderNum = ExRT.lib.CreateSlider(self,300,15,20,-225,1,10,ExRT.L.BossWatcherOptionsFightsSave,VExRT.BossWatcher.fightsNum or 1,nil,nil,true)
	self.sliderNum:SetScript("OnValueChanged", function(self,event) 
		event = ExRT.F.Round(event)
		VExRT.BossWatcher.fightsNum = event
		self.tooltipText = event
		self:tooltipReload(self)
	end)
	self.warningText = ExRT.lib.CreateText(self,570,25,nil,15,-250,"LEFT","TOP",nil,11,ExRT.L.BossWatcherOptionsFightsWarning,nil,1,1,1,1)
	
	--[[
	self.saveVariables = ExRT.lib.CreateCheckBox(self,nil,10,-235,ExRT.L.BossWatcherSaveVariables,VExRT.BossWatcher.saveVariables,ExRT.L.BossWatcherSaveVariablesWarring)
	self.saveVariables:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.saveVariables = true
			VExRT.BossWatcher.SAVED_DATA = module.db.data
		else
			VExRT.BossWatcher.saveVariables = nil
			VExRT.BossWatcher.SAVED_DATA = nil
		end
	end)
	]]
	
	self.showButton = ExRT.lib.CreateButton(self,550,22,"TOP",0,-275,ExRT.L.BossWatcherGoToBossWatcher)
	self.showButton:SetScript("OnClick",function ()
		InterfaceOptionsFrame:Hide()
		BWInterfaceFrameLoadFunc()
	end)
	self.buttonChecker = CreateFrame("Frame",nil,self)
	self.buttonChecker:SetScript("OnShow",function (self)
		if not InterfaceOptionsFrame:IsShown() then
			module.options.showButton:Hide()
		else
			module.options.showButton:Show()
		end
	end)
	
	self.chatText = ExRT.lib.CreateText(self,600,250,nil,15,-310,"LEFT","TOP",nil,12,ExRT.L.BossWatcherOptionsHelp,nil,1,1,1,1)
	
	self.checkHideMageT100 = ExRT.lib.CreateCheckBox(self,nil,15,-425,ExRT.L.BossWatcherHidePrismatic,not VExRT.BossWatcher.showPrismatic,ExRT.L.BossWatcherHidePrismaticTooltip,nil,"ExRTCheckButtonModernTemplate")
	self.checkHideMageT100:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.showPrismatic = nil
		else
			VExRT.BossWatcher.showPrismatic = true
		end
		module.db.lastFightID = module.db.lastFightID + 1
		module.db.data[module.db.nowNum].fightID = module.db.lastFightID
		if BWInterfaceFrame then
			BWInterfaceFrame.nowFightID = module.db.lastFightID
		end
	end)
	self.checkDivisionByZeroMageT100 = ExRT.lib.CreateCheckBox(self,nil,15,-450,ExRT.L.BossWatcherDisablePrismatic,VExRT.BossWatcher.divisionPrismatic,ExRT.L.BossWatcherDisablePrismaticTooltip,nil,"ExRTCheckButtonModernTemplate")
	self.checkDivisionByZeroMageT100:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.BossWatcher.divisionPrismatic = true
		else
			VExRT.BossWatcher.divisionPrismatic = nil
		end
		module.db.lastFightID = module.db.lastFightID + 1
		module.db.data[module.db.nowNum].fightID = module.db.lastFightID
		if BWInterfaceFrame then
			BWInterfaceFrame.nowFightID = module.db.lastFightID
		end
	end)
end

function module.main:ADDON_LOADED()
	VExRT = _G.VExRT
	VExRT.BossWatcher = VExRT.BossWatcher or {}
	VExRT.BossWatcher.autoSegments = VExRT.BossWatcher.autoSegments or {}
	
	if VExRT.BossWatcher.enabled then
		module:Enable(true)
	end
	VExRT.BossWatcher.fightsNum = VExRT.BossWatcher.fightsNum or 2
	
	if VExRT.BossWatcher.saveVariables and VExRT.BossWatcher.SAVED_DATA then
		module.db.data = VExRT.BossWatcher.SAVED_DATA
		for i=1,#module.db.data do
			if module.db.data[i] then
				module.db.data[i].fightID = -i
			end
		end
	else
		VExRT.BossWatcher.SAVED_DATA = nil
	end
	
	VExRT.BossWatcher.saveVariables = nil	
end


--[[
Death type:
1: damage
2: heal
3: death
]]
local deathMaxEvents = 40

local function addDeathData_enabled(destGUID,type,sourceGUID,timestamp,spellID,amount,overkill,school,blocked,absorbed,critical,multistrike,isAbsorb)
	local destData = deathLog[destGUID]
	if not destData then
		destData = {}
		for i=1,deathMaxEvents do
			destData[i] = {}
		end
		destData.c = 0
		deathLog[destGUID] = destData
	end
	local pos = destData.c
	pos = pos + 1
	if pos > deathMaxEvents then
		pos = 1
	end
	local deathLine = destData[pos]
	deathLine.t = type
	deathLine.s = sourceGUID
	deathLine.ti = timestamp
	deathLine.sp = spellID
	deathLine.a = amount
	deathLine.o = overkill
	deathLine.sc = school
	deathLine.b = blocked
	deathLine.ab = absorbed
	deathLine.c = critical
	deathLine.m = multistrike
	deathLine.ia = isAbsorb
	
	local player = raidGUIDs[ destGUID ]
	if player then
		deathLine.h = UnitHealth( player )
		deathLine.hm = UnitHealthMax( player )
	end
	
	destData.c = pos
end
local function addDeathData_disabled() end
local addDeathData = addDeathData_enabled

local function addDeath_CopyTable(dataTable,copyTable)
	dataTable[1] = copyTable.t
	dataTable[2] = copyTable.s
	dataTable[3] = copyTable.ti
	dataTable[4] = copyTable.sp
	dataTable[5] = copyTable.a
	dataTable[6] = copyTable.o
	dataTable[7] = copyTable.sc
	dataTable[8] = copyTable.b
	dataTable[9] = copyTable.ab
	dataTable[10] = copyTable.c
	dataTable[11] = copyTable.m
	dataTable[12] = copyTable.h
	dataTable[13] = copyTable.hm
	dataTable[14] = copyTable.ia
end

local function addDeathFix_enabled(destGUID,timestamp)
	local destData = deathLog[destGUID]
	if not destData then
		destData = {}
		for i=1,deathMaxEvents do
			destData[i] = {}
		end
		destData.c = 0
		deathLog[destGUID] = destData
	end
	local destTable = {
		{3,destGUID,timestamp},
	}
	fightData.deathLog[#fightData.deathLog + 1] = destTable
	for i=destData.c,1,-1 do
		local num = #destTable + 1
		destTable[num] = {}
		addDeath_CopyTable(destTable[num],destData[i])
		wipe(destData[i])
	end
	for i=deathMaxEvents,destData.c+1,-1 do
		local num = #destTable + 1
		destTable[num] = {}
		addDeath_CopyTable(destTable[num],destData[i])
		wipe(destData[i])
	end
	destData.c = 0
end
local function addDeathFix_disabled() end
local addDeathFix = addDeathFix_enabled

local function addDamage_noGraphics(sourceGUID,destGUID,amount,timestamp,spellID,overkill,school,blocked,absorbed,critical,multistrike)
	local destTable = fightData.damage[destGUID]
	if not destTable then
		fightData.damage_seen[destGUID] = timestamp
		destTable = {}
		fightData.damage[destGUID] = destTable
	end
	local sourceTable = destTable[sourceGUID]
	if not sourceTable then
		sourceTable = {}
		destTable[sourceGUID] = sourceTable
	end
	local spellTable = sourceTable[spellID]
	if not spellTable then
		spellTable = {
			amount = 0,
			count = 0,
			overkill = 0,
			blocked = 0,
			absorbed = 0,
			crit = 0,
			critcount = 0,
			critmax = 0,
			ms = 0,
			mscount = 0,
			msmax = 0,
			hitmax = 0,
			parry = 0,
			dodge = 0,
			miss = 0,
		}
		sourceTable[spellID] = spellTable
		if school then
			spellsSchool[spellID] = school
		end
	end
	spellTable.amount = spellTable.amount + amount
	spellTable.count = spellTable.count + 1
	if overkill > 0 then
		spellTable.overkill = spellTable.overkill + overkill
	end
	if blocked then
		spellTable.blocked = spellTable.blocked + blocked
	end
	if absorbed then
		spellTable.absorbed = spellTable.absorbed + absorbed
	end
	if critical then
		spellTable.crit = spellTable.crit + amount
		spellTable.critcount = spellTable.critcount + 1
		if spellTable.critmax < amount then
			spellTable.critmax = amount
		end
	end
	if multistrike then
		spellTable.ms = spellTable.ms + amount
		spellTable.mscount = spellTable.mscount + 1
		if spellTable.msmax < amount then
			spellTable.msmax = amount
		end
	end
	if not critical and not multistrike then
		if spellTable.hitmax < amount then
			spellTable.hitmax = amount
		end
	end
	addDeathData(destGUID,1,sourceGUID,timestamp,spellID,amount,overkill,school,blocked,absorbed,critical,multistrike)
end
local function addDamage_graphics(sourceGUID,destGUID,amount,timestamp,spellID,overkill,school,blocked,absorbed,critical,multistrike)
	local destTable = fightData.damage[destGUID]
	if not destTable then
		fightData.damage_seen[destGUID] = timestamp
		destTable = {}
		fightData.damage[destGUID] = destTable
	end
	local sourceTable = destTable[sourceGUID]
	if not sourceTable then
		sourceTable = {}
		destTable[sourceGUID] = sourceTable
	end
	local spellTable = sourceTable[spellID]
	if not spellTable then
		spellTable = {
			amount = 0,
			count = 0,
			overkill = 0,
			blocked = 0,
			absorbed = 0,
			crit = 0,
			critcount = 0,
			critmax = 0,
			ms = 0,
			mscount = 0,
			msmax = 0,
			hitmax = 0,
			parry = 0,
			dodge = 0,
			miss = 0,
		}
		sourceTable[spellID] = spellTable
		if school then
			spellsSchool[spellID] = school
		end
	end
	spellTable.amount = spellTable.amount + amount
	spellTable.count = spellTable.count + 1
	if overkill > 0 then
		spellTable.overkill = spellTable.overkill + overkill
	end
	if blocked then
		spellTable.blocked = spellTable.blocked + blocked
	end
	if absorbed then
		spellTable.absorbed = spellTable.absorbed + absorbed
	end
	if critical then
		spellTable.crit = spellTable.crit + amount
		spellTable.critcount = spellTable.critcount + 1
		if spellTable.critmax < amount then
			spellTable.critmax = amount
		end
	end
	if multistrike then
		spellTable.ms = spellTable.ms + amount
		spellTable.mscount = spellTable.mscount + 1
		if spellTable.msmax < amount then
			spellTable.msmax = amount
		end
	end
	if not critical and not multistrike then
		if spellTable.hitmax < amount then
			spellTable.hitmax = amount
		end
	end
	
	local graphData = graphData[_graphSectionTimerRounded].dps
	if not graphData[sourceGUID] then
		graphData[sourceGUID] = amount
	else
		graphData[sourceGUID] = graphData[sourceGUID] + amount
	end
	
	addDeathData(destGUID,1,sourceGUID,timestamp,spellID,amount,overkill,school,blocked,absorbed,critical,multistrike)
end
local addDamage = addDamage_noGraphics

local function AddMiss(sourceGUID,destGUID,timestamp,spellId,missType,amountMissed,multistrike,school)
	if missType == "ABSORB" then
		addDamage(sourceGUID,destGUID,0,timestamp,spellId,0,school,nil,amountMissed,nil,multistrike)
	elseif missType == "BLOCK" then
		addDamage(sourceGUID,destGUID,0,timestamp,spellId,0,school,amountMissed,nil,nil,multistrike)
	elseif missType == "PARRY" then
		addDamage(sourceGUID,destGUID,0,timestamp,spellId,0,school,nil,nil,nil,multistrike)
		local spellTable = fightData.damage[destGUID][sourceGUID][spellId]
		spellTable.parry = spellTable.parry + 1
	elseif missType == "DODGE" then
		addDamage(sourceGUID,destGUID,0,timestamp,spellId,0,school,nil,nil,nil,multistrike)
		local spellTable = fightData.damage[destGUID][sourceGUID][spellId]
		spellTable.dodge = spellTable.dodge + 1
	else
		addDamage(sourceGUID,destGUID,0,timestamp,spellId,0,school,nil,nil,nil,multistrike)
		local spellTable = fightData.damage[destGUID][sourceGUID][spellId]
		spellTable.miss = spellTable.miss + 1	
	end
end

local function AddEnvironmentalDamage(sourceGUID,destGUID,timestamp,environmentalType,amount,overkill,school,resisted,blocked,absorbed,critical,multistrike)
	if environmentalType == "Falling" then
		addDamage(sourceGUID,destGUID,amount,timestamp,110122,overkill,school,blocked,absorbed,critical,multistrike)
	elseif environmentalType == "Drowning" then
		addDamage(sourceGUID,destGUID,amount,timestamp,68730,overkill,school,blocked,absorbed,critical,multistrike)
	elseif environmentalType == "Fatigue" then
		addDamage(sourceGUID,destGUID,amount,timestamp,125024,overkill,school,blocked,absorbed,critical,multistrike)
	elseif environmentalType == "Fire" then
		addDamage(sourceGUID,destGUID,amount,timestamp,103795,overkill,school,blocked,absorbed,critical,multistrike)
	elseif environmentalType == "Lava" then
		addDamage(sourceGUID,destGUID,amount,timestamp,119741,overkill,school,blocked,absorbed,critical,multistrike)
	elseif environmentalType == "Slime" then
		addDamage(sourceGUID,destGUID,amount,timestamp,16456,overkill,school,blocked,absorbed,critical,multistrike)
	else
		addDamage(sourceGUID,destGUID,amount,timestamp,48360,overkill,school,blocked,absorbed,critical,multistrike)
	end
end

--[[
Note about healing:
amount = healing + overhealing
absorbed = if spell absorbed by ability (ex. DK's egg, Koragh shadow phase)
absorbs = if spell is absorb (ex. PW:S, HPally mastery, BloodDK mastery)
]]

local function addHeal_graphics(sourceGUID,destGUID,spellId,amount,overhealing,absorbed,critical,multistrike,school,timestamp,absorbs)
	local sourceTable = fightData.heal[sourceGUID]
	if not sourceTable then
		sourceTable = {}
		fightData.heal[sourceGUID] = sourceTable
	end
	local destTable = sourceTable[destGUID]
	if not destTable then
		destTable = {}
		sourceTable[destGUID] = destTable
	end
	local spellTable = destTable[spellId]
	if not spellTable then
		spellTable = {
			amount = 0,
			over = 0,
			absorbed = 0,
			count = 0,
			crit = 0,
			critcount = 0,
			critmax = 0,
			critover = 0,
			ms = 0,
			mscount = 0,
			msmax = 0,
			msover = 0,
			hitmax = 0,
			absorbs = 0,
		}
		destTable[spellId] = spellTable
		spellsSchool[spellId] = school
	end
	spellTable.amount = spellTable.amount + amount
	spellTable.over = spellTable.over + overhealing
	spellTable.absorbed = spellTable.absorbed + absorbed
	spellTable.count = spellTable.count + 1
	if critical then
		spellTable.crit = spellTable.crit + amount + absorbed
		spellTable.critcount = spellTable.critcount + 1
		if spellTable.critmax < amount then
			spellTable.critmax = amount
		end
		spellTable.critover = spellTable.critover + overhealing
	end
	if multistrike then
		spellTable.ms = spellTable.ms + amount + absorbed
		spellTable.mscount = spellTable.mscount + 1
		if spellTable.msmax < amount then
			spellTable.msmax = amount
		end
		spellTable.msover = spellTable.msover + overhealing		
	end
	if not critical and not multistrike then
		if spellTable.hitmax < amount then
			spellTable.hitmax = amount
		end
	end
	if absorbs then
		spellTable.absorbs = spellTable.absorbs + absorbs
	end
	
	local graphData = graphData[_graphSectionTimerRounded].hps
	if not graphData[sourceGUID] then
		graphData[sourceGUID] = amount - overhealing + absorbed
	else
		graphData[sourceGUID] = graphData[sourceGUID] + amount - overhealing + absorbed
	end
	
	addDeathData(destGUID,2,sourceGUID,timestamp,spellId,amount,overhealing,school,nil,absorbed,critical,multistrike,absorbs)
end
local function addHeal_noGraphics(sourceGUID,destGUID,spellId,amount,overhealing,absorbed,critical,multistrike,school,timestamp,absorbs)
	local sourceTable = fightData.heal[sourceGUID]
	if not sourceTable then
		sourceTable = {}
		fightData.heal[sourceGUID] = sourceTable
	end
	local destTable = sourceTable[destGUID]
	if not destTable then
		destTable = {}
		sourceTable[destGUID] = destTable
	end
	local spellTable = destTable[spellId]
	if not spellTable then
		spellTable = {
			amount = 0,
			over = 0,
			absorbed = 0,
			count = 0,
			crit = 0,
			critcount = 0,
			critmax = 0,
			critover = 0,
			ms = 0,
			mscount = 0,
			msmax = 0,
			msover = 0,
			hitmax = 0,
			absorbs = 0,
		}
		destTable[spellId] = spellTable
		spellsSchool[spellId] = school
	end
	spellTable.amount = spellTable.amount + amount
	spellTable.over = spellTable.over + overhealing
	spellTable.absorbed = spellTable.absorbed + absorbed
	spellTable.count = spellTable.count + 1
	if critical then
		spellTable.crit = spellTable.crit + amount + absorbed
		spellTable.critcount = spellTable.critcount + 1
		if spellTable.critmax < amount then
			spellTable.critmax = amount
		end
		spellTable.critover = spellTable.critover + overhealing
	end
	if multistrike then
		spellTable.ms = spellTable.ms + amount + absorbed
		spellTable.mscount = spellTable.mscount + 1
		if spellTable.msmax < amount then
			spellTable.msmax = amount
		end
		spellTable.msover = spellTable.msover + overhealing		
	end
	if not critical and not multistrike then
		if spellTable.hitmax < amount then
			spellTable.hitmax = amount
		end
	end
	if absorbs then
		spellTable.absorbs = spellTable.absorbs + absorbs
	end
	
	addDeathData(destGUID,2,sourceGUID,timestamp,spellId,amount,overhealing,school,nil,absorbed,critical,multistrike,absorbs)
end
local addHeal = addHeal_noGraphics

local function removeShield_New(sourceGUID,destGUID,spellId,amount,school,timestamp)
	if amount > 0 then
		addHeal(sourceGUID,destGUID,spellId,amount,amount,0,nil,nil,school,timestamp)
	end
end

local function addSwitch(sourceGUID,targetGUID,timestamp,_type,spellId)
	local targetTable = fightData.switch[targetGUID]
	if not targetTable then
		targetTable = {
			[1]={},	--cast
			[2]={},	--target
		}
		fightData.switch[targetGUID] = targetTable
	end
	if not targetTable[_type][sourceGUID] then
		targetTable[_type][sourceGUID] = {timestamp,spellId}
	end
end

local function addCast(sourceGUID,destGUID,spellID,_type,timestamp)
	local sourceTable = fightData.cast[sourceGUID]
	if not sourceTable then
		sourceTable = {}
		fightData.cast[sourceGUID] = sourceTable
	end
	sourceTable[ #sourceTable + 1 ] = {timestamp,spellID,_type,destGUID}
end

local function addGUID(GUID,name)
	if not guidData[GUID] then
		guidData[GUID] = name or "nil"
	end
end

local function updateReaction(GUID,flags)
	reactionData[GUID] = flags
end

local function addBuff_disabled()
end
local function addBuff_enabled(timestamp,sourceGUID,destGUID,sourceFriendly,destFriendly,spellID,type_1,subeventID,stack)
	fightData.auras[ #fightData.auras + 1 ] = {timestamp,sourceGUID,destGUID,sourceFriendly,destFriendly,spellID,type_1,subeventID,stack}
end
local addBuff = addBuff_enabled

local function addChatMessage(sender,msg,spellID,time)
	fightData.chat[ #fightData.chat + 1 ] = {sender,msg,spellID,time}
end

local function addPower(sourceGUID,spellId,powerType,amount)
	local sourceData = fightData.power[sourceGUID]
	if not sourceData then
		sourceData = {}
		fightData.power[sourceGUID] = sourceData
	end
	local powerData = sourceData[powerType]
	if not powerData then
		powerData = {}
		sourceData[powerType] = powerData
	end
	local spellData = powerData[spellId]
	if not spellData then
		spellData = {0,0}
		powerData[spellId] = spellData
	end
	spellData[1] = spellData[1] + amount
	spellData[2] = spellData[2] + 1
end

function AddSegmentToData(seg)
	local segmentData = module.db.data[module.db.nowNum].fight[seg]
	for destGUID,destData in pairs(segmentData.damage) do
		local _now = module.db.nowData.damage[destGUID]
		if not _now then
			_now = {}
			module.db.nowData.damage[destGUID] = _now
		end
		for sourceGUID,sourceData in pairs(destData) do
			local _source = _now[sourceGUID]
			if not _source then
				_source = {}
				_now[sourceGUID] = _source
			end
			for spellID,spellData in pairs(sourceData) do
				local _spell = _source[spellID]
				if not _spell then
					_spell = {
						amount = 0,
						count = 0,
						overkill = 0,
						blocked = 0,
						absorbed = 0,
						crit = 0,
						critcount = 0,
						critmax = 0,
						ms = 0,
						mscount = 0,
						msmax = 0,
						hitmax = 0,
						parry = 0,
						dodge = 0,
						miss = 0,
					}
					_source[spellID] = _spell
				end
				for dataName,dataAmount in pairs(spellData) do
					if dataName:find("max") then
						_spell[dataName] = max(_spell[dataName],dataAmount)
					else
						_spell[dataName] = _spell[dataName] + dataAmount
					end				
				end
			end
		end		
	end
	for destGUID,seen in pairs(segmentData.damage_seen) do
		if module.db.nowData.damage_seen[destGUID] then
			module.db.nowData.damage_seen[destGUID] = min(module.db.nowData.damage_seen[destGUID],seen)
		else
			module.db.nowData.damage_seen[destGUID] = seen
		end
	end
	for sourceGUID,sourceData in pairs(segmentData.heal) do
		local _source = module.db.nowData.heal[sourceGUID]
		if not _source then
			_source = {}
			module.db.nowData.heal[sourceGUID] = _source
		end
		for destGUID,destData in pairs(sourceData) do
			local _dest = _source[destGUID]
			if not _dest then
				_dest = {}
				_source[destGUID] = _dest
			end
			for spellID,spellData in pairs(destData) do
				local _spell = _dest[spellID]
				if not _spell then
					_spell = {
						amount = 0,
						over = 0,
						absorbed = 0,
						count = 0,
						crit = 0,
						critcount = 0,
						critmax = 0,
						critover = 0,
						ms = 0,
						mscount = 0,
						msmax = 0,
						msover = 0,
						hitmax = 0,
						absorbs = 0,
					}
					_dest[spellID] = _spell
				end
				for dataName,dataAmount in pairs(spellData) do
					if dataName:find("max") then
						_spell[dataName] = max(_spell[dataName],dataAmount)
					else
						_spell[dataName] = _spell[dataName] + dataAmount
					end				
				end
			end
		end
	end
	for targetGUID,destData in pairs(segmentData.switch) do
		if not module.db.nowData.switch[targetGUID] then
			module.db.nowData.switch[targetGUID] = {
				[1]={},	--cast
				[2]={},	--target
			}
		end
		for _type=1,2 do
			for unitN,t in pairs(destData[_type]) do
				if not module.db.nowData.switch[targetGUID][_type][unitN] then
					module.db.nowData.switch[targetGUID][_type][unitN] = {t[1],t[2]}
				end
				if t[1] < module.db.nowData.switch[targetGUID][_type][unitN][1] then
					module.db.nowData.switch[targetGUID][_type][unitN][1] = t[1]
					module.db.nowData.switch[targetGUID][_type][unitN][2] = t[2]
				end
			end
		end
	end
	for sourceGUID,destData in pairs(segmentData.cast) do
		if not module.db.nowData.cast[sourceGUID] then
			module.db.nowData.cast[sourceGUID] = {}
		end
		for i=1,#destData do
			module.db.nowData.cast[sourceGUID][ #module.db.nowData.cast[sourceGUID]+1 ] = destData[i]
		end
	end
	for i=1,#segmentData.auras do
		module.db.nowData.auras[ #module.db.nowData.auras + 1 ] = segmentData.auras[i]
	end
	for i=1,#segmentData.dies do
		module.db.nowData.dies[ #module.db.nowData.dies + 1 ] = segmentData.dies[i]
	end
	for i=1,#segmentData.dispels do
		module.db.nowData.dispels[ #module.db.nowData.dispels + 1 ] = segmentData.dispels[i]
	end
	for i=1,#segmentData.interrupts do
		module.db.nowData.interrupts[ #module.db.nowData.interrupts + 1 ] = segmentData.interrupts[i]
	end
	for i=1,#segmentData.chat do
		module.db.nowData.chat[ #module.db.nowData.chat + 1 ] = segmentData.chat[i]
	end
	for sourceGUID,sourceData in pairs(segmentData.power) do
		local _sourceGUID = module.db.nowData.power[sourceGUID]
		if not _sourceGUID then
			_sourceGUID = {}
			module.db.nowData.power[sourceGUID] = _sourceGUID
		end
		for powerType,powerData in pairs(sourceData) do
			local _powerType = _sourceGUID[powerType]
			if not _powerType then
				_powerType = {}
				_sourceGUID[powerType] = _powerType
			end
			for spellID,spellData in pairs(powerData) do
				local _spellData = _powerType[spellID]
				if not _spellData then
					_spellData = {0,0}
					_powerType[spellID] = _spellData
				end
				_spellData[1] = _spellData[1] + spellData[1]
				_spellData[2] = _spellData[2] + spellData[2]
			end			
		end
	end
	for i=1,#segmentData.deathLog do
		local added_index = #module.db.nowData.deathLog + 1
		module.db.nowData.deathLog[added_index] = {}
		for j=1,#segmentData.deathLog[i] do
			module.db.nowData.deathLog[added_index][j] = segmentData.deathLog[i][j]
		end
	end
	for sourceGUID,sourceHP in pairs(segmentData.maxHP) do
		module.db.nowData.maxHP[sourceGUID] = sourceHP
	end
end

local function StartSegment(name,subEvent)
	fightData = {
		damage = {},
		damage_seen = {},
		heal = {},
		switch = {},
		cast = {},
		interrupts = {},
		dispels = {},
		auras = {},
		power = {},
		dies = {},
		chat = {},
		resurrests = {},
		deathLog = {},
		maxHP = {},
		time = time(),
		timeEx = GetTime(),
		name = name,
		subEvent = subEvent,
	}
	module.db.data[1].fight[ #module.db.data[1].fight + 1 ] = fightData
end

local timers_graphs_enabled = nil
local timers_improved_enabled = nil

local timers_improved_timer = 0.01
local timers_improved_segment = 1

function _BW_Start(encounterID,encounterName)
	module.db.lastFightID = module.db.lastFightID + 1

	local maxFights = (VExRT.BossWatcher.fightsNum or 10)
	for i=maxFights,2,-1 do
		module.db.data[i] = module.db.data[i-1]
	end
	module.db.data[1] = {
		guids = {},
		reaction = {},
		fight = {},
		pets = {},
		encounterName = encounterName,
		encounterStartGlobal = time(),
		encounterStart = GetTime(),
		encounterEnd = 0,
		graphData = {},
		fightID = module.db.lastFightID,
	}
	setmetatable(module.db.data[1].graphData,graphDataMetaTable)
	
	wipe(deathLog)
	
	wipe(raidGUIDs)
	
	timers_graphs_enabled = nil
	timers_improved_enabled = nil

	guidData = module.db.data[1].guids
	graphData = module.db.data[1].graphData
	reactionData = module.db.data[1].reaction
	if VExRT.BossWatcher.Improved then
		UpdateNewSegmentEvents(true)
		module.db.data[1].improved = true
		timers_improved_enabled = true
		StartSegment()
		timers_improved_timer = 0.01
		timers_improved_segment = 1
		fightData = module.db.data[1].fight[1]
		module:RegisterTimer()
	else
		StartSegment("ENCOUNTER_START")
	end	
	
	for event,_ in pairs(module.db.registerOtherEvents) do
		module:RegisterEvents(event)
	end
	module:RegisterEvents('COMBAT_LOG_EVENT_UNFILTERED','UNIT_TARGET','RAID_BOSS_EMOTE','RAID_BOSS_WHISPER','UPDATE_MOUSEOVER_UNIT')
	
	_graphSectionTimer = 0
	_graphSectionTimerRounded = 0
	_graphRaidSnapshot = {"boss1","boss2","boss3","boss4","boss5","target","focus"}
	if IsInRaid() then
		local gMax = ExRT.F.GetRaidDiffMaxGroup()
		for i=1,40 do
			local name,_,subgroup = GetRaidRosterInfo(i)
			if name and subgroup <= gMax then
				_graphRaidSnapshot[#_graphRaidSnapshot + 1] = name
				
				local guid = UnitGUID(name)
				if guid then
					raidGUIDs[ guid ] = name
				end
			end
		end
	else
		_graphRaidSnapshot[#_graphRaidSnapshot + 1] = UnitName("player")
		raidGUIDs[ UnitGUID("player") ] = UnitName("player")
		for i=1,4 do
			local partyMember = UnitCombatlogname("party"..i)
			if partyMember then
				_graphRaidSnapshot[#_graphRaidSnapshot + 1] = partyMember
				
				raidGUIDs[ UnitGUID(partyMember) ] = partyMember
			end
		end
	end

	if not VExRT.BossWatcher.noGraphics then
		timers_graphs_enabled = true
		module:RegisterTimer()
		addDamage = addDamage_graphics
		addHeal = addHeal_graphics
	else
		addDamage = addDamage_noGraphics
		addHeal = addHeal_noGraphics
	end
	if VExRT.BossWatcher.noBuffs then
		addBuff = addBuff_disabled
	else
		addBuff = addBuff_enabled
	end
	if VExRT.BossWatcher.noDeath then
		addDeathData = addDeathData_disabled
		addDeathFix = addDeathFix_disabled
	else
		addDeathData = addDeathData_enabled
		addDeathFix = addDeathFix_enabled
	end
end
function module.main:ENCOUNTER_START(encounterID,encounterName)
	SetMapToCurrentZone()
	local zoneID = GetCurrentMapAreaID()
	if module.db.raidIDs[zoneID] then
		_BW_Start(encounterID,encounterName)
	end
end
function module.main:PLAYER_REGEN_DISABLED()
	SetMapToCurrentZone()
	local zoneID = GetCurrentMapAreaID()
	if not module.db.raidIDs[zoneID] then
		_BW_Start()
	end
end

function _BW_End()
	if fightData then
		module.db.data[1].encounterEnd = GetTime()
		module.db.data[1].timeFix = module.db.timeFix
		module.db.data[1].ExRTver = ExRT.V
		
		if not module.db.data[1].encounterName then
			local minSeen,minGUID = nil
			for GUID,seen in pairs(module.db.data[1].fight[1].damage_seen) do
				if (not minSeen or minSeen > seen) and ExRT.F.GetUnitInfoByUnitFlag(module.db.data[1].reaction[GUID],3) == 64 then
					minGUID = GUID
					minSeen = seen
				end
			end
			if minGUID and module.db.data[1].guids[minGUID] and module.db.data[1].guids[minGUID] ~= "nil" then
				module.db.data[1].encounterName = module.db.data[1].guids[minGUID]
			end
		end
		
		local GLOBALpets = ExRT.F.Pets:getPetsDB()
		for GUID,name in pairs(module.db.data[1].guids) do
			local petData = GLOBALpets[GUID]
			if petData then
				module.db.data[1].pets[GUID] = petData
			end
		end
	end
	if VExRT.BossWatcher.Improved then
		UpdateNewSegmentEvents()
	end

	module:UnregisterEvents('COMBAT_LOG_EVENT_UNFILTERED','UNIT_TARGET','RAID_BOSS_EMOTE','RAID_BOSS_WHISPER','UPDATE_MOUSEOVER_UNIT')
	for event,_ in pairs(module.db.registerOtherEvents) do
		module:UnregisterEvents(event)
	end
	module:UnregisterTimer()
	fightData = nil
	guidData = nil
	graphData = nil
	reactionData = nil
	
	wipe(deathLog)
end
function module.main:ENCOUNTER_END()
	SetMapToCurrentZone()
	local zoneID = GetCurrentMapAreaID()
	if module.db.raidIDs[zoneID] then
		_BW_End()
	end
end
function module.main:PLAYER_REGEN_ENABLED()
	SetMapToCurrentZone()
	local zoneID = GetCurrentMapAreaID()
	if not module.db.raidIDs[zoneID] then
		_BW_End()
	end
end

function module.main:ZONE_CHANGED_NEW_AREA()
	if fightData then
		_BW_End()
	end
end

do
	local powers = {}
	for powerID,_ in pairs(module.db.energyLocale) do
		powers[#powers + 1] = powerID
	end
	local powersCount = #powers
	function module:timer(elapsed)
		if timers_graphs_enabled then
			_graphSectionTimer = _graphSectionTimer + elapsed
			local nowTimer = ceil(_graphSectionTimer)
			if _graphSectionTimerRounded ~= nowTimer then
				_graphSectionTimerRounded = nowTimer
				for i=1,#_graphRaidSnapshot do
					local name = _graphRaidSnapshot[i]
					local _name = UnitCombatlogname(name)
					if _name then
						local data = graphData[_graphSectionTimerRounded]
						if _name ~= name then
							data.name[name] = _name
						end
						local health = UnitHealth(name)
						if health ~= 0 then
							data.health[name] = health
						end
						local absorbs = UnitGetTotalAbsorbs(name)
						if absorbs ~= 0 then
							data.absorbs[name] = absorbs
						end
						data.power[name] = {}
						for j=1,powersCount do
							local powerID = powers[j]
							local power = UnitPower(name,powerID)
							if power ~= 0 then
								data.power[name][powerID] = power
							end
						end
					end
				end
			end
		end
		if timers_improved_enabled then
			timers_improved_timer = timers_improved_timer + elapsed
			local nowTimer = ceil(timers_improved_timer)
			if timers_improved_segment ~= nowTimer then
				timers_improved_segment = nowTimer
				StartSegment()
			end
		end
	end
end

local autoSegmentsUPValue = module.db.autoSegments
function module.main:UNIT_SPELLCAST_SUCCEEDED(unitID,_,_,_,spellID)
	if autoSegmentsUPValue.UNIT_SPELLCAST_SUCCEEDED[spellID] then
		local guid = UnitGUID(unitID)
		if AntiSpam("BossWatcherUSS"..(guid or "0x0")..(spellID or "0"),0.5) then
			StartSegment("UNIT_SPELLCAST_SUCCEEDED",spellID)
		end
	end
end

function module.main:CHAT_MSG_RAID_BOSS_EMOTE(msg,sender)
	for emote,_ in pairs(autoSegmentsUPValue.CHAT_MSG_RAID_BOSS_EMOTE) do
		if msg:find(emote, nil, true) or msg:find(emote) then
			StartSegment("CHAT_MSG_RAID_BOSS_EMOTE",emote)
		end
	end
end

function module.main:RAID_BOSS_EMOTE(msg,sender)
	local spellID = msg:match("spell:(%d+)")
	if spellID then
		addChatMessage(sender,msg,spellID,GetTime())
	end
end
module.main.RAID_BOSS_WHISPER = module.main.RAID_BOSS_EMOTE

function module.main:SPELL_DAMAGE(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,_,amount,overkill,school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand, multistrike)
	--amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand, multistrike
	addDamage(sourceGUID,destGUID,amount,timestamp,spellId,overkill,school,blocked,absorbed,critical,multistrike)
	
	addSwitch(sourceGUID,destGUID,timestamp,1,spellId)
end
module.main.SPELL_PERIODIC_DAMAGE = module.main.SPELL_DAMAGE
module.main.RANGE_DAMAGE = module.main.SPELL_DAMAGE

function module.main:SWING_DAMAGE(timestamp,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,amount,overkill,school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand, multistrike)
	--amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand, multistrike
	addDamage(sourceGUID,destGUID,amount,timestamp,6603,overkill,school,blocked,absorbed,critical,multistrike)
	
	addSwitch(sourceGUID,destGUID,timestamp,1,6603)
end

function module.main:SPELL_INSTAKILL(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,school)
	addDamage(sourceGUID,destGUID,1,timestamp,spellId,1,school)
end

function module.main:SPELL_HEAL(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,school,amount,overhealing,absorbed,critical,multistrike)
	addHeal(sourceGUID,destGUID,spellId,amount,overhealing,absorbed,critical,multistrike,school,timestamp)
end
module.main.SPELL_PERIODIC_HEAL = module.main.SPELL_HEAL

--[[
SPELL_ABSORBED info:
	for SWING
timestamp,attackerGUID,attackerName,attackerFlags,attackerFlags2,destGUID,destName,destFlags,destFlags2,sourceGUID,sourceName,sourceFlags,sourceFlags2,spellId,spellName,school,amount
	OR for SPELL
timestamp,attackerGUID,attackerName,attackerFlags,attackerFlags2,destGUID,destName,destFlags,destFlags2,attackerSpellId,attackerSpellName,attackerSchool,sourceGUID,sourceName,sourceFlags,sourceFlags2,spellId,spellName,school,amount
]]
do
	local notAbsorbs = {
		[20711]=true,
		[115069]=true,
		[157533]=true,
	}

	function module.main:SPELL_ABSORBED(timestamp,attackerGUID,attackerName,attackerFlags,_,destGUID,destName,destFlags,_,sourceGUID,sourceName,sourceFlags,sourceFlags2,spellId,_,school,amount,_,school2,amount2)
		if amount2 then
			if not notAbsorbs[amount] then
				addHeal(sourceFlags2,destGUID,amount,amount2,0,0,nil,nil,school2,timestamp,amount2)
			end
		else
			if not notAbsorbs[spellId] then
				addHeal(sourceGUID,destGUID,spellId,amount,0,0,nil,nil,school,timestamp,amount)
			end
		end
	end
end

function module.main:SPELL_AURA_APPLIED(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,_,_type,amount)
	addBuff(timestamp,sourceGUID,destGUID,UnitIsFriendlyByUnitFlag(sourceFlags),UnitIsFriendlyByUnitFlag(destFlags),spellId,_type,1,1)
	
	if autoSegmentsUPValue.SPELL_AURA_APPLIED[spellId] then
		StartSegment("SPELL_AURA_APPLIED",spellId)
	end
end

function module.main:SPELL_AURA_REMOVED(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,school,_type,amount)
	addBuff(timestamp,sourceGUID,destGUID,UnitIsFriendlyByUnitFlag(sourceFlags),UnitIsFriendlyByUnitFlag(destFlags),spellId,_type,2,1)
	
	if autoSegmentsUPValue.SPELL_AURA_REMOVED[spellId] then
		StartSegment("SPELL_AURA_REMOVED",spellId)
	end
	
	if amount then
		removeShield_New(sourceGUID,destGUID,spellId,amount,school,timestamp)
	end
end

function module.main:SPELL_AURA_APPLIED_DOSE(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,_,_type,stack)
	addBuff(timestamp,sourceGUID,destGUID,UnitIsFriendlyByUnitFlag(sourceFlags),UnitIsFriendlyByUnitFlag(destFlags),spellId,_type,3,stack)
end

function module.main:SPELL_AURA_REMOVED_DOSE(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,_,_type,stack)
	addBuff(timestamp,sourceGUID,destGUID,UnitIsFriendlyByUnitFlag(sourceFlags),UnitIsFriendlyByUnitFlag(destFlags),spellId,_type,4,stack)
end

function module.main:SPELL_CAST_SUCCESS(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId)
	addSwitch(sourceGUID,destGUID,timestamp,1,spellId)
	
	addCast(sourceGUID,destGUID,spellId,1,timestamp)
end

function module.main:SPELL_CAST_START(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId)
	--> npc cast
	addCast(sourceGUID,destGUID,spellId,2,timestamp)
	
	--> switch
	if sourceName and GetUnitInfoByUnitFlag(sourceFlags,1) == 1024 then
		local unitID = UnitInRaid(sourceName)
		if unitID then
			unitID = "raid"..unitID
			local targetGUID = UnitGUID(unitID.."target")
			if targetGUID and not UnitIsPlayerOrPet(targetGUID) then
				addSwitch(sourceGUID,targetGUID,timestamp,1,spellId)
			end
		end
	end
end

function module.main:UNIT_DIED(timestamp,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId)
	fightData.dies[#fightData.dies+1] = {destGUID,destFlags,timestamp,destFlags2}
	
	addDeathFix(destGUID,timestamp)
	
	local uID = GUIDtoID(destGUID)
	if autoSegmentsUPValue.UNIT_DIED[ uID ] then
		StartSegment("UNIT_DIED",uID)
	end
end
module.main.UNIT_DESTROYED = module.main.UNIT_DIED

function module.main:SPELL_INTERRUPT(timestamp,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId,_,_,destSpell)
	fightData.interrupts[#fightData.interrupts+1]={sourceGUID,destGUID,spellId,destSpell,timestamp}
end

function module.main:SPELL_DISPEL(timestamp,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId,_,_,destSpell)
	fightData.dispels[#fightData.dispels+1]={sourceGUID,destGUID,spellId,destSpell,timestamp}
end
module.main.SPELL_STOLEN = module.main.SPELL_DISPEL

function module.main:SPELL_RESURRECT(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId)
	fightData.resurrests[#fightData.resurrests+1]={sourceGUID,destGUID,spellId,timestamp}
end

function module.main:SPELL_ENERGIZE(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,_,amount,powerType)
	addPower(destGUID,spellId,powerType,amount)
end

function module.main:SPELL_MISSED(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,spellId,_,school,missType,isOffHand,multistrike,amountMissed)
	AddMiss(sourceGUID,destGUID,timestamp,spellId,missType,amountMissed,multistrike,school)
end
function module.main:SWING_MISSED(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,missType,isOffHand,multistrike,amountMissed)
	AddMiss(sourceGUID,destGUID,timestamp,6603,missType,amountMissed,multistrike,0x1)
end
module.main.SPELL_PERIODIC_MISSED = module.main.SPELL_MISSED
module.main.RANGE_MISSED = module.main.SPELL_MISSED

function module.main:ENVIRONMENTAL_DAMAGE(timestamp,sourceGUID,sourceName,sourceFlags,_,destGUID,destName,destFlags,_,environmentalType,amount,overkill,school,resisted,blocked,absorbed,critical,glancing,crushing,isOffHand,multistrike)
	AddEnvironmentalDamage(sourceGUID,destGUID,timestamp,environmentalType,amount,overkill,school,resisted,blocked,absorbed,critical,multistrike)
end

local CLEUEvents = {
	SPELL_HEAL = module.main.SPELL_HEAL,
	SPELL_ABSORBED = module.main.SPELL_ABSORBED,
	SPELL_PERIODIC_HEAL = module.main.SPELL_PERIODIC_HEAL,
	SPELL_PERIODIC_DAMAGE = module.main.SPELL_PERIODIC_DAMAGE,
	RANGE_DAMAGE = module.main.RANGE_DAMAGE,
	SPELL_DAMAGE = module.main.SPELL_DAMAGE,
	SWING_DAMAGE = module.main.SWING_DAMAGE,
	SPELL_INSTAKILL = module.main.SPELL_INSTAKILL,
	SPELL_AURA_APPLIED = module.main.SPELL_AURA_APPLIED,
	SPELL_AURA_REMOVED = module.main.SPELL_AURA_REMOVED,
	SPELL_AURA_APPLIED_DOSE = module.main.SPELL_AURA_APPLIED_DOSE,
	SPELL_AURA_REMOVED_DOSE = module.main.SPELL_AURA_REMOVED_DOSE,
	SPELL_CAST_SUCCESS = module.main.SPELL_CAST_SUCCESS,
	SPELL_CAST_START = module.main.SPELL_CAST_START,
	UNIT_DIED = module.main.UNIT_DIED,
	UNIT_DESTROYED = module.main.UNIT_DESTROYED,
	SPELL_INTERRUPT = module.main.SPELL_INTERRUPT,
	SPELL_DISPEL = module.main.SPELL_DISPEL,
	SPELL_STOLEN = module.main.SPELL_STOLEN,
	SPELL_RESURRECT = module.main.SPELL_RESURRECT,
	SPELL_ENERGIZE = module.main.SPELL_ENERGIZE,
	SPELL_PERIODIC_ENERGIZE = module.main.SPELL_ENERGIZE,
	SPELL_MISSED = module.main.SPELL_MISSED,
	SPELL_PERIODIC_MISSED = module.main.SPELL_PERIODIC_MISSED,
	RANGE_MISSED = module.main.RANGE_MISSED,
	SWING_MISSED = module.main.SWING_MISSED,
	ENVIRONMENTAL_DAMAGE = module.main.ENVIRONMENTAL_DAMAGE,
}

local function CLEUafterTimeFix(self,timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId,...)
	local eventFunc = CLEUEvents[event]
	if eventFunc then
		eventFunc(self,timestamp,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId,...)
	end
	
	addGUID(sourceGUID,sourceName)
	addGUID(destGUID,destName)
	
	updateReaction(sourceGUID,sourceFlags)
	updateReaction(destGUID,destFlags)
end

function module.main:COMBAT_LOG_EVENT_UNFILTERED(timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId,...)
	if not module.db.timeFix then
		module.db.timeFix = {GetTime(),timestamp}
		module.main.COMBAT_LOG_EVENT_UNFILTERED = CLEUafterTimeFix
		CLEUafterTimeFix(self,timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId,...)
		module:RegisterEvents('COMBAT_LOG_EVENT_UNFILTERED')
	end
end

function module.main:UNIT_TARGET(unitID)
	local targetGUID = UnitGUID(unitID.."target")
	if targetGUID and not UnitIsPlayerOrPet(targetGUID) then
		local sourceGUID = UnitGUID(unitID)
		if GetUnitTypeByGUID(sourceGUID) == 0 then
			addSwitch(sourceGUID,targetGUID,GetTime(),2)
		end
		if not fightData.maxHP[targetGUID] then
			fightData.maxHP[targetGUID] = UnitHealthMax(unitID.."target")
		end
	end
end

function module.main:UPDATE_MOUSEOVER_UNIT()
	local sourceGUID = UnitGUID("mouseover")
	if sourceGUID and not fightData.maxHP[sourceGUID] then
		fightData.maxHP[sourceGUID] = UnitHealthMax("mouseover")
		addGUID(sourceGUID,UnitName("mouseover"))
	end
end

local function GlobalRecordStart()
	if not VExRT.BossWatcher.enabled then
		return
	end
	module:UnregisterEvents('PLAYER_REGEN_DISABLED','PLAYER_REGEN_ENABLED','ENCOUNTER_START','ENCOUNTER_END')
	if fightData then
		_BW_End()
	end
	_BW_Start()
	
	print(ExRT.L.BossWatcherRecordStart)
end

local function GlobalRecordEnd()
	if not VExRT.BossWatcher.enabled then
		return
	end
	_BW_End()
	module:RegisterEvents('PLAYER_REGEN_DISABLED','PLAYER_REGEN_ENABLED','ENCOUNTER_START','ENCOUNTER_END')
	print(ExRT.L.BossWatcherRecordStop)
end

function module:slash(arg)
	if arg == "seg" then
		if not fightData or not VExRT.BossWatcher.enabled or VExRT.BossWatcher.Improved then
			return
		end
		StartSegment("SLASH")
		print("New segment")
	elseif arg == "bw s" or arg == "bw start" or arg == "fl s" or arg == "fl start" then
		GlobalRecordStart()
		print( ExRT.F.CreateChatLink("BWGlobalRecordEnd",GlobalRecordEnd,ExRT.L.BossWatcherStopRecord), ExRT.L.BossWatcherStopRecord2 )
	elseif arg == "bw e" or arg == "bw end" or arg == "fl e" or arg == "fl end" then
		GlobalRecordEnd()
	elseif arg == "bw" or arg == "fl" then
		BWInterfaceFrameLoadFunc()
	elseif arg == "bw clear" or arg == "fl clear" then
		VExRT.BossWatcher.SAVED_DATA = nil
		print('Cleared')
	elseif arg == "bw save" or arg == "fl save" then
		VExRT.BossWatcher.saveVariables = true
		VExRT.BossWatcher.SAVED_DATA = module.db.data
		print('Saved')
	elseif arg:find("^bw maxhp ") or arg:find("^fl maxhp ") then
		local unitname = arg:match("^bw maxhp (.+)")
		if not unitname then
			unitname = arg:match("^fl maxhp (.+)")
		end
		if unitname then
			unitname = unitname:lower()
			for GUID,GUIDname in pairs(module.db.data[module.db.nowNum].guids) do
				if GUIDname:lower():find(unitname) then
					local maxhp = module.db.nowData.maxHP[GUID]
					if maxhp then
						print(format("%s's max hp: %d",GUIDname,maxhp))
					end
				end
			end
		end
	end
end
ExRT.F.BWNS = StartSegment

function BWInterfaceFrameLoad()
	if InCombatLockdown() then
		print(ExRT.L.SetErrorInCombat)
		return
	end
	isBWInterfaceFrameLoaded = true
	
	-- Some upvaules
	local ipairs,pairs,tonumber,tostring,format,date,min,sort,table = ipairs,pairs,tonumber,tostring,format,date,min,sort,table
	local GetSpellInfo = GetSpellInfo
	
	local BWInterfaceFrame_Name = 'GExRTBWInterfaceFrame'
	BWInterfaceFrame = CreateFrame('Frame',BWInterfaceFrame_Name,UIParent,"ExRTBWInterfaceFrame")
	BWInterfaceFrame:SetPoint("CENTER",0,0)
	BWInterfaceFrame.HeaderText:SetText(ExRT.L.BossWatcher)
	BWInterfaceFrame.backToInterface:SetText("<<")
	BWInterfaceFrame:SetMovable(true)
	BWInterfaceFrame:RegisterForDrag("LeftButton")
	BWInterfaceFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	BWInterfaceFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	BWInterfaceFrame:SetDontSavePosition(true)

	BWInterfaceFrame.border = ExRT.lib.CreateShadow(BWInterfaceFrame,20)

	BWInterfaceFrame.DecorationLine = CreateFrame("Frame",nil,BWInterfaceFrame)
	BWInterfaceFrame.DecorationLine.texture = BWInterfaceFrame.DecorationLine:CreateTexture(nil, "BACKGROUND")
	BWInterfaceFrame.DecorationLine:SetPoint("TOPLEFT",BWInterfaceFrame,0,-40)
	BWInterfaceFrame.DecorationLine:SetPoint("BOTTOMRIGHT",BWInterfaceFrame,"TOPRIGHT",0,-60)
	BWInterfaceFrame.DecorationLine.texture:SetAllPoints()
	BWInterfaceFrame.DecorationLine.texture:SetTexture(1,1,1,1)
	BWInterfaceFrame.DecorationLine.texture:SetGradientAlpha("VERTICAL",.24,.25,.30,1,.27,.28,.33,1)
				
	BWInterfaceFrame.backToInterface.tooltipText = ExRT.L.BossWatcherBackToInterface
	BWInterfaceFrame.buttonClose.tooltipText = ExRT.L.BossWatcherButtonClose
	
	BWInterfaceFrame:Hide()
	
	BWInterfaceFrame.bossButton:SetText(ExRT.L.BossWatcherLastFight)
	BWInterfaceFrame.bossButton:SetWidth(BWInterfaceFrame.bossButton:GetTextWidth()+30)
	
	local reportData = {{},{},{},{ {},{},{} },{},{},{},{},{}}
	local reportOptions = {}
	BWInterfaceFrame.report = ExRT.lib.CreateButton(BWInterfaceFrame,150,18,nil,0,0,ExRT.L.BossWatcherCreateReport,nil,ExRT.L.BossWatcherCreateReport,"ExRTButtonTransparentTemplate")
	ExRT.lib.SetPoint(BWInterfaceFrame.report,"TOPRIGHT",BWInterfaceFrame,"TOPRIGHT",-4,-18)
	BWInterfaceFrame.report:SetScript("OnClick",function ()
		local activeTab = BWInterfaceFrame.tab.selected	
			
		---Tab with mobs fix
		if activeTab == 4 then
			local activeTabOnPage = BWInterfaceFrame.tab.tabs[4].infoTabs.selected
			ExRT.F.toChatWindow(reportData[4][activeTabOnPage])
			return		
		end
		
		ExRT.F.toChatWindow(reportData[activeTab],nil,reportOptions[activeTab])
	end)
	BWInterfaceFrame.report:Hide()
	
	
	---- Some updates
	for i=5,#module.db.buffsFilters do
		for _,sID in ipairs(module.db.buffsFilters[i][-2]) do
			module.db.buffsFilters[i][sID] = true
		end
	end
	
	
	---- Helpful functions
	local function GetGUID(GUID)
		if GUID and module.db.data[module.db.nowNum].guids[GUID] and module.db.data[module.db.nowNum].guids[GUID] ~= "nil" then
			return module.db.data[module.db.nowNum].guids[GUID]
		else
			return ExRT.L.BossWatcherUnknown
		end
	end
	
	local function GetPetsDB()
		return module.db.data[module.db.nowNum].pets
	end
	
	local function CloseDropDownMenus_fix()
		CloseDropDownMenus()
	end
	
	local function timestampToFightTime(time)
		if not time then
			return 0
		end
		local fixTable = module.db.data[module.db.nowNum].timeFix
		if not fixTable and module.db.timeFix then
			fixTable = module.db.timeFix
		elseif not fixTable and not module.db.timeFix then
			return 0
		end
		local res = time - (fixTable[2] - fixTable[1] + module.db.data[module.db.nowNum].encounterStart) 
		return max(res,0)
	end
	
	local function GUIDtoText(patt,GUID)
		if VExRT.BossWatcher.GUIDs and GUID and GUID ~= "" then
			patt = patt or "%s"
			local _type = ExRT.F.GetUnitTypeByGUID(GUID)
			if _type == 0 then
				return ""
			elseif _type == 3 or _type == 5 then
				local mobSpawnID = nil
				local spawnID = GUID:match("%-([^%-]+)$")
				if spawnID then
					mobSpawnID = tonumber(spawnID, 16)
				end
				if mobSpawnID then
					return format(patt,tostring(mobSpawnID))
				else
					return format(patt,GUID)
				end
			else
				return format(patt,GUID)
			end
		else
			return ""
		end
	end
	
	local function TimeLineShowSpellID(spellid)
		if VExRT.BossWatcher.timeLineSpellID then
			return " ["..spellid.."]"
		else
			return ""
		end
	end
	
	local function SetSchoolColorsToLine(self,school)
		local isNotGradient = ExRT.F.table_find(module.db.schoolsDefault,school) or school == 0
		if isNotGradient then
			self:SetVertexColor(module.db.schoolsColors[school].r,module.db.schoolsColors[school].g,module.db.schoolsColors[school].b, 1)
		else
			if module.db.schoolsColors[school] then
				self:SetVertexColor(module.db.schoolsColors[school].r,module.db.schoolsColors[school].g,module.db.schoolsColors[school].b,1)
			else
				local school1,school2 = nil
				for i=1,#module.db.schoolsDefault do
					local isSchool = bit.band(school,module.db.schoolsDefault[i]) > 0
					if isSchool and not school1 then
						school1 = module.db.schoolsDefault[i]
					elseif isSchool and not school2 then
						school2 = module.db.schoolsDefault[i]
					end
				end
				if school1 and school2 then
					self:SetVertexColor(1,1,1,1)
					self:SetGradientAlpha("HORIZONTAL", module.db.schoolsColors[school1].r,module.db.schoolsColors[school1].g,module.db.schoolsColors[school1].b,1,module.db.schoolsColors[school2].r,module.db.schoolsColors[school2].g,module.db.schoolsColors[school2].b,1)
				elseif school1 and not school2 then
					self:SetVertexColor(module.db.schoolsColors[school1].r,module.db.schoolsColors[school1].g,module.db.schoolsColors[school1].b, 1)
				else
					self:SetVertexColor(0.8,0.8,0.8, 1)
				end
			end
		end
	end
	local function GetSchoolName(school)
		if not school or module.db.schoolsNames[school]	then
			return  module.db.schoolsNames[school or 0]
		else
			local school1,school2 = nil
			for i=1,#module.db.schoolsDefault do
				local isSchool = bit.band(school,module.db.schoolsDefault[i]) > 0
				if isSchool and not school1 then
					school1 = module.db.schoolsDefault[i]
				elseif isSchool and not school2 then
					school2 = module.db.schoolsDefault[i]
				end
			end
			if school1 and school2 then
				return module.db.schoolsNames[school1] .. "-" .. module.db.schoolsNames[school2]
			elseif school1 and not school2 then
				return module.db.schoolsNames[school1]
			else
				return module.db.schoolsNames[0]
			end
		end
	end
	local function GetUnitInfoByUnitFlagFix(unitFlag,infoType)
		if not unitFlag then
			return
		end
		return GetUnitInfoByUnitFlag(unitFlag,infoType)
	end
	local function GetFightLength()
		if BWInterfaceFrame.nowFightID ~= BWInterfaceFrame.tab.tabs[10].lastFightID then
			return (module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart)
		end
		local length = 0
		for i=1,#module.db.data[module.db.nowNum].fight do
			if BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] then
				length = length + ( module.db.data[module.db.nowNum].fight[i+1] and module.db.data[module.db.nowNum].fight[i+1].timeEx or module.db.data[module.db.nowNum].encounterEnd ) - module.db.data[module.db.nowNum].fight[i].timeEx
			end
		end
		return length
	end
	local function SubUTF8String(str,len)
		local strlen = ExRT.F:utf8len(str)
		if strlen > len then
			str = ExRT.F:utf8sub(str,1,len) .. "..."
		end
		return str
	end

	
	---- Bugfix functions
	local _GetSpellLink = GetSpellLink
	local function GetSpellLink(spellID)
		local link = _GetSpellLink(spellID)
		if link then
			return link
		end
		local spellName = GetSpellInfo(spellID)
		return spellName or "Unk"
	end
	
	---- Update functions
	local function ClearAndReloadData(isSegmentReload)
		module.db.nowData = {
			damage = {},
			damage_seen = {},
			heal = {},
			switch = {},
			cast = {},
			interrupts = {},
			dispels = {},
			auras = {},
			power = {},
			dies = {},
			chat = {},
			resurrests = {},
			deathLog = {},
			maxHP = {},
		}
		if not module.db.data[module.db.nowNum] or isSegmentReload then
			return
		end
		for i=1,#module.db.data[module.db.nowNum].fight do
			AddSegmentToData(i)
		end
	end
	
	BWInterfaceFrame:SetScript("OnShow",function (self)
		if self.nowFightID ~= module.db.data[module.db.nowNum].fightID then
			if module.db.data[module.db.nowNum].encounterEnd == 0 then
				print(ExRT.L.BossWatcherCombatError)
				return
			end
			ClearAndReloadData()
			self.nowFightID = module.db.data[module.db.nowNum].fightID
			local _time = (module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart)
			self.bossButton:SetText( (module.db.data[module.db.nowNum].encounterName or ExRT.L.BossWatcherLastFight)..date(": %H:%M - ", module.db.data[module.db.nowNum].encounterStartGlobal )..date("%H:%M", module.db.data[module.db.nowNum].encounterStartGlobal + _time )..format(" (%dm%02ds)",floor(_time/60),_time%60 ) )
			self.bossButton:SetWidth(self.bossButton:GetTextWidth()+30)
			for i=1,#reportData do
				if i ~= 4 then
					wipe(reportData[i])
				else
					wipe(reportData[4][1])
					wipe(reportData[4][2])
					wipe(reportData[4][3])
				end
			end
			self:Hide()
			self:Show()
		end
	end)
	
	BWInterfaceFrame.bossButtonDropDown = CreateFrame("Frame", BWInterfaceFrame_Name.."BossButtonDropDown", nil, "UIDropDownMenuTemplate")
	BWInterfaceFrame.bossButton:SetScript("OnClick",function (self)
		local fightsList = {
			{
				text = ExRT.L.BossWatcherSelectFight, 
				isTitle = true, 
				notCheckable = true, 
				notClickable = true 
			},
		}
		for i=1,#module.db.data do
			local colorCode = ""
			if i == module.db.nowNum then
				colorCode = "|cff00ff00"
			end
			local _time = module.db.data[i].encounterEnd - module.db.data[i].encounterStart
			fightsList[#fightsList + 1] = {
				text = i..". "..colorCode..(module.db.data[i].encounterName or ExRT.L.BossWatcherLastFight)..date(": %H:%M - ", module.db.data[i].encounterStartGlobal )..date("%H:%M", module.db.data[i].encounterStartGlobal + _time )..format(" (%dm%02ds)",floor(_time/60),_time%60 ),
				notCheckable = true,
				func = function() 
					module.db.nowNum = i
					self:SetText( (module.db.data[i].encounterName or ExRT.L.BossWatcherLastFight)..date(": %H:%M - ", module.db.data[i].encounterStartGlobal )..date("%H:%M", module.db.data[i].encounterStartGlobal + _time )..format(" (%dm%02ds)",floor(_time/60),_time%60 ) )
					self:SetWidth(self:GetTextWidth()+30)
					BWInterfaceFrame:Hide()
					BWInterfaceFrame:Show()
				end,
			}
		end
		fightsList[#fightsList + 1] = {
			text = ExRT.L.BossWatcherSelectFightClose,
			notCheckable = true,
			func = CloseDropDownMenus_fix,
		}
		EasyMenu(fightsList, BWInterfaceFrame.bossButtonDropDown, "cursor", 10 , -15, "MENU")
	end)
	BWInterfaceFrame.bossButton.tooltipText = ExRT.L.BossWatcherSelectFight
	
	
	---- Tabs
	BWInterfaceFrame.tab = ExRT.lib.CreateTabFrameTemplate(BWInterfaceFrame,865,600,0,0,"ExRTTabButtonTransparentTemplate",11,1,ExRT.L.BossWatcherTabMobs,ExRT.L.BossWatcherTabHeal,ExRT.L.BossWatcherTabBuffsAndDebuffs,ExRT.L.BossWatcherTabEnemy,ExRT.L.BossWatcherTabPlayersSpells,ExRT.L.BossWatcherTabEnergy,ExRT.L.BossWatcherTabInterruptAndDispelShort,ExRT.L.BossWatcherTabGraphics,ExRT.L.BossWatcherDeath,ExRT.L.BossWatcherSegments,ExRT.L.BossWatcherTabSettings)
	ExRT.lib.SetPoint(BWInterfaceFrame.tab,"TOP",BWInterfaceFrame,0,-60)	

	BWInterfaceFrame.tab.tabs[7].button.tooltip = ExRT.L.BossWatcherTabInterruptAndDispel
	BWInterfaceFrame.tab:SetBackdropBorderColor(0,0,0,0)
	BWInterfaceFrame.tab:SetBackdropColor(0,0,0,0)
	
	
	---- Settings tab-button
	BWInterfaceFrame.tab.tabs[11]:SetScript("OnShow",function (self)
		if not module.options.isLoaded then
			if InCombatLockdown() then
				print(ExRT.L.SetErrorInCombat)
				return
			end
			module.options:Load()
			module.options:SetScript("OnShow",nil)
			module.options.isLoaded = true
		end
		module.options:SetParent(self)
		module.options:ClearAllPoints()
		module.options:SetAllPoints(self)
		module.options:Show()
	end)
	
	---- Locals for functions in code below
	local SegmentsPage_ImprovedSelect,SegmentsPage_UpdateTextures = nil
	
		

	---- TimeLine Frame
	BWInterfaceFrame.timeLineFrame = CreateFrame('Frame',nil,BWInterfaceFrame.tab)
	BWInterfaceFrame.timeLineFrame.width = 858
	BWInterfaceFrame.timeLineFrame:SetSize(BWInterfaceFrame.timeLineFrame.width,60)
	
	local TimeLine_Pieces = 60
	local function TimeLinePieceOnEnter(self)
		if self.tooltip and #self.tooltip > 0 then
			ExRT.lib.TooltipShow(self,"ANCHOR_RIGHT",ExRT.L.BossWatcherTimeLineTooltipTitle..":",unpack(self.tooltip))
		end
	end
	BWInterfaceFrame.timeLineFrame.timeLine = CreateFrame("Frame",nil,BWInterfaceFrame.timeLineFrame)
	BWInterfaceFrame.timeLineFrame.timeLine:SetSize(BWInterfaceFrame.timeLineFrame.width,30)
	BWInterfaceFrame.timeLineFrame.timeLine:SetPoint("TOP",0,0)
	do
		local tlWidth = BWInterfaceFrame.timeLineFrame.width/TimeLine_Pieces
		for i=1,TimeLine_Pieces do
			BWInterfaceFrame.timeLineFrame.timeLine[i] = CreateFrame("Frame","ExRT_FightLog_TimeLine"..i,BWInterfaceFrame.timeLineFrame.timeLine)	--FrameStack Fix
			BWInterfaceFrame.timeLineFrame.timeLine[i]:SetSize(tlWidth,30)
			BWInterfaceFrame.timeLineFrame.timeLine[i]:SetPoint("TOPLEFT",(i-1)*tlWidth,0)
			BWInterfaceFrame.timeLineFrame.timeLine[i]:SetScript("OnEnter",TimeLinePieceOnEnter)
			BWInterfaceFrame.timeLineFrame.timeLine[i]:SetScript("OnLeave",ExRT.lib.TooltipHide)
		end
	end
	BWInterfaceFrame.timeLineFrame.timeLine.texture = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND",nil,0)
	--BWInterfaceFrame.timeLineFrame.timeLine.texture:SetTexture("Interface\\AddOns\\ExRT\\media\\bar9.tga")
	--BWInterfaceFrame.timeLineFrame.timeLine.texture:SetVertexColor(0.3, 1, 0.3, 1)
	BWInterfaceFrame.timeLineFrame.timeLine.texture:SetTexture(1, 1, 1, 1)
	BWInterfaceFrame.timeLineFrame.timeLine.texture:SetGradientAlpha("VERTICAL",1,0.82,0,.7,0.95,0.65,0,.7)
	BWInterfaceFrame.timeLineFrame.timeLine.texture:SetAllPoints()
	
	BWInterfaceFrame.timeLineFrame.timeLine.textLeft = ExRT.lib.CreateText(BWInterfaceFrame.timeLineFrame.timeLine,200,16,nil,0,0,"LEFT","TOP",nil,12,"",nil,1,1,1,1)
	ExRT.lib.SetPoint(BWInterfaceFrame.timeLineFrame.timeLine.textLeft,"BOTTOMLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"BOTTOMLEFT", 2, 2)
	
	BWInterfaceFrame.timeLineFrame.timeLine.textCenter = ExRT.lib.CreateText(BWInterfaceFrame.timeLineFrame.timeLine,200,16,nil,0,0,"CENTER","TOP",nil,12,"",nil,1,1,1,1)
	ExRT.lib.SetPoint(BWInterfaceFrame.timeLineFrame.timeLine.textCenter,"BOTTOM",BWInterfaceFrame.timeLineFrame.timeLine,"BOTTOM", 0, 2)
	
	BWInterfaceFrame.timeLineFrame.timeLine.textRight = ExRT.lib.CreateText(BWInterfaceFrame.timeLineFrame.timeLine,200,16,nil,0,0,"RIGHT","TOP",nil,12,"",nil,1,1,1,1)
	ExRT.lib.SetPoint(BWInterfaceFrame.timeLineFrame.timeLine.textRight,"BOTTOMRIGHT",BWInterfaceFrame.timeLineFrame.timeLine,"BOTTOMRIGHT", -2, 2)
	
	BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND")
	BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine:SetTexture(1,1,1,1)
	BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine:SetGradientAlpha("VERTICAL", 1,0.2,0.2, 0, 1,0.2,0.2, 0.7)
	BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine._SetPoint = BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine.SetPoint
	BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine.SetPoint = function(self,_start,_end)
		self:ClearAllPoints()
		self:_SetPoint("TOPLEFT",self:GetParent(),"BOTTOMLEFT",_start*BWInterfaceFrame.timeLineFrame.width,0)
		self:SetSize((_end-_start)*BWInterfaceFrame.timeLineFrame.width,16)
		self:Show()
	end
	
	BWInterfaceFrame.timeLineFrame.timeLine.arrow = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND")
	BWInterfaceFrame.timeLineFrame.timeLine.arrow:SetTexture("Interface\\CURSOR\\Quest")
	BWInterfaceFrame.timeLineFrame.timeLine.arrow:Hide()

	BWInterfaceFrame.timeLineFrame.timeLine.arrowNow = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND")
	BWInterfaceFrame.timeLineFrame.timeLine.arrowNow:SetTexture("Interface\\CURSOR\\Inspect")	
	BWInterfaceFrame.timeLineFrame.timeLine.arrowNow:Hide()
	
	BWInterfaceFrame.timeLineFrame.timeLine.redLine = {}
	local function CreateRedLine(i)
		BWInterfaceFrame.timeLineFrame.timeLine.redLine[i] = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND",nil,5)
		BWInterfaceFrame.timeLineFrame.timeLine.redLine[i]:SetTexture(0.7, 0.1, 0.1, 0.5)
		BWInterfaceFrame.timeLineFrame.timeLine.redLine[i]:SetSize(2,30)
	end
	
	BWInterfaceFrame.timeLineFrame.timeLine.blueLine = {}
	local function CreateBlueLine(i)
		BWInterfaceFrame.timeLineFrame.timeLine.blueLine[i] = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND",nil,6)
		BWInterfaceFrame.timeLineFrame.timeLine.blueLine[i]:SetTexture(0.1, 0.1, 0.7, 0.5)
		BWInterfaceFrame.timeLineFrame.timeLine.blueLine[i]:SetSize(3,30)
	end
	
	local function UpdateTimeLine()
		local fight_dur = module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart
		BWInterfaceFrame.timeLineFrame.timeLine.textLeft:SetText( date("%H:%M:%S", module.db.data[module.db.nowNum].encounterStartGlobal) )
		BWInterfaceFrame.timeLineFrame.timeLine.textRight:SetText( date("%M:%S", fight_dur) )
		BWInterfaceFrame.timeLineFrame.timeLine.textCenter:SetText( date("%M:%S", fight_dur / 2) )
		
		if module.db.data[module.db.nowNum].improved then
			BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:Show()
			for i=1,TimeLine_Pieces do
				BWInterfaceFrame.timeLineFrame.timeLine[i]:Hide()
			end
		else
			BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:Hide()
			for i=1,TimeLine_Pieces do
				BWInterfaceFrame.timeLineFrame.timeLine[i]:Show()
			end
		end

		local redLineNum = 0
		for i=1,TimeLine_Pieces do
			if not BWInterfaceFrame.timeLineFrame.timeLine[i].tooltip then
				BWInterfaceFrame.timeLineFrame.timeLine[i].tooltip = {}
			end
			wipe(BWInterfaceFrame.timeLineFrame.timeLine[i].tooltip)
		end
		local addToToolipTable = {}
		for mobGUID,mobData in pairs(module.db.nowData.cast) do
			--if ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[mobGUID],2) == 512 then
			local UnitFlag = module.db.data[module.db.nowNum].reaction[mobGUID]
			if UnitFlag and ExRT.F.GetUnitInfoByUnitFlag(UnitFlag,3) == 64 then
				for i=1,#mobData do
					local _time = timestampToFightTime(mobData[i][1])
					
					local tooltipIndex = _time / fight_dur
					
					redLineNum = redLineNum + 1
					if not BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum] then
						CreateRedLine(redLineNum)
					end
					BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum]:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"TOPLEFT",BWInterfaceFrame.timeLineFrame.width*tooltipIndex,0)
					BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum]:Show()
					
					tooltipIndex = min( floor( (TimeLine_Pieces - 0.01)*tooltipIndex + 1 ) , TimeLine_Pieces)
					
					local spellName,_,spellTexture = GetSpellInfo(mobData[i][2])
					
					local targetInfo = ""
					if mobData[i][4] and mobData[i][4] ~= "" then
						targetInfo = " "..ExRT.L.BossWatcherTimeLineOnText.." |c"..ExRT.F.classColorByGUID(mobData[i][4])..GetGUID(mobData[i][4]).."|r"
					end
					
					addToToolipTable[#addToToolipTable + 1] = {tooltipIndex,_time,"[" .. date("%M:%S", _time )  .. "] |c"..ExRT.F.classColorByGUID(mobGUID) .. GetGUID(mobGUID) .."|r" .. GUIDtoText("(%s)",mobGUID) .. ( mobData[i][3] == 1 and " "..ExRT.L.BossWatcherTimeLineCast.." " or " "..ExRT.L.BossWatcherTimeLineCastStart.." " ) .. format("%s%s%s",spellTexture and "|T"..spellTexture..":0|t " or "",spellName or "???",TimeLineShowSpellID(mobData[i][2])) .. targetInfo }
				end
			end
		end
		for _,chatData in ipairs(module.db.nowData.chat) do
			local _time = min( max(chatData[4] - module.db.data[module.db.nowNum].encounterStart,0) , module.db.data[module.db.nowNum].encounterEnd)
			
			local tooltipIndex = _time / fight_dur
			redLineNum = redLineNum + 1
			if not BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum] then
				CreateRedLine(redLineNum)
			end
			BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum]:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"TOPLEFT",BWInterfaceFrame.timeLineFrame.width*tooltipIndex,0)
			BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum]:Show()
			
			tooltipIndex = min( floor( (TimeLine_Pieces - 0.01)*tooltipIndex + 1 ) , TimeLine_Pieces)
			
			local spellName,_,spellTexture = GetSpellInfo(chatData[3])
						
			addToToolipTable[#addToToolipTable + 1] = {tooltipIndex,_time,"[" .. date("%M:%S", _time )  .. "] "..  ExRT.L.BossWatcherChatSpellMsg .. " " .. format("%s%s%s",spellTexture and "|T"..spellTexture..":0|t " or "",spellName or "???",TimeLineShowSpellID(chatData[3])) }
		end
		for _,resData in ipairs(module.db.nowData.resurrests) do
			local _time = timestampToFightTime(resData[4])
			
			local tooltipIndex = _time / fight_dur
			redLineNum = redLineNum + 1
			if not BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum] then
				CreateRedLine(redLineNum)
			end
			BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum]:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"TOPLEFT",BWInterfaceFrame.timeLineFrame.width*tooltipIndex,0)
			BWInterfaceFrame.timeLineFrame.timeLine.redLine[redLineNum]:Show()
			
			tooltipIndex = min( floor( (TimeLine_Pieces - 0.01)*tooltipIndex + 1 ) , TimeLine_Pieces)
			local spellName,_,spellTexture = GetSpellInfo(resData[3])
			
			addToToolipTable[#addToToolipTable + 1] = {tooltipIndex,_time,"[" .. date("%M:%S", _time )  .. "] |c"..ExRT.F.classColorByGUID(resData[1]) .. GetGUID(resData[1]) .."|r" ..  GUIDtoText("(%s)",resData[1]) .. " ".. ExRT.L.BossWatcherTimeLineCast.. " " .. format("%s%s%s",spellTexture and "|T"..spellTexture..":0|t " or "",spellName or "???",TimeLineShowSpellID(resData[3])) .. " "..ExRT.L.BossWatcherTimeLineOnText.." |c"..ExRT.F.classColorByGUID(resData[2])..GetGUID(resData[2]).."|r" }
		end
		for i=(redLineNum+1),#BWInterfaceFrame.timeLineFrame.timeLine.redLine do
			BWInterfaceFrame.timeLineFrame.timeLine.redLine[i]:Hide()
		end
		
		local blueLineNum = 0
		for i=1,#module.db.nowData.dies do
			if ExRT.F.GetUnitInfoByUnitFlag(module.db.nowData.dies[i][2],1) == 1024 then
				local _time = timestampToFightTime(module.db.nowData.dies[i][3])
				
				local tooltipIndex = _time / fight_dur
				
				blueLineNum = blueLineNum + 1
				if not BWInterfaceFrame.timeLineFrame.timeLine.blueLine[blueLineNum] then
					CreateBlueLine(blueLineNum)
				end
				BWInterfaceFrame.timeLineFrame.timeLine.blueLine[blueLineNum]:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"TOPLEFT",BWInterfaceFrame.timeLineFrame.width*tooltipIndex,0)
				BWInterfaceFrame.timeLineFrame.timeLine.blueLine[blueLineNum]:Show()
				
				tooltipIndex = min ( floor( (TimeLine_Pieces - 0.01)*tooltipIndex + 1 ) , TimeLine_Pieces)
				
				addToToolipTable[#addToToolipTable + 1] = {tooltipIndex,_time,"[" .. date("%M:%S", _time )  .. "] |cffee5555" .. GetGUID(module.db.nowData.dies[i][1]) .. GUIDtoText("(%s)",module.db.nowData.dies[i][1])  .. " "..ExRT.L.BossWatcherTimeLineDies.."|r"}
			end
		end
		for i=(blueLineNum+1),#BWInterfaceFrame.timeLineFrame.timeLine.blueLine do
			BWInterfaceFrame.timeLineFrame.timeLine.blueLine[i]:Hide()
		end
		
		table.sort(addToToolipTable,function (a,b) return a[2] < b[2] end)
		for i=1,#addToToolipTable do
			table.insert(BWInterfaceFrame.timeLineFrame.timeLine[ addToToolipTable[i][1] ].tooltip,{addToToolipTable[i][3],1,1,1})
		end
		
		SegmentsPage_UpdateTextures()
	end
	
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment = CreateFrame("Button",nil,BWInterfaceFrame.timeLineFrame.timeLine)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:SetAllPoints()
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:Hide()
	
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom = CreateFrame("Button",nil,BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom:SetSize(200,13)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom:SetPoint("TOPRIGHT",BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment,"BOTTOMRIGHT",-1,4)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom.Text = ExRT.lib.CreateText(BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom,200,13,"RIGHT",0,0,"RIGHT","TOP",nil,11,"["..ExRT.L.BossWatcherGraphZoomReset.."]",nil,1,1,1,nil,1)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom:SetWidth( BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom.Text:GetStringWidth() )
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom:SetScript("OnClick",function (self)
		SegmentsPage_ImprovedSelect()
		self:Hide()
	end)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom:Hide()
	
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.hoverTime = ExRT.lib.CreateText(BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment,200,16,nil,0,0,"CENTER","TOP",nil,11,"",nil,1,1,1,nil,1)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.hoverTime:ClearAllPoints()
	
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.Texture = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND",nil,2)
	--BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.Texture:SetTexture("Interface\\AddOns\\ExRT\\media\\bar9.tga")
	--BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.Texture:SetVertexColor(0, 0.65, 0.9, .7)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.Texture:SetTexture(1, 1, 1, 1)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.Texture:SetGradientAlpha("VERTICAL",0.3,0.75,0.90,.7,0,0.62,0.90,.7)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.Texture:SetHeight(30)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.Texture:Hide()
	
	local function TimeLineFrame_ImprovedSelectSegment_GetSelected(self)
		local fightDuration = (module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart)
		local timeLineWidth = self:GetWidth()
		local start = ExRT.F.Round(self.mouseDowned / timeLineWidth * fightDuration)
		local ending = ExRT.F.Round(ExRT.F.GetCursorPos(self) / timeLineWidth * fightDuration)
		
		return start,ending
	end
	local function TimeLineFrame_ImprovedSelectSegment_OnUpdate(self)
		if not MouseIsOver(self) then
			self:SetScript("OnUpdate",nil)
			self.Texture:Hide()
			self.mouseDowned = nil
			ExRT.lib.TooltipHide()
			return
		end
		local x = ExRT.F.GetCursorPos(self)
		local width = x - self.mouseDowned
		if width > 0 then
			self.Texture:SetWidth(width)
			self.Texture:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"TOPLEFT", self.mouseDowned ,0)
			
			local start,ending = TimeLineFrame_ImprovedSelectSegment_GetSelected(self)
			
			ExRT.lib.TooltipShow(self,"ANCHOR_CURSOR",format("%d:%02d - %d:%02d",start / 60,start % 60,ending / 60,ending % 60))
		elseif width < 0 then
			width = -width
			self.Texture:SetWidth(width)
			self.Texture:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"TOPLEFT", self.mouseDowned-width,0)
			
			local start,ending = TimeLineFrame_ImprovedSelectSegment_GetSelected(self)
			ExRT.lib.TooltipShow(self,"ANCHOR_CURSOR",format("%d:%02d - %d:%02d",ending / 60,ending % 60,start / 60,start % 60))
		else
			self.Texture:SetWidth(1)
			ExRT.lib.TooltipHide()
		end
	end
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:SetScript("OnMouseDown",function (self)
		self.mouseDowned = ExRT.F.GetCursorPos(self)
		self.Texture:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"TOPLEFT", self.mouseDowned ,0)
		self.Texture:SetWidth(1)
		self.Texture:Show()
		self:SetScript("OnUpdate",TimeLineFrame_ImprovedSelectSegment_OnUpdate)
		self.hoverTime:Hide()
	end)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:SetScript("OnMouseUp",function (self)
		self:SetScript("OnUpdate",nil)
		self.Texture:Hide()
		ExRT.lib.TooltipHide()
		if not self.mouseDowned then
			return
		end
		local start,ending = TimeLineFrame_ImprovedSelectSegment_GetSelected(self)
		self.mouseDowned = nil
		if ending < start then
			start,ending = ending,start
		end
		start = start + 1
		ending = ending + 1
		SegmentsPage_ImprovedSelect(start,ending,nil,IsShiftKeyDown())
	end)
	
	local function TimeLineFrame_ImprovedSelectSegment_OnUpdate_Passive(self)
		local timeLineWidth = self:GetWidth()
		local fightDuration = (module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart)
		local x = ExRT.F.GetCursorPos(self)
		local time = ExRT.F.Round(x / timeLineWidth * fightDuration)
		self.hoverTime:SetFormattedText("%d:%02d",time / 60,time % 60)
		self.hoverTime:SetPoint("TOP",self,"TOPLEFT",x,-2)
		self.hoverTime:Show()
		local segmentNow = ceil(x / timeLineWidth * 60  + 0.01)
		if segmentNow ~= self.lastSegment then
			self.lastSegment = segmentNow
			ExRT.lib.TooltipHide()
		else
			return
		end
		local frame = BWInterfaceFrame.timeLineFrame.timeLine[segmentNow]
		if frame then
			TimeLinePieceOnEnter(frame)
		end
	end
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:SetScript("OnEnter",function (self)
		self.lastSegment = nil
		self:SetScript("OnUpdate",TimeLineFrame_ImprovedSelectSegment_OnUpdate_Passive)
	end)
	BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment:SetScript("OnLeave",function (self)
		self.hoverTime:Hide()
		if self.mouseDowned then
			return
		end
		ExRT.lib.TooltipHide()
		self:SetScript("OnUpdate",nil)
	end)
			
	BWInterfaceFrame.timeLineFrame:SetScript("OnShow",function (self)
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			UpdateTimeLine()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)

	
	
	local tab,tabName = nil
	---- Damage Tab
	tab = BWInterfaceFrame.tab.tabs[1]
	tabName = BWInterfaceFrame_Name.."DamageTab"
	
	local sourceVar,destVar = {},{}
	local DamageTab_SetLine = nil
	local DamageShowAll = false
	local Damage_Last_Func = nil
	local Damage_Last_doEnemy = nil
	
	local function DamageTab_GetGUIDsReport(list,isDest)
		local result = ""
		for GUID,_ in pairs(list) do
			if result ~= "" then
				result = result..", "
			end
			local time = ""
			if isDest and ExRT.F.GetUnitTypeByGUID(GUID) ~= 0 and module.db.nowData.damage_seen[GUID] then
				time = date(" (%M:%S)", timestampToFightTime( module.db.nowData.damage_seen[GUID] ))
			end
			result = result .. GetGUID(GUID) .. time
		end
		if result ~= "" then
			return result
		end
	end
	local function DamageTab_UpdateDropDown(arr,dropDown)
		local count = ExRT.F.table_len(arr)
		if count == 0 then
			dropDown:SetText(ExRT.L.BossWatcherAll)
		elseif count == 1 then
			local GUID = nil
			for g,_ in pairs(arr) do
				GUID = g
			end
			local name = GetGUID(GUID)
			local flags = module.db.data[module.db.nowNum].reaction[GUID]
			local isPlayer = ExRT.F.GetUnitInfoByUnitFlag(flags,1) == 1024
			local isNPC = ExRT.F.GetUnitInfoByUnitFlag(flags,2) == 512
			if isPlayer then
				name = "|c"..ExRT.F.classColorByGUID(GUID)..name
			elseif isNPC then
				name = name .. date(" %M:%S", timestampToFightTime( module.db.nowData.damage_seen[GUID] )) .. GUIDtoText(" [%s]",GUID)
			end
			dropDown:SetText(name)
		else
			dropDown:SetText(ExRT.L.BossWatcherSeveral)
		end
	end
	
	local function DamageTab_UpdateDropDownSource()
		DamageTab_UpdateDropDown(sourceVar,BWInterfaceFrame.tab.tabs[1].sourceDropDown)
	end
	local function DamageTab_UpdateDropDownDest()
		DamageTab_UpdateDropDown(destVar,BWInterfaceFrame.tab.tabs[1].targetDropDown)
	end

	local DamageTab_UpdateDropDownType = nil
	do
		local dropDownNames = {
			{ExRT.L.BossWatcherDamageDamageDone,ExRT.L.BossWatcherDamageDamageTakenByEnemy,ExRT.L.BossWatcherDamageDamageDoneBySpell,ExRT.L.BossWatcherDamageDamageSpellToHostile},
			{ExRT.L.BossWatcherDamageDamageTaken,ExRT.L.BossWatcherDamageDamageTakenByPlayers,ExRT.L.BossWatcherDamageDamageTakenBySpell,ExRT.L.BossWatcherDamageDamageSpellToFriendly},
		}
		function DamageTab_UpdateDropDownType(type,doEnemy)
			local isEnemy = doEnemy and 1 or 2
			BWInterfaceFrame.tab.tabs[1].typeDropDown:SetText(dropDownNames[isEnemy][type])
		end
	end
	local function DamageTab_Temp_SortingBy2Param(a,b)
		return a[2] > b[2]
	end
			
	local function DamageTab_UpdateLinesPlayers(doEnemy)
		DamageTab_UpdateDropDownSource()
		DamageTab_UpdateDropDownDest()
		DamageTab_UpdateDropDownType(1,doEnemy)
		Damage_Last_Func = DamageTab_UpdateLinesPlayers
		Damage_Last_doEnemy = doEnemy
		local damage = {}
		local total = 0
		local totalOver = 0
		for destGUID,destData in pairs(module.db.nowData.damage) do
			if ExRT.F.table_len(destVar) == 0 or destVar[destGUID] then
				local isEnemy = false
				if ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[destGUID],2) == 512 then
					isEnemy = true
				end
				local mobID = ExRT.F.GUIDtoID(destGUID)
				for sourceGUID,sourceData in pairs(destData) do
					local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
					if owner then
						sourceGUID = owner
					end
					if ExRT.F.table_len(sourceVar) == 0 or sourceVar[sourceGUID] then
						if (isEnemy and doEnemy) or (not isEnemy and not doEnemy) then
							local inDamagePos = ExRT.F.table_find(damage,sourceGUID,1)
							if not inDamagePos then
								inDamagePos = #damage + 1
								damage[inDamagePos] = {sourceGUID,0,0,0,0,0,0,{}}
							end
							local destPos = ExRT.F.table_find(damage[inDamagePos][8],destGUID,1)
							if not destPos then
								destPos = #damage[inDamagePos][8] + 1
								damage[inDamagePos][8][destPos] = {destGUID,0}
							end
							destPos = damage[inDamagePos][8][destPos]
							for spellID,spellAmount in pairs(sourceData) do
								damage[inDamagePos][2] = damage[inDamagePos][2] + spellAmount.amount - spellAmount.overkill
								damage[inDamagePos][3] = damage[inDamagePos][3] + spellAmount.overkill	--overkill
								damage[inDamagePos][4] = damage[inDamagePos][4] + spellAmount.blocked	--blocked
								damage[inDamagePos][5] = damage[inDamagePos][5] + spellAmount.absorbed	--absorbed
								damage[inDamagePos][6] = damage[inDamagePos][6] + spellAmount.crit	--crit
								damage[inDamagePos][7] = damage[inDamagePos][7] + spellAmount.ms	--ms
								total = total + spellAmount.amount - spellAmount.overkill
								totalOver = totalOver + spellAmount.overkill + spellAmount.blocked + spellAmount.absorbed
								
								destPos[2] = destPos[2] + spellAmount.amount + (DamageShowAll and (spellAmount.blocked+spellAmount.absorbed) or -spellAmount.overkill)
								
								if mobID == 76933 then	--Mage T100 fix
									local multiplier = VExRT.BossWatcher.divisionPrismatic and 0 or 1
									damage[inDamagePos][2] = damage[inDamagePos][2] - spellAmount.amount
									damage[inDamagePos][3] = damage[inDamagePos][3] + (spellAmount.amount * multiplier)
									total = total - spellAmount.amount
									totalOver = totalOver + (spellAmount.amount * multiplier)
								end
							end
						end
					end
				end
			end
		end
		local totalIsFull = 1
		total = max(total,1)
		if total == 1 and #damage == 0 then
			total = 0
			totalIsFull = 0
		end
		
		local _max = nil
		reportOptions[1] = ExRT.L.BossWatcherReportDPS
		wipe(reportData[1])
		reportData[1][1] = (DamageTab_GetGUIDsReport(sourceVar) or ExRT.L.BossWatcherAllSources).." > "..(DamageTab_GetGUIDsReport(destVar,true) or ExRT.L.BossWatcherAllTargets)
		local activeFightLength = GetFightLength()
		if not DamageShowAll then
			local dps = total / activeFightLength
			reportData[1][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total).."@1@ ("..floor(dps)..")@1#"
			sort(damage,function(a,b) return a[2]>b[2] end)
			_max = damage[1] and damage[1][2] or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total,dps)
		else
			local dps = (total + totalOver) / activeFightLength
			reportData[1][2] = "Всего - "..ExRT.F.shortNumber(total + totalOver).."@1@ ("..floor(dps)..")@1#"
			sort(damage,function(a,b) return (a[2]+a[3]+a[4]+a[5])>(b[2]+b[3]+b[4]+b[5]) end)
			_max = damage[1] and (damage[1][2]+damage[1][3]+damage[1][4]+damage[1][5]) or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total + totalOver,dps,nil,nil,nil,nil,nil,nil,totalOver / max(total + totalOver,1))		
		end
		for i=1,#damage do
			local class = nil
			if damage[i][1] and damage[i][1] ~= "" then
				class = select(2,GetPlayerInfoByGUID(damage[i][1]))
			end
			local icon = ""
			if class and CLASS_ICON_TCOORDS[class] then
				icon = {"Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",unpack(CLASS_ICON_TCOORDS[class])}
			end
			local tooltipData = {GetGUID(damage[i][1]),
				{ExRT.L.BossWatcherDamageTooltipOverkill,ExRT.F.shortNumber(damage[i][3])},
				{ExRT.L.BossWatcherDamageTooltipBlocked,ExRT.F.shortNumber(damage[i][4])},
				{ExRT.L.BossWatcherDamageTooltipAbsorbed,ExRT.F.shortNumber(damage[i][5])},
				{ExRT.L.BossWatcherDamageTooltipTotal,ExRT.F.shortNumber(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])},
				{" "," "},
				{ExRT.L.BossWatcherDamageTooltipFromCrit,format("%s (%.1f%%)",ExRT.F.shortNumber(damage[i][6]),max(damage[i][6]/max(1,damage[i][2]+damage[i][3])*100))},
				{ExRT.L.BossWatcherDamageTooltipFromMs,format("%s (%.1f%%)",ExRT.F.shortNumber(damage[i][7]),max(damage[i][7]/max(1,damage[i][2]+damage[i][3])*100))},
			}
			sort(damage[i][8],DamageTab_Temp_SortingBy2Param)
			if #damage[i][8] > 0 then
				tooltipData[#tooltipData + 1] = {" "," "}
				tooltipData[#tooltipData + 1] = {ExRT.L.BossWatcherDamageTooltipTargets," "}
			end
			for j=1,min(5,#damage[i][8]) do
				tooltipData[#tooltipData + 1] = {SubUTF8String(GetGUID(damage[i][8][j][1]),20)..GUIDtoText(" [%s]",damage[i][8][j][1]),format("%s (%.1f%%)",ExRT.F.shortNumber(damage[i][8][j][2]),min(damage[i][8][j][2] / max(1,damage[i][2]+(DamageShowAll and (damage[i][3]+damage[i][4]+damage[i][5]) or 0))*100,100))}
			end
			if not DamageShowAll then
				local dps = damage[i][2]/activeFightLength
				DamageTab_SetLine(i+1,icon,GetGUID(damage[i][1])..GUIDtoText(" [%s]",damage[i][1]),damage[i][2]/total,damage[i][2]/max(_max,1),damage[i][2],dps,class,damage[i][1],doEnemy,nil,tooltipData)
				reportData[1][#reportData[1]+1] = i..". "..GetGUID(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]).."@1@ ("..floor(dps)..")@1#"
			else
				local dps = (damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])/activeFightLength
				DamageTab_SetLine(i+1,icon,GetGUID(damage[i][1])..GUIDtoText(" [%s]",damage[i][1]),(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])/(total + totalOver),(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])/max(_max,1),damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5],dps,class,damage[i][1],doEnemy,nil,tooltipData,nil,(damage[i][3]+damage[i][4]+damage[i][5])/max(1,damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5]))
				reportData[1][#reportData[1]+1] = i..". "..GetGUID(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5]).."@1@ ("..floor(dps)..")@1#"			
			end
		end
		for i=#damage+2,#BWInterfaceFrame.tab.tabs[1].lines do
			BWInterfaceFrame.tab.tabs[1].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[1].scroll:SetNewHeight((#damage+1) * 20)
	end
	local function DamageTab_UpdateLinesSpells(doEnemy)
		DamageTab_UpdateDropDownSource()
		DamageTab_UpdateDropDownDest()
		DamageTab_UpdateDropDownType(3,doEnemy)
		Damage_Last_Func = DamageTab_UpdateLinesSpells
		Damage_Last_doEnemy = doEnemy
		local damage = {}
		local total = 0
		local totalOver = 0
		for destGUID,destData in pairs(module.db.nowData.damage) do
			if ExRT.F.table_len(destVar) == 0 or destVar[destGUID] then
				local isEnemy = false
				if ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[destGUID],2) == 512 then
					isEnemy = true
				end
				local mobID = ExRT.F.GUIDtoID(destGUID)
				for sourceGUID,sourceData in pairs(destData) do
					local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
					if owner then
						sourceGUID = owner
					end
					if ExRT.F.table_len(sourceVar) == 0 or sourceVar[sourceGUID] then
						if (isEnemy and doEnemy) or (not isEnemy and not doEnemy) then
							for spellID,spellAmount in pairs(sourceData) do
								if owner then
									spellID = -spellID
								end
								local inDamagePos = ExRT.F.table_find(damage,spellID,1)
								if not inDamagePos then
									inDamagePos = #damage + 1
									damage[inDamagePos] = {spellID,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,{}}
								end
								
								local destPos = ExRT.F.table_find(damage[inDamagePos][17],destGUID,1)
								if not destPos then
									destPos = #damage[inDamagePos][17] + 1
									damage[inDamagePos][17][destPos] = {destGUID,0}
								end
								destPos = damage[inDamagePos][17][destPos]
								
								damage[inDamagePos][2] = damage[inDamagePos][2] + spellAmount.amount - spellAmount.overkill	--amount
								damage[inDamagePos][3] = damage[inDamagePos][3] + spellAmount.count	--count
								damage[inDamagePos][4] = damage[inDamagePos][4] + spellAmount.overkill	--overkill
								damage[inDamagePos][5] = damage[inDamagePos][5] + spellAmount.blocked	--blocked
								damage[inDamagePos][6] = damage[inDamagePos][6] + spellAmount.absorbed	--absorbed
								damage[inDamagePos][7] = damage[inDamagePos][7] + spellAmount.crit	--crit
								damage[inDamagePos][8] = damage[inDamagePos][8] + spellAmount.critcount	--crit count
								damage[inDamagePos][9] = max(damage[inDamagePos][9],spellAmount.critmax)--crit max
								damage[inDamagePos][10] = damage[inDamagePos][10] + spellAmount.ms	--ms
								damage[inDamagePos][11] = damage[inDamagePos][11] + spellAmount.mscount	--ms count
								damage[inDamagePos][12] = max(damage[inDamagePos][12],spellAmount.msmax)--ms max
								damage[inDamagePos][13] = max(damage[inDamagePos][13],spellAmount.hitmax)--hit max
								damage[inDamagePos][14] = damage[inDamagePos][14] + spellAmount.parry	--parry
								damage[inDamagePos][15] = damage[inDamagePos][15] + spellAmount.dodge	--dodge
								damage[inDamagePos][16] = damage[inDamagePos][16] + spellAmount.miss	--other miss
								total = total + spellAmount.amount - spellAmount.overkill
								totalOver = totalOver + spellAmount.overkill + spellAmount.blocked + spellAmount.absorbed
								
								destPos[2] = destPos[2] + spellAmount.amount + (DamageShowAll and (spellAmount.blocked+spellAmount.absorbed) or -spellAmount.overkill)
								
								if mobID == 76933 then	--Mage T100 fix
									local multiplier = VExRT.BossWatcher.divisionPrismatic and 0 or 1
									damage[inDamagePos][2] = damage[inDamagePos][2] - spellAmount.amount
									damage[inDamagePos][4] = damage[inDamagePos][4] + (spellAmount.amount * multiplier)
									total = total - spellAmount.amount
									totalOver = totalOver + (spellAmount.amount * multiplier)
								end
							end
						end
					end
				end
			end
		end
		local totalIsFull = 1
		total = max(total,1)
		if total == 1 and #damage == 0 then
			total = 0
			totalIsFull = 0
		end
		local _max = nil
		reportOptions[1] = ExRT.L.BossWatcherReportDPS
		wipe(reportData[1])
		reportData[1][1] = (DamageTab_GetGUIDsReport(sourceVar) or ExRT.L.BossWatcherAllSources).." > "..(DamageTab_GetGUIDsReport(destVar,true) or ExRT.L.BossWatcherAllTargets)
		local activeFightLength = GetFightLength()
		if not DamageShowAll then
			local dps = total / activeFightLength
			reportData[1][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total).."@1@ ("..floor(dps)..")@1#"
			sort(damage,function(a,b) return a[2]>b[2] end)
			_max = damage[1] and damage[1][2] or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total,dps)
		else
			local dps = (total + totalOver) / activeFightLength
			reportData[1][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total + totalOver).."@1@ ("..floor(dps)..")@1#"
			sort(damage,function(a,b) return (a[2]+a[4]+a[5]+a[6])>(b[2]+b[4]+b[5]+b[6]) end)
			_max = damage[1] and (damage[1][2]+damage[1][4]+damage[1][5]+damage[1][6]) or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total + totalOver,dps,nil,nil,nil,nil,nil,nil,totalOver / max(total + totalOver,1))		
		end
		for i=1,#damage do
			local isPetAbility = damage[i][1] < 0
			if isPetAbility then
				damage[i][1] = -damage[i][1]
			end
			local spellName,_,spellIcon = GetSpellInfo(damage[i][1])
			if isPetAbility then
				spellName = ExRT.L.BossWatcherPetText..": "..spellName
			end
			local school = module.db.spellsSchool[ damage[i][1] ] or 0
			local tooltipData = {spellName,
				{ExRT.L.BossWatcherDamageTooltipCount,damage[i][3]-damage[i][11]},
				{ExRT.L.BossWatcherDamageTooltipMaxHit,damage[i][13]},
				{ExRT.L.BossWatcherDamageTooltipMidHit,ExRT.F.Round((damage[i][2]-damage[i][7]-damage[i][10]+damage[i][4])/max(damage[i][3]-damage[i][8]-damage[i][11],1))},
				{ExRT.L.BossWatcherDamageTooltiCritCount,format("%d (%.1f%%)",damage[i][8],damage[i][8]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltiCritAmount,ExRT.F.shortNumber(damage[i][7])},
				{ExRT.L.BossWatcherDamageTooltiMaxCrit,damage[i][9]},
				{ExRT.L.BossWatcherDamageTooltiMidCrit,ExRT.F.Round(damage[i][7]/max(damage[i][8],1))},
				{ExRT.L.BossWatcherDamageTooltiMsCount,format("%d (%.1f%%)",damage[i][11],damage[i][11]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltiMsAmount,ExRT.F.shortNumber(damage[i][10])},
				{ExRT.L.BossWatcherDamageTooltiMaxMs,damage[i][12]},				
				{ExRT.L.BossWatcherDamageTooltiMidMs,ExRT.F.Round(damage[i][10]/max(damage[i][11],1))},
				{ExRT.L.BossWatcherDamageTooltipParry,format("%d (%.1f%%)",damage[i][14],damage[i][14]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltipDodge,format("%d (%.1f%%)",damage[i][15],damage[i][15]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltipMiss,format("%d (%.1f%%)",damage[i][16],damage[i][16]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltipOverkill,ExRT.F.shortNumber(damage[i][4])},
				{ExRT.L.BossWatcherDamageTooltipBlocked,ExRT.F.shortNumber(damage[i][5])},
				{ExRT.L.BossWatcherDamageTooltipAbsorbed,ExRT.F.shortNumber(damage[i][6])},
				{ExRT.L.BossWatcherDamageTooltipTotal,ExRT.F.shortNumber(damage[i][4]+damage[i][5]+damage[i][6]+damage[i][2])},
				{ExRT.L.BossWatcherSchool,GetSchoolName(school)},
			}
			sort(damage[i][17],DamageTab_Temp_SortingBy2Param)
			if #damage[i][17] > 0 then
				tooltipData[#tooltipData + 1] = {" "," "}
				tooltipData[#tooltipData + 1] = {ExRT.L.BossWatcherDamageTooltipTargets," "}
			end
			for j=1,min(5,#damage[i][17]) do
				tooltipData[#tooltipData + 1] = {SubUTF8String(GetGUID(damage[i][17][j][1]),20)..GUIDtoText(" [%s]",damage[i][17][j][1]),format("%s (%.1f%%)",ExRT.F.shortNumber(damage[i][17][j][2]),min(damage[i][17][j][2] / max(1,damage[i][2]+(DamageShowAll and (damage[i][4]+damage[i][5]+damage[i][6]) or 0))*100,100))}
			end
			
			if not DamageShowAll then
				local dps = damage[i][2]/activeFightLength
				DamageTab_SetLine(i+1,spellIcon,spellName,damage[i][2]/total,damage[i][2]/max(_max,1),damage[i][2],dps,nil,nil,nil,"spell:"..damage[i][1],tooltipData,school)
				reportData[1][#reportData[1]+1] = i..". "..(isPetAbility and ExRT.L.BossWatcherPetText..": " or "")..GetSpellLink(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]).."@1@ ("..floor(dps)..")@1#"
			else
				local dps = (damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6])/activeFightLength
				DamageTab_SetLine(i+1,spellIcon,spellName,(damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6])/(total + totalOver),(damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6])/max(_max,1),damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6],dps,nil,nil,nil,"spell:"..damage[i][1],tooltipData,school,(damage[i][4]+damage[i][5]+damage[i][6])/max(1,damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6]))
				reportData[1][#reportData[1]+1] = i..". "..(isPetAbility and ExRT.L.BossWatcherPetText..": " or "")..GetSpellLink(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6]).."@1@ ("..floor(dps)..")@1#"
			end
		end
		for i=#damage+2,#BWInterfaceFrame.tab.tabs[1].lines do
			BWInterfaceFrame.tab.tabs[1].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[1].scroll:SetNewHeight((#damage+1) * 20)
	end
	local function DamageTab_UpdateLinesTargets(doEnemy)
		DamageTab_UpdateDropDownSource()
		DamageTab_UpdateDropDownDest()
		DamageTab_UpdateDropDownType(2,doEnemy)
		Damage_Last_Func = DamageTab_UpdateLinesTargets
		Damage_Last_doEnemy = doEnemy
		local damage = {}
		local total = 0
		local totalOver = 0
		for destGUID,destData in pairs(module.db.nowData.damage) do
			local isEnemy = ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[destGUID],2) == 512
			local mobID = ExRT.F.GUIDtoID(destGUID)
			if (ExRT.F.table_len(destVar) == 0 or destVar[destGUID]) and ((doEnemy and isEnemy) or (not doEnemy and not isEnemy)) then
				for sourceGUID,sourceData in pairs(destData) do
					local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
					if owner then
						sourceGUID = owner
					end
					if ExRT.F.table_len(sourceVar) == 0 or sourceVar[sourceGUID] then
						local inDamagePos = ExRT.F.table_find(damage,destGUID,1)
						if not inDamagePos then
							inDamagePos = #damage + 1
							damage[inDamagePos] = {destGUID,0,0,0,0,0,0,{}}
						end
						
						local sourcePos = ExRT.F.table_find(damage[inDamagePos][8],sourceGUID,1)
						if not sourcePos then
							sourcePos = #damage[inDamagePos][8] + 1
							damage[inDamagePos][8][sourcePos] = {sourceGUID,0}
						end
						sourcePos = damage[inDamagePos][8][sourcePos]
						
						for spellID,spellAmount in pairs(sourceData) do
							damage[inDamagePos][2] = damage[inDamagePos][2] + spellAmount.amount - spellAmount.overkill
							damage[inDamagePos][3] = damage[inDamagePos][3] + spellAmount.overkill	--overkill
							damage[inDamagePos][4] = damage[inDamagePos][4] + spellAmount.blocked	--blocked
							damage[inDamagePos][5] = damage[inDamagePos][5] + spellAmount.absorbed	--absorbed
							damage[inDamagePos][6] = damage[inDamagePos][6] + spellAmount.crit	--crit
							damage[inDamagePos][7] = damage[inDamagePos][7] + spellAmount.ms	--ms
							total = total + spellAmount.amount - spellAmount.overkill
							totalOver = totalOver + spellAmount.overkill + spellAmount.blocked + spellAmount.absorbed
							
							sourcePos[2] = sourcePos[2] + spellAmount.amount + (DamageShowAll and (spellAmount.blocked+spellAmount.absorbed) or -spellAmount.overkill)
							
							if mobID == 76933 then	--Mage T100 fix
								local multiplier = VExRT.BossWatcher.divisionPrismatic and 0 or 1
								damage[inDamagePos][2] = damage[inDamagePos][2] - spellAmount.amount
								damage[inDamagePos][3] = damage[inDamagePos][3] + (spellAmount.amount * multiplier)
								total = total - spellAmount.amount
								totalOver = totalOver + (spellAmount.amount * multiplier)
							end
						end
					end
				end
			end
		end
		local totalIsFull = 1
		total = max(total,1)
		if total == 1 and #damage == 0 then
			total = 0
			totalIsFull = 0
		end
		local _max = nil
		reportOptions[1] = ExRT.L.BossWatcherReportDPS
		wipe(reportData[1])
		reportData[1][1] = (DamageTab_GetGUIDsReport(sourceVar) or ExRT.L.BossWatcherAllSources).." > "..(DamageTab_GetGUIDsReport(destVar,true) or ExRT.L.BossWatcherAllTargets)
		local activeFightLength = GetFightLength()
		if not DamageShowAll then
			local dps = total / activeFightLength
			reportData[1][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total).."@1@ ("..floor(dps)..")@1#"
			sort(damage,function(a,b) return a[2]>b[2] end)
			_max = damage[1] and damage[1][2] or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total,dps)
		else
			local dps = (total + totalOver) / activeFightLength
			reportData[1][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total + totalOver).."@1@ ("..floor(dps)..")@1#"
			sort(damage,function(a,b) return (a[2]+a[3]+a[4]+a[5])>(b[2]+b[3]+b[4]+b[5]) end)
			_max = damage[1] and (damage[1][2]+damage[1][3]+damage[1][4]+damage[1][5]) or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total + totalOver,dps,nil,nil,nil,nil,nil,nil,totalOver / max(total + totalOver,1))		
		end
		for i=1,#damage do
			local class = nil
			if damage[i][1] and damage[i][1] ~= "" then
				class = select(2,GetPlayerInfoByGUID(damage[i][1]))
			end
			local icon = ""
			if class and CLASS_ICON_TCOORDS[class] then
				icon = {"Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",unpack(CLASS_ICON_TCOORDS[class])}
			end
			local tooltipData = {GetGUID(damage[i][1]),
				{ExRT.L.BossWatcherDamageTooltipOverkill,ExRT.F.shortNumber(damage[i][3])},
				{ExRT.L.BossWatcherDamageTooltipBlocked,ExRT.F.shortNumber(damage[i][4])},
				{ExRT.L.BossWatcherDamageTooltipAbsorbed,ExRT.F.shortNumber(damage[i][5])},
				{ExRT.L.BossWatcherDamageTooltipTotal,ExRT.F.shortNumber(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])},
				{" "," "},
				{ExRT.L.BossWatcherDamageTooltipFromCrit,format("%s (%.1f%%)",ExRT.F.shortNumber(damage[i][6]),max(100,damage[i][6]/max(1,damage[i][2]+damage[i][3])*100))},
				{ExRT.L.BossWatcherDamageTooltipFromMs,format("%s (%.1f%%)",ExRT.F.shortNumber(damage[i][7]),max(100,damage[i][7]/max(1,damage[i][2]+damage[i][3])*100))},
			}
			sort(damage[i][8],DamageTab_Temp_SortingBy2Param)
			if #damage[i][8] > 0 then
				tooltipData[#tooltipData + 1] = {" "," "}
				tooltipData[#tooltipData + 1] = {ExRT.L.BossWatcherDamageTooltipSources," "}
			end
			for j=1,min(5,#damage[i][8]) do
				tooltipData[#tooltipData + 1] = {SubUTF8String(GetGUID(damage[i][8][j][1]),20)..GUIDtoText(" [%s]",damage[i][8][j][1]),format("%s (%.1f%%)",ExRT.F.shortNumber(damage[i][8][j][2]),min(damage[i][8][j][2] / max(1,damage[i][2]+(DamageShowAll and (damage[i][3]+damage[i][4]+damage[i][5]) or 0))*100,100))}
			end
			if not DamageShowAll then
				local dps = damage[i][2]/activeFightLength
				DamageTab_SetLine(i+1,icon,GetGUID(damage[i][1])..GUIDtoText(" [%s]",damage[i][1]),damage[i][2]/total,damage[i][2]/max(_max,1),damage[i][2],dps,class,damage[i][1],doEnemy,nil,tooltipData,nil,nil,true)
				reportData[1][#reportData[1]+1] = i..". "..GetGUID(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]).."@1@ ("..floor(dps)..")@1#"
			else
				local dps = (damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])/activeFightLength
				DamageTab_SetLine(i+1,icon,GetGUID(damage[i][1])..GUIDtoText(" [%s]",damage[i][1]),(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])/(total + totalOver),(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5])/max(_max,1),damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5],dps,class,damage[i][1],doEnemy,nil,tooltipData,nil,(damage[i][3]+damage[i][4]+damage[i][5])/max(1,damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5]),true)
				reportData[1][#reportData[1]+1] = i..". "..GetGUID(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]+damage[i][3]+damage[i][4]+damage[i][5]).."@1@ ("..floor(dps)..")@1#"			
			end
		end
		for i=#damage+2,#BWInterfaceFrame.tab.tabs[1].lines do
			BWInterfaceFrame.tab.tabs[1].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[1].scroll:SetNewHeight((#damage+1) * 20)
	end
	
	local function DamageTab_UpdateLinesSpellToTargets(doEnemy)
		local spellIDnow,spellIDnow_Name = nil,""
		for spellID,_ in pairs(sourceVar) do
			spellIDnow = spellID
		end
		if spellIDnow then
			spellIDnow_Name = GetSpellInfo(spellIDnow) or ""
			BWInterfaceFrame.tab.tabs[1].sourceDropDown:SetText(spellIDnow_Name)
		else
			BWInterfaceFrame.tab.tabs[1].sourceDropDown:SetText(ExRT.L.BossWatcherSelect)
		end
		DamageTab_UpdateDropDownDest()
		DamageTab_UpdateDropDownType(4,doEnemy)
		Damage_Last_Func = DamageTab_UpdateLinesSpellToTargets
		Damage_Last_doEnemy = doEnemy
		local damage = {}
		local total = 0
		local totalOver = 0
		local totalCount = 0
		for destGUID,destData in pairs(module.db.nowData.damage) do
			local isEnemy = ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[destGUID],2) == 512
			local mobID = ExRT.F.GUIDtoID(destGUID)
			if (doEnemy and isEnemy) or (not doEnemy and not isEnemy) then
				for sourceGUID,sourceData in pairs(destData) do
					for spellID,spellAmount in pairs(sourceData) do
						if sourceVar[spellID] then
							local inDamagePos = ExRT.F.table_find(damage,destGUID,1)
							if not inDamagePos then
								inDamagePos = #damage + 1
								damage[inDamagePos] = {destGUID,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
							end
							damage[inDamagePos][2] = damage[inDamagePos][2] + spellAmount.amount - spellAmount.overkill	--amount
							damage[inDamagePos][3] = damage[inDamagePos][3] + spellAmount.count	--count
							damage[inDamagePos][4] = damage[inDamagePos][4] + spellAmount.overkill	--overkill
							damage[inDamagePos][5] = damage[inDamagePos][5] + spellAmount.blocked	--blocked
							damage[inDamagePos][6] = damage[inDamagePos][6] + spellAmount.absorbed	--absorbed
							damage[inDamagePos][7] = damage[inDamagePos][7] + spellAmount.crit	--crit
							damage[inDamagePos][8] = damage[inDamagePos][8] + spellAmount.critcount	--crit count
							damage[inDamagePos][9] = max(damage[inDamagePos][9],spellAmount.critmax)--crit max
							damage[inDamagePos][10] = damage[inDamagePos][10] + spellAmount.ms	--ms
							damage[inDamagePos][11] = damage[inDamagePos][11] + spellAmount.mscount	--ms count
							damage[inDamagePos][12] = max(damage[inDamagePos][12],spellAmount.msmax)--ms max
							damage[inDamagePos][13] = max(damage[inDamagePos][13],spellAmount.hitmax)--hit max
							damage[inDamagePos][14] = damage[inDamagePos][14] + spellAmount.parry	--parry
							damage[inDamagePos][15] = damage[inDamagePos][15] + spellAmount.dodge	--dodge
							damage[inDamagePos][16] = damage[inDamagePos][16] + spellAmount.miss	--other miss
							total = total + spellAmount.amount - spellAmount.overkill
							totalOver = totalOver + spellAmount.overkill + spellAmount.blocked + spellAmount.absorbed
							totalCount = totalCount + spellAmount.count - spellAmount.mscount
							
							if mobID == 76933 then	--Mage T100 fix
								local multiplier = VExRT.BossWatcher.divisionPrismatic and 0 or 1
								damage[inDamagePos][2] = damage[inDamagePos][2] - spellAmount.amount
								damage[inDamagePos][4] = damage[inDamagePos][4] + (spellAmount.amount * multiplier)
								total = total - spellAmount.amount
								totalOver = totalOver + (spellAmount.amount * multiplier)
							end
						end
					end
				end
			end
		end
		local totalIsFull = 1
		total = max(total,1)
		if total == 1 and #damage == 0 then
			total = 0
			totalIsFull = 0
		end
		local _max = nil
		reportOptions[1] = ExRT.L.BossWatcherReportCount
		wipe(reportData[1])
		reportData[1][1] = GetSpellLink(spellIDnow).." > "..ExRT.L.BossWatcherAllTargets
		if not DamageShowAll then
			reportData[1][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total).."@1@ ("..floor(totalCount)..")@1#"
			sort(damage,function(a,b) return a[2]>b[2] end)
			_max = damage[1] and damage[1][2] or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total,totalCount)
		else
			reportData[1][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total + totalOver).."@1@ ("..floor(totalCount)..")@1#"
			sort(damage,function(a,b) return (a[2]+a[4]+a[5]+a[6])>(b[2]+b[4]+b[5]+b[6]) end)
			_max = damage[1] and (damage[1][2]+damage[1][4]+damage[1][5]+damage[1][6]) or 0
			DamageTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total + totalOver,totalCount,nil,nil,nil,nil,nil,nil,totalOver / max(total + totalOver,1))
		end
		for i=1,#damage do
			local class = nil
			if damage[i][1] and damage[i][1] ~= "" then
				class = select(2,GetPlayerInfoByGUID(damage[i][1]))
			end
			local icon = ""
			if class and CLASS_ICON_TCOORDS[class] then
				icon = {"Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",unpack(CLASS_ICON_TCOORDS[class])}
			end
			local tooltipData = {GetGUID(damage[i][1]),
				{ExRT.L.BossWatcherDamageTooltipCount,damage[i][3]-damage[i][11]},
				{ExRT.L.BossWatcherDamageTooltipMaxHit,damage[i][13]},
				{ExRT.L.BossWatcherDamageTooltipMidHit,ExRT.F.Round((damage[i][2]-damage[i][7]-damage[i][10]+damage[i][4])/max(damage[i][3]-damage[i][8]-damage[i][11],1))},
				{ExRT.L.BossWatcherDamageTooltiCritCount,format("%d (%.1f%%)",damage[i][8],damage[i][8]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltiCritAmount,ExRT.F.shortNumber(damage[i][7])},
				{ExRT.L.BossWatcherDamageTooltiMaxCrit,damage[i][9]},
				{ExRT.L.BossWatcherDamageTooltiMidCrit,ExRT.F.Round(damage[i][7]/max(damage[i][8],1))},
				{ExRT.L.BossWatcherDamageTooltiMsCount,format("%d (%.1f%%)",damage[i][11],damage[i][11]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltiMsAmount,ExRT.F.shortNumber(damage[i][10])},
				{ExRT.L.BossWatcherDamageTooltiMaxMs,damage[i][12]},				
				{ExRT.L.BossWatcherDamageTooltiMidMs,ExRT.F.Round(damage[i][10]/max(damage[i][11],1))},
				{ExRT.L.BossWatcherDamageTooltipParry,format("%d (%.1f%%)",damage[i][14],damage[i][14]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltipDodge,format("%d (%.1f%%)",damage[i][15],damage[i][15]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltipMiss,format("%d (%.1f%%)",damage[i][16],damage[i][16]/damage[i][3]*100)},
				{ExRT.L.BossWatcherDamageTooltipOverkill,ExRT.F.shortNumber(damage[i][4])},
				{ExRT.L.BossWatcherDamageTooltipBlocked,ExRT.F.shortNumber(damage[i][5])},
				{ExRT.L.BossWatcherDamageTooltipAbsorbed,ExRT.F.shortNumber(damage[i][6])},
				{ExRT.L.BossWatcherDamageTooltipTotal,ExRT.F.shortNumber(damage[i][4]+damage[i][5]+damage[i][6]+damage[i][2])},
			}
			if not DamageShowAll then
				DamageTab_SetLine(i+1,icon,GetGUID(damage[i][1])..GUIDtoText(" [%s]",damage[i][1]),damage[i][2]/total,damage[i][2]/max(_max,1),damage[i][2],damage[i][3]-damage[i][11],class,nil,nil,nil,tooltipData)
				reportData[1][#reportData[1]+1] = i..". "..GetGUID(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]).."@1@ ("..(damage[i][3]-damage[i][11])..")@1#"
			else
				DamageTab_SetLine(i+1,icon,GetGUID(damage[i][1])..GUIDtoText(" [%s]",damage[i][1]),(damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6])/(total + totalOver),(damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6])/max(_max,1),damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6],damage[i][3]-damage[i][11],class,nil,nil,nil,tooltipData,nil,(damage[i][4]+damage[i][5]+damage[i][6])/max(1,damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6]))
				reportData[1][#reportData[1]+1] = i..". "..GetGUID(damage[i][1]).." - "..ExRT.F.shortNumber(damage[i][2]+damage[i][4]+damage[i][5]+damage[i][6]).."@1@ ("..(damage[i][3]-damage[i][11])..")@1#"
			end
		end
		for i=#damage+2,#BWInterfaceFrame.tab.tabs[1].lines do
			BWInterfaceFrame.tab.tabs[1].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[1].scroll:SetNewHeight((#damage+1) * 20)
	end
	
	local function DamageTab_ShowDamageToTarget(GUID)
		local button = BWInterfaceFrame.tab.tabs[1].button
		local func = button:GetScript("OnClick")
		func(button)
		wipe(sourceVar)
		wipe(destVar)
		destVar[GUID] = true
		DamageTab_UpdateLinesPlayers(true)
	end
	
	local function DamageTab_DPS_SelectDropDownSource(self,arg,doEnemy,doSpells)
		wipe(sourceVar)
		if arg then
			sourceVar[arg] = true
			
			if IsShiftKeyDown() then
				local name = module.db.data[module.db.nowNum].guids[arg]
				if name then
					for GUID,GUIDname in pairs(module.db.data[module.db.nowNum].guids) do
						if GUIDname == name then
							sourceVar[GUID] = true
						end
					end
				end
			end
		end
		if not doSpells then
			if ExRT.F.table_len(destVar) == 0 then
				if ExRT.F.table_len(sourceVar) ~= 0 then
					DamageTab_UpdateLinesTargets(doEnemy)
				else
					DamageTab_UpdateLinesPlayers(doEnemy)
				end
			else
				if ExRT.F.table_len(sourceVar) ~= 0 then
					DamageTab_UpdateLinesSpells(doEnemy)
				else
					DamageTab_UpdateLinesPlayers(doEnemy)
				end
			end
		else
			DamageTab_UpdateLinesSpells(doEnemy)
		end
		ExRT.lib.ScrollDropDown.Close()
	end
	local function DamageTab_DPS_SelectDropDownDest(self,arg,doEnemy,doSpells)
		wipe(destVar)
		if arg then
			destVar[arg] = true
			
			if IsShiftKeyDown() then
				local name = module.db.data[module.db.nowNum].guids[arg]
				if name then
					for GUID,GUIDname in pairs(module.db.data[module.db.nowNum].guids) do
						if GUIDname == name then
							destVar[GUID] = true
						end
					end
				end
			end
		end
		if not doSpells then
			if ExRT.F.table_len(sourceVar) == 0 then
				DamageTab_UpdateLinesPlayers(doEnemy)
			else
				if ExRT.F.table_len(destVar) == 0 then
					DamageTab_UpdateLinesTargets(doEnemy)
				else
					DamageTab_UpdateLinesSpells(doEnemy)
				end
			end
		else
			DamageTab_UpdateLinesSpells(doEnemy)
		end
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function DamageTab_DPS_SelectDropDownSource_Spell(self,spellID,doEnemy)
		wipe(sourceVar)
		sourceVar[spellID]=true
		DamageTab_UpdateLinesSpellToTargets(doEnemy)
		ExRT.lib.ScrollDropDown.Close()
	end

	local function DamageTab_DPS_CheckDropDownSource(self,checked)
		if checked then
			sourceVar[self.arg1] = true
		else
			sourceVar[self.arg1] = nil
		end
		Damage_Last_Func(self.arg2)
	end
	local function DamageTab_DPS_CheckDropDownDest(self,checked)
		if checked then
			destVar[self.arg1] = true
		else
			destVar[self.arg1] = nil
		end
		Damage_Last_Func(self.arg2)
	end
	
	local function DamageTab_HideArrow()
		BWInterfaceFrame.timeLineFrame.timeLine.arrow:Hide()
	end
	local function DamageTab_ShowArrow(self,pos)
		if pos then
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"BOTTOMLEFT",BWInterfaceFrame.timeLineFrame.width*pos,0)
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:Show()
		end
	end
	
	local function DamageTab_HoverDropDownSpell(self,spellID)
		if not spellID then
			return
		end
		ExRT.lib.OnEnterHyperLinkTooltip(self,"spell:"..spellID)
	end

	local function DamageTab_DPS(doEnemy,doSpells,doNotUpdateLines,isBySpellDamage)
		local reaction = 512
		if not doEnemy then
			reaction = 256
		end
		
		if not module.db.nowData.damage then	--First load fix
			return
		end
	
		local sourceTable = {}
		local destTable = {}
		for destGUID,destData in pairs(module.db.nowData.damage) do
			local mobID = ExRT.F.GUIDtoID(destGUID)
			if ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[destGUID],2) == reaction and (mobID ~= 76933 or VExRT.BossWatcher.showPrismatic) then
				destTable[#destTable + 1] = {destGUID,module.db.nowData.damage_seen[destGUID] or 0}
				for sourceGUID,sourceData in pairs(destData) do
					local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
					if owner then
						sourceGUID = owner
					end
					if not isBySpellDamage then
						if not ExRT.F.table_find(sourceTable,sourceGUID,1) then
							sourceTable[#sourceTable + 1] = {sourceGUID,GetGUID(sourceGUID)}
						end
					else
						for spellID,spellAmount in pairs(sourceData) do
							if not ExRT.F.table_find(sourceTable,spellID,1) then
								local spellName,_,spellIcon = GetSpellInfo(spellID)
								sourceTable[#sourceTable + 1] = {spellID,spellName,spellIcon}
							end
						end
					end
				end
			end
		end
		sort(sourceTable,function(a,b) return a[2]<b[2] end)
		sort(destTable,function(a,b) return a[2]<b[2] end)
		wipe(BWInterfaceFrame.tab.tabs[1].sourceDropDown.List)
		wipe(BWInterfaceFrame.tab.tabs[1].targetDropDown.List)
		if not isBySpellDamage then
			BWInterfaceFrame.tab.tabs[1].sourceDropDown.List[1] = {text = ExRT.L.BossWatcherAll,func = DamageTab_DPS_SelectDropDownSource,arg2=doEnemy,arg3=doSpells,padding = 16}
			BWInterfaceFrame.tab.tabs[1].targetDropDown.List[1] = {text = ExRT.L.BossWatcherAll,func = DamageTab_DPS_SelectDropDownDest,arg2=doEnemy,arg3=doSpells,padding = 16}
			for i=1,#sourceTable do
				local isPlayer = ExRT.F.GetUnitTypeByGUID(sourceTable[i][1]) == 0
				local classColor = ""
				if isPlayer then
					classColor = "|c"..ExRT.F.classColorByGUID(sourceTable[i][1])
				end
				BWInterfaceFrame.tab.tabs[1].sourceDropDown.List[i+1] = {
					text = classColor..sourceTable[i][2]..GUIDtoText(" [%s]",sourceTable[i][1]),
					arg1 = sourceTable[i][1],
					arg2 = doEnemy,
					arg3 = doSpells,
					func = DamageTab_DPS_SelectDropDownSource,
					checkFunc = DamageTab_DPS_CheckDropDownSource,
					checkable = true,
				}
			end
		else
			for i=1,#sourceTable do
				local spellColorTable = module.db.schoolsColors[ module.db.spellsSchool[ sourceTable[i][1] ] or 0 ] or module.db.schoolsColors[0]
				local spellColor = "|cff"..format("%02x%02x%02x",spellColorTable.r*255,spellColorTable.g*255,spellColorTable.b*255)
				BWInterfaceFrame.tab.tabs[1].sourceDropDown.List[i] = {
					text = spellColor..sourceTable[i][2],
					arg1 = sourceTable[i][1],
					arg2 = doEnemy,
					func = DamageTab_DPS_SelectDropDownSource_Spell,
					icon = sourceTable[i][3],
					hoverFunc = DamageTab_HoverDropDownSpell,
					hoverArg = sourceTable[i][1],
					leaveFunc = GameTooltip_Hide,
				}
			end
			wipe(sourceVar)
			wipe(destVar)
			DamageTab_UpdateLinesSpellToTargets(doEnemy)
			return
		end
		for i=1,#destTable do
			local isPlayer = ExRT.F.GetUnitTypeByGUID(destTable[i][1]) == 0
			local classColor = ""
			if isPlayer then
				classColor = "|c"..ExRT.F.classColorByGUID(destTable[i][1])
			end
			BWInterfaceFrame.tab.tabs[1].targetDropDown.List[i+1] = {
				text = classColor.. date("%M:%S ", timestampToFightTime( module.db.nowData.damage_seen[destTable[i][1]] ))..GetGUID(destTable[i][1])..GUIDtoText(" [%s]",destTable[i][1]),
				arg1 = destTable[i][1],
				arg2 = doEnemy,
				arg3 = doSpells,
				func = DamageTab_DPS_SelectDropDownDest,
				hoverFunc = DamageTab_ShowArrow,
				leaveFunc = DamageTab_HideArrow,
				hoverArg = timestampToFightTime( module.db.nowData.damage_seen[destTable[i][1]] ) / ( module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart ),
				checkFunc = DamageTab_DPS_CheckDropDownDest,
				checkable = true,
			}
		end
		wipe(sourceVar)
		wipe(destVar)
		if not doNotUpdateLines then
			if doSpells then
				DamageTab_UpdateLinesSpells(doEnemy)		
			else
				DamageTab_UpdateLinesPlayers(doEnemy)
			end
		end
	end
	
	local function DamageTab_FDPS(self)
		DamageTab_DPS(true,false)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function DamageTab_EDPS(self)
		DamageTab_DPS(false,false)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function DamageTab_EDTPS(self)
		DamageTab_DPS(true,false,true)
		DamageTab_UpdateLinesTargets(true)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function DamageTab_EDTPSbyName(self)
		DamageTab_DPS(false,false,true)
		DamageTab_UpdateLinesTargets()
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function DamageTab_FSPS(self)
		DamageTab_DPS(true,true)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function DamageTab_ESPS(self)
		DamageTab_DPS(false,true)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function DamageTab_FDTBS(self)
		DamageTab_DPS(false,nil,nil,true)
		ExRT.lib.ScrollDropDown.Close()
	end
	local function DamageTab_EDTBS(self)
		DamageTab_DPS(true,nil,nil,true)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	tab.typeDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",70,-75,195,200,8,ExRT.L.BossWatcherDamageDamageDone,nil,"ExRTDropDownMenuModernTemplate")
	tab.typeText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherType..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.typeText,"RIGHT",tab.typeDropDown,"LEFT",-6,0)
	tab.typeDropDown.List = {
		{text = ExRT.L.BossWatcherDamageDamageDone,func = DamageTab_FDPS},
		{text = ExRT.L.BossWatcherDamageDamageTaken,func = DamageTab_EDPS},
		{text = ExRT.L.BossWatcherDamageDamageTakenByEnemy,func = DamageTab_EDTPS},
		{text = ExRT.L.BossWatcherDamageDamageTakenByPlayers,func = DamageTab_EDTPSbyName},
		{text = ExRT.L.BossWatcherDamageDamageDoneBySpell,func = DamageTab_FSPS},
		{text = ExRT.L.BossWatcherDamageDamageTakenBySpell,func = DamageTab_ESPS},
		{text = ExRT.L.BossWatcherDamageDamageSpellToHostile,func = DamageTab_EDTBS},
		{text = ExRT.L.BossWatcherDamageDamageSpellToFriendly,func = DamageTab_FDTBS},
	}
	
	tab.sourceDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",365,-75,195,250,20,ExRT.L.BossWatcherAll,nil,"ExRTDropDownMenuModernTemplate")
	tab.sourceText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherSource..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.sourceText,"RIGHT",tab.sourceDropDown,"LEFT",-6,0)

	tab.targetDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",630,-75,195,250,20,ExRT.L.BossWatcherAll,nil,"ExRTDropDownMenuModernTemplate")
	tab.targetText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherTarget..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.targetText,"TOPRIGHT",tab.targetDropDown,"TOPLEFT",-6,0)
	
	function tab.sourceDropDown.additionalToggle(self)
		for i=2,#self.List do
			self.List[i].checkState = sourceVar[self.List[i].arg1]
		end
	end
	function tab.targetDropDown.additionalToggle(self)
		for i=2,#self.List do
			self.List[i].checkState = destVar[self.List[i].arg1]
		end
	end
	
	tab.showOverallChk = ExRT.lib.CreateCheckBox(tab,"TOPLEFT",833,-75,"",nil,ExRT.L.BossWatcherDamageShowOver,nil,"ExRTCheckButtonModernTemplate")
	tab.showOverallChk:SetScript("OnClick",function (self)
		if self:GetChecked() then
			DamageShowAll = true
		else
			DamageShowAll = false
		end
		Damage_Last_Func(Damage_Last_doEnemy)
	end)
	
	tab.scroll = ExRT.lib.CreateScrollFrame(tab,835,483,"TOP",0,-105,600,true)
	tab.lines = {}
	local function DamageTab_Line_OnClick(self)
		local GUID = self.sourceGUID
		local doEnemy = self.doEnemy
		local tooltip = self.spellLink
		local isTargetLine = self.isTargetLine
		
		local parent = self:GetParent()
		if parent.isMain then
			GUID = parent.sourceGUID
			doEnemy = parent.doEnemy
			tooltip = parent.spellLink
			isTargetLine = parent.isTargetLine
		end
		if parent.isMain and IsShiftKeyDown() and tooltip and tooltip:find("spell:") then
			local spellID = tooltip:match("%d+")
			if spellID then
				ExRT.F.LinkSpell(spellID)
				return
			end
		end
		if GUID then
			if not isTargetLine then
				wipe(sourceVar)
				sourceVar[GUID] = true
				DamageTab_UpdateLinesSpells(doEnemy)
			else
				wipe(destVar)
				wipe(sourceVar)
				destVar[GUID] = true
				DamageTab_UpdateLinesPlayers(doEnemy)
			end
		end
	end
	local function DamageTab_LineOnEnter(self)
		if self.tooltip then
			GameTooltip:SetOwner(self,"ANCHOR_LEFT")
			GameTooltip:SetText(self.tooltip[1])
			for i=2,#self.tooltip do
				if type(self.tooltip[i]) == "table" then
					GameTooltip:AddDoubleLine(self.tooltip[i][1],self.tooltip[i][2],1,1,1,1,1,1,1,1)
				else
					GameTooltip:AddLine(self.tooltip[i])
				end
			end
			GameTooltip:Show()
		end
	end
	local function DamageTab_Line_OnEnter(self)
		local parent = self:GetParent()
		if parent.spellLink then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(parent.spellLink)
			GameTooltip:Show()
		elseif parent.name:IsTruncated() then
			GameTooltip:SetOwner(self,"ANCHOR_LEFT")
			GameTooltip:SetText(parent.name:GetText())
			GameTooltip:Show()	
		elseif parent.tooltip then
			DamageTab_LineOnEnter(parent)
		end
	end
	function DamageTab_SetLine(i,icon,name,overall_num,overall,total,dps,class,sourceGUID,doEnemy,spellLink,tooltip,school,overall_black,isTargetLine)
		if not BWInterfaceFrame.tab.tabs[1].lines[i] then
			local line = CreateFrame("Button",nil,BWInterfaceFrame.tab.tabs[1].scroll.C)
			BWInterfaceFrame.tab.tabs[1].lines[i] = line
			line:SetSize(815,20)
			line:SetPoint("TOPLEFT",0,-(i-1)*20)
			
			line.icon = ExRT.lib.CreateIcon(line,18,"TOPLEFT",5,-1)
			line.name = ExRT.lib.CreateText(line,225,20,nil,25,0,"LEFT","MIDDLE",nil,12,"name",nil,1,1,1,1)
			line.name:SetMaxLines(1)
			
			line.name_tooltip = CreateFrame('Button',nil,line)
			line.name_tooltip:SetAllPoints(line.name)
			line.overall_num = ExRT.lib.CreateText(line,70,20,nil,250,0,"RIGHT","MIDDLE",nil,12,"45.76%",nil,1,1,1,1)
			line.overall = line:CreateTexture(nil, "BACKGROUND")
			--line.overall:SetTexture(0.7, 0.1, 0.1, 1)
			line.overall:SetTexture("Interface\\AddOns\\ExRT\\media\\bar24.tga")
			line.overall:SetSize(300,16)
			line.overall:SetPoint("TOPLEFT",325,-2)
			line.overall_black = line:CreateTexture(nil, "BACKGROUND")
			line.overall_black:SetTexture("Interface\\AddOns\\ExRT\\media\\bar24b.tga")
			line.overall_black:SetSize(300,16)
			line.overall_black:SetPoint("LEFT",line.overall,"RIGHT",0,0)
			
			line.total = ExRT.lib.CreateText(line,95,20,nil,630,0,"LEFT","MIDDLE",nil,12,"125.46M",nil,1,1,1,1)
			line.dps = ExRT.lib.CreateText(line,100,20,nil,725,0,"LEFT","MIDDLE",nil,12,"34576.43",nil,1,1,1,1)
			
			line.back = line:CreateTexture(nil, "BACKGROUND")
			line.back:SetAllPoints()
			if i%2==0 then
				line.back:SetTexture(0.3, 0.3, 0.3, 0.1)
			end
			line.name_tooltip:SetScript("OnClick",DamageTab_Line_OnClick)
			line.name_tooltip:SetScript("OnEnter",DamageTab_Line_OnEnter)
			line.name_tooltip:SetScript("OnLeave",GameTooltip_Hide)
			line:SetScript("OnClick",DamageTab_Line_OnClick)
			line:SetScript("OnEnter",DamageTab_LineOnEnter)
			line:SetScript("OnLeave",GameTooltip_Hide)
			
			line.isMain = true
		end
		local line = BWInterfaceFrame.tab.tabs[1].lines[i]
		if type(icon) == "table" then
			line.icon.texture:SetTexture(icon[1] or "Interface\\Icons\\INV_MISC_QUESTIONMARK")
			line.icon.texture:SetTexCoord(unpack(icon,2,5))
		else
			line.icon.texture:SetTexture(icon or "Interface\\Icons\\INV_MISC_QUESTIONMARK")
			line.icon.texture:SetTexCoord(0,1,0,1)
		end
		line.name:SetText(name or "")
		line.overall_num:SetFormattedText("%.2f%%",overall_num and overall_num * 100 or 0)
		if overall_black and overall_black > 0 then
			local width = 300*(overall or 1)
			local normal_width = width * (1 - overall_black)
			line.overall:SetWidth(max(normal_width,1))
			line.overall_black:SetWidth(max(width-normal_width,1))
			line.overall_black:Show()
			if normal_width == 0 then
				line.overall:Hide()
				line.overall_black:SetPoint("TOPLEFT",325,-2)
			else
				line.overall:Show()
				line.overall_black:ClearAllPoints()
				line.overall_black:SetPoint("LEFT",line.overall,"RIGHT",0,0)
			end
		else
			line.overall:Show()
			line.overall_black:Hide()
			line.overall:SetWidth(max(300*(overall or 1),1))
		end
		line.total:SetText(total and ExRT.F.shortNumber(total) or "")
		line.dps:SetFormattedText("%.2f",dps or 0)
		line.overall:SetGradientAlpha("HORIZONTAL", 0,0,0,0,0,0,0,0)
		line.overall_black:SetGradientAlpha("HORIZONTAL", 0,0,0,0,0,0,0,0)
		if class then
			local classColorArray = type(CUSTOM_CLASS_COLORS)=="table" and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
			if classColorArray then
				line.overall:SetVertexColor(classColorArray.r,classColorArray.g,classColorArray.b, 1)
				line.overall_black:SetVertexColor(classColorArray.r,classColorArray.g,classColorArray.b, 1)
			else
				line.overall:SetVertexColor(0.8,0.8,0.8, 1)
				line.overall_black:SetVertexColor(0.8,0.8,0.8, 1)
			end
		else
			line.overall:SetVertexColor(0.8,0.8,0.8, 1)
			line.overall_black:SetVertexColor(0.8,0.8,0.8, 1)
		end
		if school then
			SetSchoolColorsToLine(line.overall,school)
			SetSchoolColorsToLine(line.overall_black,school)
		end
		line.sourceGUID = sourceGUID
		line.doEnemy = doEnemy
		line.spellLink = spellLink
		line.tooltip = tooltip
		line.isTargetLine = isTargetLine
		line:Show()
	end
	
	tab:SetScript("OnShow",function (self)
		BWInterfaceFrame.timeLineFrame:ClearAllPoints()
		BWInterfaceFrame.timeLineFrame:SetPoint("TOP",self,"TOP",0,-10)
		BWInterfaceFrame.timeLineFrame:Show()
		
		BWInterfaceFrame.report:Show()
		
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			DamageTab_FDPS(nil,ExRT.L.BossWatcherDamageDamageDone)
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)
	tab:SetScript("OnHide",function (self)
		BWInterfaceFrame.timeLineFrame:Hide()
		BWInterfaceFrame.report:Hide()
	end)
	
	
	
	
	---- Auras Tab
	tab = BWInterfaceFrame.tab.tabs[3]
	tabName = BWInterfaceFrame_Name.."AurasTab"
	
	tab.timeLine = {}
	
	local buffsFilterSource,buffsFilterSourceGUID = 0x0111,{}
	local buffsFilterDest,buffsFilterDestGUID = 0x0111,{}
	--[[
	0x0001 - hostile
	0x0010 - friendly
	0x0100 - pets & guards
	0x1000 - by GUID
	]]
	
	local buffsNameWidth = 188
	local buffsWorkWidth = 650
	local buffsTotalWidth = buffsNameWidth + buffsWorkWidth
	local buffsTotalLines = 30
	for i=1,11 do
		tab.timeLine[i] = CreateFrame("Frame",nil,tab)
		tab.timeLine[i]:SetPoint("TOPLEFT",buffsNameWidth+(i-1)*(buffsWorkWidth/10)-1,-42)
		tab.timeLine[i]:SetSize(2,buffsTotalLines * 18 + 14)
		
		tab.timeLine[i].texture = tab.timeLine[i]:CreateTexture(nil, "BACKGROUND")
		tab.timeLine[i].texture:SetTexture(1, 1, 1, 0.3)
		tab.timeLine[i].texture:SetAllPoints()		
		
		tab.timeLine[i].timeText = ExRT.lib.CreateText(tab.timeLine[i],200,12,"TOPLEFT",4,-2,"RIGHT","TOP",nil,11,"",nil,1,1,1)
		ExRT.lib.SetPoint(tab.timeLine[i].timeText,"TOPRIGHT",tab.timeLine[i],"TOPLEFT",-1,-1)
	end
	
	tab.redDeathLine = {}
	local function CreateRedDeathLine(i)
		if not BWInterfaceFrame.tab.tabs[3].redDeathLine[i] then
			BWInterfaceFrame.tab.tabs[3].redDeathLine[i] = BWInterfaceFrame.tab.tabs[3]:CreateTexture(nil, "BACKGROUND",0,-4)
			BWInterfaceFrame.tab.tabs[3].redDeathLine[i]:SetTexture(1, 0.3, 0.3, 1)
			BWInterfaceFrame.tab.tabs[3].redDeathLine[i]:SetSize(2,buffsTotalLines * 18 + 14)
			BWInterfaceFrame.tab.tabs[3].redDeathLine[i]:Hide()
		end
	end
	
	tab.linesRightClickMenu = {
		{ text = "Spell", isTitle = true, notCheckable = true, notClickable = true },
		{ text = ExRT.L.BossWatcherSendToChat, func = function() 
			if BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData then
				local chat_type = ExRT.F.chatType(true)
				SendChatMessage(BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData[1],chat_type)
				for i=2,#BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData do
					SendChatMessage(ExRT.F.clearTextTag(BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData[i]),chat_type)
				end
			end
			CloseDropDownMenus()
		end, notCheckable = true },
		{ text = ExRT.L.BossWatcherAurasMoreInfoText, func = function() 
			if BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfoData then
				BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo:Update()
				BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo:ShowClick()
			end
			CloseDropDownMenus()
		end, notCheckable = true },
		{ text = ExRT.L.minimapmenuclose, func = function() CloseDropDownMenus() end, notCheckable = true },
	}
	tab.linesRightClickMenuDropDown = CreateFrame("Frame", tabName.."LinesRightClickMenuDropDown", nil, "UIDropDownMenuTemplate")
	
	tab.linesRightClickMoreInfo = ExRT.lib.CreatePopupFrame(300,375,ExRT.L.BossWatcherAurasMoreInfoText,true)
	tab.linesRightClickMoreInfo.ScrollFrame = ExRT.lib.CreateScrollFrame(tab.linesRightClickMoreInfo,285,320,"TOP",0,-25,400,true)
	--tab.linesRightClickMoreInfo.ScrollFrame.backdrop:Hide()
	tab.linesRightClickMoreInfo.lines = {}
	tab.linesRightClickMoreInfo.anchor = "TOPRIGHT"
	tab.linesRightClickMoreInfo.reportButton = ExRT.lib.CreateButton(tab.linesRightClickMoreInfo,292,20,"BOTTOM",0,5,ExRT.L.BossWatcherCreateReport,nil,ExRT.L.BossWatcherCreateReportTooltip,"ExRTButtonModernTemplate")
	tab.linesRightClickMoreInfo.reportButton:SetScript("OnClick",function (self)
		ExRT.F.toChatWindow(BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.report)
		BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo:Hide()
	end)
	do
		local function LineOnEnter(self)
			if self.name:IsTruncated() then
				GameTooltip:SetOwner(self,"ANCHOR_LEFT")
				GameTooltip:SetText(self.name:GetText())
				GameTooltip:Show()
 			end
		end
		local function SetLine(i,name,count)
			if not BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.lines[i] then
				local line = CreateFrame("Button",nil,BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.ScrollFrame.C)
				BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.lines[i] = line
				line:SetSize(270,20)
				line:SetPoint("TOPLEFT",0,-(i-1)*20)
				
				line.name = ExRT.lib.CreateText(line,210,20,nil,10,0,"LEFT","MIDDLE",nil,11,"name",nil,1,1,1,1)
				line.count = ExRT.lib.CreateText(line,40,20,nil,220,0,"CENTER","MIDDLE",nil,12,"name",nil,1,1,1,1)
				
				line.back = line:CreateTexture(nil, "BACKGROUND")
				line.back:SetAllPoints()
				if i%2==0 then
					line.back:SetTexture(0.3, 0.3, 0.3, 0.1)
				end
				
				line:SetScript("OnEnter",LineOnEnter)
				line:SetScript("OnLeave",GameTooltip_Hide)
			end
			BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.lines[i].name:SetText(i..". "..name)
			BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.lines[i].count:SetText(count)
			
			BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.lines[i]:Show()
		end
		tab.linesRightClickMoreInfo.Update = function(self)
			local spellID = BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfoData
			self.title:SetText(GetSpellInfo(spellID) or "?")
			local data = {}
			for i,sourceData in ipairs(module.db.nowData.auras) do
				if sourceData[6] == spellID and (sourceData[8] == 1 or sourceData[8] == 3) and (not BWInterfaceFrame.tab.tabs[3].filterS or (BWInterfaceFrame.tab.tabs[3].filterS == 1 and sourceData[4]) or (BWInterfaceFrame.tab.tabs[3].filterS == 2 and not sourceData[4]) or BWInterfaceFrame.tab.tabs[3].filterS == sourceData[2]) then
					local inPos = ExRT.F.table_find(data,sourceData[3],1)
					if not inPos then
						inPos = #data + 1
						data[inPos] = {sourceData[3],0}
					end
					data[inPos][2] = data[inPos][2] + 1
				end
			end
			sort(data,function(a,b)return a[2]>b[2]end)
			local report = {}
			BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.report = report
			report[1] = GetSpellLink(spellID)
			for i=1,#data do
				local isPlayer = ExRT.F.GetUnitTypeByGUID(data[i][1]) == 0
				local classColor = ""
				if isPlayer then
					classColor = "|c"..ExRT.F.classColorByGUID(data[i][1])
				end
				SetLine(i,classColor..GetGUID(data[i][1])..GUIDtoText(" [%s]",data[i][1]),data[i][2])
				report[#report+1] = i..". "..GetGUID(data[i][1]).." - "..data[i][2]
			end
			for i=#data+1,#BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.lines do
				BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.lines[i]:Hide()
			end
			BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfo.ScrollFrame:SetNewHeight(#data * 20)
		end
	end
	
	local BuffsLineUptimeTempTable = {}
	local function BuffsLinesOnUpdate(self)
		local x,y = ExRT.F.GetCursorPos(self)
		if ExRT.F.IsInFocus(self,x,y) then
			for j=1,buffsTotalLines do
				if BWInterfaceFrame.tab.tabs[3].lines[j] ~= self then
					BWInterfaceFrame.tab.tabs[3].lines[j].hl:Hide()
				end
			end
			self.hl:Show()
			if x <= buffsNameWidth then
				if GameTooltip:IsShown() then
					local _,_,spellID = GameTooltip:GetSpell()
					if spellID == self.spellID then
						return
					end
				end
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -buffsWorkWidth, 0)
				GameTooltip:SetHyperlink(self.spellLink)
				
				local greenCount = #self.greenTooltips
				for i=1,greenCount do
					BuffsLineUptimeTempTable[(i-1)*2+1] = self.greenTooltips[i][1]
					BuffsLineUptimeTempTable[(i-1)*2+2] = self.greenTooltips[i][2]
				end
				for i=1,greenCount do
					local iPos = (i-1)*2+1
					if BuffsLineUptimeTempTable[iPos] then
						for j=1,greenCount do
							local jPos = (j-1)*2+1
							if i~=j and BuffsLineUptimeTempTable[jPos] then
								if BuffsLineUptimeTempTable[jPos] <= BuffsLineUptimeTempTable[iPos] and BuffsLineUptimeTempTable[jPos+1] > BuffsLineUptimeTempTable[iPos] then
									BuffsLineUptimeTempTable[iPos] = BuffsLineUptimeTempTable[jPos]
									BuffsLineUptimeTempTable[iPos+1] = max(BuffsLineUptimeTempTable[jPos+1],BuffsLineUptimeTempTable[iPos+1])
									BuffsLineUptimeTempTable[jPos] = nil
									BuffsLineUptimeTempTable[jPos+1] = nil
								end
								if BuffsLineUptimeTempTable[jPos] and BuffsLineUptimeTempTable[jPos+1] >= BuffsLineUptimeTempTable[iPos+1] and BuffsLineUptimeTempTable[jPos] < BuffsLineUptimeTempTable[iPos+1] then
									BuffsLineUptimeTempTable[iPos] = min(BuffsLineUptimeTempTable[jPos],BuffsLineUptimeTempTable[iPos])
									BuffsLineUptimeTempTable[iPos+1] = BuffsLineUptimeTempTable[jPos+1]
									BuffsLineUptimeTempTable[jPos] = nil
									BuffsLineUptimeTempTable[jPos+1] = nil
								end
							end
						end
					end
				end
				local uptime = 0
				for i=1,greenCount do
					local iPos = (i-1)*2+1
					if BuffsLineUptimeTempTable[iPos] then
						uptime = uptime + (BuffsLineUptimeTempTable[iPos+1] - BuffsLineUptimeTempTable[iPos])
					end
				end
				uptime = uptime / buffsWorkWidth
				
				GameTooltip:AddLine(ExRT.L.BossWatcherBuffsAndDebuffsTooltipUptimeText..": "..format("%.2f%% (%.1f %s)",uptime*100,uptime*(module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart),ExRT.L.BossWatcherBuffsAndDebuffsSecondsText))
				GameTooltip:AddLine(ExRT.L.BossWatcherBuffsAndDebuffsTooltipCountText..": "..(self.greenCount or 0))
				GameTooltip:Show()
			else
				if not self.tooltip then
					self.tooltip = {}
				end
				table.wipe(self.tooltip)
				local owner = nil
				local _min,_max = buffsNameWidth+buffsWorkWidth,buffsNameWidth
				for j = 1,#self.greenTooltips do
					local rightPos = self.greenTooltips[j][2]
					local leftPos = self.greenTooltips[j][1]
					if rightPos - leftPos < 2 then
						rightPos = leftPos + 2
					end
					if x >= leftPos and x <= rightPos then
						local sourceClass = ExRT.F.classColorByGUID(self.greenTooltips[j][5])
						local destClass = ExRT.F.classColorByGUID(self.greenTooltips[j][6])
						local duration = (self.greenTooltips[j][4] - self.greenTooltips[j][3])
						table.insert(self.tooltip, date("[%M:%S", self.greenTooltips[j][3] ) .. format(".%03d",(self.greenTooltips[j][3]*1000)%1000).. " - "..date("%M:%S", self.greenTooltips[j][3]+duration ).. format(".%03d",((self.greenTooltips[j][3]+duration)*1000)%1000).."] " .. "|c" .. sourceClass .. GetGUID(self.greenTooltips[j][5])..GUIDtoText(" (%s)",self.greenTooltips[j][5]).."|r "..ExRT.L.BossWatcherBuffsAndDebuffsTextOn.." |c".. destClass .. GetGUID(self.greenTooltips[j][6])..GUIDtoText(" (%s)",self.greenTooltips[j][6]).."|r")
						if self.greenTooltips[j][7] and self.greenTooltips[j][7] ~= 1 then
							self.tooltip[#self.tooltip] = self.tooltip[#self.tooltip] .. " (".. self.greenTooltips[j][7] ..")"
						end
						self.tooltip[#self.tooltip] = self.tooltip[#self.tooltip] .. format(" <%.1f%s>",duration,ExRT.L.BossWatcherBuffsAndDebuffsSecondsText)
						owner = self.greenTooltips[j][1]
						
						_min = min(_min,leftPos)
						_max = max(_max,rightPos)
					end
				end
				if #self.tooltip > 0 then
					table.sort(self.tooltip,function(a,b) return a < b end)
					ExRT.lib.TooltipShow(self,{"ANCHOR_LEFT",owner or 0,0},ExRT.L.BossWatcherBuffsAndDebuffsTooltipTitle..":",unpack(self.tooltip))
				else
					GameTooltip_Hide()
				end
			end
		end
	end
	local function BuffsLinesOnLeave(self)
		GameTooltip_Hide()
		self.hl:Hide()
	end
	local function BuffsLinesOnClick(self,button)
		local x,y = ExRT.F.GetCursorPos(self)
		if x > 0 and x < buffsTotalWidth and y > 0 and y < 18 then
			if x <= buffsNameWidth then
				ExRT.F.LinkSpell(nil,self.spellLink)
			elseif button == "RightButton" then
				if GameTooltip:IsShown() then
					if BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData then
						wipe(BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData)
					else
						BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData = {}
					end
					table.insert(BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData , self.spellLink)
					for j=2, GameTooltip:NumLines() do
						table.insert(BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData , _G["GameTooltipTextLeft"..j]:GetText())
					end
					BWInterfaceFrame.tab.tabs[3].linesRightClickMenu[1].text = self.spellName
				else
					BWInterfaceFrame.tab.tabs[3].linesRightClickMenuData = nil
				end
				BWInterfaceFrame.tab.tabs[3].linesRightClickMoreInfoData = self.spellID
				EasyMenu(BWInterfaceFrame.tab.tabs[3].linesRightClickMenu, BWInterfaceFrame.tab.tabs[3].linesRightClickMenuDropDown, "cursor", 10 , -15, "MENU")
			end
		end
	end
			
	tab.lines = {}
	for i=1,buffsTotalLines do
		tab.lines[i] = CreateFrame("Button",nil,tab)
		tab.lines[i]:SetSize(buffsTotalWidth,18)
		tab.lines[i]:SetPoint("TOPLEFT", 0, -18*(i-1)-54)
		
		tab.lines[i].spellIcon = tab.lines[i]:CreateTexture(nil, "BACKGROUND")
		tab.lines[i].spellIcon:SetSize(16,16)
		tab.lines[i].spellIcon:SetPoint("TOPLEFT", 5, -1)
		
		tab.lines[i].spellText = ExRT.lib.CreateText(tab.lines[i],(buffsNameWidth-23),18,"TOPLEFT",23,0,"LEFT","MIDDLE",nil,11,"",nil,1,1,1)
		
		tab.lines[i].green = {}
		tab.lines[i].greenFrame = {}
		tab.lines[i].greenCount = 0
		
		tab.lines[i].greenTooltips = {}
		
		ExRT.lib.CreateHoverHighlight(tab.lines[i])
		tab.lines[i].hl:SetAlpha(.5)
		
		tab.lines[i]:SetScript("OnUpdate", BuffsLinesOnUpdate) 
		tab.lines[i]:SetScript("OnLeave", BuffsLinesOnLeave)
		tab.lines[i]:RegisterForClicks("RightButtonUp","LeftButtonUp")
		tab.lines[i]:SetScript("OnClick", BuffsLinesOnClick)
	end
	
	tab.scrollBar = ExRT.lib.CreateScrollBarModern(tab,16,buffsTotalLines*18,-4,-54,1,2,"TOPRIGHT")
	
	local function CreateBuffGreen(i,j)
		BWInterfaceFrame.tab.tabs[3].lines[i].green[j] = BWInterfaceFrame.tab.tabs[3].lines[i]:CreateTexture(nil, "BACKGROUND",nil,5)
		--BWInterfaceFrame.tab.tabs[3].lines[i].green[j]:SetTexture(0.1, 0.7, 0.1, 0.7)
		BWInterfaceFrame.tab.tabs[3].lines[i].green[j]:SetTexture(1, 0.82, 0, 0.7)	
		BWInterfaceFrame.tab.tabs[3].lines[i].greenFrame[j] = CreateFrame("Frame",nil,BWInterfaceFrame.tab.tabs[3].lines[i])
	end
	
	local function buffsFunc_GetNamesFromArray(arr)
		local str = ""
		for GUID,_ in pairs(arr) do
			if str ~= "" then
				str = str .. ", "
			end
			str = str .. GetGUID(GUID)
		end
		return str
	end
	
	local function CreateFilterText()
		local result = ExRT.L.BossWatcherBuffsAndDebuffsFilterSource..": "
		if bit.band(buffsFilterSource,0xF000) > 0 then
			result = result .. (buffsFunc_GetNamesFromArray(buffsFilterSourceGUID))
		elseif bit.band(buffsFilterSource,0x0FFF) == 0x111 then
			result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterAll
		else
			local petsOff = false
			if not (bit.band(buffsFilterSource,0x0F00) > 0) then
				result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterPetsFilterText 
				petsOff = true
			end
			if not (bit.band(buffsFilterSource,0x00FF) == 0x0011) then
				result = result .. (petsOff and "," or "")
				if bit.band(buffsFilterSource,0x00F0) > 0 then
					result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterFriendly
				elseif bit.band(buffsFilterSource,0x000F) > 0 then
					result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterHostile
				else
					result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterNothing
				end
			end
		end
			
		result = result .. "; "..ExRT.L.BossWatcherBuffsAndDebuffsFilterTarget..": "
		if bit.band(buffsFilterDest,0xF000) > 0 then
			result = result .. (buffsFunc_GetNamesFromArray(buffsFilterDestGUID))
		elseif bit.band(buffsFilterDest,0x0FFF) == 0x111 then
			result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterAll
		else
			local petsOff = false
			if not (bit.band(buffsFilterDest,0x0F00) > 0) then
				result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterPetsFilterText
				petsOff = true
			end
			if not (bit.band(buffsFilterDest,0x00FF) == 0x0011) then
				result = result .. (petsOff and "," or "")
				if bit.band(buffsFilterDest,0x00F0) > 0 then
					result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterFriendly
				elseif bit.band(buffsFilterDest,0x000F) > 0 then
					result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterHostile
				else
					result = result .. ExRT.L.BossWatcherBuffsAndDebuffsFilterNothing
				end
			end
		end		
		result = result .. ";"
		
		local isSpecial = nil
		for i=1,#module.db.buffsFilters do
			if module.db.buffsFilterStatus[i] then
				isSpecial = true
				break
			end
		end
		if isSpecial then
			result = result .. " "..ExRT.L.BossWatcherBuffsAndDebuffsFilterSpecial..":"
			for i=1,#module.db.buffsFilters do
				if module.db.buffsFilterStatus[i] then
					result = result .. " " .. strlower(module.db.buffsFilters[i][-1]) .. ";"
				end
			end
		end
		BWInterfaceFrame.tab.tabs[3].filterText:SetText(result)
	end
	
	local function buffsFunc_isPetOrGuard(flag)
		if not flag then
			return false
		end
		local res = ExRT.F.GetUnitInfoByUnitFlag(flag,1)
		if res == 4096 or res == 8192 then
			return true
		end
	end
	local function buffsFunc_findStringInArray(array,str)
		for array_str,_ in pairs(array) do
			if type(array_str) == "string" and (array_str == str or str:find(array_str)) then
				return true
			end
		end
	end
	
	local function UpdateBuffPageDB()
		local fightDuration = (module.db.data[module.db.nowNum].encounterEnd -module.db.data[module.db.nowNum].encounterStart)
		for i=1,10 do
			BWInterfaceFrame.tab.tabs[3].timeLine[i+1].timeText:SetText( date("%M:%S", fightDuration*(i/10) ) )
		end
		
		local _F_sourceGUID = bit.band(buffsFilterSource,0xF000) > 0
		local _F_sourceFriendly = bit.band(buffsFilterSource,0x00F0) > 0
		local _F_sourceHostile = bit.band(buffsFilterSource,0x000F) > 0
		local _F_sourcePets = bit.band(buffsFilterSource,0x0F00) > 0
		
		local _F_destGUID = bit.band(buffsFilterDest,0xF000) > 0
		local _F_destFriendly = bit.band(buffsFilterDest,0x00F0) > 0
		local _F_destHostile = bit.band(buffsFilterDest,0x000F) > 0
		local _F_destPets = bit.band(buffsFilterDest,0x0F00) > 0
		
		local buffTable = {}
		for i,sourceData in ipairs(module.db.nowData.auras) do 
			local spellID = sourceData[6]
			local spellName,_,spellTexture = GetSpellInfo(spellID)
			local filterStatus = true
			for j=5,#module.db.buffsFilters do
				filterStatus = filterStatus and (not module.db.buffsFilterStatus[j] or module.db.buffsFilters[j][spellID])
			end
			if ((not _F_sourceGUID and ((_F_sourcePets or not buffsFunc_isPetOrGuard(module.db.data[module.db.nowNum].reaction[ sourceData[2] ])) and ((_F_sourceFriendly and sourceData[4]) or (_F_sourceHostile and not sourceData[4])))) or (sourceData[2] and buffsFilterSourceGUID[ sourceData[2] ])) and
				((not _F_destGUID and ((_F_destPets or not buffsFunc_isPetOrGuard(module.db.data[module.db.nowNum].reaction[ sourceData[3] ])) and ((_F_destFriendly and sourceData[5]) or (_F_destHostile and not sourceData[5])))) or (sourceData[3] and buffsFilterDestGUID[ sourceData[3] ])) and
				(not module.db.buffsFilterStatus[1] or sourceData[7] == 'BUFF') and
				(not module.db.buffsFilterStatus[2] or sourceData[7] == 'DEBUFF') and
				(not module.db.buffsFilterStatus[3] or module.db.buffsFilters[3][spellID]) and
				(not module.db.buffsFilterStatus[4] or buffsFunc_findStringInArray(module.db.buffsFilters[4],strlower(spellName))) and
				filterStatus then
				
				local time_ = timestampToFightTime( sourceData[1] )
				local time_postion = time_ / fightDuration
				local type_ = sourceData[8]
				
				local buffTablePos
				for j=1,#buffTable do
					if buffTable[j][1] == spellID then
						buffTablePos = j
						break
					end
				end
				if not buffTablePos then
					buffTablePos = #buffTable + 1
					buffTable[buffTablePos] = {spellID,spellName,spellTexture,{},{}}
				end
				
				local sourceGUID = sourceData[2] or 0
				local destGUID = sourceData[3] or 0
				local sourceDest = sourceGUID .. destGUID
				local buffTableBuffPos
				for j=1,#buffTable[buffTablePos][4] do
					if buffTable[buffTablePos][4][j][1] == sourceDest then
						buffTableBuffPos = j
						break
					end
				end
				if not buffTableBuffPos then
					buffTableBuffPos = #buffTable[buffTablePos][4] + 1
					buffTable[buffTablePos][4][buffTableBuffPos] = {sourceDest,sourceGUID,destGUID,{}}
				end
				
				local eventPos = #buffTable[buffTablePos][4][buffTableBuffPos][4] + 1
				
				if type_ == 3 or type_ == 4 then
					buffTable[buffTablePos][4][buffTableBuffPos][4][eventPos] = {0,time_,time_postion,sourceData[9] or 1}
					type_ = 1
					eventPos = eventPos + 1
				end
				buffTable[buffTablePos][4][buffTableBuffPos][4][eventPos] = {type_ % 2,time_,time_postion,sourceData[9] or 1}
			end
		end
		
		table.sort(buffTable,function(a,b) return a[2] < b[2] end)
		
		for i=1,#buffTable do 
			for j=1,#buffTable[i][4] do
				local maxEvents = #buffTable[i][4][j][4]
				if maxEvents > 0 and buffTable[i][4][j][4][1][1] == 0 then
					local newLine = #buffTable[i][5] + 1
					buffTable[i][5][newLine] = {
						buffsNameWidth,
						buffsNameWidth+buffsWorkWidth*buffTable[i][4][j][4][1][3],
						0,
						buffTable[i][4][j][4][1][2],
						buffTable[i][4][j][2],
						buffTable[i][4][j][3],
						1,
					}
				end
				for k=1,maxEvents do
					if buffTable[i][4][j][4][k][1] == 1 then
						local endOfTime = nil
						for n=(k+1),maxEvents do
							if buffTable[i][4][j][4][n][1] == 0 and not endOfTime then
								endOfTime = n
								--break
							end
						end
						local newLine = #buffTable[i][5] + 1
						buffTable[i][5][newLine] = {
							buffsNameWidth+buffsWorkWidth*buffTable[i][4][j][4][k][3],
							buffsNameWidth+buffsWorkWidth*(endOfTime and buffTable[i][4][j][4][endOfTime][3] or 1),
							buffTable[i][4][j][4][k][2],
							endOfTime and buffTable[i][4][j][4][endOfTime][2] or fightDuration,
							buffTable[i][4][j][2],
							buffTable[i][4][j][3],
							buffTable[i][4][j][4][k][4],
						}
						--startPos,endPos,startTime,endTime,sourceGUID,destGUID,stacks
					end
				end
			end
		end
		
		--> Death Line
		for i=1,#BWInterfaceFrame.tab.tabs[3].redDeathLine do
			BWInterfaceFrame.tab.tabs[3].redDeathLine[i]:Hide()
		end
		if _F_destGUID and ExRT.F.table_len(buffsFilterDestGUID) > 0 then
			local j = 0
			for i=1,#module.db.nowData.dies do
				if buffsFilterDestGUID[ module.db.nowData.dies[i][1] ] then
					j = j + 1
					CreateRedDeathLine(j)
					local time_ = timestampToFightTime( module.db.nowData.dies[i][3] )
					local pos = buffsNameWidth + time_/fightDuration*buffsWorkWidth - 1
					BWInterfaceFrame.tab.tabs[3].redDeathLine[j]:SetPoint("TOPLEFT",pos,-42)
					BWInterfaceFrame.tab.tabs[3].redDeathLine[j]:Show()
				end
			end
		end
		
		BWInterfaceFrame.tab.tabs[3].scrollBar:SetValue(1)
		BWInterfaceFrame.tab.tabs[3].scrollBar:SetMinMaxValues(1,max(#buffTable-buffsTotalLines+1,1))		
		BWInterfaceFrame.tab.tabs[3].db = buffTable
		
		ExRT.F.ScheduleTimer(collectgarbage, 1, "collect")
	end
	
	local function UpdateBuffsPage()
		CreateFilterText()
		if not BWInterfaceFrame.tab.tabs[3].db then
			return
		end
		
		local minVal = ExRT.F.Round(BWInterfaceFrame.tab.tabs[3].scrollBar:GetValue())
		local buffTable2 = BWInterfaceFrame.tab.tabs[3].db
		
		local linesCount = 0
		for i=1,buffsTotalLines do
			for j=1,BWInterfaceFrame.tab.tabs[3].lines[i].greenCount do
				BWInterfaceFrame.tab.tabs[3].lines[i].green[j]:Hide()
			end
			BWInterfaceFrame.tab.tabs[3].lines[i].greenCount = 0
			table.wipe(BWInterfaceFrame.tab.tabs[3].lines[i].greenTooltips)
		end
		for i=minVal,#buffTable2 do
			linesCount = linesCount + 1
			local Line = BWInterfaceFrame.tab.tabs[3].lines[linesCount]
			Line.spellIcon:SetTexture(buffTable2[i][3])
			Line.spellText:SetText(buffTable2[i][2] or "???")
			Line.spellLink = GetSpellLink(buffTable2[i][1])
			Line.spellName = buffTable2[i][2] or "Spell"
			Line.spellID = buffTable2[i][1]
			
			for j=1,#buffTable2[i][5] do
				Line.greenCount = Line.greenCount + 1
				local n = Line.greenCount

				if not Line.green[n] then
					CreateBuffGreen(linesCount,n)
				end
				
				Line.green[n]:SetPoint("TOPLEFT",buffTable2[i][5][j][1],0)
				Line.green[n]:SetSize(max(buffTable2[i][5][j][2]-buffTable2[i][5][j][1],0.1),18)
				Line.green[n]:Show()
				
				Line.greenTooltips[#Line.greenTooltips+1] = buffTable2[i][5][j]
			end

			Line:Show()
			if linesCount >= buffsTotalLines then
				break
			end
		end
		for i=(linesCount+1),buffsTotalLines do
			BWInterfaceFrame.tab.tabs[3].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[3].scrollBar:ReButtonsState()
	end

	tab.scrollBar:SetScript("OnValueChanged",UpdateBuffsPage)
	tab:SetScript("OnMouseWheel",function (self,delta)
		if delta > 0 then
			BWInterfaceFrame.tab.tabs[3].scrollBar.buttonUP:Click("LeftButton")
		else
			BWInterfaceFrame.tab.tabs[3].scrollBar.buttonDown:Click("LeftButton")
		end
	end)

	tab.filterFrame = ExRT.lib.CreatePopupFrame(570,465,ExRT.L.BossWatcherBuffsAndDebuffsFilterFilter,true)
	
	tab.filterFrame.HelpButton = ExRT.lib.CreateHelpButton(tab.filterFrame,{
		FramePos = { x = 0, y = 0 },FrameSize = { width = 570, height = 465 },
		[1] = { ButtonPos = { x = 260,	y = -35 },  	HighLightBox = { x = 0, y = 0, width = 570, height = 465 },		ToolTipDir = "DOWN",	ToolTipText = ExRT.L.cd2FilterWindowHelp },
	})
	
	local function UpdateTargetsList(self,isSourceFrame,friendly,hostile,pets)
		table.wipe(self.L)
		table.wipe(self.LGUID)
		if isSourceFrame then
			isSourceFrame = 4
		else
			isSourceFrame = 5
		end
		local list = {}
		for i=1,#module.db.nowData.auras do
			local sourceData = module.db.nowData.auras[i]
			local sourceGUID
			if isSourceFrame == 4 then
				sourceGUID = (friendly and sourceData[isSourceFrame] and sourceData[2]) or (hostile and not sourceData[isSourceFrame] and sourceData[2])
			elseif isSourceFrame == 5 then
				sourceGUID = (friendly and sourceData[isSourceFrame] and sourceData[3]) or (hostile and not sourceData[isSourceFrame] and sourceData[3])
			end
			if sourceGUID and (pets or not buffsFunc_isPetOrGuard(module.db.data[module.db.nowNum].reaction[ sourceGUID ])) then
				local inList = nil
				for j=1,#list do
					if list[j][1] == sourceGUID then
						inList = true
						break
					end
				end
				if not inList then
					list[#list+1] = {sourceGUID,GetGUID(sourceGUID),"|c"..ExRT.F.classColorByGUID(sourceGUID)}
				end
			end
		end

		table.sort(list,function(a,b) 
			if a[2] == b[2] then
				return a[1] < b[1]
			else
				return a[2] < b[2] 
			end
		end)
		
		for i=1,#list do
			self.L[i] = list[i][3] .. list[i][2] 
			self.LGUID[i] = list[i][1]
		end
		self.Update()
	end
	
	tab.filterFrame:SetScript("OnShow",function()
		UpdateTargetsList(BWInterfaceFrame.tab.tabs[3].filterFrame.sourceScroll,true,BWInterfaceFrame.tab.tabs[3].filterFrame.sourceFriendly:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.sourceHostile:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.sourcePets:GetChecked())
		UpdateTargetsList(BWInterfaceFrame.tab.tabs[3].filterFrame.targetScroll,nil,BWInterfaceFrame.tab.tabs[3].filterFrame.targetFriendly:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.targetHostile:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.targetPets:GetChecked())
	end)
	
	tab.filterFrame.sourceScroll = ExRT.lib.CreateScrollList(tab.filterFrame,nil,10,-55,190,20,true)
	tab.filterFrame.sourceScroll.LGUID = {}
	tab.filterFrame.sourceScroll.dontDisable = true
	
	tab.filterFrame.sourceClear = ExRT.lib.CreateButton(tab.filterFrame,190,20,nil,10,-20,ExRT.L.BossWatcherBuffsAndDebuffsFilterClear,nil,nil,"ExRTButtonModernTemplate")
	tab.filterFrame.sourceClear:SetScript("OnClick",function ()
		wipe(buffsFilterSourceGUID)
		buffsFilterSource = 0x0111
		BWInterfaceFrame.tab.tabs[3].filterFrame.sourceFriendly:SetChecked(true)
		BWInterfaceFrame.tab.tabs[3].filterFrame.sourceHostile:SetChecked(true)
		BWInterfaceFrame.tab.tabs[3].filterFrame.sourcePets:SetChecked(true)
		UpdateTargetsList(BWInterfaceFrame.tab.tabs[3].filterFrame.sourceScroll,true,BWInterfaceFrame.tab.tabs[3].filterFrame.sourceFriendly:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.sourceHostile:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.sourcePets:GetChecked())
		BWInterfaceFrame.tab.tabs[3].filterFrame.sourceText:SetText(ExRT.L.BossWatcherBuffsAndDebuffsFilterNone)
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end)
	tab.filterFrame.sourceText = ExRT.lib.CreateText(tab.filterFrame,180,16,nil,15,-40,"LEFT","MIDDLE",nil,11,ExRT.L.BossWatcherBuffsAndDebuffsFilterNone,nil,1,1,1)
	
	tab.filterFrame.sourceFriendly = ExRT.lib.CreateCheckBox(tab.filterFrame,nil,10,-338,ExRT.L.BossWatcherBuffsAndDebuffsFilterFriendly,true,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.filterFrame.sourceHostile = ExRT.lib.CreateCheckBox(tab.filterFrame,nil,10,-363,ExRT.L.BossWatcherBuffsAndDebuffsFilterHostile,true,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.filterFrame.sourcePets = ExRT.lib.CreateCheckBox(tab.filterFrame,nil,10,-388,ExRT.L.BossWatcherBuffsAndDebuffsFilterPets,true,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.filterFrame.sourceFriendly:SetScript("OnClick",function ()
		UpdateTargetsList(BWInterfaceFrame.tab.tabs[3].filterFrame.sourceScroll,true,BWInterfaceFrame.tab.tabs[3].filterFrame.sourceFriendly:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.sourceHostile:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.sourcePets:GetChecked())
		if BWInterfaceFrame.tab.tabs[3].filterFrame.sourceFriendly:GetChecked() then
			buffsFilterSource = bit.bor(buffsFilterSource,0x0010)
		else
			buffsFilterSource = bit.band(buffsFilterSource,0xFF0F)
		end
		if BWInterfaceFrame.tab.tabs[3].filterFrame.sourceHostile:GetChecked() then
			buffsFilterSource = bit.bor(buffsFilterSource,0x0001)
		else
			buffsFilterSource = bit.band(buffsFilterSource,0xFFF0)
		end
		if BWInterfaceFrame.tab.tabs[3].filterFrame.sourcePets:GetChecked() then
			buffsFilterSource = bit.bor(buffsFilterSource,0x0100)
		else
			buffsFilterSource = bit.band(buffsFilterSource,0xF0FF)
		end
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end)
	tab.filterFrame.sourceHostile:SetScript("OnClick",tab.filterFrame.sourceFriendly:GetScript("OnClick"))
	tab.filterFrame.sourcePets:SetScript("OnClick",tab.filterFrame.sourceFriendly:GetScript("OnClick"))
	ExRT.lib.SetPoint(tab.filterFrame.sourceFriendly,"TOPLEFT",tab.filterFrame.sourceScroll,"BOTTOMLEFT",3,-2)
	ExRT.lib.SetPoint(tab.filterFrame.sourceHostile,"TOPLEFT",tab.filterFrame.sourceFriendly,"BOTTOMLEFT",0,-5)
	ExRT.lib.SetPoint(tab.filterFrame.sourcePets,"TOPLEFT",tab.filterFrame.sourceHostile,"BOTTOMLEFT",0,-5)
	
	function tab.filterFrame.sourceScroll:SetListValue(index)
		if not IsShiftKeyDown() then
			buffsFilterSourceGUID = {}
		end
		buffsFilterSourceGUID[ BWInterfaceFrame.tab.tabs[3].filterFrame.sourceScroll.LGUID[index] ] = true
		buffsFilterSource = bit.bor(buffsFilterSource,0x1000)
		BWInterfaceFrame.tab.tabs[3].filterFrame.sourceText:SetText(buffsFunc_GetNamesFromArray(buffsFilterSourceGUID))
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end
	
	function tab.filterFrame.sourceScroll:HoverListValue(isHover,index)
		if not isHover then
			GameTooltip_Hide()
		else
			local owner,ownerGUID,thisGUID
			if ExRT.F.Pets then
				owner = ExRT.F.Pets:getOwnerNameByGUID(self.LGUID[index],GetPetsDB())
			end		
			if VExRT.BossWatcher.GUIDs then
				thisGUID = self.LGUID[index]
				if ExRT.F.Pets then
					ownerGUID = ExRT.F.Pets:getOwnerGUID(self.LGUID[index],GetPetsDB())
				end
			end
			if owner or thisGUID then
				GameTooltip:SetOwner(self,"ANCHOR_CURSOR")
				if thisGUID then
					GameTooltip:AddLine(GUIDtoText("%s",thisGUID))
				end
				if owner then
					GameTooltip:AddLine( format(ExRT.L.BossWatcherPetOwner,owner) .. GUIDtoText(" (%s)",ownerGUID) )
				end
				GameTooltip:Show()
			end
		end
	end

	tab.filterFrame.targetScroll = ExRT.lib.CreateScrollList(tab.filterFrame,nil,210,-55,190,20,true)
	tab.filterFrame.targetScroll.LGUID = {}
	tab.filterFrame.targetScroll.dontDisable = true
	
	tab.filterFrame.targetClear = ExRT.lib.CreateButton(tab.filterFrame,190,20,nil,210,-20,ExRT.L.BossWatcherBuffsAndDebuffsFilterClear,nil,nil,"ExRTButtonModernTemplate")
	tab.filterFrame.targetClear:SetScript("OnClick",function ()
		wipe(buffsFilterDestGUID)
		buffsFilterDest = 0x0111
		BWInterfaceFrame.tab.tabs[3].filterFrame.targetFriendly:SetChecked(true)
		BWInterfaceFrame.tab.tabs[3].filterFrame.targetHostile:SetChecked(true)
		BWInterfaceFrame.tab.tabs[3].filterFrame.targetPets:SetChecked(true)
		UpdateTargetsList(BWInterfaceFrame.tab.tabs[3].filterFrame.targetScroll,nil,BWInterfaceFrame.tab.tabs[3].filterFrame.targetFriendly:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.targetHostile:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.targetPets:GetChecked())
		BWInterfaceFrame.tab.tabs[3].filterFrame.targetText:SetText(ExRT.L.BossWatcherBuffsAndDebuffsFilterNone)
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end)
	tab.filterFrame.targetText = ExRT.lib.CreateText(tab.filterFrame,180,16,nil,215,-40,"LEFT","MIDDLE",nil,11,ExRT.L.BossWatcherBuffsAndDebuffsFilterNone,nil,1,1,1)

	tab.filterFrame.targetFriendly = ExRT.lib.CreateCheckBox(tab.filterFrame,nil,210,-338,ExRT.L.BossWatcherBuffsAndDebuffsFilterFriendly,true,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.filterFrame.targetHostile = ExRT.lib.CreateCheckBox(tab.filterFrame,nil,210,-363,ExRT.L.BossWatcherBuffsAndDebuffsFilterHostile,true,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.filterFrame.targetPets = ExRT.lib.CreateCheckBox(tab.filterFrame,nil,210,-363,ExRT.L.BossWatcherBuffsAndDebuffsFilterPets,true,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.filterFrame.targetFriendly:SetScript("OnClick",function ()
		UpdateTargetsList(BWInterfaceFrame.tab.tabs[3].filterFrame.targetScroll,nil,BWInterfaceFrame.tab.tabs[3].filterFrame.targetFriendly:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.targetHostile:GetChecked(),BWInterfaceFrame.tab.tabs[3].filterFrame.targetPets:GetChecked())
		if BWInterfaceFrame.tab.tabs[3].filterFrame.targetFriendly:GetChecked() then
			buffsFilterDest = bit.bor(buffsFilterDest,0x0010)
		else
			buffsFilterDest = bit.band(buffsFilterDest,0xFF0F)
		end
		if BWInterfaceFrame.tab.tabs[3].filterFrame.targetHostile:GetChecked() then
			buffsFilterDest = bit.bor(buffsFilterDest,0x0001)
		else
			buffsFilterDest = bit.band(buffsFilterDest,0xFFF0)
		end
		if BWInterfaceFrame.tab.tabs[3].filterFrame.targetPets:GetChecked() then
			buffsFilterDest = bit.bor(buffsFilterDest,0x0100)
		else
			buffsFilterDest = bit.band(buffsFilterDest,0xF0FF)
		end
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end)
	tab.filterFrame.targetHostile:SetScript("OnClick",tab.filterFrame.targetFriendly:GetScript("OnClick"))
	tab.filterFrame.targetPets:SetScript("OnClick",tab.filterFrame.targetFriendly:GetScript("OnClick"))
	ExRT.lib.SetPoint(tab.filterFrame.targetFriendly,"TOPLEFT",tab.filterFrame.targetScroll,"BOTTOMLEFT",3,-2)
	ExRT.lib.SetPoint(tab.filterFrame.targetHostile,"TOPLEFT",tab.filterFrame.targetFriendly,"BOTTOMLEFT",0,-5)
	ExRT.lib.SetPoint(tab.filterFrame.targetPets,"TOPLEFT",tab.filterFrame.targetHostile,"BOTTOMLEFT",0,-5)

	function tab.filterFrame.targetScroll:SetListValue(index)
		if not IsShiftKeyDown() then
			buffsFilterDestGUID = {}
		end
		buffsFilterDestGUID[ BWInterfaceFrame.tab.tabs[3].filterFrame.targetScroll.LGUID[index] ] = true
		buffsFilterDest = bit.bor(buffsFilterDest,0x1000)
		BWInterfaceFrame.tab.tabs[3].filterFrame.targetText:SetText(buffsFunc_GetNamesFromArray(buffsFilterDestGUID))
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end
	
 	tab.filterFrame.targetScroll.HoverListValue = tab.filterFrame.sourceScroll.HoverListValue
	
	local function BuffsFilterFrameChkHover(self)
		local i = self.frameNum
		if i == 4 then
			return
		end
		local sList = module.db.buffsFilters[i][-2]
		if not sList then
			sList = {}
			for sid,_ in pairs(module.db.buffsFilters[i]) do
				if sid > 0 then
					sList[#sList + 1] = sid
				end
			end
		end
		if #sList == 0 then
			return
		end
		local sList2 = {}
		if #sList <= 35 then
			for j=1,#sList do
				local sID,_,sT=GetSpellInfo(sList[j])
				if sID then
					sList2[#sList2 + 1] = "|T"..sT..":0|t |cffffffff"..sID.."|r"
				end
			end
		else
			local count = 1
			for j=1,#sList do
				local sID,_,sT=GetSpellInfo(sList[j])
				if sID then
					if not sList2[count] then
						sList2[count] = {"|T"..sT..":0|t |cffffffff"..sID.."|r"}
					elseif not sList2[count].right then
						sList2[count].right = "|cffffffff"..sID.."|r |T"..sT..":0|t"
						count = count + 1
					end
				end
			end
		end
		ExRT.lib.TooltipShow(self,"ANCHOR_LEFT",ExRT.L.BossWatcherFilterTooltip..":",unpack(sList2))
	end
	local function BuffsFilterFrameResetEditBoxBuff(i)
		local resetTable = {}
		for sID,_ in pairs(module.db.buffsFilters[i]) do
			if sID > 0 then
				resetTable[#resetTable + 1] = sID
			end
		end
		for _,sID in ipairs(resetTable) do
			module.db.buffsFilters[i][sID] = nil
		end
	end
	
	local function BuffsFilterFrameChkSpecialClick(self)
		if self:GetChecked() then
			module.db.buffsFilterStatus[self._i] = true
		else
			module.db.buffsFilterStatus[self._i] = nil
		end
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end
	
	tab.filterFrame.chkSpecial = {}
	for i=1,#module.db.buffsFilters do
		local topPosFix = -20-(i-1)*25
		if i > 4 then
			topPosFix = -20-(i+3)*25 
		elseif i > 3 then
			topPosFix = -20-(i+1)*25
		end
		tab.filterFrame.chkSpecial[i] = ExRT.lib.CreateCheckBox(tab.filterFrame,nil,410,topPosFix,module.db.buffsFilters[i][-1],nil,nil,nil,"ExRTCheckButtonModernTemplate")
		tab.filterFrame.chkSpecial[i]._i = i
		tab.filterFrame.chkSpecial[i]:SetScript("OnClick",BuffsFilterFrameChkSpecialClick)
		tab.filterFrame.chkSpecial[i].hover = CreateFrame("Frame",nil,tab.filterFrame)
		tab.filterFrame.chkSpecial[i].hover:SetPoint("TOPLEFT",430,topPosFix)
		tab.filterFrame.chkSpecial[i].hover:SetSize(125,25)
		tab.filterFrame.chkSpecial[i].hover:SetScript("OnEnter",BuffsFilterFrameChkHover)
		tab.filterFrame.chkSpecial[i].hover:SetScript("OnLeave",GameTooltip_Hide)
		tab.filterFrame.chkSpecial[i].hover.frameNum = i

		tab.filterFrame.chkSpecial[i].text:SetWidth(130)
		tab.filterFrame.chkSpecial[i].text:SetJustifyH("LEFT")
	end
	
	local BuffsFilterFrameSceludedUpdateDB = nil
	local function BuffsFilterFrameSceludedUpdateDBFunc()
		BuffsFilterFrameSceludedUpdateDB = nil
		UpdateBuffPageDB()
		UpdateBuffsPage()
	end
	
	tab.filterFrame.chkSpecial[3].ebox = ExRT.lib.CreateMultilineEditBox(tab.filterFrame.chkSpecial[3],145,42,nil,0,0,true)
	tab.filterFrame.chkSpecial[3].ebox.ScrollBar:Hide()
	tab.filterFrame.chkSpecial[3].ebox:SetNewPoint("TOPLEFT",tab.filterFrame.chkSpecial[3],"BOTTOMLEFT",3,-6)
	tab.filterFrame.chkSpecial[3].ebox.EditBox.OnTextChanged = function (self,isUser)
		local text = self:GetText()
		if isUser then
			if text:match("[^0-9\n]") then
				text = string.gsub(text,"[^0-9\n]","")
			end
			self:SetText(text)
		else
			return
		end
		BuffsFilterFrameResetEditBoxBuff(3)
		local lines = {strsplit("\n", text)}
		local isExists = nil
		for i=1,#lines do
			lines[i] = tonumber(lines[i]) or 0
			module.db.buffsFilters[3][ lines[i] ] = true
			isExists = true
		end		
		if isExists then
			if BWInterfaceFrame.tab.tabs[3].filterFrame.chkSpecial[3]:GetChecked() then
				BuffsFilterFrameSceludedUpdateDB = ExRT.F.ScheduleETimer(BuffsFilterFrameSceludedUpdateDB, BuffsFilterFrameSceludedUpdateDBFunc, 0.8)
			end
		end
	end
	local function BuffsFilterFrameEditBoxOnEnter(self)
		GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
		GameTooltip:SetText(ExRT.L.BossWatcherBuffsAndDebuffsFilterEditBoxTooltip)
		GameTooltip:Show()
	end
	tab.filterFrame.chkSpecial[3].ebox.EditBox:SetScript("OnEnter",BuffsFilterFrameEditBoxOnEnter)
	tab.filterFrame.chkSpecial[3].ebox.EditBox:SetScript("OnLeave",GameTooltip_Hide)
	
	tab.filterFrame.chkSpecial[4].ebox = ExRT.lib.CreateMultilineEditBox(tab.filterFrame.chkSpecial[4],145,42,nil,0,0,true)
	tab.filterFrame.chkSpecial[4].ebox.ScrollBar:Hide()
	tab.filterFrame.chkSpecial[4].ebox:SetNewPoint("TOPLEFT",tab.filterFrame.chkSpecial[4],"BOTTOMLEFT",3,-6)
	tab.filterFrame.chkSpecial[4].ebox.EditBox.OnTextChanged = function (self,isUser)
		local text = self:GetText()
		for key,val in pairs(module.db.buffsFilters[4]) do
			if key ~= -1 then
				module.db.buffsFilters[4][key] = nil
			end
		end
		local lines = {strsplit("\n", text)}
		for i=1,#lines do
			if lines[i] ~= "" then
				module.db.buffsFilters[4][ strlower(lines[i]) ] = true
			end
		end		
		if BWInterfaceFrame.tab.tabs[3].filterFrame.chkSpecial[4]:GetChecked() then
			BuffsFilterFrameSceludedUpdateDB = ExRT.F.ScheduleETimer(BuffsFilterFrameSceludedUpdateDB, BuffsFilterFrameSceludedUpdateDBFunc, 0.8)
		end
	end
	tab.filterFrame.chkSpecial[4].ebox.EditBox:SetScript("OnEnter",BuffsFilterFrameEditBoxOnEnter)
	tab.filterFrame.chkSpecial[4].ebox.EditBox:SetScript("OnLeave",GameTooltip_Hide)
	
	tab.filterButton = ExRT.lib.CreateButton(tab,100,20,nil,10,-8,ExRT.L.BossWatcherBuffsAndDebuffsFilterFilter,nil,nil,"ExRTButtonModernTemplate")
	tab.filterButton:SetScript("OnClick",function ()
		BWInterfaceFrame.tab.tabs[3].filterFrame:Show()
	end)
	
	tab.filterText = ExRT.lib.CreateText(tab,700,20,nil,110,-10,"LEFT","MIDDLE",nil,nil,"",nil,1,1,1,1)
	tab.filterText:SetNewPoint("LEFT",tab.filterButton,"RIGHT",10,0)
	CreateFilterText()
	
	tab.filterTextHoverFrame = CreateFrame("Frame",nil,tab)
	tab.filterTextHoverFrame:SetPoint("LEFT",tab.filterButton,"RIGHT",10,0)
	tab.filterTextHoverFrame:SetSize(700,20)
	tab.filterTextHoverFrame:SetScript("OnEnter",function (self)
		local textRegion = BWInterfaceFrame.tab.tabs[3].filterText
		if not textRegion:IsTruncated() then
			return
		end
		GameTooltip:SetOwner(self,"ANCHOR_LEFT")
		GameTooltip:SetText(textRegion:GetText(), nil, nil, nil, nil, true)
		GameTooltip:Show()
	end)
	tab.filterTextHoverFrame:SetScript("OnLeave",function (self)
		GameTooltip_Hide()
	end)

	tab:SetScript("OnShow",function (self)
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			UpdateBuffPageDB()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
		UpdateBuffsPage()
	end)
	
	
	
	
	
	---- Mobs Info & Switch
	tab = BWInterfaceFrame.tab.tabs[4]
	tabName = BWInterfaceFrame_Name.."MobsTab"
	
	local Enemy_GUIDnow = nil
	
	tab.targetsList = ExRT.lib.CreateScrollList(tab,"TOPLEFT",10,-75,290,32,true)
	tab.targetsList.GUIDs = {}
	
	tab.DecorationLine = CreateFrame("Frame",nil,tab)
	tab.DecorationLine:SetPoint("TOPLEFT",tab.targetsList,"TOPRIGHT",0,-1)
	tab.DecorationLine:SetPoint("RIGHT",tab,-3,0)
	tab.DecorationLine:SetHeight(37)
	tab.DecorationLine.texture = tab.DecorationLine:CreateTexture(nil, "BACKGROUND")
	tab.DecorationLine.texture:SetAllPoints()
	tab.DecorationLine.texture:SetTexture(1,1,1,1)
	tab.DecorationLine.texture:SetGradientAlpha("VERTICAL",.24,.25,.30,1,.27,.28,.33,1)
	
	tab.selectedMob = ExRT.lib.CreateText(tab.DecorationLine,530,12,"TOPLEFT",305,-80,"LEFT","TOP",nil,11,"",nil,1,1,1)
	tab.selectedMob:SetNewPoint("TOPLEFT",5,-5)
	tab.infoTabs = ExRT.lib.CreateTabFrameTemplate(tab,530,465,295,-113,"ExRTTabButtonTransparentTemplate",3,1,ExRT.L.BossWatcherSwitchBySpell,ExRT.L.BossWatcherSwitchByTarget,ExRT.L.BossWatcherDamageSwitchTabInfo)
	tab.infoTabs:SetBackdropBorderColor(0,0,0,0)
	tab.infoTabs:SetBackdropColor(0,0,0,0)
	
	tab.switchSpellBox = ExRT.lib.CreateMultilineEditBox(tab.infoTabs.tabs[1],540,440,"TOPLEFT",13,-10,true)
	tab.switchTargetBox = ExRT.lib.CreateMultilineEditBox(tab.infoTabs.tabs[2],540,440,"TOPLEFT",13,-10,true)
	tab.infoBoxText = ExRT.lib.CreateText(tab.infoTabs.tabs[3],540,440,"TOPLEFT",13,-13,"LEFT","TOP",nil,12,ExRT.L.BossWatcherDamageSwitchTabInfoNoInfo,nil,1,1,1)
	
	tab.switchSpellBox.EditBox:SetHyperlinksEnabled(true)
	tab.switchSpellBox.EditBox:SetScript("OnHyperlinkEnter",ExRT.lib.EditBoxOnEnterHyperLinkTooltip)
	tab.switchSpellBox.EditBox:SetScript("OnHyperlinkLeave",ExRT.lib.EditBoxOnLeaveHyperLinkTooltip)
	
	tab.toDamageButton = ExRT.lib.CreateButton(tab.infoTabs,546,20,"BOTTOM",0,5,ExRT.L.BossWatcherShowDamageToTarget,nil,nil,"ExRTButtonModernTemplate")
	tab.toDamageButton:SetNewPoint("BOTTOMLEFT",tab.targetsList,"BOTTOMRIGHT",5,1)
	tab.toDamageButton:SetScript("OnClick",function (self)
		if not Enemy_GUIDnow then
			return
		end
		DamageTab_ShowDamageToTarget(Enemy_GUIDnow)
	end)
	
	function tab.targetsList:SetListValue(index)
		local destGUID = BWInterfaceFrame.tab.tabs[4].targetsList.GUIDs[index]
		
		Enemy_GUIDnow = destGUID
		BWInterfaceFrame.tab.tabs[4].toDamageButton:SetEnabled(true)
		
		wipe(reportData[4][1])
		wipe(reportData[4][2])
		wipe(reportData[4][3])
		
		local _time = timestampToFightTime(module.db.nowData.damage_seen[destGUID])
		local fight_dur = module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart
		
		BWInterfaceFrame.tab.tabs[4].selectedMob:SetText(GetGUID(destGUID).." "..date("%M:%S", _time )..GUIDtoText(" (%s)",destGUID))
		
		_time = _time / fight_dur
		
		local textResult = ""
		local textResult2 = ""
		if module.db.nowData.switch[destGUID] then
			local switchTable = {}

			for sourceGUID,sourceData in pairs(module.db.nowData.switch[destGUID][1]) do
				if ExRT.F.GetUnitTypeByGUID(sourceGUID) == 0 then
					table.insert(switchTable,{GetGUID(sourceGUID),timestampToFightTime(sourceData[1]),sourceGUID,sourceData[2]})
				end
			end
			table.sort(switchTable,function(a,b) return a[2] < b[2] end)
			if #switchTable > 0 then
				textResult = ExRT.L.BossWatcherReportCast.." [" .. date("%M:%S", switchTable[1][2] ) .."]:|n"
				reportData[4][1][1] = GetGUID(destGUID).." > ".. ExRT.L.BossWatcherReportCast.." [" .. date("%M:%S", switchTable[1][2] ) .."]:"
				for i=1,#switchTable do
					local spellName = GetSpellInfo(switchTable[i][4] or 0)
					textResult = textResult ..i..". ".."|c".. ExRT.F.classColorByGUID(switchTable[i][3]).. switchTable[i][1] .. GUIDtoText(" <%s>",switchTable[i][3]) .. "|r (".. format("%.3f",switchTable[i][2]-switchTable[1][2])..", |Hspell:"..(switchTable[i][4] or 0).."|h"..(spellName or "?").."|h)"
					reportData[4][1][#reportData[4][1]+1] = i..". "..switchTable[i][1] .. "(" .. format("%.3f",switchTable[i][2]-switchTable[1][2])..", "..GetSpellLink(switchTable[i][4] or 0)..")"
					if i ~= #switchTable then
						textResult = textResult .. "|n"
					end
				end
				textResult = textResult .. "\n\n"
			end
			
			wipe(switchTable)
			for sourceGUID,sourceData in pairs(module.db.nowData.switch[destGUID][2]) do
				if ExRT.F.GetUnitTypeByGUID(sourceGUID) == 0 then
					table.insert(switchTable,{GetGUID(sourceGUID),sourceData[1] - module.db.data[module.db.nowNum].encounterStart,sourceGUID,sourceData[2]})
				end
			end
			table.sort(switchTable,function(a,b) return a[2] < b[2] end)
			if #switchTable > 0 then
				textResult2 = textResult2 .. ExRT.L.BossWatcherReportSwitch.." [" .. date("%M:%S", switchTable[1][2] ) .."]:|n"
				reportData[4][2][1] = GetGUID(destGUID).." > ".. ExRT.L.BossWatcherReportSwitch.." [" .. date("%M:%S", switchTable[1][2] ) .."]:"
				for i=1,#switchTable do
					textResult2 = textResult2 ..i..". ".. "|c".. ExRT.F.classColorByGUID(switchTable[i][3]).. switchTable[i][1] .. GUIDtoText(" <%s>",switchTable[i][3]) .. "|r (".. format("%.3f",switchTable[i][2]-switchTable[1][2])..")"
					reportData[4][2][#reportData[4][2]+1] = i..". ".. switchTable[i][1].."(" .. format("%.3f",switchTable[i][2]-switchTable[1][2])..")"
					if i ~= #switchTable then
						textResult2 = textResult2 .. "|n"
					end
				end
			end
		end		
		BWInterfaceFrame.tab.tabs[4].switchSpellBox.EditBox:SetText(textResult)
		BWInterfaceFrame.tab.tabs[4].switchTargetBox.EditBox:SetText(textResult2)
		
		--> Other Info
		textResult = ""
		reportData[4][3][1] = GetGUID(destGUID)..":"
		for i=1,#module.db.nowData.dies do
			if module.db.nowData.dies[i][1]==destGUID then
				textResult = textResult .. ExRT.L.BossWatcherDamageSwitchTabInfoRIP..": ".. date("%M:%S", timestampToFightTime(module.db.nowData.dies[i][3]) ) .. date(" (%H:%M:%S)", module.db.nowData.dies[i][3] ) .. "\n"
				reportData[4][3][#reportData[4][3]+1] = ExRT.L.BossWatcherDamageSwitchTabInfoRIP..": ".. date("%M:%S", timestampToFightTime(module.db.nowData.dies[i][3]) ) .. date(" (%H:%M:%S)", module.db.nowData.dies[i][3] )
				for j=1,#module.db.raidTargets do
					if module.db.raidTargets[j] == module.db.nowData.dies[i][4] then
						textResult = textResult .. ExRT.L.BossWatcherMarkOnDeath..": |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_".. j  ..":0|t ".. string.gsub( ExRT.L["raidtargeticon"..j] , "[{}]", "" ) .."\n"
						reportData[4][3][#reportData[4][3]+1] = ExRT.L.BossWatcherMarkOnDeath..": "..string.gsub( ExRT.L["raidtargeticon"..j] , "[{}]", "" )
						break
					end
				end
			end
		end
		local mobID = ExRT.F.GUIDtoID(destGUID)
		local mobSpawnID = 0
		do
			local spawnString = destGUID:match("%-([^%-]+)$") or "0"
			mobSpawnID = tonumber(spawnString, 16) or 0
		end
		textResult = textResult .. "Mob ID: ".. mobID .. "\n"
		textResult = textResult .. "Spawn ID: ".. mobSpawnID .. "\n"
		textResult = textResult .. "GUID: ".. destGUID .. "\n"
		reportData[4][3][#reportData[4][3]+1] = "Mob ID: ".. mobID
		reportData[4][3][#reportData[4][3]+1] = "Spawn ID: ".. mobSpawnID
		reportData[4][3][#reportData[4][3]+1] = "GUID: ".. destGUID
		
		if module.db.nowData.maxHP[destGUID] then
			textResult = textResult .. "Max Health: ".. module.db.nowData.maxHP[destGUID] .. "\n"
			reportData[4][3][#reportData[4][3]+1] = "Max Health:: ".. module.db.nowData.maxHP[destGUID]
		end
		
		BWInterfaceFrame.tab.tabs[4].infoBoxText:SetText(textResult)
	end
	
	function tab.targetsList:HoverListValue(isHover,index)
		if not isHover then
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:Hide()
			BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine:Hide()
			GameTooltip_Hide()
		else
			local mobGUID = BWInterfaceFrame.tab.tabs[4].targetsList.GUIDs[index]
			local mobSeen = timestampToFightTime( module.db.nowData.damage_seen[mobGUID] )
			local fight_dur = module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart
			local _time = mobSeen / fight_dur
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"BOTTOMLEFT",BWInterfaceFrame.timeLineFrame.width*_time,0)
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:Show()
			
			local dieTime = 1
			for i=1,#module.db.nowData.dies do
				if module.db.nowData.dies[i][1]==mobGUID then
					dieTime = timestampToFightTime(module.db.nowData.dies[i][3]) / fight_dur
					break
				end
			end
			BWInterfaceFrame.timeLineFrame.timeLine.lifeUnderLine:SetPoint(_time,dieTime)
			
			GameTooltip:SetOwner(self,"ANCHOR_CURSOR")
			if VExRT.BossWatcher.GUIDs then
				GameTooltip:AddLine(GUIDtoText("%s",mobGUID))
			end
			local scrollPos = ExRT.F.Round( BWInterfaceFrame.tab.tabs[4].targetsList.ScrollBar:GetValue())
			if  BWInterfaceFrame.tab.tabs[4].targetsList.List[index - scrollPos + 1].text:IsTruncated() then
				GameTooltip:AddLine(GetGUID(mobGUID) .. date(" %M:%S", mobSeen) )
			end
			GameTooltip:Show()
		end
	end

	local function UpdateMobsPage()
		table.wipe(BWInterfaceFrame.tab.tabs[4].targetsList.L)
		table.wipe(BWInterfaceFrame.tab.tabs[4].targetsList.GUIDs)
		
		wipe(reportData[4][1])
		wipe(reportData[4][2])
		wipe(reportData[4][3])
		
		local mobsList = {}
		for mobGUID,mobData in pairs(module.db.nowData.damage) do
			local mobID = ExRT.F.GUIDtoID(mobGUID)
			if ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[mobGUID],2) == 512 and (mobID ~= 76933 or VExRT.BossWatcher.showPrismatic) then	--76933 = Mage T100 talent Prismatic Crystal fix
				mobsList[#mobsList+1] = {GetGUID(mobGUID),module.db.nowData.damage_seen[mobGUID],mobGUID}
			end
		end
		table.sort(mobsList,function(a,b) return a[2] < b[2] end)
		for i=1,#mobsList do
			BWInterfaceFrame.tab.tabs[4].targetsList.L[i] =  date("%M:%S ", timestampToFightTime(mobsList[i][2]))..mobsList[i][1]
			BWInterfaceFrame.tab.tabs[4].targetsList.GUIDs[i] = mobsList[i][3]
		end
		BWInterfaceFrame.tab.tabs[4].targetsList.Update()
		
		Enemy_GUIDnow = nil
		BWInterfaceFrame.tab.tabs[4].toDamageButton:SetEnabled(false)
	end

	tab:SetScript("OnShow",function (self)
		BWInterfaceFrame.timeLineFrame:ClearAllPoints()
		BWInterfaceFrame.timeLineFrame:SetPoint("TOP",self,"TOP",0,-10)
		BWInterfaceFrame.timeLineFrame:Show()
		
		BWInterfaceFrame.report:Show()
		
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			UpdateMobsPage()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)
	tab:SetScript("OnHide",function (self)
		BWInterfaceFrame.timeLineFrame:Hide()
		BWInterfaceFrame.report:Hide()
	end)
	
	
	
	
	---- Spells
	tab = BWInterfaceFrame.tab.tabs[5]
	tabName = BWInterfaceFrame_Name.."SpellsTab"
	
	local SpellsTab_Type = 1	--1 - friendly 2 - hostile 3 - spells count
	local SpellsTab_Filter = {}

	tab.playersList = ExRT.lib.CreateScrollList(tab,"TOPLEFT",10,-123,200,29,true)
	tab.playersCastsList = ExRT.lib.CreateScrollList(tab,"TOPLEFT",210,-91,644,31,true)
	tab.playersList.IndexToGUID = {}
	tab.playersCastsList.IndexToGUID = {}
	
	local function SpellsTab_ReloadSpells()
		local selected = BWInterfaceFrame.tab.tabs[5].playersList.selected
		if selected then
			 BWInterfaceFrame.tab.tabs[5].playersList.SetListValue(BWInterfaceFrame.tab.tabs[5].playersList,selected)
		end
	end
	
	local SpellsTab_UpdateFilterHeader = nil
	local function SpellsTab_UpdateFilter(text)
		SpellsTab_UpdateFilterHeader = nil
		wipe(SpellsTab_Filter)
		local spells = {strsplit(";",text)}
		for i=1,#spells do
			if tonumber(spells[i]) then
				spells[i] = tonumber(spells[i])
			end
			SpellsTab_Filter[spells[i]] = true
		end
		SpellsTab_ReloadSpells()
	end
	tab.filterEditBox = ExRT.lib.CreateEditBox(tab,639,16,nil,213,-73,ExRT.L.BossWatcherSpellsFilterTooltip,nil,nil,"ExRTInputBoxModernTemplate")
	tab.filterEditBox:SetScript("OnTextChanged",function (self)
		local text = self:GetText()
		if text == "" then
			ExRT.F.CancelTimer(SpellsTab_UpdateFilterHeader)
			wipe(SpellsTab_Filter)
			SpellsTab_ReloadSpells()
			return
		end
		SpellsTab_UpdateFilterHeader = ExRT.F.ScheduleETimer(SpellsTab_UpdateFilterHeader,SpellsTab_UpdateFilter,0.8,text)
	end)
	
	function tab.playersList:HoverListValue(isHover,index)
		if not isHover then
			GameTooltip_Hide()
		else
			GameTooltip:SetOwner(self,"ANCHOR_CURSOR")
			if VExRT.BossWatcher.GUIDs then
				GameTooltip:AddLine(GUIDtoText("%s",BWInterfaceFrame.tab.tabs[5].playersList.IndexToGUID[index]))
			end
			GameTooltip:Show()
		end
	end
	function tab.playersCastsList:HoverListValue(isHover,index)
		if not isHover then
			GameTooltip_Hide()
			ExRT.lib.HideAdditionalTooltips()
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:Hide()
		else
			local scrollPos = ExRT.F.Round(BWInterfaceFrame.tab.tabs[5].playersCastsList.ScrollBar:GetValue())
			local this = BWInterfaceFrame.tab.tabs[5].playersCastsList.List[index - scrollPos + 1]
			
			local data = BWInterfaceFrame.tab.tabs[5].playersCastsList.IndexToGUID[index]
			GameTooltip:SetOwner(this or self,"ANCHOR_BOTTOMLEFT")
			GameTooltip:SetHyperlink(data[1])
			GameTooltip:Show()
			
			if this.text:IsTruncated() then
				ExRT.lib.AdditionalTooltip(nil,{this.text:GetText()})
			end
			
			if data[2] then
				BWInterfaceFrame.timeLineFrame.timeLine.arrow:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"BOTTOMLEFT",BWInterfaceFrame.timeLineFrame.width*data[2],0)
				BWInterfaceFrame.timeLineFrame.timeLine.arrow:Show()
			end
		end
	end
	
	function tab.playersList:SetListValue(index)
		table.wipe(BWInterfaceFrame.tab.tabs[5].playersCastsList.L)
		table.wipe(BWInterfaceFrame.tab.tabs[5].playersCastsList.IndexToGUID)
		
		local selfGUID = BWInterfaceFrame.tab.tabs[5].playersList.IndexToGUID[index]
		local fight_dur = module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart
		
		local SpellsTab_isFriendly = SpellsTab_Type == 1
		
		if SpellsTab_Type ~= 3 then
			local spells = {}
			if selfGUID then
				for i,PlayerCastData in ipairs(module.db.nowData.cast[selfGUID]) do
					spells[#spells + 1] = {PlayerCastData[1],PlayerCastData[2],PlayerCastData[3],PlayerCastData[4]}
				end
			else
				local reaction = SpellsTab_isFriendly and 256 or 512
				for GUID,dataGUID in pairs(module.db.nowData.cast) do
					if ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[GUID],2) == reaction then
						for i,PlayerCastData in ipairs(dataGUID) do
							spells[#spells + 1] = {PlayerCastData[1],PlayerCastData[2],PlayerCastData[3],PlayerCastData[4],GUID}
						end
					end
				end
				sort(spells,function(a,b) return a[1]<b[1] end)
			end
	
			local isFilterEnabled = ExRT.F.table_len(SpellsTab_Filter) > 0
			for i,data in ipairs(spells) do
				local spellName,_,spellTexture = GetSpellInfo(data[2])
				local time_ = timestampToFightTime(data[1])
				local isCast = ""
				if data[3] == 2 then
					isCast = ExRT.L.BossWatcherBeginCasting.." "
				end
				local sourceName = ""
				if data[5] then
					sourceName = "|c"..ExRT.F.classColorByGUID(data[5])..GetGUID( data[5] )..GUIDtoText(" <%s>",data[5]).."|r "
				end
				local filter = false
				for filterSource,_ in pairs(SpellsTab_Filter) do
					if (type(filterSource) == "number" and filterSource == data[2]) or
					   (type(filterSource) ~= "number" and spellName and string.find(strlower(spellName),strlower(filterSource))) then
						filter = true
						break
					end
				end
				if not isFilterEnabled or filter then
					BWInterfaceFrame.tab.tabs[5].playersCastsList.L[#BWInterfaceFrame.tab.tabs[5].playersCastsList.L + 1] = format("[%02d:%06.3f] ",time_ / 60,time_ % 60)..sourceName..isCast..format("%s%s",spellTexture and "|T"..spellTexture..":0|t " or "",spellName or "???")
					BWInterfaceFrame.tab.tabs[5].playersCastsList.IndexToGUID[#BWInterfaceFrame.tab.tabs[5].playersCastsList.IndexToGUID + 1] = {"spell:"..data[2],time_ / fight_dur,data[2]}
					
					if data[4] and data[4] ~= "" then
						BWInterfaceFrame.tab.tabs[5].playersCastsList.L[#BWInterfaceFrame.tab.tabs[5].playersCastsList.L] = BWInterfaceFrame.tab.tabs[5].playersCastsList.L[#BWInterfaceFrame.tab.tabs[5].playersCastsList.L] .. " > |c"..ExRT.F.classColorByGUID(data[4])..GetGUID( data[4] )..GUIDtoText(" <%s>",data[4]).."|r"
					end
				end
			end
		else
			local spells = {}
			for GUID,dataGUID in pairs(module.db.nowData.cast) do
				if not selfGUID or selfGUID == GUID then
					for i,PlayerCastData in ipairs(module.db.nowData.cast[GUID]) do
						if PlayerCastData[3] ~= 2 then
							local spellID = PlayerCastData[2]
							local inTable = ExRT.F.table_find(spells,spellID,1)
							if not inTable then
								inTable = #spells + 1
								spells[inTable] = {spellID,0}
							end
							spells[inTable][2] = spells[inTable][2] + 1
						end
					end
				end
			end
			sort(spells,function(a,b)return a[2]>b[2] end)
			for i,data in ipairs(spells) do
				local spellName,_,spellTexture = GetSpellInfo(data[1])
				
				BWInterfaceFrame.tab.tabs[5].playersCastsList.L[#BWInterfaceFrame.tab.tabs[5].playersCastsList.L + 1] = data[2].." "..format("%s%s",spellTexture and "|T"..spellTexture..":0|t " or "",spellName or "???")
				BWInterfaceFrame.tab.tabs[5].playersCastsList.IndexToGUID[#BWInterfaceFrame.tab.tabs[5].playersCastsList.IndexToGUID + 1] = {"spell:"..data[1],nil,data[1]}
			end
		end
		
		BWInterfaceFrame.tab.tabs[5].playersCastsList.Update()		
	end
	function tab.playersCastsList:SetListValue(index)
		for j=1,self.linesNum do
			self.List[j]:SetEnabled(true)
		end
		self.selected = nil
		
		local sID = self.IndexToGUID[index][3]
		if self.redSpell == sID then
			self.redSpell = nil
		else
			self.redSpell = sID
		end
		self.Update()
	end
	function tab.playersCastsList:UpdateAdditional(scrollPos)
		for j=1,self.linesNum do
			local index = self.List[j].index
			if self.redSpell and index and self.IndexToGUID[index] and self.IndexToGUID[index][3] == self.redSpell then
				self.List[j].text:SetTextColor(1,0.2,0.2,1)
			else
				self.List[j].text:SetTextColor(1,1,1,1)
			end
		end
	end	
	
	local function UpdateSpellsPage()
		table.wipe(BWInterfaceFrame.tab.tabs[5].playersList.L)
		table.wipe(BWInterfaceFrame.tab.tabs[5].playersList.IndexToGUID)
		table.wipe(BWInterfaceFrame.tab.tabs[5].playersCastsList.L)
		table.wipe(BWInterfaceFrame.tab.tabs[5].playersCastsList.IndexToGUID)
		local playersListTable = {}
		local SpellsTab_isFriendly = SpellsTab_Type == 1
		for sourceGUID,sourceData in pairs(module.db.nowData.cast) do
			if not ExRT.F.table_find(playersListTable,sourceGUID,1) and (SpellsTab_Type == 3 or (SpellsTab_isFriendly and ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[sourceGUID],1) == 1024) or (not SpellsTab_isFriendly and ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[sourceGUID],2) == 512)) then
				playersListTable[#playersListTable + 1] = {sourceGUID,GetGUID( sourceGUID ),"|c"..ExRT.F.classColorByGUID(sourceGUID)}
			end
		end
		table.sort(playersListTable,function (a,b) return a[2] < b[2] end)
		BWInterfaceFrame.tab.tabs[5].playersList.L[1] = ExRT.L.BossWatcherAll
		for i,playersListTableData in ipairs(playersListTable) do
			BWInterfaceFrame.tab.tabs[5].playersList.L[i+1] = playersListTableData[3]..playersListTableData[2]
			BWInterfaceFrame.tab.tabs[5].playersList.IndexToGUID[i+1] = playersListTableData[1]
		end
		
		BWInterfaceFrame.tab.tabs[5].playersList.selected = nil
		
		BWInterfaceFrame.tab.tabs[5].playersList.Update()
		BWInterfaceFrame.tab.tabs[5].playersCastsList.Update()
	end
	
	tab.chkFriendly = CreateFrame("CheckButton",nil,tab,"UIRadioButtonTemplate")  
	tab.chkFriendly:SetPoint("TOPLEFT", 15, -75)
	tab.chkFriendly.text:SetText(ExRT.L.BossWatcherFriendly)
	tab.chkFriendly:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[5].chkEnemy:SetChecked(false)
		BWInterfaceFrame.tab.tabs[5].chkSpellsCount:SetChecked(false)
		SpellsTab_Type = 1
		UpdateSpellsPage()
	end)
	tab.chkFriendly:SetChecked(true)
	tab.chkEnemy = CreateFrame("CheckButton",nil,tab,"UIRadioButtonTemplate")  
	tab.chkEnemy:SetPoint("TOPLEFT", 15, -90)
	tab.chkEnemy.text:SetText(ExRT.L.BossWatcherHostile)
	tab.chkEnemy:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[5].chkFriendly:SetChecked(false)
		BWInterfaceFrame.tab.tabs[5].chkSpellsCount:SetChecked(false)
		SpellsTab_Type = 2
		UpdateSpellsPage()
	end)
	tab.chkSpellsCount = CreateFrame("CheckButton",nil,tab,"UIRadioButtonTemplate")  
	tab.chkSpellsCount:SetPoint("TOPLEFT", 15, -105)
	tab.chkSpellsCount.text:SetText(ExRT.L.BossWatcherSpellsCount)
	tab.chkSpellsCount:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[5].chkFriendly:SetChecked(false)
		BWInterfaceFrame.tab.tabs[5].chkEnemy:SetChecked(false)
		SpellsTab_Type = 3
		UpdateSpellsPage()
	end)

	tab:SetScript("OnShow",function (self)
		BWInterfaceFrame.timeLineFrame:ClearAllPoints()
		BWInterfaceFrame.timeLineFrame:SetPoint("TOP",self,"TOP",0,-10)
		BWInterfaceFrame.timeLineFrame:Show()
		
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			UpdateSpellsPage()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)
	tab:SetScript("OnHide",function (self)
		BWInterfaceFrame.timeLineFrame:Hide()
	end)
	
	
	
	---- Power
	tab = BWInterfaceFrame.tab.tabs[6]
	tabName = BWInterfaceFrame_Name.."PowerTab"
	
	local PowerTab_isFriendly = true

	tab.sourceList = ExRT.lib.CreateScrollList(tab,"TOPLEFT",10,-45,200,25,true)
	tab.sourceList.IndexToGUID = {}
	tab.powerTypeList = ExRT.lib.CreateScrollList(tab,"TOPLEFT",0,0,200,8,true)
	ExRT.lib.SetPoint(tab.powerTypeList,"TOPLEFT",tab.sourceList,"BOTTOMLEFT",0,-3)
	tab.powerTypeList.IndexToGUID = {}
	
	local function EnergyLineOnEnter(self)
		if self.spellID then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:SetHyperlink("spell:"..self.spellID)
			GameTooltip:Show()
		end
	end
	
	tab.text = ExRT.lib.CreateText(tab,420,tab:GetHeight()-10,nil,210,-10,"LEFT","TOP",nil,11,nil,nil,1,1,1,1)
	tab.spells = {}
	for i=1,20 do
		tab.spells[i] = CreateFrame("Frame",nil,tab)
		tab.spells[i]:SetPoint("TOPLEFT",220,-10-28*(i-1))
		tab.spells[i]:SetSize(420,28)
		
		tab.spells[i].texture = tab.spells[i]:CreateTexture(nil,"BACKGROUND")
		tab.spells[i].texture:SetSize(24,24)
		tab.spells[i].texture:SetPoint("TOPLEFT",0,-2)
		
		tab.spells[i].spellName = ExRT.lib.CreateText(tab.spells[i],225,28,nil,26,0,"LEFT","MIDDLE",nil,13,nil,nil,1,1,1,1)
		tab.spells[i].amount = ExRT.lib.CreateText(tab.spells[i],90,28,nil,250,0,"LEFT","MIDDLE",nil,12,nil,nil,1,1,1,1)
		tab.spells[i].count = ExRT.lib.CreateText(tab.spells[i],80,28,nil,340,0,"LEFT","MIDDLE",nil,12,nil,nil,1,1,1,1)
		
		tab.spells[i]:SetScript("OnEnter",EnergyLineOnEnter)
		tab.spells[i]:SetScript("OnLeave",GameTooltip_Hide)
	end
	
	local function EnergyClearLines()
		for i=1,#BWInterfaceFrame.tab.tabs[6].spells do
			BWInterfaceFrame.tab.tabs[6].spells[i]:Hide()
		end
	end
	
	function tab.sourceList:SetListValue(index)
		table.wipe(BWInterfaceFrame.tab.tabs[6].powerTypeList.L)
		table.wipe(BWInterfaceFrame.tab.tabs[6].powerTypeList.IndexToGUID)

		local sourceGUID = BWInterfaceFrame.tab.tabs[6].sourceList.IndexToGUID[index]
		BWInterfaceFrame.tab.tabs[6].sourceGUID = sourceGUID
		local powerList = {}
		for powerType,powerData in pairs(module.db.nowData.power[sourceGUID]) do
			powerList[#powerList + 1] = {powerType,module.db.energyLocale[ powerType ] or ExRT.L.BossWatcherEnergyTypeUnknown..powerType}
		end
		table.sort(powerList,function (a,b) return a[1] < b[1] end)
		for i,powerData in ipairs(powerList) do
			BWInterfaceFrame.tab.tabs[6].powerTypeList.L[i] = powerData[2]
			BWInterfaceFrame.tab.tabs[6].powerTypeList.IndexToGUID[i] = powerData[1]
		end
		
		BWInterfaceFrame.tab.tabs[6].powerTypeList.selected = nil
		BWInterfaceFrame.tab.tabs[6].powerTypeList.Update()
		EnergyClearLines()
	end
	function tab.powerTypeList:SetListValue(index)
		local powerType = BWInterfaceFrame.tab.tabs[6].powerTypeList.IndexToGUID[index]
		local sourceGUID = BWInterfaceFrame.tab.tabs[6].sourceGUID
		
		local spellList = {
			{nil,ExRT.L.BossWatcherReportTotal,"",0,0},
		}
		for spellID,spellData in pairs(module.db.nowData.power[sourceGUID][powerType]) do
			local spellName,_,spellTexture = GetSpellInfo(spellID)
			spellList[#spellList + 1] = {spellID,spellName,spellTexture,spellData[1],spellData[2]}
			spellList[1][4] = spellList[1][4] + spellData[1]
			spellList[1][5] = spellList[1][5] + spellData[2]
		end
		table.sort(spellList,function (a,b) return a[4] > b[4] end)
		EnergyClearLines()
		if #spellList > 1 then
			for i,spellData in ipairs(spellList) do
				local line = BWInterfaceFrame.tab.tabs[6].spells[i]
				if line then
					line.texture:SetTexture(spellData[3])
					line.spellName:SetText(spellData[2])
					line.amount:SetText(spellData[4])
					line.count:SetText(spellData[5].." |4"..ExRT.L.BossWatcherEnergyOnce1..":"..ExRT.L.BossWatcherEnergyOnce2..":"..ExRT.L.BossWatcherEnergyOnce1)
					line.spellID = spellData[1]
					line:Show()
				end
			end
		end
	end

	local function UpdatePowerPage()
		table.wipe(BWInterfaceFrame.tab.tabs[6].sourceList.L)
		table.wipe(BWInterfaceFrame.tab.tabs[6].sourceList.IndexToGUID)
		table.wipe(BWInterfaceFrame.tab.tabs[6].powerTypeList.L)
		table.wipe(BWInterfaceFrame.tab.tabs[6].powerTypeList.IndexToGUID)
		local sourceListTable = {}
		for sourceGUID,sourceData in pairs(module.db.nowData.power) do
			if (PowerTab_isFriendly and ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[sourceGUID],1) == 1024) or (not PowerTab_isFriendly and ExRT.F.GetUnitInfoByUnitFlag(module.db.data[module.db.nowNum].reaction[sourceGUID],2) == 512) then
				sourceListTable[#sourceListTable + 1] = {sourceGUID,GetGUID( sourceGUID ),"|c"..ExRT.F.classColorByGUID(sourceGUID)}
			end
		end
		table.sort(sourceListTable,function (a,b) return a[2] < b[2] end)
		for i,sourceData in ipairs(sourceListTable) do
			BWInterfaceFrame.tab.tabs[6].sourceList.L[i] = sourceData[3]..sourceData[2]
			BWInterfaceFrame.tab.tabs[6].sourceList.IndexToGUID[i] = sourceData[1]
		end
		
		BWInterfaceFrame.tab.tabs[6].sourceList.selected = nil
		BWInterfaceFrame.tab.tabs[6].powerTypeList.selected = nil
		
		BWInterfaceFrame.tab.tabs[6].sourceList.Update()
		BWInterfaceFrame.tab.tabs[6].powerTypeList.Update()
		EnergyClearLines()
	end
	
	tab.chkFriendly = CreateFrame("CheckButton",nil,tab,"UIRadioButtonTemplate")  
	tab.chkFriendly:SetPoint("TOPLEFT", 15, -10)
	tab.chkFriendly.text:SetText(ExRT.L.BossWatcherFriendly)
	tab.chkFriendly:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[6].chkEnemy:SetChecked(false)
		PowerTab_isFriendly = true
		UpdatePowerPage()
	end)
	tab.chkFriendly:SetChecked(true)
	tab.chkEnemy = CreateFrame("CheckButton",nil,tab,"UIRadioButtonTemplate")  
	tab.chkEnemy:SetPoint("TOPLEFT", 15, -25)
	tab.chkEnemy.text:SetText(ExRT.L.BossWatcherHostile)
	tab.chkEnemy:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[6].chkFriendly:SetChecked(false)
		PowerTab_isFriendly = nil
		UpdatePowerPage()
	end)

	tab:SetScript("OnShow",function (self)
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			UpdatePowerPage()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)
	
	
	
	---- Graphics
	tab = BWInterfaceFrame.tab.tabs[8]
	tabName = BWInterfaceFrame_Name.."GraphicsTab"
	local graphsPowerTypeNow,graphsPowerLastName = 0
	local graphsHealthTypeNow,graphsHealthLastName = 1
	
	tab.DecorationLine = CreateFrame("Frame",nil,tab)
	tab.DecorationLine:SetPoint("TOPLEFT",tab,"TOPLEFT",3,-9)
	tab.DecorationLine:SetPoint("RIGHT",tab,-3,0)
	tab.DecorationLine:SetHeight(20)
	tab.DecorationLine.texture = tab.DecorationLine:CreateTexture(nil, "BACKGROUND")
	tab.DecorationLine.texture:SetAllPoints()
	tab.DecorationLine.texture:SetTexture(1,1,1,1)
	tab.DecorationLine.texture:SetGradientAlpha("VERTICAL",.24,.25,.30,1,.27,.28,.33,1)

	tab.graphicsTab = ExRT.lib.CreateTabFrameTemplate(tab,850,555,0,0,"ExRTTabButtonTransparentTemplate",4,1,ExRT.L.BossWatcherGraphicsDPS,ExRT.L.BossWatcherReportHPS,ExRT.L.BossWatcherGraphicsHealth,ExRT.L.BossWatcherGraphicsPower)
	ExRT.lib.SetPoint(tab.graphicsTab,"TOP",0,-29)
	tab.graphicsTab:SetBackdropBorderColor(0,0,0,0)
	tab.graphicsTab:SetBackdropColor(0,0,0,0)
	
	tab.graphicsTab.dropDown = ExRT.lib.CreateScrollDropDown(tab.graphicsTab,"TOPLEFT",15,-10,220,220,10,nil,nil,"ExRTDropDownMenuModernTemplate")
	tab.graph = ExRT.lib.CreateGraph(tab.graphicsTab,760,485,"TOP",0,-50,true)
	tab.graph.isDots = true

	tab.graphicsTab.powerDropDown = ExRT.lib.CreateScrollDropDown(tab.graphicsTab,"TOPLEFT",560,-10,220,200,ExRT.F.table_len(module.db.energyLocale),nil,nil,"ExRTDropDownMenuModernTemplate")
	tab.graphicsTab.powerDropDown:SetText(ExRT.L.BossWatcherSelectPower..module.db.energyLocale[0])

	tab.graphicsTab.healthDropDown = ExRT.lib.CreateScrollDropDown(tab.graphicsTab,"TOPLEFT",560,-10,220,200,2,nil,nil,"ExRTDropDownMenuModernTemplate")
	tab.graphicsTab.healthDropDown:SetText(ExRT.L.BossWatcherSelectPower..(HEALTH or "Health"))
	
	tab.graphicsTab.stepSlider = ExRT.lib.CreateSlider(tab.graphicsTab,250,15,270,-15,1,1,ExRT.L.BossWatcherGraphicsStep,1,nil,nil,true)
	tab.graphicsTab.stepSlider:SetScript("OnValueChanged",function (self,value)
		value = ExRT.F.Round(value)
		self.tooltipText = value
		self:tooltipReload(self)
		if self.disableUpdateFix then
			return
		end
		BWInterfaceFrame.tab.tabs[8].graph.step = value
		BWInterfaceFrame.tab.tabs[8].graph:Reload()
	end)
	tab.graphicsTab.stepSlider:SetScript("OnMinMaxChanged",function (self)
		local _min,_max = self:GetMinMaxValues()
		self.textLow:SetText(_min)
		self.textHigh:SetText(_max)
	end)
	
	tab.graph:SetScript("OnLeave",function ()
		GameTooltip_Hide()
	end)
	
	tab.graphZoomDropDown = CreateFrame("Frame", BWInterfaceFrame_Name.."GraphZoomDropDown", nil, "UIDropDownMenuTemplate")
	function tab.graph:Zoom(start,ending)
		local zoomList = {
			{
				text = ExRT.L.BossWatcherGraphZoom, 
				isTitle = true, 
				notCheckable = true, 
				notClickable = true 
			},
			{
				text = ExRT.L.BossWatcherGraphZoomOnlyGraph,
				notCheckable = true,
				func = function()
					self.ZoomMinX = start
					self.ZoomMaxX = ending
					self:Reload()
				end,
			},
		}
		if module.db.data[module.db.nowNum].improved then
			zoomList[#zoomList + 1] = {
				text = ExRT.L.BossWatcherGraphZoomGlobal,
				notCheckable = true,
				func = function()
					self.ZoomMinX = start
					self.ZoomMaxX = ending
					self:Reload()
					SegmentsPage_ImprovedSelect(start,ending,true)
				end,
			}
		end
		zoomList[#zoomList + 1] = {
			text = ExRT.L.BossWatcherSelectFightClose,
			notCheckable = true,
			func = CloseDropDownMenus_fix,
		}
		EasyMenu(zoomList, BWInterfaceFrame.tab.tabs[8].graphZoomDropDown, "cursor", 10 , -15, "MENU")
	end
	
	local function GraphGetFightMax()
		local i = 0
		for sec,data in pairs(module.db.data[module.db.nowNum].graphData) do
			i=max(sec,i)
		end
		return i
	end
	local function GraphDPSSelect(self,GUID)
		local myGraphData = {}
		local maxFight = GraphGetFightMax()
		for sec=1,maxFight do
			local dpsNow = 0
			for sourceGUID,sourceDPS in pairs(module.db.data[module.db.nowNum].graphData[sec].dps) do
				local owner = nil
				if ExRT.F.Pets then
					owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
				end
				if sourceGUID == GUID or owner == GUID then
					dpsNow = dpsNow + sourceDPS
				end
				if GUID == "_total" and (GetUnitInfoByUnitFlagFix(module.db.data[module.db.nowNum].reaction[sourceGUID],3) == 16 or (owner and GetUnitInfoByUnitFlagFix(module.db.data[module.db.nowNum].reaction[owner],3) == 16)) then
					dpsNow = dpsNow + sourceDPS
				end
			end
			myGraphData[#myGraphData + 1] = {sec,dpsNow,format("%d:%02d",sec/60,sec%60),"%c|n%y"}
		end
		table.sort(myGraphData,function(a,b)return a[1]<b[1] end)
		BWInterfaceFrame.tab.tabs[8].graph.data = myGraphData
		local step = maxFight > 300 and 4 or maxFight > 120 and 3 or maxFight > 60 and 2 or 1
		BWInterfaceFrame.tab.tabs[8].graph.step = step
		BWInterfaceFrame.tab.tabs[8].graph:Reload()
		
		local stepSlider = BWInterfaceFrame.tab.tabs[8].graphicsTab.stepSlider
		stepSlider.disableUpdateFix = true
		stepSlider:SetMinMaxValues(1,max(1,maxFight))
		stepSlider:SetValue(step)
		stepSlider.disableUpdateFix = nil
		BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown:SetText(GUID == "_total" and ExRT.L.BossWatcherGraphicsTotal or GetGUID( GUID ))	
		ExRT.lib.ScrollDropDown.Close()
	end
	local function GraphHPSSelect(self,GUID)
		local myGraphData = {}
		local maxFight = GraphGetFightMax()
		for sec=1,maxFight do
			local hpsNow = 0
			for sourceGUID,sourceHPS in pairs(module.db.data[module.db.nowNum].graphData[sec].hps) do
				local owner = nil
				if ExRT.F.Pets then
					owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
				end
				if sourceGUID == GUID or owner == GUID then
					hpsNow = hpsNow + sourceHPS
				end
				if GUID == "_total" and (GetUnitInfoByUnitFlagFix(module.db.data[module.db.nowNum].reaction[sourceGUID],3) == 16 or (owner and GetUnitInfoByUnitFlagFix(module.db.data[module.db.nowNum].reaction[owner],3) == 16)) then
					hpsNow = hpsNow + sourceHPS
				end
			end
			myGraphData[#myGraphData + 1] = {sec,hpsNow,format("%d:%02d",sec/60,sec%60),"%c|n%y"}
		end
		table.sort(myGraphData,function(a,b)return a[1]<b[1] end)
		BWInterfaceFrame.tab.tabs[8].graph.data = myGraphData
		local step = maxFight > 300 and 4 or maxFight > 120 and 3 or maxFight > 60 and 2 or 1
		BWInterfaceFrame.tab.tabs[8].graph.step = step
		BWInterfaceFrame.tab.tabs[8].graph:Reload()
		
		local stepSlider = BWInterfaceFrame.tab.tabs[8].graphicsTab.stepSlider
		stepSlider.disableUpdateFix = true
		stepSlider:SetMinMaxValues(1,max(1,maxFight))
		stepSlider:SetValue(step)
		stepSlider.disableUpdateFix = nil
		BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown:SetText(GUID == "_total" and ExRT.L.BossWatcherGraphicsTotalHPS or GetGUID( GUID ))	
		ExRT.lib.ScrollDropDown.Close()
	end
	local function GraphHealthSelect(self,name)
		graphsHealthLastName = name
		
		local graphTypeName = graphsHealthTypeNow == 1 and "health" or "absorbs"
	
		local myGraphData = {}
		local maxFight = GraphGetFightMax()
		local startingHealth = 0
		if graphsHealthTypeNow == 1 then
			for sec=1,maxFight do
				local health = module.db.data[module.db.nowNum].graphData[sec][graphTypeName][name] or 0
				if health > startingHealth then
					startingHealth = health
					break
				end
			end
		end
		local percentTextFix = startingHealth > 0 and "%" or ""
		for sec,data in pairs(module.db.data[module.db.nowNum].graphData) do
			local health = data[graphTypeName][name]
			local comment = format("%d:%02d",sec/60,sec%60) .. (data.name[name] and ("|n" ..data.name[name]) or "") .. (startingHealth > 0 and format("|n%.1f",(health or 0) / startingHealth * 100) or "")
			if health then
				myGraphData[#myGraphData + 1] = {sec,health,comment,"%c"..percentTextFix.."|n%y"}
			else
				myGraphData[#myGraphData + 1] = {sec,0,comment,"%c"..percentTextFix.."|n%y"}
			end
		end
		table.sort(myGraphData,function(a,b)return a[1]<b[1] end)
		BWInterfaceFrame.tab.tabs[8].graph.data = myGraphData
		BWInterfaceFrame.tab.tabs[8].graph:Reload()
		
		BWInterfaceFrame.tab.tabs[8].graphicsTab.stepSlider:SetMinMaxValues(1,max(1,maxFight))
		BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown:SetText(name)	
		ExRT.lib.ScrollDropDown.Close()
	end
	local function GraphPowerSelect(self,name)
		graphsPowerLastName = name
	
		local myGraphData = {}
		local maxFight = GraphGetFightMax()
		for sec,data in pairs(module.db.data[module.db.nowNum].graphData) do
			local dataPower = data.power[name]
			local comment = format("%d:%02d",sec/60,sec%60) .. (data.name[name] and ("|n"..data.name[name]) or "")
			if dataPower and dataPower[graphsPowerTypeNow] then
				myGraphData[#myGraphData + 1] = {sec,dataPower[graphsPowerTypeNow],comment,"%c|n%y"}
			else
				myGraphData[#myGraphData + 1] = {sec,0,comment,"%c|n%y"}
			end
		end
		table.sort(myGraphData,function(a,b)return a[1]<b[1] end)
		BWInterfaceFrame.tab.tabs[8].graph.data = myGraphData
		BWInterfaceFrame.tab.tabs[8].graph:Reload()
		
		BWInterfaceFrame.tab.tabs[8].graphicsTab.stepSlider:SetMinMaxValues(1,max(1,maxFight))
		BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown:SetText(name)	
		ExRT.lib.ScrollDropDown.Close()
	end

	local function GraphTabLoad()
		ExRT.lib.ScrollDropDown.Close()
		BWInterfaceFrame.tab.tabs[8].graph.data = {}
		BWInterfaceFrame.tab.tabs[8].graph:Reload()
		BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown:SetText(ExRT.L.BossWatcherGraphicsSelect)	
		table.wipe(BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List)
		BWInterfaceFrame.tab.tabs[8].graphicsTab.stepSlider:SetMinMaxValues(1,1)
		BWInterfaceFrame.tab.tabs[8].graphicsTab.stepSlider:SetValue(1)
		
		BWInterfaceFrame.tab.tabs[8].graphicsTab.powerDropDown:Hide()
		BWInterfaceFrame.tab.tabs[8].graphicsTab.healthDropDown:Hide()
	end
	tab.graphicsTab.tabs[1]:SetScript("OnShow",function (self)
		GraphTabLoad()
		if not module.db.data[module.db.nowNum].graphData then
			return
		end
		local units = {"_total"}
		for i,data in pairs(module.db.data[module.db.nowNum].graphData) do
			for sourceGUID,_ in pairs(data.dps) do
				local GUID = sourceGUID
				if ExRT.F.Pets then
					local owner = ExRT.F.Pets:getOwnerGUID(GUID,GetPetsDB())
					if owner then
						GUID = owner
					end
				end
				if not ExRT.F.table_find(units,GUID) and ExRT.F.GetUnitTypeByGUID(GUID) == 0 then
					units[#units+1] = GUID
				end
			end
		end
		for i=1,#units do
			local info = {}
			BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List[i] = info
			local name = GetGUID( units[i] )
			local color = ""
			local GUIDpatt = ""
			if units[i] == "_total" then
				name = ExRT.L.BossWatcherGraphicsTotal
			else
				color = "|c"..ExRT.F.classColorByGUID(units[i])
				GUIDpatt = " <%s>"
			end
			info.text = color..name..GUIDtoText(GUIDpatt,units[i])
			info.arg1 = units[i]
			info.func = GraphDPSSelect
			info.justifyH = "CENTER"
			info._sort = (units[i] == "_total" and "_total") or name
		end
		table.sort(BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List,function(a,b)return a._sort < b._sort end)
	end)
	tab.graphicsTab.tabs[2]:SetScript("OnShow",function (self)
		GraphTabLoad()
		if not module.db.data[module.db.nowNum].graphData then
			return
		end
		local units = {"_total"}
		for i,data in pairs(module.db.data[module.db.nowNum].graphData) do
			for sourceGUID,_ in pairs(data.hps) do
				local GUID = sourceGUID
				if ExRT.F.Pets then
					local owner = ExRT.F.Pets:getOwnerGUID(GUID,GetPetsDB())
					if owner then
						GUID = owner
					end
				end
				if not ExRT.F.table_find(units,GUID) and ExRT.F.GetUnitTypeByGUID(GUID) == 0 then
					units[#units+1] = GUID
				end
			end
		end
		for i=1,#units do
			local info = {}
			BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List[i] = info
			local name = GetGUID( units[i] )
			local color = ""
			local GUIDpatt = ""
			if units[i] == "_total" then
				name = ExRT.L.BossWatcherGraphicsTotalHPS
			else
				color = "|c"..ExRT.F.classColorByGUID(units[i])
				GUIDpatt = " <%s>"
			end
			info.text = color..name..GUIDtoText(GUIDpatt,units[i])
			info.arg1 = units[i]
			info.func = GraphHPSSelect
			info.justifyH = "CENTER"
			info._sort = (units[i] == "_total" and "_total") or name
		end
		table.sort(BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List,function(a,b)return a._sort < b._sort end)
	end)
	tab.graphicsTab.tabs[3]:SetScript("OnShow",function (self)
		GraphTabLoad()
		BWInterfaceFrame.tab.tabs[8].graphicsTab.healthDropDown:Show()
		if not module.db.data[module.db.nowNum].graphData then
			return
		end
		local units = {}
		for i,data in pairs(module.db.data[module.db.nowNum].graphData) do
			for sourceName,_ in pairs(data.health) do
				if not ExRT.F.table_find(units,sourceName) then
					units[#units+1] = sourceName
				end
			end
		end
		for i=1,#units do
			local info = {}
			BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List[i] = info
			info.text = units[i]
			info.arg1 = units[i]
			info.func = GraphHealthSelect
			info.justifyH = "CENTER" 
		end
		table.sort(BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List,function(a,b)return a.text < b.text end)
	end)
	tab.graphicsTab.tabs[4]:SetScript("OnShow",function (self)
		GraphTabLoad()
		BWInterfaceFrame.tab.tabs[8].graphicsTab.powerDropDown:Show()
		if not module.db.data[module.db.nowNum].graphData then
			return
		end
		local units = {}
		for i,data in pairs(module.db.data[module.db.nowNum].graphData) do
			for sourceName,_ in pairs(data.power) do
				if not ExRT.F.table_find(units,sourceName) then
					units[#units+1] = sourceName
				end
			end
		end
		for i=1,#units do
			local info = {}
			BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List[i] = info
			info.text = units[i]
			info.arg1 = units[i]
			info.func = GraphPowerSelect
			info.justifyH = "CENTER" 
		end
		table.sort(BWInterfaceFrame.tab.tabs[8].graphicsTab.dropDown.List,function(a,b)return a.text < b.text end)
	end)
	
	local function GraphPowerSelectPowerType(_,powerID,powerName)
		graphsPowerTypeNow = powerID
		if graphsPowerLastName then
			GraphPowerSelect(nil,graphsPowerLastName)
		end
		BWInterfaceFrame.tab.tabs[8].graphicsTab.powerDropDown:SetText(ExRT.L.BossWatcherSelectPower..module.db.energyLocale[powerID])
		ExRT.lib.ScrollDropDown.DropDownList:Hide()
	end
	
	for powerID,powerName in pairs(module.db.energyLocale) do
		local info = {}
		BWInterfaceFrame.tab.tabs[8].graphicsTab.powerDropDown.List[ #BWInterfaceFrame.tab.tabs[8].graphicsTab.powerDropDown.List + 1 ] = info
		info.text = powerName
		info.arg1 = powerID
		info.arg2 = powerName
		info.func = GraphPowerSelectPowerType
	end
	table.sort(BWInterfaceFrame.tab.tabs[8].graphicsTab.powerDropDown.List,function(a,b)return a.arg1 < b.arg1 end)
	
	local function GraphPowerSelectHealthType(_,arg)
		graphsHealthTypeNow = arg
		if graphsHealthLastName then
			GraphHealthSelect(nil,graphsHealthLastName)
		end
		local text
		if arg == 1 then
			text = HEALTH
		else
			text = ACTION_SPELL_MISSED_ABSORB
		end
		BWInterfaceFrame.tab.tabs[8].graphicsTab.healthDropDown:SetText(ExRT.L.BossWatcherSelectPower..text)
		ExRT.lib.ScrollDropDown.DropDownList:Hide()
	end	
	tab.graphicsTab.healthDropDown.List[1] = {text = HEALTH,arg1 = 1,func = GraphPowerSelectHealthType}
	tab.graphicsTab.healthDropDown.List[2] = {text = ACTION_SPELL_MISSED_ABSORB,arg1 = 2,func = GraphPowerSelectHealthType}
	
	tab:SetScript("OnShow",function (self)
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			graphsPowerLastName = nil
			graphsHealthLastName = nil
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)

	
	
	
	---- Segments
	tab = BWInterfaceFrame.tab.tabs[10]
	tabName = BWInterfaceFrame_Name.."SegmentsTab"

	BWInterfaceFrame.tab.tabs[3].timeSegments = {}
	BWInterfaceFrame.timeLineFrame.timeLine.timeSegments = {}
	local function CreateBuffSegmentBack(i)
		if not BWInterfaceFrame.tab.tabs[3].timeSegments[i] then
		  	BWInterfaceFrame.tab.tabs[3].timeSegments[i] = CreateFrame("Frame",nil,BWInterfaceFrame.tab.tabs[3])
			BWInterfaceFrame.tab.tabs[3].timeSegments[i].texture = BWInterfaceFrame.tab.tabs[3].timeSegments[i]:CreateTexture(nil, "BACKGROUND",0,-5)
			BWInterfaceFrame.tab.tabs[3].timeSegments[i].texture:SetTexture(1, 1, 0.5, 0.2)
			BWInterfaceFrame.tab.tabs[3].timeSegments[i].texture:SetAllPoints()
		end
		if not BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i] then
			BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i] = BWInterfaceFrame.timeLineFrame.timeLine:CreateTexture(nil, "BACKGROUND",nil,1)
			BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:SetTexture("Interface\\AddOns\\ExRT\\media\\bar9.tga")
			BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:SetVertexColor(0.8, 0.8, 0.8, 1)
		end
	end
	
	local function Segments_UpdateBuffAndTimeLine()
		local count = 0
		for i=1,#BWInterfaceFrame.tab.tabs[10].segmentsList.L do
			if BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] then
				count = count + 1
			end
		end

		if count == #BWInterfaceFrame.tab.tabs[10].segmentsList.L then
			for i=1,#BWInterfaceFrame.tab.tabs[3].timeSegments do
				BWInterfaceFrame.tab.tabs[3].timeSegments[i]:Hide()
			end
			for i=1,#BWInterfaceFrame.timeLineFrame.timeLine.timeSegments do
				BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:Hide()
			end
		else
			local fightDuration = (module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart)
			for i=1,#BWInterfaceFrame.tab.tabs[10].segmentsList.L do
				CreateBuffSegmentBack(i)
				if BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] then
					local timeStart = max(module.db.data[module.db.nowNum].fight[i].timeEx - module.db.data[module.db.nowNum].encounterStart,0)
					local timeEnd = max(module.db.data[module.db.nowNum].fight[i+1] and (module.db.data[module.db.nowNum].fight[i+1].timeEx - module.db.data[module.db.nowNum].encounterStart) or fightDuration,0)
					local startPos = buffsNameWidth+timeStart/fightDuration*buffsWorkWidth
					local endPos = buffsNameWidth+timeEnd/fightDuration*buffsWorkWidth
					BWInterfaceFrame.tab.tabs[3].timeSegments[i]:SetPoint("TOPLEFT",startPos,-42)
					BWInterfaceFrame.tab.tabs[3].timeSegments[i]:SetSize(max(endPos-startPos,0.5),buffsTotalLines * 18 + 14)
					BWInterfaceFrame.tab.tabs[3].timeSegments[i]:Show()
					
					BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:Hide()
				else
					BWInterfaceFrame.tab.tabs[3].timeSegments[i]:Hide()
					
					local timeStart = max(module.db.data[module.db.nowNum].fight[i].timeEx - module.db.data[module.db.nowNum].encounterStart,0)
					local timeEnd = max(module.db.data[module.db.nowNum].fight[i+1] and (module.db.data[module.db.nowNum].fight[i+1].timeEx - module.db.data[module.db.nowNum].encounterStart) or fightDuration,0)
					local tlWidth = BWInterfaceFrame.timeLineFrame.timeLine:GetWidth()
					local startPos = timeStart/fightDuration*tlWidth
					local endPos = timeEnd/fightDuration*tlWidth
					BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:SetPoint("TOPLEFT",startPos,0)
					BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:SetSize(max(endPos-startPos,0.5),BWInterfaceFrame.timeLineFrame.timeLine:GetHeight())
					BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:Show()
				end
			end
			for i=(#BWInterfaceFrame.tab.tabs[10].segmentsList.L + 1),#BWInterfaceFrame.tab.tabs[3].timeSegments do
				BWInterfaceFrame.tab.tabs[3].timeSegments[i]:Hide()
			end
			for i=(#BWInterfaceFrame.tab.tabs[10].segmentsList.L + 1),#BWInterfaceFrame.timeLineFrame.timeLine.timeSegments do
				BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:Hide()
			end
		end
	end
	
	function SegmentsPage_UpdateTextures()
		if BWInterfaceFrame.tab.tabs[10].lastFightID ~= module.db.data[module.db.nowNum].fightID then
			for i=1,#BWInterfaceFrame.tab.tabs[3].timeSegments do
				BWInterfaceFrame.tab.tabs[3].timeSegments[i]:Hide()
			end
			for i=1,#BWInterfaceFrame.timeLineFrame.timeLine.timeSegments do
				BWInterfaceFrame.timeLineFrame.timeLine.timeSegments[i]:Hide()
			end
		end
	end
	
	tab.segmentsText = ExRT.lib.CreateText(tab,240,15,nil,25,-53,"LEFT","TOP",nil,11,ExRT.L.BossWatcherSegments..":",nil,1,1,1,1)
	tab.segmentsList = ExRT.lib.CreateScrollCheckList(tab,nil,15,-70,340,10,true)
	tab.segmentsList:Update()
	function tab.segmentsList:ValueChanged()
		ClearAndReloadData(true)
		local count = 0
		for i=1,#self.L do
			if self.C[i] then
				AddSegmentToData(i)
				count = count + 1
			end
		end
		module.db.lastFightID = module.db.lastFightID + 1
		module.db.data[module.db.nowNum].fightID = module.db.lastFightID
		BWInterfaceFrame.nowFightID = module.db.lastFightID
		BWInterfaceFrame.tab.tabs[10].lastFightID = module.db.lastFightID
		Segments_UpdateBuffAndTimeLine()
	end
	function tab.segmentsList:HoverListValue(isHover,index)
		if not isHover then
			GameTooltip_Hide()
		else
			local scrollPos = ExRT.F.Round(BWInterfaceFrame.tab.tabs[10].segmentsList.ScrollBar:GetValue())
			local textObj = BWInterfaceFrame.tab.tabs[10].segmentsList.List[index - scrollPos + 1].text
			if textObj:IsTruncated() then
				GameTooltip:SetOwner(self,"ANCHOR_CURSOR")
				GameTooltip:AddLine( textObj:GetText() )
				GameTooltip:Show()
			end
		end
	end	
	
	tab.segmentsButtonAll = ExRT.lib.CreateButton(tab,130,20,nil,88,-48,ExRT.L.BossWatcherSegmentSelectAll,nil,nil,"ExRTButtonModernTemplate")
	tab.segmentsButtonAll:SetScript("OnClick",function ()
		for i=1,#BWInterfaceFrame.tab.tabs[10].segmentsList.L do
			BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] = true
		end
		BWInterfaceFrame.tab.tabs[10].segmentsList:Update()
		BWInterfaceFrame.tab.tabs[10].segmentsList:ValueChanged()
	end)
	tab.segmentsButtonNone = ExRT.lib.CreateButton(tab,130,20,nil,224,-48,ExRT.L.BossWatcherSegmentSelectNothing,nil,nil,"ExRTButtonModernTemplate")
	tab.segmentsButtonNone:SetScript("OnClick",function ()
		for i=1,#BWInterfaceFrame.tab.tabs[10].segmentsList.L do
			BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] = nil
		end
		BWInterfaceFrame.tab.tabs[10].segmentsList:Update()
		BWInterfaceFrame.tab.tabs[10].segmentsList:ValueChanged()
	end)
	
	tab.segmentsTooltip = ExRT.lib.CreateText(tab,465,250,nil,365,-50,"LEFT","TOP",nil,12,ExRT.L.BossWatcherSegmentsTooltip,nil,nil,nil,nil,1)
	
	tab.segmentsPreSetList = {
		{ExRT.L.BossWatcherSegmentClear,},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss1,143469,"CHAT_MSG_RAID_BOSS_EMOTE"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss2,143546,"SPELL_AURA_APPLIED",143546,"SPELL_AURA_REMOVED",143812,"SPELL_AURA_APPLIED",143812,"SPELL_AURA_REMOVED",143955,"SPELL_AURA_APPLIED",143955,"SPELL_AURA_REMOVED"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss4,144832,"UNIT_SPELLCAST_SUCCEEDED"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss6,144483,"SPELL_AURA_APPLIED",144483,"SPELL_AURA_REMOVED"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss7,144302,"UNIT_SPELLCAST_SUCCEEDED",},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss8,143593,"SPELL_AURA_APPLIED",143589,"SPELL_AURA_APPLIED",143594,"SPELL_AURA_APPLIED"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss9,142842,"UNIT_SPELLCAST_SUCCEEDED",142879,"SPELL_AURA_APPLIED",142879,"SPELL_AURA_REMOVED"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss11,143440,"SPELL_AURA_APPLIED",143440,"SPELL_AURA_REMOVED"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss13,71161,"UNIT_DIED",71157,"UNIT_DIED",71156,"UNIT_DIED",71155,"UNIT_DIED",71160,"UNIT_DIED",71154,"UNIT_DIED",71152,"UNIT_DIED",71158,"UNIT_DIED",71153,"UNIT_DIED"},
		{ExRT.L.sooitemst16.." - "..ExRT.L.sooitemssooboss14,145235,"UNIT_SPELLCAST_SUCCEEDED",144956,"UNIT_SPELLCAST_SUCCEEDED",146984,"UNIT_SPELLCAST_SUCCEEDED"},

		{ExRT.L.RaidLootT17Highmaul.." - "..ExRT.L.RaidLootHighmaulBoss2,156172,"UNIT_SPELLCAST_SUCCEEDED"},
		{ExRT.L.RaidLootT17Highmaul.." - "..ExRT.L.RaidLootHighmaulBoss4,159996,"UNIT_SPELLCAST_SUCCEEDED"},			
		{ExRT.L.RaidLootT17Highmaul.." - "..ExRT.L.RaidLootHighmaulBoss5,163297,"SPELL_AURA_APPLIED"},			
		{ExRT.L.RaidLootT17Highmaul.." - "..ExRT.L.RaidLootHighmaulBoss6,160734,"SPELL_AURA_APPLIED",160734,"SPELL_AURA_REMOVED"},
		{ExRT.L.RaidLootT17Highmaul.." - "..ExRT.L.RaidLootHighmaulBoss7,158013,"SPELL_AURA_APPLIED",174057,"SPELL_AURA_APPLIED",158012,"SPELL_AURA_APPLIED",157289,"SPELL_AURA_APPLIED",157964,"SPELL_AURA_APPLIED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss1,155539,"SPELL_AURA_APPLIED",155539,"SPELL_AURA_REMOVED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss2,165127,"UNIT_SPELLCAST_SUCCEEDED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss3,155460,"SPELL_AURA_APPLIED",155458,"SPELL_AURA_APPLIED",155459,"SPELL_AURA_APPLIED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss4,155493,"SPELL_AURA_REMOVED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss5,156938,"UNIT_SPELLCAST_SUCCEEDED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss7,163532,"SPELL_AURA_APPLIED",163532,"SPELL_AURA_REMOVED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss8,157060,"SPELL_AURA_APPLIED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss9,156601,"SPELL_AURA_APPLIED"},
		{ExRT.L.RaidLootT17BF.." - "..ExRT.L.RaidLootBFBoss10,161346,"UNIT_SPELLCAST_SUCCEEDED"},
	}
	local function SegmentsSetPreSet(self)
		local id = self.id
		for i=2,27,2 do
			local j = i / 2
			VExRT.BossWatcher.autoSegments[j] = VExRT.BossWatcher.autoSegments[j] or {}
		
			BWInterfaceFrame.tab.tabs[10].autoSegments[j]:SetText( BWInterfaceFrame.tab.tabs[10].segmentsPreSetList[id][i] or "" )
			VExRT.BossWatcher.autoSegments[j][1] = tonumber( BWInterfaceFrame.tab.tabs[10].segmentsPreSetList[id][i] or "" )
			
			local event = BWInterfaceFrame.tab.tabs[10].segmentsPreSetList[id][i+1]
			VExRT.BossWatcher.autoSegments[j][2] = event
			event = event or "UNIT_SPELLCAST_SUCCEEDED"
			local slider = BWInterfaceFrame.tab.tabs[10].autoSegments[j].slider
			local inList = ExRT.F.table_find(slider.List,event,2)
			slider.text:SetText( slider.List[inList][1] )
			slider.tooltipText = slider.List[inList][2]
			slider.selected = inList
		end
		UpdateNewSegmentEvents()
		BWInterfaceFrame.tab.tabs[10].segmentsPreSet.HideByTimer(BWInterfaceFrame.tab.tabs[10].segmentsPreSet)
	end
	tab.segmentsPreSet = ExRT.lib.CreateListFrame(tab,350,#tab.segmentsPreSetList,"RIGHT",nil,846,-225,ExRT.L.BossWatcherSegmentPreSet..":",SegmentsSetPreSet,true)
	local function SegmentsPreSetButtonEnter(self)
		local id = self.id
		local sList = {}
		for i=2,21,2 do
			local spellID = BWInterfaceFrame.tab.tabs[10].segmentsPreSetList[id][i]
			local event = BWInterfaceFrame.tab.tabs[10].segmentsPreSetList[id][i+1]
			if spellID and event then
				local sID,_,sT=GetSpellInfo(spellID)
				if sID and event ~= "UNIT_DIED" then
					table.insert(sList,"|cffffffff"..module.db.autoSegmentEventsL[event].." |T"..sT..":0|t"..sID.."|r")
				elseif event == "UNIT_DIED" then
					table.insert(sList,"|cffffffff"..module.db.autoSegmentEventsL[event].." "..spellID.."|r")
				end
			end
		end
		if #sList > 0 then
			ExRT.lib.TooltipShow(self,"ANCHOR_LEFT",ExRT.L.cd2fastSetupTooltip..":",unpack(sList))
		end
	end
	for i=1,#tab.segmentsPreSetList do
		tab.segmentsPreSet.buttons[i].text:SetText(tab.segmentsPreSetList[i][1])
		tab.segmentsPreSet.buttons[i]:SetScript("OnEnter", SegmentsPreSetButtonEnter)
		tab.segmentsPreSet.buttons[i]:SetScript("OnLeave", ExRT.lib.TooltipHide)
	end

	local Segments_SliderList = {}
	for i,event in ipairs(module.db.autoSegmentEvents) do
		Segments_SliderList[i] = {module.db.autoSegmentEventsL[event],event}
	end
	
	local function Segments_SliderBoxFunc(self)
		local i = self._i
		local selected = self.selected
		if not VExRT.BossWatcher.autoSegments[i] then
			VExRT.BossWatcher.autoSegments[i] = {}
		end
		VExRT.BossWatcher.autoSegments[i][2] = Segments_SliderList[selected][2]	
		UpdateNewSegmentEvents()  
	end
	
	local function EditSliderBoxOnEnterEditBox(self)
		local i = self._i
		local sID = self:GetText()
		sID = tonumber(sID)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:SetText(ExRT.L.BossWatcherSegmentsSpellTooltip)
		if VExRT.BossWatcher.autoSegments[i] and VExRT.BossWatcher.autoSegments[i][2] ~= "UNIT_DIED" and sID and GetSpellInfo(sID) then
			GameTooltip:AddLine(ExRT.L.BossWatcherSegmentNowTooltip)
			GameTooltip:AddSpellByID(sID)
		end			
		GameTooltip:Show()
	end
	
	local function AutoSegmentsEditBoxOnTextChanged(self,isUser)
		if not isUser then
			return
		end
		VExRT.BossWatcher.autoSegments[self._i] = VExRT.BossWatcher.autoSegments[self._i] or {}
		VExRT.BossWatcher.autoSegments[self._i][1] = tonumber(self:GetText())
		VExRT.BossWatcher.autoSegments[self._i][2] = VExRT.BossWatcher.autoSegments[self._i][2] or "UNIT_SPELLCAST_SUCCEEDED" 
		UpdateNewSegmentEvents()
	end

	tab.autoSegments = {}
	for i=1,14 do
		tab.autoSegments[i] = ExRT.lib.CreateEditBox(tab,339,24,nil,15,-250-(i-1)*24,ExRT.L.BossWatcherSegmentsSpellTooltip,6,true,true,VExRT.BossWatcher.autoSegments[i] and VExRT.BossWatcher.autoSegments[i][1] or "")
		tab.autoSegments[i]:SetScript("OnTextChanged",AutoSegmentsEditBoxOnTextChanged)
		tab.autoSegments[i]._i = i
		tab.autoSegments[i]:SetScript("OnEnter",EditSliderBoxOnEnterEditBox)
		
		tab.autoSegments[i]:SetBackdropBorderColor(0.24,0.25,0.30,1)

		local selected = 1
		if VExRT.BossWatcher.autoSegments[i] and VExRT.BossWatcher.autoSegments[i][2] then
			selected = ExRT.F.table_find(module.db.autoSegmentEvents,VExRT.BossWatcher.autoSegments[i][2]) or 1
		end
		tab.autoSegments[i].slider = ExRT.lib.CreateSliderBox(tab,483,24,364,-250-(i-1)*24,Segments_SliderList,selected)
		tab.autoSegments[i].slider.func = Segments_SliderBoxFunc
		tab.autoSegments[i].slider._i = i

		tab.autoSegments[i].slider:SetBackdropBorderColor(0.24,0.25,0.30,1)
		tab.autoSegments[i].slider.left:SetBackdropBorderColor(0.24,0.25,0.30,1)
		tab.autoSegments[i].slider.right:SetBackdropBorderColor(0.24,0.25,0.30,1)
	end
	
	local function UpdateSegmentsPage()
		wipe(BWInterfaceFrame.tab.tabs[10].segmentsList.L)
		wipe(BWInterfaceFrame.tab.tabs[10].segmentsList.C)
		for i=1,#module.db.data[module.db.nowNum].fight do
			local time = module.db.data[module.db.nowNum].fight[i].time - module.db.data[module.db.nowNum].encounterStartGlobal
			local name = module.db.data[module.db.nowNum].fight[i].name
			local subEvent = module.db.data[module.db.nowNum].fight[i].subEvent
			if name then
				local event = name
				name = " "..(module.db.segmentsLNames[name] or name)
				if subEvent then
					name = name.." <"..subEvent..">"
					if (event == "UNIT_SPELLCAST_SUCCEEDED" or event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_APPLIED") and tonumber(subEvent) then
						local spellName = GetSpellInfo( tonumber(subEvent) )
						if spellName then
							name = name .. ": " ..spellName
						end
					elseif event == "UNIT_DIED" and tonumber(subEvent) then
						local mobID = tonumber(subEvent)
						for guid,mobName in pairs(module.db.data[module.db.nowNum].guids) do
							if string.len(guid) > 3 then
								local thisID = ExRT.F.GUIDtoID(guid)
								if thisID == mobID and mobName then
									name = name .. ": " ..mobName
									break
								end
							end
						end
					end
				end
			end
			BWInterfaceFrame.tab.tabs[10].segmentsList.L[i] = date("%M:%S", max(time,0)) .. (name or "")
			BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] = true
		end
		BWInterfaceFrame.tab.tabs[10].segmentsList:Update()
	end
	
	function SegmentsPage_ImprovedSelect(from,to,disableReloadPage,isAdd)
		if BWInterfaceFrame.tab.tabs[10].lastFightID ~= module.db.data[module.db.nowNum].fightID then
			isAdd = nil
		end
		if not isAdd then
			UpdateSegmentsPage()
		end
		if isAdd and from and to then
			for i=1,#module.db.data[module.db.nowNum].fight do
				if (i>=from and i<=to) then
					BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] = true
				end
			end
		else
			for i=1,#module.db.data[module.db.nowNum].fight do
				BWInterfaceFrame.tab.tabs[10].segmentsList.C[i] = not from or not to or (i>=from and i<=to)
			end
		end
		BWInterfaceFrame.tab.tabs[10].segmentsList:Update()
		BWInterfaceFrame.tab.tabs[10].segmentsList:ValueChanged()
		
		if not disableReloadPage then
			local selectedTab = BWInterfaceFrame.tab.selected
			BWInterfaceFrame.tab.tabs[selectedTab]:Hide()
			BWInterfaceFrame.tab.tabs[selectedTab]:Show()
		end
		
		if from and to then
			BWInterfaceFrame.timeLineFrame.timeLine.ImprovedSelectSegment.ResetZoom:Show()
		end
	end
	
	tab:SetScript("OnShow",function (self)
		BWInterfaceFrame.timeLineFrame:ClearAllPoints()
		BWInterfaceFrame.timeLineFrame:SetPoint("TOP",self,"TOP",0,-10)
		BWInterfaceFrame.timeLineFrame:Show()
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			UpdateSegmentsPage()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
		if VExRT.BossWatcher.Improved then
			self.segmentsPreSet.buttonToggle:Hide()
			for i=1,#self.autoSegments do
				self.autoSegments[i]:Hide()
				self.autoSegments[i].slider:Hide()
			end
		else
			self.segmentsPreSet.buttonToggle:Show()
			for i=1,#self.autoSegments do
				self.autoSegments[i]:Show()
				self.autoSegments[i].slider:Show()
			end
		end
	end)
	tab:SetScript("OnHide",function (self)
		BWInterfaceFrame.timeLineFrame:Hide()
	end)
	
	
	
	
	---- Interrupt & dispels
	tab = BWInterfaceFrame.tab.tabs[7]
	tabName = BWInterfaceFrame_Name.."InterruptTab"

	tab.DecorationLine = CreateFrame("Frame",nil,tab)
	tab.DecorationLine:SetPoint("TOPLEFT",tab,"TOPLEFT",3,-80)
	tab.DecorationLine:SetPoint("RIGHT",tab,-3,0)
	tab.DecorationLine:SetHeight(20)
	tab.DecorationLine.texture = tab.DecorationLine:CreateTexture(nil, "BACKGROUND")
	tab.DecorationLine.texture:SetAllPoints()
	tab.DecorationLine.texture:SetTexture(1,1,1,1)
	tab.DecorationLine.texture:SetGradientAlpha("VERTICAL",.24,.25,.30,1,.27,.28,.33,1)

	tab.tabs = ExRT.lib.CreateTabFrameTemplate(tab,845,485,0,0,"ExRTTabButtonTransparentTemplate",2,1,ExRT.L.BossWatcherInterrupts,ExRT.L.BossWatcherDispels)
	ExRT.lib.SetPoint(tab.tabs,"TOP",0,-100)
	tab.tabs:SetBackdropBorderColor(0,0,0,0)
	tab.tabs:SetBackdropColor(0,0,0,0)
	
	local Intterupt_Type = 1
	local UpdateInterruptPage = nil
	
	function tab.tabs:buttonAdditionalFunc()
		UpdateInterruptPage()
	end
	
	tab.bySource = CreateFrame("CheckButton",nil,tab.tabs,"UIRadioButtonTemplate")  
	tab.bySource:SetPoint("TOPLEFT", 10, -3)
	tab.bySource.text:SetText(ExRT.L.BossWatcherBySource)
	tab.bySource:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[7].byTarget:SetChecked(false)
		BWInterfaceFrame.tab.tabs[7].bySpell:SetChecked(false)
		Intterupt_Type = 1
		UpdateInterruptPage()
	end)
	tab.byTarget = CreateFrame("CheckButton",nil,tab.tabs,"UIRadioButtonTemplate")  
	tab.byTarget:SetPoint("TOPLEFT", 10, -18)
	tab.byTarget.text:SetText(ExRT.L.BossWatcherByTarget)
	tab.byTarget:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[7].bySource:SetChecked(false)
		BWInterfaceFrame.tab.tabs[7].bySpell:SetChecked(false)
		Intterupt_Type = 2
		UpdateInterruptPage()
	end)
	tab.bySpell = CreateFrame("CheckButton",nil,tab.tabs,"UIRadioButtonTemplate")  
	tab.bySpell:SetPoint("TOPLEFT", 10, -33)
	tab.bySpell.text:SetText(ExRT.L.BossWatcherBySpell)
	tab.bySpell:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		BWInterfaceFrame.tab.tabs[7].byTarget:SetChecked(false)
		BWInterfaceFrame.tab.tabs[7].bySource:SetChecked(false)
		Intterupt_Type = 3
		UpdateInterruptPage()
	end)
	tab.bySource:SetChecked(true)
	
	tab.list = ExRT.lib.CreateScrollList(tab.tabs,"TOPLEFT",0,-50,200,27,true)
	tab.list.GUIDs = {}
	
	tab.events = ExRT.lib.CreateScrollList(tab.tabs,"TOPLEFT",200,-2,644,30,true)
	tab.events.DATA = {}
	
	function tab.list:SetListValue(index)
		local filter = BWInterfaceFrame.tab.tabs[7].list.GUIDs[index]
		local isInterrupt = BWInterfaceFrame.tab.tabs[7].tabs.selected == 1
		local workTable = module.db.nowData.interrupts
		if not isInterrupt then
			workTable = module.db.nowData.dispels
		end
		local data = {}
		table.wipe(BWInterfaceFrame.tab.tabs[7].events.L)
		table.wipe(BWInterfaceFrame.tab.tabs[7].events.DATA)
		for i,line in ipairs(workTable) do
			local isOkay = false
			if (Intterupt_Type == 1 and (not filter or line[1] == filter)) or
			   (Intterupt_Type == 2 and (not filter or line[2] == filter)) or
			   (Intterupt_Type == 3 and (not filter or line[4] == filter)) then
				isOkay = true
			end
			if isOkay then
				local spellSourceName,_,spellSourceTexture = GetSpellInfo(line[3])
				local spellDestName,_,spellDestTexture = GetSpellInfo(line[4])
				local dispelOrInterrupt = ExRT.L.BossWatcherDispelText
				if isInterrupt then
					dispelOrInterrupt = ExRT.L.BossWatcherInterruptText
				end
				BWInterfaceFrame.tab.tabs[7].events.L[#BWInterfaceFrame.tab.tabs[7].events.L + 1] = "[".. date("%M:%S", timestampToFightTime(line[5])).."] |c".. ExRT.F.classColorByGUID(line[1]) .. GetGUID(line[1]) .. GUIDtoText(" (%s)",line[1]) .. "|r "..dispelOrInterrupt.." |c" ..  ExRT.F.classColorByGUID(line[2]).. GetGUID(line[2]) .. "'s" .. GUIDtoText(" (%s)",line[2]) .. "|r |Hspell:" .. (line[4] or 0) .. "|h" .. format("%s%s",spellDestTexture and "|T"..spellDestTexture..":0|t " or "",spellDestName or "???") .. "|h "..ExRT.L.BossWatcherByText.." |Hspell:" .. (line[3] or 0) .. "|h" .. format("%s%s",spellSourceTexture and "|T"..spellSourceTexture..":0|t " or "",spellSourceName or "???") .. "|h"
				BWInterfaceFrame.tab.tabs[7].events.DATA[#BWInterfaceFrame.tab.tabs[7].events.L] = line
			end
		end
		BWInterfaceFrame.tab.tabs[7].events.Update()
	end
	function tab.events:SetListValue(index)
		self.selected = nil
		self.Update()
	end
	function tab.events:HoverListValue(isHover,index)
		if not isHover then
			GameTooltip_Hide()
			ExRT.lib.HideAdditionalTooltips()
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:Hide()
		else
			local scrollPos = ExRT.F.Round(BWInterfaceFrame.tab.tabs[7].events.ScrollBar:GetValue())
			local this = BWInterfaceFrame.tab.tabs[7].events.List[index - scrollPos + 1]
			local line = BWInterfaceFrame.tab.tabs[7].events.DATA[index]
			
			GameTooltip:SetOwner(this or self,"ANCHOR_BOTTOMLEFT")
			GameTooltip:SetHyperlink("spell:"..line[4])
			GameTooltip:Show()
			
			ExRT.lib.AdditionalTooltip("spell:"..line[3])
			
			if this.text:IsTruncated() then
				ExRT.lib.AdditionalTooltip(nil,{this.text:GetText()})
			end
			
			local _time = timestampToFightTime(line[5]) / ( module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart )
			
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:SetPoint("TOPLEFT",BWInterfaceFrame.timeLineFrame.timeLine,"BOTTOMLEFT",BWInterfaceFrame.timeLineFrame.width*_time,0)
			BWInterfaceFrame.timeLineFrame.timeLine.arrow:Show()
		end
	end

	function UpdateInterruptPage()
		table.wipe(BWInterfaceFrame.tab.tabs[7].list.L)
		table.wipe(BWInterfaceFrame.tab.tabs[7].list.GUIDs)
		table.wipe(BWInterfaceFrame.tab.tabs[7].events.L)
		
		local workTable = module.db.nowData.interrupts
		if BWInterfaceFrame.tab.tabs[7].tabs.selected == 2 then
			workTable = module.db.nowData.dispels
		end
		local data = {}
		for i,line in ipairs(workTable) do
			if Intterupt_Type == 1 then
				if not ExRT.F.table_find(data,line[1]) then
					data[#data + 1] = line[1]
				end
			elseif Intterupt_Type == 2 then
				if not ExRT.F.table_find(data,line[2]) then
					data[#data + 1] = line[2]
				end
			else
				if not ExRT.F.table_find(data,line[4]) then
					data[#data + 1] = line[4]
				end
			end
		end
		local data2 = {}
		for i=1,#data do
			if Intterupt_Type ~= 3 then
				data2[i] = {data[i],GetGUID(data[i]),"|c"..ExRT.F.classColorByGUID(data[i])}
			else
				local spellName = GetSpellInfo(data[i])
				data2[i] = {data[i],spellName}
			end
		end
		sort(data2,function(a,b)return a[2]<b[2] end)
		for i=1,#data2 do
			BWInterfaceFrame.tab.tabs[7].list.L[i+1] = (data2[i][3] or "")..data2[i][2]
			BWInterfaceFrame.tab.tabs[7].list.GUIDs[i+1] = data2[i][1]
		end
		BWInterfaceFrame.tab.tabs[7].list.L[1] = ExRT.L.BossWatcherAll
		
		BWInterfaceFrame.tab.tabs[7].list.selected = nil
		
		BWInterfaceFrame.tab.tabs[7].list.Update()
		BWInterfaceFrame.tab.tabs[7].events.Update()
	end

	tab:SetScript("OnShow",function (self)
		BWInterfaceFrame.timeLineFrame:ClearAllPoints()
		BWInterfaceFrame.timeLineFrame:SetPoint("TOP",self,"TOP",0,-10)
		BWInterfaceFrame.timeLineFrame:Show()
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			UpdateInterruptPage()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)
	tab:SetScript("OnHide",function (self)
		BWInterfaceFrame.timeLineFrame:Hide()
	end)


	
	
	---- Heal
	tab = BWInterfaceFrame.tab.tabs[2]
	tabName = BWInterfaceFrame_Name.."HealingTab"
	
	local HsourceVar,HdestVar = {},{}
	local HealingTab_SetLine = nil
	local HealingShowOverheal = false
	local Healing_Last_Func = nil
	local Healing_Last_doEnemy = nil
	
	local function HealingTab_UpdateDropDown(arr,dropDown)
		local count = ExRT.F.table_len(arr)
		if count == 0 then
			dropDown:SetText(ExRT.L.BossWatcherAll)
		elseif count == 1 then
			local GUID = nil
			for g,_ in pairs(arr) do
				GUID = g
			end
			local name = GetGUID(GUID)
			local flags = module.db.data[module.db.nowNum].reaction[GUID]
			local isPlayer = ExRT.F.GetUnitInfoByUnitFlag(flags,1) == 1024
			local isNPC = ExRT.F.GetUnitInfoByUnitFlag(flags,2) == 512
			if isPlayer then
				name = "|c"..ExRT.F.classColorByGUID(GUID)..name
			elseif isNPC then
				name = name .. GUIDtoText(" [%s]",GUID)
			end
			dropDown:SetText(name)
		else
			dropDown:SetText(ExRT.L.BossWatcherSeveral)
		end
	end
	
	local function HealingTab_UpdateDropDownSource()
		HealingTab_UpdateDropDown(HsourceVar,BWInterfaceFrame.tab.tabs[2].sourceDropDown)
	end
	local function HealingTab_UpdateDropDownDest()
		HealingTab_UpdateDropDown(HdestVar,BWInterfaceFrame.tab.tabs[2].targetDropDown)
	end
	
	local HealingTab_UpdateDropDownType = nil
	do
		local dropDownNames = {
			{ExRT.L.BossWatcherHealFriendly,ExRT.L.BossWatcherHealFriendlyByTarget,ExRT.L.BossWatcherHealFriendlyBySpell},
			{ExRT.L.BossWatcherHealHostile,ExRT.L.BossWatcherHealHostileByTarget,ExRT.L.BossWatcherHealHostileBySpell},
		}
		function HealingTab_UpdateDropDownType(type,doEnemy)
			local isEnemy = doEnemy and 2 or 1
			BWInterfaceFrame.tab.tabs[2].typeDropDown:SetText(dropDownNames[isEnemy][type])
		end
	end
	
	local function HealingTab_UpdateLinesPlayers(doEnemy)
		HealingTab_UpdateDropDownSource()
		HealingTab_UpdateDropDownDest()
		HealingTab_UpdateDropDownType(1,doEnemy)
		Healing_Last_Func = HealingTab_UpdateLinesPlayers
		Healing_Last_doEnemy = doEnemy
		local heal = {}
		local total = 0
		local totalOver = 0
		for sourceGUID,sourceData in pairs(module.db.nowData.heal) do
			local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
			if owner then
				sourceGUID = owner
			end
			if ExRT.F.table_len(HsourceVar) == 0 or HsourceVar[sourceGUID] then
				for destGUID,destData in pairs(sourceData) do
					local isEnemy = not ExRT.F.UnitIsFriendlyByUnitFlag2(module.db.data[module.db.nowNum].reaction[destGUID])
					if ExRT.F.table_len(HdestVar) == 0 or HdestVar[destGUID] then
						if (isEnemy and doEnemy) or (not isEnemy and not doEnemy) then
							local inDamagePos = ExRT.F.table_find(heal,sourceGUID,1)
							if not inDamagePos then
								inDamagePos = #heal + 1
								heal[inDamagePos] = {sourceGUID,0,0,0,0,0,0,{},0}
							end
							local destPos = ExRT.F.table_find(heal[inDamagePos][8],destGUID,1)
							if not destPos then
								destPos = #heal[inDamagePos][8] + 1
								heal[inDamagePos][8][destPos] = {destGUID,0}
							end
							destPos = heal[inDamagePos][8][destPos]
							
							for spellID,spellAmount in pairs(destData) do
								heal[inDamagePos][2] = heal[inDamagePos][2] + spellAmount.amount - spellAmount.over + spellAmount.absorbed
								heal[inDamagePos][3] = heal[inDamagePos][3] + spellAmount.amount 						--total
								heal[inDamagePos][4] = heal[inDamagePos][4] + spellAmount.over 							--overheal
								heal[inDamagePos][5] = heal[inDamagePos][5] + spellAmount.absorbed 						--absorbed
								if HealingShowOverheal then
									heal[inDamagePos][6] = heal[inDamagePos][6] + spellAmount.crit
									heal[inDamagePos][7] = heal[inDamagePos][7] + spellAmount.ms
								else
									heal[inDamagePos][6] = heal[inDamagePos][6] + spellAmount.crit - spellAmount.critover
									heal[inDamagePos][7] = heal[inDamagePos][7] + spellAmount.ms - spellAmount.msover					
								end
								heal[inDamagePos][9] = heal[inDamagePos][9] + spellAmount.absorbs						--absorbs
								total = total + spellAmount.amount - spellAmount.over + spellAmount.absorbed
								totalOver = totalOver + spellAmount.over
								
								destPos[2] = destPos[2] + spellAmount.amount + spellAmount.absorbed + (HealingShowOverheal and 0 or -spellAmount.over)
							end
						end
					end
				end
			end
		end
		local totalIsFull = 1
		total = max(total,1)
		if total == 1 and #heal == 0 then
			total = 0
			totalIsFull = 0
		end
		local _max = nil
		reportOptions[2] = ExRT.L.BossWatcherReportHPS
		wipe(reportData[2])
		reportData[2][1] = (DamageTab_GetGUIDsReport(HsourceVar) or ExRT.L.BossWatcherAllSources).." > "..(DamageTab_GetGUIDsReport(HdestVar) or ExRT.L.BossWatcherAllTargets)
		local activeFightLength = GetFightLength()
		if not HealingShowOverheal then
			local hps = total / activeFightLength
			reportData[2][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total).."@1@ ("..floor(hps)..")@1#"
			sort(heal,function(a,b) return a[2]>b[2] end)
			_max = heal[1] and heal[1][2] or 0
			HealingTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total,hps)
		else
			local hps = (total + totalOver) / activeFightLength
			reportData[2][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total + totalOver).."@1@ ("..floor(hps)..")@1#"
			sort(heal,function(a,b) return (a[2]+a[4])>(b[2]+b[4]) end)
			_max = heal[1] and (heal[1][2]+heal[1][4]) or 0
			HealingTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total + totalOver,hps,nil,nil,nil,nil,nil,nil,totalOver / max(total + totalOver,1))
		end
		for i=1,#heal do
			local class = nil
			if heal[i][1] and heal[i][1] ~= "" then
				class = select(2,GetPlayerInfoByGUID(heal[i][1]))
			end
			local icon = ""
			if class and CLASS_ICON_TCOORDS[class] then
				icon = {"Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",unpack(CLASS_ICON_TCOORDS[class])}
			end
			local tooltipData = {GetGUID(heal[i][1]),
				{ExRT.L.BossWatcherHealTooltipOver,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][4]),heal[i][4]/max(heal[i][2]+heal[i][4],1)*100)},
				{ExRT.L.BossWatcherHealTooltipAbsorbed,ExRT.F.shortNumber(heal[i][5])},
				{ExRT.L.BossWatcherHealTooltipTotal,ExRT.F.shortNumber(heal[i][3])},
				{" "," "},
				{ExRT.L.BossWatcherHealTooltipFromCrit,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][6]),heal[i][6]/max(1,heal[i][2]+(HealingShowOverheal and heal[i][4] or 0))*100)},
				{ExRT.L.BossWatcherHealTooltipFromMs,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][7]),heal[i][7]/max(1,heal[i][2]+(HealingShowOverheal and heal[i][4] or 0))*100)},
				{ACTION_SPELL_MISSED_ABSORB,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][9]),heal[i][9]/max(heal[i][2]+(HealingShowOverheal and heal[i][4] or 0),1)*100)},
			}
			sort(heal[i][8],DamageTab_Temp_SortingBy2Param)
			if #heal[i][8] > 0 then
				tooltipData[#tooltipData + 1] = {" "," "}
				tooltipData[#tooltipData + 1] = {ExRT.L.BossWatcherHealTooltipTargets," "}
			end
			for j=1,min(5,#heal[i][8]) do
				tooltipData[#tooltipData + 1] = {SubUTF8String(GetGUID(heal[i][8][j][1]),20)..GUIDtoText(" [%s]",heal[i][8][j][1]),format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][8][j][2]),min(heal[i][8][j][2] / max(1,heal[i][2]+(HealingShowOverheal and (heal[i][4]) or 0))*100,100))}
			end
			if not HealingShowOverheal then
				local hps = heal[i][2]/activeFightLength
				HealingTab_SetLine(i+1,icon,GetGUID(heal[i][1])..GUIDtoText(" [%s]",heal[i][1]),heal[i][2]/total,heal[i][2]/max(_max,1),heal[i][2],hps,class,heal[i][1],doEnemy,nil,tooltipData,nil,heal[i][9]/max(1,heal[i][2]))
				reportData[2][#reportData[2]+1] = i..". "..GetGUID(heal[i][1]).." - "..ExRT.F.shortNumber(heal[i][2]).."@1@ ("..floor(hps)..")@1#"
			else
				local hps = (heal[i][2]+heal[i][4])/activeFightLength
				HealingTab_SetLine(i+1,icon,GetGUID(heal[i][1])..GUIDtoText(" [%s]",heal[i][1]),(heal[i][2]+heal[i][4])/(total+totalOver),(heal[i][2]+heal[i][4])/max(_max,1),(heal[i][2]+heal[i][4]),hps,class,heal[i][1],doEnemy,nil,tooltipData,nil,heal[i][4] / max(heal[i][2]+heal[i][4],1))			
				reportData[2][#reportData[2]+1] = i..". "..GetGUID(heal[i][1]).." - "..ExRT.F.shortNumber(heal[i][2]+heal[i][4]).."@1@ ("..floor(hps)..")@1#"
			end
		end
		for i=#heal+2,#BWInterfaceFrame.tab.tabs[2].lines do
			BWInterfaceFrame.tab.tabs[2].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[2].scroll.SetNewHeight(BWInterfaceFrame.tab.tabs[2].scroll,(#heal+1) * 20)
	end
	local function HealingTab_UpdateLinesSpell(doEnemy)
		HealingTab_UpdateDropDownSource()
		HealingTab_UpdateDropDownDest()
		HealingTab_UpdateDropDownType(3,doEnemy)
		Healing_Last_Func = HealingTab_UpdateLinesSpell
		Healing_Last_doEnemy = doEnemy
		local heal = {}
		local total = 0
		local totalOver = 0
		for sourceGUID,sourceData in pairs(module.db.nowData.heal) do
			local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
			if owner then
				sourceGUID = owner
			end
			if ExRT.F.table_len(HsourceVar) == 0 or HsourceVar[sourceGUID] then
				for destGUID,destData in pairs(sourceData) do
					local isEnemy = not ExRT.F.UnitIsFriendlyByUnitFlag2(module.db.data[module.db.nowNum].reaction[destGUID])
					if ExRT.F.table_len(HdestVar) == 0 or HdestVar[destGUID] then
						if (isEnemy and doEnemy) or (not isEnemy and not doEnemy) then
							for spellID,spellAmount in pairs(destData) do
								if owner then
									spellID = -spellID
								end							
								local inDamagePos = ExRT.F.table_find(heal,spellID,1)
								if not inDamagePos then
									inDamagePos = #heal + 1
									heal[inDamagePos] = {spellID,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,{}}
								end
								
								local destPos = ExRT.F.table_find(heal[inDamagePos][17],destGUID,1)
								if not destPos then
									destPos = #heal[inDamagePos][17] + 1
									heal[inDamagePos][17][destPos] = {destGUID,0}
								end
								destPos = heal[inDamagePos][17][destPos]
								
								heal[inDamagePos][2] = heal[inDamagePos][2] + spellAmount.amount - spellAmount.over + spellAmount.absorbed	--ef
								heal[inDamagePos][3] = heal[inDamagePos][3] + spellAmount.amount 						--total
								heal[inDamagePos][4] = heal[inDamagePos][4] + spellAmount.over 							--overheal
								heal[inDamagePos][5] = heal[inDamagePos][5] + spellAmount.absorbed 						--absorbed
								heal[inDamagePos][6] = heal[inDamagePos][6] + spellAmount.count 						--count
								heal[inDamagePos][7] = heal[inDamagePos][7] + spellAmount.crit 							--crit
								heal[inDamagePos][8] = heal[inDamagePos][8] + spellAmount.critcount						--crit-count
								heal[inDamagePos][9] = max(heal[inDamagePos][9],spellAmount.critmax)						--crit-max
								heal[inDamagePos][10] = heal[inDamagePos][10] + spellAmount.ms							--ms
								heal[inDamagePos][11] = heal[inDamagePos][11] + spellAmount.mscount						--ms-count
								heal[inDamagePos][12] = max(heal[inDamagePos][12],spellAmount.msmax) 						--ms-max
								heal[inDamagePos][13] = max(heal[inDamagePos][13],spellAmount.hitmax)						--hit-max
								heal[inDamagePos][14] = heal[inDamagePos][14] + spellAmount.critover						--crit overheal
								heal[inDamagePos][15] = heal[inDamagePos][15] + spellAmount.msover						--ms overheal
								heal[inDamagePos][16] = heal[inDamagePos][16] + spellAmount.absorbs						--absorbs
								total = total + spellAmount.amount - spellAmount.over + spellAmount.absorbed
								totalOver = totalOver + spellAmount.over
								
								destPos[2] = destPos[2] + spellAmount.amount + spellAmount.absorbed + (HealingShowOverheal and 0 or -spellAmount.over)
							end
						end
					end
				end
			end
		end
		local totalIsFull = 1
		total = max(total,1)
		if total == 1 and #heal == 0 then
			total = 0
			totalIsFull = 0
		end
		local _max = nil
		reportOptions[2] = ExRT.L.BossWatcherReportHPS
		wipe(reportData[2])
		reportData[2][1] = (DamageTab_GetGUIDsReport(HsourceVar) or ExRT.L.BossWatcherAllSources).." > "..(DamageTab_GetGUIDsReport(HdestVar) or ExRT.L.BossWatcherAllTargets)
		local activeFightLength = GetFightLength()
		if not HealingShowOverheal then
			local hps = total / activeFightLength
			reportData[2][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total).."@1@ ("..floor(hps)..")@1#"
			sort(heal,function(a,b) return a[2]>b[2] end)
			_max = heal[1] and heal[1][2] or 0
			HealingTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total,hps)
		else
			local hps = (total + totalOver) / activeFightLength
			reportData[2][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total + totalOver).."@1@ ("..floor(hps)..")@1#"
			sort(heal,function(a,b) return (a[2]+a[4])>(b[2]+b[4]) end)
			_max = heal[1] and (heal[1][2]+heal[1][4]) or 0
			HealingTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total + totalOver,hps,nil,nil,nil,nil,nil,nil,totalOver / max(total + totalOver,1))		
		end
		for i=1,#heal do
			local isPetAbility = heal[i][1] < 0
			if isPetAbility then
				heal[i][1] = -heal[i][1]
			end
			local spellName,_,spellIcon = GetSpellInfo(heal[i][1])
			if isPetAbility then
				spellName = ExRT.L.BossWatcherPetText..": "..spellName
			end
			local school = module.db.spellsSchool[ heal[i][1] ] or 0
			local tooltipData = {spellName,
				{ExRT.L.BossWatcherHealTooltipCount,heal[i][6]-heal[i][11]},
				{ExRT.L.BossWatcherHealTooltipHitMax,heal[i][13]},
				{ExRT.L.BossWatcherHealTooltipHitMid,ExRT.F.Round(max(heal[i][3]-heal[i][10]-heal[i][7]-(heal[i][4]-heal[i][14]-heal[i][15]),0)/max(heal[i][6]-heal[i][8]-heal[i][11],1))},
				{ExRT.L.BossWatcherHealTooltipCritCount,format("%d (%.1f%%)",heal[i][8],heal[i][8]/heal[i][6]*100)},
				{ExRT.L.BossWatcherHealTooltipCritAmount,ExRT.F.shortNumber(heal[i][7]-heal[i][14])},
				{ExRT.L.BossWatcherHealTooltipCritMax,heal[i][9]},
				{ExRT.L.BossWatcherHealTooltipCritMid,ExRT.F.Round((heal[i][7]-heal[i][14])/max(heal[i][8],1))},
				{ExRT.L.BossWatcherHealTooltipMsCount,format("%d (%.1f%%)",heal[i][11],heal[i][11]/heal[i][6]*100)},
				{ExRT.L.BossWatcherHealTooltipMsAmount,ExRT.F.shortNumber(heal[i][10]-heal[i][15])},
				{ExRT.L.BossWatcherHealTooltipMsMax,heal[i][12]},
				{ExRT.L.BossWatcherHealTooltipMsMid,ExRT.F.Round((heal[i][10]-heal[i][15])/max(heal[i][11],1))},
				{ExRT.L.BossWatcherHealTooltipOver,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][4]),heal[i][4]/max(heal[i][2]+heal[i][4],1)*100)},
				{ExRT.L.BossWatcherHealTooltipAbsorbed,ExRT.F.shortNumber(heal[i][5])},
				{ExRT.L.BossWatcherHealTooltipTotal,ExRT.F.shortNumber(heal[i][3])},
				{ExRT.L.BossWatcherSchool,GetSchoolName(school)},
			}
			sort(heal[i][17],DamageTab_Temp_SortingBy2Param)
			if #heal[i][17] > 0 then
				tooltipData[#tooltipData + 1] = {" "," "}
				tooltipData[#tooltipData + 1] = {ExRT.L.BossWatcherHealTooltipTargets," "}
			end
			for j=1,min(5,#heal[i][17]) do
				tooltipData[#tooltipData + 1] = {SubUTF8String(GetGUID(heal[i][17][j][1]),20)..GUIDtoText(" [%s]",heal[i][17][j][1]),format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][17][j][2]),min(heal[i][17][j][2] / max(1,heal[i][2]+(HealingShowOverheal and (heal[i][4]) or 0))*100,100))}
			end
			if not HealingShowOverheal then
				local hps = heal[i][2]/activeFightLength
				HealingTab_SetLine(i+1,spellIcon,spellName,heal[i][2]/total,heal[i][2]/max(_max,1),heal[i][2],hps,nil,nil,nil,"spell:"..heal[i][1],tooltipData,school,heal[i][16]/max(1,heal[i][2]))
				reportData[2][#reportData[2]+1] = i..". "..(isPetAbility and ExRT.L.BossWatcherPetText..": " or "")..GetSpellLink(heal[i][1]).." - "..ExRT.F.shortNumber(heal[i][2]).."@1@ ("..floor(hps)..")@1#"
			else
				local hps = (heal[i][2]+heal[i][4])/activeFightLength
				HealingTab_SetLine(i+1,spellIcon,spellName,(heal[i][2]+heal[i][4])/(total+totalOver),(heal[i][2]+heal[i][4])/max(_max,1),(heal[i][2]+heal[i][4]),hps,nil,nil,nil,"spell:"..heal[i][1],tooltipData,school,heal[i][4] / max(heal[i][2]+heal[i][4],1))			
				reportData[2][#reportData[2]+1] = i..". "..(isPetAbility and ExRT.L.BossWatcherPetText..": " or "")..GetSpellLink(heal[i][1]).." - "..ExRT.F.shortNumber(heal[i][2]+heal[i][4]).."@1@ ("..floor(hps)..")@1#"
			end
		end
		for i=#heal+2,#BWInterfaceFrame.tab.tabs[2].lines do
			BWInterfaceFrame.tab.tabs[2].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[2].scroll.SetNewHeight(BWInterfaceFrame.tab.tabs[2].scroll,(#heal+1) * 20)
	end
	local function HealingTab_UpdateLinesTargets(doEnemy)
		HealingTab_UpdateDropDownSource()
		HealingTab_UpdateDropDownDest()
		HealingTab_UpdateDropDownType(2,doEnemy)
		Healing_Last_Func = HealingTab_UpdateLinesTargets
		Healing_Last_doEnemy = doEnemy
		local heal = {}
		local total = 0
		local totalOver = 0
		for sourceGUID,sourceData in pairs(module.db.nowData.heal) do
			local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
			if owner then
				sourceGUID = owner
			end
			if ExRT.F.table_len(HsourceVar) == 0 or HsourceVar[sourceGUID] then
				for destGUID,destData in pairs(sourceData) do
					local isEnemy = not ExRT.F.UnitIsFriendlyByUnitFlag2(module.db.data[module.db.nowNum].reaction[destGUID])
					if ExRT.F.table_len(HdestVar) == 0 or HdestVar[destGUID] then
						if (isEnemy and doEnemy) or (not isEnemy and not doEnemy) then
							local inDamagePos = ExRT.F.table_find(heal,destGUID,1)
							if not inDamagePos then
								inDamagePos = #heal + 1
								heal[inDamagePos] = {destGUID,0,0,0,0,0,0,0,{}}
							end
							local sourcePos = ExRT.F.table_find(heal[inDamagePos][9],sourceGUID,1)
							if not sourcePos then
								sourcePos = #heal[inDamagePos][9] + 1
								heal[inDamagePos][9][sourcePos] = {sourceGUID,0}
							end
							sourcePos = heal[inDamagePos][9][sourcePos]

							for spellID,spellAmount in pairs(destData) do
								heal[inDamagePos][2] = heal[inDamagePos][2] + spellAmount.amount - spellAmount.over + spellAmount.absorbed
								heal[inDamagePos][3] = heal[inDamagePos][3] + spellAmount.amount 						--total
								heal[inDamagePos][4] = heal[inDamagePos][4] + spellAmount.over 							--overheal
								heal[inDamagePos][5] = heal[inDamagePos][5] + spellAmount.absorbed 						--absorbed
								if HealingShowOverheal then
									heal[inDamagePos][6] = heal[inDamagePos][6] + spellAmount.crit
									heal[inDamagePos][7] = heal[inDamagePos][7] + spellAmount.ms
								else
									heal[inDamagePos][6] = heal[inDamagePos][6] + spellAmount.crit - spellAmount.critover
									heal[inDamagePos][7] = heal[inDamagePos][7] + spellAmount.ms - spellAmount.msover					
								end
								heal[inDamagePos][8] = heal[inDamagePos][8] + spellAmount.absorbs						--absorbs
								total = total + spellAmount.amount - spellAmount.over + spellAmount.absorbed
								totalOver = totalOver + spellAmount.over
								
								sourcePos[2] = sourcePos[2] + spellAmount.amount + spellAmount.absorbed + (HealingShowOverheal and 0 or -spellAmount.over)
							end
						end
					end
				end
			end
		end
		local totalIsFull = 1
		total = max(total,1)
		if total == 1 and #heal == 0 then
			total = 0
			totalIsFull = 0
		end
		local _max = nil
		reportOptions[2] = ExRT.L.BossWatcherReportHPS
		wipe(reportData[2])
		reportData[2][1] = (DamageTab_GetGUIDsReport(HsourceVar) or ExRT.L.BossWatcherAllSources).." > "..(DamageTab_GetGUIDsReport(HdestVar) or ExRT.L.BossWatcherAllTargets)
		local activeFightLength = GetFightLength()
		if not HealingShowOverheal then
			local hps = total / activeFightLength
			reportData[2][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total).."@1@ ("..floor(hps)..")@1#"
			sort(heal,function(a,b) return a[2]>b[2] end)
			_max = heal[1] and heal[1][2] or 0
			HealingTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total,hps)
		else
			local hps = (total + totalOver) / activeFightLength
			reportData[2][2] = ExRT.L.BossWatcherReportTotal.." - "..ExRT.F.shortNumber(total + totalOver).."@1@ ("..floor(hps)..")@1#"
			sort(heal,function(a,b) return (a[2]+a[4])>(b[2]+b[4]) end)
			_max = heal[1] and (heal[1][2]+heal[1][4]) or 0
			HealingTab_SetLine(1,"",ExRT.L.BossWatcherReportTotal,totalIsFull,totalIsFull,total + totalOver,hps,nil,nil,nil,nil,nil,nil,totalOver / max(total + totalOver,1))		
		end
		for i=1,#heal do
			local class = nil
			if heal[i][1] and heal[i][1] ~= "" then
				class = select(2,GetPlayerInfoByGUID(heal[i][1]))
			end
			local icon = ""
			if class and CLASS_ICON_TCOORDS[class] then
				icon = {"Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",unpack(CLASS_ICON_TCOORDS[class])}
			end
			local tooltipData = {GetGUID(heal[i][1]),
				{ExRT.L.BossWatcherHealTooltipOver,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][4]),heal[i][4]/max(heal[i][2]+heal[i][4],1)*100)},
				{ExRT.L.BossWatcherHealTooltipAbsorbed,ExRT.F.shortNumber(heal[i][5])},
				{ExRT.L.BossWatcherHealTooltipTotal,ExRT.F.shortNumber(heal[i][3])},
				{" "," "},
				{ExRT.L.BossWatcherHealTooltipFromCrit,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][6]),heal[i][6]/max(1,heal[i][2]+(HealingShowOverheal and heal[i][4] or 0))*100)},
				{ExRT.L.BossWatcherHealTooltipFromMs,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][7]),heal[i][7]/max(1,heal[i][2]+(HealingShowOverheal and heal[i][4] or 0))*100)},
				{ACTION_SPELL_MISSED_ABSORB,format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][8]),heal[i][8]/max(heal[i][2]+(HealingShowOverheal and heal[i][4] or 0),1)*100)},
			}
			sort(heal[i][9],DamageTab_Temp_SortingBy2Param)
			if #heal[i][9] > 0 then
				tooltipData[#tooltipData + 1] = {" "," "}
				tooltipData[#tooltipData + 1] = {ExRT.L.BossWatcherHealTooltipSources," "}
			end
			for j=1,min(5,#heal[i][9]) do
				tooltipData[#tooltipData + 1] = {SubUTF8String(GetGUID(heal[i][9][j][1]),20)..GUIDtoText(" [%s]",heal[i][9][j][1]),format("%s (%.1f%%)",ExRT.F.shortNumber(heal[i][9][j][2]),min(heal[i][9][j][2] / max(1,heal[i][2]+(HealingShowOverheal and (heal[i][4]) or 0))*100,100))}
			end
			if not HealingShowOverheal then
				local hps = heal[i][2]/activeFightLength
				HealingTab_SetLine(i+1,icon,GetGUID(heal[i][1])..GUIDtoText(" [%s]",heal[i][1]),heal[i][2]/total,heal[i][2]/max(_max,1),heal[i][2],hps,class,heal[i][1],doEnemy,nil,tooltipData,nil,heal[i][8]/max(1,heal[i][2]),true)
				reportData[2][#reportData[2]+1] = i..". "..GetGUID(heal[i][1]).." - "..ExRT.F.shortNumber(heal[i][2]).."@1@ ("..floor(hps)..")@1#"
			else
				local hps = (heal[i][2]+heal[i][4])/activeFightLength
				HealingTab_SetLine(i+1,icon,GetGUID(heal[i][1])..GUIDtoText(" [%s]",heal[i][1]),(heal[i][2]+heal[i][4])/(total+totalOver),(heal[i][2]+heal[i][4])/max(_max,1),(heal[i][2]+heal[i][4]),hps,class,heal[i][1],doEnemy,nil,tooltipData,nil,heal[i][4] / max(heal[i][2]+heal[i][4],1),true)			
				reportData[2][#reportData[2]+1] = i..". "..GetGUID(heal[i][1]).." - "..ExRT.F.shortNumber(heal[i][2]+heal[i][4]).."@1@ ("..floor(hps)..")@1#"
			end
		end
		for i=#heal+2,#BWInterfaceFrame.tab.tabs[2].lines do
			BWInterfaceFrame.tab.tabs[2].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[2].scroll.SetNewHeight(BWInterfaceFrame.tab.tabs[2].scroll,(#heal+1) * 20)
	end
	
	local function HealingTab_SelectDropDownSource(self,arg,doEnemy,doSpells)
		wipe(HsourceVar)
		if arg then
			HsourceVar[arg] = true
			
			if IsShiftKeyDown() then
				local name = module.db.data[module.db.nowNum].guids[arg]
				if name then
					for GUID,GUIDname in pairs(module.db.data[module.db.nowNum].guids) do
						if GUIDname == name then
							HsourceVar[GUID] = true
						end
					end
				end
			end
		end
		if not doSpells then
			if ExRT.F.table_len(HdestVar) == 0 then
				if ExRT.F.table_len(HsourceVar) ~= 0 then
					HealingTab_UpdateLinesTargets(doEnemy)
				else
					HealingTab_UpdateLinesPlayers(doEnemy)
				end
			else
				if ExRT.F.table_len(HsourceVar) ~= 0 then
					HealingTab_UpdateLinesSpell(doEnemy)
				else
					HealingTab_UpdateLinesPlayers(doEnemy)
				end
			end
		else
			HealingTab_UpdateLinesSpell(doEnemy)
		end
		ExRT.lib.ScrollDropDown.Close()
	end
	local function HealingTab_SelectDropDownDest(self,arg,doEnemy,doSpells)
		wipe(HdestVar)
		if arg then
			HdestVar[arg] = true
			
			if IsShiftKeyDown() then
				local name = module.db.data[module.db.nowNum].guids[arg]
				if name then
					for GUID,GUIDname in pairs(module.db.data[module.db.nowNum].guids) do
						if GUIDname == name then
							HdestVar[GUID] = true
						end
					end
				end
			end
		end
		if not doSpells then
			HealingTab_UpdateLinesPlayers(doEnemy)
			if ExRT.F.table_len(HsourceVar) == 0 then
				HealingTab_UpdateLinesPlayers(doEnemy)
			else
				if ExRT.F.table_len(HdestVar) ~= 0 then
					HealingTab_UpdateLinesSpell(doEnemy)
				else
					HealingTab_UpdateLinesTargets(doEnemy)
				end
			end
		else
			HealingTab_UpdateLinesSpell(doEnemy)
		end
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function HealingTab_CheckDropDownSource(self,checked)
		if checked then
			HsourceVar[self.arg1] = true
		else
			HsourceVar[self.arg1] = nil
		end
		Healing_Last_Func(self.arg2)
	end
	local function HealingTab_CheckDropDownDest(self,checked)
		if checked then
			HdestVar[self.arg1] = true
		else
			HdestVar[self.arg1] = nil
		end
		Healing_Last_Func(self.arg2)
	end

	local function HealingTab_HPS(doEnemy,doSpells,doNotUpdateLines)		
		local sourceTable = {}
		local destTable = {}
		for sourceGUID,sourceData in pairs(module.db.nowData.heal) do	
			local owner = ExRT.F.Pets:getOwnerGUID(sourceGUID,GetPetsDB())
			if owner then
				sourceGUID = owner
			end
			for destGUID,destData in pairs(sourceData) do
				local isFriendly = ExRT.F.UnitIsFriendlyByUnitFlag2(module.db.data[module.db.nowNum].reaction[destGUID])
				if (isFriendly and not doEnemy) or (not isFriendly and doEnemy) then
					if not ExRT.F.table_find(destTable,destGUID,1) then
						destTable[#destTable + 1] = {destGUID,GetGUID(destGUID)}
					end
					if not ExRT.F.table_find(sourceTable,sourceGUID,1) then
						sourceTable[#sourceTable + 1] = {sourceGUID,GetGUID(sourceGUID)}
					end
				end
			end
		end
		sort(sourceTable,function(a,b) return a[2]<b[2] end)
		sort(destTable,function(a,b) return a[2]<b[2] end)
		wipe(BWInterfaceFrame.tab.tabs[2].sourceDropDown.List)
		wipe(BWInterfaceFrame.tab.tabs[2].targetDropDown.List)
		BWInterfaceFrame.tab.tabs[2].sourceDropDown.List[1] = {text = ExRT.L.BossWatcherAll,func = HealingTab_SelectDropDownSource,arg2 = doEnemy,arg3=doSpells,padding = 16}
		BWInterfaceFrame.tab.tabs[2].targetDropDown.List[1] = {text = ExRT.L.BossWatcherAll,func = HealingTab_SelectDropDownDest,arg2 = doEnemy,arg3=doSpells,padding = 16}
		for i=1,#sourceTable do
			local isPlayer = ExRT.F.GetUnitTypeByGUID(sourceTable[i][1]) == 0
			local classColor = ""
			if isPlayer then
				classColor = "|c"..ExRT.F.classColorByGUID(sourceTable[i][1])
			end
			BWInterfaceFrame.tab.tabs[2].sourceDropDown.List[i+1] = {
				text = classColor..sourceTable[i][2]..GUIDtoText(" [%s]",sourceTable[i][1]),
				arg1 = sourceTable[i][1],
				arg2 = doEnemy,
				arg3 = doSpells,
				func = HealingTab_SelectDropDownSource,
				checkFunc = HealingTab_CheckDropDownSource,
				checkable = true,
			}
		end
		for i=1,#destTable do
			local isPlayer = ExRT.F.GetUnitTypeByGUID(destTable[i][1]) == 0
			local classColor = ""
			if isPlayer then
				classColor = "|c"..ExRT.F.classColorByGUID(destTable[i][1])
			end
			BWInterfaceFrame.tab.tabs[2].targetDropDown.List[i+1] = {
				text = classColor..destTable[i][2]..GUIDtoText(" [%s]",destTable[i][1]),
				arg1 = destTable[i][1],
				arg2 = doEnemy,
				arg3 = doSpells,
				func = HealingTab_SelectDropDownDest,
				checkFunc = HealingTab_CheckDropDownDest,
				checkable = true,
			}
		end
		wipe(HsourceVar)
		wipe(HdestVar)
		if not doNotUpdateLines then
			if doSpells then
				HealingTab_UpdateLinesSpell(doEnemy)		
			else
				HealingTab_UpdateLinesPlayers(doEnemy)
			end
		end
	end
	
	local function HealingTab_Friendly(self)
		HealingTab_HPS(false,false)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function HealingTab_Enemy(self)
		HealingTab_HPS(true,false)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function HealingTab_FriendlyTarget(self)
		HealingTab_HPS(false,false,true)
		HealingTab_UpdateLinesTargets(false)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function HealingTab_EnemyTarget(self)
		HealingTab_HPS(false,false,true)
		HealingTab_UpdateLinesTargets(true)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function HealingTab_FriendlySpell(self)
		HealingTab_HPS(false,true)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	local function HealingTab_EnemySpell(self)
		HealingTab_HPS(true,true)
		ExRT.lib.ScrollDropDown.Close()
	end
	
	tab.typeDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",70,-50,195,200,6,ExRT.L.BossWatcherHealFriendly,nil,"ExRTDropDownMenuModernTemplate")
	tab.typeText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherType..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.typeText,"TOPRIGHT",tab.typeDropDown,"TOPLEFT",-6,0)
	tab.typeDropDown.List = {
		{text = ExRT.L.BossWatcherHealFriendly,func = HealingTab_Friendly},
		{text = ExRT.L.BossWatcherHealHostile,func = HealingTab_Enemy},
		{text = ExRT.L.BossWatcherHealFriendlyByTarget,func = HealingTab_FriendlyTarget},
		{text = ExRT.L.BossWatcherHealHostileByTarget,func = HealingTab_EnemyTarget},
		{text = ExRT.L.BossWatcherHealFriendlyBySpell,func = HealingTab_FriendlySpell},
		{text = ExRT.L.BossWatcherHealHostileBySpell,func = HealingTab_EnemySpell},
	}
	
	tab.sourceDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",365,-50,195,250,20,ExRT.L.BossWatcherAll,nil,"ExRTDropDownMenuModernTemplate")
	tab.sourceText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherSource..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.sourceText,"TOPRIGHT",tab.sourceDropDown,"TOPLEFT",-6,0)

	tab.targetDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",630,-50,195,250,20,ExRT.L.BossWatcherAll,nil,"ExRTDropDownMenuModernTemplate")
	tab.targetText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherTarget..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.targetText,"TOPRIGHT",tab.targetDropDown,"TOPLEFT",-6,0)
	
	function tab.sourceDropDown.additionalToggle(self)
		for i=2,#self.List do
			self.List[i].checkState = HsourceVar[self.List[i].arg1]
		end
	end
	function tab.targetDropDown.additionalToggle(self)
		for i=2,#self.List do
			self.List[i].checkState = HdestVar[self.List[i].arg1]
		end
	end
	
	tab.showOverhealChk = ExRT.lib.CreateCheckBox(tab,"TOPLEFT",833,-50,"",nil,ExRT.L.BossWatcherHealShowOver,nil,"ExRTCheckButtonModernTemplate")
	tab.showOverhealChk:SetScript("OnClick",function (self)
		if self:GetChecked() then
			HealingShowOverheal = true
		else
			HealingShowOverheal = false
		end
		Healing_Last_Func(Healing_Last_doEnemy)
	end)
	
	tab.scroll = ExRT.lib.CreateScrollFrame(tab,835,508,"TOP",0,-80,600,true)
	tab.lines = {}
	local function HealingTab_Line_OnClick(self)
		local GUID = self.sourceGUID
		local doEnemy = self.doEnemy
		local tooltip = self.spellLink
		local isTargetLine = self.isTargetLine
		
		local parent = self:GetParent()
		if parent.isMain then
			GUID = parent.sourceGUID
			doEnemy = parent.doEnemy
			tooltip = parent.spellLink
			isTargetLine = parent.isTargetLine
		end
		if parent.isMain and IsShiftKeyDown() and tooltip and tooltip:find("spell:") then
			local spellID = tooltip:match("%d+")
			if spellID then
				ExRT.F.LinkSpell(spellID)
				return
			end
		end
		if GUID then
			if not isTargetLine then
				wipe(HsourceVar)
				HsourceVar[GUID] = true
				HealingTab_UpdateLinesSpell(doEnemy)
			else
				wipe(HdestVar)
				wipe(HsourceVar)
				HdestVar[GUID] = true
				HealingTab_UpdateLinesPlayers(doEnemy)
			end
		end
	end
	local function HealingTab_LineOnEnter(self)
		if self.tooltip then
			GameTooltip:SetOwner(self,"ANCHOR_LEFT")
			GameTooltip:SetText(self.tooltip[1])
			for i=2,#self.tooltip do
				if type(self.tooltip[i]) == "table" then
					GameTooltip:AddDoubleLine(self.tooltip[i][1],self.tooltip[i][2],1,1,1,1,1,1,1,1)
				else
					GameTooltip:AddLine(self.tooltip[i])
				end
			end
			GameTooltip:Show()
		end
	end
	local function HealingTab_Line_OnEnter(self)
		local parent = self:GetParent()
		if parent.spellLink then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(parent.spellLink)
			GameTooltip:Show()
		elseif parent.name:IsTruncated() then
			GameTooltip:SetOwner(self,"ANCHOR_LEFT")
			GameTooltip:SetText(parent.name:GetText())
			GameTooltip:Show()	
		elseif parent.tooltip then
			HealingTab_LineOnEnter(parent)
		end
	end
	function HealingTab_SetLine(i,icon,name,overall_num,overall,total,dps,class,sourceGUID,doEnemy,spellLink,tooltip,school,overall_black,isTargetLine)
		if not BWInterfaceFrame.tab.tabs[2].lines[i] then
			local line = CreateFrame("Button",nil,BWInterfaceFrame.tab.tabs[2].scroll.C)
			BWInterfaceFrame.tab.tabs[2].lines[i] = line
			line:SetSize(815,20)
			line:SetPoint("TOPLEFT",0,-(i-1)*20)
			
			line.icon = ExRT.lib.CreateIcon(line,18,"TOPLEFT",5,-1)
			line.name = ExRT.lib.CreateText(line,225,20,nil,25,0,"LEFT","MIDDLE",nil,12,"name",nil,1,1,1,1)
			line.name:SetMaxLines(1)
			
			line.name_tooltip = CreateFrame('Button',nil,line)
			line.name_tooltip:SetAllPoints(line.name)
			line.overall_num = ExRT.lib.CreateText(line,70,20,nil,250,0,"RIGHT","MIDDLE",nil,12,"45.76%",nil,1,1,1,1)
			line.overall = line:CreateTexture(nil, "BACKGROUND")
			--line.overall:SetTexture(0.7, 0.1, 0.1, 1)
			line.overall:SetTexture("Interface\\AddOns\\ExRT\\media\\bar24.tga")
			line.overall:SetSize(300,16)
			line.overall:SetPoint("TOPLEFT",325,-2)
			line.overall_black = line:CreateTexture(nil, "BACKGROUND")
			line.overall_black:SetTexture("Interface\\AddOns\\ExRT\\media\\bar24b.tga")
			line.overall_black:SetSize(300,16)
			line.overall_black:SetPoint("LEFT",line.overall,"RIGHT",0,0)

			line.total = ExRT.lib.CreateText(line,95,20,nil,630,0,"LEFT","MIDDLE",nil,12,"125.46M",nil,1,1,1,1)
			line.dps = ExRT.lib.CreateText(line,100,20,nil,725,0,"LEFT","MIDDLE",nil,12,"34576.43",nil,1,1,1,1)
			
			line.back = line:CreateTexture(nil, "BACKGROUND")
			line.back:SetAllPoints()
			if i%2==0 then
				line.back:SetTexture(0.3, 0.3, 0.3, 0.1)
			end
			line.name_tooltip:SetScript("OnClick",HealingTab_Line_OnClick)
			line.name_tooltip:SetScript("OnEnter",HealingTab_Line_OnEnter)
			line.name_tooltip:SetScript("OnLeave",GameTooltip_Hide)
			line:SetScript("OnClick",HealingTab_Line_OnClick)
			line:SetScript("OnEnter",HealingTab_LineOnEnter)
			line:SetScript("OnLeave",GameTooltip_Hide)
			
			line.isMain = true
		end
		local line = BWInterfaceFrame.tab.tabs[2].lines[i]
		if type(icon) == "table" then
			line.icon.texture:SetTexture(icon[1] or "Interface\\Icons\\INV_MISC_QUESTIONMARK")
			line.icon.texture:SetTexCoord(unpack(icon,2,5))
		else
			line.icon.texture:SetTexture(icon or "Interface\\Icons\\INV_MISC_QUESTIONMARK")
			line.icon.texture:SetTexCoord(0,1,0,1)
		end
		line.name:SetText(name or "")
		line.overall_num:SetFormattedText("%.2f%%",overall_num and overall_num * 100 or 0)
		if overall_black and overall_black > 0 then
			local width = 300*(overall or 1)
			local normal_width = width * (1 - overall_black)
			line.overall:SetWidth(max(normal_width,1))
			line.overall_black:SetWidth(max(width-normal_width,1))
			line.overall_black:Show()
			if normal_width == 0 then
				line.overall:Hide()
				line.overall_black:SetPoint("TOPLEFT",325,-2)
			else
				line.overall:Show()
				line.overall_black:ClearAllPoints()
				line.overall_black:SetPoint("LEFT",line.overall,"RIGHT",0,0)
			end
		else
			line.overall:Show()
			line.overall_black:Hide()
			line.overall:SetWidth(max(300*(overall or 1),1))
		end
		line.total:SetText(total and ExRT.F.shortNumber(total) or "")
		line.dps:SetFormattedText("%.2f",dps or 0)
		line.overall:SetGradientAlpha("HORIZONTAL", 0,0,0,0,0,0,0,0)
		line.overall_black:SetGradientAlpha("HORIZONTAL", 0,0,0,0,0,0,0,0)
		if class then
			local classColorArray = type(CUSTOM_CLASS_COLORS)=="table" and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
			if classColorArray then
				line.overall:SetVertexColor(classColorArray.r,classColorArray.g,classColorArray.b, 1)
				line.overall_black:SetVertexColor(classColorArray.r,classColorArray.g,classColorArray.b, 1)
			else
				line.overall:SetVertexColor(0.8,0.8,0.8, 1)
				line.overall_black:SetVertexColor(0.8,0.8,0.8, 1)
			end
		else
			line.overall:SetVertexColor(0.8,0.8,0.8, 1)
			line.overall_black:SetVertexColor(0.8,0.8,0.8, 1)
		end
		if school then
			SetSchoolColorsToLine(line.overall,school)
			SetSchoolColorsToLine(line.overall_black,school)
		end
		line.sourceGUID = sourceGUID
		line.doEnemy = doEnemy
		line.spellLink = spellLink
		line.tooltip = tooltip
		line.isTargetLine = isTargetLine
		line:Show()
	end
	
	tab:SetScript("OnShow",function (self)
		BWInterfaceFrame.timeLineFrame:ClearAllPoints()
		BWInterfaceFrame.timeLineFrame:SetPoint("TOP",self,"TOP",0,-10)
		BWInterfaceFrame.timeLineFrame:Show()
	
		BWInterfaceFrame.report:Show()
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			HealingTab_Friendly(nil,ExRT.L.BossWatcherHealFriendly)
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)
	tab:SetScript("OnHide",function (self)
		BWInterfaceFrame.timeLineFrame:Hide()
		BWInterfaceFrame.report:Hide()
	end)
	
	
	
	
	---- Death Tab
	tab = BWInterfaceFrame.tab.tabs[9]
	tabName = BWInterfaceFrame_Name.."DeathTab"
	
	local DeathTab_isEnemy = false
	local DeathTab_SetDeath_Last_Arg,DeathTab_SetDeath_Last_Arg2 = nil
	local DeathTab_isBuffs = false
	local DeathTab_isDebuffs = false
	local DeathTab_isBlack = false
	
	local DeathTab_SetLine = nil
	
	local DeathTab_aurasBlackList = {
		[116956]=true,
		[167188]=true,
		[113742]=true,
		[6673]=true,
		[19740]=true,
		[109773]=true,
		[1126]=true,
		[21562]=true,
		[24907]=true,
		[166928]=true,
		[1459]=true,
		[93435]=true,
		[19506]=true,
		[167187]=true,
		[166916]=true,
		[166646]=true,
		[77747]=true,
		[67330]=true,
		[116781]=true,
		[24604]=true,
		[115921]=true,
		[51470]=true,
		[24932]=true,
		[117666]=true,
		[128432]=true,
		[155522]=true,
		[20217]=true,
		[469]=true,
		[57330]=true,
	}
	
	local function DeathTab_ClearPage()
		for i=1,#BWInterfaceFrame.tab.tabs[9].lines do
			BWInterfaceFrame.tab.tabs[9].lines[i]:Hide()
		end
		BWInterfaceFrame.tab.tabs[9].scroll:SetNewHeight(0)
		BWInterfaceFrame.tab.tabs[9].sourceDropDown:SetText(ExRT.L.BossWatcherSelect)
	end
	
	local function DeathTab_SetDeath(_,arg,arg2)
		DeathTab_SetDeath_Last_Arg = arg
		DeathTab_SetDeath_Last_Arg2 = arg2
		ExRT.lib.ScrollDropDown.Close()
		DeathTab_ClearPage()
		BWInterfaceFrame.tab.tabs[9].sourceDropDown:SetText( arg2 )
		local _data = module.db.nowData.deathLog[arg]
		local data = {}
		local minTime,maxTime = _data[1][3]-20,_data[1][3]
		local GUID = _data[1][2]
		local deathTime = nil
		wipe(reportData[9])
		reportData[9][1] = date("%H:%M:%S",_data[1][3])..date(" %Mm%Ss",timestampToFightTime(_data[1][3])).." "..GetGUID(_data[1][2])
		for i=1,#_data do
			if _data[i][3] then
				_data[i].P = i
				data[#data + 1] = _data[i]
				minTime = min(minTime,_data[i][3])
			end
		end
		if DeathTab_isBuffs or DeathTab_isDebuffs then
			local DataDefLen = #_data
			for i,auraData in ipairs(module.db.nowData.auras) do
				if auraData[3] == GUID and auraData[1] >= minTime and auraData[1] <= maxTime and ((DeathTab_isBuffs and auraData[7]=='BUFF') or (DeathTab_isDebuffs and auraData[7]=='DEBUFF')) and (not DeathTab_isBlack or not DeathTab_aurasBlackList[ auraData[6] ]) then
					data[#data + 1] = {4,auraData[2],auraData[1],auraData[6],auraData[8],P=(DataDefLen + i)}
				end
			end
			sort(data,function(a,b) if a[3]==b[3] then return a.P<b.P else return a[3]>b[3] end end)
		end
		for i=1,#data do
			if data[i][1] then
				local _time = timestampToFightTime(data[i][3])
				local diffTime = deathTime and format("%.2f",_time - deathTime) or ""
				if diffTime == "0.00" then diffTime = "-0.00" end
				local timeText = date("%M:%S.",_time)..format("%03d",_time * 1000 % 1000)..(diffTime~="" and "  " or "")..diffTime
				if data[i][1] == 3 then
					local text = GetGUID(data[i][2])..GUIDtoText(" [%s]",data[i][2]) .. " ".. ExRT.L.BossWatcherDeathDeath
					
					DeathTab_SetLine(i,timeText,text,0,0,0,data[i][4])
					
					reportData[9][#reportData[9] + 1] = "-0.0s "..ExRT.L.BossWatcherDeathDeath
					
					deathTime = _time
				elseif data[i][1] == 1 then
					local spellName,_,spellTexture = GetSpellInfo(data[i][4])
					local name = GetGUID(data[i][2])..GUIDtoText(" [%s]",data[i][2])
					local overkill = data[i][6] and data[i][6] > 0 and " ("..ExRT.L.BossWatcherDeathOverKill..":"..data[i][6]..")" or ""
					local blocked = data[i][8] and data[i][8] > 0 and " ("..ExRT.L.BossWatcherDeathBlocked..":"..data[i][8]..")" or ""
					local absorbed = data[i][9] and data[i][9] > 0 and " ("..ExRT.L.BossWatcherDeathAbsorbed..":"..data[i][9]..")" or ""
					local isCrit = data[i][10] and "*" or ""
					local isMs = data[i][11] and " ("..ExRT.L.BossWatcherDeathMultistrike..")" or ""
					local school = " ("..GetSchoolName(data[i][7])..")"
					local amount = data[i][5] - (data[i][6] or 0)
					local HP = ""
					if data[i][12] and data[i][13]~=0 then
						HP = format("%d%% ",data[i][12]/data[i][13]*100)
					end
					
					if ExRT.F.GetUnitTypeByGUID(data[i][2]) == 0 then
						name = "|c"..ExRT.F.classColorByGUID(data[i][2])..name.."|r"
					end
					
					local text = HP..name.." "..ExRT.L.BossWatcherDeathDamage.." |T"..spellTexture..":0|t"..spellName.." "..ExRT.L.BossWatcherDeathOn.." "..isCrit..amount..isCrit .. isMs .. blocked .. absorbed .. overkill .. school
					
					DeathTab_SetLine(i,timeText,text,1,0,0,data[i][4])
					
					reportData[9][#reportData[9] + 1] = diffTime.."s."..HP.." -"..isCrit..amount..isCrit .. isMs..blocked .. absorbed .. overkill .." ["..GetGUID(data[i][2]).." - "..GetSpellLink(data[i][4]).."]"
				elseif data[i][1] == 2 then
					local spellName,_,spellTexture = GetSpellInfo(data[i][4])
					local name = GetGUID(data[i][2])..GUIDtoText(" [%s]",data[i][2])
					local overheal = data[i][6] and data[i][6] > 0 and " ("..ExRT.L.BossWatcherDeathOverHeal..":"..data[i][6]..")" or ""
					local absorbed = data[i][9] and data[i][9] > 0 and " ("..ExRT.L.BossWatcherDeathAbsorbed..":"..data[i][9]..")" or ""
					local isCrit = data[i][10] and "*" or ""
					local isMs = data[i][11] and " ("..ExRT.L.BossWatcherDeathMultistrike..")" or ""
					local school = " ("..GetSchoolName(data[i][7])..")"
					local amount = data[i][5] - (data[i][6] or 0)
					local HP = ""
					if data[i][12] and data[i][13]~=0 then
						HP = format("%d%% ",data[i][12]/data[i][13]*100)
					end
					
					if ExRT.F.GetUnitTypeByGUID(data[i][2]) == 0 then
						name = "|c"..ExRT.F.classColorByGUID(data[i][2])..name.."|r"
					end
					
					local text = HP .. name.." "..ExRT.L.BossWatcherDeathHeal..(data[i][14] and (" ("..(ACTION_SPELL_MISSED_ABSORB and strlower(ACTION_SPELL_MISSED_ABSORB) or "absorbed")..")") or "").." |T"..spellTexture..":0|t"..spellName.." "..ExRT.L.BossWatcherDeathOn.." "..isCrit..amount..isCrit .. isMs .. absorbed .. overheal .. school
					
					DeathTab_SetLine(i,timeText,text,0,1,0,data[i][4])
					
					reportData[9][#reportData[9] + 1] = diffTime.."s."..HP.." +"..isCrit..amount..isCrit .. isMs.. absorbed .. overheal .." ["..GetGUID(data[i][2]).." - "..GetSpellLink(data[i][4]).."]"
				elseif data[i][1] == 4 then
					local spellName,_,spellTexture = GetSpellInfo(data[i][4])
					local name = GetGUID(data[i][2])..GUIDtoText(" [%s]",data[i][2])
					local isApplied = (data[i][5]==1 or data[i][5]==3)
					
					if ExRT.F.GetUnitTypeByGUID(data[i][2]) == 0 then
						name = "|c"..ExRT.F.classColorByGUID(data[i][2])..name.."|r"
					end
					
					local text = name.." "..(isApplied and ExRT.L.BossWatcherDeathAuraAdd or ExRT.L.BossWatcherDeathAuraRemove).." |T"..spellTexture..":0|t"..spellName
					
					DeathTab_SetLine(i,timeText,text,1,1,0,data[i][4])
				
					reportData[9][#reportData[9] + 1] = diffTime.."s. ["..GetGUID(data[i][2]).." "..(isApplied and "+" or "-")..GetSpellLink(data[i][4]).."]"					
				end
				BWInterfaceFrame.tab.tabs[9].lines[i]:Show()
			end
		end
		BWInterfaceFrame.tab.tabs[9].scroll:SetNewHeight(#data * 18)
	end
	
	local function DeathTab_SetDeathList()
		local counter = 0
		for i,deathData in ipairs(module.db.nowData.deathLog) do
			local GUID = deathData[1][2]
			local isFriendly = ExRT.F.UnitIsFriendlyByUnitFlag2(module.db.data[module.db.nowNum].reaction[GUID])
			if ((isFriendly and not DeathTab_isEnemy) or (not isFriendly and DeathTab_isEnemy)) and (deathData[2] and deathData[2][1]) then
				counter = counter + 1
				local classColor = "|cffbbbbbb"
				local isPlayer = ExRT.F.GetUnitTypeByGUID(GUID) == 0
				if isPlayer then
					classColor = "|c"..ExRT.F.classColorByGUID(GUID)
				end
				local text = classColor..GetGUID(GUID)..GUIDtoText(" [%s]",GUID).."|r"
				local spellID = nil
				for j=2,#deathData do
					if deathData[j][1] == 1 and deathData[j][6] > 0 then
						local sourceColor = "|cffbbbbbb"
						if ExRT.F.GetUnitTypeByGUID(deathData[j][2]) == 0 then
							sourceColor = "|c"..ExRT.F.classColorByGUID(deathData[j][2])
						end
						local spellName,_,spellTexture = GetSpellInfo(deathData[j][4])
						text = text .." < " ..sourceColor .. GetGUID(deathData[j][2])..GUIDtoText(" [%s]",deathData[j][2]).."|r (|T"..spellTexture..":0|t"..spellName..")"
						spellID = deathData[j][4]
						break
					end
				end
				
				local _time = timestampToFightTime( deathData[1][3] )
				local timeText = date("%M:%S.",_time)..format("%03d",_time * 1000 % 1000)
				DeathTab_SetLine(counter,timeText,text,0,0,0,spellID,i)
				BWInterfaceFrame.tab.tabs[9].lines[counter]:Show()
			end
		end
		BWInterfaceFrame.tab.tabs[9].scroll:SetNewHeight(counter * 18)
	end
	
	local function DeathTab_UpdatePage()
		wipe(BWInterfaceFrame.tab.tabs[9].sourceDropDown.List)
		local list = BWInterfaceFrame.tab.tabs[9].sourceDropDown.List
		for i,deathData in ipairs(module.db.nowData.deathLog) do	
			local GUID = deathData[1][2]
			local isFriendly = ExRT.F.UnitIsFriendlyByUnitFlag2(module.db.data[module.db.nowNum].reaction[GUID])
			if ((isFriendly and not DeathTab_isEnemy) or (not isFriendly and DeathTab_isEnemy)) and (deathData[2] and deathData[2][1]) then
				local classColor = ""
				local isPlayer = ExRT.F.GetUnitTypeByGUID(GUID) == 0
				if isPlayer then
					classColor = "|c"..ExRT.F.classColorByGUID(GUID)
				elseif isFriendly then
					classColor = "|cffbbbbbb"
				end
				local text = date("%M:%S ",timestampToFightTime(deathData[1][3]))..classColor..GetGUID(GUID)..GUIDtoText(" [%s]",GUID)
				list[#list+1] = {
					text = text,
					arg1 = i,
					arg2 = text,
					func = DeathTab_SetDeath,
					hoverFunc = DamageTab_ShowArrow,
					leaveFunc = DamageTab_HideArrow,
					hoverArg = timestampToFightTime( deathData[1][3] ) / ( module.db.data[module.db.nowNum].encounterEnd - module.db.data[module.db.nowNum].encounterStart ),
				}
			end
		end
	end
	
	local function DeathTab_SetType(self,arg)
		DeathTab_isEnemy = arg
		BWInterfaceFrame.tab.tabs[9].typeDropDown:SetText(arg and ExRT.L.BossWatcherHostile or ExRT.L.BossWatcherFriendly)
		ExRT.lib.ScrollDropDown.Close()
		DeathTab_UpdatePage()
		DeathTab_ClearPage()
		DeathTab_SetDeathList()
		DeathTab_SetDeath_Last_Arg = nil
	end
	
	tab.typeDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",70,-75,180,200,2,ExRT.L.BossWatcherFriendly,nil,"ExRTDropDownMenuModernTemplate")
	tab.typeText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherType..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.typeText,"TOPRIGHT",tab.typeDropDown,"TOPLEFT",-6,0)
	tab.typeDropDown.List = {
		{text = ExRT.L.BossWatcherFriendly,func = DeathTab_SetType},
		{text = ExRT.L.BossWatcherHostile,func = DeathTab_SetType,arg1 = true},
	}
	
	tab.sourceDropDown = ExRT.lib.CreateScrollDropDown(tab,"TOPLEFT",335,-75,180,250,20,ExRT.L.BossWatcherSelect,nil,"ExRTDropDownMenuModernTemplate")
	tab.sourceText = ExRT.lib.CreateText(tab,100,20,nil,0,0,"RIGHT","MIDDLE",nil,12,ExRT.L.BossWatcherTarget..":",nil,1,1,1,1)
	ExRT.lib.SetPoint(tab.sourceText,"TOPRIGHT",tab.sourceDropDown,"TOPLEFT",-6,0)
	
	tab.showBuffsChk = ExRT.lib.CreateCheckBox(tab,"TOPLEFT",530,-75,ExRT.L.BossWatcherDeathBuffsShow,nil,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.showBuffsChk:SetScript("OnClick",function (self)
		if self:GetChecked() then
			DeathTab_isBuffs = true
		else
			DeathTab_isBuffs = false
		end
		if DeathTab_SetDeath_Last_Arg then
			DeathTab_SetDeath(nil,DeathTab_SetDeath_Last_Arg,DeathTab_SetDeath_Last_Arg2)
		end
	end)

	tab.showDebuffsChk = ExRT.lib.CreateCheckBox(tab,"TOPLEFT",680,-75,ExRT.L.BossWatcherDeathDebuffsShow,nil,nil,nil,"ExRTCheckButtonModernTemplate")
	tab.showDebuffsChk:SetScript("OnClick",function (self)
		if self:GetChecked() then
			DeathTab_isDebuffs = true
		else
			DeathTab_isDebuffs = false
		end
		if DeathTab_SetDeath_Last_Arg then
			DeathTab_SetDeath(nil,DeathTab_SetDeath_Last_Arg,DeathTab_SetDeath_Last_Arg2)
		end
	end)
	
	tab.buffsblacklistChk = ExRT.lib.CreateCheckBox(tab,"TOPLEFT",833,-75,"",nil,ExRT.L.BossWatcherDeathBlacklist,nil,"ExRTCheckButtonModernTemplate")
	tab.buffsblacklistChk:SetScript("OnClick",function (self)
		if self:GetChecked() then
			DeathTab_isBlack = true
		else
			DeathTab_isBlack = false
		end
		if DeathTab_SetDeath_Last_Arg then
			DeathTab_SetDeath(nil,DeathTab_SetDeath_Last_Arg,DeathTab_SetDeath_Last_Arg2)
		end
	end)
	
	local function DeathTab_LineOnEnter(self)
		if self.spellLink then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT",120,0)
			GameTooltip:SetHyperlink(self.spellLink)
			GameTooltip:Show()
		end
		if self.text:IsTruncated() then
			ExRT.lib.AdditionalTooltip(nil,{self.text:GetText()})
		end
	end
	local function DeathTab_LineOnLeave(self)
		GameTooltip_Hide()
		ExRT.lib.HideAdditionalTooltips()
	end
	local function DeathTab_LineOnClick(self)
		if not self.clickToLog then
			return
		end
		local name = self.text:GetText()
		DeathTab_SetDeath(nil,self.clickToLog,name:match("(.-)|r"),nil)
	end
	tab.scroll = ExRT.lib.CreateScrollFrame(tab,835,483,"TOP",0,-105,600,true)
	tab.lines = {}
	function DeathTab_SetLine(i,textTime,textText,gradientR,gradientG,gradientB,spellID,clickToLog)
		local line = BWInterfaceFrame.tab.tabs[9].lines[i]
		if not line then
			line = CreateFrame("Button",nil,BWInterfaceFrame.tab.tabs[9].scroll.C)
			BWInterfaceFrame.tab.tabs[9].lines[i] = line
			line:SetPoint("TOP",0,-(i-1)*18)
			line:SetSize(810,18)
			line.time = ExRT.lib.CreateText(line,150,16,"LEFT",10,0,"LEFT","MIDDLE",nil,12,"00:02."..format("%02d",i),nil,1,1,1,1)
			line.text = ExRT.lib.CreateText(line,810-125-20,16,"LEFT",125,0,"LEFT","MIDDLE",nil,12,"00:02."..format("%02d",i),nil,1,1,1,1)
			
			line.back = line:CreateTexture(nil, "BACKGROUND")
			line.back:SetAllPoints()
			line.back:SetTexture( 1, 1, 1, 1)
			line.back:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 0)
			
			line:SetScript("OnEnter",DeathTab_LineOnEnter)
			line:SetScript("OnLeave",DeathTab_LineOnLeave)
			line:SetScript("OnClick",DeathTab_LineOnClick)
		end
		line.time:SetText(textTime)
		line.text:SetText(textText)
		line.back:SetGradientAlpha("HORIZONTAL", gradientR,gradientG,gradientB, 0.3, gradientR,gradientG,gradientB, 0)
		line.spellLink = spellID and "spell:"..spellID
		line.clickToLog = clickToLog
		line:Show()
	end
	
	tab:SetScript("OnShow",function (self)
		BWInterfaceFrame.timeLineFrame:ClearAllPoints()
		BWInterfaceFrame.timeLineFrame:SetPoint("TOP",self,"TOP",0,-10)
		BWInterfaceFrame.timeLineFrame:Show()
		
		BWInterfaceFrame.report:Show()
		
		if BWInterfaceFrame.nowFightID ~= self.lastFightID then
			DeathTab_SetDeath_Last_Arg = nil
			DeathTab_ClearPage()
			DeathTab_UpdatePage()
			DeathTab_SetDeathList()
			self.lastFightID = BWInterfaceFrame.nowFightID
		end
	end)
	tab:SetScript("OnHide",function (self)
		BWInterfaceFrame.timeLineFrame:Hide()
		BWInterfaceFrame.report:Hide()
	end)
end