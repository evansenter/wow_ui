local GlobalAddonName, ExRT = ...

ExRT.Options = {}
ExRT.Options.panel = CreateFrame( "Frame", "ExRTOptionsPanel" )
ExRT.Options.panel.name = "Exorsus Raid Tools"
InterfaceOptions_AddCategory(ExRT.Options.panel)
ExRT.Options.panel:Hide()

----> Minimap Icon

ExRT.MiniMapIcon = CreateFrame("Button", "LibDBIcon10_ExorsusRaidTools", Minimap)
ExRT.MiniMapIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight") 
ExRT.MiniMapIcon:SetSize(32,32) 
ExRT.MiniMapIcon:SetFrameStrata("MEDIUM")
ExRT.MiniMapIcon:SetFrameLevel(8)
ExRT.MiniMapIcon:SetPoint("CENTER", -12, -80)
ExRT.MiniMapIcon:SetDontSavePosition(true)
ExRT.MiniMapIcon:RegisterForDrag("LeftButton")
ExRT.MiniMapIcon.icon = ExRT.MiniMapIcon:CreateTexture(nil, "BACKGROUND")
ExRT.MiniMapIcon.icon:SetTexture("Interface\\AddOns\\ExRT\\media\\MiniMap")
ExRT.MiniMapIcon.icon:SetSize(32,32)
ExRT.MiniMapIcon.icon:SetPoint("CENTER", 0, 0)
ExRT.MiniMapIcon.border = ExRT.MiniMapIcon:CreateTexture(nil, "ARTWORK")
ExRT.MiniMapIcon.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
ExRT.MiniMapIcon.border:SetTexCoord(0,0.6,0,0.6)
ExRT.MiniMapIcon.border:SetAllPoints()
ExRT.MiniMapIcon:RegisterForClicks("anyUp")
ExRT.MiniMapIcon:SetScript("OnEnter",function(self) 
	GameTooltip:SetOwner(self, "ANCHOR_LEFT") 
	GameTooltip:AddLine("Exorsus Raid Tools") 
	GameTooltip:AddLine(ExRT.L.minimaptooltiplmp,1,1,1) 
	GameTooltip:AddLine(ExRT.L.minimaptooltiprmp,1,1,1) 
	GameTooltip:Show() 
end)
ExRT.MiniMapIcon:SetScript("OnLeave", function(self)    
	GameTooltip:Hide()
end)

local minimapShapes = {
	["ROUND"] = {true, true, true, true},
	["SQUARE"] = {false, false, false, false},
	["CORNER-TOPLEFT"] = {false, false, false, true},
	["CORNER-TOPRIGHT"] = {false, false, true, false},
	["CORNER-BOTTOMLEFT"] = {false, true, false, false},
	["CORNER-BOTTOMRIGHT"] = {true, false, false, false},
	["SIDE-LEFT"] = {false, true, false, true},
	["SIDE-RIGHT"] = {true, false, true, false},
	["SIDE-TOP"] = {false, false, true, true},
	["SIDE-BOTTOM"] = {true, true, false, false},
	["TRICORNER-TOPLEFT"] = {false, true, true, true},
	["TRICORNER-TOPRIGHT"] = {true, false, true, true},
	["TRICORNER-BOTTOMLEFT"] = {true, true, false, true},
	["TRICORNER-BOTTOMRIGHT"] = {true, true, true, false},
}

local function IconMoveButton(self)
	if self.dragMode == "free" then
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", x, y)
		VExRT.Addon.IconMiniMapLeft = x
		VExRT.Addon.IconMiniMapTop = y
	else
		local mx, my = Minimap:GetCenter()
		local px, py = GetCursorPosition()
		local scale = Minimap:GetEffectiveScale()
		px, py = px / scale, py / scale
		
		local angle = math.atan2(py - my, px - mx)
		local x, y, q = math.cos(angle), math.sin(angle), 1
		if x < 0 then q = q + 1 end
		if y > 0 then q = q + 2 end
		local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
		local quadTable = minimapShapes[minimapShape]
		if quadTable[q] then
			x, y = x*80, y*80
		else
			local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
			x = math.max(-80, math.min(x*diagRadius, 80))
			y = math.max(-80, math.min(y*diagRadius, 80))
		end
		self:ClearAllPoints()
		self:SetPoint("CENTER", Minimap, "CENTER", x, y)
		VExRT.Addon.IconMiniMapLeft = x
		VExRT.Addon.IconMiniMapTop = y
	end
