-- $Id: AtlasJournalEncounter.lua 91 2016-09-02 17:56:36Z arith $
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

-- Atlas JournalEncounter Integration

local L = LibStub("AceLocale-3.0"):GetLocale("Atlas");
local BB = Atlas_GetLocaleLibBabble("LibBabble-Boss-3.0");

function Atlas_AdventureJournalButton_OnClick(frame)
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local data = AtlasMaps;
	local base = data[zoneID];

	if (not EJ_GetInstanceInfo(base.JournalInstanceID)) then
		return;
	end

	if ( not EncounterJournal or not EncounterJournal:IsShown() ) then
		ToggleEncounterJournal();
	end
	-- EncounterJournal_ListInstances();
	EncounterJournal_DisplayInstance(base.JournalInstanceID);

	Atlas_Toggle();
	if (not EncounterJournal:IsShown()) then
		EncounterJournal:Show();
	else
		EncounterJournal:Hide();
		EncounterJournal:Show();
	end
end

function Atlas_AdventureJournal_EncounterButton_OnClick(encounterID)
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local data = AtlasMaps;
	local base = data[zoneID];

	if (not EJ_GetInstanceInfo(base.JournalInstanceID)) then
		return;
	end
	if (not EJ_GetEncounterInfo(encounterID)) then
		return;
	end

	if ( not EncounterJournal or not EncounterJournal:IsShown() ) then
		ToggleEncounterJournal();
	end
	-- EncounterJournal_ListInstances();
	EncounterJournal_DisplayInstance(base.JournalInstanceID);
	EncounterJournal_DisplayEncounter(encounterID);

	Atlas_Toggle();
	if (not EncounterJournal:IsShown()) then
		EncounterJournal:Show();
	else
		EncounterJournal:Hide();
		EncounterJournal:Show();
	end
end


function AtlasFrameAdventureJournalButton_OnEnter(frame)
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local data = AtlasMaps;
	local base = data[zoneID];

	if (MouseIsOver(frame)) then
		if (EJ_GetInstanceInfo(base.JournalInstanceID)) then
			EJ_SelectInstance(base.JournalInstanceID);

			local name, description = EJ_GetInstanceInfo();

			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT");
			GameTooltip:SetText(name);
			GameTooltipTextLeft1:SetTextColor(1, 1, 1);
			GameTooltip:AddLine(description, nil, nil, nil, true);
			GameTooltip:AddLine(L["ATLAS_OPEN_ADVENTURE"], 0.5, 0.5, 1, true);
			GameTooltip:Show();
		end
	else
		GameTooltip:Hide();
	end
end

-- ------------------------------------------------------------
-- Call this function to translate boss name
-- Syntax 1: Atlas_GetBossName(bossname);
-- Syntax 2: Atlas_GetBossName(bossname, encounterID);
-- Syntax 2: Atlas_GetBossName(bossname, encounterID, creatureIndex);
-- ------------------------------------------------------------
function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	if (encounterID) then
		local encounter;
		if (creatureIndex) then
			if (EJ_GetCreatureInfo(creatureIndex, encounterID)) then
				local _;
				_, encounter = EJ_GetCreatureInfo(creatureIndex, encounterID);
			end
		else 
			if (EJ_GetEncounterInfo(encounterID)) then
				encounter, _, _, _, link = EJ_GetEncounterInfo(encounterID);
			end
		end
		if (encounter == nil) then
			if (bossname and BB[bossname]) then
				bossname = BB[bossname];
			elseif (bossname and L[bossname]) then
				bossname = L[bossname];
			else
				--bossname = bossname;
			end
		else
			bossname = encounter;
		end
	elseif (bossname and BB[bossname]) then
		bossname = BB[bossname];
	elseif (bossname and L[bossname]) then
		bossname = L[bossname];
	else
		--bossname = bossname;
	end

	return bossname;
end

function Atlas_EncounterJournal_Binding()
	local button = _G["AtlasToggleFromEncounterJournal"];
	if (not button) then
		button = CreateFrame("Button","AtlasToggleFromEncounterJournal", EncounterJournal);
		button:SetWidth(32);
		button:SetHeight(32);
		
		button:SetPoint("TOPRIGHT", EncounterJournalCloseButton, -23, 0, "TOPRIGHT"); 
		button:SetNormalTexture("Interface\\AddOns\\Atlas\\Images\\AtlasButton-Up");
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");

		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
			GameTooltip:SetText(L["ATLAS_CLICK_TO_OPEN"], nil, nil, nil, nil, 1);
		end);
		button:SetScript("OnLeave", function(self) GameTooltip:Hide(); end);
		button:SetScript("OnClick",AtlasToggleFromEncounterJournal_OnClick);
	end
end

function AtlasFrameAdventureJournalMapButton_OnClick()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local data = AtlasMaps;
	local base = data[zoneID];

	HideUIPanel(AtlasFrame);
	WorldMapFrame.fromJournal = true;
	ShowUIPanel(WorldMapFrame);
	if (base.WorldMapID) then
		SetMapByID(base.WorldMapID);
	end
	if (base.DungeonLevel) then
		SetDungeonMapLevel(base.DungeonLevel);
	end
end

function AtlasFrameLarge_OnShow(self)
	AtlasMap_AddNPCButtonLarge();
end

