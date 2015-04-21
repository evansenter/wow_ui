local GlobalAddonName, ExRT = ...

local GetTime, GetRaidTargetIndex, SetRaidTarget, UnitName, SetRaidTargetIcon = GetTime, GetRaidTargetIndex, SetRaidTarget, UnitName, SetRaidTargetIcon

local VExRT = nil

local module = ExRT.mod:New("MarksBar",ExRT.L.marksbar,nil,true)
module.db.perma = {}
module.db.clearnum = -1
module.db.iconsList = {
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_1",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_2",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_3",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_4",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_5",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_6",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_7",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_8",
}
module.db.worldMarksList = {
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_6",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_4",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_3",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_7",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_1",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_2",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_5",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_8",
	"Interface\\AddOns\\ExRT\\media\\flare_del.blp",
}
module.db.wm_color ={
	{ r = 4/255, g = 149/255, b = 255/255},
	{ r = 15/255, g = 155/255 , b = 12/255},
	{ r = 168/255, g = 14/255, b = 192/255},
	{ r = 167/255, g = 20/255 , b = 13/255},
	{ r = 222/255, g = 218/255, b = 50/255},
	{ r = 208/255, g = 84/255, b = 0/255},
	{ r = 116/255, g = 155/255, b = 179/255},
	{ r = 243/255, g = 241/255, b = 235/255},
	{ r = 0.7, g = 0.7, b = 0.7 },
}

module.db.wm_color_hover ={
	{ r = 100/255, g = 189/255, b = 255/255},
	{ r = 15/255, g = 215/255 , b = 12/255},
	{ r = 220/255, g = 67/255, b = 241/255},
	{ r = 240/255, g = 77/255 , b = 68/255},
	{ r = 243/255, g = 242/255, b = 182/255},
	{ r = 255/255, g = 128/255, b = 43/255},
	{ r = 56/255, g = 86/255, b = 103/255},
	{ r = 191/255, g = 194/255, b = 155/255},
	{ r = 1.0, g = 1.0, b = 1.0 },
}

module.db.WMcount = 9
module.db.WMwidthWODfix = 28

module.frame = CreateFrame("Frame",nil,UIParent)
module.frame:SetSize(370,34)
module.frame:SetPoint("CENTER",UIParent, "CENTER", 0, 0)
module.frame:SetFrameStrata("HIGH")
module.frame:EnableMouse(true)
module.frame:SetMovable(true)
module.frame:SetClampedToScreen(true)
module.frame:RegisterForDrag("LeftButton")
module.frame:SetScript("OnDragStart", function(self) 
	if self:IsMovable() then 
		self:StartMoving() 
	end 
end)
module.frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	VExRT.MarksBar.Left = self:GetLeft()
	VExRT.MarksBar.Top = self:GetTop()
end)
module.frame:SetBackdrop({bgFile = ExRT.mds.barImg})
module.frame:SetBackdropColor(0,0,0,0.8)
module.frame:Hide()
module:RegisterHideOnPetBattle(module.frame)

module.frame.edge = CreateFrame("Frame",nil,module.frame)
--module.frame.edge:SetSize(368,32)
module.frame.edge:SetPoint("TOPLEFT", 1, -1)
module.frame.edge:SetPoint("BOTTOMRIGHT", -1, 1)
module.frame.edge:SetBackdrop({bgFile = ExRT.mds.barImg,edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 6})
module.frame.edge:SetBackdropColor(0,0,0,0)
module.frame.edge:SetBackdropBorderColor(0.6,0.6,0.6,1)

local function MainFrameMarkButtonOnEnter(self)
	local name = ExRT.A.Marks:GetName(self._i)
	if not (name and ExRT.A.Marks.Enabled) then
		module.frame.markbuts[self._i]:SetBackdropBorderColor(0.7,0.7,0.7,1)
	end
end
local function MainFrameMarkButtonOnLeave(self)
	local name = ExRT.A.Marks:GetName(self._i)
	if not (name and ExRT.A.Marks.Enabled) then
		module.frame.markbuts[self._i]:SetBackdropBorderColor(0.4,0.4,0.4,1)
	end
end
local function MainFrameMarkButtonOnClick(self, button)
	local i = self._i
	if button == "RightButton" then
		local name = ExRT.A.Marks:GetName(i)
		if name and ExRT.A.Marks.Enabled then
			module.frame.markbuts[i]:SetBackdropBorderColor(0.7,0.7,0.7,1)
			ExRT.A.Marks:SetName(i,nil)
			SetRaidTargetIcon(name, 0)
		else
			module.frame.markbuts[i]:SetBackdropBorderColor(0.2,0.8,0.2,1)
			if not ExRT.A.Marks.Enabled then
				ExRT.A.Marks:ClearNames()
				ExRT.A.Marks:Enable()
			end
			ExRT.A.Marks:SetName(i,UnitName("target"))
			SetRaidTargetIcon("target", i)
		end
	else
		SetRaidTargetIcon("target", i)
	end
