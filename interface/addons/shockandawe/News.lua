if not ShockAndAwe then return end

--- Many thanks to Dennis Hafstrom for the idea (and the code) for this News frame (lifted from Enhancer)

local _G = getfenv(0)
local LibStub = _G["LibStub"]
local L = LibStub("AceLocale-3.0"):GetLocale("ShockAndAwe")

local format, len = _G.string.format, _G.string.len
local gsub, trim = _G.string.gsub, _G.strtrim

ShockAndAwe.newsCurrent = 3 -- Can only ever increase

function ShockAndAwe:AddNewsStory(article)
	ShockAndAwe.newsFrame:AddLine("Introduction", "Welcome to ShockAndAwe and Enhancement Shammy max dps addon. ")
	ShockAndAwe.newsFrame:AddLine("", "This addon was written to enhance Enhancement shamans dps and build on the")
	ShockAndAwe.newsFrame:AddLine("", "work done with DisqoDice. Its aim is to provide a fully configurable addon")
	ShockAndAwe.newsFrame:AddLine("", "you can adjust to suit your own particular UI layout. Use /saa config to")
	ShockAndAwe.newsFrame:AddLine("", "access the configuration menu")
	ShockAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("Timer Bars", "There are bars for Maelstrom Weapon, Shocks, Shields, Stormstrike,")
	ShockAndAwe.newsFrame:AddLine("", "Windfury, Lava Lash and Global cooldown. You can change their colours, ")
	ShockAndAwe.newsFrame:AddLine("", "textures, scale the frame and change its width in the config options. As")
	ShockAndAwe.newsFrame:AddLine("", "well as turning them on or off. You can also configure the Maelstrom sounds")
	ShockAndAwe.newsFrame:AddLine("", "to play on 4 and 5 stacks, as well as configuring the maelstrom bar to flash ")
	ShockAndAwe.newsFrame:AddLine("", "when 5 stacks are achieved. If you wish you can also configure the bars to ")
	ShockAndAwe.newsFrame:AddLine("", "hide when out of combat, and you can display icons next to each bar to help")
	ShockAndAwe.newsFrame:AddLine("", "you remember which is which.")
	ShockAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("Priority Frame", "The priority frame comes with default configuration options. You can")
	ShockAndAwe.newsFrame:AddLine("", "change these to whatever priority of skills you want to use. The default")
	ShockAndAwe.newsFrame:AddLine("", "is set to use Lightning bolt on 5 maelstrom, StormStrike, Earth Shock,")
	ShockAndAwe.newsFrame:AddLine("", "Lava Lash. You can also turn on and off the ability to show Shamanistic")
	ShockAndAwe.newsFrame:AddLine("", "rage on low mana, and availability of your feral spirits. You can also choose")
	ShockAndAwe.newsFrame:AddLine("", "to display the maelstrom weapon stacks as 'combo points' on the")
	ShockAndAwe.newsFrame:AddLine("", "priority frame.")
	ShockAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("Uptime Frame", "The optional uptime frame will show you the percentage uptime each of your")
	ShockAndAwe.newsFrame:AddLine("", "main buffs was present for. This shows your data since last login/reload and")
	ShockAndAwe.newsFrame:AddLine("", "the data from the last fight. There is a reset session button to clear data")
	ShockAndAwe.newsFrame:AddLine("", "so far this session.")
	ShockAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("Export to Sim", "You can use the /saa export command to export your paper doll")
	ShockAndAwe.newsFrame:AddLine("", "stats to the EnhSim enhancement shammy simulator which is available for")
	ShockAndAwe.newsFrame:AddLine("", "download at http://code.google.com/p/enhsim/downloads/list")
	ShockAndAwe.newsFrame:AddLine("", "To use this open the config.txt file from EnhSim in wordpad or similar")
	ShockAndAwe.newsFrame:AddLine("", "editor (notepad doesn't work) and find the section at the end of the config" )
	ShockAndAwe.newsFrame:AddLine("", " filewhich tells you to replace that data with the data pasted from")
	ShockAndAwe.newsFrame:AddLine("", "ShockAndAwe. Once you delete the old data switch to WoW and simply ")
	ShockAndAwe.newsFrame:AddLine("", "type /saa export and press ctrl-c when the frame opens,then go back to ")
	ShockAndAwe.newsFrame:AddLine("", "your text editor and paste the data into the file at the end. Save this new")
	ShockAndAwe.newsFrame:AddLine("", "config file eg: I use Levva.txt and the run the sim.")
	ShockAndAwe.newsFrame:AddLine("","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("","Use EnhSimGUI.exe if you want to change other things like buffs etc. as the")
	ShockAndAwe.newsFrame:AddLine("", "visual display of the settings is easier to use if you are not sure what")
	ShockAndAwe.newsFrame:AddLine("", "to do. The Simulate button will give your expected DPS and the ")
	ShockAndAwe.newsFrame:AddLine("", "Calculate EP values button will calculate what stats eg:AP/Crit to look for")
	ShockAndAwe.newsFrame:AddLine("", "when you are looking for new gear. The higher the EP number the sim")
	ShockAndAwe.newsFrame:AddLine("", "calculates the more you need that stat.")
	ShockAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("Keybindings", "You can also use ShockAndAwe to keybind your Water Shield and")
	ShockAndAwe.newsFrame:AddLine("", " Lightning Shields, as well as keybinding your main and off hand weapon buffs.")
	ShockAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("General","Windfury & Stormstrike cumulative totals can be shown in Scrolling")
	ShockAndAwe.newsFrame:AddLine("","Combat text addon or in a default warning frame. ")
	ShockAndAwe.newsFrame:AddLine("","All of the frames in ShockAndAwe can be moved using /saa moveframes")
	ShockAndAwe.newsFrame:AddLine("","There are dozens and dozens of configurable options in ShockAndAwe use")
	ShockAndAwe.newsFrame:AddLine("","/saa config to view them all")
	ShockAndAwe.newsFrame:AddLine("","ShockAndAwe can warn you if you enter combat without your weapon buffs,")
	ShockAndAwe.newsFrame:AddLine("","it can also be configured to warn you when your shield and weapon buffs ")
	ShockAndAwe.newsFrame:AddLine("","expire. You can view this news at any time by typing /saa news")
	ShockAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	ShockAndAwe.newsFrame:AddLine("Bugs", "Please also report any bugs you find to the website below. However")
	ShockAndAwe.newsFrame:AddLine("", "before you post a bug report PLEASE do a /saa version and quote the")
	ShockAndAwe.newsFrame:AddLine("", "full version number when you post a bug. A report without a version")
	ShockAndAwe.newsFrame:AddLine("", "number is practically useless.")
end

function ShockAndAwe:News(override)
	if (not override and ((self.db.char.newsitem or 0) >= self.newsCurrent)) then return; end
	self:CreateNewsFrame()
	tinsert(UISpecialFrames, "AddOnNewsFrame")
	self.newsFrame:Clear()
	self.newsFrame.title:SetText("|cffffd200ShockAndAwe|r")
	
	self:AddNewsStory(self.db.char.newsitem)
	-------- max length for "subject    ","body"---------------------------------------------------
	self.newsFrame:AddLine("            ","") -- Some spacing
	self.newsFrame:AddLine("            ","")
	
	self.newsFrame:AddLine(L["Config"], L["help1"])
	self.newsFrame:AddLine("", L["help2"])
	self.newsFrame:AddLine("", L["help_command"])
	self.newsFrame:AddLine("            ","")
	self.newsFrame:AddLine(L["Website"], self:SpamSafe(L["__URL__"]))
	
	self:PopulateNewsFrame(1)
	self.newsFrame:Show()
	self.db.char.newsitem = self.newsCurrent
end

function ShockAndAwe:SpamSafe(text)
	-- replace ' [dot] ' with '.' and ' [at] ' with '@'
	return gsub(gsub(text, " %[at%] ", "@"), " %[dot%] ", ".")
end

function ShockAndAwe:CreateNewsFrame()
	self.newsFrame = CreateFrame("Frame", "AddOnNewsFrame", UIParent, "DialogBoxFrame")
	self.newsFrame:ClearAllPoints()
	self.newsFrame:SetWidth(1000)
	self.newsFrame:SetHeight(400)
	self.newsFrame:SetPoint("CENTER")
	self.newsFrame:SetBackdrop({
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
	    edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	    tile = true, tileSize = 16, edgeSize = 16,
	    insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	self.newsFrame:SetBackdropColor(0,0,0,1)
	
	local text = self.newsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
	text:SetFont([[Interface\AddOns\ShockAndAwe\fonts\CAS_ANTN.TTF]], 24, "OUTLINE") -- http://wdnaddons.com/2307561/FrameXML/Fonts.xml
	self.newsFrame.title = text
	text:SetPoint("TOP", 0, -10)
	self.newsFrame:Hide()
	self.newsFrame:EnableMouse(true)
	self.newsFrame:SetMovable(true);
	self.newsFrame:RegisterForDrag("LeftButton");
	self.newsFrame:SetScript("OnDragStart", function() self.newsFrame:StartMoving() end)
	self.newsFrame:SetScript("OnDragStop", function() self.newsFrame:StopMovingOrSizing() end)
	self.newsFrame.scroll = CreateFrame("ScrollFrame", "AddOnNewsScrollFrame", self.newsFrame, "FauxScrollFrameTemplate")
	self.newsFrame.scroll:SetParent(self.newsFrame)
	self.newsFrame.scroll:ClearAllPoints()
	self.newsFrame.scroll:SetWidth(520)
	self.newsFrame.scroll:SetHeight(320) -- 20 entries a 16 px
	self.newsFrame.scroll:SetPoint("TOPLEFT", self.newsFrame, "TOPLEFT", 0, -10)
	
	local function updateScroll()
		self:NewsFrameScroll()
	end

	self.newsFrame.scroll:SetScript("OnVerticalScroll",
		function(self, offset)
			FauxScrollFrame_OnVerticalScroll(self, offset, 16, updateScroll)
		end )
	self.newsFrame.scroll:SetScript("OnShow", function() ShockAndAwe:NewsFrameScroll() end )

	self.newsFrame.lefts = {}
	self.newsFrame.rights = {}
	self.newsFrame.textLefts = {}
	self.newsFrame.textRights = {}
	function ShockAndAwe.newsFrame:Clear()
		self.title:SetText("")
		self.disclaimer:SetText("")
		for i = 1, #self.lefts do
			self.lefts[i] = nil
			self.rights[i] = nil
		end
	end
	
	local function rightColor(right)
		-- Email color as link
		right = gsub(right, "[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?", function(v) return "|cff007fff"..v.."|r"; end)
		
		-- URL color as link (is crap need better URL matching)
		right = gsub(right, "http%:%/%/[A-Za-z0-9%.%/%-]+", function(v) return "|cff007fff"..v.."|r"; end)
		
		-- '-quoted color gray
		right = gsub(right, "(%')(%/%w-%s?%w-)(%')", function(v1, v2, v3) return v1.."|cffcccccc"..v2.."|r"..v3; end) --00ff7f
		
		-- *) lists
		right = gsub(right, "^(%*%)%s)(.+)", function(v1, v2) return "|cff00cccc"..v1.."|r"..v2; end)
		
		-- return the mess
		return right
	end

	function ShockAndAwe.newsFrame:AddLine(left, right)
		ShockAndAwe.newsFrame.lefts[#ShockAndAwe.newsFrame.lefts+1] = trim(left)
		ShockAndAwe.newsFrame.rights[#ShockAndAwe.newsFrame.rights+1] = rightColor(trim(right))
	end
	ShockAndAwe.newsFrame:Hide()
	
	local disclaimer = ShockAndAwe.newsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	disclaimer:SetFont([[Interface\AddOns\ShockAndAwe\fonts\Cella.ttf]], 8, "")
	ShockAndAwe.newsFrame.disclaimer = disclaimer
	disclaimer:SetPoint("BOTTOMRIGHT", ShockAndAwe.newsFrame:GetName(), "BOTTOMRIGHT", -5, 5)
	
	ShockAndAwe.CreateNewsFrame = function() return; end;
end

function ShockAndAwe:PopulateNewsFrame(startline)
	local textHeight = 0
	local endline = startline + 19
	local textline = 0
	if endline > #self.newsFrame.lefts then
		endline = #self.newsFrame.lefts
	end
	for i = startline, endline do
		textline = i - startline + 1
		if not self.newsFrame.textLefts[textline] then
			local left = ShockAndAwe.newsFrame.scroll:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			left:SetFont([[Interface\AddOns\ShockAndAwe\fonts\CAS_ANTN.TTF]], 16, "OUTLINE")
			self.newsFrame.textLefts[textline] = left
			local right = ShockAndAwe.newsFrame.scroll:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
			right:SetFont([[Interface\AddOns\ShockAndAwe\fonts\Cella.ttf]], 14, "OUTLINE")
			self.newsFrame.textRights[textline] = right
			if textline == 1 then
				left:SetPoint("TOPRIGHT", ShockAndAwe.newsFrame.scroll, "TOPLEFT", 125, -35)
			else
				left:SetPoint("TOPRIGHT", self.newsFrame.textLefts[textline-1], "BOTTOMRIGHT", 0, -1)
			end
			right:SetPoint("LEFT", left, "RIGHT", 5, 0)
		end
		self.newsFrame.textLefts[textline]:SetText(self.newsFrame.lefts[i] .. ((len(self.newsFrame.lefts[i]) > 0 and len(strtrim(self.newsFrame.lefts[i])) > 0 and ":") or " "))
		self.newsFrame.textRights[textline]:SetText(self.newsFrame.rights[i])
		local leftWidth = self.newsFrame.textLefts[textline]:GetWidth()
		local rightWidth = self.newsFrame.textRights[textline]:GetWidth()
		textHeight = self.newsFrame.textLefts[textline]:GetHeight()
	end
	for i = textline + 1, 20 do
		if self.newsFrame.textLefts[i] then
			self.newsFrame.textLefts[i]:SetText('')
			self.newsFrame.textRights[i]:SetText('')
		end
	end
	self.newsFrame.scroll:SetWidth(960)
	self.newsFrame.scroll:SetHeight(20 * (textHeight + 1))
	self.newsFrame:SetWidth(1000)
	self.newsFrame:SetHeight(20 * (textHeight + 1) + 120)
	self.newsFrame.scroll:Show()
end

function ShockAndAwe:NewsFrameScroll()
	FauxScrollFrame_Update(self.newsFrame.scroll, #self.newsFrame.lefts, 20, 16) -- scrollframe, number in list, number to display, fontsize of line
	local startline = FauxScrollFrame_GetOffset(self.newsFrame.scroll)
	if startline > 0 then
		self:PopulateNewsFrame(startline)
	end
end