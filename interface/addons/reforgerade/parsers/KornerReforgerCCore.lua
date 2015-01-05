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
	["mst"] = MASTERY,
	["cri"] = CRIT,
	["hst"] = HASTE,
	["hit"] = HIT,
	["exp"] = EXP,
	}
	
	local function ParseKornerReforgerCCore(inputString)
		local reforgeTable = {}
		local reforgeString = inputString .. "\n"
		for w in string.gmatch(reforgeString, "(.-)\n") do
			local first, last, from, to, itemName = string.find(w, "(%a*)%s*->%s*(%a*)%s*%(.*%)%s*(.*)")
			if (from and to and itemName) then
--~ 				Reforgerade:DebugPrint("Reforge |" .. itemName .. "| from |" .. from .. "| to |" .. to .. "|")
				reforgeTable[itemName] = {StatToID[from], StatToID[to]}      
			else
				first, last, itemName = string.find(w, "%-%-%-.*%)%s*(.*)")
				if (first and last and itemName) then
--~ 					Reforgerade:DebugPrint("Dont Reforge " .. itemName)
					reforgeTable[itemName] = {0, 0}
				else
--~ 					Reforgerade:DebugPrint("KornerReforgerCCore: unable to parse line " .. w)
				end
			end
		end

--~ 		for k,v in pairs(reforgeTable) do
--~ 			Reforgerade:DebugPrint("reforge " .. k .. " from " .. v[1] .. " to " .. v[2])
--~ 		end
		return reforgeTable
	end
		
	Reforgerade:RegisterParser("KornerReforgerCCore", ParseKornerReforgerCCore)
end