end

module.frame.edges = {}

local function CreateEdge(i,x)
	local self = CreateFrame("Frame",nil,module.frame)
	self:SetSize(1,1)
	self:SetPoint("TOPLEFT",x,0)
	return self
end

module.frame.edges[1] = CreateEdge(1,4)

module.frame.markbuts = {}
do
	local markbuts_backdrop = {bgFile = ExRT.mds.barImg,edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 8}
	for i=1,8 do
		local frame = CreateFrame("Frame",nil,module.frame)
		module.frame.markbuts[i] = frame
		frame:SetSize(26,26)
		frame:SetPoint("TOPLEFT", module.frame.edges[1], (i-1)*28, -4)
		frame:SetBackdrop(markbuts_backdrop)
		frame:SetBackdropColor(0,0,0,0)
		frame:SetBackdropBorderColor(0.4,0.4,0.4,1)
	
		frame.but = CreateFrame("Button",nil,frame)
		frame.but:SetSize(20,20)
		frame.but:SetPoint("TOPLEFT",  3, -3)
		frame.but.t = frame.but:CreateTexture(nil, "BACKGROUND")
		frame.but.t:SetTexture(module.db.iconsList[i])
		frame.but.t:SetAllPoints()
		
		frame.but._i = i
	
		frame.but:SetScript("OnEnter",MainFrameMarkButtonOnEnter)
		frame.but:SetScript("OnLeave", MainFrameMarkButtonOnLeave)
	
		frame.but:RegisterForClicks("RightButtonDown","LeftButtonDown")
		frame.but:SetScript("OnClick", MainFrameMarkButtonOnClick)
	end
end

module.frame.edges[2] = CreateEdge(2,228)

module.frame.start = CreateFrame("Button",nil,module.frame)
module.frame.start:SetSize(50,12)
module.frame.start:SetPoint("TOPLEFT", module.frame.edges[2], 0, -4)
module.frame.start:SetBackdrop({bgFile = ExRT.mds.barImg,edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 6})
module.frame.start:SetBackdropColor(0,0,0,0)
module.frame.start:SetBackdropBorderColor(0.4,0.4,0.4,1)
module.frame.start:SetScript("OnEnter",function(self) 
	self:SetBackdropBorderColor(0.7,0.7,0.7,1)
end)	
module.frame.start:SetScript("OnLeave", function(self)    
	self:SetBackdropBorderColor(0.4,0.4,0.4,1)
end)
module.frame.start:SetScript("OnClick", function(self)    
	module.db.clearnum = GetTime()
	for i=1,8 do
		SetRaidTarget("player", i) 
	end
end)

module.frame.start.html = module.frame.start:CreateFontString(nil,"ARTWORK")
module.frame.start.html:SetFont(ExRT.mds.defFont, 10)
module.frame.start.html:SetAllPoints()
module.frame.start.html:SetJustifyH("CENTER")
module.frame.start.html:SetText(ExRT.L.marksbarstart)
module.frame.start.html:SetShadowOffset(1,-1)

module.frame.del = CreateFrame("Button",nil,module.frame)
module.frame.del:SetSize(50,12)
module.frame.del:SetPoint("TOPLEFT", module.frame.edges[2], 0, -18)
module.frame.del:SetBackdrop({bgFile = ExRT.mds.barImg,edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 6})
module.frame.del:SetBackdropColor(0,0,0,0)
module.frame.del:SetBackdropBorderColor(0.4,0.4,0.4,1)
module.frame.del:SetScript("OnEnter",function(self) 
	self:SetBackdropBorderColor(0.7,0.7,0.7,1)
end)	
module.frame.del:SetScript("OnLeave", function(self)    
	self:SetBackdropBorderColor(0.4,0.4,0.4,1)
end)
module.frame.del:SetScript("OnClick", function(self)    
	for i=1,8 do
		local name = ExRT.A.Marks:GetName(i)
		if name and UnitName(name) then
			SetRaidTargetIcon(name, 0)
		end
		module.frame.markbuts[i]:SetBackdropBorderColor(0.4,0.4,0.4,1)
	end
	ExRT.A.Marks:ClearNames()
	ExRT.A.Marks:Disable()
end)

