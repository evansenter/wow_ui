local floor = floor
local min = min
local UnitExists = UnitExists
local GetPlayerMapPosition = GetPlayerMapPosition
local UnitHealth = UnitHealth
local GetNumGroupMembers = GetNumGroupMembers
local abs = abs
local GetPlayerFacing = GetPlayerFacing

local f = CreateFrame ("frame", "Hansgar_And_Franzok_Assist", UIParent)
f:SetFrameStrata ("DIALOG")
f.version = "v0.9"

local tframe = CreateFrame ("frame", "Hansgar_And_Franzok_Assist_PTrack", UIParent)

f:SetSize (155, 156)
f:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = -1, right = -1, top = -1, bottom = -1},
edgeFile = "Interface\\AddOns\\Hansgar_And_Franzok_Assist\\border_2", edgeSize = 8})
f:SetPoint ("center", UIParent, "center", 300, 200)
f:SetBackdropColor (0, 0, 0, 0)
f:SetBackdropBorderColor (0, 0, 0, 1)
f:SetMovable (true)
f:EnableMouse (true)
f.all_blocks = {}
f:Hide()

local title = f:CreateFontString (nil, "overlay", "GameFontNormal")
title:SetText ("Hansgar & Franzok Assist")
title:SetPoint ("center", f, "center")
title:SetPoint ("bottom", f, "top", 0, 2)

--
local frame_event = CreateFrame ("frame", "Hansgar_And_Franzok_AssistEvents", f)
frame_event:RegisterEvent ("ENCOUNTER_START")
frame_event:RegisterEvent ("ENCOUNTER_END")
frame_event:RegisterEvent ("ADDON_LOADED")

--
local player_bar = CreateFrame ("statusbar", "Hansgar_And_Franzok_PlayerAssistBar", UIParent)

--player_bar:SetPoint ("topleft", f, "bottomleft", 0, -3)
--player_bar:SetPoint ("topright", f, "bottomright", 0, -3)

player_bar:SetPoint ("center", UIParent, "center", 0, 300)
player_bar:SetSize (280, 22)

player_bar:SetMovable (true)
player_bar:EnableMouse (true)
player_bar:SetResizable (true)
player_bar:SetStatusBarColor (0, 0, 0, 0)
player_bar:SetMinMaxValues (0, 100)
player_bar:SetValue (0)
player_bar:SetMinResize (50, 15)
player_bar:SetMaxResize (500, 40)
player_bar:Hide()

local player_bar_backgroud = player_bar:CreateTexture (nil, "background")
player_bar_backgroud:SetTexture (0, 0, 0, 0.2)
player_bar_backgroud:SetAllPoints()

local icon = player_bar:CreateTexture (nil, "overlay")
icon:SetTexture ([[Interface\HELPFRAME\ReportLagIcon-Movement]])
icon:SetPoint ("left", player_bar, "left")
icon:SetDesaturated (true)
player_bar.icon = icon

local text = player_bar:CreateFontString (nil, "overlay", "GameFontNormal")
text:SetPoint ("right", player_bar, "right", -2, 0)
player_bar.text = text

player_bar:SetScript ("OnMouseDown", function (self)
	if (not self.isMoving) then
		self:StartMoving()
		self.isMoving = true
	end
end)
player_bar:SetScript ("OnMouseUp", function (self)
	if (self.isMoving) then
		self:StopMovingOrSizing()
		self.isMoving = false
	end
end)
player_bar:SetScript ("OnSizeChanged", function (self)
	self.icon:SetSize (self:GetHeight(), self:GetHeight())
	
end)
local grip = CreateFrame ("button", "Hansgar_And_Franzok_AssistPlayerBarButton", player_bar)
grip:SetPoint ("bottomright", player_bar, "bottomright")
grip:SetSize (16, 16)
grip:SetScript ("OnMouseDown", function (self, button)
	if (not player_bar.isMoving and button == "LeftButton") then
		player_bar:StartSizing ("bottomright")
		player_bar.isMoving = true
	end
end)
grip:SetScript ("OnMouseUp", function (self, button)
	if (player_bar.isMoving and button == "LeftButton") then
		player_bar:StopMovingOrSizing()
		player_bar.isMoving = false
	end
end)
grip:SetNormalTexture ([[Interface\CHATFRAME\UI-ChatIM-SizeGrabber-Up]])
grip:SetHighlightTexture ([[Interface\CHATFRAME\UI-ChatIM-SizeGrabber-Highlight]])
grip:SetPushedTexture ([[Interface\CHATFRAME\UI-ChatIM-SizeGrabber-Down]])

