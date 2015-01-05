if not ShockAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("ShockAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local C = ShockAndAwe.constants -- Defined in Constants.LUA no locale needed.

ShockAndAwe.UptimeFrame = CreateFrame("Frame", "SAA_UptimeFrame", UIParent)

---------------------------
-- Uptime functions
---------------------------

function ShockAndAwe:InitialiseUptime()
	ShockAndAwe.uptime = {}
	ShockAndAwe.uptime = {
		session = {},
		lastfight = {},
		incombat = false,
		TimerEvent = nil,
		currentTime = nil,
	}
	self:InitialiseUptimeBuffs(ShockAndAwe.uptime.session)
	self:InitialiseUptimeBuffs(ShockAndAwe.uptime.lastfight)
end

function ShockAndAwe:InitialiseUptimeBuffs(timeframe)
	timeframe.totalTime = 0
	if not timeframe.buffs then
		timeframe.buffs = {}
	end
	if not timeframe.buffs[ShockAndAwe.constants["Flurry"]] then
		timeframe.buffs[ShockAndAwe.constants["Flurry"]] = {}
		timeframe.buffs[ShockAndAwe.constants["Flurry"]].name = ShockAndAwe.constants["Flurry"]
		timeframe.buffs[ShockAndAwe.constants["Flurry"]].icon = ShockAndAwe.constants["Flurry Icon"]
	end
	timeframe.buffs[ShockAndAwe.constants["Flurry"]].uptime = 0
end

function ShockAndAwe:UpdateUptime()
	if not ShockAndAwe.uptime.incombat then
		return
	end
	local currentTime = GetTime()
	-- add conditional safety measure - we should never have no current time but to be sure...
	if  not ShockAndAwe.uptime.currentTime then
		ShockAndAwe.uptime.currentTime = currentTime
	end
	local diffTime = currentTime - ShockAndAwe.uptime.currentTime
	
	ShockAndAwe.uptime.session.totalTime = ShockAndAwe.uptime.session.totalTime + diffTime;
	ShockAndAwe.uptime.lastfight.totalTime = ShockAndAwe.uptime.lastfight.totalTime + diffTime;
	
	local i = 1
	local buff = UnitBuff("player", i)
	while buff do
		if ShockAndAwe.uptime.session.buffs[buff] then
			ShockAndAwe.uptime.session.buffs[buff].uptime = ShockAndAwe.uptime.session.buffs[buff].uptime + diffTime
		end
		if ShockAndAwe.uptime.lastfight.buffs[buff] then
			ShockAndAwe.uptime.lastfight.buffs[buff].uptime = ShockAndAwe.uptime.lastfight.buffs[buff].uptime + diffTime
		end		
		i = i + 1
		buff = UnitBuff("player", i)
	end	
	ShockAndAwe.uptime.currentTime = currentTime
	self:UpdateUptimeFrames(false)
end

function ShockAndAwe:CreateUptimeFrame()
	ShockAndAwe.UptimeFrame:ClearAllPoints()
	ShockAndAwe.UptimeFrame:SetScale(ShockAndAwe.db.char.uptime.scale)
	ShockAndAwe.UptimeFrame:SetFrameStrata("BACKGROUND")
	ShockAndAwe.UptimeFrame:SetWidth(ShockAndAwe.db.char.uptime.fWidth + ShockAndAwe.db.char.uptime.barHeight)
	ShockAndAwe.UptimeFrame:SetHeight(ShockAndAwe.db.char.uptime.fHeight + 16)
	ShockAndAwe.UptimeFrame:SetBackdrop(self.frameBackdrop)
	ShockAndAwe.UptimeFrame:SetBackdropColor(0, 0, 0, ShockAndAwe.db.char.uptime.alpha)
	ShockAndAwe.UptimeFrame:SetMovable(true)
	ShockAndAwe.UptimeFrame:RegisterForDrag("LeftButton")
	ShockAndAwe.UptimeFrame:SetPoint(ShockAndAwe.db.char.uptime.point, ShockAndAwe.db.char.uptime.relativeTo, ShockAndAwe.db.char.uptime.relativePoint, ShockAndAwe.db.char.uptime.xOffset, ShockAndAwe.db.char.uptime.yOffset)
	ShockAndAwe.UptimeFrame:SetScript("OnDragStart", 
		function()
			ShockAndAwe.UptimeFrame:StartMoving();
		end );
	ShockAndAwe.UptimeFrame:SetScript("OnDragStop",
		function()
			ShockAndAwe.UptimeFrame:StopMovingOrSizing();
			ShockAndAwe.UptimeFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(ShockAndAwe.db.char.uptime, ShockAndAwe.UptimeFrame);
		end );
	
	local barfont = media:Fetch("font", ShockAndAwe.db.char.barfont)
	if not ShockAndAwe.UptimeFrame.topText then
		ShockAndAwe.UptimeFrame.topText = ShockAndAwe.UptimeFrame:CreateFontString(nil, "OVERLAY")
	end
	ShockAndAwe.UptimeFrame.topText:SetTextColor(1,1,1,1)
	ShockAndAwe.UptimeFrame.topText:SetFont(barfont, ShockAndAwe.db.char.barfontsize, ShockAndAwe.db.char.barfonteffect)
	ShockAndAwe.UptimeFrame.topText:SetPoint("TOP", ShockAndAwe.UptimeFrame, "TOP", 0, - 2)
	ShockAndAwe.UptimeFrame.topText:SetText(L["uptime_session"])
	
	if not ShockAndAwe.UptimeFrame.ResetButton then
		ShockAndAwe.UptimeFrame.ResetButton=CreateFrame("Button", nil, ShockAndAwe.UptimeFrame)
	end
	local size = ShockAndAwe.UptimeFrame.topText:GetHeight()
	ShockAndAwe.UptimeFrame.ResetButton:SetNormalTexture("Interface\\Addons\\ShockAndAwe\\textures\\icon-reset")
	ShockAndAwe.UptimeFrame.ResetButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	ShockAndAwe.UptimeFrame.ResetButton:SetWidth(size)
	ShockAndAwe.UptimeFrame.ResetButton:SetHeight(size)
	ShockAndAwe.UptimeFrame.ResetButton:SetPoint("TOPRIGHT", ShockAndAwe.UptimeFrame.topText, "TOPLEFT", -5, 0)
	ShockAndAwe.UptimeFrame.ResetButton:SetScript("OnClick",function() ShockAndAwe:ResetUptimeValues() end)
	ShockAndAwe.UptimeFrame.ResetButton:SetFrameLevel(ShockAndAwe.UptimeFrame.ResetButton:GetFrameLevel()+1)
	ShockAndAwe.UptimeFrame.ResetButton:SetScript("OnEnter", function() UptimeResetButtonTooltip() end);
	ShockAndAwe.UptimeFrame.ResetButton:SetScript("OnLeave", function() GameTooltip:Hide() end);


	local baseOffset = (-1 * ShockAndAwe.db.char.uptime.fHeight / 6) - 2 -- 6 bars + top line + middle line 
	if not ShockAndAwe.UptimeFrame.middleText then
		ShockAndAwe.UptimeFrame.middleText = ShockAndAwe.UptimeFrame:CreateFontString(nil, "OVERLAY")
	end
	ShockAndAwe.UptimeFrame.middleText:SetTextColor(1,1,1,1)
	ShockAndAwe.UptimeFrame.middleText:SetFont(barfont, ShockAndAwe.db.char.barfontsize, ShockAndAwe.db.char.barfonteffect)
	ShockAndAwe.UptimeFrame.middleText:SetPoint("TOP", ShockAndAwe.UptimeFrame, "TOP", 0, 3 * baseOffset - 2)
	ShockAndAwe.UptimeFrame.middleText:SetText(L["uptime_lastfight"])
	if ShockAndAwe.db.char.uptime.show then
		ShockAndAwe.UptimeFrame:Show()
	else
		ShockAndAwe.UptimeFrame:Hide()
	end
	local session = ShockAndAwe.uptime.session
	local lastfight = ShockAndAwe.uptime.lastfight
	
	self:CreateUptimeBarFrame(session.buffs[ShockAndAwe.constants["Flurry"]], ShockAndAwe.db.char.uptime.flurry, baseOffset)
	
	self:CreateUptimeBarFrame(lastfight.buffs[ShockAndAwe.constants["Flurry"]], ShockAndAwe.db.char.uptime.flurry, 4 * baseOffset)
	
end

function ShockAndAwe:CreateUptimeBarFrame(buff, buffColours, frameOffset)
	if not buff.barFrame then
		buff.barFrame = CreateFrame("Frame", nil, ShockAndAwe.UptimeFrame)
	end
	buff.barFrame:SetFrameStrata("LOW")
	buff.barFrame:SetWidth(ShockAndAwe.db.char.uptime.barWidth + ShockAndAwe.db.char.uptime.barHeight)
	buff.barFrame:SetHeight(ShockAndAwe.db.char.uptime.barHeight)
	buff.barFrame:ClearAllPoints()
	buff.barFrame:SetPoint("TOPLEFT", ShockAndAwe.UptimeFrame, "TOPLEFT", ShockAndAwe.db.char.uptime.barHeight, frameOffset)
	buff.barFrame:SetScript("OnUpdate", function() self:UpdateUptimeFrames(false); end );
	
	if not buff.barFrame.buffIcon then
		buff.barFrame.buffIcon = CreateFrame("Frame", nil, buff.barFrame)
	end
	buff.barFrame.buffIcon:SetWidth(ShockAndAwe.db.char.uptime.barHeight)
	buff.barFrame.buffIcon:SetHeight(ShockAndAwe.db.char.uptime.barHeight)
	buff.barFrame.buffIcon:SetBackdrop({ bgFile = buff.icon })
	buff.barFrame.buffIcon:SetPoint("TOPRIGHT", buff.barFrame, "TOPLEFT", 12, 0)
	
	if not buff.barFrame.statusbar then
		buff.barFrame.statusbar = CreateFrame("StatusBar", nil, buff.barFrame, "TextStatusBar")
	end
	buff.barFrame.statusbar:ClearAllPoints()
	buff.barFrame.statusbar:SetHeight(ShockAndAwe.db.char.uptime.barHeight)
	buff.barFrame.statusbar:SetWidth(ShockAndAwe.db.char.uptime.barWidth)
	buff.barFrame.statusbar:SetPoint("RIGHT", buff.barFrame, "RIGHT")
	buff.barFrame.statusbar:SetStatusBarTexture(media:Fetch("statusbar", ShockAndAwe.db.char.texture))
	buff.barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
	buff.barFrame.statusbar:SetMinMaxValues(0,1)
	buff.barFrame.statusbar:SetValue(0)
	
	local barfont = media:Fetch("font", ShockAndAwe.db.char.barfont)
	if not buff.barFrame.statusbar.leftText then
		buff.barFrame.statusbar.leftText = buff.barFrame.statusbar:CreateFontString(nil, "OVERLAY")
	end
	buff.barFrame.statusbar.leftText:SetTextColor(1,1,1,1)
	buff.barFrame.statusbar.leftText:SetFont(barfont, ShockAndAwe.db.char.barfontsize, ShockAndAwe.db.char.barfonteffect)
	buff.barFrame.statusbar.leftText:SetPoint("TOPLEFT", buff.barFrame.statusbar, "TOPLEFT")
	buff.barFrame.statusbar.leftText:SetText("0.0s")
	
	if not buff.barFrame.statusbar.rightText then
		buff.barFrame.statusbar.rightText = buff.barFrame.statusbar:CreateFontString(nil, "OVERLAY")
	end
	buff.barFrame.statusbar.rightText:SetTextColor(1,1,1,1)
	buff.barFrame.statusbar.rightText:SetFont(barfont, ShockAndAwe.db.char.barfontsize, ShockAndAwe.db.char.barfonteffect)
	buff.barFrame.statusbar.rightText:SetPoint("TOPRIGHT", buff.barFrame.statusbar, "TOPRIGHT")
	buff.barFrame.statusbar.rightText:SetText("0%")
	
	buff.barFrame.statusbar:SetScript("OnEnter", function() UptimeStatusBarTooltip(buff) end);
	buff.barFrame.statusbar:SetScript("OnLeave", function() GameTooltip:Hide() end);
	buff.barFrame.buffIcon:SetScript("OnEnter", function() UptimeStatusBarTooltip(buff) end);
	buff.barFrame.buffIcon:SetScript("OnLeave", function() GameTooltip:Hide() end);
end

function UptimeStatusBarTooltip(buff)
	if not InCombatLockdown() then
		GameTooltip:SetOwner(buff.barFrame, "ANCHOR_BOTTOMLEFT");
		GameTooltip:AddLine(buff.name)
		GameTooltip:AddTexture(buff.icon)
		GameTooltip:AddLine((L["Uptime is %s (%s)"]):format(
				buff.barFrame.statusbar.leftText:GetText(),
				buff.barFrame.statusbar.rightText:GetText()
			))
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end

function UptimeResetButtonTooltip()
	if not InCombatLockdown() then
		GameTooltip:SetOwner(ShockAndAwe.UptimeFrame.ResetButton, "ANCHOR_BOTTOMLEFT");
		GameTooltip:AddLine(L["Reset Session statistics"])
		GameTooltip:Show()
	else
		GameTooltip:Hide()
		
	end
end

function ShockAndAwe:UpdateUptimeFrames(forceUpdate)
	if InCombatLockdown() or forceUpdate then
		local session = ShockAndAwe.uptime.session
		local lastfight = ShockAndAwe.uptime.lastfight
		session.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar.leftText:SetText(self:DurationString(session.buffs[ShockAndAwe.constants["Flurry"]].uptime))
		
		lastfight.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar.leftText:SetText(self:DurationString(lastfight.buffs[ShockAndAwe.constants["Flurry"]].uptime))
		

		local percent
		if session.totalTime == 0 then
			session.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(0)
			session.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText("0%")
		else
			percent = session.buffs[ShockAndAwe.constants["Flurry"]].uptime / session.totalTime
			session.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(percent)
			session.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText((("%d"):format(percent * 100)) .. "%")
		end

		if lastfight.totalTime == 0 then
			lastfight.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(0)
			lastfight.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText("0%")
		else
			percent = lastfight.buffs[ShockAndAwe.constants["Flurry"]].uptime / lastfight.totalTime
			lastfight.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(percent)
			lastfight.buffs[ShockAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText((("%d"):format(percent * 100)) .. "%")
			
		end
	end
end

function ShockAndAwe:ResetUptime()
	ShockAndAwe.UptimeFrame:ClearAllPoints()
	ShockAndAwe.db.char.uptime.point = self.defaults.char.uptime.point
	ShockAndAwe.db.char.uptime.relativeTo = self.defaults.char.uptime.relativeTo 
	ShockAndAwe.db.char.uptime.relativePoint = self.defaults.char.uptime.relativePoint
	ShockAndAwe.db.char.uptime.xOffset = self.defaults.char.uptime.xOffset
	ShockAndAwe.db.char.uptime.yOffset = self.defaults.char.uptime.yOffset
	ShockAndAwe.db.char.uptime.fWidth = self.defaults.char.uptime.fWidth
	ShockAndAwe.db.char.uptime.fHeight = self.defaults.char.uptime.fHeight
	ShockAndAwe.db.char.uptime.scale = self.defaults.char.uptime.scale
	self:CreateUptimeFrame()
	self:Print(L["uptime_reset"])
end

function ShockAndAwe:ResetUptimeValues()
	self:InitialiseUptimeBuffs(ShockAndAwe.uptime.session)
	self:InitialiseUptimeBuffs(ShockAndAwe.uptime.lastfight)
	self:UpdateUptimeFrames(true)
end