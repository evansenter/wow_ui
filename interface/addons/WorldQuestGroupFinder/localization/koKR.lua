local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestGroupFinder", "koKR") 
if not L then return end 

L["WQGF_ALREADY_IS_GROUP_FOR_WQ"] = "당신이 이미 해당 전역퀘스트의 그룹에 속해있습니다."
L["WQGF_ALREADY_QUEUED_BG"] = "현재 전장에서 대기 중입니다. 대기열을 나가서 다시 시도하십시오."
L["WQGF_ALREADY_QUEUED_DF"] = "현재 그룹 파인더에 대기 중입니다. 대기열을 나가 다시 시도하십시오."
L["WQGF_ALREADY_QUEUED_RF"] = "현재 공격대 찾기에 대기 중입니다. 대기열을 나가 다시 시도하십시오."
L["WQGF_APPLIED_TO_GROUPS"] = "전역 퀘스트 | c00bfffff % s | c00ffffff에 대해 | c00bfffff % d | c00ffffff 그룹에 적용되었습니다."
L["WQGF_AUTO_LEAVING_DIALOG"] = [=[전역 퀘스트를 완료했으며 그룹을 % d 초 뒤에 떠납니다.

안녕히 가세요!]=]
L["WQGF_CANCEL"] = "취소"
L["WQGF_CANNOT_DO_WQ_IN_GROUP"] = "이 전역 퀘스트는 그룹으로 수행 될 수 없습니다."
L["WQGF_CANNOT_DO_WQ_TYPE_IN_GROUP"] = "이러한 유형의 전역 퀘스트는 그룹으로 수행 될 수 없습니다."
L["WQGF_CONFIG_AUTO_ACCEPT_INVITES_ENABLE"] = "전투 중이 아닌 경우 WQGF 그룹에 대한 그룹 초대를 자동으로 수락합니다."
L["WQGF_CONFIG_AUTO_ACCEPT_INVITES_HOVER"] = "전투 중에 있지 않을 때 그룹 초대를 자동으로 수락합니다."
L["WQGF_CONFIG_AUTO_ACCEPT_INVITES_TITLE"] = "그룹 초대 자동 수락"
L["WQGF_CONFIG_AUTOINVITE"] = "자동 초대"
L["WQGF_CONFIG_AUTOINVITE_EVERYONE"] = "모두 자동 초대"
L["WQGF_CONFIG_AUTOINVITE_EVERYONE_HOVER"] = "모든 신청자는 5 명까지 자동으로 그룹에 초대됩니다."
L["WQGF_CONFIG_AUTOINVITE_WQGF_USERS"] = "WQGF 사용자는 자동 초대"
L["WQGF_CONFIG_AUTOINVITE_WQGF_USERS_HOVER"] = "전역 퀘스트 그룹 파인더 사용자는 자동으로 그룹에 초대됩니다."
L["WQGF_CONFIG_LANGUAGE_FILTER_ENABLE"] = "모든 언어 그룹 검색 (그룹 찾기 도구 언어 선택 무시)"
L["WQGF_CONFIG_LANGUAGE_FILTER_HOVER"] = "언어에 관계없이 항상 사용 가능한 모든 그룹을 검색합니다."
L["WQGF_CONFIG_LANGUAGE_FILTER_TITLE"] = "그룹 검색 언어 필터"
L["WQGF_CONFIG_LOGIN_MESSAGE_TITLE"] = "WQGF 로그인 메시지"
L["WQGF_CONFIG_LOGIN_MESSAGE_TITLE_ENABLE"] = "로그인시 WQGF 초기화 메시지 숨기기"
L["WQGF_CONFIG_LOGIN_MESSAGE_TITLE_HOVER"] = "더 이상 로그인 할 때 WQGF 메시지를 표시하지 않습니다."
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_AUTO_ENABLE"] = "그룹에없는 경우 자동으로 검색 시작"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_AUTO_HOVER"] = "새로운 전역 퀘스트 지역에 입장하면 그룹이 자동으로 검색됩니다."
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_ENABLE"] = "새로운 전역 퀘스트 지역 감지시 사용"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_HOVER"] = "새로운 전역 퀘스트 지역을 입력 할 때 그룹을 검색할지 묻는 메시지가 나타납니다."
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_SWITCH_ENABLE"] = "이미 다른 전역 퀘스트에 그룹화되어 있다면 제안하지 마십시오."
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_TITLE"] = "처음으로 전역 퀘스트 영역에 입장 할 때 그룹 검색을 제안하십시오."
L["WQGF_CONFIG_PAGE_CREDITS"] = "Robou, EU-Hyjal이 당신에게 가져 왔습니다."
L["WQGF_CONFIG_PARTY_NOTIFICATION_ENABLE"] = "파티 알림 사용"
L["WQGF_CONFIG_PARTY_NOTIFICATION_HOVER"] = "전역 퀘스트가 완료되면 메시지가 파티에 전송됩니다."
L["WQGF_CONFIG_PARTY_NOTIFICATION_TITLE"] = "전역 퀘스트가 완료되면 그룹에 알립니다."
L["WQGF_CONFIG_PVP_REALMS_ENABLE"] = "PvP 영역에서 그룹 가입 방지"
L["WQGF_CONFIG_PVP_REALMS_HOVER"] = "PvP 영역에서 그룹 가입을 피할 것입니다. (이 매개 변수는 PvP 영역의 문자에서는 무시됩니다.)"
L["WQGF_CONFIG_PVP_REALMS_TITLE"] = "PvP 영역"
L["WQGF_CONFIG_SILENT_MODE_ENABLE"] = "자동 모드 사용"
L["WQGF_CONFIG_SILENT_MODE_HOVER"] = "자동 모드가 활성화되면 가장 중요한 WQGF 메시지만 표시됩니다."
L["WQGF_CONFIG_SILENT_MODE_TITLE"] = "무음 모드"
L["WQGF_CONFIG_WQ_END_DIALOG_AUTO_LEAVE_ENABLE"] = "10 초 후 그룹에서 자동으로 나가기"
L["WQGF_CONFIG_WQ_END_DIALOG_AUTO_LEAVE_HOVER"] = "전역 퀘스트가 완료되면 10 초 후에 자동으로 그룹을 탈퇴합니다."
L["WQGF_CONFIG_WQ_END_DIALOG_ENABLE"] = "전역 퀘스트 종료 대화 상자 사용"
L["WQGF_CONFIG_WQ_END_DIALOG_HOVER"] = "전역 퀘스트가 완료되면 그룹을 탈퇴하거나 탈퇴를 제안합니다."
L["WQGF_CONFIG_WQ_END_DIALOG_TITLE"] = "전역 퀘스트가 완료되면 그룹에서 나가기위한 대화 상자 표시"
L["WQGF_DEBUG_CONFIGURATION_DUMP"] = "문자 구성 :"
L["WQGF_DEBUG_CURRENT_WQ_ID"] = "현재 전역 퀘스트 ID는 | c00bfffff % s | c00ffffff입니다."
L["WQGF_DEBUG_MODE_DISABLED"] = "이제 디버그 모드가 비활성화되었습니다."
L["WQGF_DEBUG_MODE_ENABLED"] = "이제 디버그 모드가 활성화되었습니다."
L["WQGF_DEBUG_NO_CURRENT_WQ_ID"] = "현재 전역 퀘스트 없음."
L["WQGF_DEBUG_WQ_ZONES_ENTERED"] = "전역 퀘스트 지역 세션에 참가했습니다. :"
L["WQGF_DELIST"] = "목록에서 빼다."
L["WQGF_GLOBAL_CONFIGURATION"] = "전역 구성 :"
L["WQGF_GROUP_CREATION_ERROR"] = "새 그룹 찾기 항목을 작성하려고 할 때 오류가 발생했습니다. 다시 시도하십시오."
L["WQGF_GROUP_NO_LONGER_DOING_WQ"] = "당신의 그룹은 더 이상 전역 퀘스트 | c00bfffff % s | c00ffffff을 수행하지 않습니다."
L["WQGF_GROUP_NOW_DOING_WQ"] = "당신의 그룹은 현재 전역 퀘스트 | c00bfffff % s | c00ffffff을 수행 중입니다."
L["WQGF_GROUP_NOW_DOING_WQ_ALREADY_COMPLETE"] = "당신의 그룹은 현재 전역 퀘스트 | c00bfffff % s | c00ffffff을 수행 중입니다. 이미 전역 퀘스트를 완료하셨습니다."
L["WQGF_GROUP_NOW_DOING_WQ_NOT_ELIGIBLE"] = "당신의 그룹은 현재 전역 퀘스트 | c00bfffff % s | c00ffffff을 수행 중입니다. 이 전역 퀘스트를 수행 할 자격이 없습니다."
L["WQGF_INIT_MSG"] = "목표 추적 창에서 전역 퀘스트의 가운데 마우스 버튼을 클릭하여 그룹을 검색하십시오."
L["WQGF_JOINED_WQ_GROUP"] = "| c00bfffff % s | c00ffffff에 대한 | c00bfffff % s | c00ffffff의 그룹에 가입하셨습니다. 즐기세요!"
L["WQGF_LEADERS_BL_CLEARED"] = "리더들의 차단내역이 삭제되었습니다."
L["WQGF_LEAVE"] = "떠나기"
L["WQGF_NEW_ENTRY_CREATED"] = "| c00bfffff % s | c00ffffff에서 | c00bfffff % s | c00ffffff에 대한 새 그룹 찾기 항목이 작성되었습니다"
L["WQGF_NO"] = "아니요"
L["WQGF_NO_APPLICATIONS_ANSWERED"] = "| c00bfffff % s | c00ffffff에 대한 당신의 애드온 중 어느 하나 응답이 없습니다. 새 그룹을 찾고 있습니다 ..."
L["WQGF_NO_APPLY_BLACKLIST"] = "리더가 차단내역에 올랐기 때문에 % d 개 그룹에 적용되지 않았습니다. 차단내역를 지우려면 c00bfffff / wqgf unbl | c00ffffff를 사용할 수 있습니다."
L["WQGF_PLAYER_IS_NOT_LEADER"] = "당신은 그룹 리더가 아닙니다."
L["WQGF_RAID_MODE_WARNING"] = "| c0000ffffWARNING : | c00ffffff이 그룹은 레이드파티이므로 전역 퀘스트를 완료 할 수 없습니다. 가능한 경우 리더에게 파티 모드로 다시 전환하도록 요청해야합니다. 그룹이 리더가되면 파티 모드로 자동 전환됩니다."
L["WQGF_SEARCH_OR_CREATE_GROUP"] = "그룹 검색 또는 생성"
L["WQGF_SEARCHING_FOR_GROUP"] = "전역 퀘스트 그룹 찾기 | c00bfffff % s | c00ffffff ..."
L["WQGF_SLASH_COMMANDS_1"] = "| c00bfffff 슬래시 명령 (/ wqgf) :"
L["WQGF_SLASH_COMMANDS_2"] = "| c00bfffff / wqgf config : 열린 addon 구성"
L["WQGF_SLASH_COMMANDS_3"] = "| c00bfffff / wqgf unbl : 리더 차단내역 지우기"
L["WQGF_START_ANOTHER_WQ_DIALOG"] = [=[현재 다른 전역 퀘스트를 위해 그룹화되었습니다.

다른 것을 시작 하시겠습니까?]=]
L["WQGF_STAY"] = "머물기"
--Translation missing 
L["WQGF_TRANSLATION_INFO"] = "Interested in translating WQGF to your language? Feel free to contact me on Curse!"
L["WQGF_USER_JOINED"] = "전역 퀘스트 그룹 파인더 사용자가 그룹에 가입했습니다!"
L["WQGF_USERS_JOINED"] = "전역 퀘스트 그룹 파인더 사용자가 그룹에 가입했습니다!"
L["WQGF_WQ_AREA_ENTERED_ALREADY_GROUPED_DIALOG"] = [=[새로운 전역 퀘스트 지역에 진입하였지만, 현재 다른 전역 퀘스트 그룹에 속해있습니다.

그룹을 떠나고 "%s"의 그룹을 찾으시겠습니까?]=]
L["WQGF_WQ_AREA_ENTERED_DIALOG"] = [=[새로운 전역 퀘스트 지역에 진입하였습니다.

"%s"의 그룹을 찾으시겠습니까?]=]
L["WQGF_WQ_COMPLETE_LEAVE_DIALOG"] = [=[전역 퀘스트를 완료하였습니다.

그룹을 떠나시겠습니까?]=]
L["WQGF_WQ_COMPLETE_LEAVE_OR_DELIST_DIALOG"] = [=[전역 퀘스트를 완료했습니다.

그룹을 떠나거나 그룹 찾기에서 탈퇴 하시겠습니까?]=]
L["WQGF_WQ_GROUP_APPLY_CANCELLED"] = "| c00bfffff % s | c00ffffff에 대한 | c00bfffff % s | c00ffffff의 그룹 신청을 취소했습니다. WQGF는 리더 차단 내역를 다시 이동 시키거나 지울 때까지이 그룹에 다시 가입하지 않습니다."
L["WQGF_WQ_GROUP_DESCRIPTION"] = "% s에서 전역 퀘스트 \"% s\"을 (를)사용하고 있습니다. World Quest Group Finder % s에 의해 자동 생성 되었습니다."
L["WQGF_WRONG_LOCATION_FOR_WQ"] = "당신은 이 전역 퀘스트를 위한 올바른 위치에 있지 않습니다."
L["WQGF_YES"] = "예"