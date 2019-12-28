--[[
	TitanItemLevel: Show your equipped and overall item levels.
	Author: InvisiBill
--]]

local ADDON_NAME, L = ...;
local VERSION = GetAddOnMetadata(ADDON_NAME, "Version")

-----------------------------------------------
local function GetButtonText(self, id)
	local name = L["Label"] .. ": "
	local OverallAvg, EquippedAvg = GetAverageItemLevel();
	EquippedAvg = math.floor(EquippedAvg);
	OverallAvg = math.floor(OverallAvg);
	local text = strconcat("|cFF00FF00", string.trim(EquippedAvg), "|r/|cFFFFFF00", string.trim(OverallAvg), "|r");
	return name, text
end

-----------------------------------------------
local function GetTooltipText()
	--local TooltipText = "Displays your |cFF00FF00equipped|r \nand |cFFFFFF00overall|r item levels.\n\n|cff00ff00Left-click for character info.|r\n|cff00ff00Right-click for options.|r";
	local TooltipText = "Displays your |cFF00FF00equipped|r \nand |cFFFFFF00overall|r item levels.\n\n\124TInterface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:228:283\124t |cff00ff00Character Info|r\n\124TInterface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:330:385\124t |cff00ff00Options|r";
	return TooltipText;
end

-----------------------------------------------
local eventsTable = {
	PLAYER_ENTERING_WORLD = function(self)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		TitanPanelButton_UpdateButton(self.registry.id)
	end,
	PLAYER_EQUIPMENT_CHANGED = function(self)
		TitanPanelButton_UpdateButton(self.registry.id)
	end,
	EQUIPMENT_SWAP_FINISHED = function(self)
		TitanPanelButton_UpdateButton(self.registry.id)
	end
}

-----------------------------------------------
local function OnClick(self, button)
	if (button == "LeftButton") then
		TitanPanelButton_UpdateButton(self.registry.id)
		ToggleCharacter("PaperDollFrame");
	end
end

-----------------------------------------------
local menus = {
	{ type = "space" },
	{ type = "rightSideToggle" }
}

-----------------------------------------------
L.Elib({
	id = "TITAN_ITEM_LEVEL",
	name = L["Name"],
	icon = "Interface\\Icons\\inv_misc_gear_01",
	category = "Information",
	version = VERSION,
	getButtonText = GetButtonText,
	tooltip = L["Name"],
	getTooltipText = GetTooltipText,
    eventsTable = eventsTable,
	menus = menus,
	onClick = OnClick
})
