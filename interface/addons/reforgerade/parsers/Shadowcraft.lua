do
	--Stole from LibReforge
	local HIT = 4
	local CRIT = 5
	local HASTE = 6
	local EXP = 7
	local MASTERY = 8
	
	local StatToID = {
	["Mastery"] = MASTERY,
	["Crit"] = CRIT,
	["Haste"] = HASTE,
	["Hit"] = HIT,
	["Expertise"] = EXP,
	}
	
	local function ParseShadowcraftReforges(inputString)
		local reforgeTable = {}
		local reforgeString = inputString .. "\n"
		for line in string.gmatch(reforgeString, "(.-)\n") do
			local found, _, itemName, from, to = string.find(line, "Reforged ([%a%s%p]+) to %-%d+ (%w+) Rating / %+%d+ (%w+) Rating")
			if from and to and itemName then
--~ 				Reforgerade:DebugPrint("Reforge \"" .. itemName .. "\" from -" .. from .. "- to -" .. to .. "\"")
				if reforgeTable[itemName] then --Reforging information already in table meas a duplicate item name
					reforgeTable[itemName][3] = StatToID[from]
					reforgeTable[itemName][4] = StatToID[to]
				else
					reforgeTable[itemName] = {StatToID[from], StatToID[to]}      
				end
			else
				local found, _, itemName, from, to = string.find(line, "Reforging ([%a%s%p]+) to %-%d+ (%w+) Rating / %+%d+ (%w+) Rating")
				if from and to and itemName then
					if reforgeTable[itemName] then --Reforging information already in table meas a duplicate item name
						reforgeTable[itemName][3] = StatToID[from]
						reforgeTable[itemName][4] = StatToID[to]
					else
						reforgeTable[itemName] = {StatToID[from], StatToID[to]}      
					end
				else
					found, _, itemName = string.find(line, "Removed reforge from ([%a%s%p]+)")
					if found and itemName then
	--~ 					Reforgerade:DebugPrint("Dont Reforge " .. itemName)
						if reforgeTable[itemName] then --Reforging information already in table meas a duplicate item name
							reforgeTable[itemName][3] = 0
							reforgeTable[itemName][4] = 0
						else
							reforgeTable[itemName] = {0, 0}
						end
					else
						found, _, itemName = string.find(line, "Removing reforge on ([%a%s%p]+)")
						if found and itemName then
		--~ 					Reforgerade:DebugPrint("Dont Reforge " .. itemName)
							if reforgeTable[itemName] then --Reforging information already in table meas a duplicate item name
								reforgeTable[itemName][3] = 0
								reforgeTable[itemName][4] = 0
							else
								reforgeTable[itemName] = {0, 0}
							end
						else
							Reforgerade:DebugPrint("unable to parse line " .. line)
						end
					end
				end
			end
		end

--~ 		for k,v in pairs(reforgeTable) do
--~ 			Reforgerade:DebugPrint("reforge " .. k .. " from " .. v[1] .. " to " .. v[2])
--~ 		end
		return reforgeTable
	end
		
	Reforgerade:RegisterParser("Shadowcraft", ParseShadowcraftReforges)
end

--[[
Removed reforge from Belt of Nefarious Whispers
Reforged Fluid Death to -128 Hit Rating / +128 Mastery Rating
Reforged Poison Protocol Pauldrons to -59 Crit Rating / +59 Haste Rating
Reforged Parasitic Bands to -50 Crit Rating / +50 Hit Rating
Reforged Storm Rider's Boots to -59 Haste Rating / +59 Hit Rating
Reforged Necklace of Strife to -50 Haste Rating / +50 Hit Rating
Reforged Wind Dancer's Gloves to -67 Haste Rating / +67 Mastery Rating
Reforged Wind Dancer's Legguards to -75 Crit Rating / +75 Hit Rating
Reforged Wind Dancer's Tunic to -75 Expertise Rating / +75 Mastery Rating
Reforged Signet of the Elder Council to -50 Haste Rating / +50 Hit Rating
Reforged Dory's Finery to -50 Crit Rating / +50 Mastery Rating
Reforged Gilnean Ring of Ruination to -55 Haste Rating / +55 Mastery Rating
Reforged Scaleslicer to -38 Expertise Rating / +38 Mastery Rating
Reforged Dragonwreck Throwing Axe to -28 Haste Rating / +28 Hit Rating
]]