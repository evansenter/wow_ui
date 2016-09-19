-- $Id: AtlasMaps_NPC_DB.lua 14 2016-05-11 10:04:42Z arith $
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

-- Atlas Map NPC Description Data
-- Maintainers: Arith, Dynaletik

AtlasMaps_NPC_DB = {
--[[
Syntax: 
	MapName = {
		{ number, EJ_BossID, X coordinate, Y coordinate };
		{ 2, 193,339, 435 };
	};
]]

--************************************************
-- Instance Entrance Maps
--************************************************

	BlackrockMountainEnt = {
		{ "A", 10001, 271, 182 };
		{ "B", 10002, 255, 498};
		{ "C", 10003, 158, 12};
		{ "D", 10004, 362, 308};
		{ "E", 10005, 220, 286};
		{ "F", 10006, 334, 419};
		{ "G", 10007, 432, 357};
		{ "1", 10008, 405, 356};
		{ "2", 10009, 136, 191};
		{ "3", 10010, 130, 33};
		{ "1'", 10011, 281, 350};
		{ "2'", 10012, 341, 391};
	};
	CavernsOfTimeEnt = {
		{ "A", 10001, 405, 170 }; -- Entrance
		{ "B", 10002, 140, 79 }; -- Hyjal Summit
		{ "C", 10003, 18, 156 }; -- Old Hillsbrad Foothills
		{ "D", 10004, 65, 442 }; -- The Black Morass
		{ "E", 10005, 263, 411 }; -- The Culling of Stratholme
		{ "F", 10006, 291, 170 }; -- Dragon Soul
		{ "G", 10007, 261, 201 }; -- End Time
		{ "H", 10008, 28, 298 }; -- Well of Eternity
		{ "I", 10009, 329, 210 }; -- Hour of Twilight
		{ "1'", 10010, 426, 170 }; -- Steward of Time <Keepers of Time>
		{ "2'", 10011, 461, 159 }; -- Alexston Chrome <Tavern of Time>
		{ "3'", 10012, 355, 148 }; -- Graveyard
		{ "4'", 10013, 323, 303 }; -- Yarley <Armorer>
		{ "5'", 10014, 313, 329 }; -- Bortega <Reagents & Poison Supplies>
		{ "6'", 10015, 196, 293 }; -- Zaladormu
		{ "7'", 10016, 198, 157 }; -- Moonwell
		{ "8'", 10017, 161, 216 }; -- Andormu <Keepers of Time>
		{ "9'", 10018, 146, 263 }; -- Anachronos <Keepers of Time>
		{ "10'", 10019, 115, 317 }; -- Andormu <Keepers of Time>
	};
};
