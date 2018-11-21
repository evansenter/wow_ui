-- GLOBALS -> LOCAL
local _G = getfenv(0)
local InFlight, self = InFlight, InFlight
local GetNumRoutes, GetTime, NumTaxiNodes, TaxiNodeGetType, TaxiNodeName, UnitOnTaxi = GetNumRoutes, GetTime, NumTaxiNodes, TaxiNodeGetType, TaxiNodeName, UnitOnTaxi
local floor, format, strsub, print = floor, format, strsub, print
local gtt = GameTooltip
local oldTakeTaxiNode
InFlight.debug = false

-- LIBRARIES
local smed = LibStub("LibSharedMedia-3.0")

-- LOCAL VARIABLES
local debug = InFlight.debug
local Print, PrintD = InFlight.Print, InFlight.PrintD
local vars, db  -- addon
local taxiSrc, taxiDst, endTime  -- location data
local porttaken, takeoff, inworld, ontaxi  -- flags
local ratio, endText  -- cache variables
local sb, spark, timeText, locText, bord  -- frame elements
local totalTime, startTime, elapsed, throt = 0, 0, 0, 0  -- throttle vars

-- LOCALIZATION
local gl = GetLocale()
local L_destparse = ", (.+)"  -- removes main zone name, leaving only subzone
local L_duration = "Duration: "
local L_tooltipoption2 = " <Shift left-click> to move."
local L_tooltipoption3 = " <Right-click> for options."
local L_confirmpopup = "Take flight to |cffffff00%s%s|r?"
local L_BarOptions = "Bar Options"
local L_FillUp = "Fill Up"
local L_ShowSpark = "Show spark"
local L_Texture = "Texture"
local L_Width = "Width"
local L_Height = "Height"
local L_Border = "Border"
local L_FillColor = "Fill Color"
local L_UnknownColor = "Unknown Color"
local L_BackgroundColor = "Background Color"
local L_BorderColor = "Border Color"
local L_TextOptions = "Text Options"
local L_CompactMode = "Compact Mode"
local L_ToText = "\"To\" Text"
local L_Font = "Font"
local L_FontColor = "Font Color"
local L_ShowChat = "Chat Messages"
local L_ConfirmFlight = "Confirm Flight"
if gl == "enUS" then
	-- do nada and skip ifelse chain
elseif gl == "deDE" then  -- provided by Brobar
	--L_destparse = ", (.+)"  -- removes main zone name, leaving only subzone
	L_duration = "Flugdauer: "
	L_tooltipoption2 = " <Shift Links-Klick> zum Bewegen."
	L_tooltipoption3 = " <Rechts-Klick> f\195\188r Optionen."
	L_confirmpopup = "Flug nehmen zu |cffffff00%s%s|r?"
	L_BarOptions = "Statusoptionen"
	L_FillUp = "F\195\188llen"
	L_Texture = "Textur"
	L_Width = "Breite"
	L_Height = "H\195\182he"
	L_Border = "Rand"
	L_FillColor = "F\195\188llfarbe"
	L_UnknownColor = "Unbekannte Farbe"
	L_BackgroundColor = "Hintergrundfarbe"
	L_BorderColor = "Randfarbe"
	L_TextOptions = "Textoptionen"
	L_CompactMode = "Kompaktmodus"
	L_ToText = "\"Nach\" Text"
	L_Font = "Schriftart"
	L_FontColor = "Schriftfarbe"
	L_ConfirmFlight = "Flug best\195\164tigen"
elseif gl == "koKR" then
	L_destparse = " %- (.+)"  -- removes main zone name, leaving only subzone
	L_duration = "지속시간: "
	L_tooltipoption2 = " <쉬프트+클릭> 하면 이동합니다."
	L_tooltipoption3 = " <오른쪽-클릭> 하면 설정을 엽니다."
	--L_confirmpopup = "Take flight to |cffffff00%s%s|r?"
	L_BarOptions = "바 설정"
	L_FillUp = "바 채우기"
	L_Texture = "바 텍스처"
	L_Width = "길이"
	L_Height = "높이"
	L_Border = "테두리"
	L_FillColor = "바 색상"
	L_UnknownColor = "모르는 경로 색상"
	L_BackgroundColor = "배경 색상"
	L_BorderColor = "테두리 색상"
	L_TextOptions = "글자 설정"
	L_CompactMode = "간단 모드"
	-- L_ToText = "\"To\" Text"
	L_Font = "글꼴"
	L_FontColor = "글꼴 색상"
	L_ConfirmFlight = "경로 확인"
elseif gl == "zhTW" then
	L_destparse = "，(.+)"  -- removes main zone name, leaving only subzone
	L_duration = "時間: "
	L_tooltipoption2 = " Shift-左擊: 移動"
	L_tooltipoption3 = " 右擊: 打開設定選單"
	L_confirmpopup = "你確定你要飛到|cffffff00%s%s|r?"
	L_BarOptions = "外觀"
	L_FillUp = "遞增"
	L_Texture = "時間條紋理"
	L_Width = "寬度"
	L_Height = "高度"
	L_Border = "邊框"
	L_FillColor = "時間條顏色"
	L_UnknownColor = "未知顏色"
	L_BackgroundColor = "背景顏色"
	L_BorderColor = "邊框顏色"
	L_TextOptions = "字形"
	L_CompactMode = "內嵌模式"
	L_ToText = "「到」文字"
	L_Font = "字形"
	L_FontColor = "字形顏色"
	L_ConfirmFlight = "確定飛行"