end

ExRT.MiniMapIcon:SetScript("OnDragStart", function(self)
	self:LockHighlight()
	self:SetScript("OnUpdate", IconMoveButton)
	self.isMoving = true
	GameTooltip:Hide()
end)
ExRT.MiniMapIcon:SetScript("OnDragStop", function(self)
	self:UnlockHighlight()
	self:SetScript("OnUpdate", nil)
	self.isMoving = false
end)

local function MiniMapIconOnClick(self, button)
	if button == "RightButton" then
		for i, val in pairs(ExRT.MiniMapMenu) do
			val:miniMapMenu()
		end
		ExRT.Options:UpdateModulesList()
		EasyMenu(ExRT.mds.menuTable, ExRT.Options.panel.dropdown, "cursor", 10 , -15, "MENU")
	elseif button == "LeftButton" then
		ExRT.Options:Open()
	end
end

ExRT.MiniMapIcon:SetScript("OnMouseUp", MiniMapIconOnClick)

ExRT.Options.panel.dropdown = CreateFrame("Frame", "ExRTMiniMapMenuFrame", nil, "UIDropDownMenuTemplate")

function ExRT.mds.MinimapMenuAdd(text_, func_, subMenu)
	local k = #ExRT.mds.menuTable
	for i=1,k do
		if ExRT.mds.menuTable[i].text == text_ then return end
	end
	ExRT.mds.menuTable[k+1] = ExRT.mds.menuTable[k]
	ExRT.mds.menuTable[k] = { text = text_, func = func_, notCheckable = true, keepShownOnClick = true, }
	if subMenu then
		ExRT.mds.menuTable[k].hasArrow = true
		ExRT.mds.menuTable[k].menuList = subMenu
	end
end

function ExRT.mds.MinimapMenuRemove(text_)
	local k = #ExRT.mds.menuTable
	for i=1,k do
		if ExRT.mds.menuTable[i].text == text_ then 
			for j=i+1,k do
				ExRT.mds.menuTable[j-1] = ExRT.mds.menuTable[j]
			end
			ExRT.mds.menuTable[k] = nil
			return 
		end
	end
end

function ExRT.Options:Open(PANEL)
	if InterfaceOptionsFrame:IsShown() then
		return
	end
	PANEL = PANEL or ExRT.Options.panel
	InterfaceOptionsFrame_OpenToCategory(PANEL)
	InterfaceOptionsFrame_OpenToCategory(PANEL)
	local toggleButton
	for _,button in pairs(InterfaceOptionsFrameAddOns.buttons) do
		if button.element then
			if button.element.name == ExRT.Options.panel.name then 
				toggleButton = button
				break
			end
		end
	end
	if toggleButton and toggleButton.element.collapsed then 
		OptionsListButtonToggle_OnClick(toggleButton.toggle) 
	end
end

ExRT.mds.menuTable = {
{ text = ExRT.L.minimapmenu, isTitle = true, notCheckable = true, notClickable = true },
{ text = ExRT.L.minimapmenuset, func = ExRT.Options.Open, notCheckable = true, keepShownOnClick = true, },
{ text = ExRT.L.minimapmenuclose, func = function() CloseDropDownMenus() end, notCheckable = true },
}

