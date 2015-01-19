local ADDON, data = ...

local checkboxes = {}   -- Will contain {checkbox, variable} pairs. Used in the refresh function.


--[[
local L = setmetatable({}, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

if GetLocale() == "deDE" then
    L["Miscellaneous:"] = "Verscheidene:"
    L["Use Garrison Resources"] = "Garnisonressourcen verwenden"
    L["If this option is checked, BulkOrder will automatically queue work orders even if they use garrison resources."] = "Wenn diese Option aktiviert ist, wird BulkOrder automatisch die Arbeitsaufträge einreihen, auch wenn sie Garnisonressourcen verwenden."
    L["While this add-on is installed, opening a work orders window will automatically queue up all available work orders."] = "Wenn dieses Addon aktiviert ist, wird alle verfügbare Arbeitsaufträge bei der Öffnung eines Arbeitsauftragfenster automatisch eingereiht werden."
    L["You can avoid the automatic work orders by holding LEFT SHIFT down while clicking on the work orders NPC."] = "Man kann die Automatisierung durch Drücken der Shift-Taste bei Interaktion mit dem Arbeitsauftrag-NPC verhindern."
    L["In addition, work orders that use garrison resources are by default not automatic, unless you enable the above option."] = "Arbeitsaufträge, die Garnisonressourcen verwenden, werden nicht automatisiert werden, außer wenn die obige Option aktiviert ist."

elseif GetLocale() == "esES" or GetLocale() == "esMX" then
    L["Miscellaneous:"] = "Misceláneo:"
    L["Use Garrison Resources"] = "Usar recursos de la ciudadela"
    L["If this option is checked, BulkOrder will automatically queue work orders even if they use garrison resources."] = "Si esta opción se activa, BulkOrder pondrá automaticamente los pedidos en cola, incluso si requieren recursos de la ciudadela."
    L["While this add-on is installed, opening a work orders window will automatically queue up all available work orders."] = "Si este addon se activa, todos los pedidos disponibles se pondrán en cola al abrir una ventana de pedidos."
    L["You can avoid the automatic work orders by holding LEFT SHIFT down while clicking on the work orders NPC."] = "Para evitar la automación de pedidos, presiona la tecla Mayús izquierda al hacer clic en el PNJ de pedidos."
    L["In addition, work orders that use garrison resources are by default not automatic, unless you enable the above option."] = "Además, los pedidos que requieren recursos de la ciudadela no están automatizados por defecto menos que se active la opción anterior."
end
--]]



-----------------------------------------------------------------

StaticPopupDialogs["BULKORDER_CONFIRMAPPLYTOALL"] = {
    text = "Are you sure you want to apply these settings to all of your characters?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        ApplySettingsToAllToons ()
    end,
    timeout = 0,
    hideOnEscape = true,
    preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

function ApplySettingsToAllToons ()
    g_BulkOrderGlobal = {}
    for k,v in pairs(g_BulkOrder) do
        g_BulkOrderGlobal[k] = v
    end
    g_BulkOrderGlobal.timestamp = time ()
end
-----------------------------------------------------------------

local function CreateCheckBox (parent, anchorTo, x, y, text)
    local frm = CreateFrame ("CheckButton", '', parent, "InterfaceOptionsCheckButtonTemplate")
    frm:SetPoint ("TOPLEFT", anchorTo, "BOTTOMLEFT", x, y)
    frm.Text:SetText (text)
    
    function frm:SetTooltip (title, text)
        self:SetScript("OnEnter", function(self, motion, ...)
            GameTooltip:SetOwner (self, "ANCHOR_TOPLEFT")
            GameTooltip:AddLine (title, 1, 1, 0)
            GameTooltip:AddLine (text, 1, 1, 1)
            GameTooltip:Show ()
        end)
        self:SetScript("OnLeave", function(self, motion, ...)
            GameTooltip:Hide ()
        end)
        return frm
    end
    
    function frm:Bind (varname)
        self:SetScript ("OnClick", function (self, ...)
            g_BulkOrder[varname] = self:GetChecked ()
            g_BulkOrder.timestamp = time ()
        end)
        table.insert (checkboxes, {frm, varname})
        return frm
    end
    
    return frm
end

-----------------------------------------------------------------

function BulkOrder_CreateOptions ()
    -- Default values!
    if g_BulkOrderGlobal and g_BulkOrderGlobal.timestamp and (g_BulkOrderGlobal.timestamp > (g_BulkOrder.timestamp or 0)) then
        for k,v in pairs(g_BulkOrderGlobal) do
            g_BulkOrder[k] = v
        end
    else
        g_BulkOrder = g_BulkOrder or {}
        
        for _,v in ipairs({string.split (' ', 'ExcludeTradingPost ExcludeWarMill ExcludeGoblinWorkshop RemindProfBuildings RemindMine RemindHerbGarden')}) do
            if g_BulkOrder[v]==nil then 
                g_BulkOrder[v] = true 
            end
        end
    end

    -- GUI stuff!
    local Options = CreateFrame ("Frame", "BulkOrderOptions", UIParent);
    Options.name = "BulkOrder";
    Options:Hide ()
    InterfaceOptions_AddCategory (Options);
    
    Options.refresh = function ()
        for i,v in pairs(checkboxes) do
            v[1]:SetChecked (g_BulkOrder[v[2]])
        end
    end
    
    Options.CreateCheckBox = CreateCheckBox
    
    local txt = {
        '- While this add-on is installed, opening a work orders window will automatically start all available work orders.',
        '- You can avoid the automatic work orders by holding LEFT SHIFT down while opening the work orders window.',
        '- In addition, work orders at the Trading Post or Dwarven Bunker/ War Mill are by default not automatic, which you can change with these options.',
    }
    local sometext = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    sometext:SetPoint ("TOPLEFT", 16, -40)
    sometext:SetPoint ("TOPRIGHT", -16, -40)
    sometext:SetWordWrap (true)
    sometext:SetText (string.join ('\n', unpack (txt)))
    sometext:SetJustifyH ("LEFT")
    sometext:SetJustifyV ("TOP")
    sometext:SetHeight (80)
    Options.sometext = sometext
    
    -----------------------------------------------------------------
    
    local Title = Options:CreateFontString (nil, "ARTWORK", "GameFontNormalLarge")
    Title:SetPoint ("TOPLEFT", 16, -16)
    Title:SetText (Options.name)
    Options.Title = Title

    
    -- Exclude buildings
    local TitleExclude = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    TitleExclude:SetPoint ("TOPLEFT", sometext, "BOTTOMLEFT", 0, -15)
    TitleExclude:SetText ('Exclude these buildings:')
    Options.TitleExclude = TitleExclude
    
    local dy = 2
    Options.chkTradingPost = Options:CreateCheckBox (TitleExclude, 0, -5, 'Trading Post')
        :Bind ('ExcludeTradingPost', false, true)
        :SetTooltip ('Exclude Trading Post', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Trading Post.')
    
    Options.chkWarMill = Options:CreateCheckBox (Options.chkTradingPost, 0, dy, 'Dwarven Bunker/ War Mill')
        :Bind ('ExcludeWarMill', false, true)
        :SetTooltip ('Exclude Dwarven Bunker/ War Mill', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Dwarven Bunker/ War Mill.')
    
    Options.chkGoblinWorkshop = Options:CreateCheckBox (Options.chkWarMill, 0, dy, 'Gnomish Gearworks/ Goblin Workshop')
        :Bind ('ExcludeGoblinWorkshop', false, true)
        :SetTooltip ('Exclude Gnomish Gearworks/ Goblin Workshop', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Gnomish Gearworks/ Goblin Workshop.')
    
    Options.chkEverything = Options:CreateCheckBox (Options.chkGoblinWorkshop, 0, dy, 'EVERYTHING!')
        :Bind ('ExcludeEverything', false, true)
        :SetTooltip ('Exclude Everything!', 'If this option is checked, BulkOrder will NOT automatically start work orders in any buildings, ever.\nYou will have to manually press the Start All Work Orders button like some sort of cave man.')
    
    
    -- Reminder
    local moretext = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    moretext:SetPoint ("TOPLEFT", Options.chkEverything, "BOTTOMLEFT", 0, -30)
    moretext:SetText ('The first time you enter your garrison after logging in, BulkOrder will remind you if you have buildings that have no work orders queued.')
    moretext:SetWidth (500)
    moretext:SetJustifyH ("LEFT")
    Options.moretext = moretext

    local TitleReminder = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    TitleReminder:SetPoint ("TOPLEFT", moretext, "BOTTOMLEFT", 0, -15)
    TitleReminder:SetText ('Remind me about:')
    Options.TitleReminder = TitleReminder
    
    Options.chkRemindProfBuildings = Options:CreateCheckBox (TitleReminder, 0, -5, 'Profession Buildings')
        :Bind ('RemindProfBuildings', false, true)
        :SetTooltip ('Profession Buildings', 'If this option is checked, BulkOrder will remind you to start work orders in all your profession buildings.')
    
    Options.chkRemindMine = Options:CreateCheckBox (Options.chkRemindProfBuildings, 0, dy, 'Mine')
        :Bind ('RemindMine', false, true)
        :SetTooltip ('Mine', 'If this option is checked, BulkOrder will remind you to start work orders in your mine.')
    
    Options.chkRemindHerbGarden = Options:CreateCheckBox (Options.chkRemindMine, 0, dy, 'Herb Garden')
        :Bind ('RemindHerbGarden', false, true)
        :SetTooltip ('Herb Garden', 'If this option is checked, BulkOrder will remind you to start work orders in your herb garden.')
    

    -- Misc
    local TitleMisc = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    TitleMisc:SetPoint ("TOPLEFT", Options.chkRemindHerbGarden, "BOTTOMLEFT", 0, -30)
    TitleMisc:SetText ('Misc.:')
    Options.TitleMisc = TitleMisc
    
    Options.chkHideButton = Options:CreateCheckBox (TitleMisc, 0, -5, 'Hide Button')
        :Bind ('HideButton', false, true)
        :SetTooltip ('Hide Button', 'If this option is checked, the work orders window will not display the additional Start All Work Orders button.')
    
    
    
    
    -- Apply To All
    local btnApplyToAll = CreateFrame ("Button", '', Options, "UIPanelButtonTemplate")
    btnApplyToAll:SetSize (200,25)
    btnApplyToAll:SetPoint ("BOTTOMLEFT", Options, "BOTTOMLEFT", 16, 8)
    btnApplyToAll:SetText ("Apply to ALL characters!")
    btnApplyToAll:SetScript ("OnClick", function ()
        StaticPopup_Show ("BULKORDER_CONFIRMAPPLYTOALL")
    end)
    
end

