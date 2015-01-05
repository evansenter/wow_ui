--  Title: MountHelper
--  Author: Metsavend of Quel'Thalas EU

local format=string.format;

local NAME = 'MountHelper';
MountHelper = LibStub('AceAddon-3.0'):NewAddon(NAME, 'AceEvent-3.0', 'AceConsole-3.0');
local L = LibStub('AceLocale-3.0'):GetLocale(NAME);

-- shorthand reference to the addon object.
local MH = MountHelper
local mountDb = MountHelperDB

local REALM_NAME = nil
local CHARACTER_NAME = nil
local PET_TYPE_MOUNT = 'MOUNT'
local PET_TYPE_CRITTER = 'CRITTER'

local function mapToString(map)
	local res = ""
	for key,val in pairs(map) do
		if(type(val) == 'table') then
			res = res .. key .. ' = (' .. mapToString(val) .. '), '; 
		else 
			if (type(val) == 'function') then
				res = res .. key .. ' = function, '
			else 
				if (type(val) ~= 'string') then
					res = res .. key .. ' = ' .. tostring(val) .. ', '
				else
					res = res .. key .. ' = ' .. val .. ', '
				end
			end
		end
	end
	return res;
end

local function debug(text)
	if(MH.config.debug) then
		print(text)
	end
end



-- Utility functions

local function PlayerHasSpellWithId(spellId) 
	local n,_=GetSpellInfo(spellId)
	local n2,_=GetSpellInfo(n)
	if(n2) then return true; else return false end
end

local function PlayerHasNorthrendFlight()
	return PlayerHasSpellWithId(54197)
end

local function PlayerHasAzerothFlight()
	return PlayerHasSpellWithId(90267)
end

-- Name by idx

local function getCompanionNameByIndex(type, idx)
	local _, name, _, _, _ = GetCompanionInfo(type, idx)
	return name;
end

local function getMountNameByIndex(idx)
	return getCompanionNameByIndex(PET_TYPE_MOUNT, idx)
end

local function getPetNameByIndex(idx)
	return getCompanionNameByIndex(PET_TYPE_CRITTER, idx)
end

-- SpellId by idx

local function getCompantionSpellIdByIdx(type, idx)
	local _, _, spellId, _, _ = GetCompanionInfo(type, idx)
	return spellId;
end

local function getMountSpellIdByIndex(idx)
	return getCompantionSpellIdByIdx(PET_TYPE_MOUNT, idx)
end

local function getPetSpellIdByIndex(idx)
	return getCompantionSpellIdByIdx(PET_TYPE_CRITTER, idx)
end

-- Index by SpellId

local function getCompanionIndexBySpellId(type, spellId)
	local total = GetNumCompanions(type)
	if(total == 0) then 
		return -1
	else 
		for idx=1,total do
			local idx_spellId = getCompantionSpellIdByIdx(type, idx)
			if(idx_spellId==spellId) then
				return idx;			
			end				
		end
	end
	return -1
end


local function getMountIndexBySpellId(spellId)
	return getCompanionIndexBySpellId(PET_TYPE_MOUNT, spellId)
end

local function getPetIndexBySpellId(spellId)
	return getCompanionIndexBySpellId(PET_TYPE_CRITTER, spellId)
end

-- Druid flight form

local function isFlightFormId(spellId)
	-- 33943 Flight Form
	-- 40120 Swift Flight Form
	if(spellId == 40120 or spellId == 33943) then
		return true
	else 
		return false
	end
end

function MH:OnEnable()
	self:InitData()
	
	-- Dont localize this... remove should we ever get to the point of all locales 
	-- being translated to the point of location being available for each locale.
	if (GetLocale()~='enUS' and GetLocale()~='enGB') then 
		print('Non-English Locale detected. Mount checks in certain special zone might not work!');
		print('Should you encounter such an area, type /mh debug and post the result in a ticket at the project page on curseforge.');
	end

	-- update the configuration menu when new pet/mount is learned
	self:RegisterEvent("COMPANION_LEARNED")

	self:RegisterSlashCommands()
end

function MH:COMPANION_LEARNED(evt)
	MH:InitConfigOptions()
	self.ACR:NotifyChange(NAME)
	debug('Companion Learned, Updating mount+pet tab content!')
