Reforgerade = LibStub("AceAddon-3.0"):NewAddon("Reforgerade", "AceConsole-3.0", "AceTimer-3.0")
local Reforgerade = Reforgerade
ReforgeradeSavedVariables = {}

--Local variables
local reforgeString
local reforgeTable = {}
local RfInfo = LibStub("LibReforgingInfo-1.0")
local debugPrint = false
local debugErrors = true
local firstRun = true

--from LibReforge
local SPI = 1
local DODGE = 2
local PARRY = 3
local HIT = 4
local CRIT = 5
local HASTE = 6
local EXP = 7
local MASTERY = 8

--from LibReforge
local StatNames = {
	ITEM_MOD_SPIRIT_SHORT,
	ITEM_MOD_DODGE_RATING_SHORT,
	ITEM_MOD_PARRY_RATING_SHORT,
	ITEM_MOD_HIT_RATING_SHORT,
	ITEM_MOD_CRIT_RATING_SHORT,
	ITEM_MOD_HASTE_RATING_SHORT,
	ITEM_MOD_EXPERTISE_RATING_SHORT,
	ITEM_MOD_MASTERY_RATING_SHORT
}
StatNames[0] = NONE
local StatToString = {
	"ITEM_MOD_SPIRIT_SHORT",
	"ITEM_MOD_DODGE_RATING_SHORT",
	"ITEM_MOD_PARRY_RATING_SHORT",
	"ITEM_MOD_HIT_RATING_SHORT",
	"ITEM_MOD_CRIT_RATING_SHORT",
	"ITEM_MOD_HASTE_RATING_SHORT",
	"ITEM_MOD_EXPERTISE_RATING_SHORT",
	"ITEM_MOD_MASTERY_RATING_SHORT"
}


local reforgequeue = {}
local reforgeParsers = {}

local reforgeTooltips = {}
local SlotNames = {
   "HeadSlot",
   "NeckSlot",
   "ShoulderSlot",
   "ShirtSlot",
   "ChestSlot",
   "WaistSlot",
   "LegsSlot",
   "FeetSlot",
   "WristSlot",
   "HandsSlot",
   "Finger0Slot",
   "Finger1Slot",
   "Trinket0Slot",
   "Trinket1Slot",
   "BackSlot",
   "MainHandSlot",
   "SecondaryHandSlot",
--   "RangedSlot",
   "TabardSlot",
}
local SlotIcons  = {}
for i = 1, 18 do
	SlotIcons[i] = select(2,GetInventorySlotInfo(SlotNames[i]))
end
local SlotOverlays = { reforged = "Interface\\RAIDFRAME\\ReadyCheck-Ready.png",
missingInformation = "Interface\\RAIDFRAME\\ReadyCheck-Waiting",
reforgeNeeded = "Interface\\RAIDFRAME\\ReadyCheck-NotReady",
}

local reforgeradeOptionsTable = {
  type = "group",
  args = {
    debugEnable = {
      name = "Show debugging messages",
      desc = "Enables / disables debugging",
      type = "toggle",
      set = function(info,val) debugPrint = val end,
      get = function(info) return debugPrint end,
	  width = "double",
    },
    debugErrors = {
      name = "Display Errors",
      desc = "Enables / disables displaying error messages",
      type = "toggle",
      set = function(info,val) debugErrors = val end,
      get = function(info) return debugErrors end,
	  width = "double",
    },
  }
}