player_bar.grip = grip
f.player_bar = player_bar


player_bar.texture = player_bar:CreateTexture (nil, "overlay")
player_bar.texture:SetTexture ("Interface\\AddOns\\Hansgar_And_Franzok_Assist\\bar_skyline")
player_bar:SetStatusBarTexture (player_bar.texture)

--

local player_pos_frame = CreateFrame ("frame", "Hansgar_And_Franzok_Assist_BarDance", UIParent)
--player_pos_frame:SetPoint ("topleft", player_bar, "bottomleft", 0, -3)
--player_pos_frame:SetPoint ("topright", player_bar, "bottomright", 0, -3)

player_pos_frame:SetPoint ("center", UIParent, "center", 0, -75)

player_pos_frame:SetSize (155, 6)
player_pos_frame:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
player_pos_frame:SetBackdropColor (0, 0, 0, 0.4)
player_pos_frame:SetMovable (true)
player_pos_frame:EnableMouse (true)
player_pos_frame:SetScript ("OnMouseDown", function (self)
	if (not self.isMoving) then
		self:StartMoving()
		self.isMoving = true
	end
end)
player_pos_frame:SetScript ("OnMouseUp", function (self)
	if (self.isMoving) then
		self:StopMovingOrSizing()
		self.isMoving = false
	end
end)
player_pos_frame:Hide()

--red
local t1 = player_pos_frame:CreateTexture (nil, "artwork")
t1:SetPoint ("left", player_pos_frame, "left")
t1:SetSize (player_pos_frame:GetWidth()*0.30, 6)
t1:SetTexture (1, 1, 1)
--t1:SetTexCoord (260/512, 430/512, 29/256, 82/256)
t1:SetVertexColor (1, 0.2, 0.2, 0.4)

--green
local t2 = player_pos_frame:CreateTexture (nil, "artwork")
t2:SetPoint ("left", t1, "right")
t2:SetSize (player_pos_frame:GetWidth()*0.15, 6)
t2:SetTexture (0.2, 1, 0.2, 0.4)

--red
local middle = player_pos_frame:CreateTexture (nil, "artwork")
middle:SetPoint ("left", t2, "right")
middle:SetSize (player_pos_frame:GetWidth()*0.10, 6)
middle:SetTexture (1, 1, 1)
--middle:SetTexCoord (260/512, 430/512, 29/256, 82/256)
middle:SetVertexColor (1, 0.2, 0.2, 0.4)

--green
local t3 = player_pos_frame:CreateTexture (nil, "artwork")
t3:SetPoint ("left", middle, "right")
t3:SetSize (player_pos_frame:GetWidth()*0.15, 6)
t3:SetTexture (0.2, 1, 0.2, 0.4)

--red
local t4 = player_pos_frame:CreateTexture (nil, "artwork")
t4:SetPoint ("left", t3, "right")
t4:SetSize (player_pos_frame:GetWidth()*0.30, 6)
t4:SetTexture (1, 1, 1)
--t4:SetTexCoord (260/512, 430/512, 29/256, 82/256)
t4:SetVertexColor (1, 0.2, 0.2, 0.4)

local div = player_pos_frame:CreateTexture (nil, "overlay")
div:SetPoint ("left", player_pos_frame, "left", 0, 0)
div:SetTexture (1, 1, 1, 1)
div:SetSize (1, 16)
div:Hide()
--

local AceTimer = LibStub:GetLibrary ("AceTimer-3.0")
AceTimer:Embed (f)
local AceComm = LibStub:GetLibrary ("AceComm-3.0")
AceComm:Embed (f)

function f:CommReceived (_, data, _, source)
	if (data == "US") then
		f:SendCommMessage ("HAFR", UnitName ("player") .. " " .. f.version, "RAID")
	elseif (f.users) then
		f.users [data] = true
	end
