local GlobalAddonName, ExRT = ...

ExRT.mds.FUNC_FILE_LOADED = true

local UnitName, GetTime = UnitName, GetTime
local select, floor, tonumber, tostring, string_sub, string_find, string_len, bit_band, type, unpack, pairs, format, strsplit = select, floor, tonumber, tostring, string.sub, string.find, string.len, bit.band, type, unpack, pairs, format, strsplit
local RAID_CLASS_COLORS, COMBATLOG_OBJECT_TYPE_MASK, COMBATLOG_OBJECT_CONTROL_MASK, COMBATLOG_OBJECT_REACTION_MASK, COMBATLOG_OBJECT_AFFILIATION_MASK, COMBATLOG_OBJECT_SPECIAL_MASK = RAID_CLASS_COLORS, COMBATLOG_OBJECT_TYPE_MASK, COMBATLOG_OBJECT_CONTROL_MASK, COMBATLOG_OBJECT_REACTION_MASK, COMBATLOG_OBJECT_AFFILIATION_MASK, COMBATLOG_OBJECT_SPECIAL_MASK

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
	--Used GLOBALS: CUSTOM_CLASS_COLORS

	local classColorArray = nil
	function ExRT.mds.classColor(class)
		classColorArray = type(CUSTOM_CLASS_COLORS)=="table" and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
		if classColorArray and classColorArray.colorStr then
			return classColorArray.colorStr
		else
			return "ffbbbbbb"
		end
	end

	function ExRT.mds.classColorNum(class)
		classColorArray = type(CUSTOM_CLASS_COLORS)=="table" and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
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
		local bonuses = link:match("item:%d+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:[0-9%-]+:([0-9:]+)")
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
	-- UTF8
	
	-- returns the number of bytes used by the UTF-8 character at byte i in s
	-- also doubles as a UTF-8 character validator
	local function utf8charbytes(s, i)
		-- argument defaults
		i = i or 1
	
		-- argument checking
		if type(s) ~= "string" then
			error("bad argument #1 to 'utf8charbytes' (string expected, got ".. type(s).. ")")
		end
		if type(i) ~= "number" then
			error("bad argument #2 to 'utf8charbytes' (number expected, got ".. type(i).. ")")
		end
	
		local c = strbyte(s, i)
	
		-- determine bytes needed for character, based on RFC 3629
		-- validate byte 1
		if c > 0 and c <= 127 then
			-- UTF8-1
			return 1
	
		elseif c >= 194 and c <= 223 then
			-- UTF8-2
			local c2 = strbyte(s, i + 1)
	
			if not c2 then
				error("UTF-8 string terminated early")
			end
	
			-- validate byte 2
			if c2 < 128 or c2 > 191 then
				error("Invalid UTF-8 character")
			end
	
			return 2
	
		elseif c >= 224 and c <= 239 then
			-- UTF8-3
			local c2 = strbyte(s, i + 1)
			local c3 = strbyte(s, i + 2)
	
			if not c2 or not c3 then
				error("UTF-8 string terminated early")
			end
	
			-- validate byte 2
			if c == 224 and (c2 < 160 or c2 > 191) then
				error("Invalid UTF-8 character")
			elseif c == 237 and (c2 < 128 or c2 > 159) then
				error("Invalid UTF-8 character")
			elseif c2 < 128 or c2 > 191 then
				error("Invalid UTF-8 character")
			end
	
			-- validate byte 3
			if c3 < 128 or c3 > 191 then
				error("Invalid UTF-8 character")
			end
	
			return 3
	
		elseif c >= 240 and c <= 244 then
			-- UTF8-4
			local c2 = strbyte(s, i + 1)
			local c3 = strbyte(s, i + 2)
			local c4 = strbyte(s, i + 3)
	
			if not c2 or not c3 or not c4 then
				error("UTF-8 string terminated early")
			end
	
			-- validate byte 2
			if c == 240 and (c2 < 144 or c2 > 191) then
				error("Invalid UTF-8 character")
			elseif c == 244 and (c2 < 128 or c2 > 143) then
				error("Invalid UTF-8 character")
			elseif c2 < 128 or c2 > 191 then
				error("Invalid UTF-8 character")
			end
	
			-- validate byte 3
			if c3 < 128 or c3 > 191 then
				error("Invalid UTF-8 character")
			end
	
			-- validate byte 4
			if c4 < 128 or c4 > 191 then
				error("Invalid UTF-8 character")
			end
	
			return 4
	
		else
			error("Invalid UTF-8 character")
		end
	end
	
	function ExRT.mds:utf8len(s)
		local pos = 1
		local bytes = strlen(s)
		local len = 0
	
		while pos <= bytes do
			len = len + 1
			pos = pos + utf8charbytes(s, pos)
		end
	
		return len
	end
	
	-- functions identically to string.sub except that i and j are UTF-8 characters
	-- instead of bytes
	function ExRT.mds:utf8sub(s, i, j)
		-- argument defaults
		j = j or -1
	
		local pos = 1
		local bytes = strlen(s)
		local len = 0
	
		-- only set l if i or j is negative
		local l = (i >= 0 and j >= 0) or ExRT.mds:utf8len(s)
		local startChar = (i >= 0) and i or l + i + 1
		local endChar   = (j >= 0) and j or l + j + 1
	
		-- can't have start before end!
		if startChar > endChar then
			return ""
		end
	
		-- byte offsets to pass to string.sub
		local startByte, endByte = 1, bytes
	
		while pos <= bytes do
			len = len + 1
	
			if len == startChar then
				startByte = pos
			end
	
			pos = pos + utf8charbytes(s, pos)
	
			if len == endChar then
				endByte = pos - 1
				break
			end
		end
	
		return strsub(s, startByte, endByte)
	end
