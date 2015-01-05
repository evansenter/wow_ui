--This file contains the set/get functions for all the options
--Author: Eldrikt
--Created 23.11.2012

--get the autoLinkWhenLootMaster parameter
function LinkLoot:IsAutoLink(info)
    return self.db.profile.General.autoLinkWhenLootMaster;
end

--set the autoLinkWhenLootMaster parameter
function LinkLoot:ToggleAutoLink(info, newValue)
	self.db.profile.General.autoLinkWhenLootMaster = newValue;
end

--get the checkLootTreshold parameter
function LinkLoot:IsCheckLootThreshold(info)
    return self.db.profile.General.checkLootThreshold;
end

--set the checkLootTreshold parameter
function LinkLoot:ToggleCheckLootThreshold(info, newValue)
	self.db.profile.General.checkLootThreshold = newValue;
end

--get the LinkChatOption parameter
function LinkLoot:GetLinkChatOption(info)
    return self.db.profile.General.LinkChatOption;
end

--set the LinkChatOption parameter
function LinkLoot:SetLinkChatOption(info, newValue)
	self.db.profile.General.LinkChatOption = newValue;
end

--get the showExtendedInfo parameter
function LinkLoot:IsShowExtendedInfo(info)
    return self.db.profile.General.showExtendedInfo;
end

--set the showExtendedInfo parameter
function LinkLoot:ToggleShowExtendedInfo(info, newValue)
	self.db.profile.General.showExtendedInfo = newValue;
end

--get the showMinimapIcon parameter
function LinkLoot:IsShowMinimapIcon(info)
    return self.db.profile.General.showMinimapIcon;
end

--set the showMinimapIcon parameter
function LinkLoot:ToggleShowMinimapIcon(info, newValue)
	self.db.profile.General.showMinimapIcon = newValue;
	LinkLoot:updateIconState();
end
