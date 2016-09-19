-- $Id: Atlas.lua 98 2016-09-09 08:18:21Z arith $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert@gmail.com>
	Copyright 2010 - Lothaer <lothayer@gmail.com>, Atlas Team
	Copyright 2011 ~ 2016 - Arith Hsu, Atlas Team <atlas.addon@gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local _G = getfenv(0);
local pairs = _G.pairs;
local math = _G.math;
local table = _G.table;
local string = _G.string
local select = _G.select
local type = _G.type

local L = LibStub("AceLocale-3.0"):GetLocale("Atlas");
local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0");
local LibDialog = LibStub("LibDialog-1.0");

-- Turn ON / OFF Atlas debug mode
local Atlas_DebugMode = false;
local function debug(info)
	if (Atlas_DebugMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[Atlas] "..info);
	end
end

-- Adopted from EncounterJournal
local EJ_HTYPE_OVERVIEW = 3;

local function EncounterJournal_CheckForOverview(rootSectionID)
	return select(3,EJ_GetSectionInfo(rootSectionID)) == EJ_HTYPE_OVERVIEW;
end

-- Initialization
ATLAS_VERSION = GetAddOnMetadata("Atlas", "Version");
ATLAS_PLAYER_FACTION = UnitFactionGroup("player");
ATLAS_DROPDOWNS = {};
ATLAS_INST_ENT_DROPDOWN = {};
ATLAS_NUM_LINES = 26;
ATLAS_CUR_LINES = 0;
ATLAS_SCROLL_LIST = {};
ATLAS_SCROLL_ID = {};
ATLAS_DATA = {};
ATLAS_SEARCH_METHOD = nil;
ATLAS_PLUGINS = {};
ATLAS_PLUGIN_DATA = {};
AtlasMaps_NPC_DB = {};
ATLAS_SMALLFRAME_SELECTED = false;

local GREN = "|cff66cc33";
local ATLAS_MAP_NPC_NUM = 0;
local ATLAS_LARGEMAP_NPC_NUM = 0;
ATLAS_GAMETOOLTIP_ORIGINAL_SCALE = GameTooltip:GetScale();

-- Only update this version number when the options have been revised and a force update is needed.
ATLAS_OLDEST_VERSION_SAME_SETTINGS = "1.24.00"; 

local ATLAS_LETTER_MARKS_TCOORDS = {
	["Atlas_Letter_Blue_A"] 	= {0.00000000, 0.15625000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_B"] 	= {0.15625000, 0.31250000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_C"] 	= {0.31250000, 0.46875000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_D"] 	= {0.46875000, 0.62500000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_E"] 	= {0.62500000, 0.78125000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_F"] 	= {0.78125000, 0.93750000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_G"] 	= {0.00000000, 0.15625000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_H"] 	= {0.15625000, 0.31250000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_I"] 	= {0.31250000, 0.46875000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_J"] 	= {0.46875000, 0.62500000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_K"] 	= {0.62500000, 0.78125000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_L"] 	= {0.78125000, 0.93750000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_M"] 	= {0.00000000, 0.15625000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_N"] 	= {0.15625000, 0.31250000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_O"] 	= {0.31250000, 0.46875000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_P"] 	= {0.46875000, 0.62500000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_Q"] 	= {0.62500000, 0.78125000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_R"] 	= {0.78125000, 0.93750000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_S"] 	= {0.00000000, 0.15625000, 0.46875000, 0.62500000},
	["Atlas_Letter_Blue_T"] 	= {0.15625000, 0.31250000, 0.46875000, 0.62500000},
	["Atlas_Letter_Blue_U"] 	= {0.31250000, 0.46875000, 0.46875000, 0.62500000},
	["Atlas_Letter_Blue_V"] 	= {0.46875000, 0.62500000, 0.46875000, 0.62500000},
	["Atlas_Letter_Purple_A"] 	= {0.62500000, 0.78125000, 0.46875000, 0.62500000},
	["Atlas_Letter_Purple_B"] 	= {0.78125000, 0.93750000, 0.46875000, 0.62500000},
	["Atlas_Letter_Purple_C"] 	= {0.00000000, 0.15625000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_D"] 	= {0.15625000, 0.31250000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_E"] 	= {0.31250000, 0.46875000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_F"] 	= {0.46875000, 0.62500000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_G"] 	= {0.62500000, 0.78125000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_H"] 	= {0.78125000, 0.93750000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_I"] 	= {0.00000000, 0.15625000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_J"] 	= {0.15625000, 0.31250000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_K"] 	= {0.31250000, 0.46875000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_L"] 	= {0.46875000, 0.62500000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_M"] 	= {0.62500000, 0.78125000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_N"] 	= {0.78125000, 0.93750000, 0.78125000, 0.93750000},
};

local ATLAS_FONT_COLORS = {
	["White"] 	= {1.00, 1.00, 1.00},
	["Yellow"] 	= {1.00, 1.00, 0.00},
	["Green"] 	= {0.00, 1.00, 0.00},
	["Red"] 	= {1.00, 0.00, 0.00},
	["Orange"] 	= {1.00, 0.82, 0.00},
	["Purple"]	= {0.73, 0.40, 1.00},
	["Blue"]	= {0.40, 0.40, 1.00},
};

local ATLAS_TAXI_TCOORDS = {
	["TaxiNeutral"] 	= {0.00000000, 0.31250000, 0.00000000, 0.31250000},
	["TaxiHorde"] 		= {0.31250000, 0.62500000, 0.00000000, 0.31250000},
	["TaxiAlliance"] 	= {0.62500000, 0.93750000, 0.00000000, 0.31250000},
};

local DefaultAtlasOptions = {
	["AtlasVersion"] = ATLAS_OLDEST_VERSION_SAME_SETTINGS;
	["AtlasAlpha"] = 1.0;			-- Atlas frame's transparency
	["AtlasLocked"] = false;		-- Lock Atlas frame position
	["AtlasAutoSelect"] = false;		-- Auto select map
	["AtlasButtonPosition"] = 26;		-- Minimap button position
	["AtlasButtonRadius"] = 78;		-- Minimap button radius
	["AtlasButtonShown"] = true;		-- Show / hide Atlas button
	["AtlasRightClick"] = false;		-- Right click to open world map
	["AtlasType"] = 1;			-- Default or last selected map type (category)
	["AtlasZone"] = 1;			-- Default or last selected map / zone
	["AtlasAcronyms"] = true;		-- Show dungeon's acronyms
	["AtlasScale"] = 1.0;			-- Atlas frame scale
	["AtlasClamped"] = true;		-- Clamp to WoW window
	["AtlasSortBy"] = 1;			-- Maps sorting type, 1: CONTINENT; 2: LEVEL; 3: PARTYSIZE; 4: EXPANSION; 5: TYPE
	["AtlasCtrl"] = false;			-- Press ctrl and mouse over to show full description text
	["AtlasBossDesc"] = true;		-- Toggle to show boss description or not
	["AtlasBossDescScale"] = 0.9;		-- The boss description GameToolTip scale
	["AtlasDontShowInfo"] = false; 		-- Atlas latest information
	["AtlasDontShowInfo_12201"] = false;
	["AtlasCheckModule"] = true;		-- Check if there is missing module / plugin
	["AtlasColoringDropDown"] = true;	-- Coloring dungeon dropdown list with difficulty colors
};

-- Code by Grayhoof (SCT)
local function Atlas_CloneTable(tablein)	-- Return a copy of the table tablein
	local new_table = {};			-- Create a new table
	local ka, va = next(tablein, nil);	-- The ka is an index of tablein; va = tablein[ka]
	while ka do
		if type(va) == "table" then 
			va = Atlas_CloneTable(va);
		end 
		new_table[ka] = va;
		ka, va = next(tablein, ka);	-- Get next index
	end
	return new_table;
end

function Atlas_FreshOptions()
	AtlasOptions = Atlas_CloneTable(DefaultAtlasOptions);
end


-- Below to temporary create a table to store the core map's data
-- in order to identify the dropdown's zoneID is belonging to the
-- core Atlas or plugins
local Atlas_CoreMapsKey = {};
local Atlas_CoreMapsKey_Index = 0;
for kc, vc in pairs(AtlasMaps) do
	Atlas_CoreMapsKey[Atlas_CoreMapsKey_Index] = kc;
	Atlas_CoreMapsKey_Index = Atlas_CoreMapsKey_Index + 1;
end

Atlas_MapTypes = {};
function Atlas_RegisterPlugin(name, myCategory, myData)
	ATLAS_PLUGINS[name] = {};
	local i = getn(Atlas_MapTypes) + 1;
	Atlas_MapTypes[i] = GREN..myCategory; -- Plugin category name to be added with green color, and then added to array
	
	for k, v in pairs(myData) do
		table.insert(ATLAS_PLUGINS[name], k);
		AtlasMaps[k] = v;
	end
	
	table.insert(ATLAS_PLUGIN_DATA, myData);
	
	local catName = Atlas_DropDownLayouts_Order[AtlasOptions.AtlasSortBy];
	local subcatOrder = Atlas_DropDownLayouts_Order[catName];
--	if (ATLAS_OLD_TYPE and ATLAS_OLD_TYPE <= getn(AtlasMaps)) then
	if ( ATLAS_OLD_TYPE and ATLAS_OLD_TYPE <= getn(subcatOrder) + getn(Atlas_MapTypes) ) then
		AtlasOptions.AtlasType = ATLAS_OLD_TYPE;
		AtlasOptions.AtlasZone = ATLAS_OLD_ZONE;
	end
	
	Atlas_PopulateDropdowns();
	Atlas_Refresh();
end

function Atlas_Search(text)
	local data = nil;

	if (ATLAS_SEARCH_METHOD == nil) then
		data = ATLAS_DATA;
	else
		data = ATLAS_SEARCH_METHOD(ATLAS_DATA, text);
	end

	-- Populate the scroll frame entries list, the update func will do the rest
	local i = 1;
	while ( data[i] ~= nil ) do
		ATLAS_SCROLL_LIST[i] = data[i][1];
		if (data[i][2] ~= nil) then
			ATLAS_SCROLL_ID[i] = data[i][2];
		else
			ATLAS_SCROLL_ID[i] = 0;
		end
		i = i + 1;
	end

	ATLAS_CUR_LINES = i - 1;
end

function Atlas_SearchAndRefresh(text)
	Atlas_Search(text);
	AtlasScrollBar_Update();
end

local function Process_Deprecated()
	-- List of deprecated Atlas modules.
	-- First value is the addon name
	-- Second value is the version
	-- Nil version means NO version will EVER be loaded!
	-- Non-nil version mean ONLY IT OR NEWER versions will be loaded!
	-- Note that 2.10 isn't greater than 2.9 (2.10 >= 2.9 will fail), so the addon version number must be with the same digits
	-- For example, name it as 2.09 instead of 2.9
	local Deprecated_List = {
		-- Most recent (working) versions of known modules at time of release
		-- Atlas Modules
		{ "Atlas_Legion",	 	"1.34.01" },
		{ "Atlas_WarlordsofDraenor", 	"1.34.00" },
		{ "Atlas_MistsofPandaria",	"1.34.00" },
		{ "Atlas_Cataclysm", 		"1.34.00" },
		{ "Atlas_WrathoftheLichKing", 	"1.34.00" },
		{ "Atlas_BurningCrusade", 	"1.34.00" },
		{ "Atlas_ClassicWoW", 		"1.34.00" },
		-- Atlas Plugins
		{ "Atlas_Battlegrounds", 	"1.34.00" },
		{ "Atlas_DungeonLocs", 		"1.34.00" },
		{ "Atlas_OutdoorRaids", 	"1.34.00" },
		{ "Atlas_Transportation", 	"1.34.00" },
		{ "Atlas_Scenarios", 		"1.34.00" },
		{ "Atlas_ClassOrderHalls",	"1.34.00" },
		-- 3rd parties plugins
		{ "AtlasQuest", 		"4.10.01" }, 	-- updated Jul. 26, 2016
		{ "Atlas_Arena", 		"1.06.00" }, 	-- updated Jul. 19, 2016
		{ "Atlas_WorldEvents", 		"3.15" }, 	-- updated Jul. 19, 2016
		-- remove AtlasLoot as it did not rely on Atlas since its v8 release
--		{ "AtlasLoot", 			"7.07.03" }, 	-- updated Jul. 19, 2014 -- this version is still with WoW 5.4.x
		--{ "AtlasMajorCities", 	"v1.5.3" }, 	-- updated November 15, 2010; -- comment out because this plugin is no longer maintained
		--{ "AtlasWorld", 		"3.3.5.25" }, 	-- updated July 14, 2010 -- comment out because this plugin is no longer maintained
	};

	-- Check for outdated modules, build a list of them, then disable them and tell the player
	local OldList = {};
	for k, v in pairs(Deprecated_List) do
		local loadable = select(4, GetAddOnInfo(v[1]));
		local enabled = GetAddOnEnableState(UnitName("player"), GetAddOnInfo(v[1]))
		if ( (enabled > 0) and loadable ) then
			local oldVersion = true;			
			if (v[2] ~= nil and GetAddOnMetadata(v[1], "Version") >= v[2]) then
				oldVersion = false;
			end
			if (oldVersion) then
				table.insert(OldList, v[1]);
			end
		end
	end
	if table.getn(OldList) > 0 then
		local textList = "";
		for k, v in pairs(OldList) do
			textList = textList.."\n"..v..", "..GetAddOnMetadata(v, "Version");
			DisableAddOn(v);
		end

		LibDialog:Register("ATLAS_OLD_MODULES", {
			text = ATLAS_DEP_MSG1.."\n"..ATLAS_DEP_MSG2.."\n"..ATLAS_DEP_MSG3.."\n|cff6666ff"..textList.."|r",
			buttons = {
				{
					text = ATLAS_DEP_OK,
				},
			},
			show_while_dead = false,
			hide_on_escape = true,
		});
		LibDialog:Spawn("ATLAS_OLD_MODULES");
	end
end

-- Called when the Atlas frame is first loaded
-- We CANNOT assume that data in other files is available yet!
function Atlas_OnLoad(self)

	Process_Deprecated();

	-- Register the Atlas frame for the following events
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("ADDON_LOADED");

	-- Allows Atlas to be closed with the Escape key
	tinsert(UISpecialFrames, "AtlasFrame");
	tinsert(UISpecialFrames, "AtlasFrameLarge");
	tinsert(UISpecialFrames, "AtlasFrameSmall");
	
	-- Dragging involves some special registration
	self:RegisterForDrag("LeftButton");
end

-- Removal of articles in map names (for proper alphabetic sorting)
-- For example: "The Deadmines" will become "Deadmines"
-- Thus it will be sorted under D and not under T
local function Atlas_SanitizeName(text)
   text = string.lower(text);
   if (AtlasSortIgnore) then
	   for _, v in pairs(AtlasSortIgnore) do
		   local match; 
           if (string.gmatch) then 
                match = string.gmatch(text, v)();
           else 
                match = string.gfind(text, v)(); 
           end
		   if (match) and ((string.len(text) - string.len(match)) <= 4) then
			   return match;
		   end
	   end
   end
   return text;
end

-- Comparator function for alphabetic sorting of maps
-- Yey, one function for everything
local function Atlas_SortZonesAlpha(a, b)
	local aa = Atlas_SanitizeName(AtlasMaps[a].ZoneName[1]);
	local bb = Atlas_SanitizeName(AtlasMaps[b].ZoneName[1]);
	return aa < bb;
end

-- Main Atlas event handler
function Atlas_OnEvent(self, event, ...)
	local arg1 = ...;
	if(event=="ADDON_LOADED" and (arg1=="Atlas" or arg1=="Blizzard_EncounterJournal")) then
		--Blizzard_EncounterJournal
		if (IsAddOnLoaded("Blizzard_EncounterJournal") and IsAddOnLoaded("Atlas")) then
			Atlas_EncounterJournal_Binding();
		end
	end

	if (event == "ADDON_LOADED" and arg1 == "Atlas") then
		Atlas_Init();
	end
	
end

function Atlas_PopulateDropdowns()
	local i = 1;
	local catName = Atlas_DropDownLayouts_Order[AtlasOptions.AtlasSortBy];
	local subcatOrder = Atlas_DropDownLayouts_Order[catName];
	for n = 1, getn(subcatOrder), 1 do
		local subcatItems = Atlas_DropDownLayouts[catName][subcatOrder[n]];

		ATLAS_DROPDOWNS[n] = {};

		for k,v in pairs(subcatItems) do
			table.insert(ATLAS_DROPDOWNS[n], v);
		end

		table.sort(ATLAS_DROPDOWNS[n], Atlas_SortZonesAlpha);

		i = n + 1;
	end
	
	if (ATLAS_PLUGIN_DATA) then
		for ka, va in pairs(ATLAS_PLUGIN_DATA) do

			ATLAS_DROPDOWNS[i] = {};

			for kb,vb in pairs(va) do
				if (type(vb) == "table") then
					table.insert(ATLAS_DROPDOWNS[i], kb);
				end
			end

			table.sort(ATLAS_DROPDOWNS[i], Atlas_SortZonesAlpha);

			i = i + 1;
		end	
	end
end

function Atlas_EnableMissing_Modules(list)
	local addon;
	print("Number: "..table.getn(list));

	for _, addon in pairs(list) do
		print(addon);
		--EnableAddon(addon, UnitName("player"));
	end
	
	ReloadUI();
end

-- Detect if not all modules / plugins are installed
local function Atlas_Check_Modules()
	if (AtlasOptions["AtlasCheckModule"] == nil) then
		AtlasOptions["AtlasCheckModule"] = true;
	end
	if (AtlasOptions["AtlasCheckModule"] == false) then
		return;
	end
	local Module_List = {
		"Atlas_ClassicWoW",
		"Atlas_BurningCrusade",
		"Atlas_WrathoftheLichKing",
		"Atlas_Cataclysm",
		"Atlas_MistsofPandaria",
		"Atlas_WarlordsofDraenor",
		"Atlas_Legion",
		"Atlas_Battlegrounds",
		"Atlas_DungeonLocs",
		"Atlas_OutdoorRaids",
		"Atlas_Transportation",
		"Atlas_Scenarios",
		"Atlas_ClassOrderHalls",
	};

	-- Check for outdated modules, build a list of them, then disable them and tell the player
	local List = {};
	for _, module in pairs(Module_List) do
		local loadable = select(4, GetAddOnInfo(module));
		local enabled = GetAddOnEnableState(UnitName("player"), module)
		if ( (enabled == 0) or (not loadable) ) then
			table.insert(List, module);
		end
	end
	if table.getn(List) > 0 then
		local textList = "";
		for _, str in pairs(List) do
			textList = textList.."\n"..str;
		end

		LibDialog:Register("DetectMissing", {
			text = L["ATLAS_MISSING_MODULE"].."\n|cff6666ff"..textList.."|r\n",
			buttons = {
				{
					text = CLOSE,
				},
				{
					text = L["ATLAS_OPEN_ADDON_LIST"],
					on_click = AddonList_Show,
				},
			},
			width = 500,
			show_while_dead = false,
			hide_on_escape = true,
		});
		LibDialog:Spawn("DetectMissing");
	end
end

-- Function to pop up a window to show the latest addon information
function Atlas_ShowInfo()
	if (AtlasOptions["AtlasDontShowInfo_12201"]) then
		return;
	else
		AtlasInfoFrame:Show();
		AtlasInfoFrameToggleButton:SetChecked(AtlasOptions.AtlasDontShowInfo_12201);
	end
end

function Atlas_ShowInfo_Toggle()
	if (AtlasOptions["AtlasDontShowInfo_12201"]) then
		AtlasOptions["AtlasDontShowInfo_12201"] = false;
	else
		AtlasOptions["AtlasDontShowInfo_12201"] = true;
	end
	AtlasInfoFrameToggleButton:SetChecked(AtlasOptions.AtlasDontShowInfo_12201);
end

ATLAS_OLD_TYPE = false;
ATLAS_OLD_ZONE = false;

function Atlas_InitOptions()
	-- Init saved vars for a new install
	if ( AtlasOptions == nil ) then
		Atlas_FreshOptions();
	end
	-- Init the newly added "AtlasBossDescScale" and don't bother user to reset everything
	-- Can be removed after 1.21.0 release
	if (AtlasOptions["AtlasBossDescScale"] == nil) then
		AtlasOptions["AtlasBossDescScale"] = 0.9;
	end
	if (AtlasOptions["AtlasBossDesc"] == nil) then
		AtlasOptions["AtlasBossDesc"] = true;
	end

	if (AtlasOptions["AtlasDontShowInfo_12201"] == nil) then
		AtlasOptions["AtlasDontShowInfo_12201"] = false;
	end
	
	if (AtlasOptions["AtlasCheckModule"] == nil) then
		AtlasOptions["AtlasCheckModule"] = true;
	end
	
	if (AtlasOptions["AtlasColoringDropDown"] == nil) then
		AtlasOptions["AtlasColoringDropDown"] = true;
	end
	
	--saved options version check
	if (AtlasOptions["AtlasVersion"] ~= ATLAS_OLDEST_VERSION_SAME_SETTINGS) then
		Atlas_FreshOptions();
	end
end

-- Initializes everything relating to saved variables and data in other lua files
-- This should be called ONLY when we're sure our variables are in memory
function Atlas_Init()

	-- Make the Atlas window go all the way to the edge of the screen, exactly
	AtlasFrame:SetClampRectInsets(12, 0, -12, 0);
	AtlasFrameLarge:SetClampRectInsets(12, 0, -12, 0);
	AtlasFrameSmall:SetClampRectInsets(12, 0, -12, 0);

	Atlas_InitOptions();

	-- Populate the dropdown lists...yeeeah this is so much nicer!
	Atlas_PopulateDropdowns();
	
	if (not ATLAS_DROPDOWNS[AtlasOptions.AtlasType]) then
		ATLAS_OLD_TYPE = AtlasOptions.AtlasType;
		ATLAS_OLD_ZONE = AtlasOptions.AtlasZone;
		AtlasOptions.AtlasType = 1;
		AtlasOptions.AtlasZone = 1;
	end
	
	-- Now that saved variables have been loaded, update everything accordingly
	Atlas_Refresh();
	Atlas_UpdateLock();
	Atlas_UpdateAlpha();
	AtlasFrame:SetClampedToScreen(AtlasOptions.AtlasClamped);
	AtlasFrameLarge:SetClampedToScreen(AtlasOptions.AtlasClamped);
	AtlasFrameSmall:SetClampedToScreen(AtlasOptions.AtlasClamped);
	--AtlasButton_UpdatePosition();
	AtlasOptions_Init();
	
	-- Make an LDB object
	LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Atlas", {
		type = "launcher",
		text = "Atlas",
		label = "Atlas",
		OnClick = function(self, button)
			if button == "LeftButton" then
				Atlas_Toggle();
			elseif button == "RightButton" then
				AtlasOptions_Toggle();
			end
		end,
		icon = "Interface\\WorldMap\\WorldMap-Icon",
		OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine("|cffffffff"..ATLAS_TITLE)
			tooltip:AddLine(ATLAS_LDB_HINT)
		end,
	})
	
	Atlas_Check_Modules();
	if (AtlasOptions["AtlasDontShowInfo_12201"]) then
		Atlas_ShowInfo();
	end
