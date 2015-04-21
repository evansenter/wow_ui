
--Constants
local PLAYER_NAME, PLAYER_GUID = UnitName("player"), UnitGUID("player")
local LIGHTWELL_SPELLID, LIGHTSPRING_SPELLID, LIGHTWELL_RENEW_SPELLID, LIGHTSPRING_RENEW_SPELLID, LIGHTWELL_GLYPH_SPELLID = 724, 126135, 7001, 126154, 55673
local LIGHTSPRING_GLYPH_SPELLID = 126133
local LWB = _G["LWB"];
local L = LibStub("AceLocale-3.0"):GetLocale("LWB")
local LSM = LibStub("LibSharedMedia-3.0")
local _




-- Info on Ace Libarys and Mixins is at <http://www.wowace.com/addons/ace3/pages/>

-- AceConsole-3.0 is used to print the alerts to the UIErrorsFrame and to print the log to the chat frame
-- AceEvent-3.0 is used to pervent frame waste as most users have atleast one other addon that uses AceEvent-3.0 and if they don't it still only uses one frame any ways
-- AceTimer-3.0 was used over an OnUpdate style timer to try and keep code simpler
-- AceDB-3.0 was used for the profile feature so a user can have difrent theames for for diffrent groups or toons
-- AceConfig-3.0 was used for the config as it is easyer then building the options in xml or lua and it recycles frames with other addons useing AceConfig-3.0 or AceGUI-3.0

