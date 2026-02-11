local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "koKR")
if not L then return end

-- Modes
L["mode_players_only"] = "플레이어만"
L["mode_all_enemies"] = "모든 적"

-- Zone Types
L["zone_pvp"] = "PvP 지역"
L["zone_pve"] = "PvE 인스턴스"
L["zone_world"] = "필드"

-- Status
L["current_zone"] = "현재 지역"
L["targeting"] = "대상 선택"
L["temporary_override"] = "임시 변경"
L["override_resets"] = "지역 변경 시 임시 변경이 초기화됩니다"

-- Tab names
L["tab_targeting"] = "대상 선택"
L["tab_keybinds"] = "단축키"
L["tab_appearance"] = "외관"
L["tab_profiles"] = "프로필"

-- Settings: Targeting
L["header_targeting"] = "지역별 대상 선택 방식"
L["targeting_desc"] = "각 지역에서 TAB 키로 선택할 대상을 지정합니다:"
L["mode_players_desc"] = "적 플레이어만 순환합니다 (PvP에 적합)"
L["mode_all_desc"] = "NPC와 소환수를 포함한 모든 적을 순환합니다"
L["pvp_zones_label"] = "PvP 지역 (투기장 및 전장)"
L["pvp_zones_desc"] = "투기장, 전장, 전쟁 모드 전투 지역 등 경쟁 PvP 콘텐츠에서의 대상 선택."
L["pve_zones_label"] = "PvE 인스턴스 (던전 및 공격대)"
L["pve_zones_desc"] = "던전, 공격대, 시나리오에서의 대상 선택."
L["world_zones_label"] = "필드 (퀘스트 및 탐험)"
L["world_zones_desc"] = "필드에서의 대상 선택."

-- Settings: Keybinds
L["header_keybinds"] = "단축키 설정"
L["keybind_desc"] = "적을 순환하는 키를 설정합니다. 버튼을 클릭하고 원하는 키 조합을 누르세요."
L["next_enemy"] = "다음 적"
L["next_enemy_desc"] = "앞에 있는 다음 적을 선택하는 키."
L["prev_enemy"] = "이전 적"
L["prev_enemy_desc"] = "이전 적을 선택하는 키."
L["use_default_keys"] = "기본값으로 TAB / Shift-TAB 사용"
L["use_default_keys_desc"] = "사용자 지정 키가 설정되지 않은 경우 자동으로 TAB과 Shift-TAB을 사용합니다."

-- Settings: Icons
L["header_icons"] = "아이콘 사용자 지정"
L["icon_desc"] = "각 대상 선택 모드에 표시되는 아이콘을 선택합니다. 미니맵 버튼, 드롭다운, 상태 메시지에 표시됩니다."
L["players_icon_label"] = "플레이어만 아이콘"
L["players_icon_desc"] = "플레이어만 선택 시 표시되는 아이콘."
L["all_icon_label"] = "모든 적 아이콘"
L["all_icon_desc"] = "모든 적 선택 시 표시되는 아이콘."

-- Settings: Display
L["header_display"] = "표시 옵션"
L["show_minimap"] = "미니맵 버튼 표시"
L["show_minimap_desc"] = "빠른 모드 전환과 상태 확인을 위한 미니맵 버튼을 표시합니다."
L["silent_mode"] = "조용한 모드 (채팅 메시지 숨기기)"
L["silent_mode_desc"] = "지역 변경 시 채팅 창의 상태 업데이트를 숨깁니다. 오류 메시지는 계속 표시됩니다."

-- Settings: Help
L["header_help"] = "빠른 도움말"
L["help_slash"] = "슬래시 명령어:"
L["help_slash_desc"] = "/pvptab 또는 /ptt — 설정 패널 열기"
L["help_minimap"] = "미니맵 버튼:"
L["help_left_click"] = "좌클릭 — 대상 선택 모드 임시 전환"
L["help_right_click"] = "우클릭 — 설정 열기"
L["help_temp_info"] = "임시 변경은 지역 변경이나 UI 재로드 시 초기화됩니다."

-- Tooltip
L["tooltip_next_target"] = "다음 대상:"
L["tooltip_prev_target"] = "이전 대상:"

-- Messages
L["msg_override"] = "[임시 변경] 현재 선택:"
L["msg_combat_error"] = "전투 중에는 설정을 열 수 없습니다!"
L["msg_settings_unavailable"] = "설정 패널을 사용할 수 없습니다."

-- Minimap tooltip
L["minimap_left_click"] = "좌클릭"
L["minimap_right_click"] = "우클릭"
L["minimap_toggle_mode"] = "빠른 모드 전환"
L["minimap_open_settings"] = "설정 열기"