module.frame.del.html = module.frame.del:CreateFontString(nil,"ARTWORK")
module.frame.del.html:SetFont(ExRT.mds.defFont, 10)
module.frame.del.html:SetAllPoints()
module.frame.del.html:SetJustifyH("CENTER")
module.frame.del.html:SetText(ExRT.L.marksbardel)
module.frame.del.html:SetShadowOffset(1,-1)

module.frame.edges[3] = CreateEdge(3,383)

module.frame.wmarksbuts = CreateFrame("Frame",nil,module.frame)
module.frame.wmarksbuts:SetSize(70,26)
module.frame.wmarksbuts:SetPoint("TOPLEFT", module.frame.edges[3], 0, -4)
local function MainFrameWMOnEnter(self)
	self:SetBackdropBorderColor(0.7,0.7,0.7,1)
end
local function MainFrameWMOnLeave(self)
	self:SetBackdropBorderColor(0.4,0.4,0.4,0)
end
local function MainFrameWMOnEvent(self, event, ...)
	self[event](self, event, ...)
end

do
	local wmarksbuts_backdrop = {bgFile = "",edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 6}
	for i=1,module.db.WMcount do
		local frame = CreateFrame("Button","ExRT_MarksBar_WorldMarkers_Kind1_"..i,module.frame.wmarksbuts,"SecureActionButtonTemplate")	--FrameStack Fix
		module.frame.wmarksbuts[i] = frame
		frame:SetSize(14,13)
		frame:SetPoint("TOPLEFT", floor((i-1)/2)*14, -((i-1)%2)*13)
		frame:SetBackdrop(wmarksbuts_backdrop)
		frame:SetBackdropColor(0,0,0,0)
		frame:SetBackdropBorderColor(0.4,0.4,0.4,0)
		frame:SetScript("OnEnter",MainFrameWMOnEnter)	
		frame:SetScript("OnLeave",MainFrameWMOnLeave)
		
		if i < module.db.WMcount then
			frame:RegisterForClicks("AnyDown")
			frame:SetAttribute("type", "macro")
			frame:SetAttribute("macrotext1", format("/wm %d", i))
			frame:SetAttribute("macrotext2", format("/cwm %d", i))
			frame:SetScript('OnEvent', MainFrameWMOnEvent)
		else
			frame:SetScript("OnClick", ClearRaidMarker)
		end
	
		frame.t = frame:CreateTexture(nil, "BACKGROUND")
		frame.t:SetTexture(module.db.worldMarksList[i])
		frame.t:SetSize(10,10)
		frame.t:SetPoint("CENTER",frame, "CENTER", 0,0)
	end
end

module.frame.wmarksbuts.b = CreateFrame("Frame",nil,module.frame)
module.frame.wmarksbuts.b:SetSize(123+19*(module.db.WMcount == 9 and 3 or 0),26)
module.frame.wmarksbuts.b:SetPoint("TOPLEFT", module.frame,"BOTTOMLEFT",20, 3)
module.frame.wmarksbuts.b:SetFrameLevel(0)
module.frame.wmarksbuts.b:SetBackdrop({bgFile = ExRT.mds.barImg})
module.frame.wmarksbuts.b:SetBackdropColor(0,0,0,0.8)
module.frame.wmarksbuts.b.t = CreateFrame("Frame",nil,module.frame.wmarksbuts.b)
module.frame.wmarksbuts.b.t:SetPoint("BOTTOMRIGHT", -1, 1)
module.frame.wmarksbuts.b.t:SetPoint("TOPLEFT", 1, -1)
module.frame.wmarksbuts.b.t:SetBackdrop({bgFile = ExRT.mds.barImg,edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 6})
module.frame.wmarksbuts.b.t:SetBackdropColor(0,0,0,0)
module.frame.wmarksbuts.b.t:SetBackdropBorderColor(0.6,0.6,0.6,1)
local function MainFrameWMKind2OnEnter(self)
	self.t:SetVertexColor(module.db.wm_color_hover[self._i].r,module.db.wm_color_hover[self._i].g,module.db.wm_color_hover[self._i].b,1)
end
local function MainFrameWMKind2OnLeave(self)
	self.t:SetVertexColor(module.db.wm_color[self._i].r,module.db.wm_color[self._i].g,module.db.wm_color[self._i].b,1)
end

