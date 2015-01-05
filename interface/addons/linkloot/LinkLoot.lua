--Author: Eldrikt
--Created 23.11.2012

--init the addon as a Ace Addon
LinkLoot = LibStub("AceAddon-3.0"):NewAddon("LinkLoot", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("LinkLoot") --the table with the localized strings

--prepare for FuBar
local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LibStub("LibDBIcon-1.0", true)

LL_DEBUG = false;

--the local options
local options = {
	name = "LinkLoot",
	handler = LinkLoot,
	type = "group",
	args = {
		General = {
			type = "group",
			name = L["General Settings"],
			desc = L["General Settings"],
			handler = LinkLoot,
			args = {
				autoLinkWhenLootMaster = {
					type = "toggle", 									--check box
					name = L["Link when Lootmaster"], 					--title to be displayed
					desc = L["Automatically link available loot when you are the Master Looter"],  --tooltip description
					get = "IsAutoLink",								--get method
					set = "ToggleAutoLink",							--set method
					order = 1,
				},
				checkLootThreshold = {
					type = "toggle", 									--check box
					name = L["Check Loot Treshold"], 					--title to be displayed
					desc = L["Check if the loot treshold set is below the items you are trying to loot."],  --tooltip descroption
					get = "IsCheckLootThreshold",								--get method
					set = "ToggleCheckLootThreshold",							--set method
					order = 2,
				},
				LinkChatOption = {
					type = "select",
					values = {
						["NONE"] = "none",
						["SAY"] = "Say",
						["WHISPER"] = "Whisper",
						["RAID"] = "Raid",
						["PARTY"] = "Party",
						["GUILD"] = "Guild",
						["OFFICER"] = "Officer",
						["RAID_WARNING"] = "Raid Warning",
					},
					name = "Link loot in:",
					desc = "Select a chat to link the loot to.",
					get = "GetLinkChatOption",
					set = "SetLinkChatOption",
					order = 3,
				},
				showExtendedInfo = {
					type = "toggle", 										--check box
					name = L["showExtendedInfo"], 							--title to be displayed
					desc = L["showExtendedInfoDesc"],  						--tooltip description
					get = "IsShowExtendedInfo",								--get method
					set = "ToggleShowExtendedInfo",							--set method
					order = 4,
				},
				showMinimapIcon = {
					type = "toggle", 										--check box
					name = L["showMinimapIcon"], 							--title to be displayed
					desc = L["showMinimapIconDesc"],  						--tooltip description
					get = "IsShowMinimapIcon",								--get method
					set = "ToggleShowMinimapIcon",							--set method
					order = 5,
				},
			},
		},
	},
}


--the defaults
local defaults = {
	profile = {
		General = {
			autoLinkWhenLootMaster = true,
			checkLootThreshold = true,
			LinkChatOption = "RAID",
			showExtendedInfo = true,
			showMinimapIcon = true,
		},
		LDBIconStorage = {}, -- LibDBIcon storage
	},
}

local IconRegistered = false;
local LDBObj = nil

--Initialize stuff here
function LinkLoot:OnInitialize()
    -- Called when the addon is loaded
	--                                 defined in TOC,             ,Profile Name
	self.db = LibStub("AceDB-3.0"):New("LinkLootDB", defaults, "Deafult");
	--add profiles support
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	--Add to Blizzard options
	LibStub("AceConfig-3.0"):RegisterOptionsTable("LinkLoot", options);
	--LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("LinkLoot Blizz", options);
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("LinkLoot Profile", options.args.profile);
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("LinkLoot General", options.args.General);
	
	local AceConfigDialog = LibStub("AceConfigDialog-3.0");
	AceConfigDialog:AddToBlizOptions("LinkLoot General", "LinkLoot");
	AceConfigDialog:AddToBlizOptions("LinkLoot Profile", "Profile", "LinkLoot");
	
	--Register chat commands
	self:RegisterChatCommand("LinkLoot", "ChatCommand");
	self:RegisterChatCommand("ll", "ChatCommand");
	
	if LDB then
		local L_BMH_LEFT = L["|cffffff00Click|r to link loot from the open container"]
		local L_BMH_RIGHT = L["|cffffff00Right-click|r to open the options menu"]
		LL_DebugMsg("creating LibDataBroker object");
		LDBObj = LDB:NewDataObject("LinkLoot", {
			type = "launcher",
			icon = "Interface\\Icons\\Spell_Misc_ConjureManaJewel",
			label = "LinkLoot",
			OnClick = function(_,msg)
				if msg == "LeftButton" then
					LinkLoot:ListItems();
				elseif msg == "RightButton" then
					LinkLoot:ChatCommand("menu");
				end
			end,
			OnTooltipShow = function(tooltip)
				if not tooltip or not tooltip.AddLine then return end
				tooltip:AddLine("LinkLoot")
				tooltip:AddLine(L_BMH_LEFT)
				tooltip:AddLine(L_BMH_RIGHT)
			end,
		})
				
		if LDBIcon and LinkLoot.db.profile.General.showMinimapIcon then
			LDBIcon:Register("LinkLoot", LDBObj, LinkLoot.db.profile.LDBIconStorage)
			IconRegistered = true;
			LDBIcon:Hide("LinkLoot")
		end	
	end
end

function LinkLoot:updateIconState()	
	if LDBIcon then
		if LinkLoot.db.profile.General.showMinimapIcon then
			if not IconRegistered then
				LDBIcon:Register("LinkLoot", LDBObj, LinkLoot.db.profile.LDBIconStorage)
				IconRegistered = true;
			end
			LDBIcon:Show("LinkLoot")
		else
			LDBIcon:Hide("LinkLoot")
		end
	end
end

--handles the OnEnable event and set up message hooks
function LinkLoot:OnEnable()
    -- Called when the addon is enabled
	self:RegisterEvent("LOOT_OPENED");
	--LinkLoot:updateIconState()
end

LinkLoot_lastLootTarget = nil;

function LinkLoot:LOOT_OPENED()
	local listloot= true
	local targetName = GetUnitName("target");
	--dont link loot again if it is the same target
	--LL_DebugMsg("targetName: "..targetName)
	if (LinkLoot_lastLootTarget == targetName) then
		return
	else
		LinkLoot_lastLootTarget = targetName
	end
	
	if self.db.profile.General.autoLinkWhenLootMaster then 
	--list only when Master Looter is selected, so check if the player is the Master Looter
		local lootmethod, masterlooterPartyID, masterlooterRaidID = GetLootMethod();	
		if ((lootmethod == "master") and (masterlooterPartyID == 0)) then
			--the player is the Master Looter
			listloot = true
		else
			listloot = false
			--do not show the loot
		end
	end
	
	if listloot then
		LinkLoot:ListItems();
	end
end

--lists all items in chat
 function LinkLoot:ListItems(self)
	if (LinkLoot.db.profile.General.checkLootThreshold) then
		LL_DebugMsg("selected Loot Threshold: true")
	else
		LL_DebugMsg("selected Loot Threshold: false")
	end
	
	local itemnr = 0;
	for index=1,GetNumLootItems() do
		
		local lootIcon, lootName, lootQuantity, rarity, locked = GetLootSlotInfo(index);
		if not(rarity == nil) then
			LL_DebugMsg("rarity: "..rarity.." LootTreshold: "..GetLootThreshold())
			if   ((rarity >= GetLootThreshold() and LinkLoot.db.profile.General.checkLootThreshold) or ( not LinkLoot.db.profile.General.checkLootThreshold)) then
				local iteminfo = GetLootSlotLink(index);
				itemnr = itemnr+1;
				if not (iteminfo == nil) then
					LL_DebugMsg("iteminfo: "..iteminfo)
					local msg = itemnr..": "..iteminfo --the message to output
					
					if (LinkLoot.db.profile.General.showExtendedInfo) then
						LL_DebugMsg("show extended info: true")
					else
						LL_DebugMsg("show extended info: false")
					end
					
					if (LinkLoot.db.profile.General.showExtendedInfo) then
						--prepare extended item information
						local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc = GetItemInfo(iteminfo);
						--itemSubType is Cloth, Plate, Mail and the like
						if (itemSubType == nil) then 
							itemSubType = "";
						end
						LL_DebugMsg("itemSubType:"..itemSubType);
						--equipLoc is the slot. We need to translate the variable into a localized string before we can use it
						local equipLoc = _G[itemEquipLoc];
						if (equipLoc == nil) then
							equipLoc = "";
						end
						LL_DebugMsg("equipLoc:"..equipLoc);
						--extend the message with the additional information
						msg = msg.." "..itemSubType.." "..equipLoc;
						
					end
					
					if not (LinkLoot.db.profile.General.LinkChatOption == "NONE") then
						SendChatMessage(msg,LinkLoot.db.profile.General.LinkChatOption ,nil ,UnitName("player"));
					end
				end
			end
		end
	end
 end

--handle chat commands
function LinkLoot:ChatCommand(input)
	local params = input:trim();
	local par1,par2,par3,par4 = strsplit(" ", params);
	if params == "menu" then
		InterfaceOptionsFrame_OpenToCategory("LinkLoot");
	elseif params == "list" then
		LinkLoot:ListItems();
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(LinkLoot, "ll","LinkLoot", input);
	end
end

--outputs a debug message only if the BMH_DEBUG variable is set
function LL_DebugMsg(msg)
	if LL_DEBUG then
		LinkLoot:Print("LL: " .. msg);
		--DEFAULT_CHAT_FRAME:AddMessage("LinkLoot: " .. msg);
	end   
end


