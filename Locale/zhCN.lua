local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "zhCN")
if not L then return end

-- Modes
L["mode_players_only"] = "仅玩家"
L["mode_all_enemies"] = "所有敌人"

-- Zone Types
L["zone_pvp"] = "PvP 区域"
L["zone_pve"] = "PvE 副本"
L["zone_world"] = "开放世界"

-- Status
L["current_zone"] = "当前区域"
L["targeting"] = "选取目标"
L["temporary_override"] = "临时覆盖"
L["override_resets"] = "切换区域时覆盖将被重置"

-- Tab names
L["tab_targeting"] = "目标选取"
L["tab_keybinds"] = "按键绑定"
L["tab_appearance"] = "外观"
L["tab_profiles"] = "配置文件"

-- Settings: Targeting
L["header_targeting"] = "按区域选取目标行为"
L["targeting_desc"] = "选择您的 TAB 键在不同区域中选取什么目标："
L["mode_players_desc"] = "仅在敌方玩家之间切换（适合 PvP）"
L["mode_all_desc"] = "在所有敌人之间切换，包括 NPC 和宠物"
L["pvp_zones_label"] = "PvP 区域（竞技场和战场）"
L["pvp_zones_desc"] = "在竞技场、战场和战争模式战斗区域等竞技 PvP 内容中选取什么目标。"
L["pve_zones_label"] = "PvE 副本（地下城和团队副本）"
L["pve_zones_desc"] = "在地下城、团队副本和场景战役中选取什么目标。"
L["world_zones_label"] = "开放世界（任务和探索）"
L["world_zones_desc"] = "在开放世界中选取什么目标。"

-- Settings: Keybinds
L["header_keybinds"] = "按键设置"
L["keybind_desc"] = "自定义用于切换敌人的按键。点击按钮并按下您想要的组合键。"
L["next_enemy"] = "下一个敌人"
L["next_enemy_desc"] = "选取前方下一个敌人的按键。"
L["prev_enemy"] = "上一个敌人"
L["prev_enemy_desc"] = "选取上一个敌人的按键。"
L["use_default_keys"] = "使用 TAB / Shift-TAB 作为默认"
L["use_default_keys_desc"] = "如果未设置自定义按键，自动使用 TAB 和 Shift-TAB。"

-- Settings: Icons
L["header_icons"] = "图标自定义"
L["icon_desc"] = "选择每种选取模式显示的图标。这些图标会出现在小地图按钮、下拉菜单和状态消息中。"
L["players_icon_label"] = "仅玩家图标"
L["players_icon_desc"] = "仅选取玩家时显示的图标。"
L["all_icon_label"] = "所有敌人图标"
L["all_icon_desc"] = "选取所有敌人时显示的图标。"

-- Settings: Display
L["header_display"] = "显示选项"
L["show_minimap"] = "显示小地图按钮"
L["show_minimap_desc"] = "在小地图上显示一个按钮，用于快速切换模式和查看状态。"
L["silent_mode"] = "安静模式（隐藏聊天消息）"
L["silent_mode_desc"] = "切换区域时不再在聊天窗口显示状态更新。错误消息仍会显示。"

-- Settings: Help
L["header_help"] = "快速帮助"
L["help_slash"] = "斜杠命令："
L["help_slash_desc"] = "/pvptab 或 /ptt — 打开此设置面板"
L["help_minimap"] = "小地图按钮："
L["help_left_click"] = "左键点击 — 临时切换选取模式"
L["help_right_click"] = "右键点击 — 打开设置"
L["help_temp_info"] = "临时覆盖将在您切换区域或重新加载界面时重置。"

-- Tooltip
L["tooltip_next_target"] = "下一个目标："
L["tooltip_prev_target"] = "上一个目标："

-- Messages
L["msg_override"] = "[覆盖] 当前选取："
L["msg_combat_error"] = "无法在战斗中打开设置！"
L["msg_settings_unavailable"] = "设置面板不可用。"

-- Minimap tooltip
L["minimap_left_click"] = "左键点击"
L["minimap_right_click"] = "右键点击"
L["minimap_toggle_mode"] = "快速切换模式"
L["minimap_open_settings"] = "打开设置"