end
function f:ShowUsers()
	
	local users_frame = Hansgar_And_Franzok_Assist_UsersPanel
	if (not users_frame) then
		users_frame = CreateFrame ("frame", "Hansgar_And_Franzok_Assist_UsersPanel", UIParent)
		users_frame:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = -1, right = -1, top = -1, bottom = -1},
		edgeFile = "Interface\\AddOns\\Hansgar_And_Franzok_Assist\\border_2", edgeSize = 8})
		users_frame:SetBackdropColor (0, 0, 0, 1)
		tinsert (UISpecialFrames, "Hansgar_And_Franzok_Assist_UsersPanel")
		users_frame:SetSize (200, 500)
		users_frame:SetPoint ("right", f, "left", -15, 0)
		users_frame.text = users_frame:CreateFontString (nil, "overlay", "GameFontHighlight")
		users_frame.text:SetPoint ("topleft", users_frame, "topleft", 10, -10)
		users_frame.text:SetJustifyH ("left")
		
		users_frame.title = users_frame:CreateFontString (nil, "overlay", "GameFontNormal")
		users_frame.title:SetText ("Hansgar & Franzok Assist: Users")
		users_frame.title:SetPoint ("center", users_frame, "center")
		users_frame.title:SetPoint ("bottom", users_frame, "top", 0, 2)
		
	end
	
	local s = ""
	
	for key, value in pairs (f.users) do
		s = s .. "|cFF33FF33" .. key .. "\n"
	end
	
	s = s .. "|r\n\n\n|cFFFFFFFFOut of Date or Not installed:|r\n\n"
	
	for i = 1, GetNumGroupMembers() do
		local name = UnitName ("raid" .. i)
		if (not s:find (name)) then
			s = s .. "|cFFFF3333" .. name .. "|r\n"
		end
	end
	
	users_frame.text:SetText (s)
	
	users_frame:Show()

	f.users = nil
	f.users_schedule = nil
	
end
f:RegisterComm ("HAFR", "CommReceived")

local db

f.block_tracker = {}

frame_event:SetFrameStrata ("FULLSCREEN")

frame_event:SetScript ("OnEvent", function (self, event, ...)

	if (event == "ADDON_LOADED" and select (1, ...) == "Hansgar_And_Franzok_Assist") then

		db = Hansgar_And_Franzok_DB
		if (not db) then
			db = {}
			Hansgar_And_Franzok_DB = db
		end
		--
		db.STAMPERS_DELAY = db.STAMPERS_DELAY or 5
		if (db.CD_NUMBER == nil) then
			db.CD_NUMBER = false
		end
		if (db.SHOW_DANCE == nil) then
			db.SHOW_DANCE = true
		end
		if (db.FRAME_LOCK == nil) then
			db.FRAME_LOCK = false
		end
		if (db.AUTO_FACING == nil) then
			db.AUTO_FACING = true
		end
		if (db.FACING_SIDE == nil) then
			db.FACING_SIDE = 1
		end
		if (db.SHOW_MAIN_FRAME == nil) then
			db.SHOW_MAIN_FRAME = true
		end
		if (db.PLAY_SOUND == nil) then
			db.PLAY_SOUND = false
		end
		--
		
		f:SetLockState (true)
		
	elseif (event == "ENCOUNTER_START" or event == "ENCOUNTER_END") then
	
		local encounterID, encounterName, difficultyID, raidSize = select (1, ...)
		
		if (encounterID == 1693) then
			if (event == "ENCOUNTER_START") then
				f.on_encounter = true
			elseif (event == "ENCOUNTER_END") then
				f.on_encounter = false
			end
		end
		
		if (encounterID == 1693 and db.SHOW_DANCE) then
			if (event == "ENCOUNTER_START") then
				SetMapToCurrentZone()
				f:StartTrackPlayerPosition()
			elseif (event == "ENCOUNTER_END") then
				f:EndTrackPlayerPosition()
			end
		end
		
		if (encounterID == 1693 and difficultyID == 16) then
		
			if (event == "ENCOUNTER_START") then
			
				print ("|cFFFFAA00Hansgar and Franzok Assist|r: addon enabled, good look!")
			
				if (f.StampersPhase) then
					f:StopTracking()
				end
				f:RegisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")
				
			elseif (event == "ENCOUNTER_END") then
				f:UnregisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")
				
				if (f.StampersPhase) then
					f:StopTracking()
				end
				
				f:EndTrackPlayerPosition()
			end
		end
	end

end)

