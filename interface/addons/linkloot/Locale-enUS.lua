--Author: Eldrikt
--Created 23.11.2012

local L = LibStub("AceLocale-3.0"):NewLocale("LinkLoot", "enUS", true)

--chat commands
L["linkloot"] = true
L["ll"] = true

--autoLinkWhenLootMaster
L["Link when Lootmaster"] = "Link only when Master Looter" --name
L["Automatically link available loot when you are the Master Looter"] = "Automatically link available loot when you are the Master Looter \nDisable this to always link available loot, if you are a the Master Looter or not" --description

--checkLootTreshold
L["Check Loot Treshold"] = true --name
L["Check if the loot treshold set is below the items you are trying to loot."] = "Check if the loot treshold set is below the items you are trying to loot. \n\nEnable this to link the loot only when there is something to be distributed by the Master Looter. \n\nDisable this to link loot every time you loot if you are the Master Looter, regardless of the item quality" --description

--show extended info
L["showExtendedInfo"] = "Show extended information"
L["showExtendedInfoDesc"] = "Enable to show additional item information like item slot and type"

--show Minimap Icon
L["showMinimapIcon"] = "Show Minimap Icon"
L["showMinimapIconDesc"] = "Enable to show the minimap icon"

--tooltips
L["|cffffff00Click|r to link loot from the open container"] = true
L["|cffffff00Right-click|r to open the options menu"] = true

L["General Settings"] = true
