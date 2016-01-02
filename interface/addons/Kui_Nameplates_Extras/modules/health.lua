local addon = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')
local mod = addon:NewModule('ExtrasHealth', addon.Prototype, 'AceEvent-3.0')
local kui = LibStub('Kui-1.0')
local extras = addon:GetModule('ExtrasCore')

local profile_text
local HealthValues = {
    function(f) return f.health.percent < 100 and floor(f.health.percent) or '' end,
    function(f) return '' end,
    function(f) return kui.num(f.health.curr) end,
    function(f) return kui.num(f.health.curr) end,
    function(f) return '' end
}

local orig_OnHealthValueChanged
local function OnHealthValueChanged(frame)
    orig_OnHealthValueChanged(frame)

    if not frame.health.m then
        return
    end

    if profile_text.hp_text_disabled or
       not frame.health.health_max_snapshot or
       frame.trivial
    then
        frame.health.m:SetText('')
        return
    end

    if frame.friend then
        if frame.health.curr == frame.health.max then
            frame.health.m:SetText(HealthValues[profile_text.hp_friend_max](frame))
        else
            frame.health.m:SetText(HealthValues[profile_text.hp_friend_low](frame))
        end
    else
        if frame.health.curr == frame.health.max then
            frame.health.m:SetText(HealthValues[profile_text.hp_hostile_max](frame))
        else
            frame.health.m:SetText(HealthValues[profile_text.hp_hostile_low](frame))
        end
    end
end

local orig_UpdateFrameCritical
local function UpdateFrameCritical(frame)
    orig_UpdateFrameCritical(frame)

    if not frame.trivial and frame.health.p:IsShown() then
        frame.health.m:Show()
    else
        frame.health.m:Hide()
    end
end

function mod:PostCreate(msg,frame)
    if not orig_OnHealthValueChanged then
        orig_OnHealthValueChanged = frame.OnHealthValueChanged
    end
    frame.OnHealthValueChanged = OnHealthValueChanged

    if profile_text.mouseover then
        if not orig_UpdateFrameCritical then
            orig_UpdateFrameCritical = frame.UpdateFrameCritical
        end
        frame.UpdateFrameCritical = UpdateFrameCritical
    end

    frame.health.m = frame:CreateFontString(frame.overlay, { size = 'small' })
    frame.health.m:SetPoint('RIGHT',frame.health.p,'LEFT')
    frame.health.m:SetJustifyH('RIGHT')
    frame.health.m:SetJustifyV('BOTTOM')
end
function mod:PostShow(msg,frame)
    if not frame.health.m then return end
    if frame.trivial then
        frame.health.m:Hide()
    elseif not profile_text.mouseover then
        frame.health.m:Show()
    end
end

mod:AddGlobalConfigChanged('addon', {'hp','text'}, function()
    profile_text = addon.db.profile.hp.text
end)

function mod:OnInitialize()
    self:SetEnabledState(extras.db.profile.health)
end
function mod:OnEnable()
    profile_text = addon.db.profile.hp.text
    self:RegisterMessage('KuiNameplates_PostCreate','PostCreate')
    self:RegisterMessage('KuiNameplates_PostShow','PostShow')

    for k,v in ipairs(addon.frameList) do
        if v.kui and not v.kui.health.m then
            self:PostCreate(nil,v.kui)

            if v.kui:IsVisible() then
                self:PostShow(nil,v.kui)
            end
        end
    end
end