for i=1,module.db.WMcount do
	local frame = CreateFrame("Button","ExRT_MarksBar_WorldMarkers_Kind2_"..i,module.frame.wmarksbuts.b,"SecureActionButtonTemplate")	--FrameStack Fix
	module.frame.wmarksbuts.b[i] = frame
	frame:SetSize(18,18)
	frame:SetPoint("TOPLEFT", 19*(i-1)+6, -4)
	frame.t = frame:CreateTexture(nil, "BACKGROUND")
	if i == module.db.WMcount then
		frame.t:SetTexture(module.db.worldMarksList[i])
	else
		frame.t:SetTexture("Interface\\AddOns\\ExRT\\media\\blip")
	end
	frame.t:SetSize(16,16)
	frame.t:SetPoint("TOPLEFT", 1, 0)
	frame.t:SetVertexColor(module.db.wm_color[i].r,module.db.wm_color[i].g,module.db.wm_color[i].b,1)
	frame._i = i
	
	frame:SetScript("OnEnter",MainFrameWMKind2OnEnter)	
	frame:SetScript("OnLeave", MainFrameWMKind2OnLeave)

	if i < module.db.WMcount then
		frame:RegisterForClicks("AnyDown")
		frame:SetAttribute("type", "macro")
		frame:SetAttribute("macrotext1", format("/wm %d", i))
		frame:SetAttribute("macrotext2", format("/cwm %d", i))
		frame:SetScript('OnEvent', MainFrameWMOnEvent)
	else
		frame:SetScript("OnClick", ClearRaidMarker)
	end
end

module.frame.edges[4] = CreateEdge(4,325)

module.frame.readyCheck = CreateFrame("Button",nil,module.frame)
module.frame.readyCheck:SetSize(40,12)
module.frame.readyCheck:SetPoint("TOPLEFT",module.frame.edges[4],0,-4)
module.frame.readyCheck:SetBackdrop({bgFile = ExRT.mds.barImg,edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 6})
module.frame.readyCheck:SetBackdropColor(0,0,0,0)
module.frame.readyCheck:SetBackdropBorderColor(0.4,0.4,0.4,1)
module.frame.readyCheck:SetScript("OnEnter",function(self) 
	self:SetBackdropBorderColor(0.7,0.7,0.7,1)
end)	
module.frame.readyCheck:SetScript("OnLeave", function(self)    
	self:SetBackdropBorderColor(0.4,0.4,0.4,1)
end)
module.frame.readyCheck:SetScript("OnClick", function(self)    
	DoReadyCheck()
end)

module.frame.readyCheck.html = module.frame.readyCheck:CreateFontString(nil,"ARTWORK")
module.frame.readyCheck.html:SetFont(ExRT.mds.defFont, 10)
module.frame.readyCheck.html:SetAllPoints()
module.frame.readyCheck.html:SetJustifyH("CENTER")
module.frame.readyCheck.html:SetText(ExRT.L.marksbarrc)
module.frame.readyCheck.html:SetShadowOffset(1,-1)

module.frame.pull = CreateFrame("Button",nil,module.frame)
module.frame.pull:SetSize(40,12)
module.frame.pull:SetPoint("TOPLEFT",module.frame.edges[4],0, -18)
module.frame.pull:SetBackdrop({bgFile = ExRT.mds.barImg,edgeFile = ExRT.mds.defBorder,tile = false,edgeSize = 6})
module.frame.pull:SetBackdropColor(0,0,0,0)
module.frame.pull:SetBackdropBorderColor(0.4,0.4,0.4,1)
module.frame.pull:SetScript("OnEnter",function(self) 
	self:SetBackdropBorderColor(0.7,0.7,0.7,1)
end)	
module.frame.pull:SetScript("OnLeave", function(self)    
	self:SetBackdropBorderColor(0.4,0.4,0.4,1)
end)
module.frame.pull:SetScript("OnClick", function(self)    
	ExRT.mds:DoPull(VExRT.MarksBar.pulltimer)
end)

module.frame.pull.html = module.frame.pull:CreateFontString(nil,"ARTWORK")
module.frame.pull.html:SetFont(ExRT.mds.defFont, 10)
module.frame.pull.html:SetAllPoints()
module.frame.pull.html:SetJustifyH("CENTER")
module.frame.pull.html:SetText(ExRT.L.marksbarpull)
module.frame.pull.html:SetShadowOffset(1,-1)

