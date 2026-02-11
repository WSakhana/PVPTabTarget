local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "zhTW")
if not L then return end

-- Modes
L["mode_players_only"] = "僅玩家"
L["mode_all_enemies"] = "所有敵人"

-- Zone Types
L["zone_pvp"] = "PvP 區域"
L["zone_pve"] = "PvE 副本"
L["zone_world"] = "開放世界"

-- Status
L["current_zone"] = "目前區域"
L["targeting"] = "選取目標"
L["temporary_override"] = "暫時覆蓋"
L["override_resets"] = "切換區域時覆蓋將被重置"

-- Tab names
L["tab_targeting"] = "目標選取"
L["tab_keybinds"] = "按鍵綁定"
L["tab_appearance"] = "外觀"
L["tab_profiles"] = "設定檔"

-- Settings: Targeting
L["header_targeting"] = "按區域選取目標行為"
L["targeting_desc"] = "選擇您的 TAB 鍵在不同區域中選取什麼目標："
L["mode_players_desc"] = "僅在敵方玩家之間切換（適合 PvP）"
L["mode_all_desc"] = "在所有敵人之間切換，包括 NPC 和寵物"
L["pvp_zones_label"] = "PvP 區域（競技場和戰場）"
L["pvp_zones_desc"] = "在競技場、戰場和戰爭模式戰鬥區域等競技 PvP 內容中選取什麼目標。"
L["pve_zones_label"] = "PvE 副本（地下城和團隊副本）"
L["pve_zones_desc"] = "在地下城、團隊副本和場景戰役中選取什麼目標。"
L["world_zones_label"] = "開放世界（任務和探索）"
L["world_zones_desc"] = "在開放世界中選取什麼目標。"

-- Settings: Keybinds
L["header_keybinds"] = "按鍵設定"
L["keybind_desc"] = "自訂用於切換敵人的按鍵。點擊按鈕並按下您想要的組合鍵。"
L["next_enemy"] = "下一個敵人"
L["next_enemy_desc"] = "選取前方下一個敵人的按鍵。"
L["prev_enemy"] = "上一個敵人"
L["prev_enemy_desc"] = "選取上一個敵人的按鍵。"
L["use_default_keys"] = "使用 TAB / Shift-TAB 作為預設"
L["use_default_keys_desc"] = "如果未設定自訂按鍵，自動使用 TAB 和 Shift-TAB。"

-- Settings: Icons
L["header_icons"] = "圖示自訂"
L["icon_desc"] = "選擇每種選取模式顯示的圖示。這些圖示會出現在小地圖按鈕、下拉選單和狀態訊息中。"
L["players_icon_label"] = "僅玩家圖示"
L["players_icon_desc"] = "僅選取玩家時顯示的圖示。"
L["all_icon_label"] = "所有敵人圖示"
L["all_icon_desc"] = "選取所有敵人時顯示的圖示。"

-- Settings: Display
L["header_display"] = "顯示選項"
L["show_minimap"] = "顯示小地圖按鈕"
L["show_minimap_desc"] = "在小地圖上顯示一個按鈕，用於快速切換模式和查看狀態。"
L["silent_mode"] = "安靜模式（隱藏聊天訊息）"
L["silent_mode_desc"] = "切換區域時不再在聊天視窗顯示狀態更新。錯誤訊息仍會顯示。"

-- Settings: Help
L["header_help"] = "快速說明"
L["help_slash"] = "斜線指令："
L["help_slash_desc"] = "/pvptab 或 /ptt — 開啟此設定面板"
L["help_minimap"] = "小地圖按鈕："
L["help_left_click"] = "左鍵點擊 — 暫時切換選取模式"
L["help_right_click"] = "右鍵點擊 — 開啟設定"
L["help_temp_info"] = "暫時覆蓋將在您切換區域或重新載入介面時重置。"

-- Tooltip
L["tooltip_next_target"] = "下一個目標："
L["tooltip_prev_target"] = "上一個目標："

-- Messages
L["msg_override"] = "[覆蓋] 目前選取："
L["msg_combat_error"] = "無法在戰鬥中開啟設定！"
L["msg_settings_unavailable"] = "設定面板不可用。"

-- Minimap tooltip
L["minimap_left_click"] = "左鍵點擊"
L["minimap_right_click"] = "右鍵點擊"
L["minimap_toggle_mode"] = "快速切換模式"
L["minimap_open_settings"] = "開啟設定"
