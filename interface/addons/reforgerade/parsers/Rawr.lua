do
	local RfInfo = LibStub("LibReforgingInfo-1.0")
	local function RawrReforge(inputString)
		local reforgeTable = {}
		local reforgeString = inputString .. "\n"
		local beginParsing = false
		for w in string.gmatch(reforgeString, "(.-)\n") do --for each line in the input text
			if string.find(w, "character = {") then --seek to the section that contains current data
				beginParsing = true
			end
			if beginParsing then
				local itemName = nil
				--item:itemId:enchantId:jewelId1:jewelId2:jewelId3:jewelId4:suffixId:uniqueId:linkLevel:reforgeId
				local first, last, slot, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, linkLevel, reforgeId = string.find(w, "slot = (%d*), item = \"item:([-%d]*):([-%d]*):([-%d]*):([-%d]*):([-%d]*):([-%d]*):([-%d]*):([-%d]*):([-%d]*):([-%d]*)\",")
				if slot and tonumber(slot)~= 4 and itemId and reforgeId then
					if tonumber(suffixId) > 0 then --This is a temporary fix,  Rawr is exporting suffixIds as positive when 
						suffixId = suffixId*-1  --they should be negative.  This will cause a problem with suffixIds that really are positive.
					end  --But the only items should be thos with pre 2.0 prefixes
					tempLink = "\124cffa335ee\124Hitem:"
						.. itemId .. ":" .. enchantId .. ":" .. jewelId1 .. ":" 
						.. jewelId2 .. ":" .. jewelId3 .. ":" .. jewelId4 .. ":" 
						.. suffixId .. ":" .. uniqueId .. ":" .. linkLevel .. ":" 
						.. reforgeId
						.. "\124h[Some Item]\124h\124r"
					itemName, itemLink = GetItemInfo(tempLink) 
					if itemName and itemLink then
						local from, to = RfInfo:GetReforgedStatIDs(reforgeId)
						if not from then from = 0 end
						if not to then to = 0 end
						if reforgeTable[itemName] then --check for duplicate item names
							reforgeTable[itemName][3] = from
							reforgeTable[itemName][4] = to
						else
							reforgeTable[itemName] = {from, to}
						end
					end
				end
			end
			if string.find(w, "loaded = {") then --stop when we get to the next section
				return reforgeTable
			end
--~ 			reforgeTable[itemName] = {StatToID[from], StatToID[to]}	
		end
		return reforgeTable
	end
		
	Reforgerade:RegisterParser("RawrReforge", RawrReforge)
end