local function modifymarkbars()
	local mainFrame = module.frame
	if not VExRT.MarksBar.Vertical then
		--Horizontal
		for i=1,8 do
			mainFrame.markbuts[i]:SetPoint("TOPLEFT", mainFrame.edges[1], (i-1)*28, -4)		
		end
		
		mainFrame.start:SetSize(50,12)
		mainFrame.start:SetPoint("TOPLEFT", mainFrame.edges[2], 0, -4)
		mainFrame.del:SetSize(50,12)
		mainFrame.del:SetPoint("TOPLEFT", mainFrame.edges[2], 0, -18)
		
		mainFrame.wmarksbuts:SetPoint("TOPLEFT", mainFrame.edges[3], 0, -4)
		for i=1,module.db.WMcount do
			mainFrame.wmarksbuts[i]:SetPoint("TOPLEFT", floor((i-1)/2)*14, -((i-1)%2)*13)
		end
		
		mainFrame.wmarksbuts.b:SetSize(123+19*(module.db.WMcount == 9 and 3 or 0),26)
		mainFrame.wmarksbuts.b:SetPoint("TOPLEFT", mainFrame,"BOTTOMLEFT",20, 3)
		for i=1,module.db.WMcount do
			mainFrame.wmarksbuts.b[i]:SetPoint("TOPLEFT", 19*(i-1)+6, -4)
		end
		
		mainFrame.readyCheck:SetSize(40,12)
		mainFrame.readyCheck:SetPoint("TOPLEFT",mainFrame.edges[4],0,-4)
		mainFrame.pull:SetSize(40,12)
		mainFrame.pull:SetPoint("TOPLEFT",mainFrame.edges[4],0, -18)
		--/Horizontal
	
		local posX = 4
		local totalWidth = 8
		
		mainFrame.edges[1]:SetPoint("TOPLEFT",4,0)
		if not VExRT.MarksBar.Show[1] then
			for i=1,8 do
				mainFrame.markbuts[i]:Hide()
			end
		else
			for i=1,8 do
				mainFrame.markbuts[i]:Show()
			end
			
			posX = posX + 222
			totalWidth = totalWidth + 222
		end
	
		mainFrame.edges[3]:SetPoint("TOPLEFT",posX,0)
		if not VExRT.MarksBar.Show[3] or not VExRT.MarksBar.wmKind then
			mainFrame.wmarksbuts:Hide()
		elseif VExRT.MarksBar.Show[3] and VExRT.MarksBar.wmKind then
			mainFrame.wmarksbuts:Show()
			
			posX = posX + 14*ceil(module.db.WMcount / 2)
			totalWidth = totalWidth + 14*ceil(module.db.WMcount / 2)
		end
	
		mainFrame.edge:Show()
		mainFrame:SetBackdropColor(0,0,0,0.8)
		if not VExRT.MarksBar.wmKind and VExRT.MarksBar.Show[3] then
			mainFrame.wmarksbuts.b:Show()
			if not (VExRT.MarksBar.Show[1] or VExRT.MarksBar.Show[2] or VExRT.MarksBar.Show[4]) then
				mainFrame.edge:Hide()
				mainFrame:SetBackdropColor(0,0,0,0)
			end
		else
			mainFrame.wmarksbuts.b:Hide()
		end
		
		mainFrame.edges[2]:SetPoint("TOPLEFT",posX,0)
		if not VExRT.MarksBar.Show[2] then
			mainFrame.start:Hide()
			mainFrame.del:Hide()
		else
			mainFrame.start:Show()
			mainFrame.del:Show()
			
			posX = posX + 51
			totalWidth = totalWidth + 51
		end
	
		mainFrame.edges[4]:SetPoint("TOPLEFT",posX,0)
		if not VExRT.MarksBar.Show[4] then
			mainFrame.readyCheck:Hide()
			mainFrame.pull:Hide()
		else
			mainFrame.readyCheck:Show()
			mainFrame.pull:Show()
			
			posX = posX + 40
			totalWidth = totalWidth + 40
		end
		if not (VExRT.MarksBar.Show[1] or VExRT.MarksBar.Show[2] or VExRT.MarksBar.Show[3] or VExRT.MarksBar.Show[4]) or not VExRT.MarksBar.enabled then
			mainFrame:Hide()
		else
			mainFrame:Show()
		end
	
		mainFrame:SetSize(totalWidth,34)
	else
		--Vertical
		for i=1,8 do
			mainFrame.markbuts[i]:SetPoint("TOPLEFT", mainFrame.edges[1], 4, -(i-1)*28)		
		end
		
		mainFrame.start:SetSize(26,12)
		mainFrame.start:SetPoint("TOPLEFT", mainFrame.edges[2], 4, 0)
		mainFrame.del:SetSize(26,12)
		mainFrame.del:SetPoint("TOPLEFT", mainFrame.edges[2], 4, -14)
		
		mainFrame.wmarksbuts:SetPoint("TOPLEFT", mainFrame.edges[3], 4, 0)
		for i=1,module.db.WMcount do
			mainFrame.wmarksbuts[i]:SetPoint("TOPLEFT", ((i-1)%2)*13, -floor((i-1)/2)*14)
		end
		
		mainFrame.wmarksbuts.b:SetSize(26,123+19*(module.db.WMcount == 9 and 3 or 0))
		mainFrame.wmarksbuts.b:SetPoint("TOPLEFT", mainFrame,"TOPRIGHT",-3,-20)
		for i=1,module.db.WMcount do
			mainFrame.wmarksbuts.b[i]:SetPoint("TOPLEFT", 4, -19*(i-1)-6)
		end
		
		mainFrame.readyCheck:SetSize(26,12)
		mainFrame.readyCheck:SetPoint("TOPLEFT",mainFrame.edges[4],4,0)
		mainFrame.pull:SetSize(26,12)
		mainFrame.pull:SetPoint("TOPLEFT",mainFrame.edges[4],4, -14)
		--/Vertical
	
		local posX = 4
		local totalWidth = 8
		
		mainFrame.edges[1]:SetPoint("TOPLEFT",0,-posX)
		if not VExRT.MarksBar.Show[1] then
			for i=1,8 do
				mainFrame.markbuts[i]:Hide()
			end
		else
			for i=1,8 do
				mainFrame.markbuts[i]:Show()
			end
			
			posX = posX + 224
			totalWidth = totalWidth + 224
		end
	
		mainFrame.edges[3]:SetPoint("TOPLEFT",0,-posX)
		if not VExRT.MarksBar.Show[3] or not VExRT.MarksBar.wmKind then
			mainFrame.wmarksbuts:Hide()
		elseif VExRT.MarksBar.Show[3] and VExRT.MarksBar.wmKind then
			mainFrame.wmarksbuts:Show()
			
			posX = posX + 14*ceil(module.db.WMcount / 2)
			totalWidth = totalWidth + 14*ceil(module.db.WMcount / 2)
		end
	
		mainFrame.edge:Show()
		mainFrame:SetBackdropColor(0,0,0,0.8)
		if not VExRT.MarksBar.wmKind and VExRT.MarksBar.Show[3] then
			mainFrame.wmarksbuts.b:Show()
			if not (VExRT.MarksBar.Show[1] or VExRT.MarksBar.Show[2] or VExRT.MarksBar.Show[4]) then
				mainFrame.edge:Hide()
				mainFrame:SetBackdropColor(0,0,0,0)
			end
		else
			mainFrame.wmarksbuts.b:Hide()
		end
		
		mainFrame.edges[2]:SetPoint("TOPLEFT",0,-posX)
		if not VExRT.MarksBar.Show[2] then
			mainFrame.start:Hide()
			mainFrame.del:Hide()
		else
			mainFrame.start:Show()
			mainFrame.del:Show()
			
			posX = posX + 26
			totalWidth = totalWidth + 26
		end
	
		mainFrame.edges[4]:SetPoint("TOPLEFT",0,-posX)
		if not VExRT.MarksBar.Show[4] then
			mainFrame.readyCheck:Hide()
			mainFrame.pull:Hide()
		else
			mainFrame.readyCheck:Show()
			mainFrame.pull:Show()
			
			posX = posX + 26
			totalWidth = totalWidth + 26
		end
		if not (VExRT.MarksBar.Show[1] or VExRT.MarksBar.Show[2] or VExRT.MarksBar.Show[3] or VExRT.MarksBar.Show[4]) or not VExRT.MarksBar.enabled then
			mainFrame:Hide()
		else
			mainFrame:Show()
		end
	
		mainFrame:SetSize(34,totalWidth)
	end
	if VExRT.MarksBar.DisableOutsideRaid then
		module:GroupRosterUpdate()
	end