end

-- Simple function to toggle the Atlas frame's lock status and update it's appearance
function Atlas_ToggleLock()
	AtlasOptions_ToggleLock();
end

-- Updates the appearance of the lock button based on the status of AtlasLocked
function Atlas_UpdateLock()
	local btnLckUp = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Up";
	local btnLckDn = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Down";
	local btnUlckUp = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Up";
	local btnUnlckDn = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Down";
	if (AtlasOptions.AtlasLocked) then
		AtlasLockNorm:SetTexture(btnLckUp);
		AtlasLockPush:SetTexture(btnLckDn);
		AtlasLockLargeNorm:SetTexture(btnLckUp);
		AtlasLockLargePush:SetTexture(btnLckDn);
		AtlasLockSmallNorm:SetTexture(btnLckUp);
		AtlasLockSmallPush:SetTexture(btnLckDn);
	else
		AtlasLockNorm:SetTexture(btnUlckUp);
		AtlasLockPush:SetTexture(btnUnlckDn);
		AtlasLockLargeNorm:SetTexture(btnUlckUp);
		AtlasLockLargePush:SetTexture(btnUnlckDn);
		AtlasLockSmallNorm:SetTexture(btnUlckUp);
		AtlasLockSmallPush:SetTexture(btnUnlckDn);
	end
