-- **************************************************************************
-- * TitanItemLevel.lua
-- *
-- * By: InvisiBill
-- **************************************************************************

-- ******************************** Constants *******************************
local _G = getfenv(0);
local TITAN_ITEMLEVEL_ID = "ItemLevel";
local TITAN_ITEMLEVEL_VER = "1.0.0.80000";
local updateTable = {TITAN_ITEMLEVEL_ID, TITAN_PANEL_UPDATE_BUTTON};
local buttonlabel = "iLvl: "
-- ******************************** Variables *******************************
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceTimer = LibStub("AceTimer-3.0")
local OverallAvg
local EquippedAvg
-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelItemLevelButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
function TitanPanelItemLevelButton_OnLoad(self)
	self.registry = {
		id = TITAN_ITEMLEVEL_ID,
		version = TITAN_ITEMLEVEL_VER,
		category = "Information",
		menuText = "Titan Item Level",
		buttonTextFunction = "TitanPanelItemLevelButton_GetButtonText", 
		tooltipTitle = "Item Level",
		tooltipTextFunction = "TitanPanelItemLevelButton_GetTooltipText", 
		icon = "Interface\\Icons\\inv_misc_gear_01",
		iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			DisplayOnRightSide = false
		},
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};

	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

-- **************************************************************************
-- NAME : TitanPanelItemLevelButton_OnEvent()
-- DESC : Parse events registered to plugin and act on them
-- **************************************************************************
function TitanPanelItemLevelButton_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") and (not self:IsEventRegistered("PLAYER_EQUIPMENT_CHANGED")) then
		self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	end

	if event == "PLAYER_EQUIPMENT_CHANGED" then
		-- Create only when the event is active
		self:SetScript("OnUpdate", TitanPanelItemLevelButton_OnUpdate)
	end
end

function TitanPanelItemLevelButton_OnUpdate(self)
	-- update the button
	TitanPanelPluginHandle_OnUpdate(updateTable)
	-- remove until the next event
	self:SetScript("OnUpdate", nil)
end

-- **************************************************************************
-- NAME : TitanPanelItemLevelButton_OnClick(button)
-- DESC : Opens character window
-- VARS : button = value of action
-- **************************************************************************
function TitanPanelItemLevelButton_OnClick(self, button)
	if (button == "LeftButton") then
		ToggleCharacter("PaperDollFrame");
	end
end

-- **************************************************************************
-- NAME : TitanPanelItemLevelButton_GetButtonText(id)
-- DESC : Calculate item level logic then display data on button
-- VARS : id = button ID
-- **************************************************************************
function TitanPanelItemLevelButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	OverallAvg, EquippedAvg = GetAverageItemLevel();
	EquippedAvg = (EquippedAvg - (EquippedAvg % 1));
	OverallAvg = (OverallAvg - (OverallAvg % 1));
	return buttonlabel, strconcat("|cFF00FF00", string.trim(EquippedAvg), "|r/|cFFFFFF00", string.trim(OverallAvg), "|r");
end

-- **************************************************************************
-- NAME : TitanPanelItemLevelButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
function TitanPanelItemLevelButton_GetTooltipText()
	return "Displays your |cFF00FF00equipped|r \nand |cFFFFFF00overall|r item levels.\n\n|cff00ff00Left-click for character info.|r\n|cff00ff00Right-click for options.|r";
end

-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareItemLevelMenu()
-- DESC : Display rightclick menu options
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareItemLevelMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ITEMLEVEL_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_ITEMLEVEL_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ITEMLEVEL_ID);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_ITEMLEVEL_ID, TITAN_PANEL_MENU_FUNC_HIDE);

end