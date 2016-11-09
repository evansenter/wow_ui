-- Translate RCLootCouncil to your language at:
-- http://wow.curseforge.com/addons/rclootcouncil/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("RCLootCouncil", "ruRU")
if not L then return end

L["Abort"] = "\208\161\208\177\209\128\208\190\209\129\208\184\209\130\209\140" -- Needs review
L["Accept Whispers"] = "\208\159\209\128\208\184\208\189\208\184\208\188\208\176\209\130\209\140 \208\155\208\184\209\135\208\189\209\139\208\181 \209\129\208\190\208\190\208\177\209\137\208\181\208\189\208\184\209\143" -- Needs review
-- L["accept_whispers_desc"] = ""
-- L["Acknowledged as 'response'"] = ""
-- L["Active"] = ""
-- L["active_desc"] = ""
L["add"] = "\208\180\208\190\208\177\208\176\208\178\208\184\209\130\209\140" -- Needs review
-- L["Add Item"] = ""
L["Add Note"] = "\208\148\208\190\208\177\208\176\208\178\208\184\209\130\209\140 \208\151\208\176\208\188\208\181\209\130\208\186\209\131" -- Needs review
L["Add ranks"] = "\208\148\208\190\208\177\208\176\208\178\208\184\209\130\209\140 \209\128\208\176\208\189\208\186\208\184" -- Needs review
-- L["add_ranks_desc"] = ""
-- L["add_ranks_desc2"] = ""
-- L["Add rolls"] = ""
L["All items"] = "\208\146\209\129\208\181 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\209\139" -- Needs review
-- L["All items has been awarded and  the loot session concluded"] = ""
-- L["Alt click Looting"] = ""
-- L["alt_click_looting_desc"] = ""
-- L["Alternatively, flag the loot as award later."] = ""
-- L["Always use RCLootCouncil when I'm Master Looter"] = ""
-- L["Always use when leader"] = ""
-- L["A new session has begun, type '/rc open' to open the voting frame."] = ""
L["Announce Awards"] = "\208\144\208\189\208\190\208\189\209\129\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\146\209\128\209\131\209\135\208\181\208\189\208\189\209\139\208\181 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\209\139" -- Needs review
-- L["announce_awards_desc"] = ""
-- L["announce_awards_desc2"] = ""
-- L["Announce Considerations"] = ""
-- L["announce_considerations_desc"] = ""
-- L["announce_considerations_desc2"] = ""
-- L["Announcements"] = ""
L["Anonymous Voting"] = "\208\144\208\189\208\190\208\189\208\184\208\188\208\189\208\190\208\181 \208\147\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\208\181" -- Needs review
L["anonymous_voting_desc"] = "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\176\208\189\208\190\208\189\208\184\208\188\208\189\208\190\208\181 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\208\181 (\209\130.\208\181. \208\187\209\142\208\180\208\184 \208\189\208\181 \208\178\208\184\208\180\209\143\209\130 \208\186\209\130\208\190 \208\183\208\176 \209\135\209\130\208\190 \208\191\209\128\208\190\208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\187)"
-- L["Appearance"] = ""
-- L["Append realm names"] = ""
-- L["Are you sure you want to abort?"] = ""
-- L["Are you sure you want to give #item to #player?"] = ""
-- L["Ask me every time I become Master Looter"] = ""
-- L["Ask me when leader"] = ""
L["Auto Award"] = "\208\144\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\190\208\181 \208\146\209\128\209\131\209\135\208\181\208\189\208\184\208\181" -- Needs review
L["auto_award_desc"] = "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\190\208\181 \209\128\208\176\209\129\208\191\209\128\208\181\208\180\208\181\208\187\208\181\208\189\208\184\208\181"
-- L["Auto awarded 'item'"] = ""
L["Auto Award to"] = "\208\144\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\184 \208\146\209\128\209\131\209\135\208\176\209\130\209\140" -- Needs review
L["auto_award_to_desc"] = "\208\152\208\179\209\128\208\190\208\186\208\184 \208\180\208\187\209\143 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\190\208\179\208\190 \209\128\208\176\209\129\208\191\209\128\208\181\208\180\208\181\208\187\208\181\208\189\208\184\209\143. \208\161\208\191\208\184\209\129\208\190\208\186 \208\184\208\179\209\128\208\190\208\186\208\190\208\178 \208\180\208\187\209\143 \208\178\209\139\208\177\208\190\209\128\208\176 \208\191\208\190\209\143\208\178\208\187\209\143\208\181\209\130\209\129\209\143 \208\181\209\129\208\187\208\184 \208\178\209\139 \208\178 \209\128\208\181\208\185\208\180\208\190\208\178\208\190\208\185 \208\179\209\128\209\131\208\191\208\191\208\181."
-- L["Auto Close"] = ""
-- L["auto_close_desc"] = ""
-- L["Auto Enable"] = ""
-- L["auto_enable_desc"] = ""
-- L["Auto Loot"] = ""
-- L["Autoloot BoE"] = ""
-- L["autoloot_BoE_desc"] = ""
-- L["auto_loot_desc"] = ""
-- L["Auto Open"] = ""
-- L["auto_open_desc"] = ""
L["Autopass"] = "\208\144\208\178\209\130\208\190\208\191\208\176\209\129" -- Needs review
-- L["Auto Pass"] = ""
-- L["Auto pass BoE"] = ""
-- L["auto_pass_boe_desc"] = ""
-- L["auto_pass_desc"] = ""
-- L["Autopassed on 'item'"] = ""
-- L["Auto Start"] = ""
-- L["auto_start_desc"] = ""
-- L["Autostart isn't supported when testing"] = ""
-- L["award"] = ""
-- L["Award"] = ""
-- L["Award Announcement"] = ""
-- L["Award for ..."] = ""
-- L["Award later?"] = ""
L["Award Reasons"] = "\208\159\209\128\208\184\209\135\208\184\208\189\208\176 \208\146\209\128\209\131\209\135\208\181\208\189\208\184\209\143" -- Needs review
L["award_reasons_desc"] = "\208\159\209\128\208\184\209\135\208\184\208\189\209\139 \208\178\209\128\209\131\209\135\208\181\208\189\208\184\209\143, \208\186\208\190\209\130\208\190\209\128\209\139\208\181 \208\189\208\181 \208\188\208\190\208\179\209\131\209\130 \208\177\209\139\209\130\209\140 \208\178\209\139\208\177\209\128\208\176\208\189\209\139 \208\178\208\190 \208\178\209\128\208\181\208\188\209\143 \209\128\208\190\208\187\208\187\208\176.\
\208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\209\130\209\129\209\143 \208\191\209\128\208\184 \208\184\208\183\208\188\208\181\208\189\208\181\208\189\208\184\208\184 \208\190\209\130\208\178\208\181\209\130\208\176 \208\178 \208\188\208\181\208\189\209\142 \208\191\208\190 \208\191\209\128\208\176\208\178\208\190\208\185 \208\186\208\189\208\190\208\191\208\186\208\184 \208\188\209\139\209\136\208\184, \208\184 \208\180\208\187\209\143 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\190\208\179\208\190 \208\178\209\128\209\131\209\135\208\181\208\189\208\184\209\143."
L["Awards"] = "\208\157\208\176\208\179\209\128\208\176\208\180\209\139" -- Needs review
-- L["Background"] = ""
-- L["Background Color"] = ""
L["Banking"] = "\208\146 \208\177\208\176\208\189\208\186"
-- L["BBCode export, tailored for SMF."] = ""
-- L["Border"] = ""
-- L["Border Color"] = ""
L["Button"] = "\208\154\208\189\208\190\208\191\208\186\208\176" -- Needs review
-- L["Buttons and Responses"] = ""
-- L["buttons_and_responses_desc"] = ""
-- L["Cancel"] = ""
L["Candidate didn't respond on time"] = "\208\154\208\176\208\189\208\180\208\184\208\180\208\176\209\130 \208\189\208\181 \208\190\209\130\208\178\208\181\209\130\208\184\208\187 \208\178\208\190\208\178\209\128\208\181\208\188\209\143" -- Needs review
-- L["Candidate has disabled RCLootCouncil"] = ""
-- L["Candidate is not in the instance"] = ""
L["Candidate is selecting response, please wait"] = "\208\154\208\176\208\189\208\180\208\184\208\180\208\176\209\130 \208\180\208\181\208\187\208\176\208\181\209\130 \208\178\209\139\208\177\208\190\209\128, \208\191\208\190\208\182\208\176\208\187\209\131\208\185\209\129\209\130\208\176 \208\191\208\190\208\180\208\190\208\182\208\180\208\184\209\130\208\181" -- Needs review
L["Candidate removed"] = "\208\154\208\176\208\189\208\180\208\184\208\180\208\176\209\130 \209\131\208\180\208\176\208\187\208\181\208\189" -- Needs review
-- L["Cannot autoaward:"] = ""
-- L["Cannot give 'item' to 'player' due to Blizzard limitations. Gave it to you for distribution."] = ""
-- L["Change Response"] = ""
L["Changing LootMethod to Master Looting"] = "\208\160\208\176\208\183\208\180\208\181\208\187\208\181\208\189\208\184\208\181 \208\180\208\190\208\177\209\139\209\135\208\184 \208\191\209\128\208\190\208\184\208\183\208\178\208\190\208\180\208\184\209\130\209\129\209\143 \208\191\208\190 \209\129\208\184\209\129\209\130\208\181\208\188\208\181 \208\158\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\181\208\189\208\189\209\139\208\185 \208\183\208\176 \208\180\208\190\208\177\209\139\209\135\209\131." -- Needs review
L["Changing loot threshold to enable Auto Awarding"] = "\208\152\208\183\208\188\208\181\208\189\208\184\209\130\208\181 \208\191\208\190\209\128\208\190\208\179 \209\128\208\176\209\129\208\191\209\128\208\181\208\180\208\181\208\187\208\181\208\189\208\184\209\143 \208\180\208\190\208\177\209\139\209\135\208\184, \209\135\209\130\208\190\208\177\209\139 \208\178\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\144\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\190\208\181 \208\146\209\128\209\131\209\135\208\181\208\189\208\184\208\181" -- Needs review
-- L["Channel"] = ""
-- L["channel_desc"] = ""
-- L["chat_commands"] = ""
-- L["chat tVersion string"] = ""
-- L["chat version String"] = ""
-- L["Check this to loot the items and distribute them later."] = ""
-- L["Check to append the realmname of a player from another realm"] = ""
-- L["Check to have all frames minimize when entering combat"] = ""
-- L["Choose timeout length in seconds"] = ""
-- L["Choose when to use RCLootCouncil"] = ""
-- L["Clear Loot History"] = ""
-- L["clear_loot_history_desc"] = ""
-- L["Click to add note to send to the council."] = ""
-- L["Click to expand/collapse more info"] = ""
-- L["Click to switch to 'item'"] = ""
-- L["Close"] = ""
L["config"] = "\208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\176" -- Needs review
-- L["confirm_usage_text"] = ""
-- L["Could not Auto Award i because the Loot Threshold is too high!"] = ""
-- L["Could not find 'player' in the group."] = ""
-- L["Couldn't find any councilmembers in the group"] = ""
L["council"] = "\209\129\208\190\208\178\208\181\209\130" -- Needs review
-- L["Council"] = ""
-- L["Current Council"] = ""
L["current_council_desc"] = "\208\157\208\176\208\182\208\188\208\184\209\130\208\181, \209\135\209\130\208\190\208\177\209\139 \209\131\208\180\208\176\208\187\208\184\209\130\209\140 \208\190\208\191\209\128\208\181\208\180\208\181\208\187\208\181\208\189\208\189\209\139\209\133 \208\187\209\142\208\180\208\181\208\185 \208\184\208\183 \209\129\208\190\208\178\208\181\209\130\208\176" -- Needs review
-- L["Customize appearance"] = ""
-- L["customize_appearance_desc"] = ""
-- L["Date"] = ""
L["days and x months"] = "%s \208\184 %d \208\188\208\181\209\129\209\143\209\134\208\181\208\178." -- Needs review
L["days, x months, y years"] = "%s, %d \208\188\208\181\209\129\209\143\209\134\208\181\208\178 \208\184 %d \208\187\208\181\209\130." -- Needs review
-- L["Delete Skin"] = ""
-- L["delete_skin_desc"] = ""
-- L["Deselect responses to filter them"] = ""
-- L["Diff"] = ""
L["Disenchant"] = "\208\160\208\176\209\129\208\191\209\139\208\187\208\181\208\189\208\184\208\181" -- Needs review
-- L["disenchant_desc"] = ""
L["DPS"] = "\208\163\208\146\208\161" -- Needs review
-- L["Dropped by:"] = ""
-- L["Enable Loot History"] = ""
L["enable_loot_history_desc"] = "\208\146\208\186\208\187\209\142\209\135\208\176\208\181\209\130 \208\178\208\181\208\180\208\181\208\189\208\184\208\181 \208\184\209\129\209\130\208\190\209\128\208\184\208\184. RCLootCouncil \208\189\208\181 \208\177\209\131\208\180\208\181\209\130 \208\189\208\184\209\135\208\181\208\179\208\190 \208\183\208\176\208\191\208\184\209\129\209\139\208\178\208\176\209\130\209\140 \208\181\209\129\208\187\208\184 \208\190\209\130\208\186\208\187\209\142\209\135\208\181\208\189\208\190." -- Needs review
-- L["Enable Timeout"] = ""
-- L["enable_timeout_desc"] = ""
-- L["Enter your note:"] = ""
-- L["EQdkp-Plus XML output, tailored for Enjin import."] = ""
-- L["Everyone have voted"] = ""
-- L["Export"] = ""
-- L["Filter"] = ""
-- L["Following winners was registered:"] = ""
L["Free"] = "\208\145\208\181\209\129\208\191\208\187\208\176\209\130\208\189\208\190" -- Needs review
-- L["From:"] = ""
L["g1"] = "\208\1911" -- Needs review
L["g2"] = "\208\1912" -- Needs review
-- L["General"] = ""
-- L["General options"] = ""
L["Greed"] = "\208\157\208\181 \208\190\209\130\208\186\208\176\208\182\209\131\209\129\209\140" -- Needs review
-- L["Group"] = ""
-- L["Group Council Members"] = ""
L["group_council_members_desc"] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\185\209\130\208\181 \209\141\209\130\208\190, \209\135\209\130\208\190\208\177\209\139 \208\180\208\190\208\177\208\176\208\178\208\184\209\130\209\140 \209\135\208\187\208\181\208\189\208\190\208\178 \209\129\208\190\208\178\208\181\209\130\208\176 \209\129 \208\180\209\128\209\131\208\179\208\190\208\179\208\190 \209\129\208\181\209\128\208\178\208\181\209\128\208\176 \208\184\208\187\208\184 \208\179\208\184\208\187\209\140\208\180\208\184\208\184." -- Needs review
L["group_council_members_head"] = "\208\148\208\190\208\177\208\176\208\178\208\184\209\130\209\140 \209\135\208\187\208\181\208\189\208\176 \209\129\208\190\208\178\208\181\209\130\208\176 \208\184\208\183 \209\130\208\181\208\186\209\131\209\137\208\181\208\185 \208\179\209\128\209\131\208\191\208\191\209\139." -- Needs review
-- L["Guild"] = ""
-- L["Guild Council Members"] = ""
L["Healer"] = "\208\166\208\181\208\187\208\184\209\130\208\181\208\187\209\140" -- Needs review
L["help"] = "\208\191\208\190\208\188\208\190\209\137\209\140" -- Needs review
L["Hide Votes"] = "\208\161\208\186\209\128\209\139\209\130\209\140 \208\147\208\190\208\187\208\190\209\129\208\176" -- Needs review
L["hide_votes_desc"] = "\208\162\208\190\208\187\209\140\208\186\208\190 \208\191\209\128\208\190\208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\178\209\136\208\184\208\181 \208\184\208\179\209\128\208\190\208\186\208\184 \208\188\208\190\208\179\209\131\209\130 \208\178\208\184\208\180\208\181\209\130\209\140 \209\128\208\181\208\183\209\131\208\187\209\140\209\130\208\176\209\130\209\139 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\209\143"
L["history"] = "\208\184\209\129\209\130\208\190\209\128\208\184\209\143" -- Needs review
-- L["ignore_input_desc"] = ""
-- L["ignore_input_usage"] = ""
-- L["Ignore List"] = ""
-- L["ignore_list_desc"] = ""
-- L["Ignore Options"] = ""
-- L["ignore_options_desc"] = ""
L["ilvl"] = "\208\184\208\187\208\178\208\187" -- Needs review
L["ilvl: x"] = "\208\184\208\187\208\178\208\187: %d" -- Needs review
L[" is not active in this raid."] = "\208\189\208\181 \209\131\209\135\208\176\209\129\209\130\208\178\209\131\208\181\209\130 \208\178 \209\130\208\181\208\186\209\131\209\137\208\181\208\188 \209\128\208\181\208\185\208\180\208\181." -- Needs review
-- L["Item"] = ""
-- L["Item has been awarded"] = ""
-- L["Item received and added from 'player'"] = ""
-- L["Item(s) replaced:"] = ""
L["Items under consideration:"] = "\208\159\209\128\208\181\208\180\208\188\208\181\209\130\209\139, \208\190\208\182\208\184\208\180\208\176\209\142\209\137\208\184\208\181 \209\128\208\176\209\129\209\129\208\188\208\190\209\130\209\128\208\181\208\189\208\184\209\143:" -- Needs review
-- L["Latest item(s) won"] = ""
-- L["leaderUsage_desc"] = ""
-- L["Length"] = ""
-- L["Log"] = ""
-- L["log_desc"] = ""
L["Loot announced, waiting for answer"] = "\208\148\208\190\208\177\209\139\209\135\208\176 \208\190\208\177\209\138\209\143\208\178\208\187\208\181\208\189\208\176, \208\190\208\182\208\184\208\180\208\176\208\189\208\184\208\181 \208\190\209\130\208\178\208\181\209\130\208\176" -- Needs review
-- L["Looted items to award later"] = ""
-- L["Loot Everything"] = ""
-- L["loot_everything_desc"] = ""
-- L["Loot History"] = ""
-- L["loot_history_desc"] = ""
-- L["Looting options"] = ""
-- L["Loot won:"] = ""
L["Lower Quality Limit"] = "\208\157\208\184\208\182\208\189\209\143\209\143 \208\147\209\128\208\176\208\189\208\184\209\134\208\176 \208\154\208\176\209\135\208\181\209\129\209\130\208\178\208\176" -- Needs review
L["lower_quality_limit_desc"] = "\208\146\209\139\208\177\208\181\209\128\208\184\209\130\208\181 \208\189\208\184\208\182\208\189\208\184\208\185 \208\191\209\128\208\181\208\180\208\181\208\187 \208\186\208\176\209\135\208\181\209\129\209\130\208\178\208\176 \208\180\208\187\209\143 \208\176\208\178\209\130\208\190\209\128\208\176\209\129\208\191\209\128\208\181\208\180\208\181\208\187\208\181\208\189\208\184\209\143 (\209\141\209\130\208\190 \208\186\208\176\209\135\208\181\209\129\209\130\208\178\208\190 \208\178\208\186\208\187\209\142\209\135\208\176\208\181\209\130\209\129\209\143!).\
\208\159\209\128\208\184\208\188\208\181\209\135\208\176\208\189\208\184\208\181: \208\173\209\130\208\190 \208\190\209\130\208\188\208\181\208\189\209\143\208\181\209\130 \208\189\208\190\209\128\208\188\208\176\208\187\209\140\208\189\209\139\208\185 \208\191\208\190\209\128\208\190\208\179 \208\187\209\131\209\130\208\176."
L["Mainspec/Need"] = "\208\158\209\129\208\189\208\190\208\178\208\189\208\190\208\185 \209\129\208\191\208\181\208\186/\208\157\209\131\208\182\208\189\208\190" -- Needs review
-- L["Master Looter"] = ""
-- L["master_looter_desc"] = ""
-- L["Message"] = ""
-- L["message_desc"] = ""
-- L["Minimize in combat"] = ""
L["Minor Upgrade"] = "\208\157\208\181\208\183\208\189\208\176\209\135\208\184\209\130\208\181\208\187\209\140\208\189\208\190\208\181 \209\131\208\187\209\131\209\135\209\136\208\181\208\189\208\184\208\181" -- Needs review
L["ML sees voting"] = "\208\156\208\155 \208\178\208\184\208\180\208\184\209\130 \209\128\208\181\208\183\209\131\208\187\209\140\209\130\208\176\209\130\209\139 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\209\143" -- Needs review
-- L["ml_sees_voting_desc"] = ""
-- L["Modules"] = ""
-- L["More Info"] = ""
-- L["more_info_desc"] = ""
L["Multi Vote"] = "\208\156\208\189\208\190\208\182\208\181\209\129\209\130\208\178\208\181\208\189\208\189\208\190\208\181 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\208\181"
-- L["multi_vote_desc"] = ""
-- L["Name"] = ""
-- L["'n days' ago"] = ""
L["Need"] = "\208\157\209\131\208\182\208\189\208\190" -- Needs review
-- L["Never use RCLootCouncil"] = ""
L["No"] = "\208\157\208\181\209\130" -- Needs review
-- L["No (dis)enchanters found"] = ""
-- L["No entries in the Loot History"] = ""
-- L["No items to award later registered"] = ""
L["None"] = "\208\157\208\184\208\186\209\130\208\190" -- Needs review
-- L["No session running"] = ""
L["Not announced"] = "\208\157\208\181 \208\176\208\189\208\190\208\189\209\129\208\184\209\128\208\190\208\178\208\176\208\189\208\189\208\190"
-- L["Not cached, please reopen."] = ""
-- L["Note"] = ""
-- L["Note: Huge exports will cause lag."] = ""
-- L["Notes"] = ""
-- L["notes_desc"] = ""
-- L["Not Found"] = ""
-- L["Not installed"] = ""
-- L["Now handles looting"] = ""
-- L["No winners registered"] = ""
-- L["Number of buttons"] = ""
-- L["number_of_buttons_desc"] = ""
L["Number of reasons"] = "\208\154\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190 \208\191\209\128\208\184\209\135\208\184\208\189" -- Needs review
-- L["number_of_reasons_desc"] = ""
-- L["Number of responses"] = ""
-- L["Observe"] = ""
-- L["observe_desc"] = ""
-- L["Officer"] = ""
L["Offline or RCLootCouncil not installed"] = "\208\146\209\139\209\136\208\181\208\187 \208\184\208\183 \209\129\208\181\209\130\208\184 \208\184\208\187\208\184 RCLootCouncil \208\189\208\181 \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189" -- Needs review
L["Offspec/Greed"] = "\208\158\209\132\209\132\209\129\208\191\208\181\208\186/\208\157\208\181 \208\190\209\130\208\186\208\176\208\182\209\131\209\129\209\140" -- Needs review
-- L["Only use in raids"] = ""
-- L["onlyUseInRaids_desc"] = ""
L["open"] = "\208\190\209\130\208\186\209\128\209\139\209\130\209\140" -- Needs review
-- L["Open the Loot History"] = ""
-- L["open_the_loot_history_desc"] = ""
-- L["Party"] = ""
L["Pass"] = "\208\159\208\176\209\129" -- Needs review
-- L["'player' has asked you to reroll"] = ""
-- L["'player' has ended the session"] = ""
-- L["&p was awarded with &i for &r!"] = ""
-- L["Raid"] = ""
-- L["Raid Warning"] = ""
-- L["Rank"] = ""
-- L["Raw lua output. Doesn't work well with date selection."] = ""
-- L["RCLootCouncil Loot Frame"] = ""
-- L["RCLootCouncil Loot History"] = ""
-- L["RCLootCouncil Session Setup"] = ""
-- L["RCLootCouncil Version Checker"] = ""
-- L["RCLootCouncil Voting Frame"] = ""
-- L["Reannounce ..."] = ""
L["Reason"] = "\208\159\209\128\208\184\209\135\208\184\208\189\208\176" -- Needs review
-- L["reason_desc"] = ""
-- L["Remove All"] = ""
-- L["remove_all_desc"] = ""
-- L["Remove from consideration"] = ""
-- L["reset"] = ""
-- L["reset_announce_to_default_desc"] = ""
-- L["reset_buttons_to_default_desc"] = ""
-- L["Reset Skin"] = ""
-- L["reset_skin_desc"] = ""
-- L["Reset skins"] = ""
-- L["reset_skins_desc"] = ""
L["Reset to default"] = "\208\146\208\190\209\129\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\209\140 \208\191\208\190 \209\131\208\188\208\190\208\187\209\135\208\176\208\189\208\184\209\142" -- Needs review
-- L["reset_to_default_desc"] = ""
-- L["Response"] = ""
-- L["Response color"] = ""
-- L["response_color_desc"] = ""
-- L["Responses from Chat"] = ""
-- L["responses_from_chat_desc"] = ""
-- L["Role"] = ""
-- L["Roll"] = ""
-- L["Save Skin"] = ""
-- L["save_skin_desc"] = ""
-- L["Say"] = ""
L["Self Vote"] = "\208\161\208\178\208\190\209\145 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\208\181"
-- L["self_vote_desc"] = ""
-- L["Send History"] = ""
-- L["send_history_desc"] = ""
-- L["Sent whisper help to 'player'"] = ""
-- L["session_error"] = ""
-- L["Set the text for button i's response."] = ""
-- L["Set the text on button 'number'"] = ""
-- L["Set the whisper keys for button i."] = ""
-- L["Silent Auto Pass"] = ""
-- L["silent_auto_pass_desc"] = ""
-- L["Simple BBCode output."] = ""
-- L["Skins"] = ""
-- L["skins_description"] = ""
L["Something went wrong :'("] = "\208\167\209\130\208\190-\209\130\208\190 \208\191\208\190\209\136\208\187\208\190 \208\189\208\181 \209\130\208\176\208\186 :'(" -- Needs review
-- L["Standard .csv output."] = ""
L["Start"] = "\208\157\208\176\209\135\208\176\209\130\209\140" -- Needs review
-- L["Status texts"] = ""
L["Tank"] = "\208\162\208\176\208\189\208\186" -- Needs review
L["test"] = "\209\130\208\181\209\129\209\130" -- Needs review
L["Test"] = "\208\162\208\181\209\129\209\130" -- Needs review
-- L["test_desc"] = ""
L["Text color"] = "\208\166\208\178\208\181\209\130 \209\130\208\181\208\186\209\129\209\130\208\176" -- Needs review
-- L["text_color_desc"] = ""
L["Text for reason #i"] = "\208\162\208\181\208\186\209\129\209\130 \208\191\209\128\208\184\209\135\208\184\208\189\209\139 #" -- Needs review
-- L["The following council members have voted"] = ""
-- L["The item would now be awarded to 'player'"] = ""
-- L["The loot is already on the list"] = ""
L["The Master Looter doesn't allow multiple votes."] = "\208\158\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\181\208\189\208\189\209\139\208\185 \208\183\208\176 \208\180\208\190\208\177\209\139\209\135\209\131 \208\189\208\181 \209\128\208\176\208\183\209\128\208\181\209\136\208\184\208\187 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\208\181 \208\183\208\176 \208\189\208\181\209\129\208\186\208\190\208\187\209\140\208\186\208\184\209\133." -- Needs review
L["The Master Looter doesn't allow votes for yourself."] = "\208\158\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\181\208\189\208\189\209\139\208\185 \208\183\208\176 \208\180\208\190\208\177\209\139\209\135\209\131 \208\189\208\181 \209\128\208\176\208\183\209\128\208\181\209\136\208\184\208\187 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\209\130\209\140 \208\183\208\176 \209\129\208\181\208\177\209\143." -- Needs review
-- L["The session has ended."] = ""
L["This item"] = "\208\173\209\130\208\190\209\130 \208\191\209\128\208\181\208\180\208\188\208\181\209\130" -- Needs review
L["This item has been awarded"] = "\208\173\209\130\208\190\209\130 \208\191\209\128\208\181\208\180\208\188\208\181\209\130 \208\177\209\139\208\187 \208\178\209\128\209\131\209\135\208\181\208\189" -- Needs review
-- L["Time"] = ""
-- L["Time left (num seconds)"] = ""
-- L["Timeout"] = ""
-- L["Total items received:"] = ""
-- L["Total items won:"] = ""
-- L["Totals"] = ""
-- L["tVersion_outdated_msg"] = ""
-- L["Unable to give 'item' to 'player' - (player offline, left group or instance?)"] = ""
-- L["Unable to give out loot without the loot window open."] = ""
L["Unguilded"] = "\208\157\208\181 \208\178 \208\179\208\184\208\187\209\140\208\180\208\184\208\184" -- Needs review
-- L["Unknown"] = ""
-- L["Unknown/Chest"] = ""
-- L["Unknown date"] = ""
-- L["Unvote"] = ""
L["Upper Quality Limit"] = "\208\155\208\184\208\188\208\184\209\130 \209\131\208\187\209\131\209\135\209\136\208\181\208\189\208\184\209\143 \208\186\208\176\209\135\208\181\209\129\209\130\208\178\208\176"
-- L["upper_quality_limit_desc"] = ""
-- L["Usage"] = ""
-- L["Usage Options"] = ""
L["version"] = "\208\178\208\181\209\128\209\129\208\184\209\143" -- Needs review
-- L["Version"] = ""
-- L["Version Check"] = ""
-- L["version_check_desc"] = ""
-- L["version_outdated_msg"] = ""
-- L["Vote"] = ""
-- L["Voters"] = ""
-- L["Votes"] = ""
L["Voting options"] = "\208\158\208\191\209\134\208\184\208\184 \208\179\208\190\208\187\208\190\209\129\208\190\208\178\208\176\208\189\208\184\209\143"
-- L["Waiting for item info"] = ""
-- L["Waiting for response"] = ""
L["whisper"] = "\209\136\208\181\208\191\208\190\209\130" -- Needs review
-- L["whisper_guide"] = ""
-- L["whisper_guide2"] = ""
L["whisper_help"] = "\208\160\208\181\208\185\208\180\208\181\209\128\209\139 \208\188\208\190\208\179\209\131\209\130 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \209\129\208\184\209\129\209\130\208\181\208\188\209\131 \208\187\208\184\209\135\208\189\209\139\209\133 \209\129\208\190\208\190\208\177\209\137\208\181\208\189\208\184\208\185, \208\178 \209\129\208\187\209\131\209\135\208\176\208\181 \208\181\209\129\208\187\208\184 \208\186\209\130\208\190-\209\130\208\190 \208\189\208\181 \208\184\208\188\208\181\208\181\209\130 \208\176\208\180\208\180\208\190\208\189\208\176.\
\208\168\208\181\208\191\208\189\209\131\208\178 \"rchelp\" \208\190\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\181\208\189\208\189\208\190\208\188\209\131 \208\183\208\176 \208\180\208\190\208\177\209\139\209\135\209\131, \208\190\208\189\208\184 \208\191\208\190\208\187\209\131\209\135\208\176\209\130 \209\129\208\191\208\184\209\129\208\190\208\186 \208\186\208\187\209\142\209\135\208\181\208\178\209\139\209\133 \209\129\208\187\208\190\208\178, \208\186\208\190\209\130\208\190\209\128\209\139\208\185 \208\188\208\190\208\182\208\181\209\130 \208\177\209\139\209\130\209\140 \208\184\208\183\208\188\208\181\208\189\208\181\208\189 \208\178 \208\188\208\181\208\189\209\142 \"\208\154\208\189\208\190\208\191\208\186\208\184 \208\184 \208\158\209\130\208\178\208\181\209\130\209\139\".\
\208\158\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\181\208\189\208\189\208\190\208\188\209\131 \208\183\208\176 \208\180\208\190\208\177\209\139\209\135\209\131 \209\128\208\181\208\186\208\190\208\188\208\181\208\189\208\180\209\131\208\181\209\130\209\129\209\143 \208\178\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \"\208\144\208\189\208\190\208\189\209\129 \208\161\208\190\208\190\208\177\209\137\208\181\208\189\208\184\208\185\" \208\180\208\187\209\143 \208\186\208\176\208\182\208\180\208\190\208\179\208\190 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176, \208\191\208\190\209\130\208\190\208\188\209\131 \209\135\209\130\208\190 \208\189\208\190\208\188\208\181\209\128 \208\186\208\176\208\182\208\180\208\190\208\179\208\190 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176 \208\189\208\181\208\190\208\177\209\133\208\190\208\180\208\184\208\188 \208\180\208\187\209\143 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\208\189\208\184\209\143 \209\129\208\184\209\129\209\130\208\181\208\188\209\139 \208\187\208\184\209\135\208\189\209\139\209\133 \209\129\208\190\208\190\208\177\209\137\208\181\208\189\208\184\208\185.\
\208\159\209\128\208\184\208\188\208\181\209\135\208\176\208\189\208\184\208\181: \208\155\209\142\208\180\209\143\208\188 \209\129\208\187\208\181\208\180\209\131\208\181\209\130 \209\131\209\129\209\130\208\176\208\189\208\176\208\178\208\187\208\184\208\178\208\176\209\130\209\140 \208\176\208\180\208\180\208\190\208\189, \208\178 \208\191\209\128\208\190\209\130\208\184\208\178\208\189\208\190\208\188 \209\129\208\187\209\131\209\135\208\176\208\181 \208\190\208\177 \208\184\208\179\209\128\208\190\208\186\208\181 \208\177\209\131\208\180\208\181\209\130 \208\180\208\190\209\129\209\130\209\131\208\191\208\189\208\176 \208\189\208\181 \208\178\209\129\209\143 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\143." -- Needs review
-- L["whisperKey_greed"] = ""
-- L["whisperKey_minor"] = ""
-- L["whisperKey_need"] = ""
-- L["Windows reset"] = ""
-- L["winners"] = ""
-- L["x days"] = ""
-- L["x out of x have voted"] = ""
-- L["Yell"] = ""
L["Yes"] = "\208\148\208\176" -- Needs review
L["You are not allowed to see the Voting Frame right now."] = "\208\146\209\139 \208\189\208\181 \208\188\208\190\208\182\208\181\209\130\208\181 \208\178\208\184\208\180\208\181\209\130\209\140 \208\190\208\186\208\189\208\190 \208\179\208\190\208\187\208\190\208\178\208\176\208\189\208\184\209\143 \208\191\209\128\209\143\208\188\208\190 \209\129\208\181\208\185\209\135\208\176\209\129." -- Needs review
L[" you are now the Master Looter and RCLootCouncil is now handling looting."] = "\208\178\209\139 \209\130\208\181\208\191\208\181\209\128\209\140 \208\158\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\181\208\189\208\189\209\139\208\185 \208\183\208\176 \208\148\208\190\208\177\209\139\209\135\209\131 \208\184 RCLootCouncil \209\130\208\181\208\191\208\181\209\128\209\140 \208\183\208\176\208\189\208\184\208\188\208\176\208\181\209\130\209\129\209\143 \209\128\208\176\209\129\208\191\209\128\208\181\208\180\208\181\208\187\208\181\208\189\208\184\208\181\208\188 \208\180\208\190\208\177\209\139\209\135\208\184." -- Needs review
-- L["You cannot initiate a test while in a group without being the MasterLooter."] = ""
-- L["You cannot start an empty session."] = ""
-- L["You cannot use the menu when the session has ended."] = ""
-- L["You cannot use this command without being the Master Looter"] = ""
-- L["You can only auto award items with a quality lower than 'quality' to yourself due to Blizaard restrictions"] = ""
-- L["You can't start a loot session while in combat."] = ""
-- L["You can't start a session before all items are loaded!"] = ""
-- L["You haven't set a council! You can edit your council by typing '/rc council'"] = ""
-- L["You're already running a session."] = ""
-- L["Your note:"] = ""

