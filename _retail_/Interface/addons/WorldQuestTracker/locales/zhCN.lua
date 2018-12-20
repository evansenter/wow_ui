local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestTrackerAddon", "zhCN") 
if not L then return end 

L["S_APOWER_AVAILABLE"] = "可用的"
L["S_APOWER_NEXTLEVEL"] = "下一等级"
L["S_DECREASESIZE"] = "减少尺寸"
L["S_ENABLED"] = "已启用"
L["S_ERROR_NOTIMELEFT"] = "此任务已过期。"
L["S_ERROR_NOTLOADEDYET"] = "这个任务还没有被加载，请稍候。"
--[[Translation missing --]]
--[[ L["S_FACTION_TOOLTIP_SELECT"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_FACTION_TOOLTIP_TRACK"] = ""--]] 
L["S_FLYMAP_SHOWTRACKEDONLY"] = "仅被追踪"
L["S_FLYMAP_SHOWTRACKEDONLY_DESC"] = "仅显示正在被追踪的任务"
L["S_FLYMAP_SHOWWORLDQUESTS"] = "显示世界任务"
L["S_GROUPFINDER_ACTIONS_CANCEL_APPLICATIONS"] = "点击取消申请…"
L["S_GROUPFINDER_ACTIONS_CANCELING"] = "取消中…"
L["S_GROUPFINDER_ACTIONS_CREATE"] = "未找到队伍？点击创建"
L["S_GROUPFINDER_ACTIONS_CREATE_DIRECT"] = "创建队伍"
L["S_GROUPFINDER_ACTIONS_LEAVEASK"] = "离开队伍吗？"
L["S_GROUPFINDER_ACTIONS_LEAVINGIN"] = "离开队伍（单击立即离开）："
L["S_GROUPFINDER_ACTIONS_RETRYSEARCH"] = "重新搜索"
L["S_GROUPFINDER_ACTIONS_SEARCH"] = "单击开始搜索队伍"
L["S_GROUPFINDER_ACTIONS_SEARCH_RARENPC"] = "寻找队伍击杀稀有"
L["S_GROUPFINDER_ACTIONS_SEARCH_TOOLTIP"] = "加入队伍做此任务"
L["S_GROUPFINDER_ACTIONS_SEARCHING"] = "搜索中…"
L["S_GROUPFINDER_ACTIONS_SEARCHMORE"] = "点击寻找更多队伍成员"
L["S_GROUPFINDER_ACTIONS_SEARCHOTHER"] = "离开并搜索其他的队伍？"
L["S_GROUPFINDER_ACTIONS_UNAPPLY1"] = "点击移除申请，以便于我们可以创建新队伍"
L["S_GROUPFINDER_ACTIONS_UNLIST"] = "点击后不列出你的队伍"
L["S_GROUPFINDER_ACTIONS_UNLISTING"] = "不列出…"
L["S_GROUPFINDER_ACTIONS_WAITING"] = "等待中…"
L["S_GROUPFINDER_AUTOOPEN_RARENPC_TARGETED"] = "目标为稀有怪物时自动打开"
L["S_GROUPFINDER_ENABLED"] = "新任务时自动启用"
L["S_GROUPFINDER_LEAVEOPTIONS"] = "离开队伍选项"
L["S_GROUPFINDER_LEAVEOPTIONS_AFTERX"] = "X 秒后离开"
L["S_GROUPFINDER_LEAVEOPTIONS_ASKX"] = "不自动离开，只提示 X 秒"
L["S_GROUPFINDER_LEAVEOPTIONS_DONTLEAVE"] = "不显示离开面板"
L["S_GROUPFINDER_LEAVEOPTIONS_IMMEDIATELY"] = "任务完成时立即离开队伍"
L["S_GROUPFINDER_NOPVP"] = "避开 PVP 服务器"
L["S_GROUPFINDER_OT_ENABLED"] = "任务追踪上显示按钮"
L["S_GROUPFINDER_QUEUEBUSY"] = "你已经在队列中。"
L["S_GROUPFINDER_QUEUEBUSY2"] = "不显示团队查找器窗口：已在队伍或查找时。"
L["S_GROUPFINDER_RESULTS_APPLYING"] = "有 %d 个剩余的队伍，请再点击一次"
L["S_GROUPFINDER_RESULTS_APPLYING1"] = "有1个剩余的队伍可加入，请再点击一次"
L["S_GROUPFINDER_RESULTS_FOUND"] = [=[找到 %d 个队伍
点击开始加入]=]
L["S_GROUPFINDER_RESULTS_FOUND1"] = [=[找到1个队伍
点击开始加入]=]
L["S_GROUPFINDER_RESULTS_UNAPPLY"] = "%d 个剩余申请…"
L["S_GROUPFINDER_RIGHTCLICKCLOSE"] = "右击关闭"
L["S_GROUPFINDER_SECONDS"] = "秒"
L["S_GROUPFINDER_TITLE"] = "队伍寻找"
L["S_GROUPFINDER_TUTORIAL1"] = "加入队伍完成相同任务能更快的完成世界任务！"
L["S_INCREASESIZE"] = "增加尺寸"
L["S_MAPBAR_FILTER"] = "过滤"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES"] = "阵营目标"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES_DESC"] = "始终显示阵营任务即使他们已被过滤。"
L["S_MAPBAR_OPTIONS"] = "选项"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED"] = "箭头更新速度"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_HIGH"] = "快"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_MEDIUM"] = "中"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_REALTIME"] = "实时时间"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_SLOW"] = "慢"
L["S_MAPBAR_OPTIONSMENU_EQUIPMENTICONS"] = "装备图标"
L["S_MAPBAR_OPTIONSMENU_QUESTTRACKER"] = "启用任务追踪"
L["S_MAPBAR_OPTIONSMENU_REFRESH"] = "刷新"
L["S_MAPBAR_OPTIONSMENU_SOUNDENABLED"] = "启用声音"
L["S_MAPBAR_OPTIONSMENU_STATUSBARANCHOR"] = "顶部锚点"
L["S_MAPBAR_OPTIONSMENU_TOMTOM_WPPERSISTENT"] = "路径点持续"
L["S_MAPBAR_OPTIONSMENU_TRACKER_CURRENTZONE"] = "只限当前地区"
L["S_MAPBAR_OPTIONSMENU_TRACKER_SCALE"] = "跟踪缩放：%s"
L["S_MAPBAR_OPTIONSMENU_TRACKERCONFIG"] = "追踪配置"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_AUTO"] = "自动位置"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_CUSTOM"] = "自定义位置"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_LOCKED"] = "已锁定"
L["S_MAPBAR_OPTIONSMENU_UNTRACKQUESTS"] = "停止追踪所有任务"
L["S_MAPBAR_OPTIONSMENU_WORLDMAPCONFIG"] = "世界地图配置"
L["S_MAPBAR_OPTIONSMENU_YARDSDISTANCE"] = "显示码数距离"
L["S_MAPBAR_OPTIONSMENU_ZONE_QUESTSUMMARY"] = "显示任务概况"
L["S_MAPBAR_OPTIONSMENU_ZONEMAPCONFIG"] = "区域地图配置"
L["S_MAPBAR_RESOURCES_TOOLTIP_TRACKALL"] = "点击追踪所有：|cFFFFFFFF%s|r任务。"
L["S_MAPBAR_SORTORDER"] = "分类排序"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_FADE"] = "消退任务"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_OPTION"] = "小于%d小时"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SHOWTEXT"] = "剩余时间文本"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SORTBYTIME"] = "以时间排序"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_TITLE"] = "剩余时间"
L["S_MAPBAR_SUMMARY"] = "汇总"
L["S_MAPBAR_SUMMARYMENU_ACCOUNTWIDE"] = "账号汇总"
L["S_MAPBAR_SUMMARYMENU_MOREINFO"] = "点击显示更多信息"
L["S_MAPBAR_SUMMARYMENU_NOATTENTION"] = [=[你其他角色正在追踪任务的
剩余时限没有小于两小时的。]=]
L["S_MAPBAR_SUMMARYMENU_REQUIREATTENTION"] = "请注意"
L["S_MAPBAR_SUMMARYMENU_TODAYREWARDS"] = "今日奖励"
--[[Translation missing --]]
--[[ L["S_MAPFRAME_ALIGN_CENTER"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_MAPFRAME_ALIGN_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_MAPFRAME_ALIGN_LEFT"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_ANIMATIONS"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_MAPFRAME_ALIGN"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_MAPFRAME_ERROR_SCALING_DISABLED"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_MAPFRAME_SCALE"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_MAPFRAME_SCALE_ENABLED"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_QUESTBLACKLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_RESET"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_SHOWFACTIONS"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_TIMELEFT_NOPRIORITY"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_TRACKER_RESETPOSITION"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_WORLD_ANCHOR_LEFT"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_WORLD_ANCHOR_RIGHT"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_WORLD_DECREASEICONSPERROW"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_WORLD_INCREASEICONSPERROW"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_WORLD_ORGANIZE_BYMAP"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_WORLD_ORGANIZE_BYTYPE"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_OPTIONS_ZONE_SHOWONLYTRACKED"] = ""--]] 
L["S_OVERALL"] = "全部"
L["S_PARTY"] = "队伍"
L["S_PARTY_DESC1"] = "任务有蓝色星星的代表全部队友有此任务。"
L["S_PARTY_DESC2"] = "如果红星显示，队友没有世界任务资格或者还没有安装 WQT。"
L["S_PARTY_PLAYERSWITH"] = "队伍中使用 WQT 的玩家："
L["S_PARTY_PLAYERSWITHOUT"] = "队伍中没有使用 WQT 的玩家："
L["S_QUESTSCOMPLETED"] = "已经完成的任务"
L["S_QUESTTYPE_ARTIFACTPOWER"] = "神器能量"
L["S_QUESTTYPE_DUNGEON"] = "地下城"
L["S_QUESTTYPE_EQUIPMENT"] = "装备"
L["S_QUESTTYPE_GOLD"] = "金币"
L["S_QUESTTYPE_PETBATTLE"] = "宠物对战"
L["S_QUESTTYPE_PROFESSION"] = "专业"
L["S_QUESTTYPE_PVP"] = "PvP"
L["S_QUESTTYPE_RESOURCE"] = "资源"
L["S_QUESTTYPE_TRADESKILL"] = "商业技能"
L["S_RAREFINDER_ADDFROMPREMADE"] = "在预创建队伍添加已找到稀有"
L["S_RAREFINDER_NPC_NOTREGISTERED"] = "稀有不在数据库中"
L["S_RAREFINDER_OPTIONS_ENGLISHSEARCH"] = "总是使用英语查找"
L["S_RAREFINDER_OPTIONS_SHOWICONS"] = "激活稀有显示图标"
L["S_RAREFINDER_SOUND_ALWAYSPLAY"] = "音效已禁用时仍播放"
L["S_RAREFINDER_SOUND_ENABLED"] = "迷你地图出现稀有时播放音效"
L["S_RAREFINDER_SOUNDWARNING"] = "迷你地图出现稀有时已播放音效，可以在选项菜单 > 稀有查找器子菜单禁用此音效。"
L["S_RAREFINDER_TITLE"] = "稀有查找器"
L["S_RAREFINDER_TOOLTIP_REMOVE"] = "移除"
L["S_RAREFINDER_TOOLTIP_SEACHREALM"] = "在其他服务器搜索"
L["S_RAREFINDER_TOOLTIP_SPOTTEDBY"] = "发现人"
L["S_RAREFINDER_TOOLTIP_TIMEAGO"] = "分钟"
L["S_SUMMARYPANEL_EXPIRED"] = "已过期"
L["S_SUMMARYPANEL_LAST15DAYS"] = "最近15天"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_ACCOUNT"] = "账号在线时间统计"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_CHARACTER"] = "角色在线时间统计"
L["S_SUMMARYPANEL_OTHERCHARACTERS"] = "其他角色"
L["S_TUTORIAL_AMOUNT"] = "显示接收量"
L["S_TUTORIAL_CLICKTOTRACK"] = "点击追踪任务。"
--[[Translation missing --]]
--[[ L["S_TUTORIAL_MAPALIGN"] = ""--]] 
L["S_TUTORIAL_PARTY"] = "队伍中时，蓝星显示此全部队友有此任务！"
L["S_TUTORIAL_TIMELEFT"] = "显示剩余时间（大于4小时，大于90分钟，大于30分钟，小于30分钟）"
--[[Translation missing --]]
--[[ L["S_TUTORIAL_WORLDBUTTONS"] = ""--]] 
L["S_TUTORIAL_WORLDMAPBUTTON"] = "点击这个按钮将向你显示破碎群岛地图。"
L["S_UNKNOWNQUEST"] = "未知任务"
--[[Translation missing --]]
--[[ L["S_WORLDBUTTONS_SHOW_NONE"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_WORLDBUTTONS_SHOW_TYPE"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_WORLDBUTTONS_SHOW_ZONE"] = ""--]] 
--[[Translation missing --]]
--[[ L["S_WORLDBUTTONS_TOGGLE_QUESTS"] = ""--]] 
L["S_WORLDMAP_QUESTLOCATIONS"] = "显示任务位置"
L["S_WORLDMAP_QUESTSUMMARY"] = "显示任务摘要"
L["S_WORLDMAP_TOOGLEQUESTS"] = "切换任务"
--[[Translation missing --]]
--[[ L["S_WORLDMAP_TOOLTIP_TRACKALL"] = ""--]] 
L["S_WORLDQUESTS"] = "世界任务"

