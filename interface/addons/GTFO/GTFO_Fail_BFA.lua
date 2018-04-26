--------------------------------------------------------------------------
-- GTFO_Fail_BFA.lua 
--------------------------------------------------------------------------
--[[
GTFO Fail List - Battle for Azeroth
Author: Zensunim of Malygos
]]--


--- ******************************
--- * Battle for Azeroth (World) *
--- ******************************


GTFO.SpellID["268216"] = {
  --desc = "Earth Shattering (Azerite War Machine)";
  sound = 3;
};

GTFO.SpellID["269560"] = {
  --desc = "Landmine Explosion ";
  sound = 3;
};

-- ***********************
-- * Shrine of the Storm *
-- ***********************

GTFO.SpellID["267973"] = {
  --desc = "Wash Away (Temple Attendant)";
  sound = 3;
};

GTFO.SpellID["268059"] = {
  --desc = "Anchor of Binding (Tidesage Spiritualist)";
  sound = 3;
};

GTFO.SpellID["264773"] = {
  --desc = "Choking Brine (Aqu'sirr)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["267899"] = {
  --desc = "Hindering Cleave (Brother Ironhull)";
  sound = 3;
  tankSound = 0;
};

GTFO.SpellID["268280"] = {
  --desc = "Tidal Pod (Tidesage Enforcer)";
  sound = 3;
};

GTFO.SpellID["268391"] = {
  --desc = "Mental Assault (Abyssal Cultist)";
  applicationOnly = true;
  test = true; -- Is this actually avoidable?
  sound = 3;
};

GTFO.SpellID["269104"] = {
  --desc = "Explosive Void (Lord Stormsong)";
  sound = 3;
};

GTFO.SpellID["267956"] = {
  --desc = "Zap (Jellyfish)";
  sound = 3;
};

GTFO.SpellID["267385"] = {
  --desc = "Tentacle Slam (Vol'zith the Whisperer)";
  sound = 3;
};

-- ******************
-- * Waycrest Manor *
-- ******************

GTFO.SpellID["263905"] = {
  --desc = "Marking Cleave (Heartsbane Runeweaver)";
  sound = 3;
  tankSound = 0;
  test = true;
};

GTFO.SpellID["264531"] = {
  --desc = "Shrapnel Trap (Maddened Survivalist)";
  sound = 3;
  test = true;
};

GTFO.SpellID["264476"] = {
  --desc = "Tracking Explosive (Crazed Marksman)";
  sound = 3;
  test = true;
};

GTFO.SpellID["271174"] = {
  --desc = "Retch (Pallid Gorger)";
  sound = 3;
  test = true;
};

GTFO.SpellID["264923"] = {
  --desc = "Tenderize (Raal the Gluttonous)";
  sound = 3;
};

GTFO.SpellID["265757"] = {
  --desc = "Splinter Spike (Matron Bryndle)";
  sound = 3;
};

GTFO.SpellID["264150"] = {
  --desc = "Shatter (Thornguard)";
  sound = 3;
  test = true;
};

GTFO.SpellID["265372"] = {
  --desc = "Shadow Cleave (Enthralled Guard)";
  sound = 3;
  tankSound = 0;
};

-- ************
-- * Freehold *
-- ************

GTFO.SpellID["258673"] = {
  --desc = "Azerite Grenade (Irontide Crackshot)";
  sound = 3;
};

GTFO.SpellID["256106"] = {
  --desc = "Azerite Powder Shot (Skycap'n Kragg)";
  sound = 3;
  tankSound = 0;
  test = true;
};

GTFO.SpellID["258773"] = {
  --desc = "Charrrrrge (Skycap'n Kragg)";
  sound = 3;
};

GTFO.SpellID["258779"] = {
  --desc = "Sea Spout (Irontide Oarsman)";
  sound = 3;
  negatingDebuffSpellID = 274389;  -- Rat Trap
  -- negatingDebuffSpellID = 274400; -- Duelist Dash
  -- TODO: Add support for multiple spell IDs
};

GTFO.SpellID["272374"] = {
  --desc = "Whirlpool of Blades (Captain Jolly)";
  sound = 3;
};

GTFO.SpellID["267523"] = {
  --desc = "Cutting Surge (Captain Jolly)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["256594"] = {
  --desc = "Barrel Smash (Captain Raoul)";
  sound = 3;
  test = true;
};

GTFO.SpellID["257310"] = {
  --desc = "Cannon Barrage (Harlan Sweete)";
  sound = 3;
  test = true;
};

GTFO.SpellID["257315"] = {
  --desc = "Black Powder Bomb (Harlan Sweete)";
  sound = 3;
  test = true;
};

