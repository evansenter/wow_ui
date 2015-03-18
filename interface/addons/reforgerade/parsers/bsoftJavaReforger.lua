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
	["Mastery"] = MASTERY,
	["Crit"] = CRIT,
	["Haste"] = HASTE,
	["Hit"] = HIT,
	["Expertise"] = EXP,
	}
	
	local function ParsebsoftReforge(inputString)
		local reforgeTable = {}
		local reforgeString = inputString .. "\n"
		local unforgedSection = false
		for w in string.gmatch(reforgeString, "(.-)\n") do
			local first, last, itemName, from, to = string.find(w, "%s*%[\"([%a*%s*%p*]*)\"%s*%d*%s*(%a*)%s*to%s*(%a*)")
			if (from and to and itemName) then
				Reforgerade:DebugPrint("Reforge |" .. itemName .. "| from |" .. from .. "| to |" .. to .. "|")
				reforgeTable[itemName] = {StatToID[from], StatToID[to]}      
			else
				first, last, itemName = string.find(w, "%-%-%-.*:%s*(.*)")
				if (first and last and itemName) then
--~ 					Reforgerade:DebugPrint("Dont Reforge " .. itemName)
					reforgeTable[itemName] = {0, 0}
				else
--~ 					Reforgerade:DebugPrint("unable to parse line " .. w)
				end
			end
			if string.find(w, "Stats with no reforgings") then
				Reforgerade:DebugPrint("Finished unforge section")
				unforgedSection = false
			end
			if (unforgedSection) then
				local first, last, itemName = string.find(w, "%s*(.*)%s*")
				reforgeTable[itemName] = {0, 0}
				Reforgerade:DebugPrint("Unforge " .. itemName)
			end
			if string.find(w, "Should not be reforged:") then
				unforgedSection = true
				Reforgerade:DebugPrint("Starting unforge section")
			end
		end

--~ 		for k,v in pairs(reforgeTable) do
--~ 			Reforgerade:DebugPrint("reforge " .. k .. " from " .. v[1] .. " to " .. v[2])
--~ 		end
		return reforgeTable
	end
		
	Reforgerade:RegisterParser("bsoft java reforger", ParsebsoftReforge)
end