SLASH_Hansgar_And_Franzok_Assist1, SLASH_Hansgar_And_Franzok_Assist2 = "/hansgar", "/franzok"
function SlashCmdList.Hansgar_And_Franzok_Assist (msg, editbox)

	local command, rest = msg:match ("^(%S*)%s*(.-)$")

	if (command == "users") then
		if (f.users_schedule) then
			print ("|cFFFFAA00Hansgar and Franzok Assist|r please wait 5 seconds...")
		elseif (IsInRaid()) then
			f.users = {}
			f:SendCommMessage ("HAFR", "US", "RAID")
			f.users_schedule = f:ScheduleTimer ("ShowUsers", 5)
			print ("|cFFFFAA00Hansgar and Franzok Assist|r please wait 5 seconds...")
		else
			print ("|cFFFFAA00Hansgar and Franzok Assist|r you aren't in a raid group.")
		end
	
	elseif (command == "delay") then
		local t = tonumber (rest)
		if (t) then
			db.STAMPERS_DELAY = t
			print ("|cFFFFAA00Hansgar and Franzok Assist|r delay set to: ", t)
		else
			print ("|cFFFFAA00Hansgar and Franzok Assist|r invalid time.", t)
		end
		
	elseif (command == "test" or command == "show") then
		if (f.StampersPhase) then
			f:EndTrackPlayerPosition()
			return f:StopTracking()
		end
		
		f:StartTracking()
		f:StartTrackPlayerPosition()
		
	elseif (command == "hide") then
		if (f.StampersPhase) then
			return f:StopTracking()
		end
		f:EndTrackPlayerPosition()

	elseif (command == "unlock") then
		db.FRAME_LOCK = true
		f:SetLockState()
		print ("|cFFFFAA00Hansgar and Franzok Assist|r frame unlocked.")

	elseif (command == "lock") then
		f:SetLockState()
		
		if (db.FRAME_LOCK) then
			print ("|cFFFFAA00Hansgar and Franzok Assist|r frame locked.")
		else
			print ("|cFFFFAA00Hansgar and Franzok Assist|r frame unlocked.")
		end
	
	elseif (command == "facing") then
		if (rest == "1") then
			db.FACING_SIDE = 1
			tframe.facing = true
			print ("|cFFFFAA00Hansgar and Franzok Assist|r facing set to south.")
			
		elseif (rest == "2") then
			db.FACING_SIDE = 2
			tframe.facing = false
			print ("|cFFFFAA00Hansgar and Franzok Assist|r facing set to north.")
		
		elseif (rest == "auto") then
			db.AUTO_FACING = true
			print ("|cFFFFAA00Hansgar and Franzok Assist|r auto facing enabled.")
			
		else
			print ("|cFFFFFF00/hansgar facing|r: |cFF00FF001|r = south |cFF00FF002|r = north, use to set the dance bar when auto facing is disabled.")
		end
		
	elseif (command == "autofacing") then
		db.AUTO_FACING = not db.AUTO_FACING
		if (db.AUTO_FACING) then
			print ("|cFFFFAA00Hansgar and Franzok Assist|r auto facing enabled.")
		else
			print ("|cFFFFAA00Hansgar and Franzok Assist|r auto facing disabled.")
			tframe.facing = db.FACING_SIDE == 1
		end
	
	elseif (command == "dance") then
		db.SHOW_DANCE = not db.SHOW_DANCE
		if (db.SHOW_DANCE) then
			if (f.on_encounter) then
				f:StartTrackPlayerPosition()
			end
			print ("|cFFFFAA00Hansgar and Franzok Assist|r dance bars enabled.")
		else
			f:EndTrackPlayerPosition()
			print ("|cFFFFAA00Hansgar and Franzok Assist|r dance bars disabled.")
		end
	
	elseif (command == "cooldown") then
		db.CD_NUMBER = not db.CD_NUMBER
		f:RefreshCooldownSettings()
		
	else
		print ("|cFFFFAA00Hansgar and Franzok Assist|r |cFF00FF00" .. f.version .. "|r Commands:")
		print ("|cFFFFFF00/hansgar lock|r: toggle lock and unlock on the frame.")
		print ("|cFFFFFF00/hansgar test show hide|r: active the addon on test mode or hide it.")
		print ("|cFFFFFF00/hansgar delay <time>|r: time in seconds until the percentage goes from 0 to 100.")
		print ("|cFFFFFF00/hansgar dance|r: toggle dance bar (used to dodge regular stampers and searing plates).")
		print ("|cFFFFFF00/hansgar autofacing|r: toggle if the dance bar auto switch left and right when looking to north or south.")
		print ("|cFFFFFF00/hansgar facing|r: |cFF00FF001|r = south |cFF00FF002|r = north, use to set the dance bar when auto facing is disabled.")
		print ("|cFFFFFF00/hansgar users|r: show who is using the addon in the raid.")
		print ("|cFFFFFF00/hansgar cooldown|r: show the countdown text for each stamper go back up to the ceiling.")
	end
end

--
--f:RegisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")

f:SetScript ("OnEvent", function (self, event, time, token, _, who_serial, who_name, who_flags, _, target_serial, target_name, target_flags, _, spellid, spellname, spellschool, buff_type, ...)

	if (token == "SPELL_AURA_APPLIED" and spellid == 162124 and not f.StampersPhase) then
		f:StartTracking()
		f:EndTrackPlayerPosition()
		
	elseif (token == "SPELL_AURA_REMOVED" and spellid == 162124 and f.StampersPhase) then
		f:StopTracking()
		if (db.SHOW_DANCE) then
			f:StartTrackPlayerPosition()
		end
		
	end

end)