end

local function EnableMarksBar()
	VExRT.MarksBar.enabled = true
	module.frame:Show()
	module:RegisterEvents('RAID_TARGET_UPDATE')
	if VExRT.MarksBar.DisableOutsideRaid then
		module:RegisterEvents('GROUP_ROSTER_UPDATE')
		module:GroupRosterUpdate()
	end
end
local function DisableMarksBar()
	VExRT.MarksBar.enabled = nil
	module.frame:Hide()
	module:UnregisterEvents('RAID_TARGET_UPDATE','GROUP_ROSTER_UPDATE')
end

function module.options:Load()
	self:CreateTilte()

	self.chkEnable = ExRT.lib.CreateCheckBox(self,nil,10,-35,ExRT.L.senable,VExRT.MarksBar.enabled,"/rt mb")
	self.chkEnable.On = EnableMarksBar
	self.chkEnable.Off = DisableMarksBar
	
	self.chkFix = ExRT.lib.CreateCheckBox(self,nil,300,-35,ExRT.L.messagebutfix)
	self.chkFix:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.MarksBar.Fix = true
			ExRT.mds.LockMove(module.frame,nil,nil,1)
		else
			VExRT.MarksBar.Fix = nil
			ExRT.mds.LockMove(module.frame,true,nil,1)
		end
	end)
	
	self.chkVertical = ExRT.lib.CreateCheckBox(self,nil,10,-130,ExRT.L.MarksBarVertical,VExRT.MarksBar.Vertical)
	self.chkVertical:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.MarksBar.Vertical = true
		else
			VExRT.MarksBar.Vertical = nil
		end
		modifymarkbars()
	end)
	
	self.TabViewOptions = ExRT.lib.CreateOneTab(self,605,115,"TOP",0,-160)
	
	self.html1 = ExRT.lib.CreateText(self,100,25,nil,120,-46,nil,"TOP",nil,11,"/rt mm")

	self.chkEnable1 = ExRT.lib.CreateCheckBox(self.TabViewOptions,nil,10,-5,ExRT.L.marksbarshowmarks)
	self.chkEnable1:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.MarksBar.Show[1]=true
		else
			VExRT.MarksBar.Show[1]=nil
		end
		modifymarkbars()
	end)
	
	self.chkEnable2 = ExRT.lib.CreateCheckBox(self.TabViewOptions,nil,10,-30,ExRT.L.marksbarshowpermarks)
	self.chkEnable2:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.MarksBar.Show[2]=true
		else
			VExRT.MarksBar.Show[2]=nil
		end
		modifymarkbars()
	end)
	
	self.chkEnable3 = ExRT.lib.CreateCheckBox(self.TabViewOptions,nil,10,-55,ExRT.L.marksbarshowfloor)
	self.chkEnable3:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.MarksBar.Show[3]=true
		else
			VExRT.MarksBar.Show[3]=nil
		end
		modifymarkbars()
	end)
	
	self.chkEnable3kindhtml = ExRT.lib.CreateText(self.TabViewOptions,100,18,nil,300,-66,nil,"TOP",nil,11,ExRT.L.marksbarWMView)
	
	self.chkEnable3kind1 = CreateFrame("CheckButton",nil,self.TabViewOptions,"UIRadioButtonTemplate")  
	self.chkEnable3kind1:SetPoint("TOPLEFT", 380, -65)
	self.chkEnable3kind1.text:SetText("1")
	self.chkEnable3kind1:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		module.options.chkEnable3kind2:SetChecked(false)
		VExRT.MarksBar.wmKind = true
		modifymarkbars()
	end)
	
	self.chkEnable3kind2 = CreateFrame("CheckButton",nil,self.TabViewOptions,"UIRadioButtonTemplate")  
	self.chkEnable3kind2:SetPoint("TOPLEFT", 420, -65)
	self.chkEnable3kind2.text:SetText("2")
	self.chkEnable3kind2:SetScript("OnClick", function(self,event) 
		self:SetChecked(true)
		module.options.chkEnable3kind1:SetChecked(false)
		VExRT.MarksBar.wmKind = nil
		modifymarkbars()
	end)
	
	self.chkEnable4 = ExRT.lib.CreateCheckBox(self.TabViewOptions,nil,10,-80,ExRT.L.marksbarshowrcpull)
	self.chkEnable4:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.MarksBar.Show[4]=true
		else
			VExRT.MarksBar.Show[4]=nil
		end
		modifymarkbars()
	end)
	
	self.SliderScale = ExRT.lib.CreateSlider(self,550,15,0,-75,5,200,ExRT.L.marksbarscale,100,"TOP")
	self.SliderScale:SetScript("OnValueChanged", function(self,event) 
		event = event - event%1
		VExRT.MarksBar.Scale = event
		ExRT.mds.SetScaleFix(module.frame,event/100)
		self.tooltipText = event
		self:tooltipReload(self)
	end)
	
	self.SliderAlpha = ExRT.lib.CreateSlider(self,550,15,0,-108,0,100,ExRT.L.marksbaralpha,nil,"TOP")
	self.SliderAlpha:SetScript("OnValueChanged", function(self,event) 
		event = event - event%1
		VExRT.MarksBar.Alpha = event
		module.frame:SetAlpha(event/100)
		self.tooltipText = event
		self:tooltipReload(self)
	end)
	
	
	self.htmlTimer = ExRT.lib.CreateText(self,150,18,nil,14,-281,nil,"TOP",nil,11,ExRT.L.marksbartmr)

	self.editBoxTimer = ExRT.lib.CreateEditBox(self,120,24,nil,143,-275,nil,6,true,nil,"10")
	self.editBoxTimer:SetScript("OnTextChanged",function(self)
		VExRT.MarksBar.pulltimer = tonumber(self:GetText()) or 10
	end)  
	
	self.chkDisableInRaid = ExRT.lib.CreateCheckBox(self,nil,10,-296,ExRT.L.MarksBarDisableInRaid,VExRT.MarksBar.DisableOutsideRaid)
	self.chkDisableInRaid:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.MarksBar.DisableOutsideRaid = true
			if VExRT.MarksBar.enabled then
				module:GroupRosterUpdate()
			end
		else
			VExRT.MarksBar.DisableOutsideRaid = nil
			if VExRT.MarksBar.enabled and not module.frame:IsShown() then
				module.frame:Show()
			end
		end
	end)
	
	self.ButtonToCenter = ExRT.lib.CreateButton(self,255,22,nil,10,-330,ExRT.L.MarksBarResetPos,nil,ExRT.L.MarksBarResetPosTooltip)
	self.ButtonToCenter:SetScript("OnClick",function()
		VExRT.MarksBar.Left = nil
		VExRT.MarksBar.Top = nil

		module.frame:ClearAllPoints()
		module.frame:SetPoint("CENTER",UIParent, "CENTER", 0, 0)
	end) 
	
	self.shtml1 = ExRT.lib.CreateText(self,605,200,nil,10,-365,nil,"TOP",nil,12,ExRT.L.MarksBarHelp)

	self.chkEnable1:SetChecked(VExRT.MarksBar.Show[1])
	self.chkEnable2:SetChecked(VExRT.MarksBar.Show[2])
	self.chkEnable3:SetChecked(VExRT.MarksBar.Show[3])
	self.chkEnable4:SetChecked(VExRT.MarksBar.Show[4])
	self.chkEnable3kind1:SetChecked(VExRT.MarksBar.wmKind)
	self.chkEnable3kind2:SetChecked(not VExRT.MarksBar.wmKind)

	self.editBoxTimer:SetText(VExRT.MarksBar.pulltimer)
	self.editBoxTimer:SetCursorPosition(0)

	self.chkFix:SetChecked(VExRT.MarksBar.Fix)

	if VExRT.MarksBar.Alpha then self.SliderAlpha:SetValue(VExRT.MarksBar.Alpha) end
	if VExRT.MarksBar.Scale then self.SliderScale:SetValue(VExRT.MarksBar.Scale) end
