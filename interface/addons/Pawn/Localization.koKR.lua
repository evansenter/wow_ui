﻿-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2016 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- Korean resources
------------------------------------------------------------

local function PawnUseThisLocalization()
PawnLocal =
{
	AsteriskTooltipLine = "|TInterface\\AddOns\\Pawn\\Textures\\Question:0|t 특별한 효과는 값에 포함되지 않습니다.",
	AverageItemLevelIgnoringRarityTooltipLine = "평균 아이템 레벨",
	BackupCommand = "backup",
	BaseValueWord = "기본",
	CopyScaleEnterName = "%s의 복사본인 새 능력치 크기의 이름을 입력하세요:",
	CorrectGemsValueCalculationMessage = "   -- 정확한 보석이 가치 있습니다: %g",
	DebugOffCommand = "debug off",
	DebugOnCommand = "debug on",
	DecimalSeparator = ".",
	DeleteScaleConfirmation = "%s|1을;를; 정말 삭제할까요? 지우면 복구할 수 없습니다. \"%s\"를 입력하여 동의:",
	DidntUnderstandMessage = "   (?) \"%s\" 이해할 수 없음.",
	EnchantedStatsHeader = "(현재 값)",
	EngineeringName = "기계공학",
	ExportAllScalesMessage = "Ctrl+C를 눌러 능력치 크기 태그를 복사하세요, 백업을 위해 컴퓨터에 파일을 만든 후 Ctrl+V로 붙여 넣으세요.",
	ExportScaleMessage = "Ctrl+C를 눌러 |cffffffff%s|r의 능력치 크기 태그를 복사하세요, Ctrl+V로 나중에 붙여넣기 하세요.",
	FailedToGetItemLinkMessage = "   툴팁에서 아이템 링크를 가져오지 못했습니다.  애드온 충돌이 원인일 수 있습니다.",
	FailedToGetUnenchantedItemMessage = "   기본 아이템 값을 가져오지 못했습니다.  애드온 충돌이 원인일 수 있습니다.",
	FoundStatMessage = "   %d %s",
	GemColorList1 = "%d %s",
	GemColorList2 = "%d %s 또는 %s",
	GemColorList3 = "%d 아무 색깔", -- Needs review
	GenericGemLink = "|Hitem:%d|h[보석 %d]|h", -- Needs review
	GenericGemName = "(보석 %d)", -- Needs review
	HiddenScalesHeader = "다른 능력치 크기",
	ImportScaleMessage = "Ctrl+V를 눌러 복사해놓은 다른 능력치 크기 태그를 여기에 붙여넣으세요:",
	ImportScaleTagErrorMessage = "Pawn은 이 능력치 크기 태그를 이해할 수 없습니다. 전체 태그를 복사했나요? 다시 복사하고 붙여넣기 해보세요:",
	ItemIDTooltipLine = "아이템 ID",
	ItemLevelTooltipLine = "아이템 레벨",
	LootUpgradeAdvisorHeader = "클릭하여 당신의 아이템과 비교합니다.|n",
	LootUpgradeAdvisorHeaderMany = "|TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t 이 아이템은 %d 능력치 크기가 업그레이드 됩니다.  클릭하여 당신의 아이템과 비교하세요.",
	MissocketWorthwhileMessage = "   -- 하지만 %s 보석만 사용하는게 낫습니다:",
	NeedNewerVgerCoreMessage = "Pawn은 VgerCore의 새로운 버전이 필요합니다. Pawn과 함께 VgerCore의 버전을 사용해주세요.",
	NewScaleDuplicateName = "같은 이름의 능력치 크기가 있습니다. 능력치 크기의 이름을 입력하세요:",
	NewScaleEnterName = "능력치 크기의 이름을 입력하세요:",
	NewScaleNoQuotes = "이름에 \" (큰 따옴표)는 포함할 수 없습니다. 능력치 크기의 이름을 입력하세요:",
	NormalizationMessage = "   -- %g로 나누어서 일반화",
	NoScale = "(없음)",
	NoScalesDescription = "시작하려면, 능력치 크기를 가져오기하거나 새로운 것으로 시작하세요.",
	NoStatDescription = "왼쪽 목록에서 능력치를 선택하세요.",
	Or = "또는",
	RenameScaleEnterName = "%s의 새 이름을 입력하세요:",
	SocketBonusValueCalculationMessage = "   -- 보석 장착 보너스가 더 낫습니다: %g",
	StatNameText = "|cffffffff%s|r 1의 가치:",
	ThousandsSeparator = ",",
	TooltipBestAnnotation = "%s  |cff8ec3e6(최상)|r",
	TooltipBestAnnotationSimple = "%s  최상",
	TooltipBigUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00 업그레이드%s|r",
	TooltipSecondBestAnnotation = "%s  |cff8ec3e6(두번째 순위)|r",
	TooltipSecondBestAnnotationSimple = "%s  두번째 순위",
	TooltipUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00+%.0f%% 업그레이드%s|r",
	TooltipUpgradeFor1H = " 한손 세트",
	TooltipUpgradeFor2H = " 양손",
	TooltipVersusLine = "%s|n  vs. |c%s%s|r",
	TotalValueMessage = "   ---- Total: %g",
	UnenchantedStatsHeader = "(기본값)",
	Unusable = "(사용불가)",
	UnusableStatMessage = "   -- %s는 사용할 수 없습니다, 중지합니다.",
	Usage = [=[Pawn by Vger-Azjol-Nerub
www.vgermods.com
 
/pawn -- Pawn UI 열기 또는 닫기
/pawn debug [ on | off ] -- 콘솔에 디버그 메시지 스팸
/pawn backup -- 모든 능력치 크기 태그 백업
 
Pawn 사용자 설정의 더 자세한 정보는, 애드온에 포함된 help 파일 (Readme.htm) 를 참고하세요.]=],
	ValueCalculationMessage = "   %g %s x %g each = %g",
	VisibleScalesHeader = "%s의 능력치 크기",
	Stats = {
		AgilityInfo = "민첩성. 몇몇 직업의 전투력을 증가시킵니다.",
		Ap = "전투력",
		ApInfo = "전투력. 대다수 아이템에 직접 붙지 않습니다. 힘이나 민첩성으로 오르는 전투력은 포함되지 않습니다.",
		ArmorInfo = "기본 방어도. 탱커용 방어구의 추가 방어도는 포함되지 않습니다.",
		ArmorTypes = "방어구 유형",
		AvoidanceInfo = "광역회피. 광역 공격으로부터 받는 피해를 줄입니다.",
		BonusArmorInfo = "추가 방어도.  모든 방어구의 기본 방어도에 포함되지 않습니다.  이 숫자는 반드시 방어도의 값만큼 높아야 합니다.",
		Cloth = "천",
		ClothInfo = "천 아이템일 경우 할당합니다.",
		Crit = "치명타",
		CritInfo = "치명타 및 극대화. 공격이나 치유 주문이 증가한 효과로 적용될 확률을 증가시킵니다.",
		DpsInfo = "무기 초당 공격력. (무기 유형 별로 DPS 값을 다르게 평가하려면, \"특별한 무기 능력치\" 항목을 참고하세요.)",
		HasteInfo = "가속. 주문 시전이나 자원 회복 속도를 증가시킵니다.",
		IndestructibleInfo = "파괴불가. 장비의 내구도 감소를 방지합니다.",
		IndestructibleIs = "|cffffffffin파괴 불가|r의 가치:",
		IntellectInfo = "지능. 몇몇 직업의 주문력을 증가시킵니다.",
		Leather = "가죽",
		LeatherInfo = "가죽 아이템일 경우 할당합니다.",
		LeechInfo = "생기흡수. 자신의 공격과 치유 주문으로 자신의 체력을 회복합니다.",
		Mail = "사슬",
		MailInfo = "사슬 아이템일 경우 할당합니다.",
		MasteryInfo = "특화력. 직업 전문화의 특별한 보너스를 향상시킵니다.",
		MetaSocket = "얼개 보석 홈",
		MetaSocketInfo = "비었거나 장착된 얼개 보석 홈.  얼개 보석의 특별한 효과가 활성화 되었는지 얼개 보석 홈이 있는 투구에 특별히 할당합니다.",
		MinorStats = "보조 능력치",
		MovementSpeedInfo = "이동 속도. 자신의 캐릭터의 달리기 속도가 빨라집니다.",
		MultistrikeInfo = "연속타격. 공격이나 치유 주문이 감소된 양으로 대상에게 두 번의 추가 적용 될 확률을 증가시킵니다.",
		Plate = "판금",
		PlateInfo = "판금 아이템일 경우 할당합니다.",
		PrimaryStats = "주 능력치",
		PvPPower = "PvP 위력",
		PvPPowerInfo = "PvP 위력. PvP 상황에서 다른 플레이어(몬스터 제외)에게 기술 피해를 더 주거나, 치유 주문으로 다른 플레이어를 더 치유합니다.",
		PvPResilience = "PvP 탄력",
		PvPResilienceInfo = "PvP 탄력. 다른 플레이어의 공격으로부터 받는 피해를 감소시킵니다. 다른 플레이어를 상대할때만 효과가 있습니다.",
		PvPStats = "PvP 능력치",
		SecondaryStats = "2차 능력치",
		Shield = "방패",
		ShieldInfo = "방패 아이템일 경우 할당합니다.",
		Sockets = "보석 홈",
		SpecialWeaponStats = "특별한 무기 능력치",
		SpeedBaseline = "속도 기준",
		SpeedBaselineInfo = "무기에 표시되는 실제 능력치가 아닙니다, 이 숫자는 능력치 크기 값과 곱해지기 전에 속도 능력치로 부터 감산됩니다.",
		SpeedBaselineIs = "|cffffffff속도 기준|r:",
		SpeedInfo = "무기 속도, 스윙 당 초. (빠른 무기를 선호한다면, 이 숫자는 낮아야 합니다. 참고: \"특별한 무기 능력치\" 영역의 \"속도 기준\"",
		SpeedIs = "|cffffffff스윙 속도|r 1초 의 가치:",
		SpellPower = "주문력",
		SpellPowerInfo = "주문력. 캐스터 무기에 있습니다. 주문의 피해량과 치유량을 증가시킵니다. 지능으로 오르는 주문력은 포함되지 않습니다.",
		SpiritInfo = "정신력. 힐러의 마나 재생량을 증가시킵니다.",
		StaminaInfo = "체력. 생명력을 증가시킵니다.",
		StrengthInfo = "힘. 몇몇 직업의 전투력을 증가시킵니다.",
		VersatilityInfo = "유연성. 딜러에겐 피해량을 증가시키고, 힐러에겐 치유량을 증가시키며, 탱커에겐 받는 피해를 감소시킵니다.",
		WeaponMainHandDps = "주무기: DPS",
		WeaponMainHandDpsInfo = "주무기의 초당 공격력.",
		WeaponMainHandMaxDamage = "주무기: 최대 공격력",
		WeaponMainHandMaxDamageInfo = "주무기의 최대 공격력.",
		WeaponMainHandMinDamage = "주무기: 최소 공격력",
		WeaponMainHandMinDamageInfo = "주무기의 최소 공격력.",
		WeaponMainHandSpeed = "주무기: 속도",
		WeaponMainHandSpeedInfo = "주무기의 속도.",
		WeaponMaxDamage = "최대 공격력",
		WeaponMaxDamageInfo = "무기 최대 공격력.",
		WeaponMeleeDps = "근접: DPS",
		WeaponMeleeDpsInfo = "근접 무기의 초당 공격력.",
		WeaponMeleeMaxDamage = "근접: 최대 공격력",
		WeaponMeleeMaxDamageInfo = "근접 무기의 최대 공격력.",
		WeaponMeleeMinDamage = "근접: 최소 공격력",
		WeaponMeleeMinDamageInfo = "근접 무기의 최소 공격력.",
		WeaponMeleeSpeed = "근접: 속도",
		WeaponMeleeSpeedInfo = "근접 무기의 속도.",
		WeaponMinDamage = "최소 공격력",
		WeaponMinDamageInfo = "무기 최소 공격력.",
		WeaponOffHandDps = "보조: DPS",
		WeaponOffHandDpsInfo = "보조무기의 초당 공격력.",
		WeaponOffHandMaxDamage = "보조: 최대 공격력",
		WeaponOffHandMaxDamageInfo = "보조무기의 최대 공격력.",
		WeaponOffHandMinDamage = "보조: 최소 공격력",
		WeaponOffHandMinDamageInfo = "보조무기의 최소 공격력.",
		WeaponOffHandSpeed = "보조: 속도",
		WeaponOffHandSpeedInfo = "보조무기의 속도.",
		WeaponOneHandDps = "한손: DPS",
		WeaponOneHandDpsInfo = "주무기 또는 보조무기 상관없이 한손 장비 무기의 초당 공격력.",
		WeaponOneHandMaxDamage = "한손: 최대 공격력",
		WeaponOneHandMaxDamageInfo = "주무기 또는 보조무기 상관없이 한손 장비 무기의 최대 공격력.",
		WeaponOneHandMinDamage = "한손: 최소 공격력",
		WeaponOneHandMinDamageInfo = "주무기나 보조무기 상관없이 한손 무기의 최소 공격력.",
		WeaponOneHandSpeed = "한손: 속도",
		WeaponOneHandSpeedInfo = "주무기나 보조무기 상관없이 한손 무기의 속도.",
		WeaponRangedDps = "원거리: DPS",
		WeaponRangedDpsInfo = "원거리 무기의 초당 공격력.",
		WeaponRangedMaxDamage = "원거리: 최대 공격력",
		WeaponRangedMaxDamageInfo = "원거리 무기의 최대 공격력.",
		WeaponRangedMinDamage = "원거리: 최소 공격력",
		WeaponRangedMinDamageInfo = "원거리 무기의 최소 공격력.",
		WeaponRangedSpeed = "원거리: 속도",
		WeaponRangedSpeedInfo = "원거리 무기의 속도.",
		WeaponStats = "무기 능력치",
		WeaponTwoHandDps = "양손: DPS",
		WeaponTwoHandDpsInfo = "양손 무기의 초당 공격력.",
		WeaponTwoHandMaxDamage = "양손: 최대 공격력",
		WeaponTwoHandMaxDamageInfo = "양손 무기의 최대 공격력.",
		WeaponTwoHandMinDamage = "양손: 최소 공격력",
		WeaponTwoHandMinDamageInfo = "양손 무기의 최소 공격력.",
		WeaponTwoHandSpeed = "양손: 속도",
		WeaponTwoHandSpeedInfo = "양손 무기의 속도.",
		WeaponType1HAxe = "도끼: 한손",
		WeaponType1HAxeInfo = "한손 도끼 아이템일때 할당합니다.",
		WeaponType1HMace = "둔기: 한손",
		WeaponType1HMaceInfo = "한손 둔기 아이템일때 할당합니다.",
		WeaponType1HSword = "도검: 한손",
		WeaponType1HSwordInfo = "한손 도검 아이템일때 할당합니다.",
		WeaponType2HAxe = "도끼: 양손",
		WeaponType2HAxeInfo = "양손 도끼 아이템일때 할당합니다.",
		WeaponType2HMace = "둔기: 양손",
		WeaponType2HMaceInfo = "양손 둔기 아이템일때 할당합니다.",
		WeaponType2HSword = "도검: 양손",
		WeaponType2HSwordInfo = "양손 도검 아이템일때 할당합니다.",
		WeaponTypeBow = "활",
		WeaponTypeBowInfo = "활 아이템일때 할당합니다.",
		WeaponTypeCrossbow = "석궁",
		WeaponTypeCrossbowInfo = "석궁 아이템일때 할당합니다.",
		WeaponTypeDagger = "단검",
		WeaponTypeDaggerInfo = "단검 아이템일때 할당합니다.",
		WeaponTypeFistWeapon = "장착 무기",
		WeaponTypeFistWeaponInfo = "장착 무기 아이템일때 할당합니다.",
		WeaponTypeFrill = "보조장비 장식",
		WeaponTypeFrillInfo = "캐스터 보조장비 아이템일때 할당합니다. 방패나 무기에 적용되지 않습니다.",
		WeaponTypeGun = "총",
		WeaponTypeGunInfo = "총 아이템일때 할당합니다.",
		WeaponTypeOffHand = "보조무기",
		WeaponTypeOffHandInfo = "보조장비로만 착용할 수 있는 무기일때 할당합니다. 보조장비 \"장식\" (캐스터) 아이템, 주/보조 장비로 착용할 수 있는 방패 또는 무기에는 적용되지 않습니다.",
		WeaponTypePolearm = "장창",
		WeaponTypePolearmInfo = "장창 아이템일때 할당합니다.",
		WeaponTypes = "무기 유형",
		WeaponTypeStaff = "지팡이",
		WeaponTypeStaffInfo = "지팡이 아이템일때 할당합니다.",
		WeaponTypeWand = "마법봉",
		WeaponTypeWandInfo = "마법봉 아이템일때 할당합니다.",
	},
	TooltipParsing = {
		Agility = "^민첩성 %+?([-%d%.,]+)$",
		AllStats = "^모든 능력치 %+?([%d%.,]+)$",
		Ap = "^전투력 %+?([%d%.,]+)$",
		Armor = "^방어도 %+?([%d%.,]+)$",
		Armor2 = "^UNUSED$", -- Requires localization
		Avoidance = "^광역회피 %+([%d%.,]+)$",
		Axe = "^도끼$",
		BagSlots = "^%d+칸.+$", -- Needs review
		BonusArmor = "^추가 방어도 %+([%d%.,]+)$",
		Bow = "^활$",
		ChanceOnHit = "발동 효과:",
		Charges = "^.+회 사용 가능$",
		Cloth = "^천$",
		CooldownRemaining = "^재사용 대기시간:",
		Crit = "^치명타 및 극대화 %+?([%d%.,]+)$",
		Crit2 = "^UNUSED$", -- Requires localization
		Crossbow = "^석궁$",
		Dagger = "^단검$",
		Design = "디자인:",
		DisenchantingRequires = "^마력 추출 요구 사항", -- Needs review
		Dodge = "^회피 %+?([%d%.,]+)$",
		Dodge2 = "^UNUSED$", -- Requires localization
		Dps = "^%(초당 공격력 ([%d%.,]+)%)$",
		DpsAdd = "^초당 공격력 ([%d%.,]+) 추가$", -- Needs review
		Duration = "^지속시간:",
		Elite = "^정예$",
		EnchantmentArmorKit = "^강화 %(방어도 %+([%d%.,]+)%)$", -- Needs review
		EnchantmentCounterweight = "^평형추 %(가속 %+([%d%.,]+)%)", -- Needs review
		EnchantmentFieryWeapon = "^불타는 무기$",
		EnchantmentHealth = "^체력 %+([%d%.,]+)$", -- Needs review
		EnchantmentHealth2 = "^생명력 %+([%d%.,]+)$", -- Needs review
		EnchantmentLivingSteelWeaponChain = "^살아있는 강철 무기 사슬$",
		EnchantmentPyriumWeaponChain = "^황철 무기 사슬$",
		EnchantmentTitaniumWeaponChain = "^티타늄 무기 사슬$",
		Equip = "착용 효과:",
		FistWeapon = "^장착 무기$",
		Flexible = "^Flexible$", -- Requires localization
		Formula = "주문식:",
		Gun = "^총$",
		Haste = "^가속 %+?([%d%.,]+)$",
		Haste2 = "^UNUSED$", -- Requires localization
		HeirloomLevelRange = "^요구 레벨: %d+ %- (%d+)",
		HeirloomXpBoost = "^착용 효과: 경험치 획득량이", -- Needs review
		HeirloomXpBoost2 = "^UNUSED$", -- Requires localization
		Heroic = "^상급$",
		HeroicElite = "^정예 상급$",
		HeroicThunderforged = "^천둥벼림 상급$",
		HeroicWarforged = "^상급 전쟁벼림$",
		Hp5 = "^착용 효과: 5초마다 ([%d%.,]+)의 생명력이 회복됩니다%.$",
		Hp52 = "^Equip: Restores ([%d%.,]+) health per 5 sec%.$", -- Needs review
		Hp53 = "^5초당 생명력 %+?([%d%.,]+)$",
		Hp54 = "^UNUSED$", -- Requires localization
		Intellect = "^지능 %+?([-%d%.,]+)$",
		Leather = "^가죽$",
		Leech = "^생기흡수 %+([%d%.,]+)$",
		Mace = "^둔기$",
		Mail = "^사슬$",
		Manual = "처방전:",
		Mastery = "^특화 %+?([%d%.,]+)$",
		Mastery2 = "^UNUSED$", -- Requires localization
		MetaGemRequirements = "|cff%x%x%x%x%x%x필요 조건:",
		MovementSpeed = "^이동 속도 %+([%d%.,]+)$",
		MultiStatSeparator1 = "/",
		Multistrike = "^연속타격 %+([%d%.,]+)$",
		NormalizationEnchant = "^마법부여: (.*)$",
		Parry = "^무기 막기 %+?([%d%.,]+)$",
		Parry2 = "^UNUSED$", -- Requires localization
		Pattern = "도안:",
		Plans = "도면:",
		Plate = "^판금$",
		Polearm = "^장창$",
		PvPPower = "^PvP 위력 %+?([%d%.,]+)$",
		RaidFinder = "^공격대 찾기$",
		Recipe = "제조법:",
		Requires2 = "^UNUSED$", -- Requires localization
		Resilience = "^PvP 탄력 %+?([%d%.,]+)$",
		Resilience2 = "^UNUSED$", -- Requires localization
		Schematic = "설계도:",
		Scope = "^조준경 %(공격력 %+([%d%.,]+)%)$", -- Needs review
		ScopeCrit = "^조준경 %(치명타 %+([%d%.,]+)%)$", -- Needs review
		ScopeRangedCrit = "^원거리 치명타 %+?([%d%.,]+)$",
		Shield = "^방패$",
		SocketBonusPrefix = "보석 장착 보너스:",
		Speed = "^속도 ([%d%.,]+)$",
		Speed2 = "^UNUSED$", -- Requires localization
		SpellPower = "^주문력 %+?([%d%.,]+)$",
		Spirit = "^정신력 %+?([-%d%.,]+)$",
		Staff = "^지팡이$",
		Stamina = "^체력 %+?([-%d%.,]+)$",
		Strength = "^힘 %+?([-%d%.,]+)$",
		Sword = "^도검$",
		TemporaryBuffMinutes = "^.+%(%d+분%)$",
		TemporaryBuffSeconds = "^.+%(%d+초%)$",
		Thunderforged = "^천둥벼림$",
		Timeless = "^영원의 장비$",
		UpgradeLevel = "^강화 단계:",
		Use = "사용 효과:",
		Versatility = "^유연성 %+([%d%.,]+)$",
		Wand = "^마법봉$",
		Warforged = "^전쟁벼림$",
		WeaponDamage = "^공격력 ([%d%.,]+) %- ([%d%.,]+)$",
		WeaponDamageArcane = "^비전 피해 ([%d%.,]+)%~([%d%.,]+)$",
		WeaponDamageArcaneExact = "^비전 피해 %+?([%d%.,]+)$",
		WeaponDamageEnchantment = "^무기 공격력 %+?([%d%.,]+)$", -- Needs review
		WeaponDamageEquip = "^착용 효과: 무기 공격력 %+?([%d%.,]+)%.$", -- Needs review
		WeaponDamageExact = "^공격력 %+?([%d%.,]+)$",
		WeaponDamageFire = "^화염 피해 ([%d%.,]+)%~([%d%.,]+)$",
		WeaponDamageFireExact = "^화염 피해 %+?([%d%.,]+)$",
		WeaponDamageFrost = "^냉기 피해 ([%d%.,]+)%~([%d%.,]+)$",
		WeaponDamageFrostExact = "^냉기 피해 %+?([%d%.,]+)$",
		WeaponDamageHoly = "^신성 피해 ([%d%.,]+)%~([%d%.,]+)$",
		WeaponDamageHolyExact = "^신성 피해 %+?([%d%.,]+)$",
		WeaponDamageNature = "^자연 피해 ([%d%.,]+)%~([%d%.,]+)$",
		WeaponDamageNatureExact = "^자연 피해 %+?([%d%.,]+)$",
		WeaponDamageShadow = "^암흑 피해 ([%d%.,]+)%~([%d%.,]+)$",
		WeaponDamageShadowExact = "^암흑 피해 %+?([%d%.,]+)$",
	},
	UI = {
		AboutHeader = "Pawn 정보",
		AboutReadme = "Pawn을 처음 사용하세요? 시작하기 탭에서 기본 소개를 확인하세요.",
		AboutTab = "정보",
		AboutTranslation = "한글화: 적셔줄게@데스윙",
		AboutVersion = "버전 %s",
		AboutWebsite = [=[vgermods.com 을 방문하여 Vger의 다른 애드온을 확인하세요..

허가받은 Wowhead 능력치 점수 사용—기본 능력치 크기 값의 피드백을 와우헤드에 직접해주세요.]=],
		CompareClearItems = "비우기",
		CompareClearItemsTooltip = "양쪽 비교 아이템 제거하기.",
		CompareColoredSockets = "보석 홈 색상",
		CompareEquipped = "착용 중",
		CompareGemTotalValue = "보석의 값",
		CompareHeader = "%s|1을;를; 사용하여 아이템 비교",
		CompareMetaSockets = "얼개 보석 홈",
		CompareOtherHeader = "기타",
		CompareSlotEmpty = "(아이템 없음)",
		CompareSocketBonus = "보석 장착 보너스",
		CompareSocketsHeader = "보석 홈",
		CompareSpecialEffects = "특별한 효과",
		CompareSwap = "‹ 교체 ›",
		CompareSwapTooltip = "왼쪽 아이템과 오른쪽 아이템을 교체합니다.",
		CompareTab = "비교",
		CompareVersus = "—vs.—",
		CompareWelcomeLeft = "먼저, 왼쪽의 목록에서 능력치 크기를 골라주세요.",
		CompareWelcomeRight = [=[다음엔, 이 박스에 아이템을 끌어다 주세요.

왼쪽 아래 모서리에 있는 아이콘을 사용해 보유 중인 아이템과 비교할 수 있습니다.]=],
		CompareYourBest = "최상급",
		GemsColorHeader = "%s 보석",
		GemsHeader = "%s를 위한 보석",
		GemsNoneFound = "적당한 보석을 찾지 못했습니다.",
		GemsQualityLevel = "보석 등급",
		GemsQualityLevelTooltip = [=[보석을 제안할 아이템의 레벨.

에를 들어, "463"이면, Pawn은 아이템 레벨 463: 판다리아의 안개 영웅 던전 전리품에 사용하기 적당한 보석을 보여줍니다.]=],
		GemsShowBest = "사용 가능한 최상의 보석 표시",
		GemsShowBestTooltip = "현재 선택된 능력치 크기에서 사용 가능한 최상의 보석을 표시합니다. 이 보석들은 오래되거나 낮은 등급의 아이템에 사용하기엔 너무 강력할 수 있습니다.",
		GemsShowForItemLevel = "아이템 레벨에 맞는 보석 표시:",
		GemsShowForItemLevelTooltip = "현재 선택된 능력치 크기와 특정 레벨의 아이템을 위해 Pawn이 추천하는 보석 표시",
		GemsTab = "보석",
		GemsWelcome = "Pawn이 추천하는 보석을 보려면 왼쪽에서 능력치 크기를 선택하세요.",
		HelpHeader = "Pawn 환영합니다!",
		HelpTab = "시작하기",
		HelpText = [=[Pawn은 아이템의 능력치에 기반하여 점수를 계산합니다.  이 점수는 어떤 아이템이 최상급인지, 현재 장비보다 업그레이드 되는 아이템인지 결정하는 데 사용됩니다.


각 아이템은 캐릭터에 활성화 된 "능력치 크기" 별로 점수를 가집니다. 능력치 크기는 당신에게 중요한 능력치와 능력치 별로 얼마나 가치가 있는지 나열합니다. 보통 직업의 특성 또는 역할 별로 하나의 능력치 크기를 가집니다. 점수는 보통 숨겨져 있지만, 비교 탭에서 아이템 점수가 어떻게 계산되는지 볼 수 있습니다.

 • 능력치 크기 탭에 있는 목록에서 쉬프트-클릭하여 능력치 크기를 켜거나 끌 수 있습니다.


Pawn은 각 직업과 특성 별로 미리 만들어진 능력치 크기를 가지고 있습니다. 또한 각 능력치 별로 값을 할당하여 자신만의 설정을 만들 수 있고, 인터넷이나 시뮬레이션 도구, 또는 길드원과의 공유를 통해 능력치 크기를 가져올 수 있습니다.


|cff8ec3e6기본 사용법을 배우기 위해 이 기능들을 사용해보세요:|r
  • Pawn의 비교 탭을 사용해 두 아이템의 능력치를 비교해보세요.
  • 아이템 링크 창을 우클릭하여 현재 장비와 어떻게 비교되는지 확인하세요.
  • 능력치 크기 탭에서 하나를 복사하여 당신의 능력치 크기를 만들고, 수치 탭에서 능력치 수치를 개인설정 해보세요.
  • 인터넷에서 당신의 직업에 맞는 능력치 크기를 찾아보세요.
  • readme 파일을 확인해서 Pawn의 고급 기능들에 대해 배워보세요.]=],
		InterfaceOptionsBody = "Pawn 버튼을 클릭하여 이동합니다. 또한 인벤토리 페이지에서 Pawn을 열수 있으며, 단축키를 지정할수도 있습니다.",
		InterfaceOptionsWelcome = "Pawn 옵션은 Pawn UI에 있습니다.",
		InventoryButtonTooltip = "클릭하여 Pawn 열기.",
		InventoryButtonTotalsHeader = "모든 착용 아이템의 총합:",
		KeyBindingCompareItemLeft = "아이템 비교 (왼쪽)",
		KeyBindingCompareItemRight = "아이템 비교 (오른쪽)",
		KeyBindingShowUI = "Pawn UI 토글",
		OptionsAdvisorHeader = "조언가 옵션",
		OptionsAlignRight = "툴팁 오른쪽 끝으로 수치 정렬",
		OptionsAlignRightTooltip = "이 옵션을 켜면 Pawn 수치와 업그레이드 정보를 툴팁 왼쪽 대신 오른쪽 끝에 정렬합니다.",
		OptionsBlankLine = "값 위에 빈 줄 추가",
		OptionsBlankLineTooltip = "이 옵션을 켜면 Pawn 값 위에 빈 줄을 추가해 아이템 툴팁을 깔끔하게 정리할 수 있습니다.",
		OptionsButtonHidden = "숨기기",
		OptionsButtonHiddenTooltip = "캐릭터 정보 창에 Pawn 버튼을 표시하지 않습니다.",
		OptionsButtonPosition = "Pawn 버튼 표시하기:",
		OptionsButtonPositionLeft = "왼쪽에",
		OptionsButtonPositionLeftTooltip = "Pawn 버튼을 캐릭터 정보 창의 왼쪽 아래 모서리에 표시합니다.",
		OptionsButtonPositionRight = "오른쪽에",
		OptionsButtonPositionRightTooltip = "Pawn 버튼을 캐릭터 정보 창의 오른쪽 아래 모서리에 표시합니다.",
		OptionsColorBorder = "업그레이드 툴팁 테두리에 색깔 넣기",
		OptionsColorBorderTooltip = "이 옵션을 켜면 업그레이드 아이템의 툴팁 테두리의 색상을 녹색으로 바꿉니다. 툴팁 테두리를 변경하는 다른 애드온과 문제가 생기면 이 옵션을 끄세요.",
		OptionsCurrentValue = "현재값과 기본값 모두 표시",
		OptionsCurrentValueTooltip = [=[이 옵션을 켜면 Pawn은 아이템에 두개의 값을 표시합니다: 현재값, 실제 장착된 보석과 마법부여된 아이템의 현재 상태를 나타냅니다, 빈 보석 홈은 얻는 효과 없이 제공됩니다. 그리고 Pawn이 일반적으로 표시하는 기본값. 이 옵션은 툴팁에 아이템 수치 표시를 켜야 작동합니다.

최종적으로 두 개의 아이템 사이에서 결정하려면 기본값을 사용해야 합니다, 하지만 현재값은 레벨링 중이거나 새로운 아이템에 보석이나 마법부여를 하기 전 즉시 착용했을 때의 가치를 쉽게 알 수 있게 해줍니다.]=],
		OptionsDebug = "디버그 정보 표시",
		OptionsDebugTooltip = [=[몇몇 아이템의 수치 계산이 맘에 들지 않는다면, 이 옵션을 켜서 아이템에 마우스를 올릴 때마다 '유용한' 데이터를 대화 콘솔에 내보내게 하세요  이 정보는 아이템이 가지고 있다고 생각하는 능력치, Pawn이 이해할 수 없는 몇몇 아이템, 그리고 각 능력치 크기 별로 계정에 어떻게 작용하는 지를 포함하고 있습니다.

이 옵션은 대화 로그를 빠르게 채웁니다, 따라서 조사가 끝나면 꺼야합니다.

단축키:
/pawn debug on
/pawn debug off]=],
		OptionsHeader = "Pawn 옵션 조정",
		OptionsIgnoreGemsWhileLevelingCheck = "낮은 레벨 아이템의 보석 홈 무시하기",
		OptionsIgnoreGemsWhileLevelingCheckTooltip = [=[이 옵션을 켜면 많은 사람들이 보석을 장착하지 않거나 레벨링 중일 때 저레벨 아이템의 보석홈을 무시합니다. "저레벨" 아이템은 현재 레벨의 영웅 던전에서 획득할 수 있는 것보다 약한 아이템입니다.

체크하면, Pawn 보석장착 조언가는 저레벨 아이템에 적당한 보석을 추천하지만 보석 홈은 계산에서 제외되며 보석이 장착된 아이템은 종종 업그레이드로 보여지지 않습니다.

체크하지 않으면, 아이템 레벨에 상관없이 보석 홈에 최상의 보석을 장착한 것으로 가정하고 값을 계산하게 됩니다.]=],
		OptionsInventoryIcon = "인벤토리 아이콘 표시",
		OptionsInventoryIconTooltip = "이 옵션을 켜면 아이템 링크 창 옆에 인벤토리 아이콘을 표시합니다.",
		OptionsItemIDs = "아이템 ID 표시",
		OptionsItemIDsTooltip = [=[이 옵션을 켜면 Pawn이 모든 아이템의 아이템 ID를 표시하게 하며, 모든 마법부여와 보석의 ID까지 표시됩니다.

월드 오브 워크래프트의 모든 아이템은 연관된 ID 숫자를 가집니다. 이 정보는 보통 애드온 제작자에게 유용합니다.]=],
		OptionsLootAdvisor = "전리품 업그레이드 조언가 표시",
		OptionsLootAdvisorTooltip = "던전에서 당신의 캐릭터를 업그레이드 시켜주는 전리품이 나오면, Pawn은 주사위 굴림 창에 업그레이드에 관한 정보를 보여주는 팝업창을 붙입니다.",
		OptionsOtherHeader = "기타 옵션",
		OptionsQuestUpgradeAdvisor = "퀘스트 업그레이드 조언가 표시",
		OptionsQuestUpgradeAdvisorTooltip = "퀘스트 목록이나 NPC들과 대화할 때, 퀘스트 보상 중 현재 장비를 업그레이드 하는 것이 있으면, Pawn은 녹색 화살표 아이콘을 그 아이템에 표시합니다. 업그레이드 아이템이 없으면, Pawn은 상인에게 판매 가격이 가장 높은 아이템에 동전 더미를 표시합니다.",
		OptionsResetUpgrades = "장비 재탐색",
		OptionsResetUpgradesTooltip = [=[Pawn은 최상의 아이템으로 계속 장착 해왔던 아이템을 잊고, 앞으로 최신 업그레이드 정보를 제공하기 위해 당신의 장비를 재탐색 합니다.

Pawn이 상점에 판매했거나, 파괴했거나, 다른 방법으로 더이상 사용하지 않는 아이템을 업그레이드로 추천한다면 이 기능을 사용하세요. Pawn을 사용하는 모든 캐릭터에 영향을 미칩니다.]=],
		OptionsSocketingAdvisor = "보석 장착 조언가 표시",
		OptionsSocketingAdvisorTooltip = "아이템에 보석을 추가할 때, Pawn은 효과를 극대화시켜주는 보석을 제안하는 팝업 창을 표시합니다. (각 색상 별 보석 제안의 전체 목록을 보려면, 사용할 보석의 등급을 설정할 수 있는 보석 탭으로 가세요.)",
		OptionsTab = "옵션",
		OptionsTooltipHeader = "툴팁 옵션",
		OptionsTooltipUpgradesOnly = "업그레이드만 표시",
		OptionsTooltipUpgradesOnlyTooltip = [=[이것은 단순한 옵션입니다. 오직 현재 장비를 업그레이드 하는 아이템에 업그레이드 백분율만 표시하며, 각 능력치 크기에 맞게 최상의 아이템으로 나타냅니다.


|cff8ec3e6화염:|r  |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% 업그레이드|r

...또는...

|cff8ec3e6화염:  최상급|r]=],
		OptionsTooltipValuesAndUpgrades = "능력치 크기 값과 업그레이드 % 표시",
		OptionsTooltipValuesAndUpgradesTooltip = [=[모든 아이템에 0의 값을 가지지 않는 능력치 크기의 값을 표시합니다.  추가로, 업그레이드 정보도 나타냅니다.

|cff8ec3e6냉기:  123.4
화염:  156.7 |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% 업그레이드|r]=],
		OptionsTooltipValuesOnly = "업그레이드 %를 제외한 능력치 크기 값만 표시",
		OptionsTooltipValuesOnlyTooltip = [=[모든 아이템에 0의 값을 가지지 않는 능력치 크기의 값을 표시합니다.  업그레이드 정보는 나타내지 않습니다.  이 옵션은 구버전 Pawn의 기본 작동법 입니다.

|cff8ec3e6냉기:  123.4
화염:  156.7|r]=],
		OptionsUpgradeHeader = "툴팁에 |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t 업그레이드 표시:",
		OptionsUpgradesForBothWeaponTypes = "한손과 양손 모두 업그레이드 표시",
		OptionsUpgradesForBothWeaponTypesTooltip = [=[Pawn의 업그레이드 조언가는 양손 무기와 쌍수 (또는 캐스터의 주무기와 보조 장비 장식) 무기 세트를 분리해서 업그레이드 정보를 추적하고 표시할 수 있습니다.

체크하면, 양손 무기를 사용 중일 때도 보유 중인 낮은 순위의 한손 무기 (또는 두번째 순위)보다 나은 한손 무기를 업그레이드로 표시합니다, Pawn은 양손 세트의 업그레이드를 따로 추적하기 때문입니다.

체크하지 않으면, 양손 무기를 착용 중일 때 한손 장비를 업그레이드로 보여주지 않으며 반대로도 작동합니다.]=],
		OptionsWelcome = "원하는 대로 Pawn을 설정하세요. 변경 내용은 즉시 적용됩니다.",
		ScaleChangeColor = "색상 변경",
		ScaleChangeColorTooltip = "아이템 툴팁에 나타나는 이 능력치 크기의 이름과 값의 색상을 변경합니다.",
		ScaleCopy = "복사",
		ScaleCopyTooltip = "이 중 하나를 복사하여 새로운 능력치 크기를 만듭니다.",
		ScaleDefaults = "기본값",
		ScaleDefaultsTooltip = "기본값을 복사하여 새로운 능력치 크기를 만듭니다.",
		ScaleDeleteTooltip = [=[이 능력치 크기 삭제하기.

이 명령은 되돌릴 수 없습니다!]=],
		ScaleEmpty = "비어 있는",
		ScaleEmptyTooltip = "긁어오기로 새로운 능력치 크기를 만듭니다.",
		ScaleExport = "내보내기",
		ScaleExportTooltip = "인터넷의 다른 사람들과 능력치 크기를 공유합니다.",
		ScaleHeader = "Pawn 능력치 크기 관리",
		ScaleImport = "가져오기",
		ScaleImportTooltip = "인터넷으로부터 능력치 크기 태그를 붙여넣어 새로운 능력치 크기를 추가합니다.",
		ScaleNewHeader = "새 능력치 크기 만들기",
		ScaleRename = "이름 변경",
		ScaleRenameTooltip = "이 능력치 크기의 이름 변경",
		ScaleSelectorHeader = "능력치 크기 선택:",
		ScaleSelectorShowScale = "툴팁에 능력치 크기 표시",
		ScaleSelectorShowScaleTooltip = [=[이 옵션을 체크하면, 이 캐릭터의 아이템 툴팁에 이 능력치 크기의 값을 표시합니다. 각 능력치 크기 별로 한 캐릭터, 여러 캐릭터, 또는 아무 캐릭터에도 표시하지 않게 설정할 수 있습니다.

단축키: 능력치 크기 쉬프트+클릭]=],
		ScaleShareHeader = "능력치 크기 공유하기",
		ScaleTab = "능력치 크기",
		ScaleTypeNormal = "수치 탭에서 이 능력치 크기를 변경할 수 있습니다.",
		ScaleTypeReadOnly = "이 능력치 크기를 변경하려면 복사본을 만들어야 합니다.",
		ScaleWelcome = "능력치 크기는 할당된 아이템에 사용되는 능력치의 세트와 값입니다. 자신만의 것을 만들거나 이미 만들어진 다른 능력치 크기 갑을 사용할 수 있습니다.",
		SocketingAdvisorButtonTooltip = "클릭하여 Pawn의 보석 탭을 엽니다, Pawn이 추천하는 보석에 대한 정보를 더 볼 수 있습니다.",
		SocketingAdvisorHeader = "Pawn 보석 장착 조언가 추천:",
		SocketingAdvisorIgnoreThisItem = "낮은 레벨 아이템에 보석 추가하지 않기. 가능하다면, 이것을 사용하기:",
		ValuesDoNotShowUpgradesFor1H = "한손 아이템의 업그레이드 보지 않기",
		ValuesDoNotShowUpgradesFor2H = "양손 아이템의 업그레이드 보지 않기",
		ValuesDoNotShowUpgradesTooltip = "이 옵션을 켜면 이 아이템 형식의 업그레이드를 숨깁니다. 예를 들어, 성기사 탱커는 양손 무기를 사용할 수 있지만, 양손 무기는 성기사 탱커 세트에 \"업그레이드\"하지 않습니다, 따라서 Pawn은 이에 따른 업그레이드 정보를 표시하지 않습니다. 유사하게, 징벌 성기사는 한손 무기를 사용할 수 있지만, 그것들을 업그레이드하지 않습니다.",
		ValuesFollowSpecialization = "레벨 50 이후의 최상의 방어구 종류의 업그레이드만 표시하기",
		ValuesFollowSpecializationTooltip = "이 옵션을 켜면 레벨 50 이후 직업 별 전문화되지 않는 방어구에 대한 업그레이드를 숨깁니다. 예를 들어, 신성 성기사는 레벨 50에 판금 전문화를 배웁니다, 이것은 판금 방어구를 착용했을 때만 지능을 5% 증가시킵니다. 이 옵션을 선택했을 땐 Pawn은 레벨 50+ 신성 성기사에게 천, 가죽, 또는 사슬을 업그레이드에 고려하지 않습니다.",
		ValuesHeader = "%s의 능력치 크기 값",
		ValuesIgnoreStat = "포함된 아이템 사용불가",
		ValuesIgnoreStatTooltip = "이 옵션을 켜면 능력치 크기에 따른 능력치 값을 가져오지 않습니다. 예를 들어, 주술사는 판금을 착용할 수 없으며, 판금이 사용불가능 하게 디자인된 주술사의 능력치 크기는 판금 방어구로부터 값을 가져오지 않습니다.",
		ValuesNormalize = "값 일반화 (Wowhead 처럼)",
		ValuesNormalizeTooltip = "이 옵션을 켜면 능력치 크기의 모든 능력치 값을 합산한 값과 아이템의 최종 계산 값을 분할합니다, Wowhead와 Lootzor이 그러하듯이. 이 것은 1을 기준으로 한 능력치 크기와 5를 기준으로 한 능력치 크기의 값을 균일하게 하는데 유용합니다. 또한 숫자를 작게 관리할 수 있게 도와줍니다.",
		ValuesRemove = "제거",
		ValuesRemoveTooltip = "능력치 크기에서 이 능력치 제거",
		ValuesTab = "수치",
		ValuesWelcome = "이 능력치 크기의 각 능력치 별로 할당할 값을 개인 설정할 수 있습니다. 능력치 크기를 관리하거나 추가하려면, 능력치 크기 탭을 이용하세요.",
		ValuesWelcomeNoScales = "능력치 크기를 선택하지 않았습니다. 시작하려면, 능력치 크기 탭으로 가서 새로운 능력치 크기를 만들거나 인터넷에서 붙여넣으세요.",
		ValuesWelcomeReadOnly = "선택된 능력치 크기는 변경할 수 없습니다. 이 값들을 변경하고 싶다면, 능력치 크기 탭으로 가서 이 능력치 크기를 복사하거나 새로운 것을 만드세요.",
	},
	Wowhead = {
		DeathKnightBloodTank = "죽기: 혈기",
		DeathKnightFrostDps = "죽기: 냉기",
		DeathKnightUnholyDps = "죽기: 부정",
		DruidBalance = "드루이드: 조화",
		DruidFeralDps = "드루이드: 야성",
		DruidFeralTank = "드루이드: 수호",
		DruidRestoration = "드루이드: 회복",
		HunterBeastMastery = "사냥꾼: 야수",
		HunterMarksman = "사냥꾼: 사격",
		HunterSurvival = "사냥꾼: 생존",
		MageArcane = "마법사: 비전",
		MageFire = "마법사: 화염",
		MageFrost = "마법사: 냉기",
		MonkBrewmaster = "수도사: 양조",
		MonkMistweaver = "수도사: 운무",
		MonkWindwalker = "수도사: 풍운",
		PaladinHoly = "성기사: 신성",
		PaladinRetribution = "성기사: 징벌",
		PaladinTank = "성기사: 보호",
		PriestDiscipline = "사제: 수양",
		PriestHoly = "사제: 신성",
		PriestShadow = "사제: 암흑",
		Provider = "Wowhead 능력치 크기",
		ProviderStarter = "초보자 능력치 크기",
		RogueAssassination = "도적: 암살",
		RogueCombat = "도적: 전투",
		RogueSubtlety = "도적: 잠행",
		ShamanElemental = "주술사: 정기",
		ShamanEnhancement = "주술사: 고양",
		ShamanRestoration = "주술사: 복원",
		WarlockAffliction = "흑마법사: 고통",
		WarlockDemonology = "흑마법사: 악마",
		WarlockDestruction = "흑마법사: 파괴",
		WarriorArms = "전사: 무기",
		WarriorFury = "전사: 분노",
		WarriorTank = "전사: 방어",
	},
}
end

if GetLocale() == "koKR" then
	PawnUseThisLocalization()
end

-- After using this localization or deciding that we don't need it, remove it from memory.
PawnUseThisLocalization = nil