local frame_tracker = CreateFrame ("frame", "Hansgar_And_Franzok_AssistTracker", UIParent)
local on_update_tracker = function (self, elapsed)
	
	local raid_size = GetNumGroupMembers()
	
	for i = 1, raid_size do
		local x, y = GetPlayerMapPosition ("raid"..i)
		if (UnitExists ("raid"..i) and UnitHealth ("raid"..i) > 1 and x and y) then
			local block = f:WhichBlock (x, y)
			if (block) then
				if (not f.block_tracker [block]) then --> was a clear block
					f.block_tracker [block] = GetTime()
					f:Paint (f.all_blocks [block])
				end
			end
		end
	end
	
	local px, py = GetPlayerMapPosition ("player")
	local player_block = f:WhichBlock (px, py)
	if (player_block and f.block_tracker [player_block] and raid_size > 0) then
		
		local time_limit_at = f.block_tracker [player_block] + db.STAMPERS_DELAY
		local time_now = GetTime()
		
		local timeleft = time_limit_at - time_now
		f.player_bar:SetValue ((timeleft) / db.STAMPERS_DELAY * 100)
		if (timeleft > 0) then
			f.player_bar.text:SetText (format ("%.1f", timeleft))
		else
			f.player_bar.text:SetText ("Move!")
		end
		f.player_bar:Show()

		local block_frame = f.all_blocks [player_block]
		f.player_loc_box:SetPoint ("center", block_frame, "center")
		f.player_loc_box:Show()

	else
		f.player_loc_box:Hide()
		f.player_bar:Hide()
	end
end

function f:StartTracking()

	print ("|cFFFFAA00Hansgar and Franzok Assist|r: Smart Stampers phase started.")

	f.StampersPhase = true

	if (not f.frames_built) then
		f:CreateWindow()
	end

	f:ResetBlocks()
	f.player_loc_box:Hide()

	f.block_tracker = f.block_tracker or {}
	table.wipe (f.block_tracker)

	SetMapToCurrentZone()

	frame_tracker:SetScript ("OnUpdate", on_update_tracker)
	f:Show()
	f.player_bar:Show()

end

function f:StopTracking()
	print ("|cFFFFAA00Hansgar and Franzok Assist|r: Smart Stampers phase ended.")

	f.StampersPhase = false
	frame_tracker:SetScript ("OnUpdate", nil)
	table.wipe (f.block_tracker)
	f.player_loc_box:Hide()
	f:Hide()
	f.player_bar:SetValue (0)
	f.player_bar:Hide()
end

local on_mouse_down = function (self)
	if (not self.isMoving and not db.FRAME_LOCK) then
		self.isMoving = true
		f:StartMoving()
	end
end
local on_mouse_up = function (self)
	if (self.isMoving) then
		self.isMoving = nil
		f:StopMovingOrSizing()
	end
end

local painting = function (self, elapsed)
	self.step = self.step + elapsed
	self.total_time = self.total_time + elapsed
	
	if (self.step > 0.2) then
		self.step = 0
		local percent = self.total_time / db.STAMPERS_DELAY * 100
		
		percent = min (percent, 100)
		
		local r, g, b = f:percent_color (percent, true)
		self:SetBackdropColor (r, g, b, 0.5)
		
		self.number:SetText (floor (percent) .. "%")
		self.number:SetTextColor (1, 1, 1, 1)
		
		if (percent == 100) then
			self:SetScript ("OnUpdate", nil)
			self.stamper_icon:Show()
			self.number:Hide()
			self.cooldown:Show()
			self.cooldown:SetCooldown (GetTime(), 37 - db.STAMPERS_DELAY, 0, 0)
		end
	end
end

function f:UnPaint (block)
	f:ResetBlock (block)
end
function f:Paint (block)
	block.step = 0
	block.total_time = 0
	block:SetScript ("OnUpdate", painting)
	local unpaint = f:ScheduleTimer ("UnPaint", 37, block)
	block.unpaint_process = unpaint
end

function f:ResetBlock (block)
	block:SetScript ("OnUpdate", nil)
	block:SetBackdropColor (.8, .8, .8, 0.5)
	block.number:SetText (block.id)
	block.number:SetTextColor (1, 1, 1, 0.5)
	block.number:Show()
	block.stamper_icon:Hide()
	block.cooldown:SetCooldown (0, 0, 0, 0)
	block.cooldown:Hide()
	
	f.block_tracker [block.id] = nil
	if (block.unpaint_process) then
		f:CancelTimer (block.unpaint_process)
		block.unpaint_process = nil
	end