local modulesActive = {}
function ExRT.Options:UpdateModulesList()
	local alreadyAdded = false
	for i=1,#ExRT.mds.menuTable do
		if ExRT.mds.menuTable[i].isTitle and ExRT.mds.menuTable[i].text == " " then
			alreadyAdded = true
			break
		end
	end
	if not alreadyAdded then
		ExRT.mds.menuTable[#ExRT.mds.menuTable + 1] = ExRT.mds.menuTable[#ExRT.mds.menuTable]
		ExRT.mds.menuTable[#ExRT.mds.menuTable - 1] = { text = " ", isTitle = true, notCheckable = true, notClickable = true }
	end
	for i=1,#ExRT.ModulesOptions do
		if not modulesActive[ ExRT.ModulesOptions[i].name ] then
			ExRT.mds.menuTable[#ExRT.mds.menuTable + 1] = ExRT.mds.menuTable[#ExRT.mds.menuTable]
			ExRT.mds.menuTable[#ExRT.mds.menuTable - 1] = { text = ExRT.ModulesOptions[i].name, notCheckable = true, func = function() ExRT.Options:Open(ExRT.ModulesOptions[i]) end }
		end
		modulesActive[ ExRT.ModulesOptions[i].name ] = true
	end
end

----> Options

ExRT.Options.panel.title = ExRT.lib.CreateText(ExRT.Options.panel,500,22,nil,160,-52,nil,nil,nil,22,"Exorsus Raid Tools",nil,1,1,1)

ExRT.Options.panel.image = CreateFrame("FRAME",nil,ExRT.Options.panel)
ExRT.Options.panel.image:SetSize(256,256)
ExRT.Options.panel.image:SetBackdrop({bgFile = "Interface\\AddOns\\ExRT\\media\\OptionLogo"})
ExRT.Options.panel.image:SetPoint("TOPLEFT", -30,-4)	
ExRT.Options.panel.image:SetFrameLevel(5)

ExRT.Options.panel.chkIconMiniMap = ExRT.lib.CreateCheckBox(ExRT.Options.panel,nil,25,-165,ExRT.L.setminimap1)
ExRT.Options.panel.chkIconMiniMap:SetScript("OnClick", function(self,event) 
	if self:GetChecked() then
		VExRT.Addon.IconMiniMapHide = true
		ExRT.MiniMapIcon:Hide()
	else
		VExRT.Addon.IconMiniMapHide = nil
		ExRT.MiniMapIcon:Show()
	end
end)
ExRT.Options.panel.chkIconMiniMap:SetScript("OnShow", function(self,event) 
	self:SetChecked(VExRT.Addon.IconMiniMapHide) 
end)

ExRT.Options.panel.timerSlider = ExRT.lib.CreateSlider(ExRT.Options.panel,550,15,0,-145,10,1000,ExRT.L.setEggTimerSlider,100,"TOP")
ExRT.Options.panel.timerSlider:Hide()
ExRT.Options.panel.timerSlider:SetScript("OnValueChanged", function(self,event) 
	event = event - event%1
	self.tooltipText = event
	self:tooltipReload(self)	
	event = event / 1000	
	VExRT.Addon.Timer = event
end)

ExRT.Options.panel.eventsCountTextLeft = ExRT.lib.CreateText(ExRT.Options.panel,590,300,"TOPLEFT",15,-300,"LEFT","TOP",nil,12,nil,nil,1,1,1,1)
ExRT.Options.panel.eventsCountTextRight = ExRT.lib.CreateText(ExRT.Options.panel,590,300,"TOPLEFT",85,-300,"LEFT","TOP",nil,12,nil,nil,1,1,1,1)
ExRT.Options.panel.eventsCountTextFrame = CreateFrame("Frame",nil,ExRT.Options.panel)
ExRT.Options.panel.eventsCountTextFrame:SetSize(1,1)
ExRT.Options.panel.eventsCountTextFrame:SetPoint("TOPLEFT")
ExRT.Options.panel.eventsCountTextFrame:Hide()
ExRT.Options.panel.eventsCountTextFrame:SetScript("OnShow",function()
	local tmp = {}
	for i=1,#ExRT.Modules do
		if ExRT.Modules[i].main.eventsCounter then
			for event,count in pairs(ExRT.Modules[i].main.eventsCounter) do
				if not tmp[event] then
					tmp[event] = count
				else
					tmp[event] = max(tmp[event],count)
				end
			end
		end
	end
	tmp["COMBAT_LOG_EVENT_UNFILTERED"] = ExRT.CLEUframe.eventsCounter or 0
	local tmp2 = {}
	local total = 0
	for event,count in pairs(tmp) do
		table.insert(tmp2,{event,count})
		total = total + count
	end
	table.sort(tmp2,function(a,b) return a[2] > b[2] end)
	local h = total.."\n"
	local n = "Total\n"
	for i=1,#tmp2 do
		h = h .. tmp2[i][2].."\n"
		n = n .. tmp2[i][1] .."\n"
	end
	ExRT.Options.panel.eventsCountTextLeft:SetText(h)
	ExRT.Options.panel.eventsCountTextRight:SetText(n)
end)

ExRT.Options.panel.eggBut = CreateFrame("Button",nil,ExRT.Options.panel)  
ExRT.Options.panel.eggBut:SetSize(12,12) 
ExRT.Options.panel.eggBut:SetPoint("TOPLEFT",89,-52)
ExRT.Options.panel.eggBut:SetFrameLevel(8)
ExRT.Options.panel.eggBut:SetScript("OnClick",function(s) 
	local superMode = nil
	ExRT.Options.panel.timerSlider:SetValue(VExRT.Addon.Timer*1000 or 100)
	ExRT.Options.panel.timerSlider:Show()
	ExRT.Options.panel.eventsCountTextFrame:Show()
	if IsShiftKeyDown() then
		return
	end
	if IsAltKeyDown() then
		superMode = true
	end
	for i, val in pairs(ExRT.Eggs) do
		val:egg(superMode)
	end
end)

ExRT.Options.panel.authorLeft = ExRT.lib.CreateText(ExRT.Options.panel,150,25,nil,25,-220,"LEFT","TOP",nil,12,ExRT.L.setauthor,nil,nil,nil,nil,1)
ExRT.Options.panel.authorRight = ExRT.lib.CreateText(ExRT.Options.panel,450,25,nil,135,-220,"LEFT","TOP",nil,12,"Afiya (Афиа) @ EU-Howling Fjord",nil,1,1,1,1)

ExRT.Options.panel.versionLeft = ExRT.lib.CreateText(ExRT.Options.panel,150,25,nil,25,-240,"LEFT","TOP",nil,12,ExRT.L.setver,nil,nil,nil,nil,1)
ExRT.Options.panel.versionRight = ExRT.lib.CreateText(ExRT.Options.panel,450,25,nil,135,-240,"LEFT","TOP",nil,12,ExRT.V..(ExRT.T == "R" and "" or " "..ExRT.T),nil,1,1,1,1)

ExRT.Options.panel.contactLeft = ExRT.lib.CreateText(ExRT.Options.panel,150,25,nil,25,-260,"LEFT","TOP",nil,12,ExRT.L.setcontact,nil,nil,nil,nil,1)
ExRT.Options.panel.contactRight = ExRT.lib.CreateText(ExRT.Options.panel,450,25,nil,135,-260,"LEFT","TOP",nil,12,"e-mail: ykiigor@gmail.com",nil,1,1,1,1)

ExRT.Options.panel.thanksLeft = ExRT.lib.CreateText(ExRT.Options.panel,150,25,nil,25,-280,"LEFT","TOP",nil,12,ExRT.L.SetThanks,nil,nil,nil,nil,1)
ExRT.Options.panel.thanksRight = ExRT.lib.CreateText(ExRT.Options.panel,450,0,nil,135,-280,"LEFT","TOP",nil,12,"Phanx, funkydude, Shurshik, Kemayo, Guillotine, Rabbit, fookah, diesal2010",nil,1,1,1,1)

if ExRT.L.TranslateBy ~= "" then
	ExRT.Options.panel.translateLeft = ExRT.lib.CreateText(ExRT.Options.panel,150,25,nil,25,-280,"LEFT","TOP",nil,12,ExRT.L.SetTranslate,nil,nil,nil,nil,1)
	ExRT.Options.panel.translateRight = ExRT.lib.CreateText(ExRT.Options.panel,450,25,nil,135,-280,"LEFT","TOP",nil,12,ExRT.L.TranslateBy,nil,1,1,1,1)
	ExRT.lib.SetPoint(ExRT.Options.panel.translateRight,"TOPLEFT",ExRT.Options.panel.thanksRight,"BOTTOMLEFT",0,-10)
	ExRT.lib.SetPoint(ExRT.Options.panel.translateLeft,"TOPLEFT",ExRT.Options.panel.translateRight,"TOPLEFT",-110,0)
end

local function CreateDataBrokerPlugin()
	local dataObject = LibStub:GetLibrary('LibDataBroker-1.1'):NewDataObject(GlobalAddonName, {
		type = 'launcher',

		icon = "Interface\\AddOns\\ExRT\\media\\MiniMap",

		OnClick = MiniMapIconOnClick,
	})
end
CreateDataBrokerPlugin()