LWB = LibStub("AceAddon-3.0"):NewAddon(LWB, "Lightwell Buddy", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0");-- make our Ace3 addon mixing in the Console, Event and Timer functions
local AceDB = LibStub("AceDB-3.0"); -- library for handling the db and profiles
local AceDBOptions = LibStub("AceDBOptions-3.0"); -- library that builds the profiles option table alowing users to have diffrent settings for each toon if they wish
local AceConfig = LibStub("AceConfig-3.0"); -- config management library
local AceConfigDialog = LibStub("AceConfigDialog-3.0"); -- library that injects out options in to the bliz interface addon option window
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0"); -- library used to trigger a reload of the settings in to the option window


-- set some defaults
LWB.chargesMax = 15
LWB.chargesRemaining = 0
LWB.chargesUsed = 0
LWB.lightwellUp = false
LWB.LightwellUpFromEnable = false
LWB.logs = {}
LWB.idleTime = 0
LWB.idleCycles = 0
local isHoly = false



--###########################################
--##### Initialize Addon ####################
--###########################################
--Set up database and options window, register events, callbacks and slash commands.

function LWB:OnInitialize()

	self.db = AceDB:New("CHTLWBDB", self.dbDefaults, true); -- setup the DB. Get saved variables and defaults
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged"); -- setup the db's callbacks, monitor for changes in the active profile.
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged");
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged");
--	self.db.RegisterCallback(self, "OnNewProfile", "OnProfileChanged");
--	LSM.RegisterCallback(self, "LibSharedMedia_Registered", "UpdateUsedMedia")
	LSM.RegisterCallback(self, "LibSharedMedia_Registered", "MediaUpdate" ) --Monitor for changes in available graphics
	LSM.RegisterCallback(self, "LibSharedMedia_SetGlobal", "MediaUpdate" )
	self.optionsTable.args.profiles = AceDBOptions:GetOptionsTable(self.db) --{profileManagement}-- add the db profile options to our options
	AceConfig:RegisterOptionsTable("Lightwell_Buddy", self.optionsTable); -- setup the config

	self.optionFrames = {} -- holder for the blizz option frames

	self.optionFrames.general = AceConfigDialog:AddToBlizOptions("Lightwell_Buddy", "Lightwell Buddy", nil, "general"); -- add the general options to the bliz options window

	self.optionFrames.general.default = function() self:SetDefaultOptions() end; -- enable use of the default button
	self.optionFrames.profiles = AceConfigDialog:AddToBlizOptions("Lightwell_Buddy", L["Modify Profiles"], "Lightwell Buddy", "profiles"); --{profileManagement}-- add the profile options to the bliz options window

	--Create slash commands
    	self:RegisterChatCommand("lwb", "ChatCommand")
    	self:RegisterChatCommand("lightwellbuddy", "ChatCommand")

	--create channel lists, including custom channels.
	LWB:updateChannelsList()
	LWB:updateChannelsWithWhispersList()
	-- Run LWB:OnProfileChanged to create default announcements. Only needed the first time the add-on has ran. 
	LWB:OnProfileChanged() 


end;

--Enable add-on. Detect if the player is a priest and has lightwell/lightspring. soft-disable if playerClass is non-priest. Register for combat events if englishClass is a priest
function LWB:OnEnable()
	PLAYER_NAME, PLAYER_GUID = UnitName("player"), UnitGUID("player")
	localizedClass, englishClass = UnitClass("player")

	--set counter defaults and localization
	LightwellCounterFormChargesLabel:SetText (L["No lightwell up"])
	LightwellCounterFormBar:SetStatusBarColor(LWB.db.profile.counterBarR, LWB.db.profile.counterBarG, LWB.db.profile.counterBarB)
	LightwellCounterFormBar:SetStatusBarTexture(LSM:Fetch("statusbar", LWB.db.profile.counterBarTexture))
	LightwellCounterForm:SetBackdrop({ 
		bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
		edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
		insets = { 	left = LWB.db.profile.counterSkinInset, 
				right = LWB.db.profile.counterSkinInset, 
				top = LWB.db.profile.counterSkinInset, 
				bottom = LWB.db.profile.counterSkinInset, }
	})
	LightwellCounterFormChargesLabel:SetFont(LSM:Fetch("font", LWB.db.profile.counterFont),12)	
	
	
	if englishClass == "PRIEST" and (GetSpellBookItemInfo(GetSpellInfo(LIGHTWELL_SPELLID)) or GetSpellBookItemInfo(GetSpellInfo(LIGHTSPRING_SPELLID))) then
		--Priest detected, and has lightwell/lightspring. Register all events.
		isHoly = true
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED"); -- used to detect lightwell summon, uses and, heals
		self:RegisterEvent("PLAYER_TOTEM_UPDATE");-- used to detect if the lightwell went away early
		self:RegisterEvent("PLAYER_REGEN_DISABLED");
		self:RegisterEvent("PLAYER_REGEN_ENABLED");
		self:RegisterEvent("LEARNED_SPELL_IN_TAB");
		LWB.counter.postChange()

		if GetTotemInfo(1) then
			self.LightwellUpFromEnable = true
		end
	elseif englishClass == "PRIEST" then
		--Priest detected, but the priest doesn't have lightwell/lightspring. Only monitor events that will detect if the player learns lightspring.
		isHoly = false
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
		self:RegisterEvent("LEARNED_SPELL_IN_TAB");
		LWB.counter.postChange()
	else 	
		--Player is not a priest, disable all events and hide graphical counter. 
		isHoly = false
		LightwellCounterForm:Hide()
		LWB.counter.postChange()
		self:Print(localizedClass.." detected Soft Disabling")
		self:Disable();
		return
	end
end

function LWB:OnProfileChanged() --Runs when a player changes their active profile, when they delete a profile or when they make a new one

	--Update the graphical counter with the new options
	LWB.MediaUpdate( )
	LWB.counter.postChange()
	LWB.counter.update()

	--Add default messages if none exist. Best to add default messages like this instead of through AceDB, because AceDB will keep trying to add messages back after a player manually deletes them. Messages will not be added unless the player resets their current profile (causing the count of phrases to be reset to 0), if they create a new profile, if they're loading an add-on for the first time, or if they're loading a profile for the first time since I added this section.
	if #LWB.db.profile.summonPhrases == 0 then LWB.db.profile.summonPhrases = {strsplit("\n",L["summonPhrases"])} end
	if #LWB.db.profile.usePhrases == 0 then LWB.db.profile.usePhrases = {strsplit("\n",L["usePhrases"])} end
	if #LWB.db.profile.wastePhrases == 0 then LWB.db.profile.wastePhrases = {strsplit("\n",L["wastePhrases"])} end
	if #LWB.db.profile.emptyPhrases == 0 then LWB.db.profile.emptyPhrases = {strsplit("\n",L["emptyPhrases"])} end
	if #LWB.db.profile.expirePhrases == 0 then LWB.db.profile.expirePhrases = {strsplit("\n",L["expirePhrases"])} end
	if #LWB.db.profile.disappearPhrases == 0 then LWB.db.profile.disappearPhrases = {strsplit("\n",L["disappearPhrases"])} end
	if #LWB.db.profile.multiconsumptionPhrases == 0 then LWB.db.profile.multiconsumptionPhrases = {strsplit("\n",L["multiconsumptionPhrases"])} end
	if #LWB.db.profile.idlePhrases == 0 then LWB.db.profile.idlePhrases = {strsplit("\n",L["idlePhrases"])} end

	--If the configuration window is already open, this will refresh it with the window to display the new options without have to close and re-open it.
	LibStub("AceConfigRegistry-3.0"):NotifyChange("Lightwell_Buddy")
end


function LWB:OnDisable()
--	if changingProfile == true then return end
	LightwellCounterForm:Hide()
	self.lightwellUp = false
	self:UnregisterAllEvents()
	self:CancelAllTimers()
end;

function LWB:Reload() -- simple function to disable then enable if currently enabled
	if self:IsEnabled() then
		self:Disable();
		self:Enable();
	end;
end;


function LWB:SetDefaultOptions() -- resets the options then tells the config to refresh
	self.db:ResetProfile();
	AceConfigRegistry:NotifyChange("Lightwell_Buddy");
end;


--###########################################
--##### Soft Enabling/Disabling #############
--###########################################
--Detect if the priest gains or loses the Lightwell/Lightspring ability by learning the ability or switching profiles, and soft-enable/disable.

function LWB:ACTIVE_TALENT_GROUP_CHANGED(activeSpec)
	--Enable the addon's core functions if the spell lightwell or lightspring are in the spellbook. 
	if englishClass == "PRIEST" and (GetSpellBookItemInfo(GetSpellInfo(LIGHTWELL_SPELLID)) or GetSpellBookItemInfo(GetSpellInfo(LIGHTSPRING_SPELLID))) then
		isHoly = true
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED"); -- used to detect lightwell summon, uses and, heals
		self:RegisterEvent("PLAYER_TOTEM_UPDATE");-- used to detect if the lightwell went away early
		self:RegisterEvent("PLAYER_REGEN_DISABLED");
		self:RegisterEvent("PLAYER_REGEN_ENABLED");
		LWB.counter.postChange()
	else
		isHoly = false
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED"); -- used to detect lightwell summon, uses and, heals
		self:UnregisterEvent("PLAYER_TOTEM_UPDATE");-- used to detect if the lightwell went away early
		self:UnregisterEvent("PLAYER_REGEN_DISABLED");
		self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		LightwellCounterForm:Hide()
	end

end


function LWB:LEARNED_SPELL_IN_TAB()
	--Detect if the player JUST learned lightwell for the first time
	LWB:ACTIVE_TALENT_GROUP_CHANGED()
end




function LWB:CHAT_MSG_CHANNEL_NOTICE() -- Update the drop down menus in the configuration that show available channels, in particular when a player creates a custom channel (but the event will fire even when non-custom channels change, like when changing zones)
	--update channel lists
	LWB:updateChannelsList()
	LWB:updateChannelsWithWhispersList()
	--update the configuration window to show the new lists without having to close and re-open
	LibStub("AceConfigRegistry-3.0"):NotifyChange("Lightwell_Buddy")
end





--###########################################
--##### Slash Command Handler################
--###########################################

function LWB:ChatCommand(input)
	if strlower(input:trim()) == strlower(L["Config"]) then
		InterfaceOptionsFrame_OpenToCategory(self.optionFrames.general)
	elseif strlower(input:trim()) == strlower(L["Blacklist"]) then
		
		if UnitName("target") then
			local targetFullName = ""
	
			local targetName, targetRealm = UnitName("target")

			if targetRealm then
				targetFullName = targetName.."-"..targetRealm
			else targetFullName = targetName
			end
			
			if LWB:IsBlacklisted(targetFullName) then
				local m = gsub(L["Already Blacklisted"],"%[PlayerName%]", targetFullName)
				LWB:Print(m)
			
			--add players starting at the second key. First is reserved for a drop-box description.
			else 
				tinsert(LWB.db.profile.blackList,2,targetFullName) 
				local m = gsub(L["Added to Blacklist"],"%[PlayerName%]", targetFullName)
				LWB:Print(m)
			end
		else self:Print(L["Blacklist Instructions"])
		end
	else
        	LWB:Print(L["/lwb config -- opens the configuration window"])
		LWB:Print(L["/lwb blacklist -- blacklists your current target"])
    	end
end

function LWB:IsBlacklisted(item)
       local index = 1;
       while LWB.db.profile.blackList[index] do
               if ( strlower(item) == strlower(LWB.db.profile.blackList[index]) ) then
                       return 1;
               end
               index = index + 1;
       end
       return nil;
end

--###########################################
--##### Utility Functions####################
--###########################################


function LWB:LWBtablecopy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end;




--###########################################
--##### Timers###############################
--###########################################

--These timers are activated by LWB:COMBAT_LOG_EVENT_UNFILTERED and send messages when the lightwell expires, has sat idle, and update the graphical counter's alpha and pulse at standard intervals. 

function LWB:lightwellUnused() --Monitors how long the lightwell has been un-used
	LWB.idleTime = 0
	LWB.idleCycles = 0
	
	--This function is only called when the lightwell is summoned or used, so cancel and re-start the idle timer
	if self.lightwellUnusedTimer then
		self:CancelTimer(self.lightwellUnusedTimer,true) self.lightwellUnusedTimer = nil
	end
	self.lightwellUnusedTimer = self:ScheduleRepeatingTimer(function() -- lightwell hasn't been used for given time period


		if self.lightwellUp == true then
				LWB.idleTime = LWB.idleTime + 1

				--Check if the idle time is evenly divisible by the maximum amount of time a lightwell can be idle before a message should be sent. If it is evenly divisible, send a message.

				if floor(LWB.idleTime / LWB.db.profile.idleMaxTime) == LWB.idleTime / LWB.db.profile.idleMaxTime and (InCombatLockdown() or self.db.profile.talkOutOfCombat) then
					self:SmartRandomChatMessage(self.db.profile.idleChannel, self.db.profile.idlePhrases, self.db.profile.idleRate, self.db.profile.idleCD, PLAYER_NAME)
				end
		else self:CancelTimer(self.lightwellUnusedTimer,true) self.lightwellUnusedTimer = nil
		end			
	end, 1) 
end

--Activate these timers when a lightwell is detected as summoned in LWB:COMBAT_LOG_EVENT_UNFILTERED. 
function LWB:lightwellTotalTimer(totalTimeLeft)
	if not(totalTimeLeft) then totalTimeLeft = 179 end
	LWB.totalTimeLeft = totalTimeLeft
	
	--Clear old timers if they are currently active, for whatever reason (possible if the priest is given shortened or instant cooldown refresh)
	if self.lightwellTimer then self:CancelTimer(self.lightwellTimer,true)	self.lightwellTimer  = nil end
	if self.lightwellUnusedTimer then self:CancelTimer(self.lightwellUnusedTimer,true) self.lightwellUnusedTimer = nil end -- prevent lightwellUnused from firing
	if self.lightwellCounterUpdate then self:CancelTimer(self.lightwellCounterUpdate,true) self.lightwellCounterUpdate = nil end -- cancel the counter update graphic timer


	self.lightwellTimer = self:ScheduleTimer(function() -- lightwell expired
		self.lightwellUp = false -- pervent disappear from fireing

		if self.db.profile.alert then
			local m = gsub(L["Lightwell Expired with [Charges] charges remaining!"],"%[Charges%]", self.chargesRemaining)
			self:Print(UIErrorsFrame, m)
		end
		if (InCombatLockdown() or self.db.profile.talkOutOfCombat) then
			self:SmartRandomChatMessage(self.db.profile.expireChannel, self.db.profile.expirePhrases, self.db.profile.expireRate, self.db.profile.expireCD, PLAYER_NAME)
		end
		self:CancelTimer(self.lightwellUnusedTimer,true) -- prevent lightwellUnused from firing
		self:CancelTimer(self.lightwellCounterUpdate,true) -- cancel the counter update graphic timer
		self.lightwellUnusedTimer = nil
		self.lightwellCounterUpdate = nil
		self.chargesRemaining = 0

		LWB.counter.update()
		self.log.downTime = time()
		self:ReportLog(self.log)
	end, LWB.totalTimeLeft) -- 179 is 3 mins - 1 sec to make sure the timer goes off before the lightwell totem update is fired

	self.lightwellCounterUpdate = self:ScheduleRepeatingTimer(function() -- repeating timer refreshes every 0.1 seconds to update the graphical counter color
		if self.lightwellUp == true then
			LWB.totalTimeLeft = LWB.totalTimeLeft - .1

   			local timeLeft = LWB.totalTimeLeft  + 1
   			if timeLeft > LWB.db.profile.counterBeginPulsing then

        			-- do colour
        			local val = timeLeft / 180;
       				val = (0.5 + 0.5*val);
       				LightwellCounterFormBar:SetAlpha(val);
     			end

        			-- do pulsing
     			if (timeLeft <= LWB.db.profile.counterBeginPulsing) and timeLeft > 0 then
         			LightwellCounterFormBar:SetAlpha(math.abs(math.sin(math.pi*timeLeft))/2.5 + .35);
     			end
		else self:CancelTimer(self.lightwellCounterUpdate,true) self.lightwellCounterUpdate = nil
		end			
	end, .1) 


end



--##################################################
--##### Combat Log Unfiltered - Core Function#######
--##################################################

--Monitors the combat log for lightwell summon and use events. Activates timers that monitor how long the lightwell has been out and unused, and periodically updates the graphical counter's pulse and alpha. 
--Sends announcements when the lightwell is summoned, used, or consumed.

function LWB:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, _, sourceGUID, _, _, _, _, destName, _, _, spellId, _, _, amount, overhealing, absorbed, critical)
	if sourceGUID == PLAYER_GUID and not self.LightwellUpFromEnable then
		if event == "SPELL_SUMMON" and (spellId == LIGHTWELL_SPELLID or spellId == LIGHTSPRING_SPELLID) then -- lightwell summoned
			self.chargesMax = 15
			self.chargesRemaining = 15
			self.chargesUsed = 0
			for i = 1, GetNumGlyphSockets() do
				local enabled, _, _, glyphSpellID = GetGlyphSocketInfo(i,GetActiveSpecGroup(false, "player"));
				if enabled and glyphSpellID == LIGHTWELL_GLYPH_SPELLID then 
					self.chargesMax = 17
					self.chargesRemaining = 17
				end
			end
			self.log = {
				upTime = time(),
				healing = 0,
				effectiveHealing = 0,
				overHealing = 0,
				absorbed = 0,
				crits = 0,
				chargesUsed = 0,
				renewTicks = 0,
			}
			self.logs[self.log.upTime] = self.log -- save lightwell log for later -- not yet used
			if self.db.profile.alert then
				self:Print(UIErrorsFrame, L["Lightwell Summoned!"])
			end

			--Update the Counter
			LightwellCounterFormBar:SetAlpha(1);
			LWB.counter.update();
					    if (not(LWB.db.profile.counterHideCombat) or InCombatLockdown()==1) and LWB.db.profile.counterEnable then LightwellCounterForm:Show(); end

			self:SmartRandomChatMessage(self.db.profile.summonChannel, self.db.profile.summonPhrases, self.db.profile.summonRate, self.db.profile.summonCD, PLAYER_NAME)
			LWB:lightwellTotalTimer()
			LWB:lightwellUnused()
			self.lightwellUp = true
			


		elseif event == "SPELL_AURA_REFRESH" and (spellId == LIGHTWELL_RENEW_SPELLID or spellId == LIGHTSPRING_RENEW_SPELLID) then



			self.chargesRemaining = self.chargesRemaining - 1
			self.chargesUsed = self.chargesUsed + 1
			self.log.chargesUsed = self.log.chargesUsed + 1
			LWB.counter.update();
			if self.db.profile.alert then
				local m = gsub(L["Multiple Lightwell Charges Used by [PlayerName] ([chargesRemaining]/[chargesMax] Left)"],"%[PlayerName%]",destName)
				m = gsub(m,"%[chargesRemaining%]",self.chargesRemaining)
				m = gsub(m,"%[chargesMax%]",self.chargesMax)
				self:Print(UIErrorsFrame, m)
			end

			if (self.db.profile.talkToStrangers or UnitInParty(destName) or UnitInRaid(destName)) then
					self:SmartRandomChatMessage(self.db.profile.multiconsumptionChannel, self.db.profile.multiconsumptionPhrases, self.db.profile.multiconsumptionRate, self.db.profile.multiconsumptionCD, destName)
				end




		elseif event == "SPELL_AURA_APPLIED" and (spellId == LIGHTWELL_RENEW_SPELLID or spellId == LIGHTSPRING_RENEW_SPELLID) then -- lightwell used

			LWB:lightwellUnused()
			self.chargesRemaining = self.chargesRemaining - 1
			self.chargesUsed = self.chargesUsed + 1
			self.log.chargesUsed = self.log.chargesUsed + 1
			LWB.counter.update()
			if not (UnitInParty(destName) or UnitInRaid(destName)) or UnitHealth(destName)/UnitHealthMax(destName) <= self.db.profile.wasteCutOff then
				if self.db.profile.alert then
					local m = gsub(L["Lightwell Used by [PlayerName] ([chargesRemaining]/[chargesMax] Left)"],"%[PlayerName%]",destName)
					m = gsub(m,"%[chargesRemaining%]",self.chargesRemaining)
					m = gsub(m,"%[chargesMax%]",self.chargesMax)
					self:Print(UIErrorsFrame, m)
				end
				if (self.chargesRemaining ~= 0 or self.db.profile.msgOnLastUse) and (self.db.profile.talkToStrangers or UnitInParty(destName) or UnitInRaid(destName)) and not(LWB:IsBlacklisted(destName)) then
					local personalList = self:PlayerInPersonalList(destName)
					if personalList then
						self:SmartRandomChatMessage(self.db.profile.personalLists.channel[personalList], self.db.profile.personalLists.phrases[personalList], self.db.profile.personalLists.rate[personalList],0, destName)
					else
						self:SmartRandomChatMessage(self.db.profile.useChannel, self.db.profile.usePhrases, self.db.profile.useRate, self.db.profile.useCD, destName)
					end
				end
			else
				if self.db.profile.alert then
					local m = gsub(L["Lightwell Wasted by [PlayerName] ([chargesRemaining]/[chargesMax] Left)"],"%[PlayerName%]",destName)
					m = gsub(m,"%[chargesRemaining%]",self.chargesRemaining)
					m = gsub(m,"%[chargesMax%]",self.chargesMax)
					self:Print(UIErrorsFrame, m)

				end
				if (self.chargesRemaining ~= 0 or self.db.profile.msgOnLastUse) and (self.db.profile.talkToStrangers or UnitInParty(destName) or UnitInRaid(destName)) then
					self:SmartRandomChatMessage(self.db.profile.wasteChannel, self.db.profile.wastePhrases, self.db.profile.wasteRate, self.db.profile.wasteCD, destName)
				end
			end
			if self.chargesRemaining == 0 then -- lightwell out of charges
				self.lightwellUp = false -- pervent disappear from fireing
				self:CancelTimer(self.lightwellTimer, true) -- pervent expire timer from fireing
				self.lightwellTimer = nil
				if self.db.profile.alert then
					self:Print(UIErrorsFrame, L["Lightwell Empty!"])
				end
				self:SmartRandomChatMessage(self.db.profile.emptyChannel, self.db.profile.emptyPhrases, self.db.profile.emptyRate, self.db.profile.emptyCD, PLAYER_NAME)
				self:CancelTimer(self.lightwellUnusedTimer,true)
				self.lightwellUnusedTimer = nil
				self.log.downTime = time()
				self:ReportLog(self.log)
			end
		elseif event == "SPELL_PERIODIC_HEAL" and (spellId == LIGHTWELL_RENEW_SPELLID or spellId == LIGHTSPRING_RENEW_SPELLID) then-- lightwell healed
				self.log.renewTicks = self.log.renewTicks + 1
				self.log.healing = self.log.healing + amount
				self.log.effectiveHealing = self.log.effectiveHealing + (amount - (overhealing + absorbed))
				self.log.overHealing = self.log.overHealing + overhealing
				self.log.absorbed = self.log.absorbed + absorbed
				if critical then
					self.log.crits = self.log.crits + 1
				end
		end
	end
