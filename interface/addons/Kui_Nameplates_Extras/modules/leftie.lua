local addon = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')
local mod = addon:NewModule('ExtrasLeftie', addon.Prototype, 'AceEvent-3.0')
local extras = addon:GetModule('ExtrasCore')

local orig_UpdateName
local function UpdateName(self,frame,trivial)
    orig_UpdateName(self,frame,trivial)
    if trivial then return end

    frame.name:ClearAllPoints()
    frame.name:SetPoint('BOTTOMLEFT', frame.health, 'TOPLEFT', 2.5, -2.5)
    frame.name:SetPoint('RIGHT', frame.health.p, 'LEFT')
    frame.name:SetJustifyH('LEFT')
end

function mod:PostShow(msg,frame)
    if frame.trivial then return end

    frame.health.p:ClearAllPoints()
    frame.level:ClearAllPoints()

    frame.health.p:SetFontSize('large')
    frame.health.p:SetPoint('BOTTOMRIGHT', frame.health, 'TOPRIGHT', -2.5, -2.5)

    frame.level:SetFontSize('small')
    frame.level:SetPoint('TOPLEFT', frame.health, 'BOTTOMLEFT', 2.5, 6.5)

    if frame.health.m then
        frame.health.m:ClearAllPoints()
        frame.health.m:SetPoint('TOPRIGHT', frame.health, 'BOTTOMRIGHT', -2.5, 6.5)
    end

    if frame.castbar then
        if frame.castbar.name then
            frame.castbar.name:ClearAllPoints()
            frame.castbar.name:SetPoint('TOPLEFT', frame.castbar.bar, 'BOTTOMLEFT', 2.5, -3)
            frame.castbar.name:SetPoint('TOPRIGHT', frame.castbar.bar, 'BOTTOMRIGHT')
            frame.castbar.name:SetJustifyH('LEFT')
        end

        if frame.castbar.curr then
            frame.castbar.curr:ClearAllPoints()
            frame.castbar.curr:SetPoint('TOPRIGHT', frame.castbar.bar, 'BOTTOMRIGHT', -2.5, -3)
            frame.castbar.curr:SetJustifyH('RIGHT')
        end

        if frame.castbar.name and frame.castbar.curr then
            frame.castbar.name:SetPoint('RIGHT', frame.castbar.curr, 'LEFT')
        end
    end

    if frame.castWarning then
        frame.castWarning:ClearAllPoints()
        frame.castWarning:SetPoint('BOTTOMLEFT', frame.name, 'TOPLEFT', 0, 1)
        frame.castWarning:SetJustifyH('LEFT')

        frame.incWarning:ClearAllPoints()
        frame.incWarning:SetPoint('BOTTOMRIGHT', frame.health.p, 'TOPRIGHT', 0, 1)
        frame.incWarning:SetJustifyH('RIGHT')
    end
end

function mod:OnInitialize()
    self:SetEnabledState(extras.db.profile.leftie)
end
function mod:OnEnable()
    self:RegisterMessage('KuiNameplates_PostShow','PostShow')

    orig_UpdateName = addon.UpdateName
    addon.UpdateName = UpdateName
end