end

-- Begin moving the Atlas frame if it's unlocked
function Atlas_StartMoving(self)
	if (not AtlasOptions.AtlasLocked) then
		self:StartMoving();
	end
end

-- Parses slash commands
-- If an un-recognized command is given, toggle Atlas
function Atlas_SlashCommand(msg)
	if (msg == ATLAS_SLASH_OPTIONS) then
		AtlasOptions_Toggle();
	else
		Atlas_Toggle();
	end
end

-- Sets the transparency of the Atlas frame based on AtlasAlpha
function Atlas_UpdateAlpha()
	AtlasFrame:SetAlpha(AtlasOptions.AtlasAlpha);
	AtlasFrameLarge:SetAlpha(AtlasOptions.AtlasAlpha);
	AtlasFrameSmall:SetAlpha(AtlasOptions.AtlasAlpha);
end

-- Sets the scale of the Atlas frame based on AtlasScale
function Atlas_UpdateScale()
	AtlasFrame:SetScale(AtlasOptions.AtlasScale);
	AtlasFrameLarge:SetScale(AtlasOptions.AtlasScale);
	AtlasFrameSmall:SetScale(AtlasOptions.AtlasScale);
end

-- Simple function to toggle the visibility of the Atlas frame
function Atlas_Toggle()
	if (ATLAS_SMALLFRAME_SELECTED) then
		if (AtlasFrameSmall:IsVisible()) then
			HideUIPanel(AtlasFrameSmall);
		else
			ShowUIPanel(AtlasFrameSmall);
		end
	else
		if (AtlasFrame:IsVisible()) then
			HideUIPanel(AtlasFrame);
		else
			ShowUIPanel(AtlasFrame);
		end
	end
end

-- Adopted some of the codes from AlasMajorCitiesEnhanced
-- Function to cleanup the text frame
--[[
function Atlas_Clear_NPC_Button()
	-- Clean up NPC text frames
	if (ATLAS_MAP_NPC_NUM == 0) then 
		return; 
	end
	if (ATLAS_MAP_NPC_NUM > 0) then
		for i = 1, ATLAS_MAP_NPC_NUM do
			local button = _G["AtlasMapNPCButton"..i];
			local bossbutton = _G["AtlasMapBossButton"..i];

			if (button) then
				button:Hide();
				button:ClearAllPoints();

				local t = _G[button:GetName().."_Text"];
				if (t) then
					t:SetText("");
				end
			end
			if (bossbutton) then
				bossbutton:Hide();
				bossbutton:ClearAllPoints();
			end
		end

		for i = 1, ATLAS_MAP_NPC_NUM do
			local button = _G["AtlasMapNPCButtonS"..i];
			local bossbutton = _G["AtlasMapBossButtonS"..i];

			if (button) then
				button:Hide();
				button:ClearAllPoints();

				local tex = _G[button:GetName().."Texture"];
				if (tex) then
					tex:ClearAllPoints();
					tex:SetTexture(nil);
				end

				local t = _G[button:GetName().."_Text"];
				if (t) then
					t:SetText("");
				end
			end
			if (bossbutton) then
				bossbutton:Hide();
				bossbutton:ClearAllPoints();
			end
		end
		ATLAS_MAP_NPC_NUM = 0;
	end
end
]]

