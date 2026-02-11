local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "ruRU")
if not L then return end

-- Modes
L["mode_players_only"] = "Только игроки"
L["mode_all_enemies"] = "Все враги"

-- Zone Types
L["zone_pvp"] = "PvP-зона"
L["zone_pve"] = "PvE-подземелье"
L["zone_world"] = "Открытый мир"

-- Status
L["current_zone"] = "Текущая зона"
L["targeting"] = "Выбор цели"
L["temporary_override"] = "Временная замена"
L["override_resets"] = "Замена сбрасывается при смене зоны"

-- Tab names
L["tab_targeting"] = "Цели"
L["tab_keybinds"] = "Клавиши"
L["tab_appearance"] = "Внешний вид"
L["tab_profiles"] = "Профили"

-- Settings: Targeting
L["header_targeting"] = "Поведение выбора целей по зонам"
L["targeting_desc"] = "Выберите, кого нацеливает клавиша TAB в разных зонах:"
L["mode_players_desc"] = "Переключает только между вражескими игроками (отлично для PvP)"
L["mode_all_desc"] = "Переключает между всеми врагами, включая НИП и питомцев"
L["pvp_zones_label"] = "PvP-зоны (Арены и Поля боя)"
L["pvp_zones_desc"] = "Кого нацеливать в соревновательном PvP-контенте: арены, поля боя и зоны боевых действий в режиме войны."
L["pve_zones_label"] = "PvE-подземелья (Подземелья и Рейды)"
L["pve_zones_desc"] = "Кого нацеливать в подземельях, рейдах и сценариях."
L["world_zones_label"] = "Открытый мир (Задания и Исследования)"
L["world_zones_desc"] = "Кого нацеливать в открытом мире."

-- Settings: Keybinds
L["header_keybinds"] = "Настройка клавиш"
L["keybind_desc"] = "Настройте клавиши для переключения между врагами. Нажмите на кнопку и введите нужную комбинацию клавиш."
L["next_enemy"] = "Следующий враг"
L["next_enemy_desc"] = "Клавиша для выбора следующего врага перед вами."
L["prev_enemy"] = "Предыдущий враг"
L["prev_enemy_desc"] = "Клавиша для выбора предыдущего врага."
L["use_default_keys"] = "Использовать TAB / Shift-TAB по умолчанию"
L["use_default_keys_desc"] = "Если пользовательские клавиши не назначены, автоматически использовать TAB и Shift-TAB."

-- Settings: Icons
L["header_icons"] = "Настройка значков"
L["icon_desc"] = "Выберите значки для каждого режима выбора целей. Они отображаются на кнопке мини-карты, в выпадающих меню и в сообщениях о состоянии."
L["players_icon_label"] = "Значок «Только игроки»"
L["players_icon_desc"] = "Значок, отображаемый при нацеливании только на игроков."
L["all_icon_label"] = "Значок «Все враги»"
L["all_icon_desc"] = "Значок, отображаемый при нацеливании на всех врагов."

-- Settings: Display
L["header_display"] = "Параметры отображения"
L["show_minimap"] = "Показать кнопку мини-карты"
L["show_minimap_desc"] = "Отображает кнопку на мини-карте для быстрого переключения режима."
L["silent_mode"] = "Тихий режим (скрыть сообщения чата)"
L["silent_mode_desc"] = "Не показывать обновления состояния в чате при смене зон. Сообщения об ошибках по-прежнему будут отображаться."

-- Settings: Help
L["header_help"] = "Быстрая справка"
L["help_slash"] = "Slash-команды:"
L["help_slash_desc"] = "/pvptab или /ptt — Открыть панель настроек"
L["help_minimap"] = "Кнопка мини-карты:"
L["help_left_click"] = "Левый клик — Временно переключить режим выбора целей"
L["help_right_click"] = "Правый клик — Открыть настройки"
L["help_temp_info"] = "Временные замены сбрасываются при смене зоны или перезагрузке интерфейса."

-- Tooltip
L["tooltip_next_target"] = "Следующая цель:"
L["tooltip_prev_target"] = "Предыдущая цель:"

-- Messages
L["msg_override"] = "[Замена] Текущий выбор:"
L["msg_combat_error"] = "Невозможно открыть настройки во время боя!"
L["msg_settings_unavailable"] = "Панель настроек недоступна."

-- Minimap tooltip
L["minimap_left_click"] = "Левый клик"
L["minimap_right_click"] = "Правый клик"
L["minimap_toggle_mode"] = "Быстрое переключение режима"
L["minimap_open_settings"] = "Открыть настройки"
