local addon = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')
local mod = addon:NewModule('ExtrasCore', addon.Prototype, 'AceEvent-3.0')

mod.uiName = 'Extras'

-- register ####################################################################
function mod:GetOptions()
    return {
        leftie = {
            name = 'Leftie',
            desc = 'Use left-aligned text layout (similar to the pre-223 layout). Note that this layout truncates long names. But maybe you prefer that.',
            order = 10,
            type = 'toggle'
        },
        health = {
            name = 'Contextual health',
            desc = 'Complements your choice of health display with another suitable value. For example, if you choose to display health percentage, contextual health will be shown next to the percentage as currect health.',
            order = 20,
            type = 'toggle'
        }
    }
end
function mod:OnInitialize()
    self.db = addon.db:RegisterNamespace(self.moduleName, {
        profile = {
            leftie = false,
            health = false
        }
    })
    addon:InitModuleOptions(self)
end