elseif gl == "esES" then
	--L_destparse = ", (.+)"  -- removes main zone name, leaving only subzone
	L_duration = "Duración: "
	L_tooltipoption2 = " <Shift+Click-Izquierdo> para mover."
	L_tooltipoption3 = " <Click-Derecho> para Opciones."
	L_confirmpopup = "¿Coger un vuelo hacia |cffffff00%s%s|r?"
	L_BarOptions = "Opciones de la Barra"
	L_FillUp = "Rellenar"
	L_Texture = "Textura"
	L_Width = "Ancho"
	L_Height = "Alto"
	L_Border = "Borde"
	L_FillColor = "Color de la Barra"
	L_UnknownColor = "Color de Desconocido"
	L_BackgroundColor = "Color de Fondo"
	L_BorderColor = "Color de Borde"
	L_TextOptions = "Opciones del Texto"
	L_CompactMode = "Modo Compacto"
	L_ToText = "Texto \"Hacia\""
	L_Font = "Fuente"
	L_FontColor = "Color"
	L_ConfirmFlight = "Confirmar Vuelo"
elseif gl == "ruRU" then  -- Translated by StingerSoft (Эритнулл ака Шептун)
	--L_destparse = ", (.+)"  -- удаляет название основной зоны, оставляя только подзону
	L_duration = "Продолжительность полета: "
	L_tooltipoption2 = " <Shift левый-клик> для перемещения."
	L_tooltipoption3 = " <Правый-клик> для опций."
	L_confirmpopup = "Лететь в |cffffff00%s%s|r?"
	L_BarOptions = "Опции полосы"
	L_FillUp = "Заполнять"
	L_Texture = "Текстура"
	L_Width = "Ширина"
	L_Height = "Высота"
	L_Border = "Края"
	L_FillColor = "Цвет заполнения"
	L_UnknownColor = "Неизвестный цвет"
	L_BackgroundColor = "Цвет фона"
	L_BorderColor = "Цвет края"
	L_TextOptions = "Опции текста"
	L_CompactMode = "Компактный режим"
	L_ToText = "\"в\" Текст"
	L_Font = "Шрифт"
	L_FontColor = "Цвет шрифта"
	L_ConfirmFlight = "Подтверждать полет"
elseif gl == "frFR" then
	L_destparse = ", (.+)" -- removes main zone name, leaving only subzone
	L_duration = "Durée: "
	L_tooltipoption2 = " <Shift clic gauche> pour se déplacer."
	L_tooltipoption3 = " <clic droit> f\195\188r Options."
	L_confirmpopup = "Prenez votre envol pour |cffffff00%s%s|r?"
	L_BarOptions = "Status Options"
	L_FillUp = "compléter"
	L_Texture = "Texture"
	L_Width = "Largeur"
	L_Height = "Hauteur"
	L_Border = "Bordure"
	L_FillColor = "Couleur de remplissage"
	L_UnknownColor = "couleur Inconnu"
	L_BackgroundColor = "Couleur de fond"
	L_BorderColor = "Couleur de la bordure"
	L_TextOptions = "Options du texte"
	L_CompactMode = "Compact Mode"
	L_ToText = "\"Après\" Text"
	L_Font = "Font"
	L_FontColor = "Couleur de font"
	L_ConfirmFlight = "Confirmer votre vol"
end

-- LOCAL FUNCTIONS
local function FormatTime(secs, f)  -- simple time format
	if not secs then
		return "??"
	end
	if not f then
		return format("%d:%02d", secs / 60, secs % 60)
	end
	f:SetFormattedText("%d:%02d / %s", secs / 60, secs % 60, endText)
end

local function ShortenName(name)  -- shorten name to lighten saved vars and display
	return gsub(name, L_destparse, "")
end

local function SetPoints(f, lp, lrt, lrp, lx, ly, rp, rrt, rrp, rx, ry)
	f:ClearAllPoints()
	f:SetPoint(lp, lrt, lrp, lx, ly)
	if rp then
		f:SetPoint(rp, rrt, rrp, rx, ry)
	end
end

local function SetToUnknown()  -- setup bar for flights with unknown time
	sb:SetMinMaxValues(0, 1)
	sb:SetValue(1)
	sb:SetStatusBarColor(db.unknowncolor.r, db.unknowncolor.g, db.unknowncolor.b, db.unknowncolor.a)
	endText = "??"
	spark:Hide()
end