function Reforgerade:ADDON_LOADED()
	Reforgerade:ResetEventHandlers()
	local position = 3
	for k,v in pairs(Reforgerade.EventDescriptions) do
		reforgeradeOptionsTable.args[k] = {name = Reforgerade.EventDescriptions[k],
		desc = Reforgerade.EventDescriptions.k,
		type = "select",
		values = Reforgerade.ActionDescriptions,
		get = function(info) return ReforgeradeSavedVariables.EventHandlers[info[#info]] end,
		set = function(info, value) ReforgeradeSavedVariables.EventHandlers[info[#info]] = value end,
		style  = "dropdown",
		width = "double",
		order = position,
		}
		position = position + 1
	end
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Reforgerade", reforgeradeOptionsTable)
	local optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Reforgerade")
	optionsFrame.default = function() Reforgerade:ResetEventHandlers(true) InterfaceOptionsFrame_OpenToCategory("Reforgerade") end
	
	Reforgerade:RegisterChatCommand("rfa", "ChatCommand")
	Reforgerade:RegisterChatCommand("reforgerade", "ChatCommand")
	
end

function Reforgerade:ChatCommand(parameter)
	if not parameter or parameter:trim() == "" then
		ReforgeradeInputFrame.frame:Show()
	else
		parameter = parameter:trim():lower()
		if parameter == "options" or parameter == "config" then
			InterfaceOptionsFrame_OpenToCategory("Reforgerade")
		end
	end	
end




function Reforgerade:DebugPrint(debugString)
	if (debugPrint) then
		self:Print("DEBUG: " .. debugString)
	end
end

function Reforgerade:ErrorPrint(errorString)
	if (debugErrors) then
		self:Print(RED_FONT_COLOR_CODE .. ERROR_CAPS .. ": " .. errorString .. FONT_COLOR_CODE_CLOSE)
	end
end


--Checks to make sure an item has the stat to reforge from and does not have the stat to reforge to
--If false a reason is provided as to why the reforge failed validation
function Reforgerade:IsValidReforge(item, from, to, silent)
	silent = silent or false --default to false if called with nil
	if not item or not from or not to then return false end
	self:DebugPrint("Checking "  .. item .. " " .. from .. " -> " .. to .. " for validity")
	if (GetItemInfo(item)) then
		if (from <= 8 and to <= 8) then
			local statTable = {}
			local itemFound = false
			for slotID = 1, 17 do
				local itemLink = GetInventoryItemLink("player", slotID)
				if itemLink then
					if itemLink:match(item:gsub("%-", "%%%-")) then  --hyphens need to be escaped with '%'.  '%' also needs to be escaped
						GetItemStats(itemLink, statTable)
						itemFound = true
						break
					end
				end
			end
			
			if not itemFound then
				return false, "Unable to find item stats for " .. item .. ". check to make sure it is equipped."
			end
			
			if ((statTable[StatToString[from]] ~= nil and statTable[StatToString[from]] > 0) or from == 0) then
				if (statTable[StatToString[to]] == nil) then
					return true
				else
					if (not silent) then
						self:DebugPrint(item .. " already has " .. StatNames[to] .. ". " .. StatNames[from] .. " -> " .. StatNames[to] .. " is an invalid reforge option.")
					end
					return false, item .. " already has " .. StatNames[to] .. ". " .. StatNames[from] .. " -> " .. StatNames[to] .. " is an invalid reforge option."
				end
			else
				if (not silent) then
					self:DebugPrint(item .. " does not have " .. StatNames[from] .. ". " .. StatNames[from] .. " -> " .. StatNames[to] .. " is an invalid reforge option.")
				end
				return false, item .. " does not have " .. StatNames[from] .. ". " .. StatNames[from] .. " -> " .. StatNames[to] .. " is an invalid reforge option."
			end
		else
			if (not silent) then
				self:DebugPrint("Invalid reforge IDs for " .. item)
			end
			return false
		end
	else
		if (not silent) then
			self:DebugPrint(item .. " appears to be an invalid item.")
		end
		return false, item .. " appears to be an invalid item name."
	end
end

function Reforgerade:BuildReforgeTable(silent)
	silent = silent or false --default to false if called with nil
	local reforgeString = ReforgeradeInputFrame.editBox:GetText()
	reforgeTable = {}
	local best = 0
	local parserName = nil
	local pickedParser = nil
	if next(reforgeParsers) ~= nil then
		for parserName, parserFunction in pairs(reforgeParsers) do --for each parser added to our list let them try parsing the data
			local parseAttempt = parserFunction(reforgeString)
			local validItems = 0
			local attemptedReforges = 0
			if (parseAttempt and next(parseAttempt) ~= nil) then
				for itemName,reforgeID in pairs(parseAttempt) do
					if (Reforgerade:IsValidReforge(itemName, reforgeID[1], reforgeID[2], silent)) then
						validItems = validItems + 1					
					end
					attemptedReforges = attemptedReforges + 1
				end
			end
			if (not silent) then
				self:DebugPrint(parserName .. " returned " .. validItems .. " valid item reforges")
			end
			if ((validItems > best) or (best == 0 and attemptedReforges > 0)) then
				best = validItems
				reforgeTable = parseAttempt
				pickedParser = parserName
			end
		end
		
		if next(reforgeTable) ~= nil then
			if (not silent) then
				self:DebugPrint("Picked parser: " .. pickedParser)
			end
			local finalizedTable = {}
			for itemName,reforgeID in pairs(reforgeTable) do
				for i = 1, #reforgeID /2 do
					local duplicateIndex = i-1
					local duplicateOffset = duplicateIndex * 2
					local valid, reason = Reforgerade:IsValidReforge(itemName, reforgeID[1 + duplicateOffset], reforgeID[2 + duplicateOffset], silent)
					if (valid) then
						if not finalizedTable[itemName] then
							finalizedTable[itemName] = {}
						end
						finalizedTable[itemName][1 + duplicateOffset] = reforgeID[1 + duplicateOffset]
						finalizedTable[itemName][2 + duplicateOffset] = reforgeID[2 + duplicateOffset]
					else
						if (firstRun) then
							if (reason) then
								self:ErrorPrint(reason)
							else
								self:ErrorPrint("Removing invalid reforge request for " .. itemName)
							end
						end
					end
				end
			end
			reforgeTable = finalizedTable
		else
			if not silent then
				self:ErrorPrint("Unable to parse input")
			end
		end
--~ 		for k,v in pairs(reforgeTable) do
--~ 			print("Finalized Reforge " .. k .. " from " .. v[1] .. " to " .. v[2])
--~ 		end
	else
		self:ErrorPrint("No reforge parsers found!")
	end
end

function Reforgerade:ReforgeScan(silent)
	
	silent = silent or false --default to false if called with nil
--~ 	if ReforgeradeInputFrame.frame:IsShown() == false then ReforgeradeInputFrame.frame:Show() return end
	Reforgerade:BuildReforgeTable(silent) --rebuild the list of want reforges
	reforgequeue = {} --clear the reforge queue
	local duplicateIndexs = {} --used for detecting duplicate item names (should only be a problem with rings, trinkets, and weapons, but covers all cases.)
	local itemChanged = false
	local reforgeCost = 0
	Reforgerade:RefreshEquipmentIcons()
	for i = 1, 17 do
--~ 	for i = 1, 2 do
		if i ~= 4 then --Skip the shirt slot
			local item = GetInventoryItemLink("player", i)
			if item then --if we have and item equiped in the slot and the slot is not the shirt or tabard slot
				local itemName = select(1,GetItemInfo(item))
				local WantReforgeFrom, WantReforgeTo
				if (reforgeTable[itemName] ~= nil) then
					duplicateOffset = duplicateIndexs[itemName] or 0
					WantReforgeFrom = reforgeTable[itemName][(1  + duplicateOffset *2)]
					WantReforgeTo = reforgeTable[itemName][(2 + duplicateOffset *2)]
	--~ 				self:Print(itemName .. " duplicate number " .. duplicateOffset .. " " .. 1  + duplicateOffset *2 .. " " .. 2  + duplicateOffset *2)
	--~ 				self:Print(WantReforgeFrom .. " " .. WantReforgeTo)
					if duplicateIndexs[itemName] then
						duplicateIndexs[itemName] = duplicateIndexs[itemName] + 1
					else
						duplicateIndexs[itemName] = 1
					end
					if WantReforgeFrom and WantReforgeTo then
						local CurrentReforgeFrom, CurrentReforgeTo
						if RfInfo:IsItemReforged(item) then
							CurrentReforgeFrom, CurrentReforgeTo = RfInfo:GetReforgedStatIDs(RfInfo:GetReforgeID(item))			
						end
						if (CurrentReforgeFrom == nil or CurrentReforgeTo == nil) then
							CurrentReforgeFrom = 0
							CurrentReforgeTo = 0
						end
				--~ 			self:Print(itemName .. " is reforged from " .. CurrentReforgeFrom .. " to " .. CurrentReforgeTo)
						if (CurrentReforgeFrom ~= WantReforgeFrom or CurrentReforgeTo ~= WantReforgeTo) then
							if (not silent) then
								self:Print(item .. " " .. REFORGE_CURRENT  .. ": " .. StatNames[CurrentReforgeFrom] .. " -> " .. StatNames[CurrentReforgeTo] .. ". Wanted: " .. StatNames[WantReforgeFrom] .. " -> " .. StatNames[WantReforgeTo] .. ".")
								itemChanged = true
							end
							
							tinsert(reforgequeue, {i, WantReforgeFrom, WantReforgeTo})
--~ 							Reforgerade:SetSlotOverlay(i, GetInventoryItemTexture("player", i))
							Reforgerade:SetSlotOverlay(i, SlotOverlays.reforgeNeeded)
							reforgeTooltips[ReforgeradeInputFrame.SlotOverlay[i]] = REFORGE_CURRENT .. ": " .. StatNames[CurrentReforgeFrom] .. " -> " .. StatNames[CurrentReforgeTo] .. "\n" .. NEED .. ": " .. StatNames[WantReforgeFrom] .. " -> " .. StatNames[WantReforgeTo]
							reforgeCost = max(reforgeCost + select(11,GetItemInfo(GetInventoryItemLink("player", i))), 10000) --Reforge cost is the vendor price or 1g
						else
							reforgeTooltips[ReforgeradeInputFrame.SlotOverlay[i]] = GREEN_FONT_COLOR_CODE .. REFORGED
							if (not silent) then
		--~ 	 					self:Print("No need to change reforging for " ..item)
							end
							Reforgerade:SetSlotOverlay(i, SlotOverlays.reforged)
						end
					end
				else
					Reforgerade:SetSlotOverlay(i, SlotOverlays.missingInformation)
					reforgeTooltips[ReforgeradeInputFrame.SlotOverlay[i]] = NO .. " " .. REFORGE .. " " .. GUILDINFOTAB_INFO
					if (not silent) then
						self:DebugPrint("Unable to find wanted reforge information for equiped item " .. item)
					end
				end
			else
				Reforgerade:SetSlotOverlay(i, SlotOverlays.missingInformation)
				reforgeTooltips[ReforgeradeInputFrame.SlotOverlay[i]] = NO .. " " .. REFORGE .. " " .. GUILDINFOTAB_INFO
				if (not silent) then
					self:DebugPrint("Unable to find wanted reforge information for slot " .. SlotNames[i])
				end
			end
		end
	end
	if (not silent) then
		if (itemChanged == false) then
			self:Print("Everything is already reforged.")
		end
	end
	ReforgeradeInputFrame.reforgeCostString:SetText(REFORGE .. " " .. COSTS_LABEL .. "\n" .. GetCoinTextureString(reforgeCost, 12))
end

local currentSlot = 0

function Reforgerade:ReforgeIt()
	Reforgerade:ReforgeScan(true)
--~ 	self:DebugPrint("Running ReforgingIt")
	if (#reforgequeue == 0 or reforgequeue == {} or reforgequeue == nil) then
		self:Print(REFORGE .. " " .. COMPLETE)
		Reforgerade:DoEvent("ReforgeFinished")
		firstRun = true
		if (ReforgingFrameItemButton and ReforgingFrameItemButton:IsVisible()) then
			ClearCursor()
			SetReforgeFromCursorItem() -- pick up the old item
			ClearCursor() --get rid of it
		end
		currentSlot = 0
		return
	end
	if (ReforgingFrame == nil  or ReforgingFrame:IsVisible() == nil) then
		self:ErrorPrint("Open the reforging frame")
		return
	end
	firstRun = false
	self:DebugPrint(#reforgequeue .. " items need to be reforged")
	for k, v in pairs(reforgequeue) do
--~ 		self:Print(v[1])
		--Pick up the item and place it in the reforge windo
		local itemSlot = v[1]
		local item = GetInventoryItemLink("player", itemSlot)
		if (currentSlot ~= itemSlot) then
			ClearCursor()
			SetReforgeFromCursorItem() -- pick up the old item
			ClearCursor() --get rid of it
			PickupInventoryItem(itemSlot)
			SetReforgeFromCursorItem()
			currentSlot = itemSlot
--~ 			self:DebugPrint("Placing " .. item .. " in the reforge window.")
		end
		local reforgeID
		if v[2] == 0 then
			reforgeID = 0
		else
			for i=1, GetNumReforgeOptions() do
				local from, _, _, to, _, _ = GetReforgeOptionInfo(i)
	--~ 			print(from .. " -> " .. to)
				if (StatNames[v[2]] == from and StatNames[v[3]] == to) then
					reforgeID = i
					break
				end
			end
		end
--~ 		self:DebugPrint("Found reforge combination reforge ID is " .. reforgeID)
		if reforgeID then
			self:DebugPrint("Reforging " .. item)
			ReforgeItem(reforgeID)
			Reforgerade:RetryReforge()
			return
		else
			self:ERRORPrint("Unable to find wanted reforge option for item " .. item)
		end
	end
	Reforgerade:RetryReforge()
end

function Reforgerade:RetryReforge()
	local waitTime = max(select(4, GetNetStats())*2, 250) -- Wait for 2x current latentcy or 250ms whichever is larger and do it again
--~ 	self:DebugPrint("Next action in " .. waitTime .. "ms")
	self:ScheduleTimer("ReforgeIt", waitTime/1000)  
end

function Reforgerade:RegisterParser(name, func)
	self:DebugPrint("Registering parser " .. name)
	reforgeParsers[name] = func
end





ReforgeradeInputFrame = {}
ReforgeradeInputFrame.frame = nil
ReforgeradeInputFrame.frame = CreateFrame("Frame", "ReforgeradeInputFrame", UIParent)
ReforgeradeInputFrame.frame:SetBackdrop({
		bgFile = "Interface\\FrameGeneral\\UI-Background-Marble",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = false, tileSize = 256, edgeSize = 16, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
ReforgeradeInputFrame.frame:SetClampedToScreen(true)
ReforgeradeInputFrame.frame:SetMovable(true)
ReforgeradeInputFrame.frame:EnableMouse(true)
ReforgeradeInputFrame.frame:RegisterForDrag("LeftButton")
ReforgeradeInputFrame.frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
ReforgeradeInputFrame.frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
ReforgeradeInputFrame.frame:SetScript("OnShow", function(self)
	Reforgerade:DoEvent("ReforgeradeShow")
	ReforgeradeInputFrame.editBox:SetFocus()
	ReforgeradeInputFrame.frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
end)
ReforgeradeInputFrame.frame:SetScript("OnHide", function(self)
	ReforgeradeInputFrame.frame:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	Reforgerade:DoEvent("ReforgeradeClosed")
end)

ReforgeradeInputFrame.titleString = ReforgeradeInputFrame.frame:CreateFontString("TitleString");
ReforgeradeInputFrame.titleString:SetFontObject("GameFontNormal")
ReforgeradeInputFrame.titleString:SetPoint("TOP", ReforgeradeInputFrame.frame, "TOP", -2, -9)
ReforgeradeInputFrame.titleString:SetText("Reforgerade")

ReforgeradeInputFrame.frame:SetWidth(400)
ReforgeradeInputFrame.frame:SetHeight(500)
ReforgeradeInputFrame.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
ReforgeradeInputFrame.frame:SetFrameStrata("HIGH")

ReforgeradeInputFrame.frame:RegisterEvent("GOSSIP_SHOW")
ReforgeradeInputFrame.frame:RegisterEvent("FORGE_MASTER_OPENED")
ReforgeradeInputFrame.frame:RegisterEvent("ADDON_LOADED")
ReforgeradeInputFrame.frame:RegisterEvent("FORGE_MASTER_CLOSED")
ReforgeradeInputFrame.frame:SetScript("OnEvent", function(self, event, ...)
	if event == "FORGE_MASTER_OPENED" then
		Reforgerade:DoEvent("ReforgeWindowOpen")
		return
	end
	if event == "FORGE_MASTER_CLOSED" then
		Reforgerade:DoEvent("ReforgeWindowClosed")
		return
	end
	if event == "ADDON_LOADED" then
		arg1  = ...
		if arg1 == "Reforgerade" then
			Reforgerade:ADDON_LOADED()
		end
		return
	end
	if event == "UNIT_INVENTORY_CHANGED" then
		if ReforgeradeInputFrame.frame:IsShown() then
			Reforgerade:ReforgeScan(true)
		end
		return
	end
end)

local scrollArea = CreateFrame("ScrollFrame", "ExportScroll", ReforgeradeInputFrame.frame, "UIPanelScrollFrameTemplate")

ReforgeradeInputFrame.editBox = CreateFrame("EditBox", "ReforgeradeEditBox", ReforgeradeInputFrame.frame)
ReforgeradeInputFrame.editBox:SetMultiLine(true)
ReforgeradeInputFrame.editBox:SetMaxLetters(99999)
ReforgeradeInputFrame.editBox:EnableMouse(true)
ReforgeradeInputFrame.editBox:SetAutoFocus(false)
ReforgeradeInputFrame.editBox:SetFontObject(ChatFontNormal)
ReforgeradeInputFrame.editBox:SetWidth(250)
ReforgeradeInputFrame.editBox:SetHeight(100)
ReforgeradeInputFrame.editBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
local lastEditTextLength = 0
ReforgeradeInputFrame.editBox:SetScript("OnTextChanged", function(self,isUserInput)
	if isUserInput then 
		if math.abs(#self:GetText() - lastEditTextLength) > 1 then --if more than 1 character was entered or deleted
			Reforgerade:DoEvent("TextPasted")
		else
--~ 			print("typed text")  --or 1 char deleted
		end
		lastEditTextLength = #self:GetText()
	else
		lastEditTextLength = #self:GetText()
	end 
 end
)

--~ ReforgeradeInputFrame.editBox:SetScript("OnMouseDown", function() ReforgeradeInputFrame.editBox:SetFocus() end)
--~ ReforgeradeInputFrame.frame:SetScript("OnMouseDown", function() ReforgeradeInputFrame.editBox:SetFocus() end)

scrollArea:SetPoint("TOPLEFT", ReforgeradeInputFrame.frame, "TOPLEFT", 55, -30)
scrollArea:SetPoint("BOTTOMRIGHT", ReforgeradeInputFrame.frame, "BOTTOMRIGHT", -75, 80)
scrollArea:SetScrollChild(ReforgeradeInputFrame.editBox)
scrollArea:SetScript("OnMouseDown", function(self,button) ReforgeradeInputFrame.editBox:SetFocus() end)
scrollArea:RegisterForDrag("LeftButton")
scrollArea:SetScript("OnDragStart", function(self) self:GetParent():StartMoving() end)
scrollArea:SetScript("OnDragStop", function(self) self:GetParent():StopMovingOrSizing() end)

local close = CreateFrame("Button", "ReforgeradeCloseButton", ReforgeradeInputFrame.frame, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", ReforgeradeInputFrame.frame, "TOPRIGHT")
close:SetHitRectInsets(6, 6, 6, 6)

--~ local config = CreateFrame("Button", "ReforgeradeConfigButton", ReforgeradeInputFrame.frame, "OptionsButtonTemplate")
local config = CreateFrame("Button", "ReforgeradeConfigButton", ReforgeradeInputFrame.frame)
--~ config:SetNormalTexture("Interface\\ICONS\\Trade_Engineering")
config:SetBackdrop( { 
					bgFile = "Interface\\ICONS\\Trade_Engineering", 
					edgeFile = "", tile = false, tileSize = 0, edgeSize = -2, 
					insets = { left = 6, right = 6, top = 6, bottom = 6 }
					});
config:SetHitRectInsets(6, 6, 6, 6 )
config:SetPoint("TOPRIGHT", close, "TOPLEFT", 5, 0)
config:SetScript("OnClick", function(self) InterfaceOptionsFrame_OpenToCategory("Reforgerade") end)
config:SetWidth(close:GetWidth())
config:SetHeight(close:GetHeight())
config:SetScript("OnEnter", function(self) 
	ReforgeradeInputFrame.Tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
	ReforgeradeInputFrame.Tooltip:SetText(CHAT_CONFIGURATION)
end)

config:SetScript("OnLeave", function(self) ReforgeradeInputFrame.Tooltip:Hide() end)

ReforgeradeInputFrame.reforgeCostString = ReforgeradeInputFrame.frame:CreateFontString("ReforgeradeCostString");
ReforgeradeInputFrame.reforgeCostString:SetFontObject("GameFontNormal")
ReforgeradeInputFrame.reforgeCostString:SetPoint("CENTER", ReforgeradeInputFrame.frame, "BOTTOMRIGHT", -65, 45)
ReforgeradeInputFrame.reforgeCostString:SetText(REFORGE .. " " .. COSTS_LABEL .. "\n" .. GetCoinTextureString(0, 12))

local ReforgeCompareButton = CreateFrame("Button", "ReforgeCompareButton", ReforgeradeInputFrame.frame, "OptionsButtonTemplate")
ReforgeCompareButton:SetPoint("BOTTOMRIGHT", ReforgeradeInputFrame.frame, "BOTTOM", 0, 5)
ReforgeCompareButton:SetText("Compare")
ReforgeCompareButton:SetScript("OnClick", function() Reforgerade:ReforgeScan(false) end)

local ReforgeItButton = CreateFrame("Button", "ReforgeItButton", ReforgeradeInputFrame.frame, "OptionsButtonTemplate")
ReforgeItButton:SetPoint("BOTTOMLEFT", ReforgeradeInputFrame.frame, "BOTTOM", 0, 5)
ReforgeItButton:SetText(REFORGE)
ReforgeItButton:SetScript("OnClick", function() firstRun = true currentSlot = 0 Reforgerade:ReforgeIt() end)

ReforgeradeInputFrame.Tooltip = CreateFrame("GameTooltip", "ReforgeradeTooltip", UIParent, "GameTooltipTemplate")
ReforgeradeInputFrame.Tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")


ReforgeradeInputFrame.SlotBackground = {}
ReforgeradeInputFrame.SlotOverlay = {}
for i=1, 18 do
	ReforgeradeInputFrame.SlotBackground[i] = CreateFrame("Frame", "ReforgeradeSlotBackground" .. i, ReforgeradeInputFrame.frame)
	ReforgeradeInputFrame.SlotBackground[i]:SetBackdrop( { 
		bgFile = SlotIcons[i], 
		edgeFile = "", tile = false, tileSize = 0, edgeSize = -1, 
		insets = { left = -2, right = -2, top = -2, bottom = -2 }
	});
	ReforgeradeInputFrame.SlotBackground [i]:SetWidth(40)
	ReforgeradeInputFrame.SlotBackground [i]:SetHeight(40)

	
	ReforgeradeInputFrame.SlotOverlay[i] = CreateFrame("Frame", "ReforgeradeSlotOverlay" .. i, ReforgeradeInputFrame.SlotBackground[i])
	ReforgeradeInputFrame.SlotOverlay[i]:SetWidth(ReforgeradeInputFrame.SlotBackground[i]:GetWidth())
	ReforgeradeInputFrame.SlotOverlay[i]:SetHeight(ReforgeradeInputFrame.SlotBackground[i]:GetHeight())
	ReforgeradeInputFrame.SlotOverlay[i]:SetPoint("TOPLEFT", ReforgeradeInputFrame.SlotBackground[i], "TOPLEFT")
	ReforgeradeInputFrame.SlotOverlay[i]:SetScript("OnEnter", function(self)
		if reforgeTooltips[self] then 
			ReforgeradeInputFrame.Tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			ReforgeradeInputFrame.Tooltip:SetText(reforgeTooltips[self])
		else
			ReforgeradeInputFrame.Tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			ReforgeradeInputFrame.Tooltip:SetText(NO .. " " .. REFORGE .. " " .. GUILDINFOTAB_INFO)
		end
	end
	)
	ReforgeradeInputFrame.SlotOverlay[i]:SetScript("OnMouseDown", function(self)
		if ReforgingFrame:IsVisible() then
			ClearCursor()
			PickupInventoryItem(i)
			SetReforgeFromCursorItem()
			ClearCursor()
		end
	end)	
	ReforgeradeInputFrame.SlotOverlay[i]:SetScript("OnLeave", function(self) ReforgeradeInputFrame.Tooltip:Hide() end)
end

reforgeTooltips[ReforgeradeInputFrame.SlotOverlay[4]] = ERR_REFORGE_INSUFFICIENT_SRC_STAT
reforgeTooltips[ReforgeradeInputFrame.SlotOverlay[18]] = ERR_REFORGE_INSUFFICIENT_SRC_STAT -- was 19

local IconPositions = {}
--First Column
IconPositions[1] = { ofsx = 10, ofsy = -30, relativePoint = "TOPLEFT" }
IconPositions[2] = { relativeTo = ReforgeradeInputFrame.SlotBackground[1] }
IconPositions[3] = { relativeTo = ReforgeradeInputFrame.SlotBackground[2] }
IconPositions[15] = { relativeTo = ReforgeradeInputFrame.SlotBackground[3] }
IconPositions[5] = { relativeTo = ReforgeradeInputFrame.SlotBackground[15] }
IconPositions[4] = { relativeTo = ReforgeradeInputFrame.SlotBackground[5] }
IconPositions[18] = { relativeTo = ReforgeradeInputFrame.SlotBackground[4] } -- was 19
IconPositions[9] = { relativeTo = ReforgeradeInputFrame.SlotBackground[18] } -- was 18
--Next Column
IconPositions[10] = { point = "TOPRIGHT", relativePoint = "TOPRIGHT", ofsx = -10, ofsy = -30}
IconPositions[6] = { relativeTo = ReforgeradeInputFrame.SlotBackground[10] }
IconPositions[7] = { relativeTo = ReforgeradeInputFrame.SlotBackground[6] }
IconPositions[8] = { relativeTo = ReforgeradeInputFrame.SlotBackground[7] }
IconPositions[11] = { relativeTo = ReforgeradeInputFrame.SlotBackground[8] }
IconPositions[12] = { relativeTo = ReforgeradeInputFrame.SlotBackground[11] }
IconPositions[13] = { relativeTo = ReforgeradeInputFrame.SlotBackground[12] }
IconPositions[14] = { relativeTo = ReforgeradeInputFrame.SlotBackground[13] }
--Weapons
IconPositions[16] = { point = "BOTTOMLEFT", relativePoint = "BOTTOMLEFT", ofsx = 156, ofsy = 30 } -- was ofsx = 132
IconPositions[17] = { relativeTo = ReforgeradeInputFrame.SlotBackground[16], relativePoint = "TOPRIGHT", ofsx = 8, ofsy = 0 }
--IconPositions[18] = { relativeTo = ReforgeradeInputFrame.SlotBackground[17], relativePoint = "TOPRIGHT", ofsx = 8, ofsy = 0 }

for i=1, 18 do  --Since incons are not displayed in order we have to set their parent frame after creating them
	ReforgeradeInputFrame.SlotBackground[i]:SetPoint(
		(IconPositions[i]["point"] or "TOPLEFT"), 
		(IconPositions[i]["relativeTo"] or ReforgeradeInputFrame.frame),
		(IconPositions[i]["relativePoint"] or "BOTTOMLEFT"),
		(IconPositions[i]["ofsx"] or 0),
		(IconPositions[i]["ofsy"] or -8)
		)
end

function Reforgerade:SetSlotOverlay(slot, icon)
	if not slot or not ReforgeradeInputFrame.SlotOverlay[slot] then return end
	ReforgeradeInputFrame.SlotOverlay[slot]:SetBackdrop({
		bgFile = icon, 
		edgeFile = "", tile = false, tileSize = 0, edgeSize = -1, 
		insets = { left = -2, right = -2, top = -2, bottom = -2 }
	});
end

function Reforgerade:SetSlotBackground(slot, icon)
	if not slot or not ReforgeradeInputFrame.SlotBackground[slot] then return end
	ReforgeradeInputFrame.SlotBackground[slot]:SetBackdrop({
		bgFile = icon, 
		edgeFile = "", tile = false, tileSize = 0, edgeSize = -1, 
		insets = { left = -2, right = -2, top = -2, bottom = -2 }
	});
end

function Reforgerade:ResetEquipmentIcons()  --Updates slot backgrounds and resets overlays to unknown reforge info
	for i=1, 17 do --skip 18, the tabard
		if i ~= 4 then --Skip the shirt
			Reforgerade:SetSlotBackground(i, GetInventoryItemTexture("player", i) or SlotIcons[i])
			Reforgerade:SetSlotOverlay(i, SlotOverlays.missingInformation)
		end
	end
--~ 	Reforgerade:SetSlotBackground(4, SlotIcons[4]) 
--~ 	Reforgerade:SetSlotBackground(19, SlotIcons[19])
--~ 	reforgeTooltips = { [ReforgeradeInputFrame.SlotOverlay[4]] = "This item slot can't be reforged.", [ReforgeradeInputFrame.SlotOverlay[19]] = "This item slot can't be reforged." }
end


function Reforgerade:RefreshEquipmentIcons()  --Updates slot backgrounds only
	for i=1, 17 do --skip 18, the tabard slot
		if i ~= 4 then --Skip the shirt
			Reforgerade:SetSlotBackground(i, GetInventoryItemTexture("player", i) or SlotIcons[i])
		end
	end
end

Reforgerade:ResetEquipmentIcons()
Reforgerade:SetSlotOverlay(4, SlotOverlays.reforged)
Reforgerade:SetSlotOverlay(18, SlotOverlays.reforged)


--The event -> action system allows the user to automate common tasks
--The idea for the event system comes from the Warcraft 3 GUI scripting system that lets you create 'triggers'  where an action then does a list of events
--Currently this system only supports one action per event and does not support conditions.
--
--To create a new event add an event to the EventDescriptions where the key is the name of the event and the value is the description of the event
--	add a default action to associate with the event to the EventDefaults where the event is the key and the value is the action to run when the event fires
--
--To add an action add the action to the Actions table where the key is the name of the action and the value is the function to run to execute the action

Reforgerade.EventDescriptions = {
	["ReforgeWindowOpen"] = "When the reforge window opens",
	["ReforgeradeShow"] = "When the Reforgerade window is shown",
	["ReforgeradeClosed"] = "When the Reforgerade window is closed.",
	["TextPasted"] = "When I paste text into Reforgerade",
	["ReforgeFinished"] = "When I finish reforging",
	["ReforgeWindowClosed"] = "When the reforge window is closed",	
}

local EventDefaults = {
	["ReforgeWindowOpen"] = "Show Reforgerade",
	["ReforgeradeShow"] = "Update Reforgerade window",
	["TextPasted"] = "Update Reforgerade window",
	["ReforgeFinished"] = "Close Reforgerade",	
	["ReforgeWindowClosed"] = "Close Reforgerade",
	["ReforgeradeClosed"] = "Clear Reforgerade",
}

Actions = {
	["Do Nothing"] = function() return end,
	["Close Reforgerade"] = function () 
		if ReforgingFrame:IsVisible() then
			CloseReforge() 
		end
		ReforgeradeInputFrame.frame:Hide()
	end,
	["Show Reforgerade"] = function () ReforgeradeInputFrame.frame:Show() end,
	["Show reforge changes in chat"] = function () Reforgerade:ReforgeScan(false) end,
	["Update Reforgerade window"] = function () Reforgerade:ReforgeScan(true) end,
	["Reforge"] = function () Reforgerade:ReforgeIt() end,
	["Clear Reforgerade"] = function () 
		ReforgeradeInputFrame.editBox:SetText("")
		Reforgerade:ResetEquipmentIcons()
		ReforgeradeInputFrame.reforgeCostString:SetText(REFORGE .. " " .. COSTS_LABEL .. "\n" .. GetCoinTextureString(0, 12))
	end,
}

Reforgerade.ActionDescriptions = {}
for k,v in pairs(Actions) do
	Reforgerade.ActionDescriptions[k] = k
end

function Reforgerade:DoEvent(event)
	if not event then return end
	Reforgerade:DebugPrint(event)
	if not ReforgeradeSavedVariables then
		Reforgerade:ResetEventHandlers()
	end
	if not ReforgeradeSavedVariables.EventHandlers then
		Reforgerade:ResetEventHandlers()
	end
	if ReforgeradeSavedVariables.EventHandlers[event] and Actions[ReforgeradeSavedVariables.EventHandlers[event]] then
		Actions[ReforgeradeSavedVariables.EventHandlers[event]]()
	end
end

function Reforgerade:ResetEventHandlers(Overide)
	if not ReforgeradeSavedVariables then
		ReforgeradeSavedVariables = {}
	end
	if not ReforgeradeSavedVariables.EventHandlers or Overide or type(ReforgeradeSavedVariables.EventHandlers) ~= "table" then
		ReforgeradeSavedVariables.EventHandlers = {}
		Reforgerade:DebugPrint("Overridng event handlers.")
	end
	
	for event, action in pairs(EventDefaults) do
		if not ReforgeradeSavedVariables.EventHandlers[event] then
			Reforgerade:DebugPrint("Setting default action for " .. event .. " to " .. action .. ".")
			ReforgeradeSavedVariables.EventHandlers[event] = action
		end
	end
end

ReforgeradeInputFrame.frame:Hide()