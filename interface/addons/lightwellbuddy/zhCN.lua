_G["LWB"] = _G["LWB"] or {}
local LWB = _G["LWB"]
local L = LibStub("AceLocale-3.0"):NewLocale("LWB","zhCN")
if not L then return end


L["1 Charge"] = "1\230\172\161" -- Needs review
L["Absorbed:"] = "\229\144\184\230\148\182:" -- Needs review
L["Added to Blacklist"] = "[PlayerName] \229\183\178\230\183\187\229\138\160\229\136\176\233\187\145\229\144\141\229\141\149\227\128\130" -- Needs review
L["Add Player"] = "\230\183\187\229\138\160\231\142\169\229\174\182" -- Needs review
L["Add Player Desc"] = "\230\183\187\229\138\160\228\184\128\228\184\170\231\142\169\229\174\182\230\142\165\230\148\182\230\157\165\232\135\170\232\175\165\229\136\151\232\161\168\231\154\132\230\182\136\230\129\175" -- Needs review
L["Alert to Self"] = "\230\143\144\233\134\146\232\135\170\229\183\177" -- Needs review
L["Alert to Self Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\229\143\145\231\148\159\229\143\152\229\140\150\230\151\182\229\156\168\229\177\143\229\185\149\228\184\138\230\143\144\233\134\146" -- Needs review
L["Already Blacklisted"] = "[PlayerName] \229\183\178\231\187\143\229\156\168\233\187\145\229\144\141\229\141\149\227\128\130" -- Needs review
L["Already in List"] = "\231\142\169\229\174\182\229\183\178\229\156\168 [currentList] \229\136\151\232\161\168" -- Needs review
L["Battleground"] = "\230\136\152\229\156\186"
L["Begin Pulsing"] = "\229\188\128\229\167\139\232\132\137\229\138\168" -- Needs review
L["Blacklist"] = "\233\187\145\229\144\141\229\141\149"
L["Blacklist Desc"] = "\233\128\154\232\191\135\230\150\156\230\157\160\229\145\189\228\187\164\226\128\156/lwb \233\187\145\229\144\141\229\141\149\226\128\157\230\183\187\229\138\160\231\155\174\230\160\135\231\142\169\229\174\182\229\136\176\233\187\145\229\144\141\229\141\149,\230\136\150\233\128\154\232\191\135\230\150\135\230\156\172\230\161\134\232\190\147\229\133\165\231\142\169\229\174\182\229\144\141\229\173\151\230\183\187\229\138\160\229\136\176\233\187\145\229\144\141\229\141\149\239\188\140 \233\187\145\229\144\141\229\141\149\229\143\170\233\128\130\231\148\168\228\186\142\231\159\173\232\175\173\227\128\130 \229\166\130\230\158\156\232\166\129\230\183\187\229\138\160\228\184\128\228\184\170\230\157\165\232\135\170\229\133\182\228\187\150\230\156\141\229\138\161\229\153\168\231\154\132\231\142\169\229\174\182\239\188\140\232\175\183\229\156\168\229\144\141\229\173\151\229\144\142\233\157\162\230\183\187\229\138\160\230\156\141\229\138\161\229\153\168\229\144\141\229\173\151\227\128\130\228\190\139\229\166\130\239\188\154\229\189\188\229\190\151-\231\153\189\233\147\182\228\185\139\230\137\139" -- Needs review
L["Blacklist Instructions"] = "\233\128\137\228\184\173\231\155\174\230\160\135\231\142\169\229\174\182\230\183\187\229\138\160\229\136\176\233\187\145\229\144\141\229\141\149\230\136\150\228\187\142\233\133\141\231\189\174\231\170\151\229\143\163\230\137\139\229\138\168\230\183\187\229\138\160" -- Needs review
L["Channel"] = "\233\162\145\233\129\147" -- Needs review
L["[chargesRemaining] Charges"] = "[chargesRemaining] \230\172\161"
L["Charges Used:"] = "\228\189\191\231\148\168\230\172\161\230\149\176:" -- Needs review
L["Config"] = "\233\133\141\231\189\174" -- Needs review
L["Counter Bar Color"] = "\232\174\161\230\151\182\230\157\161\233\162\156\232\137\178" -- Needs review
L["Counter Bar Texture"] = "\232\174\161\230\151\182\230\157\161\230\157\144\232\180\168" -- Needs review
L["Counter Border"] = "Counter Border" -- Requires localization
L["Counter Border Size"] = "Counter Border Size" -- Requires localization
L["Counter Font"] = "Counter Font" -- Requires localization
L["Counter Options"] = "\232\174\161\230\149\176\229\153\168\233\128\137\233\161\185"
L["Counter Skin"] = "Counter Skin" -- Requires localization
L["Counter Skin Inset"] = "Counter Skin Inset" -- Requires localization
L["Crits:"] = "\230\154\180\229\135\187:" -- Needs review
L["Default"] = "\233\187\152\232\174\164" -- Needs review
L["Delete List"] = "\229\136\160\233\153\164\229\136\151\232\161\168" -- Needs review
L["Delete List Desc"] = "\229\136\160\233\153\164\233\128\137\229\174\154\229\136\151\232\161\168\233\135\140\231\154\132\228\184\170\230\128\167\229\140\150\228\191\161\230\129\175?" -- Needs review
L["Disappear"] = "\230\182\136\229\164\177\229\150\138\232\175\157" -- Needs review
L["Disappear Channel Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\229\155\160\230\132\143\229\164\150\230\182\136\229\164\177\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["disappearPhrases"] = "\230\179\137\230\176\180\229\183\178\230\143\144\229\137\141\230\182\136\229\164\177!\229\143\175\232\131\189\230\152\175\229\155\160\228\184\186\230\136\145\232\183\157\231\166\187\232\191\135\232\191\156\230\136\150\232\128\133\230\141\159\229\164\17730%\232\161\128\239\188\129(CD\229\137\169\228\189\153%l\231\167\146)" -- Needs review
L["Disappear Phrases Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\229\155\160\230\132\143\229\164\150\230\182\136\229\164\177\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Disappear Rate Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\229\155\160\230\132\143\229\164\150\230\182\136\229\164\177\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["Effective Healing:"] = "\230\156\137\230\149\136\230\178\187\231\150\151:" -- Needs review
L["Emote"] = "\232\161\168\230\131\133" -- Needs review
L["Emote As Lightwell"] = "\229\133\137\230\152\142\228\185\139\230\179\137\232\161\168\230\131\133\229\140\150" -- Needs review
L["Empty"] = "\231\148\168\231\169\186\229\150\138\232\175\157" -- Needs review
L["Empty Channel Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\231\148\168\231\169\186\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["emptyPhrases"] = "\230\179\137\230\176\180\229\183\178\231\148\168\229\174\140\239\188\140\232\176\162\232\176\162\233\133\141\229\144\136!(CD\229\137\169\228\189\153%l\231\167\146)" -- Needs review
L["Empty Phrases Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\231\148\168\231\169\186\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Empty Rate Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\231\148\168\231\169\186\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["Enable Counter"] = "\229\144\175\231\148\168\232\174\161\230\149\176\229\153\168"
L["Enabled"] = "\229\144\175\231\148\168" -- Needs review
L["Enabled Desc"] = "\229\144\175\231\148\168\230\136\150\232\128\133\231\166\129\231\148\168\230\143\146\228\187\182\227\128\130" -- Needs review
L["Expire"] = "\229\136\176\230\156\159\229\150\138\232\175\157" -- Needs review
L["Expire Channel Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\229\136\176\230\156\159\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["expirePhrases"] = "\230\179\137\230\176\180\229\183\178\229\136\176\230\156\159! (\232\191\152\230\156\137%c\230\172\161\230\156\170\228\189\191\231\148\168)" -- Needs review
L["Expire Phrases Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\229\136\176\230\156\159\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Expire Rate Desc"] = "\229\189\147\228\189\160\231\154\132\230\179\137\230\176\180\229\136\176\230\156\159\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["General Use"] = "\228\184\128\232\136\172\229\150\138\232\175\157" -- Needs review
L["General Use CD Desc"] = "\228\184\186\228\186\134\233\129\191\229\133\141\229\136\183\229\177\143\239\188\140\229\143\145\233\128\129\228\184\128\230\157\161\230\182\136\230\129\175\229\144\142\239\188\140\229\143\166\228\184\128\230\157\161\230\182\136\230\129\175\229\176\134\228\184\141\228\188\154\232\162\171\229\143\145\233\128\129\239\188\140\231\155\180\229\136\176\230\140\135\229\174\154\231\154\132\231\167\146\230\149\176\232\191\135\229\142\187\227\128\130" -- Needs review
L["General Use Channel Desc"] = "\229\189\147\230\156\137\228\186\186\228\189\191\231\148\168\228\189\160\231\154\132\230\179\137\230\176\180\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["General Use Desc"] = "\230\142\167\229\136\182\228\184\128\232\136\172\231\142\169\229\174\182\228\189\191\231\148\168\230\179\137\230\176\180\231\154\132\230\182\136\230\129\175\239\188\140\228\189\134\228\184\141\229\140\133\230\139\172\228\184\170\230\128\167\229\140\150\229\136\151\232\161\168\231\154\132\231\142\169\229\174\182\227\128\130" -- Needs review
L["General Use Phrases Desc"] = "\229\189\147\230\156\137\228\186\186\228\189\191\231\148\168\228\189\160\231\154\132\230\179\137\230\176\180\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["General Use Rate Desc"] = "\229\189\147\230\156\137\228\186\186\228\189\191\231\148\168\228\189\160\231\154\132\230\179\137\230\176\180\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["Guild"] = "\229\133\172\228\188\154"
L["Healing Done:"] = "\230\128\187\230\178\187\231\150\151\233\135\143:" -- Needs review
L["Hide Counter When:"] = "\233\154\144\232\151\143\232\174\161\230\149\176\229\153\168\229\189\147:" -- Needs review
L["Hide Counter When Not Summoned"] = "\230\178\161\230\156\137\230\148\190\229\135\186\230\179\137\230\176\180" -- Needs review
L["Idle"] = "\233\151\178\231\189\174\229\150\138\232\175\157" -- Needs review
L["Idle Channel Desc"] = "\230\179\137\230\176\180\233\151\178\231\189\174\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["Idle Desc"] = "\230\179\137\230\176\180\229\156\168\228\184\128\229\174\154\230\151\182\233\151\180\229\134\133\230\156\170\228\189\191\231\148\168\239\188\140\229\176\134\229\150\138\232\175\157\230\143\144\233\134\146\227\128\130" -- Needs review
L["Idle Max Time Desc"] = "\232\182\133\232\191\135\228\184\128\229\174\154\230\151\182\233\151\180\230\156\170\232\162\171\228\189\191\231\148\168\229\176\134\229\150\138\232\175\157\227\128\130" -- Needs review
L["idlePhrases"] = "\229\133\137\230\152\142\228\185\139\230\179\137\239\188\154\239\189\158\239\189\158\229\164\170\229\175\130\229\175\158\228\186\134\239\188\140\229\147\166\239\189\158\229\164\170\229\175\130\229\175\158\228\186\134\239\189\158\232\191\153\228\185\136\233\149\191\230\151\182\233\151\180\230\178\161\228\186\186\232\166\129\230\136\145\239\189\158\239\189\158(\231\169\186\233\151\178%i\231\167\146\239\188\140\229\137\169\228\189\153%c\230\172\161)\
\229\133\137\230\152\142\228\185\139\230\179\137\239\188\154\228\189\160\230\131\179\232\166\129\229\176\177\232\175\180\232\175\157\229\152\155,\232\153\189\231\132\182\228\189\160\229\190\136\230\156\137\232\175\154\230\132\143\231\154\132\231\156\139\231\157\128\230\136\145,\229\143\175\230\152\175\232\191\152\230\152\175\232\166\129\232\183\159\230\136\145\232\175\180\228\189\160\230\131\179\232\166\129\231\154\132,\231\156\159\231\154\132\230\131\179\232\166\129\229\144\151?\233\130\163\229\176\177\230\139\191\229\142\187\229\144\167!\228\189\160\228\184\141\230\152\175\231\156\159\231\154\132\230\131\179\232\166\129\229\144\167?\233\154\190\233\129\147\228\189\160\231\156\159\231\154\132\230\131\179\232\166\129\229\144\151?(\231\169\186\233\151\178%i\231\167\146\239\188\140\229\137\169\228\189\153%c\230\172\161)" -- Needs review
L["idle Phrases Desc"] = "\230\179\137\230\176\180\233\151\178\231\189\174\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Idle Rate Desc"] = "\230\179\137\230\176\180\233\151\178\231\189\174\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175" -- Needs review
L["Instance"] = "Instance" -- Requires localization
L["Lightwell Disappeared with [chargesRemaining] charges remaining!"] = "\230\179\137\230\176\180\229\183\178\230\182\136\229\164\177\239\188\140\230\181\170\232\180\185: [chargesRemaining]\230\172\161!" -- Needs review
L["Lightwell Empty!"] = "\230\179\137\230\176\180\231\169\186\228\186\134!" -- Needs review
L["Lightwell Expired with [Charges] charges remaining!"] = "\230\179\137\230\176\180\230\174\139\229\173\152[Charges] \230\172\161\239\188\140\230\182\136\229\164\177\228\186\134!" -- Needs review
L["Lightwell Summoned!"] = "\230\148\190\229\135\186\230\179\137\230\176\180!" -- Needs review
L["Lightwell Used by [PlayerName] ([chargesRemaining]/[chargesMax] Left)"] = "[PlayerName] \231\148\168\228\186\134\230\179\137\230\176\180 ([chargesRemaining]/[chargesMax])" -- Needs review
L["Lightwell Wasted by [PlayerName] ([chargesRemaining]/[chargesMax] Left)"] = "[PlayerName] \230\181\170\232\180\185\228\186\134\228\184\128\230\172\161\230\179\137\230\176\180 ([chargesRemaining]/[chargesMax])" -- Needs review
L["Lock Counter Position"] = "\233\148\129\229\174\154\232\174\161\230\149\176\229\153\168\228\189\141\231\189\174" -- Needs review
L["/lwb blacklist -- blacklists your current target"] = "/lwb \233\187\145\229\144\141\229\141\149 -- \230\183\187\229\138\160\228\189\160\229\189\147\229\137\141\231\155\174\230\160\135\229\136\176\233\187\145\229\144\141\229\141\149" -- Needs review
L["/lwb config -- opens the configuration window"] = "/lwb \233\133\141\231\189\174 -- \230\137\147\229\188\128\233\133\141\231\189\174\231\170\151\229\143\163" -- Needs review
L["Max Idle Time"] = "\230\156\128\229\164\167\233\151\178\231\189\174\230\151\182\233\151\180" -- Needs review
L["Message Cooldown"] = "\230\182\136\230\129\175\233\151\180\233\154\148" -- Needs review
L["Message on Last Use"] = "\228\189\191\231\148\168\230\138\165\229\145\138" -- Needs review
L["Message on Last Use Desc"] = "\230\138\165\229\145\138\228\189\191\231\148\168\230\179\137\230\176\180\231\154\132\230\182\136\230\129\175" -- Needs review
L["Modify Profiles"] = "\230\155\180\230\148\185\233\133\141\231\189\174" -- Needs review
L["Multiconsumption"] = "\229\164\154\230\172\161\231\130\185\229\135\187\229\150\138\232\175\157" -- Needs review
L["Multiconsumption Channel Desc"] = "\229\189\147\231\142\169\229\174\182\229\191\171\233\128\159\229\164\154\229\135\187\230\179\137\230\176\180\239\188\140\233\128\160\230\136\144\230\181\170\232\180\185\230\172\161\230\149\176\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["Multiconsumption Desc"] = "\228\184\128\232\136\172\231\154\132\230\179\137\230\176\180\228\189\191\231\148\168\232\128\133\228\184\141\228\188\154\229\155\160\228\184\186\229\183\178\231\187\143\230\139\165\230\156\137\230\179\137\230\176\180hot\230\149\136\230\158\156\232\128\140\229\134\141\230\172\161\231\130\185\229\135\187\233\128\160\230\136\144\230\172\161\230\149\176\230\181\170\232\180\185\239\188\140\228\189\134\230\152\175\229\189\147\228\184\128\228\184\170\231\142\169\229\174\182\229\156\168\232\142\183\229\190\151\230\179\137\230\176\180hot\230\149\136\230\158\156\228\185\139\230\151\182\239\188\140\229\191\171\233\128\159\229\164\154\229\135\187\230\179\137\230\176\180\239\188\140\229\176\134\228\188\154\233\128\160\230\136\144\230\172\161\230\149\176\230\181\170\232\180\185\227\128\130" -- Needs review
L["multiconsumptionPhrases"] = "%u\239\188\140\228\184\186\228\186\134\233\129\191\229\133\141\230\179\137\230\176\180\230\172\161\230\149\176\232\162\171\230\181\170\232\180\185\239\188\140\232\175\183\228\184\141\232\166\129\229\191\171\233\128\159\231\154\132\229\164\154\230\172\161\231\130\185\229\135\187\230\179\137\230\176\180\227\128\130(%c / %m)\
%u\239\188\140\228\184\141\232\166\129\232\191\158\231\187\173\230\136\179\230\136\145\239\188\129\231\150\188\239\188\129(%c / %m)" -- Needs review
L["Multiconsumption Phrases Desc"] = "\229\189\147\231\142\169\229\174\182\229\191\171\233\128\159\229\164\154\229\135\187\230\179\137\230\176\180\239\188\140\233\128\160\230\136\144\230\172\161\230\149\176\230\181\170\232\180\185\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Multiconsumption Rate Desc"] = "\229\189\147\231\142\169\229\174\182\229\191\171\233\128\159\229\164\154\229\135\187\230\179\137\230\176\180\239\188\140\233\128\160\230\136\144\230\172\161\230\149\176\230\181\170\232\180\185\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["Multiple Lightwell Charges Used by [PlayerName] ([chargesRemaining]/[chargesMax] Left)"] = " [PlayerName] \229\164\154\230\172\161\231\130\185\229\135\187\230\179\137\230\176\180([chargesRemaining]/[chargesMax])" -- Needs review
L["New List"] = "\230\150\176\229\187\186\229\136\151\232\161\168" -- Needs review
L["New List Desc"] = "\231\187\153\228\189\160\231\154\132\230\150\176\229\136\151\232\161\168\232\181\183\228\184\128\228\184\170\228\184\170\230\128\167\229\140\150\229\144\141\229\173\151\227\128\130" -- Needs review
L["No lightwell up"] = "\230\178\161\230\156\137\230\179\137\230\176\180" -- Needs review
L["None"] = "\230\151\160"
L["Officer"] = "\229\174\152\229\145\152"
L["Out of Combat"] = "\232\132\177\231\166\187\230\136\152\230\150\151" -- Needs review
L["Out of Combat Desc"] = "\229\156\168\231\166\187\229\188\128\230\136\152\230\150\151\229\144\142\228\190\157\230\151\167\230\138\165\229\145\138\232\191\135\230\156\159\239\188\140\230\182\136\229\164\177\229\146\140\233\151\178\231\189\174\230\151\182\233\151\180" -- Needs review
L["Over Healing:"] = "\232\191\135\233\135\143\230\178\187\231\150\151:" -- Needs review
L["Party"] = "\233\152\159\228\188\141"
L["Personalized Use"] = "\228\184\170\230\128\167\229\150\138\232\175\157" -- Needs review
L["Personalized Use Desc"] = "\231\137\185\229\174\154\231\154\132\231\142\169\229\174\182\228\189\191\231\148\168\230\179\137\230\176\180\230\151\182\239\188\140\229\176\134\228\189\191\231\148\168\228\184\170\230\128\167\229\140\150\230\182\136\230\129\175\229\143\150\228\187\163\228\184\128\232\136\172\228\189\191\231\148\168\230\182\136\230\129\175\227\128\130" -- Needs review
L["Personal List CD Desc"] = "\229\143\145\233\128\129\228\184\128\230\157\161\230\182\136\230\129\175\229\144\142\239\188\140\229\176\134\228\184\141\228\188\154\229\143\145\233\128\129\229\143\166\228\184\128\230\157\161\230\182\136\230\129\175\229\156\168\230\173\164\229\136\151\232\161\168\228\184\173\231\154\132\231\142\169\229\174\182\239\188\140\231\155\180\229\136\176\230\140\135\229\174\154\231\154\132\230\151\182\233\151\180\232\191\135\229\142\187\227\128\130" -- Needs review
L["Personal List Channel Desc"] = "\231\137\185\229\174\154\231\154\132\231\142\169\229\174\182\228\189\191\231\148\168\230\179\137\230\176\180\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["Personal List Phrases Desc"] = "\231\137\185\229\174\154\231\154\132\231\142\169\229\174\182\228\189\191\231\148\168\230\179\137\230\176\180\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Personal List Rate Desc"] = "\231\137\185\229\174\154\231\154\132\231\142\169\229\174\182\228\189\191\231\148\168\230\179\137\230\176\180\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["Phrases"] = "\231\159\173\232\175\173" -- Needs review
L["Placeholder Desc"] = "\228\187\187\228\189\149\228\187\165\228\184\139\229\141\160\228\189\141\231\172\166\229\176\134\232\162\171\230\155\191\230\141\162\239\188\154%u = \228\189\191\231\148\168\232\128\133,%p = \232\135\170\229\183\177\229\144\141\229\173\151,%c = \229\137\169\228\189\153\230\172\161\230\149\176,%x = \229\183\178\231\148\168\230\172\161\230\149\176,%m = \230\156\128\229\164\167\230\172\161\230\149\176,%t = \229\173\152\229\156\168\230\151\182\233\151\180,%l = \229\137\169\228\189\153\230\151\182\233\151\180, %i  = \230\151\160\228\186\186\228\189\191\231\148\168\230\151\182\233\151\180\227\128\130\239\188\136\230\175\143\228\184\170\233\161\181\233\157\162\231\154\132\226\128\156\229\135\160\231\142\135\226\128\157\233\128\137\233\161\185\230\152\175\230\140\135\229\189\147\229\128\188\228\184\18650%\230\151\182\239\188\140\228\188\154\230\156\13750%\231\154\132\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\239\188\140\229\189\147\229\128\188\228\184\1860%\230\151\182\239\188\140\232\130\175\229\174\154\228\184\141\228\188\154\229\143\145\233\128\129\230\182\136\230\129\175\239\188\137----\228\184\137\229\140\186,\231\148\156\230\176\180\231\187\191\230\180\178,\233\155\168\229\174\171\228\188\152\229\173\144(ranrain) \228\184\173\230\150\135\229\140\150" -- Needs review
L["Player Unblacklisted"] = "[PlayerName] \229\183\178\228\187\142\233\187\145\229\144\141\229\141\149\228\184\173\229\136\160\233\153\164\227\128\130" -- Needs review
L["Profile changed to: [profileName]"] = "\230\155\180\230\148\185\233\133\141\231\189\174\229\136\176: [profileName]"
L["Raid"] = "\229\155\162\233\152\159"
L["Raid Warning"] = "\229\155\162\233\152\159\233\128\154\231\159\165" -- Needs review
L["Rate"] = "\229\135\160\231\142\135" -- Needs review
L["Remove Player"] = "\229\136\160\233\153\164\231\142\169\229\174\182" -- Needs review
L["Remove Player Desc"] = "\229\136\160\233\153\164\228\184\128\228\184\170\230\142\165\230\148\182\232\175\165\229\136\151\232\161\168\230\182\136\230\129\175\231\154\132\231\142\169\229\174\182\227\128\130" -- Needs review
L["Results of Lightwell:"] = "\230\179\137\230\176\180\228\189\191\231\148\168\231\187\147\230\158\156:" -- Needs review
L["Say"] = "\232\175\180" -- Needs review
L["Say As Lightwell"] = "\229\133\137\230\152\142\228\185\139\230\179\137\232\175\180" -- Needs review
L["Select A List"] = "\233\128\137\230\139\169\228\184\128\228\184\170\229\136\151\232\161\168" -- Needs review
L["Select A List Desc"] = "\233\128\137\230\139\169\228\184\128\228\184\170\231\142\176\230\156\137\229\136\151\232\161\168\239\188\140\228\187\165\228\190\191\230\183\187\229\138\160\231\142\169\229\174\182\239\188\140\231\159\173\232\175\173\229\146\140\228\191\174\230\148\185\229\133\182\228\187\150\233\128\137\233\161\185\227\128\130" -- Needs review
L["Smart"] = "\232\135\170\229\138\168" -- Needs review
L["Summon"] = "\230\148\190\229\135\186\229\150\138\232\175\157" -- Needs review
L["Summon Channel Desc"] = "\229\189\147\228\189\160\230\148\190\229\135\186\230\179\137\230\176\180\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\230\143\144\233\134\146\229\133\182\228\187\150\231\142\169\229\174\182\227\128\130" -- Needs review
L["summonPhrases"] = "\232\175\183\229\156\168\232\161\128\229\176\145\231\154\132\230\151\182\229\128\153\232\135\170\232\167\137\231\130\185\230\179\137\230\176\180! (20\231\160\129\229\134\133\239\188\140\230\152\143\232\191\183\231\156\169\230\153\149\231\173\137\228\187\187\228\189\149\231\138\182\230\128\129\231\154\134\229\143\175\231\148\168\239\188\140\229\133\177\232\174\161%m\230\172\161)" -- Needs review
L["Summon Phrases Desc"] = "\229\189\147\228\189\160\230\148\190\229\135\186\230\179\137\230\176\180\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Summon Rate Desc"] = "\229\189\147\228\189\160\230\148\190\229\135\186\230\179\137\230\176\180\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["Support Lightspring"] = "\230\148\175\230\140\129\229\133\137\230\152\142\229\156\163\230\179\137(\233\155\149\230\150\135)" -- Needs review
L["Support Lightspring Desc"] = "\229\144\175\231\148\168\229\133\137\230\152\142\229\156\163\230\179\137\231\154\132\230\138\165\229\145\138" -- Needs review
L["Talk to Strangers"] = "\230\138\165\229\145\138\233\153\140\231\148\159\228\186\186" -- Needs review
L["Talk to Strangers Desc"] = "\228\187\150\228\184\141\229\156\168\228\189\160\231\154\132\229\176\143\233\152\159\230\136\150\229\155\162\233\152\159\230\151\182\228\185\159\230\138\165\229\145\138\228\189\191\231\148\168\228\191\161\230\129\175" -- Needs review
L["Unblacklist"] = "\232\167\163\233\153\164\233\187\145\229\144\141\229\141\149" -- Needs review
L["Unblacklist Desc"] = "\228\189\191\231\148\168\228\184\139\230\139\137\232\143\156\229\141\149\228\187\142\233\187\145\229\144\141\229\141\149\228\184\173\229\136\160\233\153\164\228\184\128\228\184\170\231\142\169\229\174\182\227\128\130" -- Needs review
L["Un-blacklist player"] = "\228\187\142\233\187\145\229\144\141\229\141\149\229\136\160\233\153\164\231\142\169\229\174\182" -- Needs review
L["usePhrases"] = "%u,\232\176\162\232\176\162\228\189\160\228\189\191\231\148\168\228\186\134\230\136\145\231\154\132\230\179\137\230\176\180! (%c / %m)\
%u,\228\189\191\231\148\168\228\186\134\230\179\137\230\176\180! (%c / %m)" -- Needs review
L["Waste"] = "\230\181\170\232\180\185\229\150\138\232\175\157" -- Needs review
L["Waste Channel Desc"] = "\229\189\147\230\156\137\228\186\186\232\175\149\229\155\190\228\185\177\231\130\185\230\179\137\230\176\180\233\128\160\230\136\144\230\181\170\232\180\185\230\151\182\239\188\140\229\143\145\233\128\129\230\182\136\230\129\175\229\156\168\233\162\145\233\129\147" -- Needs review
L["Waste Cut Off"] = "\230\156\128\229\164\167\229\129\165\229\186\183\229\128\188" -- Needs review
L["Waste Cut Off Desc"] = "\229\166\130\230\158\156\230\156\137\228\186\186\230\156\137\230\175\148\232\191\153\230\155\180\229\129\165\229\186\183\230\151\182\239\188\140\228\187\150\228\187\172\229\134\141\228\189\191\231\148\168\230\179\137\230\176\180\239\188\140\229\176\134\230\138\165\229\145\138\228\187\150\228\187\172\228\184\186\230\181\170\232\180\185\239\188\155\229\189\147\228\187\150\228\187\172\228\184\141\229\156\168\228\189\160\231\154\132\229\176\143\233\152\159\230\136\150\229\155\162\233\152\159\230\151\182\239\188\140\231\148\177\228\186\142\230\178\161\230\156\137\229\138\158\230\179\149\232\142\183\229\190\151\228\187\150\231\154\132\229\129\165\229\186\183\239\188\140\230\137\128\228\187\165\228\187\150\228\187\172\229\176\134\228\184\141\232\162\171\230\163\128\230\181\139\228\184\186\230\181\170\232\180\185\227\128\130" -- Needs review
L["wastePhrases"] = "%u\239\188\140\232\176\162\232\176\162\228\189\160\228\189\191\231\148\168\230\136\145\231\154\132\230\179\137\230\176\180,\228\189\134\232\175\183\229\176\189\233\135\143\231\161\174\228\191\157\228\189\160\233\156\128\232\166\129\229\174\131\227\128\130 (%c / %m)\
%u\239\188\140 \230\137\139\231\150\188\228\185\159\228\184\141\232\166\129\230\136\179\230\136\145\239\188\140\230\136\179\229\174\140\228\186\134\229\176\177\230\138\165\229\186\159\228\186\134\239\188\129(%c / %m)" -- Needs review
L["Waste Phrases Desc"] = "\229\189\147\230\156\137\228\186\186\232\175\149\229\155\190\228\185\177\231\130\185\230\179\137\230\176\180\233\128\160\230\136\144\230\181\170\232\180\185\230\151\182\239\188\140\229\136\134\229\136\171\231\148\168\228\184\139\233\157\162\231\154\132\231\159\173\232\175\173\230\157\165\230\138\165\229\145\138\227\128\130" -- Needs review
L["Waste Rate Desc"] = "\229\189\147\230\156\137\228\186\186\232\175\149\229\155\190\228\185\177\231\130\185\230\179\137\230\176\180\233\128\160\230\136\144\230\181\170\232\180\185\230\151\182\239\188\140\230\156\137\229\135\160\231\142\135\228\184\141\229\143\145\233\128\129\230\182\136\230\129\175\227\128\130" -- Needs review
L["Whisper"] = "\229\175\134\232\175\173"
L["Yell"] = "\229\164\167\229\150\138"
