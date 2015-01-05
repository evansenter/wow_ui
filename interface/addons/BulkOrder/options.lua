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
    end
    
    function frm:Bind (varname)
        self:SetScript ("OnClick", function (self, ...)
            g_BulkOrder[varname] = self:GetChecked ()
        end)
        table.insert (checkboxes, {frm, varname})
    end
    
    return frm
end

-----------------------------------------------------------------

function BulkOrder_CreateOptions ()
    -- Default values!
    g_BulkOrder = g_BulkOrder or {}
    if g_BulkOrder.ExcludeTradingPost==nil then 
        g_BulkOrder.ExcludeTradingPost = true 
    end
    if g_BulkOrder.ExcludeWarMill==nil then 
        g_BulkOrder.ExcludeWarMill = true 
    end
    if g_BulkOrder.ExcludeGoblinWorkshop==nil then 
        g_BulkOrder.ExcludeGoblinWorkshop = true 
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
    sometext:SetPoint ("TOPLEFT", 8, -40)
    sometext:SetText (string.join ('\n', unpack (txt)))
    sometext:SetWidth (500)
    sometext:SetJustifyH ("LEFT")
    Options.sometext = sometext
    
    -----------------------------------------------------------------
    
    local Title = Options:CreateFontString (nil, "ARTWORK", "GameFontNormalLarge")
    Title:SetPoint ("TOPLEFT", 8, -16)
    Title:SetText (Options.name)
    Options.Title = Title

    
    -- Exclude buildings
    local TitleExclude = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    TitleExclude:SetPoint ("TOPLEFT", 8, -130)
    TitleExclude:SetText ('Exclude these buildings:')
    Options.TitleExclude = TitleExclude
    local y=-6
    
    Options.chkTradingPost = Options:CreateCheckBox (TitleExclude, 0, y, 'Trading Post')
    Options.chkTradingPost:Bind ('ExcludeTradingPost', false, true)
    Options.chkTradingPost:SetTooltip ('Exclude Trading Post', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Trading Post.')
    y=y-25
    
    Options.chkWarMill = Options:CreateCheckBox (TitleExclude, 0, y, 'Dwarven Bunker/ War Mill')
    Options.chkWarMill:Bind ('ExcludeWarMill', false, true)
    Options.chkWarMill:SetTooltip ('Exclude Dwarven Bunker/ War Mill', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Dwarven Bunker/ War Mill.')
    y=y-25
    
    Options.chkGoblinWorkshop = Options:CreateCheckBox (TitleExclude, 0, y, 'Gnomish Gearworks/ Goblin Workshop')
    Options.chkGoblinWorkshop:Bind ('ExcludeGoblinWorkshop', false, true)
    Options.chkGoblinWorkshop:SetTooltip ('Exclude Gnomish Gearworks/ Goblin Workshop', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Gnomish Gearworks/ Goblin Workshop.')
    y=y-25
    
    Options.chkEverything = Options:CreateCheckBox (TitleExclude, 0, y, 'EVERYTHING!')
    Options.chkEverything:Bind ('ExcludeEverything', false, true)
    Options.chkEverything:SetTooltip ('Exclude Everything!', 'If this option is checked, BulkOrder will NOT automatically start work orders in any buildings, ever.\nYou will have to manually press the Start All Work Orders button like some sort of cave man.')
    y=y-25
    
    
    -- Misc
    local TitleMisc = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    TitleMisc:SetPoint ("TOPLEFT", 8, -265)
    TitleMisc:SetText ('Misc.:')
    Options.TitleMisc = TitleMisc
    local y=-6
    
    Options.chkHideButton = Options:CreateCheckBox (TitleMisc, 0, y, 'Hide Button')
    Options.chkHideButton:Bind ('HideButton', false, true)
    Options.chkHideButton:SetTooltip ('Hide Button', 'If this option is checked, the work orders window will not display the additional Start All Work Orders button.')
    y=y-25
    
    
    
    

end