local function GetEstimatedTime(slot)  -- estimates flight times based on hops
	local numNodes, numRoutes = NumTaxiNodes(), GetNumRoutes(slot)
	local nodeName = ShortenName(TaxiNodeName(slot))
	local taxiNodes = {[numRoutes + 1] = nodeName}
	for hop = 1, numRoutes, 1 do
		local nodeX, nodeY = floor(100 * TaxiGetSrcX(slot, hop)), floor(100 * TaxiGetSrcY(slot, hop))
		for i = 1, numNodes, 1 do
			local iX, iY = TaxiNodePosition(i)
			iX, iY = floor(100 * iX), floor(100 * iY)
			if nodeX == iX and nodeY == iY then
				nodeName = ShortenName(TaxiNodeName(i))
				taxiNodes[hop] = nodeName
				break
			end
		end
	end

	local etimes = { 0 }
	local prevNode = {}
	local nextNode = {}
	local srcNode, dstNode = 1, #taxiNodes - 1
	PrintD("|cff208080New Route:|r", taxiNodes[srcNode], "|cff208020to|r", taxiNodes[dstNode + 1])
	while srcNode and srcNode < #taxiNodes do
		while dstNode and dstNode > srcNode do
			PrintD("|cff208080Node:|r", taxiNodes[srcNode], "|cff208020to|r", taxiNodes[dstNode])
			if vars[taxiNodes[srcNode]] then
				if not etimes[dstNode] and vars[taxiNodes[srcNode]][taxiNodes[dstNode]] then
					etimes[dstNode] = etimes[srcNode] + vars[taxiNodes[srcNode]][taxiNodes[dstNode]]
					PrintD(taxiNodes[dstNode], "time:", FormatTime(etimes[srcNode]), "+", FormatTime(vars[taxiNodes[srcNode]][taxiNodes[dstNode]]), "=", FormatTime(etimes[dstNode]))
					nextNode[srcNode] = dstNode - 1
					prevNode[dstNode] = srcNode
					srcNode = dstNode
					dstNode = #taxiNodes
				else
					dstNode = dstNode - 1
				end
			else
				srcNode = prevNode[srcNode]
				dstNode = nextNode[srcNode]
			end
		end

		if not etimes[#taxiNodes] then
			PrintD("..")
			srcNode = prevNode[srcNode]
			dstNode = nextNode[srcNode]
		end
	end

	PrintD(".")
	return etimes[#taxiNodes]
end

local function postTaxiNodeOnButtonEnter(button) -- adds duration info to taxi node tooltips
	local id = button:GetID()
	if TaxiNodeGetType(id) ~= "REACHABLE" then
		return
	end
	local ftime = (vars[taxiSrc] and vars[taxiSrc][ShortenName(TaxiNodeName(id))]) or GetEstimatedTime(id) or 0
	if ftime > 0 then
		gtt:AddLine(L_duration..FormatTime(ftime), 1, 1, 1)
	else
		gtt:AddLine(L_duration.."-:--", 0.8, 0.8, 0.8)
	end
	gtt:Show()
end

local function postFlightNodeOnButtonEnter(button) -- adds duration info to flight node tooltips
	if button.taxiNodeData.state ~= Enum.FlightPathState.Reachable then
		return
	end
	local ftime = (vars[taxiSrc] and vars[taxiSrc][ShortenName(button.taxiNodeData.name)]) or GetEstimatedTime(button.taxiNodeData.slotIndex) or 0
	if ftime > 0 then
		gtt:AddLine(L_duration..FormatTime(ftime), 1, 1, 1)
	else
		gtt:AddLine(L_duration.."-:--", 0.8, 0.8, 0.8)
	end
	gtt:Show()
end

----------------------------
function InFlight.Print(...)  -- prefix chat messages
----------------------------
	print("|cff0040ffIn|cff00aaffFlight|r:", ...)
end
Print = InFlight.Print

-----------------------------
function InFlight.PrintD(...)  -- debug print
-----------------------------
	if debug then
		print("|cff00ff40In|cff00aaffFlight|r:", ...)
	end
end
PrintD = InFlight.PrintD

----------------------------
function InFlight:LoadBulk()  -- called from InFlight_Load
----------------------------
	InFlightDB = InFlightDB or {}
	if InFlightDB.profiles then
		InFlightDB = InFlightDB.profiles.Default
		InFlightDB.profiles = nil
	end
	db = InFlightDB.perchar and InFlightCharDB or InFlightDB

	InFlightVars = InFlightVars or { Alliance = {}, Horde = {}, }  -- flight time data
	vars = InFlightVars[UnitFactionGroup("player")]

	if db.dbinit ~= 806 or debug then
		db.dbinit = 806
		local function SetDefaults(db, t)  -- set saved variables
			for k, v in pairs(t) do
				if type(db[k]) == "table" then
					SetDefaults(db[k], v)
				elseif db[k] == nil then
					db[k] = v
				end
			end
		end
		SetDefaults(db, {
			fill = true,
			spark = true,
			border = "Blizzard Dialog",
			height = 14,
			width = 230,
			font = "Friz Quadrata TT",
			fontsize = 12,
			texture = "Blizzard",
			barcolor = { r = 0.5, g = 0.5, b = 0.8, a = 1.0, },
			unknowncolor = { r = 0.2, g = 0.2, b = 0.4, a = 1.0, },
			bordercolor = { r = 0.6, g = 0.6, b = 0.6, a = 0.8, },
			backcolor = { r = 0.1, g = 0.1, b = 0.1, a = 0.6, },
			fontcolor = { r = 1.0, g = 1.0, b = 1.0, a = 1.0, },
			totext = "-->",
			chatlog = true,
		} )

		db.totext = strtrim(db.totext)
		db.upload = nil

		-- updates to default data
		Print("Default data updated.")
		local defaults = self:LoadDefaults()
		for faction, t in pairs(defaults) do
			local updated, added = 0, 0
			for src, dt in pairs(t) do
				InFlightVars[faction][src] = InFlightVars[faction][src] or { }
				for dst, dtime in pairs(dt) do
					if not InFlightVars[faction][src][dst] then
						added = added + 1
					end

					-- Always update with default data to avoid data cycle regressions
					if debug then
						if not InFlightVars[faction][src][dst] then
							InFlightVars[faction][src][dst] = dtime
						else
							local utime = InFlightVars[faction][src][dst]
							if utime > dtime + 5 or utime < dtime - 5 then
								updated = updated + 1
								PrintD(faction, "|cff208020-|r", src, db.totext, dst, "|cff208020updated:|r", FormatTime(dtime), "|cff208020to|r", FormatTime(utime))
							end
						end
					else
						InFlightVars[faction][src][dst] = dtime
					end
				end
			end

			if updated > 0 then
				PrintD(faction, "|cff208020- updated|r", updated, "|cff208020flight times.|r")
			end
			if added > 0 then
				Print(faction, "|cff208080- added|r", added, "|cff208080new flight times.|r")
			end
		end
	end

	-- check every 2 weeks if there are new flight times found
	if not db.upload or db.upload < time() then
		local locale = GetLocale()
		if locale == "enUS" or locale == "enGB" then
			local defaults = self:LoadDefaults()
			self:Sanitise(InFlightVars, false)
			for faction, t in pairs(InFlightVars) do
				local found = 0
				for src, dt in pairs(t) do
					for dst, dtime in pairs(dt) do
						if not defaults[faction][src] or not defaults[faction][src][dst] then
							found = found + 1
							PrintD(faction, "|cff208020-|r", src, db.totext, dst, "|cff208020found:|r", FormatTime(dtime))
						end
					end
				end

				if found > 0 then
					Print(faction, "|cff208020- found|r", found, "|cff208020flight times available to contribute.|r")
				end
			end
		end

		db.upload = time() + 1209600
	end

	if not debug then
		self.LoadDefaults = nil
	end

	oldTakeTaxiNode = TakeTaxiNode
	TakeTaxiNode = function(slot)
		if TaxiNodeGetType(slot) ~= "REACHABLE" then
			return
		end

		taxiDst = ShortenName(TaxiNodeName(slot))
		local t = vars[taxiSrc]
		if t and t[taxiDst] and t[taxiDst] > 0 then  -- saved variables lookup
			endTime = t[taxiDst]
		else
			endTime = GetEstimatedTime(slot)
		end

		if db.confirmflight then  -- confirm flight
			StaticPopupDialogs.INFLIGHTCONFIRM = StaticPopupDialogs.INFLIGHTCONFIRM or {
				button1 = OKAY, button2 = CANCEL,
				OnAccept = function(this, data) InFlight:StartTimer(data) end,
				timeout = 0, exclusive = 1, hideOnEscape = 1,
			}
			StaticPopupDialogs.INFLIGHTCONFIRM.text = format(L_confirmpopup, taxiDst, endTime and format(" (%s)", FormatTime(endTime)) or "")

			local dialog = StaticPopup_Show("INFLIGHTCONFIRM")
			if dialog then
				dialog.data = slot
			end
		else  -- just take the flight
			self:StartTimer(slot)
		end
	end

	-- function hooks to detect if a user took a summon
	hooksecurefunc("TaxiRequestEarlyLanding", function() porttaken = true end)
	hooksecurefunc("AcceptBattlefieldPort", function(index, accept) porttaken = accept and true end)
	hooksecurefunc("ConfirmSummon", function() porttaken = true end)
	hooksecurefunc("CompleteLFGRoleCheck", function(bool) porttaken = bool end)

	self:Hide()
	self.LoadBulk = nil
end

---------------------------------------
function InFlight:InitSource(isTaxiMap)  -- cache source location and hook tooltips
---------------------------------------
	if isTaxiMap then
		for i = 1, NumTaxiNodes(), 1 do
			local tb = _G["TaxiButton"..i]
			if tb and not tb.inflighted then
				tb:HookScript("OnEnter", postTaxiNodeOnButtonEnter)
				tb.inflighted = true
			end
			if TaxiNodeGetType(i) == "CURRENT" then
				taxiSrc = ShortenName(TaxiNodeName(i))
			end
		end
	elseif FlightMapFrame and GetTaxiMapID() ~= 994 then
		local tb = FlightMapFrame.pinPools.FlightMap_FlightPointPinTemplate
		for flightnode in tb:EnumerateActive() do
			if not flightnode.inflighted then
				flightnode:HookScript("OnEnter", postFlightNodeOnButtonEnter)
				flightnode.inflighted = true
			end
			if flightnode.taxiNodeData.state == Enum.FlightPathState.Current then
				taxiSrc = ShortenName(flightnode.taxiNodeData.name)
			end
		end
	end
end

----------------------------------
function InFlight:StartTimer(slot)  -- lift off
----------------------------------
	Dismount()
	if CanExitVehicle() == 1 then
		VehicleExit()
	end

	-- Don't show timer or record times for Argus map
	if slot and FlightMapFrame and GetTaxiMapID() == 994 then
		return oldTakeTaxiNode(slot)
	end

	-- create the timer bar
	if not sb then
		self:CreateBar()
	end

	-- start the timers and setup statusbar
	if endTime then
		sb:SetMinMaxValues(0, endTime)
		sb:SetValue(db.fill and 0 or endTime)
		endText = FormatTime(endTime)
	else
		SetToUnknown()
	end

	InFlight:UpdateLook()
	FormatTime(0, timeText)
	sb:Show()
	self:Show()

	porttaken = nil
	elapsed, totalTime, startTime = 0, 0, GetTime()
	takeoff, inworld = true, true
	throt = min(0.2, (endTime or 50) * 0.004)  -- increases updates for short flights

	self:RegisterEvent("PLAYER_CONTROL_GAINED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")

	if slot then
		oldTakeTaxiNode(slot)
	end
end

-------------------------------------------
function InFlight:StartMiscFlight(src, dst)  -- called from InFlight_Load for special flights
-------------------------------------------
	self:TAXIMAP_OPENED()
	endTime = vars[src] and vars[src][dst]
	taxiSrc, taxiDst = src, dst
	self:StartTimer()
end

do  -- timer bar
	local bdrop = { edgeSize = 16, insets = {}, }
	local bdi = bdrop.insets
	-----------------------------
	function InFlight:CreateBar()
	-----------------------------
		sb = CreateFrame("StatusBar", "InFlightBar", UIParent)
		sb:Hide()
		sb:SetPoint(db.p or "BOTTOM", UIParent, db.rp or "TOP", db.x or 0, db.y or -170)
		sb:SetMovable(true)
		sb:EnableMouse(true)
		sb:SetScript("OnMouseUp", function(this, a1)
			if a1 == "RightButton" then
				InFlight:ShowOptions()
			elseif a1 == "LeftButton" and IsControlKeyDown() then
				ontaxi, porttaken = nil, true
			end
		end)
		sb:RegisterForDrag("LeftButton")
		sb:SetScript("OnDragStart", function(this)
			if IsShiftKeyDown() then
				this:StartMoving()
			end
		end)
		sb:SetScript("OnDragStop", function(this)
			this:StopMovingOrSizing()
			local a,b,c,d,e = this:GetPoint()
			db.p, db.rp, db.x, db.y = a, c, floor(d + 0.5), floor(e + 0.5)
		end)
		sb:SetScript("OnEnter", function(this)
			gtt:SetOwner(this, "ANCHOR_RIGHT")
			gtt:SetText("InFlight", 1, 1, 1)
			gtt:AddLine(L_tooltipoption2, 0, 1, 0)
			gtt:AddLine(L_tooltipoption3, 0, 1, 0)
			gtt:AddLine("<Control left-click> to force close", 0, 1, 0)
			gtt:Show()
		end)
		sb:SetScript("OnLeave", function() gtt:Hide() end)

		timeText = sb:CreateFontString(nil, "OVERLAY")
		locText = sb:CreateFontString(nil, "OVERLAY")

		spark = sb:CreateTexture(nil, "OVERLAY")
		spark:Hide()
		spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
		spark:SetWidth(16)
		spark:SetBlendMode("ADD")

		bord = CreateFrame("Frame", nil, sb)  -- border/background
		SetPoints(bord, "TOPLEFT", sb, "TOPLEFT", -5, 5, "BOTTOMRIGHT", sb, "BOTTOMRIGHT", 5, -5)
		bord:SetFrameStrata("LOW")

		local function onupdate(this, a1)
			elapsed = elapsed + a1
			if elapsed < throt then
				return
			end

			totalTime = GetTime() - startTime
			elapsed = 0

			if takeoff then  -- check if actually in flight after take off (doesn't happen immediately)
				if UnitOnTaxi("player") then
					takeoff, ontaxi = nil, true
					elapsed, totalTime, startTime = throt - 0.01, 0, GetTime()
				elseif totalTime > 5 then
					sb:Hide()
					this:Hide()
				end

				return
			end

			if not UnitOnTaxi("player") then  -- event bug fix
				ontaxi = nil
			end

			if not ontaxi then  -- flight ended
				PrintD("|cff208080porttaken -|r", porttaken)
				if not porttaken then
					if type(vars) == "table" and type(taxiSrc) == "string" then
						vars[taxiSrc] = vars[taxiSrc] or { }
						local oldTime = vars[taxiSrc][taxiDst]
						local newTime = floor(totalTime + 0.5)
						if db.chatlog then
							if not oldTime then
								Print(taxiSrc, db.totext, taxiDst, "|cff208080added flight time:|r", FormatTime(newTime))
							elseif newTime > oldTime + 5 or newTime < oldTime - 5 then
								Print(taxiSrc, db.totext, taxiDst, "|cff208080updated flight time:|r", FormatTime(oldTime), "|cff208080to|r", FormatTime(newTime))
							else
								PrintD(taxiSrc, db.totext, taxiDst, "|cff208080updated flight time:|r", FormatTime(oldTime), "|cff208080to|r", FormatTime(newTime))
							end
						end

						vars[taxiSrc][taxiDst] = newTime
					end
				end

				endTime = nil
				sb:Hide()
				this:Hide()

				return
			end

			if endTime then  -- update statusbar if destination time is known
				if totalTime - 2 > endTime then   -- in case the flight is longer than expected
					SetToUnknown()
					endTime = nil
				else
					local value = db.fill and totalTime or (endTime - totalTime)
					if value > endTime then
						value = endTime
					elseif value < 0 then
						value = 0
					end

					sb:SetValue(value)
					spark:SetPoint("CENTER", sb, "LEFT", value * ratio, 0)
					FormatTime(value, timeText)
				end
			else  -- destination time is unknown, so show that it's timing
				FormatTime(totalTime, timeText)
			end
		end

		function self:PLAYER_LEAVING_WORLD()
			inworld = nil
		end

		function self:PLAYER_ENTERING_WORLD()
			inworld = true
		end

		function self:PLAYER_CONTROL_GAINED()
			if not inworld then
				return
			end

			if self:IsShown() then
				ontaxi = nil
				onupdate(self, 3)
			end

			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
			self:UnregisterEvent("PLAYER_LEAVING_WORLD")
			self:UnregisterEvent("PLAYER_CONTROL_GAINED")
		end

		self:SetScript("OnUpdate", onupdate)
		self.CreateBar = nil
	end

	------------------------------
	function InFlight:UpdateLook()
	------------------------------
		if not sb then
			return
		end

		sb:SetWidth(db.width)
		sb:SetHeight(db.height)

		local texture = smed:Fetch("statusbar", db.texture)
		local inset = (db.border=="Textured" and 2) or 4
		bdrop.bgFile = texture
		bdrop.edgeFile = smed:Fetch("border", db.border)
		bdi.left, bdi.right, bdi.top, bdi.bottom = inset, inset, inset, inset
		bord:SetBackdrop(bdrop)
		bord:SetBackdropColor(db.backcolor.r, db.backcolor.g, db.backcolor.b, db.backcolor.a)
		bord:SetBackdropBorderColor(db.bordercolor.r, db.bordercolor.g, db.bordercolor.b, db.bordercolor.a)
		sb:SetStatusBarTexture(texture)
		if sb:GetStatusBarTexture() then
			sb:GetStatusBarTexture():SetHorizTile(false)
			sb:GetStatusBarTexture():SetVertTile(false)
		end

		spark:SetHeight(db.height * 2.4)
		if endTime then  -- in case we're in flight
			ratio = db.width / endTime
			sb:SetStatusBarColor(db.barcolor.r, db.barcolor.g, db.barcolor.b, db.barcolor.a)
			if db.spark then
				spark:Show()
			else
				spark:Hide()
			end
		else
			SetToUnknown()
		end

		locText:SetFont(smed:Fetch("font", db.font), db.fontsize, db.outline and "OUTLINE" or nil)
		locText:SetShadowColor(0, 0, 0, db.fontcolor.a)
		locText:SetShadowOffset(1, -1)
		locText:SetTextColor(db.fontcolor.r, db.fontcolor.g, db.fontcolor.b, db.fontcolor.a)

		timeText:SetFont(smed:Fetch("font", db.font), db.fontsize, db.outlinetime and "OUTLINE" or nil)
		timeText:SetShadowColor(0, 0, 0, db.fontcolor.a)
		timeText:SetShadowOffset(1, -1)
		timeText:SetTextColor(db.fontcolor.r, db.fontcolor.g, db.fontcolor.b, db.fontcolor.a)

		if db.inline then
			timeText:SetJustifyH("RIGHT")
			timeText:SetJustifyV("CENTER")
			SetPoints(timeText, "RIGHT", sb, "RIGHT", -4, 0)
			locText:SetJustifyH("LEFT")
			locText:SetJustifyV("CENTER")
			SetPoints(locText, "LEFT", sb, "LEFT", 4, 0, "RIGHT", timeText, "LEFT", -2, 0)
			locText:SetText(taxiDst or "??")
		else
			timeText:SetJustifyH("CENTER")
			timeText:SetJustifyV("CENTER")
			SetPoints(timeText, "CENTER", sb, "CENTER", 0, 0)
			locText:SetJustifyH("CENTER")
			locText:SetJustifyV("BOTTOM")
			SetPoints(locText, "TOPLEFT", sb, "TOPLEFT", -24, db.fontsize*2.5, "BOTTOMRIGHT", sb, "TOPRIGHT", 24, (db.border=="None" and 1) or 3)
			locText:SetFormattedText("%s %s %s", taxiSrc or "??", db.totext, taxiDst or "??")
		end
	end
end

---------------------------------
function InFlight:SetLayout(this)  -- setups the options in the default interface options
---------------------------------
	local t1 = this:CreateFontString(nil, "ARTWORK")
	t1:SetFontObject(GameFontNormalLarge)
	t1:SetJustifyH("LEFT")
	t1:SetJustifyV("TOP")
	t1:SetPoint("TOPLEFT", 16, -16)
	t1:SetText("InFlight")
	this.tl = t1

	local t2 = this:CreateFontString(nil, "ARTWORK")
	t2:SetFontObject(GameFontHighlightSmall)
	t2:SetJustifyH("LEFT")
	t2:SetJustifyV("TOP")
	t2:SetHeight(43)
	SetPoints(t2, "TOPLEFT", t1, "BOTTOMLEFT", 0, -8, "RIGHT", this, "RIGHT", -32, 0)
	t2:SetNonSpaceWrap(true)
	local function GetInfo(field)
		return GetAddOnMetadata("InFlight", field) or "N/A"
	end

	t2:SetFormattedText("Notes: %s\nAuthor: %s\nVersion: %s", GetInfo("Notes"), GetInfo("Author"), GetInfo("Version"))

	local b = CreateFrame("Button", nil, this, "UIPanelButtonTemplate")
	b:SetWidth(120)
	b:SetHeight(20)
	b:SetText(_G.GAMEOPTIONS_MENU)
	b:SetScript("OnClick", InFlight.ShowOptions)
	b:SetPoint("TOPLEFT", t2, "BOTTOMLEFT", -2, -8)
	this:SetScript("OnShow", nil)
	self.SetLayout = nil
end

-- options table
smed:Register("border", "Textured", "\\Interface\\None")  -- dummy border
local InFlightDD, offsetvalue, offsetcount, lastb
local info = { }
-------------------------------
function InFlight.ShowOptions()
-------------------------------
	if not InFlightDD then
		InFlightDD = CreateFrame("Frame", "InFlightDD", InFlight)
		InFlightDD.displayMode = "MENU"
		local function HideCheck(b)
			if b and b.GetName and _G[b:GetName().."Check"] then
				_G[b:GetName().."Check"]:Hide()
			end
		end

		hooksecurefunc("ToggleDropDownMenu", function(...) lastb = select(8, ...) end)
		local function Exec(b, k, value)
			HideCheck(b)
			if k == "totext" then
				StaticPopupDialogs["InFlightToText"] = StaticPopupDialogs["InFlightToText"] or {
					text = "Enter your 'to' text.",
					button1 = ACCEPT, button2 = CANCEL,
					hasEditBox = 1, maxLetters = 12,
					OnAccept = function(self)
						db.totext = self.editBox:GetText()
						InFlight:UpdateLook()
					end,
					OnShow = function(self)
						self.editBox:SetText(db.totext)
						self.editBox:SetFocus()
					end,
					OnHide = function(self)
						self.editBox:SetText("")
					end,
					EditBoxOnEnterPressed = function(self)
						local parent = self:GetParent()
						db.totext = parent.editBox:GetText()
						parent:Hide()
						InFlight:UpdateLook()
					end,
					EditBoxOnEscapePressed = function(self)
						self:GetParent():Hide()
					end,
					timeout = 0, exclusive = 1, whileDead = 1, hideOnEscape = 1,
				}
				StaticPopup_Show("InFlightToText")
			elseif (k == "less" or k == "more") and lastb then
				local off = (k == "less" and -8) or 8
				if offsetvalue == value then
					offsetcount = offsetcount + off
				else
					offsetvalue, offsetcount = value, off
				end

				local tb = _G[gsub(lastb:GetName(), "ExpandArrow", "")]
				CloseDropDownMenus(b:GetParent():GetID())
				ToggleDropDownMenu(b:GetParent():GetID(), tb.value, nil, nil, nil, nil, tb.menuList, tb)
			elseif k == "resetall" then
				InFlightDB, InFlightCharDB = nil, nil
				ReloadUI()
			end
		end

		local function Set(b, k)
			if not k then
				return
			end

			db[k] = not db[k]
			if k == "perchar" then
				if db[k] then
					InFlightCharDB = db
				else
					InFlightCharDB = nil
				end
				ReloadUI()
			end

			InFlight:UpdateLook()
		end

		local function SetSelect(b, a1)
			db[a1] = tonumber(b.value) or b.value
			local level, num = strmatch(b:GetName(), "DropDownList(%d+)Button(%d+)")
			level, num = tonumber(level) or 0, tonumber(num) or 0
			for i = 1, UIDROPDOWNMENU_MAXBUTTONS, 1 do
				local b = _G["DropDownList"..level.."Button"..i.."Check"]
				if b then
					b[i == num and "Show" or "Hide"](b)
				end
			end

			InFlight:UpdateLook()
		end

		local function SetColor(a1)
			local dbc = db[UIDROPDOWNMENU_MENU_VALUE]
			if not dbc then
				return
			end

			if a1 then
				local pv = ColorPickerFrame.previousValues
				dbc.r, dbc.g, dbc.b, dbc.a = pv.r, pv.g, pv.b, 1 - pv.opacity
			else
				dbc.r, dbc.g, dbc.b = ColorPickerFrame:GetColorRGB()
				dbc.a = 1 - OpacitySliderFrame:GetValue()
			end

			InFlight:UpdateLook()
		end

		local function AddButton(lvl, text, keepshown)
			info.text = text
			info.keepShownOnClick = keepshown
			UIDropDownMenu_AddButton(info, lvl)
			wipe(info)
		end

		local function AddToggle(lvl, text, value)
			info.arg1 = value
			info.func = Set
			info.checked = db[value]
			info.isNotRadio = true
			AddButton(lvl, text, 1)
		end

		local function AddExecute(lvl, text, arg1, arg2)
			info.arg1 = arg1
			info.arg2 = arg2
			info.func = Exec
			info.notCheckable = 1
			AddButton(lvl, text, 1)
		end

		local function AddColor(lvl, text, value)
			local dbc = db[value]
			if not dbc then
				return
			end

			info.hasColorSwatch = true
			info.hasOpacity = 1
			info.r, info.g, info.b, info.opacity = dbc.r, dbc.g, dbc.b, 1 - dbc.a
			info.swatchFunc, info.opacityFunc, info.cancelFunc = SetColor, SetColor, SetColor
			info.value = value
			info.notCheckable = 1
			info.func = UIDropDownMenuButton_OpenColorPicker
			AddButton(lvl, text, nil)
		end

		local function AddList(lvl, text, value)
			info.value = value
			info.hasArrow = true
			info.func = HideCheck
			info.notCheckable = 1
			AddButton(lvl, text, 1)
		end

		local function AddSelect(lvl, text, arg1, value)
			info.arg1 = arg1
			info.func = SetSelect
			info.value = value
			if tonumber(value) and tonumber(db[arg1] or "blah") then
				if floor(100 * tonumber(value)) == floor(100 * tonumber(db[arg1])) then
					info.checked = true
				end
			else
				info.checked = (db[arg1] == value)
			end

			AddButton(lvl, text, 1)
		end

		local function AddFakeSlider(lvl, value, minv, maxv, step, tbl)
			local cvalue = 0
			local dbv = db[value]
			if type(dbv) == "string" and tbl then
				for i, v in ipairs(tbl) do
					if dbv == v then
						cvalue = i
						break
					end
				end
			else
				cvalue = dbv or ((maxv - minv) / 2)
			end

			local adj = (offsetvalue == value and offsetcount) or 0
			local starti = max(minv, cvalue - (7 - adj) * step)
			local endi = min(maxv, cvalue + (8 + adj) * step)
			if starti == minv then
				endi = min(maxv, starti + 16 * step)
			elseif endi == maxv then
				starti = max(minv, endi - 16 * step)
			end

			if starti > minv then
				AddExecute(lvl, "--", "less", value)
			end

			if tbl then
				for i = starti, endi, step do
					AddSelect(lvl, tbl[i], value, tbl[i])
				end
			else
				local fstring = (step >= 1 and "%d") or (step >= 0.1 and "%.1f") or "%.2f"
				for i = starti, endi, step do
					AddSelect(lvl, format(fstring, i), value, i)
				end
			end

			if endi < maxv then
				AddExecute(lvl, "++", "more", value)
			end
		end

		InFlightDD.initialize = function(self, lvl)
			if lvl == 1 then
				info.isTitle = true
				info.notCheckable = 1
				AddButton(lvl, "|cff0040ffIn|cff00aaffFlight|r")
				AddList(lvl, L_BarOptions, "frame")
				AddList(lvl, L_TextOptions, "text")
				AddList(lvl, _G.OTHER, "other")
			elseif lvl == 2 then
				local sub = UIDROPDOWNMENU_MENU_VALUE
				if sub == "frame" then
					AddToggle(lvl, L_FillUp, "fill")
					AddToggle(lvl, L_ShowSpark, "spark")
					AddList(lvl, L_Texture, "texture")
					AddList(lvl, L_Width, "width")
					AddList(lvl, L_Height, "height")
					AddList(lvl, L_Border, "border")
					AddColor(lvl, L_FillColor, "barcolor")
					AddColor(lvl, L_UnknownColor, "unknowncolor")
					AddColor(lvl, L_BackgroundColor, "backcolor")
					AddColor(lvl, L_BorderColor, "bordercolor")
				elseif sub == "text" then
					AddToggle(lvl, L_CompactMode, "inline")
					AddExecute(lvl, L_ToText, "totext")
					AddList(lvl, L_Font, "font")
					AddList(lvl, _G.FONT_SIZE, "fontsize")
					AddColor(lvl, L_FontColor, "fontcolor")
					AddToggle(lvl, "Outline Info", "outline")
					AddToggle(lvl, "Outline Time", "outlinetime")
					AddToggle(lvl, L_ShowChat, "chatlog")
				elseif sub == "other" then
					AddToggle(lvl, L_ConfirmFlight, "confirmflight")
					AddToggle(lvl, _G.CHARACTER.." ".._G.SAVE, "perchar")
					AddExecute(lvl, _G.RESET_TO_DEFAULT, "resetall")
				end
			elseif lvl == 3 then
				local sub = UIDROPDOWNMENU_MENU_VALUE
				if sub == "texture" or sub == "border" or sub == "font" then
					local t = smed:List(sub == "texture" and "statusbar" or sub)
					AddFakeSlider(lvl, sub, 1, #t, 1, t)
				elseif sub == "width" then
					AddFakeSlider(lvl, sub, 40, 500, 5)
				elseif sub == "height" then
					AddFakeSlider(lvl, sub, 4, 100, 1)
				elseif sub == "fontsize" then
					AddFakeSlider(lvl, sub, 4, 30, 1)
				end
			end
		end
	end

	ToggleDropDownMenu(1, nil, InFlightDD, "cursor")
end

if debug then
	function inflightupdate(timeUpdatesAllowed)
		local updates = {}
		for table, updates in pairs(updates) do

		-- Set updateExistingTimes to true to update and add new times (for updates based
		--   on the current default db)
		-- Set updateExistingTimes to false to only add new unknown times (use for updates
		--   not based on current default db to avoid re-adding old/incorrect times)
		local updateExistingTimes = timeUpdatesAllowed or false

		-- Phase 1
		-- Remove update data that is the same as the default data so that it
		--   doesn't revert times that have already been updated in InFlightVars.
		-- This means that the default data should NOT be updated between releases
		--   as this could cause the updated default times to be reverted by update
		--   data that contains default times from the current release (unless
		--   updateExistingTimes is set to false)
		for faction, t in pairs(self:LoadDefaults()) do
			if updates[faction] then
				for src, dt in pairs(t) do
					if updates[faction][src] then
						for dst, dtime in pairs(dt) do
							-- Remove times that match the default times
							if updates[faction][src][dst] == dtime then
								updates[faction][src][dst] = nil
							end
						end
						if next(updates[faction][src]) == nil then
							updates[faction][src] = nil
						end
					end
				end
				if next(updates[faction]) == nil then
					updates[faction] = nil
					PrintD(faction, "|cff208020-|r No time updates found. All times equal to defaults.")
				end
			end
		end

		-- Phase 2
		self:Sanitise(updates, updateExistingTimes)

		end
	end
end
