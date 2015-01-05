if not ShockAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("ShockAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local LBF = LibStub("LibButtonFacade", true)
local LBFgroup = nil
local _, _, _, clientVersion = GetBuildInfo()

--if LBF then
--	local LBFgroup = LBF:Group("ShockAndAwe")
--end
ShockAndAwe.PriorityFrame = CreateFrame("Button", "SAA_PriorityFrame", UIParent)
ShockAndAwe.PriorityFrame.cooldown = CreateFrame("Cooldown", "SAA_PriorityFrameCooldown", ShockAndAwe.PriorityFrame)

---------------------------
-- Local Variables
---------------------------

ShockAndAwe.priorityTable = {}
ShockAndAwe.priorityTable.name = {}
ShockAndAwe.priorityTable.icon = {}
ShockAndAwe.priorityTable.test = {}

--------------------------
--  Helper Functions
--------------------------
-- returns : true if spellname is available in less than priority.cooldown
--                 or if spellname is currently activated
--           , remaining cooldown, 0 if ready to be cast
function ShockAndAwe:SpellAvailable(spellname)
	if ShockAndAwe.db.char.priority.hideImmune and self:IsTargetImmune(spellname) then
		return false
	end
	local start, duration = GetSpellCooldown(spellname)
	if start then
		local timeleft = start + duration - GetTime()
		return timeleft <= ShockAndAwe.db.char.priority.cooldown, duration, timeleft
	end
	return false, 999
end

function ShockAndAwe:GCDAvailable()
	local startTime, gcdDuration = GetSpellCooldown(ShockAndAwe.constants["Lightning Bolt"])
	local gcdTime = startTime + gcdDuration - GetTime()
	return gcdTime <= ShockAndAwe.db.char.priority.cooldown 
end

function ShockAndAwe:GetDebuffInfo(debuff)
	local index = 1
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, debuffExpires, unitCaster = UnitDebuff("target", index)
		local isMine = unitCaster == "player" 
		if name == debuff and isMine then 
			local duration = debuffExpires - GetTime()
			return duration > ShockAndAwe.db.char.priority.cooldown, duration, count, debuffExpires
		end
		index = index + 1
	end
	return false, 0, 0, 0
end

function ShockAndAwe:GetBuffInfo(buff)
	local index = 1
	while UnitBuff("player", index) do
		local name, _, _, count, _, _, buffExpires = UnitBuff("player", index)
		if name == buff then 
			local duration = buffExpires - GetTime()
			return duration > ShockAndAwe.db.char.priority.cooldown, duration, count
		end
		index = index + 1
	end
	return false, 0, 0
end

function ShockAndAwe:IsTargetImmune(spell)
	target = UnitName("target") or ""
	if spell and ShockAndAwe.db.char.immuneTargets[target.."_"..spell] then
		return true
	end
	return false
end

function ShockAndAwe:FireTotemNeeded(spell)
	if ShockAndAwe:GCDAvailable() then
		-- only bother checking for totem availabilty if we have a GCD
		local _, totemname, start, duration = GetTotemInfo(1)
		if totemname == nil or totemname == "" then -- no fire totem deployed so recommend it be dropped
			return true
		end
		if start and strmatch(totemname, spell) then
			local timeleft = start + duration - GetTime()
			return timeleft <= ShockAndAwe.db.char.priority.cooldown, duration
		end
	end
	return false, 999
end

------------------
-- Priorities
------------------

function ShockAndAwe:SetPriorityTable()
	ShockAndAwe.priorityTable.name["sr"] = ShockAndAwe.constants["Shamanistic Rage"]
	ShockAndAwe.priorityTable.icon["sr"] = ShockAndAwe.constants["Shamanistic Rage Icon"]
	ShockAndAwe.priorityTable.test["sr"] = 
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Shamanistic Rage"])
		end 

	ShockAndAwe.priorityTable.name["sr_boss"] = L["Shamanistic Rage on Boss"]
	ShockAndAwe.priorityTable.icon["sr_boss"] = ShockAndAwe.constants["Shamanistic Rage Icon"]
	ShockAndAwe.priorityTable.test["sr_boss"] = 
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Shamanistic Rage"]) and UnitClassification("target") == "worldboss"
		end 

	ShockAndAwe.priorityTable.name["sw"] = ShockAndAwe.constants["Feral Spirit"]
	ShockAndAwe.priorityTable.icon["sw"] = ShockAndAwe.constants["Feral Spirit Icon"]
	ShockAndAwe.priorityTable.test["sw"] = 
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Feral Spirit"])
		end 

	ShockAndAwe.priorityTable.name["sw_boss"] = L["Feral Spirit on Boss"]
	ShockAndAwe.priorityTable.icon["sw_boss"] = ShockAndAwe.constants["Feral Spirit Icon"]
	ShockAndAwe.priorityTable.test["sw_boss"] = 
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Feral Spirit"]) and UnitClassification("target") == "worldboss"
		end 

	ShockAndAwe.priorityTable.name["mw5_lb"] = L["MW5 Lightning Bolt"]
	ShockAndAwe.priorityTable.icon["mw5_lb"] = ShockAndAwe.constants["Lightning Bolt Icon"]
	ShockAndAwe.priorityTable.test["mw5_lb"] = 
		function () 
			return ShockAndAwe.db.char.msstacks == 5 
		end 
		
	ShockAndAwe.priorityTable.name["lb_as"] = L["Lightning Bolt if Ancestral Swiftness is up"]
	ShockAndAwe.priorityTable.icon["lb_as"] = ShockAndAwe.constants["Lightning Bolt Icon"]
	ShockAndAwe.priorityTable.test["lb_as"] = 
		function () 
		    local start, duration, enabled = GetSpellCooldown("Ancestral Swiftness")
			if enabled == 0 then
			  return true
			else
			  return false
			end
		end
		
	ShockAndAwe.priorityTable.name["cl_as"] = L["Chain Lightning if Ancestral Swiftness is up"]
	ShockAndAwe.priorityTable.icon["cl_as"] = ShockAndAwe.constants["Chain Lightning Icon"]
	ShockAndAwe.priorityTable.test["cl_as"] = 
		function () 
		    local start, duration, enabled = GetSpellCooldown("Ancestral Swiftness")
			if enabled == 0 then
			  return true
			else
			  return false
			end
		end

	ShockAndAwe.priorityTable.name["mw4_lb"] = L["MW4 Lightning Bolt"]
	ShockAndAwe.priorityTable.icon["mw4_lb"] = ShockAndAwe.constants["Lightning Bolt Icon"]
	ShockAndAwe.priorityTable.test["mw4_lb"] = 
		function () 
			return ShockAndAwe.db.char.msstacks >= 4 
		end 

	ShockAndAwe.priorityTable.name["mw3_lb"] = L["MW3 Lightning Bolt"]
	ShockAndAwe.priorityTable.icon["mw3_lb"] = ShockAndAwe.constants["Lightning Bolt Icon"]
	ShockAndAwe.priorityTable.test["mw3_lb"] = 
		function () 
			return ShockAndAwe.db.char.msstacks >= 3 
		end 

	ShockAndAwe.priorityTable.name["mw5_cl"] = L["MW5 Chain Lightning"]
	ShockAndAwe.priorityTable.icon["mw5_cl"] = ShockAndAwe.constants["Chain Lightning Icon"]
	ShockAndAwe.priorityTable.test["mw5_cl"] = 
		function () 
			return ShockAndAwe.db.char.msstacks == 5 and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Chain Lightning"])
		end 

	ShockAndAwe.priorityTable.name["mw4_cl"] = L["MW4 Chain Lightning"]
	ShockAndAwe.priorityTable.icon["mw4_cl"] = ShockAndAwe.constants["Chain Lightning Icon"]
	ShockAndAwe.priorityTable.test["mw4_cl"] = 
		function () 
			return ShockAndAwe.db.char.msstacks >= 4 and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Chain Lightning"])
		end 

	ShockAndAwe.priorityTable.name["mw3_cl"] = L["MW3 Chain Lightning"]
	ShockAndAwe.priorityTable.icon["mw3_cl"] = ShockAndAwe.constants["Chain Lightning Icon"]
	ShockAndAwe.priorityTable.test["mw3_cl"] = 
		function () 
			return ShockAndAwe.db.char.msstacks >= 3 and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Chain Lightning"])
		end 

	ShockAndAwe.priorityTable.name["ss"] = ShockAndAwe.constants["Stormstrike"]
	ShockAndAwe.priorityTable.icon["ss"] = ShockAndAwe.constants["Stormstrike Icon"]
	ShockAndAwe.priorityTable.test["ss"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Stormstrike"])
		end 

	ShockAndAwe.priorityTable.name["ss_0"] = L["Stormstrike if no debuff"]
	ShockAndAwe.priorityTable.icon["ss_0"] = ShockAndAwe.constants["Stormstrike Icon"]
	ShockAndAwe.priorityTable.test["ss_0"] =  
	function () 
		return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Stormstrike"]) and not ShockAndAwe:GetDebuffInfo(ShockAndAwe.constants["Stormstrike"])
	end 

	ShockAndAwe.priorityTable.name["es"] = ShockAndAwe.constants["Earth Shock"]
	ShockAndAwe.priorityTable.icon["es"] = ShockAndAwe.constants["Earth Shock Icon"]
	ShockAndAwe.priorityTable.test["es"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Earth Shock"])
		end 

	ShockAndAwe.priorityTable.name["es_ss"] = L["Earth Shock if SS"]
	ShockAndAwe.priorityTable.icon["es_ss"] = ShockAndAwe.constants["Earth Shock Icon"]
	ShockAndAwe.priorityTable.test["es_ss"] =  
		function () 
			return ShockAndAwe:GetDebuffInfo(ShockAndAwe.constants["Stormstrike"]) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Earth Shock"])
		end 

	ShockAndAwe.priorityTable.name["fs"] = ShockAndAwe.constants["Flame Shock"]
	ShockAndAwe.priorityTable.icon["fs"] = ShockAndAwe.constants["Flame Shock Icon"]
	ShockAndAwe.priorityTable.test["fs"] =  
		function () 
			local debuffPresent, duration = ShockAndAwe:GetDebuffInfo(ShockAndAwe.constants["Flame Shock"])
			local ticksLeft = 6 * duration / (ShockAndAwe.db.char.priority.FSDotMax or 18)
			return (not debuffPresent or ticksLeft <= ShockAndAwe.db.char.priority.fsticksleft) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Flame Shock"]) 
		end

	ShockAndAwe.priorityTable.name["fs_boss"] = L["Flame Shock on Boss"]
	ShockAndAwe.priorityTable.icon["fs_boss"] = ShockAndAwe.constants["Flame Shock Icon"]
	ShockAndAwe.priorityTable.test["fs_boss"] =  
		function () 
			local debuffPresent, duration = ShockAndAwe:GetDebuffInfo(ShockAndAwe.constants["Flame Shock"])
			local ticksLeft = 6 * duration / (ShockAndAwe.db.char.priority.FSDotMax or 18)
			return (not debuffPresent or ticksLeft <= ShockAndAwe.db.char.priority.fsticksleft) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Flame Shock"]) and UnitClassification("target") == "worldboss"
		end 

	ShockAndAwe.priorityTable.name["fn"] = ShockAndAwe.constants["Fire Nova"]
	ShockAndAwe.priorityTable.icon["fn"] = ShockAndAwe.constants["Fire Nova Icon"]
	ShockAndAwe.priorityTable.test["fn"] =  
		function () 
			local FSDotTime = ShockAndAwe:getFSDotTime()			
			if not FSDotTime or FSDotTime < GetTime() then -- no Flame Shock active so cannot use Fire Nova
				return false
			end
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Fire Nova"]) 
		end 

	ShockAndAwe.priorityTable.name["fe"] = ShockAndAwe.constants["Fire Elemental Totem"]
	ShockAndAwe.priorityTable.icon["fe"] = ShockAndAwe.constants["Fire Elemental Totem Icon"]
	ShockAndAwe.priorityTable.test["fe"] =  
		function () 
			return ShockAndAwe:FireTotemNeeded(ShockAndAwe.constants["Fire Elemental Totem"]) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Fire Elemental Totem"]) 
		end 

	ShockAndAwe.priorityTable.name["fe_boss"] = L["Fire Elemental on Boss"]
	ShockAndAwe.priorityTable.icon["fe_boss"] = ShockAndAwe.constants["Fire Elemental Totem Icon"]
	ShockAndAwe.priorityTable.test["fe_boss"] =  
		function () 
			return ShockAndAwe:FireTotemNeeded(ShockAndAwe.constants["Fire Elemental Totem"]) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Fire Elemental Totem"]) and UnitClassification("target") == "worldboss"
		end 
		
	ShockAndAwe.priorityTable.name["ll"] = ShockAndAwe.constants["Lava Lash"]
	ShockAndAwe.priorityTable.icon["ll"] = ShockAndAwe.constants["Lava Lash Icon"]
	ShockAndAwe.priorityTable.test["ll"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Lava Lash"])
		end 
		
	ShockAndAwe.priorityTable.name["ll_sf5"] = L["Lava Lash 5 Searing Flames"]
	ShockAndAwe.priorityTable.icon["ll_sf5"] = ShockAndAwe.constants["Lava Lash Icon"]
	ShockAndAwe.priorityTable.test["ll_sf5"] =  
		function () 
			local _, _, sfstacks = ShockAndAwe:GetBuffInfo(ShockAndAwe.constants["Searing Flames"])
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Lava Lash"]) and sfstacks == 5
		end 
		
	ShockAndAwe.priorityTable.name["ll_sf4"] = L["Lava Lash 4 Searing Flames"]
	ShockAndAwe.priorityTable.icon["ll_sf4"] = ShockAndAwe.constants["Lava Lash Icon"]
	ShockAndAwe.priorityTable.test["ll_sf4"] =  
		function () 
			local _, _, sfstacks = ShockAndAwe:GetBuffInfo(ShockAndAwe.constants["Searing Flames"])
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Lava Lash"]) and sfstacks >= 4
		end 
		
	ShockAndAwe.priorityTable.name["ll_sf3"] = L["Lava Lash 3 Searing Flames"]
	ShockAndAwe.priorityTable.icon["ll_sf3"] = ShockAndAwe.constants["Lava Lash Icon"]
	ShockAndAwe.priorityTable.test["ll_sf3"] =  
		function () 
			local _, _, sfstacks = ShockAndAwe:GetBuffInfo(ShockAndAwe.constants["Searing Flames"])
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Lava Lash"]) and sfstacks >= 3
		end 
		
	ShockAndAwe.priorityTable.name["ue"] = ShockAndAwe.constants["Unleash Elements"]
	ShockAndAwe.priorityTable.icon["ue"] = ShockAndAwe.constants["Unleash Elements Icon"]
	ShockAndAwe.priorityTable.test["ue"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Unleash Elements"])
		end 
		
	ShockAndAwe.priorityTable.name["ue_uf"] = L["Unleash Elements if Unleashed Fury is known"]
	ShockAndAwe.priorityTable.icon["ue_uf"] = ShockAndAwe.constants["Unleash Elements Icon"]
	ShockAndAwe.priorityTable.test["ue_uf"] =  
		function () 	
            -- Unleash Elements if spec into Unleashed Fury		
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Unleash Elements"]) and IsSpellKnown(117012)
		end
		
	ShockAndAwe.priorityTable.name["eb"] = ShockAndAwe.constants["Elemental Blast"]
	ShockAndAwe.priorityTable.icon["eb"] = ShockAndAwe.constants["Elemental Blast Icon"]
	ShockAndAwe.priorityTable.test["eb"] =  
		function () 			
			return IsSpellKnown(117014) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Elemental Blast"])
		end
		
	ShockAndAwe.priorityTable.name["as_mw<2"] = L["Ancestral Swiftness if MW < 2"]
	ShockAndAwe.priorityTable.icon["as_mw<2"] = ShockAndAwe.constants["Ancestral Swiftness Icon"]
	ShockAndAwe.priorityTable.test["as_mw<2"] =  
		function () 			
			return IsSpellKnown(16188) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Ancestral Swiftness"]) and ShockAndAwe.db.char.msstacks < 2
		end
		
	ShockAndAwe.priorityTable.name["as"] = ShockAndAwe.constants["Ancestral Swiftness"]
	ShockAndAwe.priorityTable.icon["as"] = ShockAndAwe.constants["Ancestral Swiftness Icon"]
	ShockAndAwe.priorityTable.test["as"] =  
		function () 			
			return IsSpellKnown(16188) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Ancestral Swiftness"])
		end
		
	ShockAndAwe.priorityTable.name["fs_uef"] = L["Flame Shock if Unleash Flame"]
	ShockAndAwe.priorityTable.icon["fs_uef"] = ShockAndAwe.constants["Flame Shock Icon"]
	ShockAndAwe.priorityTable.test["fs_uef"] = 
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Flame Shock"]) and ShockAndAwe:GetBuffInfo(ShockAndAwe.constants["Unleash Flame"])
		end 
		
	ShockAndAwe.priorityTable.name["st"] = ShockAndAwe.constants["Searing Totem"]
	ShockAndAwe.priorityTable.icon["st"] = ShockAndAwe.constants["Searing Totem Icon"]
	ShockAndAwe.priorityTable.test["st"] =  
		function () 
			local timeleft = ShockAndAwe.db.char.priority.firetotemtime - GetTime()
			return (ShockAndAwe:FireTotemNeeded(ShockAndAwe.constants["Searing Totem"]) or timeleft < 1.64 * ShockAndAwe.db.char.priority.searingticks) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Searing Totem"])
		end 

	ShockAndAwe.priorityTable.name["mt"] = ShockAndAwe.constants["Magma Totem"]
	ShockAndAwe.priorityTable.icon["mt"] = ShockAndAwe.constants["Magma Totem Icon"]
	ShockAndAwe.priorityTable.test["mt"] =  
		function () 
			local timeleft = ShockAndAwe.db.char.priority.firetotemtime - GetTime()
			return (ShockAndAwe:FireTotemNeeded(ShockAndAwe.constants["Magma Totem"]) or timeleft < 2 * ShockAndAwe.db.char.priority.magmaticks) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Magma Totem"])
		end 

	ShockAndAwe.priorityTable.name["mt_0"] = L["Magma Totem if expired"]
	ShockAndAwe.priorityTable.icon["mt_0"] = ShockAndAwe.constants["Magma Totem Icon"]
	ShockAndAwe.priorityTable.test["mt_0"] =  
		function () 
			return ShockAndAwe:FireTotemNeeded(ShockAndAwe.constants["Magma Totem"]) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Magma Totem"])
		end

	ShockAndAwe.priorityTable.name["ls_0"] = L["Lightning Shield if expired"]
	ShockAndAwe.priorityTable.icon["ls_0"] = ShockAndAwe.constants["Lightning Shield Icon"]
	ShockAndAwe.priorityTable.test["ls_0"] =  
		function () 
			local orbs = ShockAndAwe:GetShieldInfo()
			return orbs == 0 and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Lightning Shield"])
		end

	ShockAndAwe.priorityTable.name["mw5_hs"] = L["MW5 Healing Surge"]
	ShockAndAwe.priorityTable.test["mw5_hs"] = 
		function () 
			if ShockAndAwe.db.char.priority.chingroup == true and GetNumGroupMembers() > 0 then
				ShockAndAwe.priorityTable.icon["mw5_hs"] = ShockAndAwe.constants["Chain Heal Icon"]
			else
				ShockAndAwe.priorityTable.icon["mw5_hs"] = ShockAndAwe.constants["Healing Surge Icon"]
			end
			local healthpercent = 100 * UnitHealth("player") / UnitHealthMax("player")
			return ShockAndAwe.db.char.msstacks == 5 and healthpercent <= ShockAndAwe.db.char.priority.hwhealth
		end
		
	ShockAndAwe.priorityTable.name["mw4_hs"] = L["MW4 Healing Surge"]
	ShockAndAwe.priorityTable.test["mw4_hs"] = 
		function () 
			if ShockAndAwe.db.char.priority.chingroup == true and GetNumGroupMembers() > 0 then
				ShockAndAwe.priorityTable.icon["mw4_hs"] = ShockAndAwe.constants["Chain Heal Icon"]
			else
				ShockAndAwe.priorityTable.icon["mw4_hs"] = ShockAndAwe.constants["Healing Surge Icon"]
			end
			local healthpercent = 100 * UnitHealth("player") / UnitHealthMax("player")
			return ShockAndAwe.db.char.msstacks >= 4 and healthpercent <= ShockAndAwe.db.char.priority.hwhealth
		end
		
	ShockAndAwe.priorityTable.name["shield"] = ShockAndAwe.constants["Water Shield"] .. "/" .. ShockAndAwe.constants["Lightning Shield"]
	ShockAndAwe.priorityTable.test["shield"] = 
		function ()
			local orbs, shield, shieldExpires = ShockAndAwe:GetShieldInfo()
			local timeleft = shieldExpires - GetTime()
			if timeleft <= ShockAndAwe.db.char.priority.cooldown or orbs <= ShockAndAwe.db.char.priority.shieldorbs then
				local manapercent = 100 * UnitMana("player") / UnitManaMax("player")
				if manapercent <= ShockAndAwe.db.char.priority.wsmana then
					ShockAndAwe.priorityTable.icon["shield"] = ShockAndAwe.constants["Water Shield Icon"]
					return true
				else
					ShockAndAwe.priorityTable.icon["shield"] = ShockAndAwe.constants["Lightning Shield Icon"]
					return true
				end
			else
				return false
			end 
		end
		
	ShockAndAwe.priorityTable.name["sl_totem"] = ShockAndAwe.constants["Stormlash Totem"]
	ShockAndAwe.priorityTable.icon["sl_totem"] = ShockAndAwe.constants["Stormlash Totem Icon"]
	ShockAndAwe.priorityTable.test["sl_totem"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Stormlash Totem"])
		end
		
	ShockAndAwe.priorityTable.name["em"] = ShockAndAwe.constants["Elemental Mastery"]
	ShockAndAwe.priorityTable.icon["em"] = ShockAndAwe.constants["Elemental Mastery Icon"]
	ShockAndAwe.priorityTable.test["em"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Elemental Mastery"])
		end
		
	ShockAndAwe.priorityTable.name["Ascendance"] = ShockAndAwe.constants["Ascendance"]
	ShockAndAwe.priorityTable.icon["Ascendance"] = ShockAndAwe.constants["Ascendance Icon"]
	ShockAndAwe.priorityTable.test["Ascendance"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Ascendance"])
		end
		
	ShockAndAwe.priorityTable.name["Earth Elemental Totem"] = ShockAndAwe.constants["Earth Elemental Totem"]
	ShockAndAwe.priorityTable.icon["Earth Elemental Totem"] = ShockAndAwe.constants["Earth Elemental Totem Icon"]
	ShockAndAwe.priorityTable.test["Earth Elemental Totem"] =  
		function () 
			return ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Earth Elemental Totem"])
		end
		
	ShockAndAwe.priorityTable.name["MW>3_LB_UF"] = L["MW>3_LB_UF"]
	ShockAndAwe.priorityTable.icon["MW>3_LB_UF"] = ShockAndAwe.constants["Lightning Bolt Icon"]
	ShockAndAwe.priorityTable.test["MW>3_LB_UF"] = 
		function () 
			return ShockAndAwe.db.char.msstacks >= 3 and ShockAndAwe:GetBuffInfo(ShockAndAwe.constants["Unleashed Fury"])
		end
		
	ShockAndAwe.priorityTable.name["MW>1_LB"] = L["MW>1_LB"]
	ShockAndAwe.priorityTable.icon["MW>1_LB"] = ShockAndAwe.constants["Lightning Bolt Icon"]
	ShockAndAwe.priorityTable.test["MW>1_LB"] = 
		function () 
			return ShockAndAwe.db.char.msstacks > 1 
		end
		
	ShockAndAwe.priorityTable.name["FS_UEF"] = L["FS_UEF"]
	ShockAndAwe.priorityTable.icon["FS_UEF"] = ShockAndAwe.constants["Flame Shock Icon"]
	ShockAndAwe.priorityTable.test["FS_UEF"] = 
		function () 	
		    local debuffPresent, duration = ShockAndAwe:GetDebuffInfo(ShockAndAwe.constants["Flame Shock"])
		    local ticksLeft = 6 * duration / (ShockAndAwe.db.char.priority.FSDotMax or 18)
			return (not debuffPresent or ticksLeft <= ShockAndAwe.db.char.priority.fsticksleft) and ShockAndAwe:SpellAvailable(ShockAndAwe.constants["Flame Shock"]) and ShockAndAwe:GetBuffInfo(ShockAndAwe.constants["Unleash Flame"])
		end

	ShockAndAwe.priorityTable.name["none"] = L["None"]
	_, _, ShockAndAwe.priorityTable.icon["none"] = "Interface/Tooltips/UI-Tooltip-Background"
	ShockAndAwe.priorityTable.test["none"] = function () return false end 
end
-------------------------------
-- Priority Frame functions
-------------------------------

function ShockAndAwe:SetPriorityBackdrop(icon)
--	self.PriorityFrame.Icon:SetTexture(icon)
	self.PriorityFrame:SetBackdrop({ bgFile = icon,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
end

function ShockAndAwe:CreatePriorityFrame()
	self.updatePriority = false
	self.PriorityFrame:SetScale(ShockAndAwe.db.char.priority.scale)
	self.PriorityFrame:SetFrameStrata("BACKGROUND")
	self.PriorityFrame:SetWidth(ShockAndAwe.db.char.priority.fWidth)
	self.PriorityFrame:SetHeight(ShockAndAwe.db.char.priority.fHeight)
	self.PriorityFrame.Icon = _G["SAA_PriorityFrameIcon"]
	self:SetPriorityBackdrop("Interface/Tooltips/UI-Tooltip-Background")
	self.PriorityFrame:SetBackdropColor(0, 0, 0, ShockAndAwe.db.char.priority.alpha);
	self.PriorityFrame:SetMovable(true);
	self.PriorityFrame:RegisterForDrag("LeftButton");
	self.PriorityFrame:EnableMouse(false)
	self.PriorityFrame:SetPoint(ShockAndAwe.db.char.priority.point, ShockAndAwe.db.char.priority.relativeTo, ShockAndAwe.db.char.priority.relativePoint, ShockAndAwe.db.char.priority.xOffset, ShockAndAwe.db.char.priority.yOffset)
	self.PriorityFrame:SetScript("OnDragStart", 
		function()
			self.PriorityFrame:StartMoving();
		end );
	self.PriorityFrame:SetScript("OnDragStop",
		function()
			self.PriorityFrame:StopMovingOrSizing();
			self.PriorityFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(ShockAndAwe.db.char.priority, self.PriorityFrame);
		end );
	self:SetPriorityUpdateScript()
	if not self.PriorityFrame.topText then
		self.PriorityFrame.topText = self.PriorityFrame:CreateFontString(nil, "OVERLAY")
	end
	self.PriorityFrame.topText:SetTextColor(1,1,1,1)
	self.PriorityFrame.topText:SetFont(media:Fetch("font", ShockAndAwe.db.char.barfont), ShockAndAwe.db.char.barfontsize)
	self.PriorityFrame.topText:SetPoint("TOP", self.PriorityFrame, "TOP", 0, ShockAndAwe.db.char.barfontsize + 2)
	self.PriorityFrame.topText:SetText(string.format(L["Next Priority (Set %s)"], ShockAndAwe.db.char.priority.groupnumber))
	self.PriorityFrame.cooldown:SetAllPoints(self.PriorityFrame)
	self:CreateComboPointFrames()
	self:CreateInterruptPurgeFrames()
	
	if ShockAndAwe.db.char.priority.show and InCombatLockdown() then
		self.PriorityFrame:Show()
	else
		self.PriorityFrame:Hide()
	end
	if ShockAndAwe.db.char.priority.titleshow then
		self.PriorityFrame.topText:Show()
	else
		self.PriorityFrame.topText:Hide()
	end
	if LBF and LBFgroup then
		LBFgroup:AddButton(self.PriorityFrame)
	end
end

function ShockAndAwe:ResetPriority()
	self.PriorityFrame:ClearAllPoints()
	ShockAndAwe.db.char.priority.point = self.defaults.char.priority.point
	ShockAndAwe.db.char.priority.relativeTo = self.defaults.char.priority.relativeTo 
	ShockAndAwe.db.char.priority.relativePoint = self.defaults.char.priority.relativePoint
	ShockAndAwe.db.char.priority.xOffset = self.defaults.char.priority.xOffset
	ShockAndAwe.db.char.priority.yOffset = self.defaults.char.priority.yOffset
	ShockAndAwe.db.char.priority.fWidth = self.defaults.char.priority.fWidth
	ShockAndAwe.db.char.priority.fHeight = self.defaults.char.priority.fHeight
	ShockAndAwe.db.char.priority.scale = self.defaults.char.priority.scale
	ShockAndAwe.db.char.priority.prOption = self.defaults.char.priority.prOption
	self.PriorityFrame:SetPoint(ShockAndAwe.db.char.priority.point, ShockAndAwe.db.char.priority.relativeTo, ShockAndAwe.db.char.priority.relativePoint, ShockAndAwe.db.char.priority.xOffset, ShockAndAwe.db.char.priority.yOffset)
	self:CreatePriorityFrame()
	self:Print(L["priority_reset"])
end

function ShockAndAwe:SetPriorityUpdateScript()
	self.PriorityFrame:SetScript("OnUpdate", 
		function()
			if self.updatePriority then
				ShockAndAwe.db.char.priority.previous = ShockAndAwe.db.char.priority.next
				ShockAndAwe:SetNextPriority()
--				if ShockAndAwe.db.char.priority.next ~= ShockAndAwe.db.char.priority.previous or ShockAndAwe:CheckShamanisticRage() then
				ShockAndAwe:SetPriorityIcon(ShockAndAwe.db.char.priority.next) -- always set icon to fix the times where it was getting stuck
--				end
				if ShockAndAwe.db.char.priority.showcooldown then
					local startTime, duration = GetSpellCooldown(ShockAndAwe.constants["Lightning Shield"])
					if startTime then
						ShockAndAwe.PriorityFrame.cooldown:SetCooldown(startTime, duration)
					end
				end
			end
		end );
end

function ShockAndAwe:SetPriorityIcon(priority)
	--self:DebugPrint("setting icon to "..priority)
	if InCombatLockdown() or priority == "none" then
		local icon = self.priorityTable.icon[priority]
		if self:CheckWindShear() then
			icon = ShockAndAwe.constants["Wind Shear Icon"]
			ShockAndAwe.db.char.priority.next = "wind"
		end
		if self:CheckShamanisticRage() then
			icon = ShockAndAwe.constants["Shamanistic Rage Icon"]
			ShockAndAwe.db.char.priority.next = "mana"
		end
		-- check if we should show shamanistic rage icon
		self:SetPriorityBackdrop(icon)
	end
end

function ShockAndAwe:CheckWindShear()
	if not ShockAndAwe.db.char.priority.worldbossonly or (ShockAndAwe.db.char.priority.worldbossonly and UnitClassification("target") == "worldboss") then
		if ShockAndAwe.db.char.windshearshow and (GetNumGroupMembers()>=4) then
			-- don't use windshear option if soloing
			local _, state, _, raw = UnitDetailedThreatSituation("player", "target")
			-- state 2 or 3 = tanking which is not what an Enh Shammy should be doing
			-- state 0 threat < 100%, state 1 threat >=100%
			if not state then state = 0 end
			if not raw then raw = 0 end
			if  state > 1 or raw > ShockAndAwe.db.char.threatThreshold then
				-- we have exceeded threshold or have already started tanking so wind shear needed.
				local startTime, duration = GetSpellCooldown(ShockAndAwe.constants["Wind Shear"])
				if startTime then -- extra check in case player hasn't learned Wind Shear
					local timeleft = startTime + duration - GetTime()
					if timeleft <= ShockAndAwe.db.char.priority.cooldown then -- check its off cooldown
						return true
					end
				end
			end
		end
	end
	return false
end

function ShockAndAwe:CheckShamanisticRage()
	local srtalent
	_, _, _, _, srtalent = GetTalentInfo(2,26)
	if srtalent == 1 then
		local startTime, duration = GetSpellCooldown(ShockAndAwe.constants["Shamanistic Rage"])
		if startTime then 
			local timeleft = startTime + duration - GetTime()
			local manapercent = 100 * UnitMana("player") / UnitManaMax("player")
			if manapercent < ShockAndAwe.db.char.priority.srmana and timeleft <= ShockAndAwe.db.char.priority.cooldown then
				return true
			end
		end
	end
	return false
end

function ShockAndAwe:QuakingEarthEquipped()
	local rangedLink = GetInventoryItemLink("player",GetInventorySlotInfo("RangedSlot")) or "0:0"
    local _, itemID = strsplit(":", rangedLink)
	return itemID == "47667" -- returns if ranged slot has Totem of Quaking Earth
end

function ShockAndAwe:SetNextPriority()
	-- force update of stacks count to ensure priority shown correctly
	ShockAndAwe.db.char.msstacks = ShockAndAwe:GetMaelstromInfo()
	if ShockAndAwe.db.char.priority.combopoints then
		self:ShowComboPoints()
	end
	ShockAndAwe.db.char.priority.next = "none"
	for index = 1, 16 do
		if ShockAndAwe.db.char.priority.prOption[index] and self.priorityTable.test[ShockAndAwe.db.char.priority.prOption[index]] then  -- verify that the option actually exists
			if self.priorityTable.test[ShockAndAwe.db.char.priority.prOption[index]]() then
				ShockAndAwe.db.char.priority.next = ShockAndAwe.db.char.priority.prOption[index]
				return -- we need to break out of the routine as we have found the top priority
			end
		end
	end
end

function ShockAndAwe:ShowComboPoints()
	local col = ShockAndAwe.db.char.colours.maelstrom
	for index = 1, 5 do
		if self.PriorityFrame.combo[index].frame then
			if ShockAndAwe.db.char.msstacks >= index then
				self.PriorityFrame.combo[index].frame:SetBackdropColor(1, 0, 0, 1)
			else
				self.PriorityFrame.combo[index].frame:SetBackdropColor(col.r, col.g, col.b, 0)
			end
		else
			self:Print("Error could not find combo frame "..index)
		end
	end
end

function ShockAndAwe:CreateComboPointFrames()
	self.PriorityFrame.combo = {}
	for index = 1, 5 do 
		self:CreateComboPoint(index)
	end
end
	
function ShockAndAwe:CreateComboPoint(index)
	if not self.PriorityFrame.combo[index] or not self.PriorityFrame.combo[index].frame then
		self.PriorityFrame.combo[index] = {}
		self.PriorityFrame.combo[index].frame = CreateFrame("Frame", "SAA_PriorityComboFrame"..index, self.PriorityFrame)
	end
	local comboFrame = self.PriorityFrame.combo[index].frame
	local width = ShockAndAwe.db.char.priority.fWidth / 5
	local height = ShockAndAwe.db.char.priority.fHeight / 5
	comboFrame:SetScale(ShockAndAwe.db.char.priority.scale)
	comboFrame:SetFrameStrata("BACKGROUND")
	comboFrame:SetWidth(width)
	comboFrame:SetHeight(height)
	comboFrame:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 4,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})	
	comboFrame:SetBackdropColor(0, 0, 0, 0);
	comboFrame:SetPoint("BOTTOMLEFT",  self.PriorityFrame, "BOTTOMLEFT", (index - 1) * width , - height)

	if ShockAndAwe.db.char.priority.combopoints then
		comboFrame:Show()
	else
		comboFrame:Hide()
	end
end

function ShockAndAwe:CreateInterruptPurgeFrames()
	if not self.PriorityFrame.interrupt then
		self.PriorityFrame.interrupt = {}
		self.PriorityFrame.interrupt.frame = CreateFrame("Frame", "SAA_PriorityInterruptFrame", self.PriorityFrame)
	end
	local interruptFrame = self.PriorityFrame.interrupt.frame
	local width = ShockAndAwe.db.char.priority.fWidth / 2
	local height = ShockAndAwe.db.char.priority.fHeight / 2
	interruptFrame:SetScale(ShockAndAwe.db.char.priority.scale)
	interruptFrame:SetFrameStrata("BACKGROUND")
	interruptFrame:SetWidth(width)
	interruptFrame:SetHeight(height)
	self:SetSubFrameBackdrop(interruptFrame, "Interface/Tooltips/UI-Tooltip-Background", 4)	
	interruptFrame:SetBackdropColor(0, 0, 0, 0);
	interruptFrame:SetPoint("BOTTOMLEFT",  self.PriorityFrame, "BOTTOMRIGHT", 0 , 0)
	if ShockAndAwe.db.char.priority.showinterrupt then
		interruptFrame:Show()
	else
		interruptFrame:Hide()
	end

	if not self.PriorityFrame.purge then
		self.PriorityFrame.purge = {}
		self.PriorityFrame.purge.frame = CreateFrame("Frame", "SAA_PrioritypurgeFrame", self.PriorityFrame)
	end
	local purgeFrame = self.PriorityFrame.purge.frame
	purgeFrame:SetScale(ShockAndAwe.db.char.priority.scale)
	purgeFrame:SetFrameStrata("BACKGROUND")
	purgeFrame:SetWidth(width)
	purgeFrame:SetHeight(height)
	self:SetSubFrameBackdrop(purgeFrame, "Interface/Tooltips/UI-Tooltip-Background", 4)	
	purgeFrame:SetBackdropColor(0, 0, 0, 0);
	purgeFrame:SetPoint("BOTTOMLEFT",  self.PriorityFrame, "BOTTOMRIGHT", 0 , height)	
	if ShockAndAwe.db.char.priority.showpurge then
		purgeFrame:Show()
	else
		purgeFrame:Hide()
	end
end

function ShockAndAwe:SetSubFrameBackdrop(subFrame, icon, edgeSize)
	subFrame:SetBackdrop({ bgFile = icon,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = edgeSize,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})	
end