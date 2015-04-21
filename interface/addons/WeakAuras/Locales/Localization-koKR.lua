if not(GetLocale() == "koKR") then
    return;
end

local L = WeakAuras.L

-- Options translation
L["<"] = "<"
L["<="] = "<="
L["="] = "="
L[">"] = ">"
L[">="] = ">="
L["!="] = "!="
L["10 Man Raid"] = "10인 공격대"
L["25 Man Raid"] = "25인 공격대"
-- L["40 Man Raid"] = ""
L["5 Man Dungeon"] = "5인 던전"
L["Absorb"] = "흡수"
L["Absorbed"] = "흡수됨"
L["Action Usable"] = "사용 가능"
-- L["Affected"] = ""
-- L["Air"] = ""
-- L["Alive"] = ""
L["All Triggers"] = "모든 조건"
-- L["Alternate Power"] = ""
-- L["Always active trigger"] = ""
-- L["Ambience"] = ""
-- L["Amount"] = ""
L["Any Triggers"] = "아무 조건"
L["Arena"] = "투기장"
L["Ascending"] = "올림차순"
-- L["Assist"] = ""
L["At Least One Enemy"] = "최소 1명의 적 대상"
L["Attackable"] = "공격 가능"
L["Aura"] = "오라"
L["Aura:"] = "오라:"
L["Aura Applied"] = "오라 적용됨"
-- L["Aura Applied Dose"] = ""
-- L["Aura Broken"] = ""
-- L["Aura Broken Spell"] = ""
-- L["Aura Name"] = ""
L["Aura Name or ID"] = "오라 이름" -- Needs review
-- L["Aura Refresh"] = ""
L["Aura Removed"] = "오라 사라짐"
-- L["Aura Removed Dose"] = ""
L["Auras:"] = "오라:"
L["Aura Stack"] = "오라 중첩"
L["Aura Type"] = "오라 종류"
L["Automatic"] = "자동"
-- L["Back and Forth"] = ""
L["Battleground"] = "전장"
L["Battle.net Whisper"] = "실명 ID 귓속말"
L["BG>Raid>Party>Say"] = "전장>공격대>파티>일반대화"
L["BG-System Alliance"] = "전장 얼라이언스"
L["BG-System Horde"] = "전장 호드"
L["BG-System Neutral"] = "전장 중립"
L["Blizzard Combat Text"] = "블리자드 전투메세지"
L["Block"] = "방어"
L["Blocked"] = "방어"
L["Blood Rune #1"] = "혈기 룬 #1"
L["Blood Rune #2"] = "혈기 룬 #2"
L["Blood runes"] = "혈기 룬"
L["Boss Emote"] = "보스 감정표현"
L["Bottom"] = "아래"
L["Bottom Left"] = "왼쪽 아래"
L["Bottom Right"] = "오른쪽 아래"
L["Bottom to Top"] = "아래에서 위로"
L["Bounce"] = "바운스"
-- L["Bounce with Decay"] = ""
L["Buff"] = "버프"
-- L["Burning Embers"] = ""
L["By |cFF69CCF0Mirrored|r of Dragonmaw(US) Horde"] = "By |cFF69CCF0Mirrored|r of Dragonmaw서버 (US) 호드"
L["Cast"] = "시전"
L["Cast Failed"] = "시전 실패"
L["Cast Start"] = "시전 시작"
L["Cast Success"] = "시전 성공"
L["Cast Type"] = "시전 종류"
L["Center"] = "중앙"
L["Centered Horizontal"] = "수평 중앙"
L["Centered Vertical"] = "수직 중앙"
L["Channel"] = "채널"
L["Channel (Spell)"] = "채널"
L["Character Type"] = "캐릭터 종류"
-- L["Charges"] = ""
L["Chat Frame"] = "채팅창"
L["Chat Message"] = "채팅 메세지"
-- L["Children:"] = ""
-- L["Chi Power"] = ""
-- L["Circle"] = ""
-- L["Circular"] = ""
L["Class"] = "직업"
L["Click to close configuration"] = "클릭 - 설정창을 닫습니다"
L["Click to open configuration"] = "클릭 - 설정창 열기"
L["Combat Log"] = "전투메시지 기록"
L["Combo Points"] = "연계 점수"
-- L["Conditions"] = ""
-- L["Contains"] = ""
L["Cooldown Progress (Item)"] = "쿨다운 진행상황 (아이템)"
L["Cooldown Progress (Spell)"] = "쿨다운 진행상황 (주문)"
L["Cooldown Ready (Item)"] = "쿨다운 준비됨 (아이템)"
L["Cooldown Ready (Spell)"] = "쿨다운 준비됨 (주문)"
L["Create"] = "생성"
L["Critical"] = "치명타"
L["Crowd Controlled"] = "군중 제어"
-- L["Crushing"] = ""
L["Curse"] = "저주"
L["Custom"] = "개인추가"
L["Custom Function"] = "개인추가 기능"
L["Damage"] = "피해"
-- L["Damager"] = ""
L["Damage Shield"] = "피해 흡수"
-- L["Damage Shield Missed"] = ""
-- L["Damage Split"] = ""
L["Death Knight"] = "죽음의 기사"
L["Death Knight Rune"] = "죽음의 기사 룬"
-- L["Death Rune"] = ""
L["Debuff"] = "디버프"
-- L["Defensive"] = ""
L["Deflect"] = "튕김"
-- L["Demonic Fury"] = ""
L["Descending"] = "내림차순"
L["Destination Name"] = "대상 이름"
L["Destination Unit"] = "대상 유닛"
L["Disease"] = "질병"
L["Dispel"] = "해제"
L["Dispel Failed"] = "해제 실패"
L["Dodge"] = "회피"
L["Done"] = "완료"
L["Down"] = "아래로"
-- L["Drain"] = ""
-- L["Drowning"] = ""
L["Druid"] = "드루이드"
L["Dungeon Difficulty"] = "던전 난이도"
-- L["Durability Damage"] = ""
-- L["Durability Damage All"] = ""
-- L["Earth"] = ""
-- L["Eclipse Direction"] = ""
L["Eclipse Power"] = "일식/월식 파워"
L["Eclipse Type"] = "일식/월식 유형"
L["Emote"] = "감정표현"
-- L["Energize"] = ""
L["Energy"] = "기력"
-- L["Enrage"] = ""
-- L["Environmental"] = ""
L["Environment Type"] = "환경 종류"
L["Evade"] = "벗어남"
L["Event"] = "이벤트"
L["Event(s)"] = "이벤트"
L["Every Frame"] = "매 프레임"
-- L["Extra Amount"] = ""
-- L["Extra Attacks"] = ""
-- L["Extra Spell Name"] = ""
L["Fade In"] = "서서히 나타남"
L["Fade Out"] = "서서히 사라짐"
-- L["Fail Alert"] = ""
-- L["Falling"] = ""
-- L["Fatigue"] = ""
-- L["Fire"] = ""
-- L["First Tree"] = ""
L["Flash"] = "반짝임"
-- L["Flex Raid"] = ""
L["Flip"] = "던지기"
L["Focus"] = "주시"
L["Form"] = "폼"
L["Friendly"] = "우호적 대상"
-- L["Friendly Fire"] = ""
-- L["From"] = ""
L["Frost Rune #1"] = "냉기 룬 #1"
L["Frost Rune #2"] = "냉기 룬 #2"
L["Frost Runes"] = "냉기 룬"
L["Glancing"] = "비껴맞음"
L["Global Cooldown"] = "글로벌 쿨다운"
L["Glow"] = "빛남"
L["Gradient"] = "그라디언트"
-- L["Gradient Pulse"] = ""
L["Group"] = "그룹"
L["Group %s"] = "그룹 %s"
L["Grow"] = "성장"
-- L["GTFO Alert"] = ""
L["Guild"] = "길드"
L["Happiness"] = "만족도"
L["HasPet"] = "소환수 있음 (살아있음)"
L["Heal"] = "힐"
L["Healer"] = "힐러"
L["Health"] = "체력"
L["Health (%)"] = "체력 (%)"
L["Heroic"] = "영웅"
L["Hide"] = "숨김"
-- L["High Damage"] = ""
-- L["Higher Than Tank"] = ""
L["Holy Power"] = "신성한 힘"
L["Hostile"] = "적 대상"
-- L["Hostility"] = ""
L["Humanoid"] = "인간형"
L["Hunter"] = "사냥꾼"
L["Icon"] = "아이콘"
L["Ignore Rune CD"] = "룬 쿨다운 무시"
L["Immune"] = "면역"
L["Include Bank"] = "은행 포함"
-- L["Include Charges"] = ""
-- L["Include Death Runes"] = ""
L["In Combat"] = "전투중"
L["Inherited"] = "상속"
-- L["In Pet Battle"] = ""
L["Inside"] = "안쪽"
-- L["Instakill"] = ""
L["Instance Type"] = "인스턴스 종류"
L["Interrupt"] = "차단"
L["Interruptible"] = "차단 가능"
L["In Vehicle"] = "탑승중"
L["Inverse"] = "반대로"
L["Is Exactly"] = "정확함"
L["Item"] = "아이템"
L["Item Count"] = "아이템 갯수"
L["Item Equipped"] = "아이템 착용됨"
-- L["Lava"] = ""
-- L["Leech"] = ""
L["Left"] = "왼쪽"
L["Left to Right"] = "왼쪽에서 오른쪽"
L["Level"] = "레벨"
-- L["Low Damage"] = ""
-- L["Lower Than Tank"] = ""
-- L["Lunar"] = ""
-- L["Lunar Power"] = ""
L["Mage"] = "마법사"
L["Magic"] = "마법"
L["Main Hand"] = "주무기"
L["Mana"] = "마나"
-- L["Master"] = ""
-- L["Matches (Pattern)"] = ""
L["Message"] = "메세지"
L["Message type:"] = "메세지 유형:"
L["Message Type"] = "메세지 유형"
-- L["Miss"] = ""
L["Missed"] = "빗나감"
-- L["Missing"] = ""
-- L["Miss Type"] = ""
-- L["Monochrome"] = ""
L["Monochrome Outline"] = "단색" -- Needs review
-- L["Monochrome Thick Outline"] = ""
-- L["Monster Yell"] = ""
-- L["Mounted"] = ""
L["Multi-target"] = "다중 대상"
L["Music"] = "음악"
L["Name"] = "이름"
-- L["Never"] = ""
L["Next"] = "다음"
-- L["No Children:"] = ""
-- L["No Instance"] = ""
L["None"] = "없음"
L["Non-player Character"] = "NPC"
L["Normal"] = "일반"
-- L["Not On Threat Table"] = ""
-- L["Number"] = ""
-- L["Number Affected"] = ""
L["Off Hand"] = "보조무기"
L["Officer"] = "길드관리자"
L["Opaque"] = "불투명"
L["Orbit"] = "공전"
L["Outline"] = "외곽선"
L["Outside"] = "바깥쪽"
L["Overhealing"] = "초과치유"
-- L["Overkill"] = ""
L["Paladin"] = "성기사"
L["Parry"] = "막음"
L["Party"] = "파티"
-- L["Party Kill"] = ""
-- L["Passive"] = ""
L["Paused"] = "일시정지됨"
L["Periodic Spell"] = "주기적인 주문"
L["Pet"] = "소환수"
-- L["Pet Behavior"] = ""
L["Player"] = "플레이어"
L["Player Character"] = "플레이어 캐릭터"
L["Player Class"] = "플레이어 직업"
L["Player Dungeon Role"] = "플레이어 던전 역할"
L["Player Level"] = "플레이어 레벨"
L["Player Name"] = "플레이어 이름"
-- L["Player Race"] = ""
-- L["Player(s) Affected"] = ""
-- L["Player(s) Not Affected"] = ""
L["Poison"] = "독"
L["Power"] = "파워"
L["Power (%)"] = "파워 (%)"
L["Power Type"] = "파워 유형"
L["Preset"] = "프리셋"
L["Priest"] = "사제"
L["Progress"] = "진행"
-- L["Pulse"] = ""
-- L["PvP Flagged"] = ""
-- L["Radius"] = ""
L["Rage"] = "분노"
L["Raid"] = "공격대"
L["Raid Warning"] = "공격대 경보"
-- L["Range"] = ""
-- L["Ranged"] = ""
-- L["Realm"] = ""
L["Receiving display information"] = "%s에서 디스플레이 정보 수신 중..."
-- L["Reference Spell"] = ""
L["Reflect"] = "반사"
-- L["Relative"] = ""
L["Remaining Time"] = "남은 시간"
-- L["Requested display does not exist"] = ""
-- L["Requested display not authorized"] = ""
L["Require Valid Target"] = "유효 대상 필요"
L["Resist"] = "저항"
L["Resisted"] = "저항"
-- L["Resolve collisions dialog"] = ""
-- L["Resolve collisions dialog singular"] = ""
-- L["Resolve collisions dialog startup"] = ""
-- L["Resolve collisions dialog startup singular"] = ""
L["Resting"] = "휴식중"
L["Resurrect"] = "부활"
L["Right"] = "오른쪽"
L["Right to Left"] = "오른쪽에서 왼쪽"
L["Rogue"] = "도적"
L["Rotate Left"] = "왼쪽으로 회전"
L["Rotate Right"] = "오른쪽으로 회전"
L["Rune"] = "룬"
L["Runic Power"] = "룬마력"
L["Say"] = "일반대화"
L["Seconds"] = "초"
-- L["Second Tree"] = ""
-- L["Shadow Orbs"] = ""
L["Shake"] = "흔들기"
L["Shaman"] = "주술사"
L["Shards"] = "조각"
L["Shift-Click to pause"] = "Shift-Click - 일시정지"
L["Shift-Click to resume"] = "Shift-Click - 재시작"
L["Show"] = "보이기"
L["Shrink"] = "축소"
-- L["Slide from Bottom"] = ""
-- L["Slide from Left"] = ""
-- L["Slide from Right"] = ""
-- L["Slide from Top"] = ""
-- L["Slide to Bottom"] = ""
-- L["Slide to Left"] = ""
-- L["Slide to Right"] = ""
-- L["Slide to Top"] = ""
-- L["Slime"] = ""
-- L["Solar"] = ""
-- L["Solar Power"] = ""
L["Sound Effects"] = "사운드 효과"
L["Source Name"] = "시전자 이름"
L["Source Unit"] = "시전자 유닛"
L["Spacing"] = "간격"
-- L["Spark"] = ""
-- L["Spark Settings"] = ""
-- L["Spark Texture"] = ""
L["Specific Unit"] = "특정 유닛"
L["Spell"] = "주문"
-- L["Spell (Building)"] = ""
L["Spell Name"] = "주문 이름"
L["Spin"] = "회전"
L["Spiral"] = "소용돌이"
-- L["Spiral In And Out"] = ""
-- L["Stacks"] = ""
L["Stance/Form/Aura"] = "태세/폼/오라"
L["Status"] = "상태"
L["Stolen"] = "훔치기"
L["Summon"] = "소환"
L["Swing"] = "스윙"
L["Swing Timer"] = "스윙 타이머"
-- L["Talent selected"] = ""
L["Talent Specialization"] = "특성 전문화"
-- L["Tank"] = ""
-- L["Tanking And Highest"] = ""
-- L["Tanking But Not Highest"] = ""
L["Target"] = "대상"
-- L["Texture Info"] = ""
L["Thick Outline"] = "두꺼운 외곽선"
-- L["Third Tree"] = ""
-- L["Threat Situation"] = ""
L["Thrown"] = "던지기"
-- L["Tier "] = ""
-- L["Timed"] = ""
L["Top"] = "위"
L["Top Left"] = "왼쪽 위"
L["Top Right"] = "오른쪽 위"
L["Top to Bottom"] = "위에서 아래로"
L["Total"] = "종합"
L["Totem"] = "토템"
L["Totem Name"] = "토템 이름"
L["Totem Type"] = "토템 종류"
L["Transmission error"] = "전송 오류"
L["Trigger:"] = "조건:"
L["Trigger Update"] = "조건 업데이트"
L["Undefined"] = "정의 안됨"
L["Unholy Rune #1"] = "부정 룬 #1"
L["Unholy Rune #2"] = "부정 룬 #2"
L["Unholy Runes"] = "부정 룬"
L["Unit"] = "유닛"
-- L["Unit Characteristics"] = ""
L["Unit Destroyed"] = "유닛 파괴됨"
L["Unit Died"] = "유닛 죽음"
L["Up"] = "위로"
-- L["Version error recevied higher"] = ""
L["Version error recevied lower"] = "이 디스플레이는 현재 WeakAuras 버전과 호환되지 않습니다 - %s 버전에서 제작되었으며, 현재 설치된 WeakAuras 버전은 %s 입니다. 이 디스플레이를 보내준 이에게 WeakAuras를 업데이트 하도록 알려주세요."
L["Warlock"] = "흑마법사"
L["Warrior"] = "전사"
L["Water"] = "물"
L["WeakAuras"] = "WeakAuras"
L["WeakAurasModelPaths"] = "WeakAuras - 3D 모델 경로"
-- L["WeakAurasModelPaths .toc Notes"] = ""
L["WeakAurasOptions"] = "WeakAuras - 옵션"
L["WeakAurasOptions .toc Notes"] = "WeakAuras의 GUI 옵션"
L["WeakAuras .toc Notes"] = "버프, 디버프, 혹은 여러가지 조건에 따라 그래픽과 정보를 보여주는 강력하고 종합적인 툴입니다"
L["WeakAurasTutorials"] = "WeakAuras - 설명서"
-- L["WeakAurasTutorials .toc Notes"] = ""
L["Weapon"] = "무기"
L["Weapon Enchant"] = "무기 강화"
L["Whisper"] = "귓속말"
L["Wobble"] = "흔들기"
L["Yell"] = "외치기"
L["Zone"] = "지역"