end


--Identify if lightwell has disappeared early, for example if the priests runs out of range of it or if it's killed
function LWB:PLAYER_TOTEM_UPDATE(_, slot)
	if slot == 1 and self.LightwellUpFromEnable and not GetTotemInfo(1) then
		self.LightwellUpFromEnable = false
		LWB.chargesRemaining = 0
	elseif slot == 1 and self.lightwellUp and not GetTotemInfo(1) then
		self.lightwellUp = false -- pervent disappear from fireing agein
		self:CancelTimer(self.lightwellTimer, true) -- pervent expire timer from fireing
		self.lightwellTimer = nil

		if self.db.profile.alert then
			local m = gsub(L["Lightwell Disappeared with [chargesRemaining] charges remaining!"],"%[chargesRemaining%]",self.chargesRemaining)
			self:Print(UIErrorsFrame, m)
		end
		if (InCombatLockdown() or self.db.profile.talkOutOfCombat) then
			self:SmartRandomChatMessage(self.db.profile.disappearChannel, self.db.profile.disappearPhrases, self.db.profile.disappearRate,self.db.profile.disappearCD, PLAYER_NAME)
		end
		self:CancelTimer(self.lightwellUnusedTimer,true)
		self.lightwellUnusedTimer = nil
		LWB.chargesRemaining = 0
		self.log.downTime = time()
		self:ReportLog(self.log)
	end
	LWB.counter.update();
