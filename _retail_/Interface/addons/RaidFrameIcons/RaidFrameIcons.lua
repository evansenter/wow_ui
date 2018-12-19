-- ----------------------------------------------------------------------------
-- RaidFrameIcons by Szandos
-- Continued by Soyier
-- ----------------------------------------------------------------------------

RaidFrameIcons_Global = LibStub( "AceAddon-3.0" ):NewAddon( "RaidFrameIcons", "AceEvent-3.0")
local RaidFrameIcons = RaidFrameIcons_Global

local debug = false
local icons = {}


-------------------------------------------------------------------------
--------------------Start of Functions-----------------------------------
-------------------------------------------------------------------------

--- **OnInitialize**, which is called directly after the addon is fully loaded.
--- do init tasks here, like loading the Saved Variables
--- or setting up slash commands.
function RaidFrameIcons:OnInitialize()

	-- Set up config pane
	RaidFrameIcons:SetupOptions()
	--LoggingChat(1)
	-- Register callbacks for profile switching
	RaidFrameIcons.db.RegisterCallback(RaidFrameIcons, "OnProfileChanged", "RefreshConfig")
	RaidFrameIcons.db.RegisterCallback(RaidFrameIcons, "OnProfileCopied", "RefreshConfig")
	RaidFrameIcons.db.RegisterCallback(RaidFrameIcons, "OnProfileReset", "RefreshConfig")


end

--- **OnEnable** which gets called during the PLAYER_LOGIN event, when most of the data provided by the game is already present.
--- Do more initialization here, that really enables the use of your addon.
--- Register Events, Hook functions, Create Frames, Get information from
--- the game that wasn't available in OnInitialize
function RaidFrameIcons:OnEnable()

	if RaidFrameIcons.db.profile.enabled then
		-- Hook raid icon updates
		RaidFrameIcons:RegisterEvent("RAID_TARGET_UPDATE", "UpdateAllFrames")
		RaidFrameIcons:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateAllFrames")

		-- Make sure any icons already existing are shown
		RaidFrameIcons:UpdateAllFrames()

	end


end

--- **OnDisable**, which is only called when your addon is manually being disabled.
--- Unhook, Unregister Events, Hide frames that you created.
--- You would probably only use an OnDisable if you want to
--- build a "standby" mode, or be able to toggle modules on/off.
function RaidFrameIcons:OnDisable()

	-- Unhook raid icon updates
	RaidFrameIcons:UnregisterAllEvents()

	for frameName in pairs(icons) do
		icons[frameName].icon = nil
		icons[frameName].texture:Hide()
	end


end

-------------------------------------------------


function RaidFrameIcons:SetTextureAppearance(frame)
	local pad = 3
	local pos = RaidFrameIcons.db.profile.iconPosition
	local frameName = frame:GetName()
	if not icons[frameName] then return end
	local tex = icons[frameName].texture

	-- Set position relative to frame
	tex:ClearAllPoints()
	if pos == "TOPLEFT" then tex:SetPoint("TOPLEFT", pad, -pad) end
	if pos == "TOP" then tex:SetPoint("TOP", 0, -pad) end
	if pos == "TOPRIGHT" then tex:SetPoint("TOPRIGHT", -pad, -pad) end
	if pos == "LEFT" then tex:SetPoint("LEFT", pad, 0) end
	if pos == "CENTER" then tex:SetPoint("CENTER", 0, 0) end
	if pos == "RIGHT" then tex:SetPoint("RIGHT", -pad, 0) end
	if pos == "BOTTOMLEFT" then tex:SetPoint("BOTTOMLEFT", pad, pad) end
	if pos == "BOTTOM" then tex:SetPoint("BOTTOM", 0, pad) end
	if pos == "BOTTOMRIGHT" then tex:SetPoint("BOTTOMRIGHT", -pad, pad) end

	-- Set the icon size
	tex:SetWidth(RaidFrameIcons.db.profile.iconSize)
	tex:SetHeight(RaidFrameIcons.db.profile.iconSize)
end

function RaidFrameIcons:UpdateIcon(frame)
	local unit = frame.unit
	local frameName = frame:GetName()

	-- If fame doesn't point at anything, no need for an icon
	if not unit then return end


	-- Get icon on unit
	local icon = GetRaidTargetIndex(unit)

	-- Initialize our storage and create teture
	if not icons[frameName] then -- No icon on this frame before, need a texture

		icons[frameName] = {}
		icons[frameName].texture = frame:CreateTexture(nil, "OVERLAY")
		RaidFrameIcons:SetTextureAppearance(frame)
	end

	-- Only change icon texture if the icon on the frame actually changed
	if icon ~= icons[frameName].icon then
		icons[frameName].icon = icon
		if icon == nil then

			icons[frameName].texture:Hide()
		else

			icons[frameName].texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..icon)
			icons[frameName].texture:Show()
		end
	end
end

function RaidFrameIcons:UpdateAllFrames()

	CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", function(frame) RaidFrameIcons:UpdateIcon(frame) end)
end

-- Used to update everything that is affected by the configuration
function RaidFrameIcons:RefreshConfig()

	-- Set icon size and placement
	CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", function(frame) RaidFrameIcons:SetTextureAppearance(frame) end)
end