end

function f:ResetBlocks()
	for _, block in ipairs (f.all_blocks) do
		f:ResetBlock (block)
	end
end

function f:RefreshCooldownSettings()
	for _, block in ipairs (f.all_blocks) do
		if (not db.CD_NUMBER) then
			block.cooldown:SetHideCountdownNumbers (true)
			block.cooldown:SetDrawEdge (false)
		else
			block.cooldown:SetHideCountdownNumbers (false)
			block.cooldown:SetDrawEdge (true)
		end
	end
end

function f:SetLockState (just_refresh)

	if (not just_refresh) then
		db.FRAME_LOCK = not db.FRAME_LOCK
	end
	
	if (db.FRAME_LOCK) then
		--locked
		f:EnableMouse (false)
		player_bar:EnableMouse (false)
		player_pos_frame:EnableMouse (false)
		
		for _, block in ipairs (f.all_blocks) do
			block:EnableMouse (false)
		end
		
		if (f.StampersPhase and not just_refresh) then
			f:EndTrackPlayerPosition()
			f:StopTracking()
		end
	else
		--unlocked
		f:EnableMouse (true)
		player_bar:EnableMouse (true)
		player_pos_frame:EnableMouse (true)
		
		for _, block in ipairs (f.all_blocks) do
			block:EnableMouse (true)
		end
		
		if (not f.StampersPhase and not just_refresh) then
			f:StartTracking()
			f:StartTrackPlayerPosition()
		end
	end
	
	if (not db.FRAME_LOCK) then
		player_bar.grip:Show()
	else
		player_bar.grip:Hide()
	end
end

function f:CreateWindow()
	local x = 0
	local y = 0
	
	f.player_loc_box = frame_event:CreateTexture (nil, "overlay")
	f.player_loc_box:SetSize (32, 40)
	f.player_loc_box:SetTexture ([[Interface\ContainerFrame\UI-Icon-QuestBorder]])
	f.player_loc_box:Hide()
	
	f.all_blocks = {}
	
	for i = 1, 20 do
		
		local block = CreateFrame ("frame", "Hansgar_And_Franzok_Assist_Block" .. i, f)
		block:SetSize (30, 38)
		block:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},
		})
		block:SetBackdropBorderColor (0, 0, 0, 1)
		block:SetBackdropColor (.8, .8, .8, 0.5)
		block:SetPoint ("TopLeft", f, "TopLeft", x, y)
		
		block:SetScript ("OnMouseDown", on_mouse_down)
		block:SetScript ("OnMouseUp", on_mouse_up)
		
		local cooldown = CreateFrame ("cooldown", "Hansgar_And_Franzok_Assist_BlockCooldown" .. i, block, "CooldownFrameTemplate")
		cooldown:SetAllPoints()
		cooldown:SetFrameLevel (block:GetFrameLevel()+2)
		
		if (not db.CD_NUMBER) then
			cooldown:SetHideCountdownNumbers (true)
			cooldown:SetDrawEdge (false)
		end
		
		block.cooldown = cooldown
		
		block.id = i
		
		local number = block:CreateFontString (nil, "artwork", "GameFontHighlight")
		number:SetPoint ("center", block, "center")
		number:SetText (i)
		number:SetTextColor (1, 1, 1, 0.5)
		block.number = number
		
		local stamper_icon = block:CreateTexture (nil, "overlay")
		stamper_icon:SetTexture ([[Interface\ICONS\Warrior_talent_icon_LambsToTheSlaughter]])
		stamper_icon:SetTexCoord (4/64, 60/64, 4/64, 60/64)
		stamper_icon:SetSize (24, 24)
		stamper_icon:SetPoint ("center", block, "center")
		stamper_icon:Hide()
		block.stamper_icon = stamper_icon
		
		x = x + 31
		if (x >= 155) then
			x = 0
			y = y - 40
		end
		
		tinsert (f.all_blocks, block)
		
	end
	
	f:SetLockState (true)
	
	f.frames_built = true
	
end

