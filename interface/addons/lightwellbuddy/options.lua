_G["LWB"] = _G["LWB"] or {}
local LWB = _G["LWB"]
local L = LibStub("AceLocale-3.0"):GetLocale("LWB")
local LSM = LibStub("LibSharedMedia-3.0")
local enabled = function() return not LWB:IsEnabled() end


local channels = {}

local channelsWithWisper = {}

LWB.channels = {}

--need to adapt this to use the name and name only, and to retrieve the number as necessary to send a message. Reason for, is the number can change while the name stays the same particularly as people log into different toons.

local function buildChannelList(...)
   local serverChannels = {EnumerateServerChannels()}
   local tbl = {}
   for i = 1, select("#", ...), 2 do
     local id, name = select(i, ...)
     if tContains(serverChannels,name) then 
     else   
       tbl[""..id..""] = name
     end
   end
   return tbl
end



function LWB:updateChannelsList()
	local tbl = {	["SMART"] = L["Smart"],
			["SAY"] = L["Say"],
			["LIGHTWELLSAY"] = L["Say As Lightwell"],
			["EMOTE"] = L["Emote"],
			["LIGHTWELLEMOTE"] = L["Emote As Lightwell"],
			["YELL"] = L["Yell"],
			["PARTY"] = L["Party"],
			["INSTANCE_CHAT"] = L["Instance"],
			["GUILD"] = L["Guild"],
			["OFFICER"] = L["Officer"],
			["RAID"] = L["Raid"],
			["RAID_WARNING"] = L["Raid Warning"],
			["BATTLEGROUND"] = L["Battleground"],
			["NONE"] = L["None"],
	}

	LWB.channels = buildChannelList(GetChannelList())	
	for k,v in pairs(LWB.channels) do
		tbl[v] = v
	end

	channels =  tbl
	return tbl

end


function LWB:updateChannelsWithWhispersList()
	local tbl = {	["SMART"] = L["Smart"],
			["SAY"] = L["Say"],
			["LIGHTWELLSAY"] = L["Say As Lightwell"],
			["EMOTE"] = L["Emote"],
			["LIGHTWELLEMOTE"] = L["Emote As Lightwell"],
			["YELL"] = L["Yell"],
			["PARTY"] = L["Party"],
			["INSTANCE_CHAT"] = L["Instance"],
			["GUILD"] = L["Guild"],
			["OFFICER"] = L["Officer"],
			["RAID"] = L["Raid"],
			["RAID_WARNING"] = L["Raid Warning"],
			["BATTLEGROUND"] = L["Battleground"],
			["WHISPER"] = L["Whisper"],
			["NONE"] = L["None"],
	}

	LWB.channels = buildChannelList(GetChannelList())	
	for k,v in pairs(LWB.channels) do
		tbl[v] = v
	end

	channelsWithWisper =  tbl
	return tbl

end




