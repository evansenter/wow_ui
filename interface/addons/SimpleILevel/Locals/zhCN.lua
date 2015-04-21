local L = LibStub("AceLocale-3.0"):NewLocale("SimpleILevel", "zhCN");

if not L then return end

L.core = {
	ageDays = "%s天",
	ageHours = "%s小时",
	ageMinutes = "%s分钟",
	ageSeconds = "%s秒",
	desc = "提示栏显示其它玩家的平均物品等级",
	load = "载入版本 %s",
	minimapClick = "Simple iLevel - 点击取得细节",
	minimapClickDrag = "拖动以迁移图标",
	name = "Simple iLevel",
	purgeNotification = "清除缓存内的%s人",
	purgeNotificationFalse = "你未设置自动清除",
	scoreDesc = "这是您所有已装备物品的平均物品等级。",
	scoreYour = "您的数值 %s",
	slashClear = "清除设置",
	slashGetScore = "%s的平均物品等级为%s（%s前）",
	slashGetScoreFalse = "抱歉，获取%s的数值时发生错误",
	slashTargetScore = "%s的平均物品等级为%s",
	slashTargetScoreFalse = "抱歉，建构数值时发生错误",
	ttAdvanced = "%s前",
	ttLeft = "平均物品等级：",
	options = {
		autoscan = "自动扫描",
		autoscanDesc = "切换自动扫描队伍、团体变化",
		clear = "清除设置",
		clearDesc = "清除所有设置与缓存",
		color = "上色数值",
		colorDesc = "适时上色平均物品等级，若您只想看到白色或灰色的数值请禁用。",
		get = "获取数值",
		getDesc = "获取已记录玩家的平均物品等级",
		ldb = "LDB选项",
		ldbRefresh = "刷新频率",
		ldbRefreshDesc = "LDB将几秒刷新一次",
		ldbSource = "LDB来源标签",
		ldbSourceDesc = "显示LDB数值来源的标签",
		ldbText = "LDB文字",
		ldbTextDesc = "切换打開LDB，或可节省些资源",
		maxAge = "最长缓存时间",
		maxAgeDesc = "设置检查间隔时间（分钟）",
		minimap = "显示小地图按钮",
		minimapDesc = "切换显示小地图按钮",
		modules = "载入模块",
		modulesDesc = "您需重载插件使改动生效，以/rl或/console reloadui指令。",
		name = "SiL选项",
		open = "打开选项页面",
		options = "选项",
		paperdoll = "显示于人物信息",
		paperdollDesc = "在人物信息窗口属性栏显示平均物品等级。",
		purge = "清除缓存",
		purgeAuto = "自动清除缓存",
		purgeAutoDesc = "自动清除#天前的缓存，0为从不清除",
		purgeDesc = "清除所有超过%s天的人物缓存",
		purgeError = "请输入天数",
		round = "四舍五入",
		roundDesc = "四舍五入数值到整数",
		target = "获取目标数值",
		targetDesc = "获取目标的平均物品等级",
		ttAdvanced = "高级提示栏",
		ttAdvancedDesc = "切换显示检查间隔时间",
		ttCombat = "战斗时显示",
		ttCombatDesc = "战斗时于提示栏显示SiL信息",
	},
}
L.group = {
	addonName = "Simple iLevel - 团体",
	desc = "查看团体所有人的平均物品等级",
	load = "团体模块已加载",
	name = "SiL团体",
	nameShort = "团体",
	outputHeader = "团体平均%s",
	outputNoScore = "%s（未能取得）",
	outputRough = "*表示约略的数值",
	options = {
		group = "团体数值",
		groupDesc = "发布团体数值到<%s>",
	},
}
L.resil = {
	addonName = "Simple iLevel - 韧性",
	desc = "于提示栏显示其他玩家装备几件PvP装备",
	load = "韧性模块已加载",
	name = "SiL韧性",
	nameShort = "韧性",
	outputHeader = "团体PvP装备%s",
	outputNoScore = "%s不可用",
	outputRough = "*表示约略的数值",
	ttPaperdoll = "您%s/%s件装备加总韧性为%s。",
	ttPaperdollFalse = "你当前未装备任何PvP物品。",
	options = {
		cinfo = "显示于在人物信息",
		cinfoDesc = "于属性栏显示您的SiL韧性数值",
		group = "团体PvP数值",
		groupDesc = "发布团体PvP数值到<%s>",
		name = "SiL韧性选项",
		pvpDesc = "在您的团体显示任何有PvP装备的人。",
		ttType = "提示类型",
		ttZero = "无PvP装备也显示",
		ttZeroDesc = "即使无PvP装备也于提示栏显示信息。",
	},
}
L.social = {
	addonName = "Simple iLevel - 社交",
	desc = "于聊天窗体各频道加入平均物品等级",
	load = "社交模块已加载",
	name = "SiL社交",
	nameShort = "社交",
	options = {
		chatEvents = "显示数值于：",
		color = "上色数值",
		colorDesc = "于聊天窗体上色数值",
		enabled = "启用",
		enabledDesc = "启用所有SiL社交功能",
		name = "SiL社交选项",
	},
}