end

function MH:InitData()
	REALM_NAME = GetRealmName()
	local charName, _=UnitName("player")
	CHARACTER_NAME = charName
	
	-- mountHelperCfg
	if(not mountHelperCfgDB) then 
		mountHelperCfgDB = {
			debug=true,
			showMountMessage=false,
			showPets=false,
			fms={},
			gms={},
			wms={},
			pet={}
		}
	end
	
	MH.config = mountHelperCfgDB;
	if(not MH.config.fms) then MH.config.fms={} end
	if(not MH.config.gms) then MH.config.gms={} end
	if(not MH.config.wms) then MH.config.wms={} end
	if(not MH.config.pet) then MH.config.pet={} end
	
	MH:InitConfigOptions()
	
	print(format(L.ConfigurationLoaded, CHARACTER_NAME, REALM_NAME))
end

function MH:PrintDebug() 
	print(
		'fms='..(#(self.config.fms))..
		', gms='..(#(self.config.gms))..
		', wms='..(#(self.config.wms))..
		', pet='..(#(self.config.pet))..
		', showPets='..tostring(self.config.showPets)..
		', showMountMessage='..tostring(self.config.showMountMessage)..
		', debug='..tostring(self.config.debug)
	)
end

local function printTable(tbl)
	for k, v in pairs (tbl) do print(tostring(k)..'='..tostring(v)); end
end

local function UpdateList(data, value, adding)
	if(not adding) then
		for k,v in pairs(data) do
			if(v==value) then
				table.remove(data, k)
				return;
			end
		end
	else
		data[#data + 1] = value
	end
end

function MH:SetVal(info, v)
	if(#info==2 and info[1]=='misc') then
		self.config[info[2]] = v
		
		debug(info[2] .. '=' .. tostring(v))

		if(info[2]=='showPets') then
			if(not v) then 
				self:UnregisterChatCommand('pet')			
			else
				self:RegisterChatCommand('pet', 'OnPet')
			end
			self.config.pet={}
			MH:InitConfigOptions()
			self.ACR:NotifyChange(NAME)
		end
	else 
		if(#info==3) then
			UpdateList(self.config[info[2]], tonumber(info[3]), v)
		end
	end
end

local function ListContainsValue(data, value)
	for k, v in pairs (data) do 
		if(v==value) then return true end
	end
	return false
end

function MH:GetVal(info)
	if(#info==2 and info[1]=='misc') then
		return self.config[info[2]]
	else 
		if(#info==3) then
			return ListContainsValue(self.config[info[2]], tonumber(info[3]))
		end
	end
end

function MH:Execute(info)
	if(#info==2 and info[1]=='misc') then
		if(info[2]=='macro') then
			self:CreateMacro()
		end
		if(info[2]=='druidMacro') then
			self:CreateDruidMacro()
		end
		if(info[2]=='petMacro') then
			self:CreatePetMacro()
		end
	end
end

local function mktoggle (ord, nam, des, extrafields)
  local t = { type = 'toggle', order = ord, name = nam, desc = des }
  if extrafields and type(extrafields) == "table" then
    for k, v in pairs (extrafields) do t[k] = v end
  end
  return t
end

local function mktext (ord, text)
  local t = { type = 'description', order = ord, name = text }
  return t
end

local function mkbutton (ord, text, desc)
  local t = { type = 'execute', order = ord, name = text, desc = desc }
  return t
end

local mountTypeMappings = {
	[0]='sms',-- special
	[1]='gms',-- ground
	[2]='fms',-- flying
	[3]='wms' -- water
}

local function IsMountOfType(spellId, mountType)
	local info = mountDb[tostring(spellId)];
	if(not info) then return false end
	
	local types = info.types
	for idx=0, #types do
		if (mountTypeMappings[types[idx]]==mountType) then return true end
	end
	return false
end


local function IsPossibleGroundId(spellId)
	return IsMountOfType(spellId, 'gms')
end

local function IsPossibleFlyingId(spellId)
	return IsMountOfType(spellId, 'fms')
end

local function IsPossibleWaterId(spellId)
	return IsMountOfType(spellId, 'wms')
end

function MH:ListPlayerMounts()
	local total = GetNumCompanions(PET_TYPE_MOUNT);
	for idx = 1, total do
		local _, name, spellId, _, _ = GetCompanionInfo(PET_TYPE_MOUNT, idx)
		print(name .. ' = ' .. spellId)
	end
end

local function groupPlayerMountsByTypes()
	local map = {[0]={},[1]={},[2]={},[3]={},[100]={}};
	local total = GetNumCompanions(PET_TYPE_MOUNT)
	for idx = 1, total do
		local spellId = getMountSpellIdByIndex(idx)
		local info = mountDb[tostring(spellId)]
		
		if(info) then
			local types = info.types
			for idx=0,#types do
				local typeMounts = map[types[idx]]
				typeMounts[#typeMounts + 1] = spellId
			end
		else
			local typeMounts = map[100] -- unknown
			typeMounts[#typeMounts + 1] = spellId
		end
	end
	return map
end

local function getDruidFlightFormGroup()
	local _, clazz = UnitClass('player')
	if(clazz ~= 'DRUID' or (not PlayerHasSpellWithId(40120) and not PlayerHasSpellWithId(33943))) then
		return nil
	end
	local result = {}
	result[tostring(1)] = mktext (1, L.DruidFlightForms)
	
	-- "Swift Flight Form"=40120 "Flight Form"=33943
	if(PlayerHasSpellWithId(40120)) then 
		local n,_=GetSpellInfo(40120)
		result[tostring(40120)] = mktoggle (2, n, n..'. '..L.DruidFlightFormNote)
	else 
		if(PlayerHasSpellWithId(33943)) then
			local n,_=GetSpellInfo(33943)
			result[tostring(33943)] = mktoggle (2, n, n..'. '..L.DruidFlightFormNote)
		end
	end
	return result
end

local function addGroupToMapEnd(startingIdx, destMap, title, typeMounts)
	local idx = startingIdx;
	if(typeMounts and #typeMounts > 0) then 
		destMap[tostring(idx)] = mktext (idx, title);
		idx = idx + 1
		for mountIdx = 1, #typeMounts do
			local spellId = typeMounts[mountIdx]
			local companionIdx = getMountIndexBySpellId(spellId)
			local name = getMountNameByIndex(companionIdx)
			destMap[tostring(spellId)] = mktoggle (idx, name, name)
			idx = idx + 1
		end
	end
	return idx;
end

function MH:InitConfigOptions()
	local mountMap = groupPlayerMountsByTypes()

	-- Ground mounts
	
	local groundMounts = {}
	local groundIdx = 1
	groundIdx = addGroupToMapEnd(groundIdx, groundMounts, L.Ground, mountMap[1])
	groundIdx = addGroupToMapEnd(groundIdx, groundMounts, L.UnIdentified, mountMap[100])
	

	-- Flying mounts
	local flyingMounts = getDruidFlightFormGroup()
	local flightIdx = 1
	if(flyingMounts) then
		flightIdx = 3
	else
		flyingMounts = {}
	end

	flightIdx = addGroupToMapEnd(flightIdx, flyingMounts, L.Flying, mountMap[2])
	flightIdx = addGroupToMapEnd(flightIdx, flyingMounts, L.UnIdentified, mountMap[100])
	
	-- Water mounts
	
	local waterMounts = {}
	local waterIdx = 1
	
	waterIdx = addGroupToMapEnd(waterIdx, waterMounts, L.Water, mountMap[3])
	
	-- Pets
	
	local pets = {}
	for idx=1, GetNumCompanions(PET_TYPE_CRITTER) do
		local spellId = getPetSpellIdByIndex(idx)
		local name = getPetNameByIndex(idx)
		pets[tostring(spellId)] = mktoggle (idx, name, name)
	end
	
	-- Companion tabs
	
	local tabData = {
		 gms = {
			type = 'group', name = L.GroundMounts, desc = L.GroundMounts, order = 1,
		 	args = groundMounts
		 },
		 fms = {
		 	type = 'group', name = L.FlyingMounts, desc = L.FlyingMounts, order = 2,
		 	args = flyingMounts
		 }
	}
	
	if((#(mountMap[3]))>0) then
		tabData.wms = {
		 	type = 'group', name = L.WaterMounts, desc = L.WaterMounts, order = 3,
		 	args = waterMounts
		}
	end
	
	if(MH.config.showPets) then
		tabData.pet = {
		 	type = 'group', name = L.Pets, desc = L.Pets, order = 4,
		 	args = pets
	 	}
	end
	
	MH.configOptionTree={
		type = 'group',
		handler = MH,
		childGroups = 'tab',
		get = "GetVal", set = "SetVal", func = "Execute",
		args = {
			options = {
				type = 'group', name = L.Mounts, desc = L.MountsDesc, order = 1, childGroups = 'tab',
				args = tabData
			},
			misc = {
				type = 'group', name = L.Misc, desc = L.MiscDesc, order = 2, 
				args = {
					debug = mktoggle (1, L.Debug, L.DebugDescription),
					filler1 = mktext (2, " "),
					showMountMessage = mktoggle (3, L.ShowMountMessage, L.ShowMountMessageDesc),
					filler2 = mktext (4, " "),
					showPets = mktoggle (5, L.ShowPets, L.ShowPetsDescription),
					filler3 = mktext (6, " "),
					macro = mkbutton(7, L.MacroButton, L.MacroCommandDesc),
					filler4 = mktext (8, " "),
					druidMacro = mkbutton(9, L.DruidMacroButton, L.DruidMacroCommandDesc),
					filler5 = mktext (10, " "),
					petMacro = mkbutton(11, L.PetMacroButton, L.PetMacroCommandDesc),
					filler6 = mktext (12, " "),
				}
			},
			about = {
				type = 'group', name = L.About, desc = L.About..' '..NAME, order = 3,
      			args = {
      				content = mktext(1, 
      					L.AuthorInfo..
      					"\n"..
      					L.Usage..
      					"\n"..
      					L.TodoList
      				)
      			}
			}
		}
	}
end

function MH:GetConfigOptions()
	return MH.configOptionTree
end

function MH:InitBlizzConfigMenu()
	MH.ACR = LibStub("AceConfigRegistry-3.0")
	MH.ACR:RegisterOptionsTable (NAME, MH.GetConfigOptions)
	MH.ACD = LibStub ("AceConfigDialog-3.0")
	MH.ACD:AddToBlizOptions (NAME, GetAddOnMetadata (NAME, "Title"))
end

function MH:OnInitialize()
	self:InitBlizzConfigMenu()
	self.frame = CreateFrame ("Frame", nil)
end

function MH:RegisterSlashCommands()
	self:RegisterChatCommand('mounthelper', 'OnCmd')
	self:RegisterChatCommand('mh', 'OnCmd')
	self:RegisterChatCommand('mount', 'OnMount')
	self:RegisterChatCommand('ground', 'OnGroundMount')
	self:RegisterChatCommand('flying', 'OnFlyingMount')
	self:RegisterChatCommand('water', 'OnWaterMount')
	
	if(MH.config.showPets) then
		self:RegisterChatCommand('pet', 'OnPet')
	end
end

function MH:OnCmd(cmd)
	cmd = cmd and cmd:lower() or ''
	if cmd == 'config' then
		self:OpenConfig()
	elseif cmd == 'reset' then
		self:ResetConfig()
	elseif cmd == 'debug' then
		self:OnDebug()
	elseif cmd == 'mount' then
		self:OnMount()
	elseif cmd == 'ground' then
		self:OnGroundMount()
	elseif cmd == 'flying' then
		self:OnFlyingMount()
	elseif (cmd == 'pet' and MH.config.showPets) then
		self:OnPet()
	elseif cmd == 'macro' then
		self:CreateMacro()
	elseif cmd == 'druidmacro' then
		self:CreateDruidMacro()
	elseif cmd == 'petmacro' then
		self:CreatePetMacro()
	else
		self:PrintHelp()
	end
end

function MH:OnDebug() 
 -- print some debug information showing game locale, zone and subarea names and flight flag value
	print('Game Locale: ' .. GetLocale())
	print('GetZoneText: ' .. GetZoneText())
	print('GetRealZoneText: ' .. GetRealZoneText())
	print('GetMinimapZoneText: ' .. GetMinimapZoneText())
	if(IsFlyableArea()) then
		print('IsFyableArea: true')
	else
		print('IsFyableArea: false')
	end
end

function MH:ResetConfig()
	self.config['fms']={}
	self.config['gms']={}
	self.config['wms']={}
	self.config['pet']={}
end

function MH:CreatePetMacro()
	local mountMacroName = NAME .. 'Pets'
	if(GetMacroIndexByName(mountMacroName)==0) then
		CreateMacro(mountMacroName, 1, "/pet", false, false)
	else 
		print(format(L.MacroExists, mountMacroName));
	end
end

function MH:CreateMacro()
	local mountMacroName = NAME;
	if(GetMacroIndexByName(mountMacroName)==0) then
		CreateMacro(mountMacroName, 1, 
				"/mount \n"..
				"/dismount [noflying,nomod][mod:ctrl]",
		false, false)
	else 
		print(format(L.MacroExists, mountMacroName))
	end
end

function MH:CreateDruidMacro()
	local _, clazz = UnitClass('player')
	if(clazz ~= 'DRUID') then
		print(L.DruidMacroOnNonDruid)
		return
	end

	local mountMacroName = NAME..'Druid'
	if(GetMacroIndexByName(mountMacroName)==0) then
		local flightFormName = nil;
		do
			local flightFormSpellId = nil
			if(PlayerHasSpellWithId(40120)) then--Swift Flight Form
				flightFormSpellId = 40120
			else 
				flightFormSpellId = 33943 --Flight Form
			end
			local n,_=GetSpellInfo(flightFormSpellId)
			flightFormName = n
		end
		
		local flightStanceNr = 5
		if(PlayerHasSpellWithId(24858) or PlayerHasSpellWithId(33891)) then
			flightStanceNr = 6
		end
		 
		local macroBody =
					"/cancelform [nostance:"..flightStanceNr.."]\n".. 
					"/mh mount\n"..
					"/cast [nomounted,flyable,nostance:"..flightStanceNr.."] [mounted,noflying,flyable] "..flightFormName.."\n"..
					"/dismount [noflying,nomod][mod:ctrl]\n"..
					"/cancelform [stance:"..flightStanceNr..",noflying] [stance:"..flightStanceNr..",modifier:ctrl]"
	
		CreateMacro(mountMacroName, 1, macroBody, false, false) 
	else 
		print(format(L.MacroExists, mountMacroName))
	end
end

-- Minipets
function MH:GetRandomMinipet() 
	local data = self.config['pet']
	if (not data or #data == 0) then
		print(L.PetConfigNotSet)
		return -1
	end
	
	local petCount = (#(data))
	local i = random(1, petCount)
	
	return getPetIndexBySpellId(data[i])
end

function MH:OnPet() 
	local petIdx = self:GetRandomMinipet()
	if(not petIdx or petIdx == -1) then
		return
	end
	DismissCompanion(PET_TYPE_CRITTER)
	CallCompanion(PET_TYPE_CRITTER, petIdx)
end


-- Summoning

local function InVashjir()
	local zone = GetRealZoneText() 
	if(zone==L.AbyssalDepths or zone==L.ShimmeringExpanse or zone==L.KelptharForest) then
		return true
	else
		return false
	end
end

function MH:GetRandomMount(type)
	local data = self.config[type]
	if(not data or #(data)==0) then
		print(L.MountConfigNotSet)
		return -1
	end
	
	local typeMountCount = (#(data))
	local i = random(1, typeMountCount)
	
	local _, clazz = UnitClass("player")
	if(clazz=='DRUID' and isFlightFormId(data[i])) then
		if(data[i] == 40120) then
			print(format(L.DruidFlightTransforming, L.SwiftFlightForm))
		else 
			print(format(L.DruidFlightTransforming, L.FlightForm))
		end
		
		return -1
	end
	
	return getMountIndexBySpellId(data[i])
end

local function summonMount(idx)
	if(not idx or idx == -1) then
		return;
	end

	local _, name, _, _, _ = GetCompanionInfo(PET_TYPE_MOUNT, idx)
	if(MH.config.showMountMessage) then
		print(format(L.SummoningMount, name))
	end
	CallCompanion(PET_TYPE_MOUNT,idx)
end

function MH:OnMount(cmd)
-- if we have some water mouns selected and we are currently swimming, then try water mounts
	if(IsSwimming() and (
			-- in vashjir and atleast 1 water mount selected
			(InVashjir() and #MH.config.wms>0) 
			-- not in vashjir, one water mount selected which is not the abyssal seahorse
			or (#MH.config.wms == 1 and MH.config.wms[1]~=75207)
			-- not in vashjir and over 1 water mount selected (which means we have atleast one none-abyssal-seahorse mount in selection)
			or (#MH.config.wms > 1)
		)
	) then
		MH:OnWaterMount()
		return
	end
	
	if(
		(not IsFlyableArea() and GetZoneText()~=L.Wintergrasp)
		or GetMinimapZoneText()==L.Nespirah
		or GetZoneText()==L.ThroneOfThe4Winds
		-- Wintegrasp has its own flight rules since 4.0.1, doesn't follow the IsFlyableArea flag anymore
		or (GetZoneText()==L.Wintergrasp and not GetOutdoorPVPWaitTime())
		or IsModifierKeyDown() 
		-- Either no flying mounts selected or player doesn't have any flying mounts, just revert to ground mount.
		or (not MH.config.fms or #(MH.config.fms) == 0)
		-- Northrend needs cold weather flying to be able to fly
		or (not PlayerHasNorthrendFlight() and GetCurrentMapContinent()==4)
		-- Azeroth flight check. Needs to have Flight Master's License learned to be able to fly in kalimdor or eastern kingdoms
		or (not PlayerHasAzerothFlight() and (GetCurrentMapContinent()==1 or GetCurrentMapContinent()==2))
	) then
		MH:OnGroundMount()
	else
		MH:OnFlyingMount()
	end
end

function MH:SummonRandomMountOfType(type)
	if(not IsMounted()) then
		summonMount(self:GetRandomMount(type))
	end
end

-- Expose an option to just summon ground mount without automatic checking
function MH:OnGroundMount(cmd)
	MH:SummonRandomMountOfType("gms")
end

-- Expose an option to just summon flying mount without automatic checking
function MH:OnFlyingMount(cmd)
	MH:SummonRandomMountOfType("fms")
end

local function getAllowedWaterMounts() 
	local wms = MH.config.wms
	local allowedWms={}
	for idx=1,#wms do
		if(wms[idx]==75207) then
			if(InVashjir()) then
				return { [1] = wms[idx] }
			end
		else 
			allowedWms[#allowedWms+1]=wms[idx]
		end
	end
	return allowedWms
end

-- Expose an option to just summon water mount without automatic checking
function MH:OnWaterMount(cmd)
	if(IsMounted()) then return end

	local allowedWms=getAllowedWaterMounts()
	if(#allowedWms==0) then return end
	
	local typeMountCount = #allowedWms
	local i = random(1, typeMountCount)
	local mountIdx = getMountIndexBySpellId(allowedWms[i])
	summonMount(mountIdx)
end

function MH:OpenConfig(cmd)
	InterfaceOptionsFrame_OpenToCategory (NAME)
end

function MH:PrintHelp(cmd)
	local function PrintCmd(cmd, desc)
		print(format('/mh |cFF33FF99%s|r: %s', cmd, desc))
	end

	PrintCmd('config', L.ConfigCommandDesc)
	PrintCmd('reset', L.ResetCommandDesc)
	PrintCmd('debug', L.DebugCmd)
	PrintCmd('mount', L.MountCommandDesc)
	PrintCmd('ground', L.GroundMountCommandDesc)
	PrintCmd('flying', L.FlyingMountCommandDesc)
	PrintCmd('water', L.WaterMountCommandDesc)
	
	if(MH.config.showPets) then
		PrintCmd('pet', L.PetCommandDesc)
	end
	
	PrintCmd('macro', L.MacroCommandDesc)
	PrintCmd('druidmacro', L.DruidMacroCommandDesc)
	
	if(MH.config.showPets) then
		PrintCmd('petmacro', L.PetMacroCommandDesc)
	end
end