end

function module.main:ADDON_LOADED()
	VExRT = _G.VExRT
	VExRT.MarksBar = VExRT.MarksBar or {}

	if VExRT.MarksBar.Left and VExRT.MarksBar.Top then
		module.frame:ClearAllPoints()
		module.frame:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",VExRT.MarksBar.Left,VExRT.MarksBar.Top)
	end

	VExRT.MarksBar.Show = VExRT.MarksBar.Show or {true,true,true,true}

	modifymarkbars()

	if VExRT.MarksBar.enabled then
		EnableMarksBar()
	end

	VExRT.MarksBar.pulltimer = VExRT.MarksBar.pulltimer or 10

	if VExRT.MarksBar.Fix then ExRT.mds.LockMove(module.frame,nil,nil,1) end

	if VExRT.MarksBar.Alpha then module.frame:SetAlpha(VExRT.MarksBar.Alpha/100) end
	if VExRT.MarksBar.Scale then module.frame:SetScale(VExRT.MarksBar.Scale/100) end
	
	module:RegisterSlash()
end

function module.main:RAID_TARGET_UPDATE()
	if GetTime()-module.db.clearnum<5 and GetRaidTargetIndex("player") == 8 then
		SetRaidTarget("player", 0)
		module.db.clearnum = -1
	end
end

function module:GroupRosterUpdate()
	local n = GetNumGroupMembers() or 0
	if n == 0 and module.frame:IsShown() then
		module.frame:Hide()
	elseif n > 0 and not module.frame:IsShown() then
		module.frame:Show()
	end
end
function module.main:GROUP_ROSTER_UPDATE()
	ExRT.mds.ScheduleTimer(module.GroupRosterUpdate,1)
end

function module:slash(arg)
	if arg == "mm" or arg == "mb" then
		if not VExRT.MarksBar.enabled then
			EnableMarksBar()
		else
			DisableMarksBar()
		end
		if module.options.chkEnable then
			module.options.chkEnable:SetChecked(VExRT.MarksBar.enabled)
		end
	end
end