end


--Pick and send randomized message. Accepts commands from the Idle and Expiration timers, when the lightwell disappears, and use/summon events from LWB:COMBAT_LOG_EVENT_UNFILTERED
function LWB:SmartRandomChatMessage(channel, messages, rate, cd, user) -- function to handle the channels "LIGHTWELLEMOTE", "LIGHTWELLSAY" and "SMART" also replaces the placeholders

	if not(LWB.db.profile.messagingEnabled) then return nil end
	if not(messages) or #messages == 0 then return nil end
	if not(messages.messageLastTimeSent) then messages.messageLastTimeSent = 0 end
	if channel == "NONE" then return nil end
	if random() > rate then return nil end
	if messages.messageLastTimeSent > time() - cd then return nil end
	
	--detect lightspring glyph. Announce if lightspring glyph is inactive, or if the player has selected to announce for lightspring
	local lightspringGlyphActive = false
	for i = 1, GetNumGlyphSockets() do
		local enabled, _, _, glyphSpellID = GetGlyphSocketInfo(i,GetActiveSpecGroup(false, "player"));
		if enabled and glyphSpellID == LIGHTSPRING_GLYPH_SPELLID then 
			lightspringGlyphActive = true
		end
	end
	
	if lightspringGlyphActive == true or (lightspringGlyphActive == false and LWB.db.profile.lightspringSupport) then
	else return
	end


	
	if not(messages.used) then
		messages.used = {}
	end

	if #messages.used >= floor((#messages)/1.5) then 
		wipe(messages.used)
	end

	local messagePosition
	repeat
	messagePosition = random(#messages)
	if tContains(messages.used,messagePosition) then
		message = nil
	else 
		message = messages[messagePosition]
	end
	until message

	if message then 
		tinsert(messages.used,1,messagePosition) 
		tremove(messages.used,floor((#messages)/1.5))
		tremove(messages.used,floor((#messages)/1.5))
	end
	local channelNum = nil
	local addonChannel = nil
	local groupStatus = nil
	

	local InInstance, InstanceType = IsInInstance()
	if UnitInBattleground("player") then groupStatus = "BATTLEGROUND"
	elseif IsInRaid() and GetNumGroupMembers() > 0 then groupStatus = "RAID"
	elseif (not IsInRaid()) and GetNumSubgroupMembers() > 0 then groupStatus = "PARTY"
	end
		

	if channel == "LIGHTWELLEMOTE" then
		message = "'s Lightwell "..message
		channel = "EMOTE"
	elseif channel == "LIGHTWELLSAY" then
		message = " Lightwell says: "..message
		channel = "SAY"
	elseif channel == "SMART" then
		if groupStatus == "BATTLEGROUND" or InstanceType == "pvp" or InstanceType == "arena" then channel = "INSTANCE_CHAT"
		elseif IsPartyLFG() and (groupStatus == "RAID" or groupStatus == "PARTY") then channel = "INSTANCE_CHAT"
		elseif groupStatus == "RAID" then channel = "RAID"
		elseif groupStatus == "PARTY" then channel = "PARTY"
		else channel = "SAY"
		end
	elseif GetChannelName(channel) > 0 then
		channelNum = GetChannelName(channel)
		channel = "CHANNEL"
	elseif tContains({"SAY","EMOTE","YELL","PARTY","GUILD","OFFICER","RAID","RAID_WARNING","BATTLEGROUND","WHISPER","INSTANCE_CHAT",},channel) then
	else
		return
	end

	if channel == "GUILD" 
		then  addonChannel = "GUILD"
	elseif channel == "BATTLEGROUND" 
		then addonChannel = "BATTLEGROUND"
	elseif channel == "OFFICER" 
		then addonChannel = "OFFICER"
	elseif channel == "SAY" 
		then addonChannel = groupStatus
	elseif channel == "EMOTE" 
		then addonChannel = groupStatus
	elseif channel == "NONE" 
		then addoncChannel = groupStatus
	elseif channel == "YELL" 
		then addonChannel = groupStatus
	elseif channel == "PARTY" 
		then addonChannel = "PARTY"
	elseif channel == "RAID" 
		then addonChannel = "RAID"
	elseif channel == "RAID_WARNING" 
		then addonChannel = "RAID"
	elseif channel == "INSTANCE_CHAT"
		then addonChannel = "INSTANCE_CHAT"
	else 
		addonChannel = groupStatus
	end


	local function subFunction(arg)
		if arg == "%u" then return gsub(strsub(user,1,strfind(user,"-",1,true)),"-","(*)") end -- user is PLAYER_NAME for all events other then Use and Waste
		if arg == "%p" then return PLAYER_NAME end
		if arg == "%c" then return self.chargesRemaining end
		if arg == "%x" then return self.chargesUsed end
		if arg == "%m" then return self.chargesMax end
		if arg == "%t" then return floor(180 - LWB:TimeLeft(LWB.lightwellTimer)) end--time past on lightwell 
		if arg == "%l" then return floor(LWB:TimeLeft(LWB.lightwellTimer)) end -- time left on lightwell 
		if arg == "%i" then return floor(LWB.idleTime) end --idle time 

	end
	message = string.gsub(message, "(%%[upcxmtli])", subFunction)
	messages.messageLastTimeSent = time()
--[broken]
--	self:SendCommMessage("FriedSpam", message, addonChannel, (channel == "WHISPER" and user) or (nil))


	SendChatMessage(message, channel, nil, (channel == "WHISPER" and user) or channelNum)

		
end;


function LWB:ReportLog(log) -- reports data about the last lightwell
	self:Print(L["Results of Lightwell:"])
	self:Print(L["Charges Used:"], self.log.chargesUsed)
	self:Print(L["Healing Done:"], self.log.healing)
	self:Print(L["Effective Healing:"], self.log.effectiveHealing)
	self:Print(L["Over Healing:"], self.log.overHealing)
	self:Print(L["Absorbed:"], self.log.absorbed)
	self:Print(L["Crits:"], self.log.crits)
end


--#######################################
--###### Graphic Counter Controls #######
--#######################################

--These commands are called to control whether the graphical counter should be visible or not based on player selected options, and updates the count of charges remaining after a charge is consumed in LWB:COMBAT_LOG_EVENT_UNFILTERED. Also contains the handlers for left-clicking and right-clicking the graphical counter.

LWB.counter = {}
LWB.counter.postChange = function()
	if LWB.db.profile.counterLockPosition then LightwellCounterForm:RegisterForDrag(); else LightwellCounterForm:RegisterForDrag("LeftButton"); end
	if not(isHoly) or not(LWB.db.profile.counterEnable) or (LWB.db.profile.counterHideCombat and InCombatLockdown()==nil) or (LWB.db.profile.counterHideDown and LWB.chargesRemaining==0) then LightwellCounterForm:Hide(); else LightwellCounterForm:Show(); end
end

function LWB:PLAYER_REGEN_DISABLED()
	if not(isHoly) or not(LWB.db.profile.counterEnable) then return end
	if not(LWB.db.profile.counterHideDown) or self.chargesRemaining~=0 then LightwellCounterForm:Show(); end
end

function LWB:PLAYER_REGEN_ENABLED()
	if LWB.db.profile.counterHideCombat then LightwellCounterForm:Hide(); end
end


LWB.counter.update = function ()
    local tehtext;

    LightwellCounterFormBar:SetValue(LWB.chargesRemaining / LWB.chargesMax);

    if LWB.chargesRemaining>0 then
        if LWB.chargesRemaining == 1 then
            tehtext = L["1 Charge"];
        else
            tehtext = gsub(L["[chargesRemaining] Charges"],"%[chargesRemaining%]", LWB.chargesRemaining )
        end  
    else
        tehtext = L["No lightwell up"];
		if LWB.db.profile.counterHideDown then LightwellCounterForm:Hide(); end
    end
    
    LightwellCounterFormChargesLabel:SetText (tehtext);
end



LWB.counter.handleClick = function (self, button)
	
	if button == "RightButton" then 
		InterfaceOptionsFrame_OpenToCategory(LWB.optionFrames.general)
	end
end

function LWB:counterHandleLeftClick(self, button)
	if button == "LeftButton" then
		local tbl = {}
		LWB.db:GetProfiles(tbl)
		sort(tbl)
		local currentProfile = LWB.db:GetCurrentProfile()
		local currentProfileIndex = nil
		local countProfiles = #tbl
		for k,v in ipairs(tbl) do
			if v == currentProfile then currentProfileIndex = k end
		end

		if currentProfileIndex == countProfiles then
			local m = gsub(L["Profile changed to: [profileName]"],"%[profileName%]",tbl[1])
			LWB.db:SetProfile(tbl[1])
			LWB:Print(m)
		else 
			local m = gsub(L["Profile changed to: [profileName]"],"%[profileName%]",tbl[currentProfileIndex + 1])
			LWB.db:SetProfile(tbl[currentProfileIndex + 1])
			LWB:Print(m)
		end
	end
end