local safe_track = {
	--space 1
	{
		block = {x1 = 0.50154542922974, x2 = 0.49563668874741},
		left = {x1 = 0.49963343143463, x2 = 0.49963343143463 - 0.000624573974608}, 
		right = {x1 = 0.49710285663605, x2 = 0.49710285663605 + 0.000992229919432}, 
		-- {x1 = 0.49963343143463, y1 = 0.73492467403412} -- {x1 = 0.49710285663605, y1 = 0.74445152282715}
	},
	--space 2
	{
		block = {x1 = 0.4858917593956, x2 = 0.48044270277023},
		left = {x1 = 0.48433673381805, x2 = 0.48433673381805 - 0.00091059207916}, 
		right = {x1 = 0.48206025362015, x2 = 0.48206025362015 + 0.00075059207916},
		-- {x1 = 0.48433673381805, y1 = 0.74292266368866} -- {x1 = 0.48206025362015, y1 = 0.78930181264877}
	},
	--space 3
	{
		block = {x1 = 0.47047740221024, x2 = 0.4648859500885},
		left = {x1 = 0.46893924474716, x2 = 0.46893924474716 - 0.000902948493956},
		right = {x1 = 0.46635687351227, x2 = 0.46635687351227 + 0.000970948493956},
		--{x1 = 0.46893924474716, y1 = 0.7981019616127} -- {x1 = 0.46635687351227, y1 = 0.73558133840561}
	},
	--space 4
	{
		block = {x1 = 0.45503282546997, x2 = 0.44976264238358},
		left = {x1 = 0.4533554315567, x2 = 0.4533554315567 - 0.000714573974608}, 
		right = {x1 = 0.45124399662018, x2 = 0.45124399662018 + 0.000770009999999},
		--{x1 = 0.4533554315567, y1 = 0.74078941345215} -- {x1 = 0.45124399662018, y1 = 0.74088287353516}
	}
}
Hansgar_safe_track = safe_track

--	/hansgar test
--	/run Hansgar_safe_track [4].left.x2 = 0.4533554315567 - 0.000714573974608

local red_alpha_disabled = 0.2
local red_alpha_enabled = 0.5

local green_alpha_disabled = 0.05
local green_alpha_enabled = 0.9

-- true north -> south
-- false south -> north
function f:ChangePlayerTrackerFace()
	
end

local track_function = function (self, elapsed)

	local x, _ = GetPlayerMapPosition ("player")
	local block
	
	if (db.AUTO_FACING and x) then
		local facing = GetPlayerFacing()
		
		if (self.facing and (facing > 5.3 or facing < 1.053)) then --north -> south -- ~30º tolerance
			self.facing = false
			--print ("changing face to south")
		elseif (not self.facing and (facing > 2.3 and facing < 4.3)) then --south -> north -- ~30º tolerance
			self.facing = true
			--print ("changing face to north")
		end
	end

	if (x) then
		for i = 1, #safe_track do
			local loc = safe_track [i]
			if (x >= loc.block.x2 and x <= loc.block.x1) then
				block = i
				break
			end
		end
	end
	
	if (block and safe_track [block]) then
	
		player_pos_frame:Show()
		block = safe_track [block]
		
		if (x >= block.left.x2 and x <= block.left.x1) then
			if (self.facing) then
				t2:SetTexture (0.1, 1, 0.1, green_alpha_enabled)
				t3:SetTexture (0.2, 1, 0.2, green_alpha_disabled)
			else
				t3:SetTexture (0.2, 232/255, 1, green_alpha_enabled)
				t2:SetTexture (0.2, 232/255, 1, green_alpha_disabled)
			end
			
			t1:SetVertexColor (1, 0.2, 0.2, red_alpha_disabled) --red
			t4:SetVertexColor (1, 0.2, 0.2, red_alpha_disabled) --red 
			middle:SetVertexColor (1, 0.2, 0.2, red_alpha_disabled) --red
			
		elseif (x <= block.right.x2 and x >= block.right.x1) then
			if (self.facing) then
				t3:SetTexture (0.1, 1, 0.1, green_alpha_enabled)
				t2:SetTexture (0.2, 1, 0.2, green_alpha_disabled)
			else
				t2:SetTexture (0.2, 232/255, 1, green_alpha_enabled)
				t3:SetTexture (0.2, 232/255, 1, green_alpha_disabled)
			end
			
			t1:SetVertexColor (1, 0.2, 0.2, red_alpha_disabled) --red
			t4:SetVertexColor (1, 0.2, 0.2, red_alpha_disabled) --red 
			middle:SetVertexColor (1, 0.2, 0.2, red_alpha_disabled) --red
			
		else
			t1:SetVertexColor (1, 0.2, 0.2, red_alpha_enabled) --red
			t4:SetVertexColor (1, 0.2, 0.2, red_alpha_enabled) --red 
			middle:SetVertexColor (1, 0.2, 0.2, red_alpha_enabled) --red
			
			t2:SetTexture (0.2, 1, 0.2, green_alpha_disabled)
			t3:SetTexture (0.2, 1, 0.2, green_alpha_disabled)
			
		end
		
		--x = x - block.block.x2
		--local at = abs ((x / (block.block.x1 - block.block.x2) * 100) - 100)
		--div:SetPoint ("left", player_pos_frame, "left", self.width_pixel * at, 0)

	else
		player_pos_frame:Hide()
	end
