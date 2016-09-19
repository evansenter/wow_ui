-- $Id: Atlas_Legion-enUS.lua 37 2016-09-05 14:55:07Z arith $
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

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas_Legion", "enUS", true, true);

if L then
	--Halls of Valor
	L["King Tor"] = "King Tor"; -- 97084
	L["King Bjorn"] = "King Bjorn"; -- 97081
	L["King Haldor"] = "King Haldor"; -- 95843
	L["King Ranulf"] = "King Ranulf"; -- 97083

	--Black Rook Hold 
	L["Dantalionax"] = "Dantalionax";

	--Vault of the Wardens

	--Eye of Azshara
	L["Crate of Corks"] = "Crate of Corks"; -- Alchemy quest - Put a Cork in It (39331)
	L["Put a Cork in It"] = "Put a Cork in It";

	--Darkheart Thicket

	--Neltharion's Lair
	L["Spiritwalker Ebonhorn"] = "Spiritwalker Ebonhorn"; -- 113526
	L["Mushroom Merchant"] = "Mushroom Merchant"; -- 111746

	--Maw of Souls
	L["Echoing Horn of the Damned"] = "Echoing Horn of the Damned";

	--The Arcway

	--Court of Stars

	--Assault on VioletHold

	--The Emerald Nightmare
	L["Nightmare Watcher"] = "Nightmare Watcher";
	L["Malfurion Stormrage"] = "Malfurion Stormrage";
	L["Teleport to Moonglade"] = "Teleport to Moonglade";

	--The Nighthold
	L["Teleport to Tichondrius / Grand Magistrix Elisande"] = "Teleport to Tichondrius / Grand Magistrix Elisande";

end