function Atlas_MapRefresh()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local _;
	local data = AtlasMaps;
	local base = data[zoneID];
	local minLevel, maxLevel, minRecLevel, maxRecLevel, maxPlayers;
	local minLevelH, maxLevelH, minRecLevelH, maxRecLevelH, maxPlayersH;
	local minLevelM, maxLevelM, minRecLevelM, maxRecLevelM, maxPlayersM;
	local _RED = "|cffcc3333";
	local WHIT = "|cffffffff";
	local colortag, dungeon_difficulty;
	
	if (base.DungeonID) then
		_, _, _, minLevel, maxLevel, _, minRecLevel, maxRecLevel, _, _, _, _, maxPlayers = GetLFGDungeonInfo(base.DungeonID);

		-- For some unknown reason, some of the dungeons do not have recommended level range
		if (minRecLevel == 0) then 
			minRecLevel = minLevel;
		end
		if (maxRecLevel == 0) then
			maxRecLevel = maxLevel;
		end
	end
	if (base.DungeonHeroicID) then
		_, _, _, minLevelH, maxLevelH, _, minRecLevelH, maxRecLevelH, _, _, _, _, maxPlayersH = GetLFGDungeonInfo(base.DungeonHeroicID);

		if (minRecLevelH == 0) then
			minRecLevelH = minRecLevel;
		end
		if (maxRecLevelH == 0) then
			maxRecLevelH = maxRecLevel;
		end
	end
	if (base.DungeonMythicID) then
		_, _, _, minLevelM, maxLevelM, _, minRecLevelM, maxRecLevelM, _, _, _, _, maxPlayersM = GetLFGDungeonInfo(base.DungeonMythicID);

		if (minRecLevelM == 0) then
			minRecLevelM = minRecLevel;
		end
		if (maxRecLevelM == 0) then
			maxRecLevelM = maxRecLevel;
		end
	end
	
	-- Zone Name and Acronym
	local tName = base.ZoneName[1];
	if (base.LargeMap) then
		AtlasFrameLarge.ZoneName.Text:SetText(tName);
	end
	AtlasFrameSmall.ZoneName.Text:SetText(tName);
	AtlasFrame.ZoneName.Text:SetText(tName);
	if (AtlasOptions.AtlasAcronyms and base.Acronym ~= nil) then
		tName = tName.._RED.." ["..base.Acronym.."]";
	end
	AtlasText_ZoneName_Text:SetText(tName);
	
	-- Map Location
	local tLoc = "";
	if (base.Location) then
		tLoc = ATLAS_STRING_LOCATION..L["Colon"]..WHIT..base.Location[1];
	end
	AtlasText_Location_Text:SetText(tLoc);

	-- Map Level Range
	local tLR = "";
	if (base.DungeonID) then 
		local tmp_LR = ATLAS_STRING_LEVELRANGE..L["Colon"];
		dungeon_difficulty = Atlas_DungeonDifficulty(minLevel);
		colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
		if (minLevel ~= maxLevel) then
			tmp_LR = tmp_LR..colortag..minLevel.."-"..maxLevel;
		else
			tmp_LR = tmp_LR..colortag..minLevel;
		end
		if (base.DungeonHeroicID) then
			dungeon_difficulty = Atlas_DungeonDifficulty(minLevelH);
			colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
			if (minLevelH ~= maxLevelH) then
				tmp_LR = tmp_LR..L["Slash"]..colortag..minLevelH.."-"..maxLevelH..L["Heroic_Symbol"];
			else
				tmp_LR = tmp_LR..L["Slash"]..colortag..minLevelH..L["Heroic_Symbol"];
			end
		end
		if (base.DungeonMythicID) then
			dungeon_difficulty = Atlas_DungeonDifficulty(minLevelM);
			colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
			if (minLevelM ~= maxLevelM) then
				tmp_LR = tmp_LR..L["Slash"]..colortag..minLevelM.."-"..maxLevelM..L["Mythic_Symbol"];
			else
				tmp_LR = tmp_LR..L["Slash"]..colortag..minLevelM..L["Mythic_Symbol"];
			end
		end
		tLR = tmp_LR;
	elseif (base.LevelRange) then
		tLR = ATLAS_STRING_LEVELRANGE..L["Colon"]..WHIT..base.LevelRange;
	end
	AtlasText_LevelRange_Text:SetText(tLR);

	-- Map RecommendedLevel Range
	local tRLR = "";
	if (base.DungeonID) then 
		dungeon_difficulty = Atlas_DungeonDifficulty(minRecLevel);
		colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
		local tmp_RLR = ATLAS_STRING_RECLEVELRANGE..L["Colon"];
		if (minRecLevel ~= maxRecLevel) then
			tmp_RLR = tmp_RLR..colortag..minRecLevel.."-"..maxRecLevel;
		else
			tmp_RLR = tmp_RLR..colortag..minRecLevel;
		end
		if (base.DungeonHeroicID) then
			dungeon_difficulty = Atlas_DungeonDifficulty(minRecLevelH);
			colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
			if (minRecLevelH ~= maxRecLevelH) then
				tmp_RLR = tmp_RLR..L["Slash"]..colortag..minRecLevelH.."-"..maxRecLevelH..L["Heroic_Symbol"];
			else
				tmp_RLR = tmp_RLR..L["Slash"]..colortag..minRecLevelH..L["Heroic_Symbol"];
			end
		end
		if (base.DungeonMythicID) then
			dungeon_difficulty = Atlas_DungeonDifficulty(minRecLevelM);
			colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
			if (minRecLevelM ~= maxRecLevelM) then
				tmp_RLR = tmp_RLR..L["Slash"]..colortag..minRecLevelM.."-"..maxRecLevelM..L["Mythic_Symbol"];
			else
				tmp_RLR = tmp_RLR..L["Slash"]..colortag..minRecLevelM..L["Mythic_Symbol"];
			end
		end
		tRLR = tmp_RLR;
	elseif (base.LevelRange) then
		tRLR = ATLAS_STRING_RECLEVELRANGE..L["Colon"]..WHIT..base.LevelRange;
	end
	AtlasText_RecommendedRange_Text:SetText(tRLR);

	-- Map's Minimum Level
	local tML = "";
	if (base.DungeonID) then 
		dungeon_difficulty = Atlas_DungeonDifficulty(minLevel);
		colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
		tML = ATLAS_STRING_MINLEVEL..L["Colon"]..colortag..minLevel;
		if (base.DungeonHeroicID) then
			dungeon_difficulty = Atlas_DungeonDifficulty(minLevelH);
			colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
			tML = tML..L["Slash"]..colortag..minLevelH..L["Heroic_Symbol"];
		end
		if (base.DungeonMythicID) then
			dungeon_difficulty = Atlas_DungeonDifficulty(minLevelM);
			colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
			tML = tML..L["Slash"]..colortag..minLevelM..L["Mythic_Symbol"];
		end
	elseif (base.MinLevel) then
		tML = ATLAS_STRING_MINLEVEL..L["Colon"]..WHIT..base.MinLevel;
	end
	AtlasText_MinLevel_Text:SetText(tML);

	-- Player Limit
	local tPL = "";
	if (base.DungeonID and maxPlayers ~= 0) then 
		tPL = ATLAS_STRING_PLAYERLIMIT..L["Colon"]..WHIT..maxPlayers;
		if (base.DungeonHeroicID and maxPlayers ~= maxPlayersH) then
			tPL = tPL.." / "..maxPlayersH;
		end
	elseif (base.PlayerLimit) then
		tPL = ATLAS_STRING_PLAYERLIMIT..L["Colon"]..WHIT..base.PlayerLimit;
	end
	AtlasText_PlayerLimit_Text:SetText(tPL);

	-- Check if Journal Encounter Instance is available
	if (base.JournalInstanceID) then
		AtlasFrameAdventureJournalButton:Show();
		AtlasFrameLargeAdventureJournalButton:Show();
		AtlasFrameSmallAdventureJournalButton:Show();
		--AtlasSetEJBackground(base.JournalInstanceID);
	else
		AtlasFrameAdventureJournalButton:Hide();
		AtlasFrameLargeAdventureJournalButton:Hide();
		AtlasFrameSmallAdventureJournalButton:Hide();
		--AtlasSetEJBackground();
	end

	-- Check if WorldMap ID is available, if so, show the map button
	if (base.WorldMapID) then
		AtlasFrameAdventureJournalMapButton:Show();
		AtlasFrameLargeAdventureJournalMapButton:Show();
		AtlasFrameSmallAdventureJournalMapButton:Show();
	else
		AtlasFrameAdventureJournalMapButton:Hide();
		AtlasFrameLargeAdventureJournalMapButton:Hide();
		AtlasFrameSmallAdventureJournalMapButton:Hide();
	end

	if (base.LargeMap) then
		AtlasFrameSizeUpButton:Show();
		AtlasFrameSmallSizeUpButton:Show();
	else
		AtlasFrameSizeUpButton:Hide();
		AtlasFrameSmallSizeUpButton:Hide();
	end
	
	-- Clear boss description gametooltip when map is refreshing
	if (AtlasOptions["AtlasBossDesc"]) then
		--Atlas_Clear_NPC_Button();
	end

	-- Searching for the map path from Atlas or from plugins
	local AtlasMapPath;
	for k, v in pairs(Atlas_CoreMapsKey) do
		-- If selected map is Atlas' core map
		if (zoneID == v) then
			if (base.Module) then
				-- if the map belong to a module, set the path to module
				AtlasMapPath = "Interface\\AddOns\\"..base.Module.."\\Images\\";
			else
				AtlasMapPath = "Interface\\AddOns\\Atlas\\Images\\Maps\\";
			end
			break;
		-- Check if selected map is from plugin
		else
			-- Searching for plugins
			for ka,va in pairs(ATLAS_PLUGINS) do
				-- Searching for plugin's maps
				for kb,vb in pairs(ATLAS_PLUGINS[ka]) do
					if (zoneID == vb) then
						AtlasMapPath = "Interface\\AddOns\\"..ka.."\\Images\\";
						break;
					end
				end
			end
		end
	end
	AtlasMap:SetTexture(AtlasMapPath..zoneID);
	AtlasMapSmall:SetTexture(AtlasMapPath..zoneID);

	local AtlasMap_Text = _G["AtlasMap_Text"];
	local AtlasMapS_Text = _G["AtlasMapS_Text"];
	if (not AtlasMap_Text) then
		AtlasMap_Text = AtlasFrame:CreateFontString("AtlasMap_Text", "OVERLAY", "GameFontHighlightLarge");
	end
	if (not AtlasMapS_Text) then
		AtlasMapS_Text = AtlasFrameSmall:CreateFontString("AtlasMapS_Text", "OVERLAY", "GameFontHighlightLarge");
	end
	AtlasMap_Text:SetPoint("CENTER", "AtlasFrame", "LEFT", 256, -32);
	AtlasMapS_Text:SetPoint("CENTER", "AtlasFrameSmall", "LEFT", 256, -32);
	-- Check if the map image is available, if not replace with black and Map Not Found text
	if (base.Module) then
		local loadable = select(4, GetAddOnInfo(base.Module));
		local enabled = GetAddOnEnableState(UnitName("player"), base.Module)
		if ((enabled == 0) or (not loadable)) then
			-- AtlasMap:SetTexture(0, 0, 0);
			-- Legion changes: texture:SetTexture(r, g, b, a) changes into texture:SetColorTexture(r, g, b, a)
			AtlasMap:SetColorTexture(0, 0, 0, 0); 
			AtlasMap_Text:SetText(L["MapsNotFound"].."\n\n"..L["PossibleMissingModule"].."\n|cff6666ff"..base.Module);
			AtlasMapSmall:SetColorTexture(0, 0, 0, 0); 
			AtlasMapS_Text:SetText(L["MapsNotFound"].."\n\n"..L["PossibleMissingModule"].."\n|cff6666ff"..base.Module);
			if (not AtlasMap_Text:IsShown()) then
				AtlasMap_Text:Show();
			end
			if (not AtlasMapS_Text:IsShown()) then
				AtlasMapS_Text:Show();
			end
		else 
			AtlasMap_Text:SetText("");
			AtlasMapS_Text:SetText("");
		end
	else
		AtlasMap_Text:SetText("");
		AtlasMapS_Text:SetText("");
	end

	-- Large Atlas map
	if (base.LargeMap) then
		for i=1, 12 do
			_G["AtlasMapLarge"..i]:SetTexture(AtlasMapPath..zoneID.."\\"..base.LargeMap..i);
		end
	end

	-- The boss description to be added here
	if (AtlasOptions["AtlasBossDesc"]) then
		AtlasMap_AddNPCButton();
		AtlasMap_AddNPCButtonLarge();
	else
		--Atlas_Clear_NPC_Button();
	end
