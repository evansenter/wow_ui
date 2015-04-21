do
	--Stole from LibReforge
	local SPI = 1
	local DODGE = 2
	local PARRY = 3
	local HIT = 4
	local CRIT = 5
	local HASTE = 6
	local EXP = 7
	local MASTERY = 8
	
	local StatToID = {
	["Spirit"] = SPI,
	["DodgeRating"] = DODGE,
	["ParryRating"] = PARRY,
	["HitRating"] = HIT,
	["CritRating"] = CRIT,
	["HasteRating"] = HASTE,
	["ExpertiseRating"] = EXP,
	["MasteryRating"] = MASTERY,
	}
	
	local function WowReforge(inputString)
		local slotNames = {
		["Head"] = 1,
		["Neck"] = 2,
		["Shoulders"] = 3,
		["Chest"] = 5,
		["Waist"] = 6,
		["Legs"] = 7,
		["Feet"] = 8,
		["Wrists"] = 9,
		["Hands"] = 10,
		["Ring1"] = 11,
		["Ring2"] = 12,
		["Trinket1"] = 13,
		["Trinket2"] = 14,
		["Back"] = 15,
		["MainHand"] = 16,
		["OffHand"] = 17,
		["Ranged"] = 18,
		}
		
		local reforgeTable = {}
		local reforgeString = inputString .. "\n"
		local numReforges = 0
		for w in string.gmatch(reforgeString, "(.-)\n") do
			local itemName = nil
			local first, last, slot, from, to = string.find(w, "([%a%d]*)%s*:*%s*(%a*)%s*%->%s*(%a*)")
			if (slotNames[slot] and slotNames[slot] ~= "Used") then
--~ 				local inventoryItemID = GetInventoryItemID("player", slotNames[slot])
				local itemLink = GetInventoryItemLink("player", slotNames[slot])
--~ 				if (inventoryItemID) then
				if (itemLink) then
					itemName = select(1,GetItemInfo(itemLink))
--~ 					_, _, itemName = string.find(itemLink, "%[(.*)%]")
				else
					Reforgerade:ErrorPrint("Reforge wanted for " .. slot .. ", but no item equiped to " .. slot)
				end
				slotNames[slot] = "Used"
			end
			if (from and to and itemName) then
				Reforgerade:DebugPrint("Reforge -" .. itemName .. "- from -" .. from .. "- to -" .. to .. "-")
				if reforgeTable[itemName] then --Reforging information already in table meas a duplicate item name
					reforgeTable[itemName][3] = StatToID[from]
					reforgeTable[itemName][4] = StatToID[to]
				else
					reforgeTable[itemName] = {StatToID[from], StatToID[to]}
				end
				numReforges = numReforges + 1
			else
--~ 				Reforgerade:DebugPrint("unable to parse line " .. w)
--~ 				print(from, to, itemName, slot)
			end
		end
		if numReforges > 0 then
			for slotName,slotID in pairs(slotNames) do
				if (slotID ~= "Used") then  --unforge all slots that are not listed
					local inventoryItemID = GetInventoryItemID("player", slotID)
					if (inventoryItemID) then
						local itemLink = GetInventoryItemLink("player", slotID)
						local itemName = select(1,GetItemInfo(itemLink))
						if (itemName) then  --there is an item in this slot so we need to unforge it.
							if reforgeTable[itemName] then --we already have a reforge for one of these items so it must be a duplicate
								reforgeTable[itemName][3] = 0
								reforgeTable[itemName][4] = 0
							else
								reforgeTable[itemName] = {0,0}
								Reforgerade:DebugPrint("Reforge " .. itemName .. " from none to none")
							end
						else
							Reforgerade:DebugPrint("No items in slot " .. slotName)
						end
					else
						Reforgerade:DebugPrint("No items in slot " .. slotName)
					end					
					slotNames[slotID] = "Used"
				end
			end
		end
		return reforgeTable
	end
		
	Reforgerade:RegisterParser("WowReforge", WowReforge)
end