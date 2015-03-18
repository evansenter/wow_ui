--	15:58 16.03.2015

--[[
Bossmods: Kromog: added Test button
Bossmods: Malkorok Skada was removed
Fight log: New method of counting absorbs
Raid cooldowns: added new option: hide spark
Raid cooldowns: added support for items (Jeeves) and usable trinkets (665 world drop, Highmaul & BRF)
Raid cooldowns: added support for racial spells
Raid cooldowns: spells for low level players will be hidden if they don't learned them
Note: was reworked
Note: unlimited number of drafts
Note: drafts can be renamed
Note: personal note (will be shown after text of general note)
Note: added support for spells icons (template "{spell:SPELL_ID}")
Note: added option "Only trusted", which disables receive note updates from non-RL or non-officers
Raid loot: item level of some items was updated (blizzard's last hotfix)
Minor fixes
]]

local GlobalAddonName, ExRT = ...

ExRT.V = 3240
ExRT.T = "R"
ExRT.BETA = false

ExRT.OnUpdate = {}		--> таймеры, OnUpdate функции
ExRT.Slash = {}			--> функции вызова из коммандной строки
ExRT.OnAddonMessage = {}	--> внутренние сообщения аддона
ExRT.Eggs = {}			--> скрытые функции
ExRT.MiniMapMenu = {}		--> изменение меню кнопки на миникарте
ExRT.Modules = {}		--> список всех модулей
ExRT.ModulesLoaded = {}		--> список загруженных модулей [для Dev & Advanced]
ExRT.CLEU = {}			--> лист CLEU функций, для обработки

ExRT.A = {}			--> ссылки на все модули

ExRT.msg_prefix = {
	["EXRTADD"] = true,
	["MHADD"] = true,	--> Malkorok Helper (Curse client)
}

ExRT.L = {}			--> локализация
ExRT.locale = GetLocale()

ExRT.clientUIinterface = select(4,GetBuildInfo())

ExRT.ModulesOptions = {}

---------------> Modules <---------------
ExRT.mod = {}
ExRT.mod.__index = ExRT.mod

do
	local function mod_LoadOptions(this)
		if not InCombatLockdown() or this.enableLoadInCombat then
			this:Load()
			this:SetScript("OnShow",nil)
			ExRT.mds.dprint(this.moduleName.."'s options loaded")
			this.isLoaded = true
		else
			print(ExRT.L.SetErrorInCombat)
		end
	end
	function ExRT.mod:New(moduleName,localizatedName,disableOptions,enableLoadInCombat)
		local self = {}
		setmetatable(self, ExRT.mod)
		
		if not disableOptions then
			self.options = CreateFrame("Frame", "GExRT"..moduleName.."Options", ExRT.Options.panel)
			self.options.name = localizatedName or moduleName
			self.options.parent = ExRT.Options.panel.name
			if not ExRT.BannedModules[moduleName] then
				InterfaceOptions_AddCategory(self.options)
			end
			self.options:Hide()
			self.options.moduleName = moduleName
			self.options:SetScript("OnShow",mod_LoadOptions)
			
			if enableLoadInCombat then
				self.options.enableLoadInCombat = true
			end
			
			if not ExRT.BannedModules[moduleName] then
				ExRT.ModulesOptions[#ExRT.ModulesOptions + 1] = self.options
			end
		end
		
		self.main = CreateFrame("Frame", nil)
		self.main.events = {}
		self.main:SetScript("OnEvent",ExRT.mod.Event)
		
		if ExRT.T == "D" then
			self.main.eventsCounter = {}
			self.main:HookScript("OnEvent",ExRT.mod.HookEvent)
		end
		
		self.db = {}
		
		self.name = moduleName
		table.insert(ExRT.Modules,self)
		ExRT.A[moduleName] = self
		
		ExRT.mds.dprint("New module: "..moduleName)
		
		return self
	end
end

function ExRT.mod:Event(event,...)
	self[event](self,...)
end

function ExRT.mod:HookEvent(event)
	self.eventsCounter[event] = self.eventsCounter[event] and self.eventsCounter[event] + 1 or 1
end

function ExRT.mod:RegisterEvents(...)
	for i=1,select("#", ...) do
		local event = select(i,...)
		if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
			self.main:RegisterEvent(event)
		else
			ExRT.CLEU[ self.name ] = self.main.COMBAT_LOG_EVENT_UNFILTERED
		end
		self.main.events[event] = true
		ExRT.mds.dprint(self.name,'RegisterEvent',event)
	end
end

function ExRT.mod:UnregisterEvents(...)
	for i=1,select("#", ...) do
		local event = select(i,...)
		if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
			self.main:UnregisterEvent(event)
		else
			ExRT.CLEU[ self.name ] = nil
		end
		self.main.events[event] = nil
		ExRT.mds.dprint(self.name,'UnregisterEvent',event)
	end
end

function ExRT.mod:RegisterUnitEvent(...)
	self.main:RegisterUnitEvent(...)
	local event = select(1,...)
	self.main.events[event] = true
	ExRT.mds.dprint(self.name,'RegisterUnitEvent',event)
end

function ExRT.mod:RegisterTimer()
	ExRT.OnUpdate[self.name] = self
end

function ExRT.mod:UnregisterTimer()
	ExRT.OnUpdate[self.name] = nil
end

function ExRT.mod:RegisterSlash()
	ExRT.Slash[self.name] = self
end

function ExRT.mod:UnregisterSlash()
	ExRT.Slash[self.name] = nil
end

function ExRT.mod:RegisterAddonMessage()
	ExRT.OnAddonMessage[self.name] = self
end

function ExRT.mod:UnregisterAddonMessage()
	ExRT.OnAddonMessage[self.name] = nil
end

function ExRT.mod:RegisterEgg()
	ExRT.Eggs[self.name] = self
end

function ExRT.mod:UnregisterEgg()
	ExRT.Eggs[self.name] = nil
end

function ExRT.mod:RegisterMiniMapMenu()
	ExRT.MiniMapMenu[self.name] = self
end

function ExRT.mod:UnregisterMiniMapMenu()
	ExRT.MiniMapMenu[self.name] = nil
end

do
	local hideOnPetBattle = {}
	local petBattleTracker = CreateFrame("Frame")
	petBattleTracker:SetScript("OnEvent",function (self, event)
		if event == "PET_BATTLE_OPENING_START" then
			for _,frame in pairs(hideOnPetBattle) do
				if frame:IsShown() then
					frame.petBattleHide = true
					frame:Hide()
				else
					frame.petBattleHide = nil
				end
			end
		else
			for _,frame in pairs(hideOnPetBattle) do
				if frame.petBattleHide then
					frame.petBattleHide = nil
					frame:Show()
				end
			end
		end
	end)
	petBattleTracker:RegisterEvent("PET_BATTLE_OPENING_START")
	petBattleTracker:RegisterEvent("PET_BATTLE_CLOSE")
	function ExRT.mod:RegisterHideOnPetBattle(frame)
		hideOnPetBattle[#hideOnPetBattle + 1] = frame
	end
end

-------------> upvalues <-------------
local GetTime = GetTime
local UnitName = UnitName
local IsEncounterInProgress = IsEncounterInProgress
local SendAddonMessage, pcall = SendAddonMessage, pcall
local select, floor, tonumber, tostring, string_sub, string_find, string_len, bit_band, type, unpack, pairs, format, strsplit = select, floor, tonumber, tostring, string.sub, string.find, string.len, bit.band, type, unpack, pairs, format, strsplit
local RAID_CLASS_COLORS, COMBATLOG_OBJECT_TYPE_MASK, COMBATLOG_OBJECT_CONTROL_MASK, COMBATLOG_OBJECT_REACTION_MASK, COMBATLOG_OBJECT_AFFILIATION_MASK, COMBATLOG_OBJECT_SPECIAL_MASK = RAID_CLASS_COLORS, COMBATLOG_OBJECT_TYPE_MASK, COMBATLOG_OBJECT_CONTROL_MASK, COMBATLOG_OBJECT_REACTION_MASK, COMBATLOG_OBJECT_AFFILIATION_MASK, COMBATLOG_OBJECT_SPECIAL_MASK
local C_Timer_NewTimer, C_Timer_NewTicker = C_Timer.NewTimer, C_Timer.NewTicker

if ExRT.T == "D" then
	pcall = function(func,...)
		func(...)
	end
end

ExRT.NULL = {}
ExRT.NULLfunc = function() end
---------------> Mods <---------------
ExRT.mds = {}

do
	local antiSpamArr = {}
	function ExRT.mds.AntiSpam(numantispam,addtime)
		if not antiSpamArr[numantispam] or antiSpamArr[numantispam] < GetTime() then
			antiSpamArr[numantispam] = GetTime() + addtime
			return true
		else
			return false
		end
	end
	function ExRT.mds.ResetAntiSpam(numantispam)
		antiSpamArr[numantispam] = nil
	end
end

do
	local classColorArray = nil
	function ExRT.mds.classColor(class)
		classColorArray = RAID_CLASS_COLORS[class]
		if classColorArray and classColorArray.colorStr then
			return classColorArray.colorStr
		else
			return "ffbbbbbb"
		end
	end

	function ExRT.mds.classColorNum(class)
		classColorArray = RAID_CLASS_COLORS[class]
		if classColorArray then
			return classColorArray.r,classColorArray.g,classColorArray.b
		else
			return 0.8,0.8,0.8
		end
	end
	
	function ExRT.mds.classColorByGUID(guid)
		local class = ""
		if guid and guid ~= "" and guid ~= "0000000000000000" then
			class = select(2,GetPlayerInfoByGUID(guid))
		end
		return ExRT.mds.classColor(class)
	end
end

function ExRT.mds.clearTextTag(text,SpellLinksEnabled)
	if text then
		text = string.gsub(text,"|c........","")
		text = string.gsub(text,"|r","")
		text = string.gsub(text,"|T.-:0|t ","")
		text = string.gsub(text,"|HExRT:.-|h(.-)|h","%1")
		if SpellLinksEnabled then
			text = string.gsub(text,"|H(spell:.-)|h(.-)|h","|cff71d5ff|H%1|h[%2]|h|r")
		else
			text = string.gsub(text,"|H(spell:.-)|h(.-)|h","%2")
		end
		return text
	end
end

function ExRT.mds.splitLongLine(text,maxLetters,SpellLinksEnabled)
	maxLetters = maxLetters or 250
	local result = {}
	repeat
		local lettersNow = maxLetters
		if SpellLinksEnabled then
			local lastC = 0
			local lastR = 0
			for i=1,(maxLetters-1) do
				local word = string.sub(text,i,i+1)
				if word == "|c" then
					lastC = i
				elseif word == "|r" then
					lastR = i
				end
			end
			if lastC > 0 and lastC > lastR then
				lettersNow = lastC - 1
			end
		end
		
		local utf8pos = 1
		local textLen = string.len(text)
		while true do
			local char = string.sub(text,utf8pos,utf8pos)
			local c = char:byte()
			
			local lastPos = utf8pos
			
			if c > 0 and c <= 127 then
				utf8pos = utf8pos + 1
			elseif c >= 194 and c <= 223 then
				utf8pos = utf8pos + 2
			elseif c >= 224 and c <= 239 then
				utf8pos = utf8pos + 3
			elseif c >= 240 and c <= 244 then
				utf8pos = utf8pos + 4
			else
				utf8pos = utf8pos + 1
			end
			
			if utf8pos > lettersNow then
				lettersNow = lastPos - 1
				break
			elseif utf8pos >= textLen then
				break
			end		
		end		
		result[#result + 1] = string.sub(text,1,lettersNow)
		text = string.sub(text,lettersNow+1)
	until string.len(text) < maxLetters
	if string.len(text) > 0 then
		result[#result + 1] = text
	end
	return unpack(result)
end

function ExRT.mds:SetScaleFix(scale)
	local l = self:GetLeft()
	local t = self:GetTop()
	local s = self:GetScale()
	if not l or not t or not s then return end

	s = scale / s

	self:SetScale(scale)
	local f = self:GetScript("OnDragStop")

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",l / s,t / s)

	if f then f(self) end
end

function ExRT.mds:GetCursorPos()
	local x_f,y_f = GetCursorPosition()
	local s = self:GetEffectiveScale()
	x_f, y_f = x_f/s, y_f/s
	local x,y = self:GetLeft(),self:GetTop()
	x = x_f-x
	y = (y_f-y)*(-1)
	return x,y
end

do
	local function FindAllParents(self,obj)
		while obj do
			if obj == self then
				return true
			end
			obj = obj:GetParent()
		end
	end
	function ExRT.mds:IsInFocus(x,y,childs)
		if not x then
			x,y = ExRT.mds.GetCursorPos(self)
		end
		local obj = GetMouseFocus()
		if x > 0 and y > 0 and x < self:GetWidth() and y < self:GetHeight() and (obj == self or (childs and FindAllParents(self,obj))) then
			return true
		end
	end
end

function ExRT.mds:LockMove(isLocked,touchTexture,dontTouchMouse)
	if isLocked then
		if touchTexture then touchTexture:SetTexture(0,0,0,0.3) end
		self:SetMovable(true)
		if not dontTouchMouse then self:EnableMouse(true) end
	else
		if touchTexture then touchTexture:SetTexture(0,0,0,0) end
		self:SetMovable(false)
		if not dontTouchMouse then self:EnableMouse(false) end
	end
end

do
	local function HiddenDropDown()
		if _G["DropDownList1"] and not _G["DropDownList1"]:IsShown() then 
			ExRT.mds.dropDownBlizzFix = nil 
		end 
	end
	function ExRT.mds.FixDropDown(width)
		ExRT.mds.dropDownBlizzFix = width
		ExRT.mds.ScheduleTimer(HiddenDropDown, 0.1)
	end
end

function ExRT.mds.GetRaidDiffMaxGroup()
	local _,instance_type,difficulty = GetInstanceInfo()
	if (instance_type == "party" or instance_type == "scenario") and not IsInRaid() then
		return 1
	elseif instance_type ~= "raid" then
		return 8
	elseif difficulty == 8 or difficulty == 1 or difficulty == 2 then
		return 1
	elseif difficulty == 14 or difficulty == 15 then
		return 6
	elseif difficulty == 16 then
		return 4
	elseif difficulty == 3 or difficulty == 5 then
		return 2
	elseif difficulty == 9 then
		return 8
	else
		return 5
	end	
end

function ExRT.mds.GetDifficultyForCooldownReset()
	local _,_,difficulty = GetInstanceInfo()
	if difficulty == 3 or difficulty == 4 or difficulty == 5 or difficulty == 6 or difficulty == 7 or difficulty == 14 or difficulty == 15 or difficulty == 16 or difficulty == 17 then
		return true
	end
	return false
end

function ExRT.mds.Round(i)
	return floor(i+0.5)
end

function ExRT.mds.NumberInRange(i,mi,mx,incMi,incMx)
	if i and ((incMi and i >= mi) or (not incMi and i > mi)) and ((incMx and i <= mx) or (not incMx and i < mx)) then
		return true
	end
end

function ExRT.mds.delUnitNameServer(unitName)
	if string_find(unitName,"%-") then 
		unitName = string_sub(unitName,1,string_find(unitName,"%-")-1) 
	end
	return unitName
end

function ExRT.mds.UnitCombatlogname(unit)
	local name,server = UnitName(unit or "?")
	if name and server and server~="" then
		name = name .. "-" .. server
	end
	return name
end

do
	local old_types = {
		Player = 0,
		Creature = 3,
		Pet = 4,
		Vehicle = 5,
		GameObject = 6,		--NEW
		Vignette = 7,		--NEW
		Item = 8,		--NEW Item:976:0:4000000003A91C1A
		Uniq = 9,		--NEW
	}
	function ExRT.mds.GetUnitTypeByGUID(guid)
		if guid then
			local _type = guid:match("^([A-z]+)%-")
			if _type then
				return old_types[_type]
			end
		end
	end
end

function ExRT.mds.UnitIsPlayerOrPet(guid)
	local id = ExRT.mds.GetUnitTypeByGUID(guid)
	if id == 0 or id == 4 then
		return true
	end
end

function ExRT.mds.GetUnitInfoByUnitFlag(unitFlag,infoType)
	--> TYPE
	if infoType == 1 then
		return bit_band(unitFlag,COMBATLOG_OBJECT_TYPE_MASK)
		--[1024]="player", [2048]="NPC", [4096]="pet", [8192]="GUARDIAN", [16384]="OBJECT"
		
	--> CONTROL
	elseif infoType == 2 then
		return bit_band(unitFlag,COMBATLOG_OBJECT_CONTROL_MASK)
		--[256]="by players", [512]="by NPC",
		
	--> REACTION
	elseif infoType == 3 then
		return bit_band(unitFlag,COMBATLOG_OBJECT_REACTION_MASK)
		--[16]="FRIENDLY", [32]="NEUTRAL", [64]="HOSTILE"
		
	--> Controller affiliation
	elseif infoType == 4 then
		return bit_band(unitFlag,COMBATLOG_OBJECT_AFFILIATION_MASK)
		--[1]="player", [2]="PARTY", [4]="RAID", [8]="OUTSIDER"
		
	--> Special
	elseif infoType == 5 then
		return bit_band(unitFlag,COMBATLOG_OBJECT_SPECIAL_MASK)
		--Not all !  [65536]="TARGET", [131072]="FOCUS", [262144]="MAINTANK", [524288]="MAINASSIST"
	end
end

function ExRT.mds.UnitIsFriendlyByUnitFlag(unitFlag)
	if ExRT.mds.GetUnitInfoByUnitFlag(unitFlag,2) == 256 then
		return true
	end
end

function ExRT.mds.UnitIsFriendlyByUnitFlag2(unitFlag)
	local reaction = ExRT.mds.GetUnitInfoByUnitFlag(unitFlag,3)
	if reaction == 16 then
		return true
	elseif reaction == 32 then
		if ExRT.mds.GetUnitInfoByUnitFlag(unitFlag,2) == 256 then
			return true
		end
	end
end

function ExRT.mds.dprint(...)
	return nil
end
if ExRT.T == "D" then
	ExRT.mds.dprint = function(...)
		print(...)
	end
end

function ExRT.mds.LinkSpell(SpellID,SpellLink)
	if not SpellLink then
		SpellLink = GetSpellLink(SpellID)
	end
	if SpellLink then
		if ChatEdit_GetActiveWindow() then
			ChatEdit_InsertLink(SpellLink)
		else
			ChatFrame_OpenChat(SpellLink)
		end
	end
end

function ExRT.mds.LinkItem(itemID, itemLink)
	if not itemLink then
		if not itemID then 
			return 
		end
		itemLink = select(2,GetItemInfo(itemID))
	end
	if not itemLink then
		return
	end
	if IsModifiedClick("DRESSUP") then
		return DressUpItemLink(itemLink)
	else
		if ChatEdit_GetActiveWindow() then
			ChatEdit_InsertLink(itemLink)
		else
			ChatFrame_OpenChat(itemLink)
		end
	end
end

function ExRT.mds.shortNumber(num)
	if num < 1000 then
		return tostring(num)
	elseif num < 1000000 then
		return format("%.1fk",num/1000)
	elseif num < 1000000000 then
		return format("%.2fm",num/1000000)
	else
		return format("%.3fM",num/1000000000)
	end
end

function ExRT.mds.classIconInText(class,size)
	if CLASS_ICON_TCOORDS[class] then
		size = size or 0
		return "|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:"..size..":"..size..":0:0:256:256:".. floor(CLASS_ICON_TCOORDS[class][1]*256) ..":"..floor(CLASS_ICON_TCOORDS[class][2]*256) ..":"..floor(CLASS_ICON_TCOORDS[class][3]*256) ..":"..floor(CLASS_ICON_TCOORDS[class][4]*256) .."|t"
	end
end

function ExRT.mds.GUIDtoID(guid)
	if not guid then 
		return 0 
	else
		local id = guid:match("[^%-]+%-%d+%-%d+%-%d+%-%d+%-(%d+)%-%w+")
		return tonumber(id or 0)
	end
end

function ExRT.mds.reverseInt(int,mx,doReverse)
	if doReverse then
		int = mx - int
	end
	return int
end

function ExRT.mds.table_copy(table1,table2)
	table.wipe(table2)
	for key,val in pairs(table1) do
		table2[key] = val
	end
end

function ExRT.mds.table_wipe(arr)
	if not arr or type(arr) ~= "table" then
		return
	end
	for key,val in pairs(arr) do
		if type(val) == "table" then
			ExRT.mds.table_wipe(val)
		end
		arr[key] = nil
	end
end

function ExRT.mds.table_find(arr,subj,pos)
	if pos then
		for j=1,#arr do
			if arr[j][pos] == subj then
				return j
			end
		end
	else
		for j=1,#arr do
			if arr[j] == subj then
				return j
			end
		end
	end
end

function ExRT.mds.table_len(arr)
	local len = 0
	for _ in pairs(arr) do
		len = len + 1
	end
	return len
end

function ExRT.mds.table_add(arr,add)
	for i=1,#add do
		arr[#arr+1] = add[i]
	end
end

function ExRT.mds.table_add2(arr,add)
	for key,val in pairs(add) do
		arr[key] = val
	end
end

function ExRT.mds.tohex(num,size)
	return format("%0"..(size or "1").."X",num)
end

function ExRT.mds.UnitInGuild(unit)
	unit = ExRT.mds.delUnitNameServer(unit)
	local gplayers = GetNumGuildMembers() or 0
	for i=1,gplayers do
		local name = GetGuildRosterInfo(i)
		if name and ExRT.mds.delUnitNameServer(name) == unit then
			return true
		end
	end
	return false
end

function ExRT.mds.chatType(toSay)
	local isInInstance = IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
	local isInParty = IsInGroup()
	local isInRaid = IsInRaid()
	local playerName = nil
	local chat_type = (isInInstance and "INSTANCE_CHAT") or (isInRaid and "RAID") or (isInParty and "PARTY")
	if not chat_type and not toSay then
		chat_type = "WHISPER"
		playerName = UnitName("player") 
	elseif not chat_type then
		chat_type = "SAY"
	end
	return chat_type, playerName
end

function ExRT.mds.IsBonusOnItem(link,bonus)
	if link then 
		local bonuses = link:match("item:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:([0-9:]+)")
		if bonuses then
			local isTable = type(bonus) == "table"
			for bonusID in string.gmatch(bonuses, "%d+") do
				bonusID = tonumber(bonusID or 0)
				if (isTable and bonus[bonusID]) or (not isTable and bonusID == bonus) then
					return true
				end
			end
		end
	end
end

function ExRT.mds.IsPlayerRLorOfficer(unitName)
	unitName = ExRT.mds.delUnitNameServer(unitName)
	if not IsInRaid() then
		return false
	end
	for i=1,GetNumGroupMembers() do
		local name,rank = GetRaidRosterInfo(i)
		if name and ExRT.mds.delUnitNameServer(name) == unitName then
			if rank > 0 then
				return true
			else
				return false
			end
		end
	end
end

do
	local chatWindow = nil
	local activeChat = "RAID"
	local activeName = ""
	local UpdateLines = nil
	local function CreateChatWindow()
		chatWindow = CreateFrame("Frame","ExRTToChatWindow",UIParent,"ExRTDialogTemplate")
		chatWindow:SetSize(400,300)
		chatWindow:SetPoint("CENTER")
		chatWindow:SetFrameStrata("DIALOG")
		chatWindow:SetClampedToScreen(true)
		chatWindow:EnableMouse(true)
		chatWindow:SetMovable(true)
		chatWindow:RegisterForDrag("LeftButton")
		chatWindow:SetDontSavePosition(true)
		chatWindow:SetScript("OnDragStart", function(self) 
			self:StartMoving() 
		end)
		chatWindow:SetScript("OnDragStop", function(self) 
			self:StopMovingOrSizing() 
		end)
		
		chatWindow.title:SetTextColor(1,1,1,1)
		chatWindow.title:SetText(ExRT.L.ChatwindowName)
		
		chatWindow.box = ExRT.lib.CreateMultiEditBox(chatWindow,230,250,"TOPLEFT",15,-35)
		chatWindow.box.EditBox:SetFont( chatWindow.box.EditBox:GetFont(),11 )
		
		local chats = {
			{"ME",ExRT.L.ChatwindowChatSelf},
			{"SAY",ExRT.L.ChatwindowChatSay},
			{"PARTY",ExRT.L.ChatwindowChatParty},
			{"INSTANCE_CHAT",ExRT.L.ChatwindowChatInstance},
			{"RAID",ExRT.L.ChatwindowChatRaid},
			{"WHISPER",ExRT.L.ChatwindowChatWhisper},
			{"TARGET",ExRT.L.ChatwindowChatWhisperTarget},
			{"GUILD",ExRT.L.ChatwindowChatGuild},
			{"OFFICER",ExRT.L.ChatwindowChatOfficer},
		}

		chatWindow.dropDownText = ExRT.lib.CreateText(chatWindow,350,14,nil,0,0,"LEFT","BOTTOM",nil,10,ExRT.L.ChatwindowChannel,nil,1,1,1,1)
		chatWindow.dropDown = ExRT.lib.CreateDropDown(chatWindow,"TOPLEFT",187+50,-60,120,ExRT.L.ChatwindowChatRaid)
		ExRT.lib.SetPoint(chatWindow.dropDownText,"BOTTOMLEFT",chatWindow.dropDown,"TOPLEFT",20,2)
		UIDropDownMenu_Initialize(chatWindow.dropDown, function (self)
			ExRT.mds.FixDropDown(130)
			local info = UIDropDownMenu_CreateInfo()
			for i,chatData in ipairs(chats) do
				info.text,info.notCheckable,info.minWidth,info.justifyH = chatData[2],1,130,"CENTER"
				info.menuList, info.hasArrow, info.arg1, info.arg2 = i, false, chatData[1], chatData[2]
				info.func = function (this,arg1,arg2)
					self:SetText(arg2)
					CloseDropDownMenus()
					activeChat = arg1
				end
				UIDropDownMenu_AddButton(info)
			end
		end)
		
		chatWindow.targetText = ExRT.lib.CreateText(chatWindow,350,14,nil,0,0,"LEFT","BOTTOM",nil,10,ExRT.L.ChatwindowNameEB,nil,1,1,1,1)
		chatWindow.target = ExRT.lib.CreateEditBox(chatWindow,130,24,nil,210+50,-115)
		ExRT.lib.SetPoint(chatWindow.targetText,"BOTTOMLEFT",chatWindow.target,"TOPLEFT",5,2)
		chatWindow.target:SetScript("OnTextChanged",function (self)
			activeName = self:GetText()
		end)
		
		chatWindow.button = ExRT.lib.CreateButton(chatWindow,130,22,"TOPLEFT",207+50,-150,ExRT.L.ChatwindowSend)
		chatWindow.button:SetScript("OnClick",function (self)
			local lines = {strsplit("\n", chatWindow.box.EditBox:GetText())}
			local channel = activeChat
			local whisper = activeName
			if channel == "TARGET" then
				channel = "WHISPER"
				whisper = ExRT.mds.UnitCombatlogname("target")
				if not whisper then
					return
				end
			end
			if channel == "ME" then
				for i=1,#lines do
					if lines[i] ~= "" then
						print(lines[i])
					end
				end
				chatWindow:Hide()
				return
			end
			if whisper == "" then
				whisper = nil
			end
			for i=1,#lines do
				if lines[i] ~= "" then
					SendChatMessage(lines[i],channel,nil,whisper)
				end
			end
			chatWindow:Hide()
		end)
		
		chatWindow.helpText = ExRT.lib.CreateText(chatWindow,130,100,nil,0,0,"LEFT","TOP",nil,10,ExRT.L.ChatwindowHelp,nil,1,1,1,1)
		ExRT.lib.SetPoint(chatWindow.helpText,"TOP",chatWindow.button,"BOTTOM",0,-10)
		
		chatWindow.chk1 = ExRT.lib.CreateCheckBox(chatWindow,nil,254,-250,"Option 1")
		chatWindow.chk1:SetScript("OnClick",function()
			UpdateLines()
		end)
	end
	function UpdateLines()
		local lines = chatWindow.lines
		if not lines or type(lines)~="table" then
			return
		end
		local editData = ""
		local linesCount = #lines
		local clearTags = chatWindow.clearTags
		local option1 = chatWindow.option1enabled and chatWindow.chk1:GetChecked() and "%1" or ""
		for i=1,linesCount do
			local thisLine = lines[i]
			if thisLine ~= "" then
				thisLine = thisLine:gsub("@1@(.-)@1#",option1)
				if clearTags then
					thisLine = ExRT.mds.clearTextTag(thisLine)
				end
				if strlen(thisLine) > 254 then
					thisLine = strjoin("\n",ExRT.mds.splitLongLine(thisLine,254))
				end
				editData = editData .. thisLine
				if i ~= linesCount then
					editData = editData .. "\n"
				end
			end
		end
		chatWindow.box.EditBox:SetText(editData)
	end
	function ExRT.mds.toChatWindow(lines,clearTags,option1Name)
		if not lines or type(lines)~="table" then
			return
		end
		if not chatWindow then
			CreateChatWindow()
		end
		chatWindow.lines = lines
		chatWindow.clearTags = clearTags
		chatWindow.option1enabled = option1Name
		if option1Name then
			chatWindow.chk1.text:SetText(option1Name)
			chatWindow.chk1:SetChecked(false)
			chatWindow.chk1:Show()
		else
			chatWindow.chk1:Hide()
		end
		UpdateLines()
		chatWindow:Show()
	end
end

do
	local function TimerFunc(self)
		self.func(unpack(self.args))
	end
	function ExRT.mds.ScheduleTimer(func, delay, ...)
		local self = nil
		if delay > 0 then
			self = C_Timer_NewTimer(delay,TimerFunc)
		else
			self = C_Timer_NewTicker(-delay,TimerFunc)
		end
		self.args = {...}
		self.func = func
		
		return self
	end
	function ExRT.mds.CancelTimer(self)
		if self then
			self:Cancel()
		end
	end
	function ExRT.mds.ScheduleETimer(self, func, delay, ...)
		ExRT.mds.CancelTimer(self)
		return ExRT.mds.ScheduleTimer(func, delay, ...)
	end
	
	ExRT.mds.NewTimer = ExRT.mds.ScheduleTimer
end

ExRT.BannedModules = {["Frames1"]=1,}

---------------> Data <---------------

ExRT.mds.defFont = "Interface\\AddOns\\ExRT\\media\\skurri.ttf"
ExRT.mds.barImg = "Interface\\AddOns\\ExRT\\media\\bar17.tga"
ExRT.mds.defBorder = "Interface\\AddOns\\ExRT\\media\\border.tga"
ExRT.mds.textureList = {
	"Interface\\AddOns\\ExRT\\media\\bar1.tga",
	"Interface\\AddOns\\ExRT\\media\\bar2.tga",
	"Interface\\AddOns\\ExRT\\media\\bar3.tga",
	"Interface\\AddOns\\ExRT\\media\\bar4.tga",
	"Interface\\AddOns\\ExRT\\media\\bar5.tga",
	"Interface\\AddOns\\ExRT\\media\\bar6.tga",
	"Interface\\AddOns\\ExRT\\media\\bar7.tga",
	"Interface\\AddOns\\ExRT\\media\\bar8.tga",
	"Interface\\AddOns\\ExRT\\media\\bar9.tga",
	"Interface\\AddOns\\ExRT\\media\\bar10.tga",
	"Interface\\AddOns\\ExRT\\media\\bar11.tga",
	"Interface\\AddOns\\ExRT\\media\\bar12.tga",
	"Interface\\AddOns\\ExRT\\media\\bar13.tga",
	"Interface\\AddOns\\ExRT\\media\\bar14.tga",
	"Interface\\AddOns\\ExRT\\media\\bar15.tga",
	"Interface\\AddOns\\ExRT\\media\\bar16.tga",
	"Interface\\AddOns\\ExRT\\media\\bar17.tga",
	"Interface\\AddOns\\ExRT\\media\\bar18.tga",
	"Interface\\AddOns\\ExRT\\media\\bar19.tga",
	"Interface\\AddOns\\ExRT\\media\\bar20.tga",
	"Interface\\AddOns\\ExRT\\media\\bar21.tga",
	"Interface\\AddOns\\ExRT\\media\\bar22.tga",
	"Interface\\AddOns\\ExRT\\media\\bar23.tga",
	"Interface\\AddOns\\ExRT\\media\\bar24.tga",
	"Interface\\AddOns\\ExRT\\media\\bar24b.tga",
	"Interface\\AddOns\\ExRT\\media\\bar25.tga",
	"Interface\\AddOns\\ExRT\\media\\bar26.tga",
	"Interface\\AddOns\\ExRT\\media\\bar27.tga",
	"Interface\\AddOns\\ExRT\\media\\bar28.tga",
	"Interface\\AddOns\\ExRT\\media\\bar29.tga",
	"Interface\\AddOns\\ExRT\\media\\bar30.tga",
	"Interface\\AddOns\\ExRT\\media\\bar31.tga",
	"Interface\\AddOns\\ExRT\\media\\bar32.tga",
	"Interface\\AddOns\\ExRT\\media\\bar33.tga",
	"Interface\\AddOns\\ExRT\\media\\bar34.tga",
	"Interface\\AddOns\\ExRT\\media\\White.tga",
	[[Interface\TargetingFrame\UI-StatusBar]],
	[[Interface\PaperDollInfoFrame\UI-Character-Skills-Bar]],
	[[Interface\RaidFrame\Raid-Bar-Hp-Fill]],
}
ExRT.mds.fontList = {
	"Interface\\AddOns\\ExRT\\media\\skurri.ttf",
	"Fonts\\ARIALN.TTF",
	"Fonts\\FRIZQT__.TTF",
	"Fonts\\MORPHEUS.TTF",
	"Fonts\\NIM_____.ttf",
	"Fonts\\SKURRI.TTF",
	"Fonts\\FRIZQT___CYR.TTF",
	"Fonts\\ARHei.ttf",
	"Fonts\\ARKai_T.ttf",
	"Fonts\\2002.ttf",
	"Interface\\AddOns\\ExRT\\media\\TaurusNormal.ttf",
	"Interface\\AddOns\\ExRT\\media\\UbuntuMedium.ttf",
	"Interface\\AddOns\\ExRT\\media\\TelluralAlt.ttf",
	"Interface\\AddOns\\ExRT\\media\\Glametrix.otf",
	"Interface\\AddOns\\ExRT\\media\\FiraSansMedium.ttf",
	"Interface\\AddOns\\ExRT\\media\\alphapixels.ttf",
	"Interface\\AddOns\\ExRT\\media\\ariblk.ttf",
}

if ExRT.locale and ExRT.locale:find("^zh") then		--China & Taiwan fix
	ExRT.mds.defFont = "Fonts\\ARHei.ttf"
elseif ExRT.locale == "koKR" then			--Korea fix
	ExRT.mds.defFont = "Fonts\\2002.ttf"
end

---------------> Slash <---------------

SlashCmdList["exrtSlash"] = function (arg)
	local argL = strlower(arg)
	if argL == "icon" then
		VExRT.Addon.IconMiniMapHide = not VExRT.Addon.IconMiniMapHide
		if not VExRT.Addon.IconMiniMapHide then 
			ExRT.MiniMapIcon:Show()
		else
			ExRT.MiniMapIcon:Hide()
		end
	elseif argL == "getver" then
		ExRT.mds.SendExMsg("needversion","")
	elseif argL == "getverg" then
		ExRT.mds.SendExMsg("needversiong","","GUILD")
	elseif argL == "set" then
		ExRT.Options:Open()
	elseif argL == "quit" then
		for mod,data in pairs(ExRT.A) do
			data.main:UnregisterAllEvents()
		end
		ExRT.CLEUframe:UnregisterAllEvents()
		ExRT.frame:UnregisterAllEvents()
		ExRT.frame:SetScript("OnUpdate",nil)
		print("ExRT Disabled")
	elseif string.len(argL) == 0 then
		ExRT.Options:Open()
		return
	end
	for _,mod in pairs(ExRT.Slash) do
		mod:slash(argL,arg)
	end
end
SLASH_exrtSlash1 = "/exrt"
SLASH_exrtSlash2 = "/rt"
SLASH_exrtSlash3 = "/raidtools"
SLASH_exrtSlash4 = "/exorsusraidtools"
SLASH_exrtSlash5 = "/ert"

---------------> Chat links hook <---------------

do
	local chatLinkFormat = "|HExRT:%s:0|h|cffffff00[ExRT: %s]|r|h"
	local funcTable = {}
	local function createChatHook()
		local SetHyperlink = ItemRefTooltip.SetHyperlink
		function ItemRefTooltip:SetHyperlink(link, ...)
			local funcName = link:match("^ExRT:([^:]+):")
			if funcName then
				local func = funcTable[funcName]
				if not func then
					return
				end
				func()
			else
				SetHyperlink(self, link, ...)
			end
		end
	end

	function ExRT.mds.CreateChatLink(funcName,func,stringName)
		if createChatHook then createChatHook() createChatHook = nil end
		if not funcName or not stringName or type(func) ~= "function" then
			return ""
		end
		funcTable[funcName] = func
		return chatLinkFormat:format(funcName,stringName)
	end
end

---------------> Global addon frame <---------------

local reloadTimer = 0.1

ExRT.frame = CreateFrame("Frame")

ExRT.frame:SetScript("OnEvent",function (self, event, ...)
	if event == "CHAT_MSG_ADDON" then
		local prefix, message, channel, sender = ...
		if prefix and ExRT.msg_prefix[prefix] and (channel=="RAID" or channel=="GUILD" or channel=="INSTANCE_CHAT" or channel=="PARTY" or (channel=="WHISPER" and (ExRT.mds.UnitInGuild(sender) or sender == UnitName("player"))) or (message and (message:find("^version") or message:find("^needversion")))) then
			ExRT.mds.GetExMsg(sender, strsplit("\t", message))
		end
	elseif event == "ADDON_LOADED" then
		local addonName = ...
		if addonName ~= GlobalAddonName then
			return
		end
		VExRT = VExRT or {}
		VExRT.Addon = VExRT.Addon or {}
		VExRT.Addon.Timer = VExRT.Addon.Timer or 0.1
		reloadTimer = VExRT.Addon.Timer

		if VExRT.Addon.IconMiniMapLeft and VExRT.Addon.IconMiniMapTop then
			ExRT.MiniMapIcon:ClearAllPoints()
			ExRT.MiniMapIcon:SetPoint("CENTER", VExRT.Addon.IconMiniMapLeft, VExRT.Addon.IconMiniMapTop)
		end
		
		if VExRT.Addon.IconMiniMapHide then 
			ExRT.MiniMapIcon:Hide() 
		end

		for prefix,_ in pairs(ExRT.msg_prefix) do
			RegisterAddonMessagePrefix(prefix)
		end
		
		VExRT.Addon.Version = tonumber(VExRT.Addon.Version or "0")
		VExRT.Addon.PreVersion = VExRT.Addon.Version
		
		ExRT.mds.dprint("ADDON_LOADED event")
		ExRT.mds.dprint("MODULES FIND",#ExRT.Modules)
		for i=1,#ExRT.Modules do
			pcall(ExRT.Modules[i].main.ADDON_LOADED,self) 	-- BE CARE ABOUT IT
			ExRT.ModulesLoaded[i] = true
			
			ExRT.mds.dprint("ADDON_LOADED",i,ExRT.Modules[i].name)
		end

		VExRT.Addon.Version = ExRT.V
		
		ExRT.mds.ScheduleTimer(function()
			ExRT.frame:SetScript("OnUpdate", ExRT.frame.OnUpdate)
			ExRT.CLEUframe:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end,1)
		self:UnregisterEvent("ADDON_LOADED")

		return true	
	end
end)

ExRT.CLEUframe = CreateFrame("Frame")
do
	local CLEU = ExRT.CLEU
	ExRT.CLEUframe:SetScript("OnEvent",function (self, event, ...)
		for _,func in pairs(CLEU) do
			func(self,...)
		end
	end)
	
	if ExRT.T == "D" then
		ExRT.CLEUframe.eventsCounter = 0
		ExRT.CLEUframe:HookScript("OnEvent",function(self) self.eventsCounter = self.eventsCounter + 1 end)

		function ExRTFakeCLEU(...)
			for _,func in pairs(CLEU) do
				func(ExRT.CLEUframe,time()+GetTime()%1,...)
			end
		end
	end
end

do
	local encounterTime,isEncounter = 0,nil
	local ExRT_OnUpdate = ExRT.OnUpdate
	local frameElapsed = 0
	function ExRT.frame:OnUpdate(elapsed)
		frameElapsed = frameElapsed + elapsed
		if frameElapsed > reloadTimer then
			if not isEncounter and IsEncounterInProgress() then
				isEncounter = true
				encounterTime = GetTime()
			elseif isEncounter and not IsEncounterInProgress() then
				isEncounter = nil
			end
			
			for _,mod in pairs(ExRT_OnUpdate) do
				--pcall(mod.timer,self,self.tmr)	-- BE CARE ABOUT IT
				mod:timer(frameElapsed)
			end
			frameElapsed = 0
		end
	end
	
	function ExRT.mds.RaidInCombat()
		return isEncounter
	end
	
	function ExRT.mds.GetEncounterTime()
		if isEncounter then
			return GetTime() - encounterTime
		end
	end
end

function ExRT.mds.SendExMsg(prefix, msg, tochat, touser, addonPrefix)
	addonPrefix = addonPrefix or "EXRTADD"
	msg = msg or ""
	if tochat and not touser then
		SendAddonMessage(addonPrefix, prefix .. "\t" .. msg, tochat)
	elseif tochat and touser then
		SendAddonMessage(addonPrefix, prefix .. "\t" .. msg, tochat,touser)
	else
		local chat_type, playerName = ExRT.mds.chatType()
		SendAddonMessage(addonPrefix, prefix .. "\t" .. msg, chat_type, playerName)
	end
end

function ExRT.mds.GetExMsg(sender, prefix, ...)
	if prefix == "needversion" or prefix == "needversiong" then
		ExRT.mds.SendExMsg("version", ExRT.V,"WHISPER",sender)
	elseif prefix == "version" then
		local msgver = ...
		print(sender..": "..msgver)
	end
	for _,mod in pairs(ExRT.OnAddonMessage) do
		mod:addonMessage(sender, prefix, ...)
	end
end

_G["GExRT"] = ExRT
ExRT.frame:RegisterEvent("CHAT_MSG_ADDON")
ExRT.frame:RegisterEvent("ADDON_LOADED") 