end


-- Refreshes the Atlas frame, usually because a new map needs to be displayed
-- The zoneID variable represents the internal name used for each map, ex: "BlackfathomDeeps"
-- Also responsible for updating all the text when a map is changed
function Atlas_Refresh()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local data = AtlasMaps;
	local base = data[zoneID];

	-- Dealing with the scenario that when user is in a large map, but then the newly selected map does not have large map
	if (not base.LargeMap and AtlasFrameLarge:IsVisible() ) then
		if (ATLAS_SMALLFRAME_SELECTED) then
			HideUIPanel(AtlasFrameLarge);
			ShowUIPanel(AtlasFrameSmall);
		else
			HideUIPanel(AtlasFrameLarge);
			ShowUIPanel(AtlasFrame);
		end
	end
	
	Atlas_MapRefresh();
	
	ATLAS_DATA = base;
	ATLAS_SEARCH_METHOD = data.Search;

	if ( data.Search == nil ) then
		ATLAS_SEARCH_METHOD = AtlasSimpleSearch;
	end
	
	if ( data.Search ~= false ) then
		AtlasSearchEditBox:Show();
		AtlasNoSearch:Hide();
	else
		AtlasSearchEditBox:Hide();
		AtlasNoSearch:Show();
		ATLAS_SEARCH_METHOD = nil;
	end

	-- Populate the scroll frame entries list, the update func will do the rest
	Atlas_Search("");
	AtlasSearchEditBox:SetText("");
	AtlasSearchEditBox:ClearFocus();

	-- Create and align any new entry buttons that we need
	for i = 1, ATLAS_CUR_LINES do
		if (not _G["AtlasEntry"..i]) then
			local f = CreateFrame("Button", "AtlasEntry"..i, AtlasFrame, "AtlasEntryTemplate");
			if i == 1 then
				f:SetPoint("TOPLEFT", "AtlasScrollBar", "TOPLEFT", 16, -2);
			else
				f:SetPoint("TOPLEFT", "AtlasEntry"..(i - 1), "BOTTOMLEFT");
			end
		end
	end

	AtlasScrollBar_Update();

	-- Deal with the switch to entrance/instance button here
	-- Only display if appropriate
	-- See if we should display the button or not, and decide what it should say
	local matchFound = {};
	local sayEntrance;
	for k, v in pairs(Atlas_EntToInstMatches) do
		if (k == zoneID) then
			matchFound = v;
			sayEntrance = false;
		end
	end
	if (not matchFound[1]) then
		for k, v in pairs(Atlas_InstToEntMatches) do
			if (k == zoneID) then
				matchFound = v;
				sayEntrance = true;
			end
		end
	end
	-- Below try to add the series maps into switch button's map list
	if (not matchFound[1]) then
		for k, v in pairs(Atlas_MapSeries) do
			if (k == zoneID) then
				matchFound = v;
				sayEntrance = false;
			end
		end
	end

	-- Set the button's text, populate the dropdown menu, and show or hide the button
	if (matchFound[1]) then
		ATLAS_INST_ENT_DROPDOWN = {};
		for k, v in pairs(matchFound) do
			table.insert(ATLAS_INST_ENT_DROPDOWN, v);
		end
		table.sort(ATLAS_INST_ENT_DROPDOWN, AtlasSwitchDD_Sort);
		if (sayEntrance) then
			AtlasSwitchButton:SetText(ATLAS_ENTRANCE_BUTTON);
		else
			AtlasSwitchButton:SetText(ATLAS_INSTANCE_BUTTON);
		end
		AtlasSwitchButton:Show();
		Lib_UIDropDownMenu_Initialize(AtlasSwitchDD, AtlasSwitchDD_OnLoad);
	else
		AtlasSwitchButton:Hide();
	end

	if (TitanPanelButton_UpdateButton) then
		TitanPanelButton_UpdateButton("Atlas");
	end
end

-- Add boss / NPC button here so that we can add GameTooltip
function AtlasMap_AddNPCButton()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local t = AtlasMaps_NPC_DB[zoneID];
	local i = 1;
	local bossindex = 1;
	local buttonindex = 1;
	local bossindexS = 1;
	local buttonindexS = 1;
	local bossbutton, button, bossbuttonS, buttonS;

	if (t) then
		while (t[i]) do
			local info_mark 	= t[i][1];
			local info_id 		= t[i][2];
			local info_x 		= t[i][3];
			local info_y 		= t[i][4];
			local info_colortag	= t[i][7];

			if (info_id < 10000) then
				bossbutton = _G["AtlasMapBossButton"..bossindex];
				if (not bossbutton) then
					bossbutton = CreateFrame("Button", "AtlasMapBossButton"..bossindex, AtlasFrame, "AtlasFrameBossButtonTemplate");
				end
				bossbuttonS = _G["AtlasMapBossButtonS"..bossindexS];
				if (not bossbuttonS) then
					bossbuttonS = CreateFrame("Button", "AtlasMapBossButtonS"..bossindexS, AtlasFrameSmall, "AtlasFrameBossButtonTemplate");
				end

				encounterID = info_id;
				ejbossname, description, _, rootSectionID = EJ_GetEncounterInfo(encounterID); 
				if (ejbossname) then 
					bossbutton.tooltipTitle = ejbossname; 
					bossbuttonS.tooltipTitle = ejbossname; 
				else
					bossbutton.tooltipTitle = nil; 
					bossbuttonS.tooltipTitle = nil; 
				end
				if (encounterID) then
					bossbutton.encounterID = encounterID;
					bossbuttonS.encounterID = encounterID;
				else
					bossbutton.encounterID = nil;
					bossbuttonS.encounterID = nil;
				end
				if (description) then 
					bossbutton.tooltipText = description; 
					bossbuttonS.tooltipText = description; 
				else
					bossbutton.tooltipText = nil; 
					bossbuttonS.tooltipText = nil; 
				end
				if (ejbossname and EncounterJournal_CheckForOverview(rootSectionID)) then
					local _, overviewDescription = EJ_GetSectionInfo(rootSectionID);
					if (overviewDescription) then
						bossbutton.overviewDescription = overviewDescription;
						bossbuttonS.overviewDescription = overviewDescription;
					else
						bossbutton.overviewDescription = nil;
						bossbuttonS.overviewDescription = nil;
					end
				end

				_, _, _, displayInfo, iconImage = EJ_GetCreatureInfo(1, encounterID);
				bossbutton.displayInfo = displayInfo;
				if ( encounterID and iconImage ) then
					SetPortraitTexture(bossbutton.bgImage, displayInfo);
					SetPortraitTexture(bossbuttonS.bgImage, displayInfo);
				else 
					bossbutton.bgImage:SetTexture(nil);
					bossbuttonS.bgImage:SetTexture(nil);
				end
				bossbutton:ClearAllPoints();
				--bossbutton:SetWidth(20);
				--bossbutton:SetHeight(20);
				bossbutton:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", info_x + 18-15, -info_y - 82+15);
				bossbutton:SetID(info_id);
				bossbutton:Show();

				bossbuttonS:ClearAllPoints();
				bossbuttonS:SetPoint("TOPLEFT", "AtlasFrameSmall", "TOPLEFT", info_x + 18-15, -info_y - 82+15);
				bossbuttonS:SetID(info_id);
				bossbuttonS:Show();

				bossindex = bossindex + 1;
				bossindexS = bossindexS + 1;
			else
				button = _G["AtlasMapNPCButton"..buttonindex];
				if (not button) then
					button = CreateFrame("Button", "AtlasMapNPCButton"..buttonindex, AtlasFrame, "AtlasMapNPCButtonTemplate");
				end
				buttonS = _G["AtlasMapNPCButtonS"..buttonindexS];
				if (not buttonS) then
					buttonS = CreateFrame("Button", "AtlasMapNPCButtonS"..buttonindexS, AtlasFrameSmall, "AtlasMapNPCButtonTemplate");
				end

				local tip_title;
				for k, v in pairs(AtlasMaps[zoneID]) do
					if (v[2] == info_id) then
						tip_title = v[1];
						local _, endpos = strfind(tip_title, ") ");
						if (endpos) then
							button.tooltipTitle = strsub(tip_title, endpos+1);
							buttonS.tooltipTitle = strsub(tip_title, endpos+1);
						end
					end
				end
				button:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", info_x + 18, -info_y - 82 );
				button:SetID(info_id);
				button:Show();
				buttonS:SetPoint("TOPLEFT", "AtlasFrameSmall", "TOPLEFT", info_x + 18, -info_y - 82 );
				buttonS:SetID(info_id);
				buttonS:Show();

				buttonindex = buttonindex + 1;
				buttonindexS = buttonindexS + 1;
			end

			-- Disable the set text unless one day we want the text to be added dynamatically
			-- Or, enable it for debugging purpose
