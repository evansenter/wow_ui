local GlobalAddonName, ExRT = ...

local VExRT = nil

local module = ExRT.mod:New("Note",ExRT.L.message,nil,true)
module.db.iconsList = {
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t",
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t",
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t",
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t",
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t",
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t",
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t",
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t",
}
module.db.otherIconsList = {
	{"{"..ExRT.L.classLocalizate["WARRIOR"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:0:64:0:64|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0,0.25,0,0.25},
	{"{"..ExRT.L.classLocalizate["PALADIN"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:0:64:128:192|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0,0.25,0.5,0.75},
	{"{"..ExRT.L.classLocalizate["HUNTER"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:0:64:64:128|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0,0.25,0.25,0.5},
	{"{"..ExRT.L.classLocalizate["ROGUE"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:127:190:0:64|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.49609375,0.7421875,0,0.25},
	{"{"..ExRT.L.classLocalizate["PRIEST"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:127:190:64:128|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.49609375,0.7421875,0.25,0.5},
	{"{"..ExRT.L.classLocalizate["DEATHKNIGHT"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:64:128:128:192|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.25,0.5,0.5,0.75},
	{"{"..ExRT.L.classLocalizate["SHAMAN"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:64:127:64:128|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.25,0.49609375,0.25,0.5},
	{"{"..ExRT.L.classLocalizate["MAGE"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:64:127:0:64|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.25,0.49609375,0,0.25},
	{"{"..ExRT.L.classLocalizate["WARLOCK"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:190:253:64:128|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.7421875,0.98828125,0.25,0.5},
	{"{"..ExRT.L.classLocalizate["MONK"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:128:189:128:192|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.5,0.73828125,0.5,0.75},
	{"{"..ExRT.L.classLocalizate["DRUID"] .."}","|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:16:16:0:0:256:256:190:253:0:64|t","Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",0.7421875,0.98828125,0,0.25},
	{"{wow}","|TInterface\\FriendsFrame\\Battlenet-WoWicon:16|t","Interface\\FriendsFrame\\Battlenet-WoWicon"},
	{"{d3}","|TInterface\\FriendsFrame\\Battlenet-D3icon:16|t","Interface\\FriendsFrame\\Battlenet-D3icon"},
	{"{sc2}","|TInterface\\FriendsFrame\\Battlenet-Sc2icon:16|t","Interface\\FriendsFrame\\Battlenet-Sc2icon"},
	{"{bnet}","|TInterface\\FriendsFrame\\Battlenet-Portrait:16|t","Interface\\FriendsFrame\\Battlenet-Portrait"},
	{"{alliance}","|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t","Interface\\FriendsFrame\\PlusManz-Alliance"},
	{"{horde}","|TInterface\\FriendsFrame\\PlusManz-Horde:16|t","Interface\\FriendsFrame\\PlusManz-Horde"},
}
module.db.iconsLocalizatedNames = {
	ExRT.L.raidtargeticon1,ExRT.L.raidtargeticon2,ExRT.L.raidtargeticon3,ExRT.L.raidtargeticon4,ExRT.L.raidtargeticon5,ExRT.L.raidtargeticon6,ExRT.L.raidtargeticon7,ExRT.L.raidtargeticon8
}

module.db.msgindex = -1
module.db.lasttext = ""

local function txtWithIcons(t)
	t = t or ""
	t = string.gsub(t,"||T","|T")
	t = string.gsub(t,"||t","|t")
	for i=1,8 do
		t = string.gsub(t,module.db.iconsLocalizatedNames[i],module.db.iconsList[i])
		t = string.gsub(t,"{rt"..i.."}",module.db.iconsList[i])
	end
	t = string.gsub(t,"||c","|c")
	t = string.gsub(t,"||r","|r")
	for i=1,#module.db.otherIconsList do
		t = string.gsub(t,module.db.otherIconsList[i][1],module.db.otherIconsList[i][2])
	end
	
	local spellLastPos = t:find("{spell:[^}]+}")
	while spellLastPos do
		local template,spell = t:match("({spell:([^}]+)})")
		local _,spellTexture
		spell = tonumber(spell)
		if spell then
			_,_,spellTexture = GetSpellInfo( spell )
			spellTexture = "|T"..(spellTexture or "Interface\\Icons\\INV_MISC_QUESTIONMARK")..":16|t"
		end
		spellTexture = spellTexture or ""
		
		if template:find("%-") then
			template = template:gsub("%-","%%%-")
		end
		
		t = t:gsub(template,spellTexture)
		
		local spellNewPos = t:find("{spell:[^}]+}")
		if spellLastPos == spellNewPos then
			break
		end
		spellLastPos = spellNewPos
	end
	
	t = string.gsub(t,"{[^}]*}","")
	return t
end


function module.options:Load()
	module.db.otherIconsAdditionalList = {
		31821,62618,97462,159916,76577,51052,98008,115310,64843,740,108280,172106,106898,0,
		47788,33206,6940,102342,114030,1022,116849,0,
		155078,155080,165298,155330,173192,0,
		173471,156297,156203,155900,0,
		155196,158246,155242,155240,155225,155192,176121,156934,0,
		157139,157853,156892,161570,0,
		154932,155074,155277,155314,0,
		156766,157059,156704,158217,173917,156852,0,
		162283,154960,154975,159045,155208,0,
		164380,155864,155921,159481,0,
		170395,170405,156631,158601,158315,164271,158010,156214,0,
		156772,156047,156096,175020,162498,157000,159142,177438,177487,156479,
	}

	local BlackNoteNow = nil
	local NoteIsSelfNow = nil

	self.NotesList = ExRT.lib.CreateScrollList(self,nil,5,-125,160,21)
	self.NotesList.selected = 1
	
	local function NotesListUpdateNames()
		self.NotesList.L = {}
		
		self.NotesList.L[1] = "|cff55ee55"..ExRT.L.messageTab1
		self.NotesList.L[2] = ExRT.L.NoteSelf
		for i=1,#VExRT.Note.Black do
			self.NotesList.L[i+2] = VExRT.Note.BlackNames[i] or i
		end
		self.NotesList.L[#self.NotesList.L + 1] = ExRT.L.NoteAdd
		self.NotesList:Update()
	end
	NotesListUpdateNames()
	
	function self.NotesList:SetListValue(index)
		ExRT.lib.ShowOrHide(module.options.buttonsend,index == 1)
		ExRT.lib.ShowOrHide(module.options.buttonclear,index == 1)
		ExRT.lib.ShowOrHide(module.options.buttoncopy,index > 2)
		
		BlackNoteNow = nil
		NoteIsSelfNow = nil
		
		if index > 2 then
			module.options.DraftName:Enable()
			module.options.RemoveDraft:Enable()
		else
			module.options.DraftName:Disable()
			module.options.RemoveDraft:Disable()
		end
		
		if index == 1 then
			module.options.NoteEditBox.EditBox:SetText(VExRT.Note.Text1 or "")
			module.options.DraftName:SetText( ExRT.L.messageTab1 )
		elseif index == 2 then
			module.options.NoteEditBox.EditBox:SetText(VExRT.Note.SelfText or "")
			module.options.DraftName:SetText( ExRT.L.NoteSelf )
			
			NoteIsSelfNow = true
		elseif index == #self.L then
			VExRT.Note.Black[#VExRT.Note.Black + 1] = ""
			tinsert(self.L,#self.L - 1,#VExRT.Note.Black)
			module.options.NoteEditBox.EditBox:SetText("")
			self:Update()
			
			BlackNoteNow = #VExRT.Note.Black
			module.options.DraftName:SetText( BlackNoteNow )
			
			NotesListUpdateNames()
		else
			index = index - 2
			if IsShiftKeyDown() then
				VExRT.Note.Black[index] = VExRT.Note.Text1
			end
			module.options.NoteEditBox.EditBox:SetText(VExRT.Note.Black[index] or "")
			
			BlackNoteNow = index
			module.options.DraftName:SetText( VExRT.Note.BlackNames[index] or index )
		end
	end
	
	function self.NotesList:HoverListValue(isHover,index)
		if not isHover then
			GameTooltip_Hide()
		else
			GameTooltip:SetOwner(self,"ANCHOR_CURSOR")
			GameTooltip:AddLine(self.L[index])
			if index == 2 then
				GameTooltip:AddLine(ExRT.L.NoteSelfTooltip)
			elseif index ~= #self.L and index > 2 then
				GameTooltip:AddLine(ExRT.L.NoteTabCopyTooltip)
			end
			GameTooltip:Show()
		end
	end
	
	self.RightTab = ExRT.lib.CreateOneTab(self,453,10,nil,0,0)
	self.RightTab:SetNewPoint("TOPLEFT",self.NotesList,"TOPRIGHT",0,0)
	self.RightTab:SetPoint("BOTTOMLEFT",self.NotesList,"BOTTOMRIGHT",0,0)
	
	self.DraftName = ExRT.lib.CreateEditBox(self,0,22,nil,0,0,ExRT.L.NoteDraftName,nil,nil,nil,ExRT.L.messageTab1)
	self.DraftName:SetNewPoint("TOPLEFT",self.RightTab,10,-5)
	self.DraftName:SetPoint("TOPRIGHT",self.RightTab,-160,-5)
	self.DraftName:Disable()
	self.DraftName:SetScript("OnTextChanged",function(self,isUser)
		if not isUser then return end
		if BlackNoteNow then
			VExRT.Note.BlackNames[ BlackNoteNow ] = self:GetText()
			NotesListUpdateNames()
		end
	end)
	
	self.RemoveDraft = ExRT.lib.CreateButton(self.RightTab,150,20,"TOPRIGHT",-5,-5,ExRT.L.NoteRemove,true)
	self.RemoveDraft:SetScript("OnClick",function (self)
		if not BlackNoteNow then
			return
		end
		local size = #VExRT.Note.Black
		for i=BlackNoteNow,size do
			if i < size then
				VExRT.Note.Black[i] = VExRT.Note.Black[i + 1]
				VExRT.Note.BlackNames[i] = VExRT.Note.BlackNames[i + 1]
			else
				VExRT.Note.Black[i] = nil
				VExRT.Note.BlackNames[i] = nil
			end
		end
		NotesListUpdateNames()
		if BlackNoteNow == (#module.options.NotesList.L - 2) then
			BlackNoteNow = BlackNoteNow - 1
		end
		module.options.NotesList:SetListValue(2+BlackNoteNow)
	end)
	
	self.NoteEditBox = ExRT.lib.CreateMultilineEditBox(self.RightTab,self.RightTab:GetWidth()-15,self.RightTab:GetHeight()-38,"TOP",0,-30)
	
	function self.NoteEditBox.EditBox:OnTextChanged()
		if NoteIsSelfNow then
			VExRT.Note.SelfText = self:GetText()
			module.frame:UpdateText()
		elseif BlackNoteNow then
			VExRT.Note.Black[ BlackNoteNow ] = self:GetText()
		end
	end
	
	self.buttonsend = ExRT.lib.CreateButton(self,300,22,nil,10,-5,ExRT.L.messagebutsend,nil,ExRT.L.messagebutsendtooltip)
	self.buttonsend:SetScript("OnClick",function() 
		module.frame:Save() 
		
		if IsShiftKeyDown() then
			local text = VExRT.Note.Text1 or ""
			text = text:gsub("||c........","")
			text = text:gsub("||r","")
			text = text:gsub("||T.-:0||t ","")
			
			local lines = {strsplit("\n", text)}
			for i=1,#lines do
				if lines[i] ~= "" then
					SendChatMessage(lines[i],(IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or (IsInRaid() and "RAID") or "PARTY")
				end
			end
		end
	end) 

	self.buttonclear = ExRT.lib.CreateButton(self,300,22,"TOPRIGHT",-10,-5,ExRT.L.messagebutclear)
	self.buttonclear:SetScript("OnClick",function() 
		module.frame:Clear() 
		module.options.NoteEditBox.EditBox:SetText("")
	end) 

	self.buttoncopy = ExRT.lib.CreateButton(self,600,22,"TOP",0,-5,ExRT.L.messageButCopy)
	self.buttoncopy:SetScript("OnClick",function() 
		if not BlackNoteNow then
			return
		end
		VExRT.Note.Text1 = VExRT.Note.Black[BlackNoteNow] or ""
		module.frame:Save() 
		
		module.options.NotesList:SetListValue(1)
	end) 
	self.buttoncopy:Hide()
	
	local function AddTextToEditBox(self,text,mypos)
		local addedText = nil
		if not self then
			addedText = text
		else
			addedText = self.iconText
			if IsShiftKeyDown() then
				addedText = self.iconTextShift
			end
		end
		local txt = module.options.NoteEditBox.EditBox:GetText()
		local pos = module.options.NoteEditBox.EditBox:GetCursorPosition()
		if not self and mypos then
			pos = mypos
		end
		txt = string.sub (txt, 1 , pos) .. addedText .. string.sub (txt, pos+1)
		module.options.NoteEditBox.EditBox:SetText(txt)
		module.options.NoteEditBox.EditBox:SetCursorPosition(pos+string.len(addedText))
	end

	self.buttonicons = {}
	for i=1,8 do
		self.buttonicons[i] = CreateFrame("Button", nil,self)
		self.buttonicons[i]:SetSize(18,18)
		self.buttonicons[i]:SetPoint("TOPLEFT", 16+(i-1)*20,-29)
		self.buttonicons[i].back = self.buttonicons[i]:CreateTexture(nil, "BACKGROUND")
		self.buttonicons[i].back:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..i)
		self.buttonicons[i].back:SetAllPoints()
		self.buttonicons[i]:RegisterForClicks("LeftButtonDown")
		self.buttonicons[i].iconText = module.db.iconsLocalizatedNames[i]
		self.buttonicons[i]:SetScript("OnClick", AddTextToEditBox)
	end
	for i=1,11 do
		self.buttonicons[i] = CreateFrame("Button", nil,self)
		self.buttonicons[i]:SetSize(18,18)
		self.buttonicons[i]:SetPoint("TOPLEFT", 176+(i-1)*20,-29)
		self.buttonicons[i].back = self.buttonicons[i]:CreateTexture(nil, "BACKGROUND")
		self.buttonicons[i].back:SetTexture(module.db.otherIconsList[i][3])
		if module.db.otherIconsList[i][4] then
			self.buttonicons[i].back:SetTexCoord(unpack(module.db.otherIconsList[i],4,7))
		end
		self.buttonicons[i].back:SetAllPoints()
		self.buttonicons[i]:RegisterForClicks("LeftButtonDown")
		self.buttonicons[i].iconText = module.db.otherIconsList[i][1]
		self.buttonicons[i]:SetScript("OnClick", AddTextToEditBox)
	end
	
	self.OtherIconsButton = CreateFrame("Button", nil,self)
	self.OtherIconsButton:SetSize(120,18)
	self.OtherIconsButton:SetPoint("TOPLEFT",self.buttonicons[#self.buttonicons],"TOPRIGHT",5,0)
	self.OtherIconsButton:SetScript("OnClick",function (self)
		module.options.OtherIconsFrame:ShowClick()
	end)
	self.OtherIconsButton:SetScript("OnEnter",function (self)
		self.Text:SetShadowColor(0.2, 0.2, 0.2, 1)
	end)
	self.OtherIconsButton:SetScript("OnLeave",function (self)
		self.Text:SetShadowColor(0, 0, 0, 1)
	end)
	
	self.OtherIconsButton.Text = ExRT.lib.CreateText(self.OtherIconsButton,self.OtherIconsButton:GetWidth(),18,"TOPLEFT",0,0,"LEFT","MIDDLE",nil,11,ExRT.L.NoteOtherIcons,nil,1,1,1,1)
	
	self.OtherIconsFrame = ExRT.lib.CreatePopupFrame(250,250,ExRT.L.NoteOtherIcons)
	self.OtherIconsFrame.ScrollFrame = ExRT.lib.CreateScrollFrame(self.OtherIconsFrame,self.OtherIconsFrame:GetWidth()-10,self.OtherIconsFrame:GetHeight()-40,"TOP",0,-30,500)
	self.OtherIconsFrame.ScrollFrame.backdrop:Hide()
	
	local function CreateOtherIcon(pointX,pointY,texture,iconText)
		local self = CreateFrame("Button", nil,self.OtherIconsFrame.ScrollFrame.C)
		self:SetSize(18,18)
		self:SetPoint("TOPLEFT",pointX,pointY)
		self.texture = self:CreateTexture(nil, "BACKGROUND")
		self.texture:SetTexture(texture)
		self.texture:SetAllPoints()
		self:RegisterForClicks("LeftButtonDown")
		self.iconText = iconText
		self:SetScript("OnClick", AddTextToEditBox)
	end
	
	for i=12,17 do
		CreateOtherIcon(5+(i-12)*20,-2,module.db.otherIconsList[i][3],module.db.otherIconsList[i][1])
	end
	do
		local line = 2
		local inLine = 0
		for i=1,#module.db.otherIconsAdditionalList do
			local spellID = module.db.otherIconsAdditionalList[i]
			if spellID == 0 then
				line = line + 1
				inLine = 0
			else
				local _,_,spellTexture = GetSpellInfo( spellID )
				
				CreateOtherIcon(5+inLine*20,-2-(line-1)*20,spellTexture,"{spell:"..spellID.."}")
				inLine = inLine + 1
				if inLine > 10 then
					line = line + 1
					inLine = 0
				end
			end
		end
		self.OtherIconsFrame.ScrollFrame:SetNewHeight( max(self.OtherIconsFrame:GetHeight()-40 , line * 20 + 4) )
	end
	
	self:SetScript("OnHide",function (self)
		self.OtherIconsFrame:Hide()
	end)
	
	self.dropDownColor = ExRT.lib.CreateDropDown(self,nil,0,0,70,ExRT.L.NoteColor)
	ExRT.lib.SetPoint(self.dropDownColor,"TOPRIGHT",self,"TOPLEFT",627,-25)
	self.dropDownColor.list = {
		{ExRT.L.NoteColorRed,"|cffff0000"},
		{ExRT.L.NoteColorGreen,"|cff00ff00"},
		{ExRT.L.NoteColorBlue,"|cff0000ff"},
		{ExRT.L.NoteColorYellow,"|cffffff00"},
		{ExRT.L.NoteColorPurple,"|cffff00ff"},
		{ExRT.L.NoteColorAzure,"|cff00ffff"},
		{ExRT.L.NoteColorBlack,"|cff000000"},
		{ExRT.L.NoteColorGrey,"|cff808080"},
		{ExRT.L.NoteColorRedSoft,"|cffee5555"},
		{ExRT.L.NoteColorGreenSoft,"|cff55ee55"},
		{ExRT.L.NoteColorBlueSoft,"|cff5555ee"},
	}
	local classNames = {"WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST","DEATHKNIGHT","SHAMAN","MAGE","WARLOCK","MONK","DRUID"}
	for i,class in ipairs(classNames) do
		local colorTable = RAID_CLASS_COLORS[class]
		if colorTable then
			self.dropDownColor.list[#self.dropDownColor.list + 1] = {ExRT.L.classLocalizate[class],"|c"..colorTable.colorStr}
		end
	end
	self.dropDownColor:SetScript("OnEnter",function (self)
		ExRT.lib.TooltipShow(self,"ANCHOR_LEFT",ExRT.L.NoteColor,{ExRT.L.NoteColorTooltip1,1,1,1,true},{ExRT.L.NoteColorTooltip2,1,1,1,true})
	end)
	self.dropDownColor:SetScript("OnLeave",function ()
		ExRT.lib.TooltipHide()
	end)	
	UIDropDownMenu_Initialize(self.dropDownColor, function(self, level, menuList)
		ExRT.mds.FixDropDown(180)
		local info = UIDropDownMenu_CreateInfo()
		for i,colorData in ipairs(self.list) do
			info.text,info.notCheckable,info.minWidth,info.justifyH = colorData[1],1,180,"CENTER"
			info.menuList, info.hasArrow, info.arg1 = i, false, colorData[2]
			info.func = self.SetValue
			info.colorCode = colorData[2]
			UIDropDownMenu_AddButton(info)
		end
	end)
	function self.dropDownColor:SetValue(colorCode)
		CloseDropDownMenus()

		local selectedStart,selectedEnd = module.options.NoteEditBox.EditBox:GetTextHighlight()
		colorCode = string.gsub(colorCode,"|","||")
		if selectedStart == selectedEnd then
			AddTextToEditBox(nil,colorCode.."||r")
		else
			AddTextToEditBox(nil,"||r",selectedEnd)
			AddTextToEditBox(nil,colorCode,selectedStart)
		end
	end

	local function RaidNamesOnEnter(self)
		self.html:SetShadowColor(0.2, 0.2, 0.2, 1)
	end
	local function RaidNamesOnLeave(self)
		self.html:SetShadowColor(0, 0, 0, 1)
	end
	self.raidnames = {}
	for i=1,30 do
		self.raidnames[i] = CreateFrame("Button", nil,self)
		self.raidnames[i]:SetSize(97,14)
		self.raidnames[i]:SetPoint("TOPLEFT", 10+math.floor((i-1)/5)*99,-50-14*((i-1)%5))

		self.raidnames[i].html = ExRT.lib.CreateText(self.raidnames[i],99,14,nil,0,0,nil,nil,nil,11,"",nil,1,1,1)
		self.raidnames[i].html:ClearAllPoints()
		self.raidnames[i].html:SetAllPoints(self.raidnames[i])
		self.raidnames[i].txt = ""
		self.raidnames[i]:RegisterForClicks("LeftButtonDown")
		self.raidnames[i].iconText = ""
		self.raidnames[i]:SetScript("OnClick", AddTextToEditBox)

		self.raidnames[i]:SetScript("OnEnter", RaidNamesOnEnter)
		self.raidnames[i]:SetScript("OnLeave", RaidNamesOnLeave)
	end
	
	self.lastUpdate = ExRT.lib.CreateText(self,600,20,nil,0,0,"LEFT","TOP",nil,11,"",nil,1,1,1)
	ExRT.lib.SetPoint(self.lastUpdate,"TOPLEFT",self.NotesList,"BOTTOMLEFT",10,-2)
	if VExRT.Note.LastUpdateName and VExRT.Note.LastUpdateTime then
		self.lastUpdate:SetText( ExRT.L.NoteLastUpdate..": "..VExRT.Note.LastUpdateName.." ("..date("%H:%M:%S %d.%m.%Y",VExRT.Note.LastUpdateTime)..")" )
	end

	self.chkEnable = ExRT.lib.CreateCheckBox(self,nil,10,-490,ExRT.L.senable)
	self.chkEnable:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.Note.enabled = true
			module.frame:Show()
		else
			VExRT.Note.enabled = nil
			module.frame:Hide()
		end
	end)  
	
	self.chkFix = ExRT.lib.CreateCheckBox(self,nil,161,-490,ExRT.L.messagebutfix,nil,ExRT.L.messagebutfixtooltip)  
	self.chkFix:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.Note.Fix = true
			module.frame:SetMovable(false)
			module.frame:EnableMouse(false)
			module.frame.buttonResize:Hide()
			ExRT.lib.AddShadowComment(module.frame,1)
		else
			VExRT.Note.Fix = nil
			module.frame:SetMovable(true)
			module.frame:EnableMouse(true)
			module.frame.buttonResize:Show()
			ExRT.lib.AddShadowComment(module.frame,nil,ExRT.L.message)
		end
	end) 

	self.chkOutline = ExRT.lib.CreateCheckBox(self,nil,311,-490,ExRT.L.messageOutline)  
	self.chkOutline:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.Note.Outline = true
			module.frame.text:SetFont(ExRT.mds.defFont, 12,"OUTLINE")
		else
			VExRT.Note.Outline = nil
			module.frame.text:SetFont(ExRT.mds.defFont, 12)
		end
	end) 
	
	self.chkOnlyPromoted = ExRT.lib.CreateCheckBox(self,nil,585,-463,ExRT.L.NoteOnlyPromoted,VExRT.Note.OnlyPromoted,ExRT.L.NoteOnlyPromotedTooltip,true)
	self.chkOnlyPromoted:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.Note.OnlyPromoted = true
		else
			VExRT.Note.OnlyPromoted = nil
		end
	end)  
	
	 
	self.slideralpha = ExRT.lib.CreateSlider(self,180,15,20,-538,0,100,ExRT.L.messagebutalpha)
	self.slideralpha:SetScript("OnValueChanged", function(self,event) 
		event = event - event%1
		VExRT.Note.Alpha = event
		module.frame:SetAlpha(event/100)
		self.tooltipText = event
		self:tooltipReload(self)
	end)
	
	self.sliderscale = ExRT.lib.CreateSlider(self,180,15,220,-538,5,200,ExRT.L.messagebutscale,100)
	self.sliderscale:SetScript("OnValueChanged", function(self,event) 
		event = event - event%1
		VExRT.Note.Scale = event
		ExRT.mds.SetScaleFix(module.frame,event/100)
		self.tooltipText = event
		self:tooltipReload(self)
	end)

	self.slideralphaback = ExRT.lib.CreateSlider(self,180,15,420,-538,0,100,ExRT.L.messageBackAlpha)
	self.slideralphaback:SetScript("OnValueChanged", function(self,event) 
		event = event - event%1
		VExRT.Note.ScaleBack = event
		module.frame.background:SetTexture(0, 0, 0, event/100)
		self.tooltipText = event
		self:tooltipReload(self)
	end)
	
	self.ButtonToCenter = ExRT.lib.CreateButton(self,161,24,nil,452,-494,ExRT.L.MarksBarResetPos,nil,ExRT.L.MarksBarResetPosTooltip)
	self.ButtonToCenter:SetScript("OnClick",function()
		VExRT.Note.Left = nil
		VExRT.Note.Top = nil

		module.frame:ClearAllPoints()
		module.frame:SetPoint("CENTER",UIParent, "CENTER", 0, 0)
	end) 


	self.chkEnable:SetChecked(VExRT.Note.enabled)

	if VExRT.Note.Text1 then 
		self.NoteEditBox.EditBox:SetText(VExRT.Note.Text1) 
	end
	if VExRT.Note.Alpha then 
		self.slideralpha:SetValue(VExRT.Note.Alpha)
	end
	if VExRT.Note.Scale then 
		self.sliderscale:SetValue(VExRT.Note.Scale) 
	end
	if VExRT.Note.ScaleBack then 
		self.slideralphaback:SetValue(VExRT.Note.ScaleBack) 
	end
	self.chkFix:SetChecked(VExRT.Note.Fix)
	self.chkOutline:SetChecked(VExRT.Note.Outline)

	module:RegisterEvents("GROUP_ROSTER_UPDATE")
	module.main:GROUP_ROSTER_UPDATE()
end


module.frame = CreateFrame("Frame",nil,UIParent)
module.frame:SetSize(200,100)
module.frame:SetPoint("CENTER",UIParent, "CENTER", 0, 0)
module.frame:EnableMouse(true)
module.frame:SetMovable(true)
module.frame:RegisterForDrag("LeftButton")
module.frame:SetScript("OnDragStart", function(self)
	if self:IsMovable() then
		self:StartMoving()
	end
end)
module.frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	VExRT.Note.Left = self:GetLeft()
	VExRT.Note.Top = self:GetTop()
end)
module.frame:SetFrameStrata("TOOLTIP")
module.frame:SetResizable(true)
module.frame:SetMinResize(30, 30)
module.frame:SetScript("OnSizeChanged", function (self, width, height)
	local width_, height_ = self:GetSize()
	VExRT.Note.Width = width
	VExRT.Note.Height = height
	module.frame:UpdateText()
end)
module.frame:Hide() 

function module.frame:UpdateText()
	local selfText = VExRT.Note.SelfText or ""
	if selfText ~= "" then
		selfText = "\n"..selfText
	end
	self.text:SetText(txtWithIcons((VExRT.Note.Text1 or "")..selfText)) 
end

module.frame.background = module.frame:CreateTexture(nil, "BACKGROUND")
module.frame.background:SetTexture(0, 0, 0, 1)
module.frame.background:SetAllPoints()

module.frame.text = module.frame:CreateFontString(nil,"ARTWORK")
module.frame.text:SetFont(ExRT.mds.defFont, 12)
module.frame.text:SetPoint("TOPLEFT",5,-5)
module.frame.text:SetPoint("BOTTOMRIGHT",-5,5)
module.frame.text:SetJustifyH("LEFT")
module.frame.text:SetJustifyV("TOP")
module.frame.text:SetText(" ")

module.frame.buttonResize = CreateFrame("Frame",nil,module.frame)
module.frame.buttonResize:SetSize(15,15)
module.frame.buttonResize:SetPoint("BOTTOMRIGHT", 0, 0)
module.frame.buttonResize.back = module.frame.buttonResize:CreateTexture(nil, "BACKGROUND")
module.frame.buttonResize.back:SetTexture("Interface\\AddOns\\ExRT\\media\\Resize.tga")
module.frame.buttonResize.back:SetAllPoints()
module.frame.buttonResize:SetScript("OnMouseDown", function(self)
	module.frame:StartSizing()
end)
module.frame.buttonResize:SetScript("OnMouseUp", function(self)
	module.frame:StopMovingOrSizing()
end)


function module.frame:Save()
	VExRT.Note.Text1 = module.options.NoteEditBox.EditBox:GetText()
	if #VExRT.Note.Text1 == 0 then
		VExRT.Note.Text1 = " "
	end
	local txttosand = VExRT.Note.Text1
	local arrtosand = {}
	local j = 1
	local indextosnd = tostring(GetTime())..tostring(math.random(1000,9999))
	for i=1,#txttosand do
		if i%220 == 0 then
			arrtosand[j]=string.sub (txttosand, (j-1)*220+1, j*220)
			j = j + 1
		elseif i == #txttosand then
			arrtosand[j]=string.sub (txttosand, (j-1)*220+1)
			j = j + 1
		end
	end
	for i=1,#arrtosand do
		ExRT.mds.SendExMsg("multiline",indextosnd.."\t"..arrtosand[i])
	end
end 

function module.frame:Clear() 
	module.options.NoteEditBox.EditBox:SetText("") 
end 

function module:addonMessage(sender, prefix, ...)
	if prefix == "multiline" then
		if VExRT.Note.OnlyPromoted and IsInRaid() and not ExRT.mds.IsPlayerRLorOfficer(sender) then
			return
		end
	
		VExRT.Note.LastUpdateName = sender
		VExRT.Note.LastUpdateTime = time()
	
		local msgnowindex,lastnowtext = ...
		if tostring(msgnowindex) == tostring(module.db.msgindex) then
			module.db.lasttext = module.db.lasttext .. lastnowtext
		else
			module.db.lasttext = lastnowtext
		end
		module.db.msgindex = msgnowindex
		VExRT.Note.Text1 = module.db.lasttext
		module.frame:UpdateText()
		if module.options.NoteEditBox then
			module.options.NoteEditBox.EditBox:SetText(VExRT.Note.Text1)
			
			module.options.lastUpdate:SetText( ExRT.L.NoteLastUpdate..": "..VExRT.Note.LastUpdateName.." ("..date("%H:%M:%S %d.%m.%Y",VExRT.Note.LastUpdateTime)..")" )
		end
	end 
end 

local gruevent = {}

function module.main:ADDON_LOADED()
	VExRT = _G.VExRT
	VExRT.Note = VExRT.Note or {}
	VExRT.Note.Black = VExRT.Note.Black or {}

	if VExRT.Note.Left and VExRT.Note.Top then 
		module.frame:ClearAllPoints()
		module.frame:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",VExRT.Note.Left,VExRT.Note.Top)
	end

	if VExRT.Note.Width then 
		module.frame:SetWidth(VExRT.Note.Width) 
	end
	if VExRT.Note.Height then 
		module.frame:SetHeight(VExRT.Note.Height) 
	end

	if VExRT.Note.enabled then 
		module.frame:Show() 
	end

	if VExRT.Note.Text1 then 
		module.frame:UpdateText()
	end
	if VExRT.Note.Alpha then 
		module.frame:SetAlpha(VExRT.Note.Alpha/100) 
	end
	if VExRT.Note.Scale then 
		module.frame:SetScale(VExRT.Note.Scale/100) 
	end
	if VExRT.Note.ScaleBack then
		module.frame.background:SetTexture(0, 0, 0, VExRT.Note.ScaleBack/100)
	end
	if VExRT.Note.Outline then
		module.frame.text:SetFont(ExRT.mds.defFont, 12,"OUTLINE")
	end
	if VExRT.Note.Fix then
		module.frame:SetMovable(false)
		module.frame:EnableMouse(false)
		module.frame.buttonResize:Hide()
	else
		ExRT.lib.AddShadowComment(module.frame,nil,ExRT.L.message)
	end
	
	if VExRT.Addon.Version < 3225 then
		for i=1,12 do
			if not VExRT.Note.Black[i] then
				for j=i,12 do
					VExRT.Note.Black[j] = VExRT.Note.Black[j+1]
				end
			end
		end
	end
	VExRT.Note.BlackNames = VExRT.Note.BlackNames or {}
	
	for i=1,3 do
		VExRT.Note.Black[i] = VExRT.Note.Black[i] or ""
	end
	
	module:RegisterAddonMessage()
end

function module.main:GROUP_ROSTER_UPDATE()
	local n = GetNumGroupMembers() or 0
	local gMax = ExRT.mds.GetRaidDiffMaxGroup()
	for i=1,8 do gruevent[i] = 0 end
	for i=1,n do
		local name,_,subgroup,_,_,class = GetRaidRosterInfo(i)
		if name and subgroup <= gMax and gruevent[subgroup] then
			gruevent[subgroup] = gruevent[subgroup] + 1
			local cR,cG,cB = ExRT.mds.classColorNum(class)

			local POS = gruevent[subgroup] + (subgroup - 1) * 5
			local obj = module.options.raidnames[POS]
			
			if obj then
				name = ExRT.mds.delUnitNameServer(name)
				local colorCode = ExRT.mds.classColor(class)
				obj.iconText = "||c"..colorCode..name.."||r "
				obj.iconTextShift = name
				obj.html:SetText(name)
				obj.html:SetTextColor(cR, cG, cB, 1)
			end
		end
	end
	for i=1,6 do
		for j=(gruevent[i]+1),5 do
			local frame = module.options.raidnames[(i-1)*5+j]
			frame.iconText = ""
			frame.iconTextShift = ""
			frame.html:SetText("")
		end
	end
end 