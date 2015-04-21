local GlobalAddonName, ExRT = ...

-- https://github.com/aleksandyr/AddOns/blob/master/!BlizzBugsSuck/BlizzBugsSuck.lua
-- Fix an issue where the "DEATH" StaticPopup is wrongly shown when reloading the
-- UI.  The cause of the problem is in UIParent.lua around line 889 it seems
-- GetReleaseTimeRemaining is wrongly returning a non-zero value on the first
-- PLAYER_ENTERING_WORLD event.
hooksecurefunc("StaticPopup_Show", function(which)
	if which == "DEATH" and not UnitIsDead("player") then
		StaticPopup_Hide("DEATH")
	end
end)

-- Fix 5.4.2 dropDown & tooltip
-- minWidth do nothing since 5.4.2
do
	hooksecurefunc("UIDropDownMenu_OnUpdate", function (self, elapsed)
		if ExRT.mds and ExRT.mds.dropDownBlizzFix then
			self:SetWidth(ExRT.mds.dropDownBlizzFix + 25)
		end
	end)
	hooksecurefunc("UIDropDownMenu_OnHide", function ()
		if ExRT.mds then
			ExRT.mds.dropDownBlizzFix = nil
		end
	end)
end

-- RELOAD UI short command
SLASH_RELOADUI1 = "/rl"
SlashCmdList["RELOADUI"] = ReloadUI


-- Beta enUS & cyrillic fix
if ExRT.BETA and ExRT.locale:find("^en") then
	GameFontHighlightSmall:SetFont("Fonts\\FRIZQT___CYR.TTF",select(2,GameFontHighlightSmall:GetFont()))
	GameFontNormalSmall:SetFont("Fonts\\FRIZQT___CYR.TTF",select(2,GameFontNormalSmall:GetFont()))
end


-- Languages fix
if ExRT.locale:find("^zh") then
	ExRTFontNormal:SetFont("Fonts\\ARHei.ttf",select(2,ExRTFontNormal:GetFont()))
elseif ExRT.locale == "koKR" then
	ExRTFontNormal:SetFont("Fonts\\2002.ttf",select(2,ExRTFontNormal:GetFont()))
end

-- Fix 6.1 multiline text in options frame
do
	for i=1,35 do
		local frame = _G["InterfaceOptionsFrameAddOnsButton"..i.."Text"]
		if frame then
			frame:SetMaxLines(1)
		end
	end
end