--[[
			local f_text = button:CreateFontString(button:GetName().."_Text", "MEDIUM", "NumberFont_Outline_Huge");
			f_text:SetPoint("CENTER", button, "CENTER", 0, 0);
			f_text:SetText(info_mark);
]]
			i = i + 1;
		end
		-- We started the counting from 1, plus 1 in each loop, need to adjust by removing 1 after the loop is ended
		--ATLAS_MAP_NPC_NUM = i - 1;
	end

	bossbutton = _G["AtlasMapBossButton"..bossindex];
	while bossbutton do
		bossbutton.bgImage:SetTexture(nil);
		bossbutton:Hide();
		bossindex = bossindex + 1;
		bossbutton = _G["AtlasMapBossButton"..bossindex];
	end

	bossbuttonS = _G["AtlasMapBossButtonS"..bossindexS];
	while bossbuttonS do
		bossbuttonS.bgImage:SetTexture(nil);
		bossbuttonS:Hide();
		bossindexS = bossindexS + 1;
		bossbuttonS = _G["AtlasMapBossButtonS"..bossindexS];
	end
	
	button = _G["AtlasMapNPCButton"..buttonindex];
	while button do
		button.bgImage:SetTexture(nil);
		button:Hide();
		buttonindex = buttonindex + 1;
		button = _G["AtlasMapNPCButton"..buttonindex];
	end

	buttonS = _G["AtlasMapNPCButtonS"..buttonindexS];
	while buttonS do
		buttonS.bgImage:SetTexture(nil);
		buttonS:Hide();
		buttonindexS = buttonindexS + 1;
		buttonS = _G["AtlasMapNPCButtonS"..buttonindexS];
	end

end

function AtlasMap_AddNPCButtonLarge()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local t = AtlasMaps_NPC_DB[zoneID];
	local i = 1;
	local bossindex = 1;
	local buttonindex = 1;
	local bossbutton, button;

	if (t) then
		while (t[i]) do
			local info_mark 	= t[i][1];
			local info_id 		= t[i][2];
			local info_x 		= t[i][5];
			local info_y 		= t[i][6];
			local info_colortag	= t[i][7];

			if (info_id < 10000 and info_x and info_y) then
				bossbutton = _G["AtlasMapBossButtonL"..bossindex];
				if (not bossbutton) then
					bossbutton = CreateFrame("Button", "AtlasMapBossButtonL"..bossindex, AtlasFrameLarge, "AtlasFrameBossButtonTemplate");
				end

				encounterID = info_id;
				ejbossname, description, _, rootSectionID = EJ_GetEncounterInfo(encounterID); 
				if (ejbossname) then 
					bossbutton.tooltipTitle = ejbossname; 
				else
					bossbutton.tooltipTitle = nil; 
				end
				if (encounterID) then
					bossbutton.encounterID = encounterID;
				else
					bossbutton.encounterID = nil;
				end
				if (description) then 
					bossbutton.tooltipText = description; 
				else
					bossbutton.tooltipText = nil; 
				end
				if (ejbossname and EncounterJournal_CheckForOverview(rootSectionID)) then
					local _, overviewDescription = EJ_GetSectionInfo(rootSectionID);
					if (overviewDescription) then
						bossbutton.overviewDescription = overviewDescription;
					else
						bossbutton.overviewDescription = nil;
					end
				end

				_, _, _, displayInfo, iconImage = EJ_GetCreatureInfo(1, encounterID);
				bossbutton.displayInfo = displayInfo;
				if ( encounterID and iconImage ) then
					SetPortraitTexture(bossbutton.bgImage, displayInfo);
				else 
					bossbutton.bgImage:SetTexture(nil);
				end
				bossbutton:ClearAllPoints();
				bossbutton:SetPoint("TOPLEFT", "AtlasFrameLarge", "TOPLEFT", info_x, -info_y - 82+15);
				bossbutton:SetID(info_id);
				bossbutton:Show();

				bossindex = bossindex + 1;
			elseif (info_x and info_y) then
				button = _G["AtlasMapNPCButtonL"..buttonindex];
				if (not button) then
					button = CreateFrame("Button", "AtlasMapNPCButtonL"..buttonindex, AtlasFrameLarge, "AtlasMapNPCButtonTemplate");
				end
				local text = _G[button:GetName().."_Text"];
				if (text) then
					text:SetText("");
				end
				button.TaxiImage:SetTexture(nil);
				button.bgImage:SetTexture(nil);
				--button.LetterImage:SetTexture(nil);

				local tip_title;
				for k, v in pairs(AtlasMaps[zoneID]) do
					if (v[2] == info_id) then
						tip_title = v[1];
						local _, endpos = strfind(tip_title, ") ");
						if (endpos) then
							button.tooltipTitle = strsub(tip_title, endpos+1);
						end
					end
				end

				if (info_colortag) then
--[[
					-- Arith: 2016.08.15 - I decided to use fontstring instead of pre-made character image. But codes can be left here for future reference until I don't need it anymore.
					if (info_colortag == "Blue" or info_colortag == "Purple") then
						local texcoord;
						texcoord = "Atlas_Letter_"..info_colortag.."_"..info_mark;
						button.LetterImage:SetTexture("Interface\\AddOns\\Atlas\\Images\\Atlas_Marks_Letters1");
						button.LetterImage:SetTexCoord(unpack(ATLAS_LETTER_MARKS_TCOORDS[texcoord]));
						button:SetWidth(20);
						button:SetHeight(20);
]]
					if (info_colortag == "Dungeon" or info_colortag == "Raid") then
						button.bgImage:SetTexture("Interface\\MINIMAP\\"..info_colortag);
					elseif (info_colortag == "Battlegrounds") then
						button.bgImage:SetTexture("Interface\\MINIMAP\\Tracking\\BattleMaster");
					elseif (info_colortag == "FlightMaster") then
						button.TaxiImage:SetTexture("Interface\\MINIMAP\\Tracking\\FlightMaster");
						button.TaxiImage:SetTexCoord(0, 1, 0, 1);
					elseif (info_colortag == "TaxiAlliance" or info_colortag == "TaxiHorde" or info_colortag == "TaxiNeutral" ) then
						button.TaxiImage:SetTexture("Interface\\AddOns\\Atlas\\Images\\POIICONS");
						button.TaxiImage:SetTexCoord(unpack(ATLAS_TAXI_TCOORDS[info_colortag]));
					elseif (info_colortag == "White" or 
						info_colortag == "Yellow" or 
						info_colortag == "Red" or 
						info_colortag == "Orange" or 
						info_colortag == "Green" or 
						info_colortag == "Purple" or
						info_colortag == "Blue") then
						if (not text) then
							text = button:CreateFontString(button:GetName().."_Text", "MEDIUM", "AtlasSystemFont_Large_Outline_Thick");
						end
						text:SetPoint("CENTER", button, "CENTER", 0, 0);
						text:SetText(info_mark);
						text:SetTextColor(unpack(ATLAS_FONT_COLORS[info_colortag]));
						button:SetWidth(20);
						button:SetHeight(20);
					else
						-- Do Nothing
					end
					
				end
				button:SetPoint("TOPLEFT", "AtlasFrameLarge", "TOPLEFT", info_x + 18, -info_y - 82 );
				button:SetID(info_id);
				button:Show();

				buttonindex = buttonindex + 1;
			else
				-- Do Nothing;
			end

			i = i + 1;
		end
	end

	bossbutton = _G["AtlasMapBossButtonL"..bossindex];
	while bossbutton do
		bossbutton.bgImage:SetTexture(nil);
		bossbutton:Hide();
		bossindex = bossindex + 1;
		bossbutton = _G["AtlasMapBossButtonL"..bossindex];
	end
	
	button = _G["AtlasMapNPCButtonL"..buttonindex];
	while button do
		button.bgImage:SetTexture(nil);
		button:Hide();
		buttonindex = buttonindex + 1;
		button = _G["AtlasMapNPCButtonL"..buttonindex];
	end
end

-- Calculate the dungeon difficulty based on the dungeon's level and player's level
-- Codes adopted from FastQuest_Classic
function Atlas_DungeonDifficulty(minRecLevel)
	local lDiff = minRecLevel - UnitLevel("player");
	local color;
	if (lDiff >= 0) then
		for i= 1.00, 0.10, -0.10 do
			color = {r = 1.00, g = i, b = 0.00};
			if ((i/0.10)==(10-lDiff)) then return color; end
		end
	elseif ( -lDiff < GetQuestGreenRange() ) then
		for i= 0.90, 0.10, -0.10 do
			color = {r = i, g = 1.00, b = 0.00};
			if ((9-i/0.10)==(-1*lDiff)) then return color; end
		end
	elseif ( -lDiff == GetQuestGreenRange() ) then
		color = {r = 0.50, g = 1.00, b = 0.50};
	else
		--color = {r = 0.75, g = 0.75, b = 0.75};
		color = {r = 1.00, g = 1.00, b = 1.00};
	end
	return color;
end

-- When the switch button is clicked
-- We can basically assume that there's a match
-- Find it, set it, then update menus and the maps
function AtlasSwitchButton_OnClick()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	if (getn(ATLAS_INST_ENT_DROPDOWN) == 1) then
		-- One link, so we can just go there right away
		AtlasSwitchDD_Set(1);
	else
		-- More than one link, so it's dropdown menu time
		Lib_ToggleDropDownMenu(1, nil, AtlasSwitchDD, "AtlasSwitchButton", 0, 0);
	end
end

