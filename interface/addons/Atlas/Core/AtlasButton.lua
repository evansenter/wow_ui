-- $Id: AtlasButton.lua 98 2016-09-09 08:18:21Z arith $
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


local AL = LibStub("AceLocale-3.0"):GetLocale("Atlas");

-- Minimap button with LibDBIcon-1.0
local addon = LibStub("AceAddon-3.0"):NewAddon("Atlas", "AceConsole-3.0")
local AtlasMiniMapLDB = LibStub("LibDataBroker-1.1"):NewDataObject("Atlas", {
	type = "launcher",
	text = AL["ATLAS_TITLE"],
	icon = "Interface\\WorldMap\\WorldMap-Icon",
	OnClick = function(self, button)
		if button == "LeftButton" then
			Atlas_Toggle();
		elseif button == "RightButton" then
			AtlasOptions_Toggle();
		end
	end,
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine("|cffffffff"..ATLAS_TITLE)
		tooltip:AddLine(ATLAS_MINIMAPLDB_HINT)
	end,
})


local AtlasMiniMapIcon = LibStub("LibDBIcon-1.0")

function addon:OnInitialize()
	-- Obviously you'll need a ##SavedVariables: BunniesDB line in your TOC, duh!
	self.db = LibStub("AceDB-3.0"):New("AtlasDB", {
		profile = {
			minimap = {
				hide = false,
				minimapPos = 190,
			},
		},
	})
	AtlasMiniMapIcon:Register("Atlas", AtlasMiniMapLDB, self.db.profile.minimap);
	self:RegisterChatCommand("atlasbutton", AtlasButton_Toggle)
	self:RegisterChatCommand("atlas", Atlas_SlashCommand)
end

function addon:Toggle()
	self.db.profile.minimap.hide = not self.db.profile.minimap.hide
	if self.db.profile.minimap.hide then
		AtlasMiniMapIcon:Hide("Atlas")
		AtlasOptions.AtlasButtonShown = false;
	else
		AtlasMiniMapIcon:Show("Atlas")
		AtlasOptions.AtlasButtonShown = true;
	end
	AtlasOptions_Init();
end

function AtlasButton_Toggle()
	addon:Toggle()
end


