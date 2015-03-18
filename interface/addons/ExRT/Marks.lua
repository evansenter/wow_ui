local GlobalAddonName, ExRT = ...

local VExRT = nil

local module = ExRT.mod:New("Marks",ExRT.L.Marks,nil,true)

function module.main:ADDON_LOADED()
	VExRT = _G.VExRT
	VExRT.Marks = VExRT.Marks or {}
	VExRT.Marks.list = VExRT.Marks.list or {}
end

function module:Enable()
	module:RegisterTimer()
	module.Enabled = true
end
function module:Disable()
	module:UnregisterTimer()
	module.Enabled = nil
end

do
	local tmr = 0
	function module:timer(elapsed)
		tmr = tmr + elapsed
		if tmr > .5 then
			tmr = 0
			for i=1,8 do
				local name = VExRT.Marks.list[i]
				if name and UnitName(name) and GetRaidTargetIndex(name)~=i then
					SetRaidTargetIcon(name, i)
				end
			end
		end
	end
end

function module:SetName(markNum,name)
	if name == "" then
		name = nil
	end
	VExRT.Marks.list[markNum] = name
end

function module:GetName(markNum)
	return VExRT.Marks.list[markNum]
end

function module:ClearNames()
	for i=1,8 do
		VExRT.Marks.list[i] = nil
	end
end


function module.options:Load()
	local function MarksEditBoxTextChanged(self,isUser)
		if not isUser then
			return
		end
		local i = self._i
		local name = self:GetText()
		if name == "" then
			name = nil
		end
		VExRT.Marks.list[i] = name
	end

	self.namesEditBox = {}
	for i=1,8 do
		self.namesEditBox[i] = ExRT.lib.CreateEditBox(self,550,24,nil,45,-45-(i-1)*24,nil,nil,nil,true,VExRT.Marks.list[i])
		self.namesEditBox[i]._i = i
		self.namesEditBox[i]:SetScript("OnTextChanged",MarksEditBoxTextChanged)
		
		self.namesEditBox[i].icon = ExRT.lib.CreateIcon(self.namesEditBox[i],24,nil,0,0,"Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..i)
		ExRT.lib.SetPoint(self.namesEditBox[i].icon,"RIGHT",self.namesEditBox[i],"LEFT",-5,0)
	end

	self.showButton = ExRT.lib.CreateButton(self,550,22,"TOP",0,-15,ExRT.L.senable,nil,ExRT.L.MarksTooltip)
	self.showButton:SetScript("OnClick",function (self)
		if not module.Enabled then
			self:SetText(ExRT.L.MarksDisable)
			module:Enable()
		else
			self:SetText(ExRT.L.senable)
			module:Disable()
		end
	end)
	if module.Enabled then
		self.showButton:SetText(ExRT.L.MarksDisable)
	end
	self.showButton:SetScript("OnShow",function (self)
		if module.Enabled then
			self:SetText(ExRT.L.MarksDisable)
		else
			self:SetText(ExRT.L.senable)
		end
	end)
	
	self.showButton = ExRT.lib.CreateButton(self,550,22,"TOP",0,-250,ExRT.L.MarksClear)
	self.showButton:SetScript("OnClick",function ()
		module:ClearNames()
		for i=1,8 do
			self.namesEditBox[i]:SetText("")
		end
	end)
end