function AtlasSwitchDD_OnLoad()
	local info;
	for k, v in pairs(ATLAS_INST_ENT_DROPDOWN) do
		info = {
			text = AtlasMaps[v].ZoneName[1];
			func = AtlasSwitchDD_OnClick;
		};
		Lib_UIDropDownMenu_AddButton(info);
	end
end

function AtlasSwitchDD_OnClick(self)
	AtlasSwitchDD_Set(self:GetID());
end

function AtlasSwitchDD_Set(index)
	for k, v in pairs(ATLAS_DROPDOWNS) do
		for k2, v2 in pairs(v) do
			if (v2 == ATLAS_INST_ENT_DROPDOWN[index]) then
				AtlasOptions.AtlasType = k;
				AtlasOptions.AtlasZone = k2;
			end
		end
	end
	AtlasFrameDropDownType_OnShow();
	AtlasFrameDropDown_OnShow();
	Atlas_Refresh();
end

function AtlasSwitchDD_Sort(a, b)
	local aa = AtlasMaps[a].ZoneName[1];
	local bb = AtlasMaps[b].ZoneName[1];
	return aa < bb;
end

-- Function used to initialize the map type dropdown menu
-- Cycle through Atlas_MapTypes to populate the dropdown
function AtlasFrameDropDownType_Initialize()
	local info;
	local catName = Atlas_DropDownLayouts_Order[AtlasOptions.AtlasSortBy];
	local subcatOrder = Atlas_DropDownLayouts_Order[catName];
	for i = 1, getn(subcatOrder), 1 do
		info = {
			text = subcatOrder[i];
			func = AtlasFrameDropDownType_OnClick;
		};
		Lib_UIDropDownMenu_AddButton(info);
	end
	for i = 1, getn(Atlas_MapTypes), 1 do
		info = {
			text = Atlas_MapTypes[i];
			func = AtlasFrameDropDownType_OnClick;
		};
		Lib_UIDropDownMenu_AddButton(info);
	end
end

-- Called whenever the map type dropdown menu is shown
function AtlasFrameDropDownType_OnShow()
	Lib_UIDropDownMenu_Initialize(AtlasFrameDropDownType, AtlasFrameDropDownType_Initialize);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, AtlasOptions.AtlasType);
	Lib_UIDropDownMenu_SetWidth(AtlasFrameDropDownType, 190);

	Lib_UIDropDownMenu_Initialize(AtlasFrameLargeDropDownType, AtlasFrameDropDownType_Initialize);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDownType, AtlasOptions.AtlasType);
	Lib_UIDropDownMenu_SetWidth(AtlasFrameLargeDropDownType, 190);

	Lib_UIDropDownMenu_Initialize(AtlasFrameSmallDropDownType, AtlasFrameDropDownType_Initialize);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDownType, AtlasOptions.AtlasType);
	Lib_UIDropDownMenu_SetWidth(AtlasFrameSmallDropDownType, 190);
end

-- Called whenever an item in the map type dropdown menu is clicked
-- Sets the main dropdown menu contents to reflect the category of map selected
function AtlasFrameDropDownType_OnClick(self)
	local thisID = self:GetID();
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, thisID);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDownType, thisID);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDownType, thisID);

	AtlasOptions.AtlasType = thisID;
	AtlasOptions.AtlasZone = 1;
	AtlasFrameDropDown_OnShow();
	Atlas_Refresh();
end

-- Function used to initialize the main dropdown menu
-- Looks at the status of AtlasType to determine how to populate the list
function AtlasFrameDropDown_Initialize()
	local info;
	local colortag;
	for k, v in pairs(ATLAS_DROPDOWNS[AtlasOptions.AtlasType]) do
		
		if (AtlasOptions["AtlasColoringDropDown"] and AtlasMaps[v].DungeonID) then
			local _, _, _, _, _, _, minRecLevel = GetLFGDungeonInfo(AtlasMaps[v].DungeonID);
			local dungeon_difficulty = Atlas_DungeonDifficulty(minRecLevel);
			colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
		elseif (AtlasOptions["AtlasColoringDropDown"] and AtlasMaps[v].MinLevel) then
			if (type(AtlasMaps[v].MinLevel) == number) then
				local dungeon_difficulty = Atlas_DungeonDifficulty(AtlasMaps[v].MinLevel);
				colortag = string.format("|cff%02x%02x%02x", dungeon_difficulty.r * 255, dungeon_difficulty.g * 255, dungeon_difficulty.b * 255);
			else
				colortag = ""
			end
		else
			colortag = ""
		end
		info = {
			text = colortag..AtlasMaps[v].ZoneName[1];
			func = AtlasFrameDropDown_OnClick;
		};
		Lib_UIDropDownMenu_AddButton(info);
	end
end

-- Called whenever the main dropdown menu is shown
function AtlasFrameDropDown_OnShow()
	Lib_UIDropDownMenu_Initialize(AtlasFrameDropDown, AtlasFrameDropDown_Initialize);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, AtlasOptions.AtlasZone);
	Lib_UIDropDownMenu_SetWidth(AtlasFrameDropDown, 190);

	Lib_UIDropDownMenu_Initialize(AtlasFrameLargeDropDown, AtlasFrameDropDown_Initialize);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDown, AtlasOptions.AtlasZone);
	Lib_UIDropDownMenu_SetWidth(AtlasFrameLargeDropDown, 190);

	Lib_UIDropDownMenu_Initialize(AtlasFrameSmallDropDown, AtlasFrameDropDown_Initialize);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDown, AtlasOptions.AtlasZone);
	Lib_UIDropDownMenu_SetWidth(AtlasFrameSmallDropDown, 190);
end

-- Called whenever an item in the main dropdown menu is clicked
-- Sets the newly selected map as current and refreshes the frame
function AtlasFrameDropDown_OnClick(self)
	local i = self:GetID();
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, i);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDown, i);
	Lib_UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDown, i);

	AtlasOptions.AtlasZone = i;
	Atlas_Refresh();
end

-- Modifies the value of GetRealZoneText to account for some naming conventions
-- Always use this function instead of GetRealZoneText within Atlas
function Atlas_GetFixedZoneText()
	local currentZone = GetRealZoneText();
	if (AtlasZoneSubstitutions[currentZone]) then
		return AtlasZoneSubstitutions[currentZone];
	end
	return currentZone;
end 

-- Checks the player's current location against all Atlas maps
-- If a match is found display that map right away
-- update for Outland zones contributed by Drahcir
-- 3/23/08 now takes SubZones into account as well
function Atlas_AutoSelect()
	local currentZone = Atlas_GetFixedZoneText();
	local currentSubZone = GetSubZoneText();
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
--[[
	local factionGroup = UnitFactionGroup("player");
	if ( factionGroup and factionGroup ~= "Neutral" ) then
		if ( factionGroup == "Alliance" ) then
			
		elseif ( factionGroup == "Horde" ) then
			
		end
	end
]]
	debug("Using auto-select to open the best map.");

	-- Check if the current zone is defined in AssocDefaults table
	-- If yes, means there could be multiple maps for this zone
	-- And we will choose a proper one to be the default one.
	debug("currentZone: "..currentZone..", currentSubZone: "..currentSubZone);
	if (Atlas_AssocDefaults[currentZone]) then
		debug("currentZone: "..currentZone.." matched the one defined in Atlas_AssocDefaults{}.");
		local selected_map;
		if (Atlas_SubZoneData[currentZone]) then
			for k_instance_map, v_instance_map in pairs(Atlas_SubZoneData[currentZone]) do
				for k_subzone, v_subzone in pairs(Atlas_SubZoneData[currentZone][k_instance_map]) do
					if (v_subzone == currentSubZone) then
						selected_map = k_instance_map;
						debug("currentSubZone: "..currentSubZone.." matched found, now we will use map: \""..selected_map.."\" for instance: "..currentZone);
						break;
					end
				end
			end
		end
		if (not selected_map) then
			debug("No subzone matched, now checking if we should specify a default map.");
			if (currentZone == Atlas_SubZoneAssoc[zoneID]) then
				debug("You're in the same instance as the former map. Doing nothing.");
				return;
			else
				selected_map = Atlas_AssocDefaults[currentZone];
				debug("We will use the map: "..selected_map.." for the current zone: "..currentZone..".");
			end
		end
		debug("Selecting the map...");
		for k_DropDownType, v_DropDownType in pairs(ATLAS_DROPDOWNS) do
			for k_DropDownZone, v_DropDownZone in pairs(v_DropDownType) do         
				if (selected_map == v_DropDownZone) then
					AtlasOptions.AtlasType = k_DropDownType;
					AtlasOptions.AtlasZone = k_DropDownZone;
					Atlas_Refresh();
					debug("Map selected! Type: "..k_DropDownType..", Zone: "..k_DropDownZone..", "..zoneID);
					return;
				end
			end
		end
	else
		debug("SubZone data isn't relevant here. Checking if it's outdoor zone.");
		if (Atlas_OutdoorZoneToAtlas[currentZone]) then
			debug("This world zone "..currentZone.." is associated with a map.");
			for k_DropDownType, v_DropDownType in pairs(ATLAS_DROPDOWNS) do
				for k_DropDownZone, v_DropDownZone in pairs(v_DropDownType) do         
					if (Atlas_OutdoorZoneToAtlas[currentZone] == v_DropDownZone) then
						AtlasOptions.AtlasType = k_DropDownType;
						AtlasOptions.AtlasZone = k_DropDownZone;
						Atlas_Refresh();
						debug("Map changed to the associated map: "..zoneID);
						return;
					end
				end
			end
			debug("Checking if instance/entrance pair can be found.");
		elseif (Atlas_InstToEntMatches[zoneID]) then
			for ka, va in pairs(Atlas_InstToEntMatches[zoneID]) do
				if (currentZone == AtlasMaps[va].ZoneName[1]) then
					debug("Instance/entrance pair found. Doing nothing.");
					return;
				end
			end
		elseif (Atlas_EntToInstMatches[zoneID]) then
			for ka, va in pairs(Atlas_EntToInstMatches[zoneID]) do
				if (currentZone == AtlasMaps[va].ZoneName[1]) then
					debug("Instance/entrance pair found. Doing nothing.");
					return;
				end
			end
		end
		debug("Searching through all maps for a ZoneName match.");
		for k_DropDownType, v_DropDownType in pairs(ATLAS_DROPDOWNS) do
			for k_DropDownZone, v_DropDownZone in pairs(v_DropDownType) do         
				-- Compare the currentZone to the new substr of ZoneName
				if (currentZone == strsub(AtlasMaps[v_DropDownZone].ZoneName[1], strlen(AtlasMaps[v_DropDownZone].ZoneName[1]) - strlen(currentZone) + 1)) then
					AtlasOptions.AtlasType = k_DropDownType;
					AtlasOptions.AtlasZone = k_DropDownZone;
					Atlas_Refresh();
					debug("Found a match. Map has been changed.");
					return;
				end
			end
		end
	end
	debug("Nothing changed because no match was found.");