end

do
	local chatWindow = nil
	local activeChat = "RAID"
	local activeName = ""
	local UpdateLines = nil
	local function CreateChatWindow()
		chatWindow = CreateFrame("Frame","ExRTToChatWindow",UIParent,"ExRTDialogModernTemplate")
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
		
		chatWindow.border = ExRT.lib.CreateShadow(chatWindow,20)
		
		chatWindow.title:SetText(ExRT.L.ChatwindowName)
		
		chatWindow.box = ExRT.lib.CreateMultilineEditBox(chatWindow,230,265,"TOPLEFT",10,-23,true)
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
		chatWindow.dropDown = ExRT.lib.CreateScrollDropDown(chatWindow,"TOPLEFT",255,-60,130,130,#chats,ExRT.L.ChatwindowChatRaid,nil,"ExRTDropDownMenuModernTemplate")
		ExRT.lib.SetPoint(chatWindow.dropDownText,"BOTTOMLEFT",chatWindow.dropDown,"TOPLEFT",5,2)
		for i=1,#chats do
			local chatData = chats[i]
			chatWindow.dropDown.List[i] = {
				text = chatData[2],
				notCheckable = true,
				justifyH = "CENTER",
				arg1 = chatData[1],
				arg2 = chatData[2],
				func = function (this,arg1,arg2)
					chatWindow.dropDown:SetText(arg2)
					ExRT.lib.ScrollDropDown.DropDownList:Hide()
					activeChat = arg1
				end
			}
		end
		
		chatWindow.targetText = ExRT.lib.CreateText(chatWindow,350,14,nil,0,0,"LEFT","BOTTOM",nil,10,ExRT.L.ChatwindowNameEB,nil,1,1,1,1)
		chatWindow.target = ExRT.lib.CreateEditBox(chatWindow,130,20,nil,255,-115,nil,nil,nil,"ExRTInputBoxModernTemplate")
		ExRT.lib.SetPoint(chatWindow.targetText,"BOTTOMLEFT",chatWindow.target,"TOPLEFT",5,2)
		chatWindow.target:SetScript("OnTextChanged",function (self)
			activeName = self:GetText()
		end)
		
		chatWindow.button = ExRT.lib.CreateButton(chatWindow,130,22,"TOPLEFT",255,-150,ExRT.L.ChatwindowSend,nil,nil,"ExRTButtonModernTemplate")
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
		
		chatWindow.chk1 = ExRT.lib.CreateCheckBox(chatWindow,nil,255,-260,"Option 1",nil,nil,nil,"ExRTCheckButtonModernTemplate")
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
	local alertWindow = nil
	local alertFunc = nil
	local alertArg1 = nil
	local function CreateWindow()
		alertWindow = ExRT.lib.CreatePopupFrame(500,65,"",true)
		
		alertWindow.EditBox = ExRT.lib.CreateEditBox(alertWindow,480,16,"TOP",0,-20,nil,nil,nil,"ExRTInputBoxModernTemplate")
		
		alertWindow.OK = ExRT.lib.CreateButton(alertWindow,130,20,"TOP",0,-40,ACCEPT,nil,nil,"ExRTButtonModernTemplate")
		alertWindow.OK:SetScript("OnClick",function (self)
			alertWindow:Hide()
			local input = alertWindow.EditBox:GetText()
			alertFunc(alertArg1,input)
		end)
	end
	function ExRT.mds.ShowInput(text,func,arg1,onlyNum)
		if not alertWindow then
			CreateWindow()
		end
		alertWindow.title:SetText(text)
		alertWindow.EditBox:SetText("")
		alertWindow:ClearAllPoints()
		alertWindow:SetPoint("CENTER",UIParent,0,0)
		alertFunc = func
		alertArg1 = arg1
		if onlyNum then
			alertWindow.EditBox:SetNumeric(true)
		else
			alertWindow.EditBox:SetNumeric(false)
		end
		alertWindow:Show()
		alertWindow.EditBox:SetFocus()
	end
end

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

-------------------------

