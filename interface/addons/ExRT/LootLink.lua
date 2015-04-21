local GlobalAddonName, ExRT = ...

local module = ExRT.mod:New("LootLink",ExRT.L.LootLink,nil,true)

local VExRT = nil

module.db.mobsIDs = {
	[78714]=true,	--Kargath
	[77404]=true,	--Butcher
	[78491]=true,	--Mushroom
	[78948]=true,	--Tectus
	[78237]=true,	--Fem
	[78238]=true,	--Pol
	[79015]=true,	--Koragh
	[77428]=true,	--Margok
	[78623]=true,	--Chogall
	
	[76877]=true,	--Gruul
	[77182]=true,	--Oregorger
	[76806]=true,	--Heart of the Mountain
	[76865]=true,	--Darmac
	[76906]=true,	--Thogar
	[77477]=true,	--Marak
	[77231]=true,	--Sorka
	[77557]=true,	--Garan
	[76974]=true,	--Franzok
	[76973]=true,	--Hansgar
	[76814]=true,	--Kagraz
	[77692]=true,	--Kromog
	[77325]=true,	--Blackhand
	
}
module.db.cache = {}

function module.options:Load()
	self:CreateTilte()

	self.enableChk = ExRT.lib.CreateCheckBox(self,nil,10,-30,ExRT.L.LootLinkEnable,VExRT.LootLink.enabled)
	self.enableChk:SetScript("OnClick", function(self,event) 
		if self:GetChecked() then
			VExRT.LootLink.enabled = true
			module:Enable()
		else
			VExRT.LootLink.enabled = nil
			module:Disable()
		end
	end)
	
	self.shtml1 = ExRT.lib.CreateText(self,595,0,"TOP",0,-70,nil,"TOP",nil,12,ExRT.L.LootLinkSlashHelp)
end


function module:Enable()
	module:RegisterEvents('LOOT_OPENED')
end
function module:Disable()
	module:UnregisterEvents('LOOT_OPENED')
end


function module.main:ADDON_LOADED()
	VExRT = _G.VExRT
	VExRT.LootLink = VExRT.LootLink or {}

	if VExRT.LootLink.enabled then
		module:Enable()
	end
	module:RegisterSlash()
end

local function LootLink(linkAnyway)
	local lootMethod = GetLootMethod()
	local _,_,difficulty = GetInstanceInfo()
	if (lootMethod == "personalloot" or difficulty == 7 or difficulty == 17) and not linkAnyway then
		return
	end
	local count = GetNumLootItems()
	local cache = {}
	local numLink = 0
	local chat_type, playerName = ExRT.mds.chatType()
	for i=1,count do
		local sourceGUID = GetLootSourceInfo(i)
		if sourceGUID and (not module.db.cache[sourceGUID] or linkAnyway) then
			local mobID = ExRT.mds.GUIDtoID(sourceGUID)
			if (module.db.mobsIDs[mobID] or linkAnyway) then
				local itemLink =  GetLootSlotLink(i)
				if itemLink then
					numLink = numLink + 1
					SendChatMessage(numLink..": "..itemLink,chat_type,nil,playerName)
				end
			end
 			cache[sourceGUID] = true
 		end
	end
	for GUID,_ in pairs(cache) do
		module.db.cache[GUID] = true
	end
end


function module.main:LOOT_OPENED()
	LootLink()
end

function module:slash(arg)
	if arg == "loot" then
		LootLink(true)
	end
end