end

--Called whenever the Atlas frame is displayed
function Atlas_OnShow()
	if (AtlasOptions.AtlasAutoSelect) then
		Atlas_AutoSelect();
	end
	-- Sneakiness
	AtlasFrameDropDownType_OnShow();
	AtlasFrameDropDown_OnShow();
end


function AtlasScrollBar_Update()
	GameTooltip:Hide();
	local lineplusoffset;
	FauxScrollFrame_Update(AtlasScrollBar,ATLAS_CUR_LINES,ATLAS_NUM_LINES,15);
	for i = 1, ATLAS_NUM_LINES do
		lineplusoffset = i + FauxScrollFrame_GetOffset(AtlasScrollBar);
		if (lineplusoffset <= ATLAS_CUR_LINES) then
			_G["AtlasEntry"..i.."_Text"]:SetText(ATLAS_SCROLL_LIST[lineplusoffset]);
			if (ATLAS_SCROLL_ID[lineplusoffset]) then
				_G["AtlasEntry"..i]:SetID(ATLAS_SCROLL_ID[lineplusoffset]);
			end
			_G["AtlasEntry"..i]:Show();
		elseif (_G["AtlasEntry"..i]) then
			_G["AtlasEntry"..i]:Hide();
		end
	end
end

function AtlasSimpleSearch(data, text)
	if (string.trim(text or "") == "") then
		return data
	end
	local new = {}; -- Create a new table
	local i, v, n;
	local search_text = string.lower(text);
	search_text = search_text:gsub("([%^%$%(%)%%%.%[%]%+%-%?])", "%%%1");
	search_text = search_text:gsub("%*", ".*");
	local match;

	i, v = next(data, nil); -- The i is an index of data, v = data[i]
	n = i;
	while i do
		if ( type(i) == "number" ) then
			if ( string.gmatch ) then 
				match = string.gmatch(string.lower(data[i][1]), search_text)();
			else 
				match = string.gfind(string.lower(data[i][1]), search_text)(); 
			end
			if ( match ) then
				new[n] = {};
				new[n][1] = data[i][1];
				n = n + 1;
			end
		end
		i, v = next(data, i); -- Get next index
	end
	return new;
end

local function round(num, idp)
	local mult = 10 ^ (idp or 0);
	return math.floor(num * mult + 0.5) / mult;
end

function AtlasEntryTemplate_OnUpdate(self)
	if (MouseIsOver(self)) then
		if (IsControlKeyDown() and AtlasOptions.AtlasCtrl) then
			if (not GameTooltip:IsShown()) then
				local str = _G[self:GetName().."_Text"]:GetText();
				if (str) then
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
					GameTooltip:SetBackdropBorderColor(0, 0, 0, 0);
					GameTooltip:SetBackdropColor(0, 0, 0, 1);
					local colorCheck = string.sub(str, 1, 4);
					if (colorCheck == "|cff") then
						local color = string.sub(str, 1, 10);
						local stripped = strtrim(string.sub(str, 11));
						GameTooltip:SetText(color..stripped, 1, 1, 1, 1);
					else
						GameTooltip:SetText(str, 1, 1, 1, 1);
					end
				end
			end
		else
			local id = self:GetID();
			if (id > 0 and id < 10000) then
				local ejbossname, description, _, rootSectionID;

				ejbossname, description, _, rootSectionID = EJ_GetEncounterInfo(id); 
				if (ejbossname) then
					GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
					GameTooltip:SetBackdropColor(0, 0, 0, 1 * AtlasOptions["AtlasAlpha"]);
					GameTooltip:SetText(ejbossname, 1, 1, 1, nil, 1);
					if (description) then GameTooltip:AddLine(description, nil, nil, nil, 1); end
					if (ejbossname and EncounterJournal_CheckForOverview(rootSectionID)) then
						local _, overviewDescription = EJ_GetSectionInfo(rootSectionID);
						GameTooltip:AddLine("\n"..OVERVIEW, 1, 1, 1, 1)
						GameTooltip:AddLine(overviewDescription, nil, nil, nil, 1);
					end
					GameTooltip:SetScale(AtlasOptions["AtlasBossDescScale"] * AtlasOptions["AtlasScale"]);
					GameTooltip:Show();
				end
			end
		end
	end
end

function AtlasEntry_OnClick(self)
	local encounterID = self:GetID();
	
	Atlas_AdventureJournal_EncounterButton_OnClick(encounterID);
end

function AtlasFrame_ToggleWindowSize()
	if ( AtlasFrameLarge:IsVisible() ) then
		if (ATLAS_SMALLFRAME_SELECTED) then
			HideUIPanel(AtlasFrameLarge);
			ShowUIPanel(AtlasFrameSmall);
		else
			HideUIPanel(AtlasFrameLarge);
			ShowUIPanel(AtlasFrame);
		end
	else
		if (ATLAS_SMALLFRAME_SELECTED) then
			HideUIPanel(AtlasFrameSmall);
			ShowUIPanel(AtlasFrameLarge);
		else
			HideUIPanel(AtlasFrame);
			ShowUIPanel(AtlasFrameLarge);
		end
	end
end

function AtlasFrame_ToggleLegendPanel()
	if ( AtlasFrameSmall:IsVisible() ) then
		ATLAS_SMALLFRAME_SELECTED = false;
		HideUIPanel(AtlasFrameSmall);
		ShowUIPanel(AtlasFrame);
	else
		ATLAS_SMALLFRAME_SELECTED = true;
		HideUIPanel(AtlasFrame);
		ShowUIPanel(AtlasFrameSmall);
	end
end

function AtlasToggleFromWorldMap_OnClick(self)
	Atlas_AutoSelect_from_WorldMap();
	ToggleFrame(WorldMapFrame);
	Atlas_Toggle();
end

function AtlasToggleFromEncounterJournal_OnClick(self)
	Atlas_AutoSelect_from_EncounterJournal();
	ToggleFrame(EncounterJournal);
	Atlas_Toggle();
end

function Atlas_AutoSelect_from_WorldMap()
	local mapID, _ = GetCurrentMapAreaID();
	local dungeonLevel = GetCurrentMapDungeonLevel();
	
	if (not mapID) then
		return;
	end

	for type_k, type_v in pairs(ATLAS_DROPDOWNS) do
		for zone_k, zone_v in pairs(type_v) do
			local AtlasWorldMapID = tonumber(AtlasMaps[zone_v].WorldMapID);
			local AtlasMapDungeonLevel = tonumber(AtlasMaps[zone_v].DungeonLevel);
			local AtlasMapFaction = AtlasMaps[zone_v].Faction;
			if (AtlasWorldMapID and AtlasWorldMapID == mapID) then
				if (AtlasMapFaction and AtlasMapFaction == ATLAS_PLAYER_FACTION) then
					AtlasOptions.AtlasType = type_k;
					AtlasOptions.AtlasZone = zone_k;
					Atlas_Refresh();
					return;
				else
					if (dungeonLevel > 0 and AtlasMapDungeonLevel) then
						if (AtlasMapDungeonLevel == dungeonLevel) then
							AtlasOptions.AtlasType = type_k;
							AtlasOptions.AtlasZone = zone_k;
						end
					else
						AtlasOptions.AtlasType = type_k;
						AtlasOptions.AtlasZone = zone_k;
					end
				end
			end
		end
	end
	Atlas_Refresh();
end

function Atlas_AutoSelect_from_EncounterJournal()
	local instanceID = EncounterJournal.instanceID;
	
	if (not instanceID) then
		return;
	end

	for type_k, type_v in pairs(ATLAS_DROPDOWNS) do
		for zone_k, zone_v in pairs(type_v) do
			if (AtlasMaps[zone_v].JournalInstanceID and tonumber(AtlasMaps[zone_v].JournalInstanceID) == instanceID) then
				AtlasOptions.AtlasType = type_k;
				AtlasOptions.AtlasZone = zone_k;
				Atlas_Refresh();
				return;
			end
		end
	end
end

--[[
-- In Development, this could be fun
function AtlasSetEJBackground(instanceID)
	local f = _G["AtlasEJBackground"];
	if (not f) then
		f = CreateFrame("Frame", "AtlasEJBackground", AtlasFrame);
	end
	f:ClearAllPoints();
	f:SetWidth(610);
	f:SetHeight(610);
	f:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 530, -85);
	--f:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 550, -220);
	if (instanceID) then
		local t = f:CreateTexture(nil,"BACKGROUND");
		local name, description, bgImage, buttonImage, loreImage, dungeonAreaMapID, link = EJ_GetInstanceInfo(instanceID)
		t:SetTexture(bgImage);
		t:SetAllPoints();
		f.Texture = t;
		f:Show()
	else
		local t = f:CreateTexture(nil,"BACKGROUND");
		t:SetTexture(nil);
		t:SetAllPoints();
		f.Texture = t;
		f:Hide()
	end
end
]]