end

function f:StartTrackPlayerPosition()
	player_pos_frame:Show()
	tframe.width = player_pos_frame:GetWidth()
	tframe.width_pixel = tframe.width / 100
	tframe.facing = db.FACING_SIDE == 1
	tframe:SetScript ("OnUpdate", track_function)
end
function f:EndTrackPlayerPosition()
	player_pos_frame:Hide()
	tframe:SetScript ("OnUpdate", nil)
end

local locs = {
	--block 1:
	{x1 = 0.51103663444519, y1 = 0.79726493358612, x2 = 0.50061076879501, y2 = 0.8241291642189},
	--block 2:
	{x1 = 0.49670505523682, y1 = 0.79692482948303, x2 = 0.48469054698944, y2 = 0.82489335536957},	
	--block 3:
	{x1 = 0.48130965232849, y1 = 0.79742962121964, x2 = 0.46962946653366, y2 = 0.82453238964081},
	--block 4:
	{x1 = 0.46575212478638, y1 = 0.79766929149628, x2 = 0.45400339365005, y2 = 0.82176661491394},	
	--block 5:
	{x1 = 0.45073217153549, y1 = 0.79751670360565, x2 = 0.43945103883743, y2 = 0.82504689693451},	

	--block 6
	{x1 = 0.51104211807251, y1 = 0.76532691717148, x2 = 0.50021582841873, y2 = 0.79546189308167},
	--block 7
	{x1 = 0.4964514374733, y1 = 0.76603573560715, x2 = 0.48449218273163, y2 = 0.79527854919434},	
	--block 8
	{x1 = 0.48101079463959, y1 = 0.76503103971481, x2 = 0.46944016218185, y2 = 0.79543298482895},
	--block 9
	{x1 = 0.46541726589203, y1 = 0.7654857635498, x2 = 0.45369201898575, y2 = 0.79529416561127},
	--block 10
	{x1 = 0.45051556825638, y1 = 0.76583826541901, x2 = 0.43931984901428, y2 = 0.79570162296295},
	

	--block 11
	{x1 = 0.51104187965393, y1 = 0.73422884941101, x2 = 0.49990028142929, y2 = 0.76343530416489},
	--block 12
	{x1 = 0.49673527479172, y1 = 0.73338270187378, x2 = 0.48483556509018, y2 = 0.76356953382492},
	--block 13
	{x1 = 0.48133307695389, y1 = 0.73373115062714, x2 = 0.46920585632324, y2 = 0.76366758346558},
	--block 14
	{x1 = 0.46568286418915, y1 = 0.73440700769424, x2 = 0.45381307601929, y2 = 0.76358675956726},
	--block 15
	{x1 = 0.45046973228455, y1 = 0.73361301422119, x2 = 0.43929302692413, y2 = 0.76388084888458},

	--block 16
	{x1 = 0.51104891300201, y1 = 0.70877063274384, x2 = 0.50024521350861, y2 = 0.73220580816269},
	--block 17
	{x1 = 0.49676024913788, y1 = 0.70914703607559, x2 = 0.48485481739044, y2 = 0.73210543394089},
	--block 18
	{x1 = 0.48142266273499, y1 = 0.70876735448837, x2 = 0.46925610303879, y2 = 0.73205661773682},
	--block 19
	{x1 = 0.46603119373322, y1 = 0.70929777622223, x2 = 0.45397216081619, y2 = 0.73167610168457},
	--block 20
	{x1 = 0.45079308748245, y1 = 0.70926278829575, x2 = 0.43927478790283, y2 = 0.73225915431976},
}

function f:WhichBlock (x, y)
	for i = 1, #locs do
		local loc = locs [i]
		if (x >= loc.x2 and x <= loc.x1 and y >= loc.y1 and y <= loc.y2) then
			return i
		end
	end
end

function f:percent_color (value, inverted)
	local r, g
	if (value < 50) then
		r = 255
	else
		r = floor ( 255 - (value * 2 - 100) * 255 / 100)
	end
	
	if (value > 50) then
		g = 255
	else
		g = floor ( (value * 2) * 255 / 100)
	end
	
	if (inverted) then
		return g/255, r/255, 0
	else
		return r/255, g/255, 0
	end
end