LWB.optionsTable = {
	name = "",
	type = "group",
	args = {
		general = {
			name = "General",
			type = "group",
			childGroups = "tab",
			args = {
				enable = {													name = L["Enabled"],												type = 'toggle',												order = 1,												desc = L["Enabled Desc"],												disabled = function() return select(2, UnitClass("player")) ~= "PRIEST" end,										set = function(info, val) LWB.db.profile.enabled = val; if val then LWB:Enable(); else LWB:Disable(); end end,												get = function(info) return LWB:IsEnabled(); end,											},
				alert = {													name = L["Alert to Self"],												type = 'toggle',												order = 2,												desc = L["Alert to Self Desc"],												set = function(info,val) LWB.db.profile.alert = val; end,												get = function(info) return LWB.db.profile.alert end,											},
				modifyProfiles = {
					name = L["Modify Profiles"],
					order = 3,
					type = "execute",
					func = function() InterfaceOptionsFrame_OpenToCategory(LWB.optionFrames.profiles); end,
				},
				messagingOptions = {															name = L["Phrases"],														type = "group",														order = 1,														childGroups = "tab",														args = {															enable = {															name = L["Enabled"],														type = 'toggle',														order = 1,														set = function(info, val) LWB.db.profile.messagingEnabled = val; end,														get = function(info) return LWB.db.profile.messagingEnabled; end,													},																					talkToStrangers = {															name = L["Talk to Strangers"],														type = 'toggle',														order = 3,														desc = L["Talk to Strangers Desc"],														set = function(info,val) LWB.db.profile.talkToStrangers = val; end,														get = function(info) return LWB.db.profile.talkToStrangers end,													},														talkOutOfCombat = {															name = L["Out of Combat"],														type = 'toggle',														order = 4,														desc = L["Out of Combat Desc"],														set = function(info,val) LWB.db.profile.talkOutOfCombat = val; end,														get = function(info) return LWB.db.profile.talkOutOfCombat end,													},														msgOnLastUse = {															name = L["Message on Last Use"],														type = 'toggle',														order = 5,														desc = L["Message on Last Use Desc"],														set = function(info,val) LWB.db.profile.msgOnLastUse = val; end,														get = function(info) return LWB.db.profile.msgOnLastUse end,													},
						supportLightspring = {															name = L["Support Lightspring"],														type = 'toggle',														order = 6,														desc = L["Support Lightspring Desc"],														set = function(info,val) LWB.db.profile.lightspringSupport = val; end,														get = function(info) return LWB.db.profile.lightspringSupport end,													},																											phrases = {															name = L["Phrases"],														order = 12,														type = 'header',													},														description = {															name = L["Placeholder Desc"],														type = "description",														order = 13,													},														summon = {															name = L["Summon"],														type = "group",														order = 14,														args = {															summonChannel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["Summon Channel Desc"],														values = function()
										return channels
									end,														set = function(info,val) LWB.db.profile.summonChannel = val; end,														get = function(info) return LWB.db.profile.summonChannel end,														style = "dropdown",													},														rate = {															name = L["Rate"],														type = "range",														order = 2,														desc = L["Summon Rate Desc"],														set = function(info,val) LWB.db.profile.summonRate = val; end,														get = function(info) return LWB.db.profile.summonRate end,														width = "double",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														summonPhrases = {															name = L["Phrases"],														type = 'input',														order = 3,														desc = L["Summon Phrases Desc"],														set = function(info,val) 															LWB.db.profile.summonPhrases = {strsplit("\n", val)};														LWB:OnProfileChanged() 													end,														get = function(info) return table.concat(LWB.db.profile.summonPhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},														use = {															name = L["General Use"],														type = "group",														desc = L["General Use Desc"],														order = 15,														args = {															channel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["General Use Channel Desc"],														values = function()
										return channelsWithWisper
									end,														set = function(info,val) LWB.db.profile.useChannel = val; end,														get = function(info) return LWB.db.profile.useChannel end,														style = "dropdown",													},														cd = {															name = L["Message Cooldown"],														type = "range",														order = 2,														desc = L["General Use CD Desc"],														set = function(info,val) LWB.db.profile.useCD = val; end,														get = function(info) return LWB.db.profile.useCD end,														width = "normal",														min = 0,														max = 60,														softMin = 0,														softMax = 60,														step = 1,														bigStep = 1,														isPercent = false,													},														rate = {															name = L["Rate"],														type = "range",														order = 3,														desc = L["General Use Rate Desc"],														set = function(info,val) LWB.db.profile.useRate = val; end,														get = function(info) return LWB.db.profile.useRate end,														width = "normal",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 4,														desc = L["General Use Phrases Desc"],														set = function(info,val) 															LWB.db.profile.usePhrases = {strsplit("\n", val)}; 														LWB:OnProfileChanged() 													end,														get = function(info) return table.concat(LWB.db.profile.usePhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},														personal = {															name = L["Personalized Use"],														desc = L["Personalized Use Desc"],														type = "group",														order = 16,														args = {															newlist = {															name = L["New List"],														type = 'input',														order = 1,														desc = L["New List Desc"],														set = 	function(info,val) 															LWB:ADDLIST(val)													end,													get = function(info)  end,														width = 'double',														multiline = false,													},														removelist = {															name = L["Delete List"],														type = 'select',														style = 'dropdown',														order = 2,														confirm = true,														values = function() 															local list = {}														for k,v in pairs(LWB.db.profile.personalLists.name) 															do list[k] = v end														return list													end,													desc = L["Delete List Desc"],														get = function(info)															end,													set = function(info, key)																for k,v in pairs(LWB.db.profile.personalLists) do															LWB.db.profile.personalLists[k][key] = nil													end														local nameCount = 0														for k,v in pairs(LWB.db.profile.personalLists.name) do 															nameCount = nameCount + 1													end														if not(LWB.db.profile.personalLists.name) or nameCount == 0 then															LWB:ADDLIST(L["Default"])													end														if selectedPersonalList == key then 															local count = 1														for k,v in pairs(LWB.db.profile.personalLists.name) do															if count == 1 then 															selectedPersonalList = k														count = count + 1													end													end													end												end,													},														selectlist = {															name = L["Select A List"],														type = 'select',														style = 'dropdown',														order = 3,														values = function() 															local list = {}														for k,v in pairs(LWB.db.profile.personalLists.name) do list[k] = v end														return list														end,													desc = L["Select A List Desc"],														get = function(info)															if selectedPersonalList then return selectedPersonalList end														local count = 1														for k,v in pairs(LWB.db.profile.personalLists.name) do															if count == 1 then 															count = count + 1														selectedPersonalList = k													end													end														return selectedPersonalList													end,														set = function(info, key)															selectedPersonalList = key													end,													},														addPlayer = {															name = L["Add Player"],														type = 'input',														order = 4,														desc = L["Add Player Desc"],														set = 	function(info,val) 															LWB:AddPlayerToPersonalList(selectedPersonalList,val)													end,													get = function(info)  end,														width = 'normal',														multiline = false,													},														removePlayer = {															name = L["Remove Player"],														type = 'select',														style = 'dropdown',														order = 5,														values = function() 															return LWB.db.profile.personalLists.persons[selectedPersonalList]														end,													desc = L["Remove Player Desc"],														get = function(info)															end,													set = function(info, key)															tremove(LWB.db.profile.personalLists.persons[selectedPersonalList],key)														end,												},														channel = {															name = L["Channel"],														type = 'select',														order = 6,														desc = L["Personal List Channel Desc"],														values = function()
										return channelsWithWisper
									end,														set = function(info,val) LWB.db.profile.personalLists.channel[selectedPersonalList] = val; end,														get = function(info) return LWB.db.profile.personalLists.channel[selectedPersonalList] end,														style = "dropdown",													},														cd = {															name = L["Message Cooldown"],														type = "range",														order = 7,														desc = L["Personal List CD Desc"],														set = function(info,val) LWB.db.profile.personalLists.cd[selectedPersonalList] = val; end,														get = function(info) return LWB.db.profile.personalLists.cd[selectedPersonalList] end,														width = "normal",														min = 0,														max = 60,														softMin = 0,														softMax = 60,														step = 1,														bigStep = 1,														isPercent = false,													},														rate = {															name = L["Rate"],														type = "range",														order = 8,														desc = L["Personal List Rate Desc"],														set = function(info,val) LWB.db.profile.personalLists.rate[selectedPersonalList] = val; end,														get = function(info) return LWB.db.profile.personalLists.rate[selectedPersonalList] end,														width = "normal",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 9,														desc = L["Personal List Phrases Desc"],														set = function(info,val) LWB.db.profile.personalLists.phrases[selectedPersonalList] = {strsplit("\n", val)}; end,														get = function(info) return table.concat(LWB.db.profile.personalLists.phrases[selectedPersonalList], "\n"); end,														width = 'full',														multiline = 5,													},													},													},														waste = {															name = L["Waste"],														type = "group",														order = 17,														args = {															channel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["Waste Channel Desc"],														values = function()
										return channelsWithWisper
									end,														set = function(info,val) LWB.db.profile.wasteChannel = val; end,														get = function(info) return LWB.db.profile.wasteChannel end,														style = "dropdown",													},														cutOff = {															name = L["Waste Cut Off"],														type = "range",														order = 2,														desc = L["Waste Cut Off Desc"],														set = function(info,val) LWB.db.profile.wasteCutOff = val; end,														get = function(info) return LWB.db.profile.wasteCutOff end,														width = "normal",														min = 0,														max = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														rate = {															name = L["Rate"],														type = "range",														order = 3,														desc = L["Waste Rate Desc"],														set = function(info,val) LWB.db.profile.wasteRate = val; end,														get = function(info) return LWB.db.profile.wasteRate end,														width = "normal",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 4,														desc = L["Waste Phrases Desc"],														set = function(info,val) 															LWB.db.profile.wastePhrases = {strsplit("\n", val)};														LWB:OnProfileChanged() 												end,														get = function(info) return table.concat(LWB.db.profile.wastePhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},														empty = {															name = L["Empty"],														type = "group",														order = 18,														args = {															channel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["Empty Channel Desc"],														values = function()
										return channels
									end,														set = function(info,val) LWB.db.profile.emptyChannel = val; end,														get = function(info) return LWB.db.profile.emptyChannel end,														style = "dropdown",													},														rate = {															name = L["Rate"],														type = "range",														order = 2,														desc = L["Empty Rate Desc"],														set = function(info,val) LWB.db.profile.emptyRate = val; end,														get = function(info) return LWB.db.profile.emptyRate end,														width = "double",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 3,														desc = L["Empty Phrases Desc"],														set = function(info,val) 															LWB.db.profile.emptyPhrases = {strsplit("\n", val)}; 														LWB:OnProfileChanged() 												end,														get = function(info) return table.concat(LWB.db.profile.emptyPhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},														expire = {															name = L["Expire"],														type = "group",														order = 19,														args = {															channel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["Expire Channel Desc"],														values = function()
										return channels
									end,														set = function(info,val) LWB.db.profile.expireChannel = val; end,														get = function(info) return LWB.db.profile.expireChannel end,														style = "dropdown",													},														rate = {															name = L["Rate"],														type = "range",														order = 2,														desc = L["Empty Rate Desc"],														set = function(info,val) LWB.db.profile.expireRate = val; end,														get = function(info) return LWB.db.profile.expireRate end,														width = "double",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 3,														desc = L["Empty Phrases Desc"],														set = function(info,val) 															LWB.db.profile.expirePhrases = {strsplit("\n", val)}; 														LWB:OnProfileChanged() 													end,														get = function(info) return table.concat(LWB.db.profile.expirePhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},														disappear = {															name = L["Disappear"],														type = "group",														order = 20,														args = {															channel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["Disappear Channel Desc"],														values = function()
										return channels
									end,														set = function(info,val) LWB.db.profile.disappearChannel = val; end,														get = function(info) return LWB.db.profile.disappearChannel end,														style = "dropdown",													},														rate = {															name = L["Rate"],														type = "range",														order = 2,														desc = L["Disappear Rate Desc"],														set = function(info,val) LWB.db.profile.disappearRate = val; end,														get = function(info) return LWB.db.profile.disappearRate end,														width = "double",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 3,														desc = L["Disappear Phrases Desc"],														set = function(info,val) 															LWB.db.profile.disappearPhrases = {strsplit("\n", val)};														LWB:OnProfileChanged() 												end,														get = function(info) return table.concat(LWB.db.profile.disappearPhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},														multiconsumption = {															name = L["Multiconsumption"],														type = "group",														order = 21,														desc = L["Multiconsumption Desc"],														args = {															channel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["Multiconsumption Channel Desc"],														values = function()
										return channelsWithWisper
									end,														set = function(info,val) LWB.db.profile.multiconsumptionChannel = val; end,														get = function(info) return LWB.db.profile.multiconsumptionChannel end,														style = "dropdown",													},														rate = {															name = L["Rate"],														type = "range",														order = 2,														desc = L["Multiconsumption Rate Desc"],														set = function(info,val) LWB.db.profile.multiconsumptionRate = val; end,														get = function(info) return LWB.db.profile.multiconsumptionRate end,														width = "double",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 3,														desc = L["Multiconsumption Phrases Desc"],														set = function(info,val) 															LWB.db.profile.multiconsumptionPhrases = {strsplit("\n", val)}; 														LWB:OnProfileChanged() 												end,														get = function(info) return table.concat(LWB.db.profile.multiconsumptionPhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},														idle = {															name = L["Idle"],														type = "group",														order = 22,														desc = L["Idle Desc"],														args = {															channel = {															name = L["Channel"],														type = 'select',														order = 1,														desc = L["Idle Channel Desc"],														values = function()
										return channels
									end,														set = function(info,val) LWB.db.profile.idleChannel = val; end,														get = function(info) return LWB.db.profile.idleChannel end,														style = "dropdown",													},														maxTime = {															name = L["Max Idle Time"],														type = "range",														order = 2,														desc = L["Idle Max Time Desc"],														set = function(info,val) LWB.db.profile.idleMaxTime = val; end,														get = function(info) return LWB.db.profile.idleMaxTime end,														width = "normal",														min = 30,														max = 180,														softMin = 30,														softMax = 180,														step = 1,														bigStep = 1,														isPercent = false,													},														rate = {															name = L["Rate"],														type = "range",														order = 3,														desc = L["Idle Rate Desc"],														set = function(info,val) LWB.db.profile.idleRate = val; end,														get = function(info) return LWB.db.profile.idleRate end,														width = "normal",														min = 0,														max = 1,														softMin = 0,														softMax = 1,														step = 0.01,														bigStep = 0.05,														isPercent = true,													},														phrases = {															name = L["Phrases"],														type = 'input',														order = 4,														desc = L["idle Phrases Desc"],														set = function(info,val) 															LWB.db.profile.idlePhrases = {strsplit("\n", val)}; 														LWB:OnProfileChanged() 												end,														get = function(info) return table.concat(LWB.db.profile.idlePhrases, "\n"); end,														width = 'full',														multiline = 13,													},													},													},													},													},														blacklistingOptions = {															name = L["Blacklist"],														type = "group",														order = 3,														childGroups = "tab",														args = {
						description = {															name = L["Blacklist Desc"],														type = "description",														order = 2,													},	
						blackList = {															name = L["Blacklist"],														type = 'input',														order = 3,																					set = 	function(info,val) 															val = LWB:FormatName(val)														if LWB:IsBlacklisted(val) then															local m = gsub(L["Already Blacklisted"],"%[PlayerName%]",val)														LWB:Print(m)													--add players starting at the second key. First is reserved for a drop-box description.														else 															local m = gsub(L["Added to Blacklist"],"%[PlayerName%]",val)														tinsert(LWB.db.profile.blackList,2,val) 														LWB:Print(m)													end													end,													get = function(info)  end,														width = 'double',														multiline = false,													},														unblacklist = {															name = L["Unblacklist"],														type = 'select',														style = 'dropdown',														order = 4,														values = function() 															if LWB.db.profile.blackList[1] == L["Un-blacklist player"] then														else tinsert(LWB.db.profile.blackList,1,L["Un-blacklist player"])														end														return LWB.db.profile.blackList 														end,													desc = L["Unblacklist Desc"],														get = function(info)															--Make sure "un-blacklist player" is added as the first option in the blacklist for those who installed prior to version v1.04														if LWB.db.profile.blackList[1] == L["Un-blacklist player"] then														else tinsert(LWB.db.profile.blackList,1,L["Un-blacklist player"])														end														return 1														end,													set = function(info, key)															local m = gsub(L["Player Unblacklisted"],"%[PlayerName%]",LWB.db.profile.blackList[key])														LWB:Print(m)														tremove(LWB.db.profile.blackList,key)														end,												},														blacklistingHeader = {															name = L["Blacklist"],														order = 1,														type = 'header',													},
					},													},														counterOptions = {															name = L["Counter Options"],														type = "group",														order = 2,														childGroups = "tab",														args = {
						counterEnable = {															name = L["Enable Counter"],														type = 'toggle',														order = 1,														set = function(info,val) LWB.db.profile.counterEnable = val; LWB.counter.postChange() end,														get = function(info) return LWB.db.profile.counterEnable end,													},
						counterLockPosition = {														name = L["Lock Counter Position"],														type = 'toggle',														order = 2,														set = function(info,val) LWB.db.profile.counterLockPosition = val; LWB.counter.postChange() end,													get = function(info) return LWB.db.profile.counterLockPosition end,													},
						beginPulsing = {													name = L["Begin Pulsing"],												type = "range",												order = 3,																set = function(info,val) LWB.db.profile.counterBeginPulsing = val; end,												get = function(info) return LWB.db.profile.counterBeginPulsing end,												width = "normal",												min = 0,												max = 180,												softMin = 0,												softMax = 180,												step = .5,												bigStep = .5,												isPercent = false,											},
						counterBarColor = {															name = L["Counter Bar Color"],														type = 'color',														order = 4,	
							hasAlpha = false,												set = function(_,r,g,b,a)
								LWB.db.profile.counterBarR = r
								LWB.db.profile.counterBarG = g
								LWB.db.profile.counterBarB = b
								LightwellCounterFormBar:SetStatusBarColor(r, g, b)

							end,														get = function(info) return LWB.db.profile.counterBarR, LWB.db.profile.counterBarG, LWB.db.profile.counterBarB end,													},
						counterBarTexture = {
      							order = 5,
      							name = L["Counter Bar Texture"],
      							type = "select",
      							dialogControl = "LSM30_Statusbar",
      							values = LSM:HashTable( LSM.MediaType.STATUSBAR ),
      							get = function( info )
        							return LWB.db.profile.counterBarTexture
      							end,
      							set = function( info, v )
								LWB.db.profile.counterBarTexture = v
								LightwellCounterFormBar:SetStatusBarTexture(LSM:Fetch("statusbar", LWB.db.profile.counterBarTexture))	
      							end,
    						},
						counterSkin = {
      							order = 5,
      							name = L["Counter Skin"],
      							type = "select",
      							dialogControl = "LSM30_Background",
      							values = LSM:HashTable( LSM.MediaType.BACKGROUND ),
      							get = function( info )
        							return LWB.db.profile.counterSkin
      							end,
      							set = function( info, v )
								
								LWB.db.profile.counterSkin = v
								LightwellCounterForm:SetBackdrop({ 
									bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
									edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
									insets = { 	left = LWB.db.profile.counterSkinInset, 
											right = LWB.db.profile.counterSkinInset, 
											top = LWB.db.profile.counterSkinInset, 
											bottom = LWB.db.profile.counterSkinInset, }
								})
      							end,
    						},
						counterFont = {
      							order = 5,
      							name = L["Counter Font"],
      							type = "select",
      							dialogControl = "LSM30_Font",
      							values = LSM:HashTable( LSM.MediaType.FONT ),
      							get = function( info )
        							return LWB.db.profile.counterFont
      							end,
      							set = function( info, v )
								LWB.db.profile.counterFont = v
								
								LightwellCounterFormChargesLabel:SetFont(LSM:Fetch("font", LWB.db.profile.counterFont),12)	
      							end,
    						},
						counterBorder = {
      							order = 5,
      							name = L["Counter Border"],
      							type = "select",
      							dialogControl = "LSM30_Border",
      							values = LSM:HashTable( LSM.MediaType.BORDER ),
      							get = function( info )
        							return LWB.db.profile.counterBorder
      							end,
      							set = function( info, v )
								LWB.db.profile.counterBorder = v
								
								LightwellCounterForm:SetBackdrop({ 
									bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
									edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
									insets = { 	left = LWB.db.profile.counterSkinInset, 
											right = LWB.db.profile.counterSkinInset, 
											top = LWB.db.profile.counterSkinInset, 
											bottom = LWB.db.profile.counterSkinInset, }
								})	
      							end,
    						},
						counterBorderSize = {
      							order = 5,
      							name = L["Counter Border Size"],
      							type = "select",
      							values = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,},
      							get = function( info )
        							return LWB.db.profile.counterBorderSize
      							end,
      							set = function( info, v )
								LWB.db.profile.counterBorderSize = v
								
								LightwellCounterForm:SetBackdrop({ 
									bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
									edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
									insets = { 	left = LWB.db.profile.counterSkinInset, 
											right = LWB.db.profile.counterSkinInset, 
											top = LWB.db.profile.counterSkinInset, 
											bottom = LWB.db.profile.counterSkinInset, }
								})	
      							end,
    						},
						counterSkinInset = {
      							order = 5,
      							name = L["Counter Skin Inset"],
      							type = "select",
      							values = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,},
      							get = function( info )
        							return LWB.db.profile.counterSkinInset
      							end,
      							set = function( info, v )
								LWB.db.profile.counterSkinInset = v
								
								LightwellCounterForm:SetBackdrop({ 
									bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
									edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
									insets = { 	left = LWB.db.profile.counterSkinInset, 
											right = LWB.db.profile.counterSkinInset, 
											top = LWB.db.profile.counterSkinInset, 
											bottom = LWB.db.profile.counterSkinInset, }
								})	
      							end,
    						},
						hideCounterHeader = {															name = L["Hide Counter When:"],														order = 6,														type = 'description',													},													counterHideCombat = {															name = L["Out of Combat"],														type = 'toggle',														order = 7,														set = function(info,val) LWB.db.profile.counterHideCombat = val; LWB.counter.postChange() end,														get = function(info) return LWB.db.profile.counterHideCombat end,													},														counterHideDown = {															name = L["Hide Counter When Not Summoned"],														type = 'toggle',														order = 8,														set = function(info,val) LWB.db.profile.counterHideDown = val; LWB.counter.postChange() end,														get = function(info) return LWB.db.profile.counterHideDown end,													},								
					},													},													},													},													},													
}




local selectedPersonalList = nil

function LWB:PlayerInPersonalList(name)
--detect if player already exists in a personal list
	local currentList = nil
	for k,v in pairs (LWB.db.profile.personalLists.persons) do
		local index = 1;
       		while LWB.db.profile.personalLists.persons[k][index] do
               		if ( strlower(name) == strlower(LWB.db.profile.personalLists.persons[k][index] ) ) then
                       		return k,index;
              		end
               		index = index + 1;
      		end
	end
	return nil
end


function LWB:FormatName(name)
--Attempt to format a user-entered name of a player, properly capitalizing it, removing extra spaces, and adding a hyphen between the player name and server. Must be perfect in order for it to properly send whispers to players on personal use lists. Must also be sensitive to Non-enUS locales.
	local c = 1
	local f = ""
	for w in string.gmatch(name, "%S+") do
		if c==1 then
			f = LWB:Capitalize(w,0)
		else 
			f = f .. " " .. LWB:Capitalize(w,0)
		end
		c = c + 1
	end
	c = 1
	for w in string.gmatch(f, "[^%-]+") do
		if c==1 then
			g = LWB:Capitalize(w,1)
		else 
			g = g .. "-" .. LWB:Capitalize(w,1)
		end
		c = c + 1
	end
	f = g

	f = gsub(f," %-","%-")
	f = gsub(f,"%- ","%-")


	local hyph = strfind(f,"%-")
	local space = strfind(f," ")


	if not hyph and not space then
		return f
	elseif not hyph then
		local m = gsub(f," ","%-",1)
		return m
	elseif not space then
		return f
	elseif hyph > space then
		local m = gsub(f," ","%-",1)
		return m
	elseif space > hyph then
		return f
	end
end

function LWB:Capitalize(w,m)
	--m=0, lower case on all non first letters. = 1, ignore all non-first letters
	local charTest = strmatch(strsub(w,1,1),"%a")
	if w and m == 0 then 
		if charTest == nil then
			w = strlower(w)
		else w = strupper(strsub(w,1,1))..strlower(strsub(w,2))
		end
	end
	if w and m == 1 then 
		if charTest == nil then
			w = w
		else w = strupper(strsub(w,1,1))..strsub(w,2)
		end
	end
	return w
end


function LWB:AddPlayerToPersonalList(list,name)
	name = LWB:FormatName(name)
	local currentList, currentListValue = LWB:PlayerInPersonalList(name)

	if currentList then
		local m = gsub(L["Already in List"],"%[currentList%]",currentList)
		LWB:Print(m)
		return nil
	end

	tinsert(LWB.db.profile.personalLists.persons[list],1,name)
end




function LWB:ADDLIST(name)
	local d = L["Default"]
	for k,v in pairs(LWB.dbDefaults.profile.personalLists) do
							
		if k == "name" then
			LWB.db.profile.personalLists[k][name] = name
		
		elseif type(LWB.dbDefaults.profile.personalLists[k][d]) =="table" then
			
			LWB.db.profile.personalLists[k][name] = LWB:LWBtablecopy(LWB.dbDefaults.profile.personalLists[k][d])
		else	LWB.db.profile.personalLists[k][name] = LWB.dbDefaults.profile.personalLists[k][d]
		end

	end

end

	
function LWB.MediaUpdate(event, _, mediatype, key)
    -- do whatever needs to be done to repaint / refont
	if mediatype == "sound" then
	elseif mediatype == "border" then
		if key == LWB.db.profile.counterBorder then
			LightwellCounterForm:SetBackdrop({ 
				bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
				edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
				insets = { 	left = LWB.db.profile.counterSkinInset, 
						right = LWB.db.profile.counterSkinInset, 
						top = LWB.db.profile.counterSkinInset, 
						bottom = LWB.db.profile.counterSkinInset, }
			})
		end
	elseif mediatype == "background" then
		if key == LWB.db.profile.counterSkin then
			LightwellCounterForm:SetBackdrop({ 
				bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
				edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
				insets = { 	left = LWB.db.profile.counterSkinInset, 
						right = LWB.db.profile.counterSkinInset, 
						top = LWB.db.profile.counterSkinInset, 
						bottom = LWB.db.profile.counterSkinInset, }
			})
		end
	elseif mediatype == "font" then
		if key == LWB.db.profile.counterFont then
			LightwellCounterFormChargesLabel:SetFont(LSM:Fetch("font", LWB.db.profile.counterFont),12)

		end
	elseif mediatype == "statusbar" then
		if key == LWB.db.profile.counterBarTexture then
			LightwellCounterFormBar:SetStatusBarTexture(LSM:Fetch("statusbar", LWB.db.profile.counterBarTexture))

		end
	end

--Implement Changes
	LightwellCounterFormBar:SetStatusBarColor(LWB.db.profile.counterBarR, LWB.db.profile.counterBarG, LWB.db.profile.counterBarB)
	LightwellCounterForm:SetBackdrop({ 
				bgFile = LSM:Fetch("background", LWB.db.profile.counterSkin), 
				edgeFile = LSM:Fetch("border", LWB.db.profile.counterBorder), tile = false, tileSize = 0, edgeSize = LWB.db.profile.counterBorderSize, 
				insets = { 	left = LWB.db.profile.counterSkinInset, 
						right = LWB.db.profile.counterSkinInset, 
						top = LWB.db.profile.counterSkinInset, 
						bottom = LWB.db.profile.counterSkinInset, }
			})
	LightwellCounterFormChargesLabel:SetFont(LSM:Fetch("font", LWB.db.profile.counterFont),12)
	LightwellCounterFormBar:SetStatusBarTexture(LSM:Fetch("statusbar", LWB.db.profile.counterBarTexture))

end


