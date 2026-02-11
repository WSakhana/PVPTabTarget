local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "enUS", true)
if not L then return end

-- Modes
L["mode_players_only"] = "Players Only"
L["mode_all_enemies"] = "All Enemies"

-- Zone Types
L["zone_pvp"] = "PvP Zone"
L["zone_pve"] = "PvE Instance"
L["zone_world"] = "Open World"

-- Status
L["current_zone"] = "Current Zone"
L["targeting"] = "Targeting"
L["temporary_override"] = "Temporary Override"
L["override_resets"] = "Override resets on zone change"

-- Tab names
L["tab_targeting"] = "Targeting"
L["tab_keybinds"] = "Keybinds"
L["tab_appearance"] = "Appearance"
L["tab_profiles"] = "Profiles"

-- Settings: Targeting
L["header_targeting"] = "Targeting Behavior by Zone"
L["targeting_desc"] = "Choose what your TAB key targets in different zones:"
L["mode_players_desc"] = "Only cycles through enemy players (great for PvP)"
L["mode_all_desc"] = "Cycles through all enemies including NPCs and pets"
L["pvp_zones_label"] = "PvP Zones (Arenas & Battlegrounds)"
L["pvp_zones_desc"] = "What to target in competitive PvP content like arenas, battlegrounds, and war mode combat areas."
L["pve_zones_label"] = "PvE Instances (Dungeons & Raids)"
L["pve_zones_desc"] = "What to target in dungeons, raids, and scenarios."
L["world_zones_label"] = "Open World (Questing & Exploration)"
L["world_zones_desc"] = "What to target while out in the open world."

-- Settings: Keybinds
L["header_keybinds"] = "Keybind Settings"
L["keybind_desc"] = "Customize which keys cycle through enemies. Click a button and press your desired key combination."
L["next_enemy"] = "Next Enemy"
L["next_enemy_desc"] = "Key to target the next enemy in front of you."
L["prev_enemy"] = "Previous Enemy"
L["prev_enemy_desc"] = "Key to target the previous enemy."
L["use_default_keys"] = "Use TAB / Shift-TAB as fallback"
L["use_default_keys_desc"] = "If no custom keybinds are set above, automatically use TAB and Shift-TAB."

-- Settings: Icons
L["header_icons"] = "Icon Customization"
L["icon_desc"] = "Choose the icons displayed for each targeting mode. These icons appear on the minimap button, in dropdowns, and in status messages."
L["players_icon_label"] = "Players Only Icon"
L["players_icon_desc"] = "Icon to display when targeting players only."
L["all_icon_label"] = "All Enemies Icon"
L["all_icon_desc"] = "Icon to display when targeting all enemies."

-- Settings: Display
L["header_display"] = "Display Options"
L["show_minimap"] = "Show Minimap Button"
L["show_minimap_desc"] = "Display a minimap button for quick mode toggling and status at a glance."
L["silent_mode"] = "Quiet Mode (hide chat messages)"
L["silent_mode_desc"] = "Stop showing status updates in the chat window when zones change. Error messages will still appear."

-- Settings: Help
L["header_help"] = "Quick Help"
L["help_slash"] = "Slash Commands:"
L["help_slash_desc"] = "/pvptab or /ptt — Open this settings panel"
L["help_minimap"] = "Minimap Button:"
L["help_left_click"] = "Left-click — Temporarily toggle targeting mode"
L["help_right_click"] = "Right-click — Open settings"
L["help_temp_info"] = "Temporary overrides reset when you change zones or reload your UI."

-- Tooltip
L["tooltip_next_target"] = "Next Target:"
L["tooltip_prev_target"] = "Previous Target:"

-- Messages
L["msg_override"] = "[Override] Now targeting:"
L["msg_combat_error"] = "Cannot open settings during combat!"
L["msg_settings_unavailable"] = "Settings panel not available."

-- Minimap tooltip
L["minimap_left_click"] = "Left-Click"
L["minimap_right_click"] = "Right-Click"
L["minimap_toggle_mode"] = "Quick toggle mode"
L["minimap_open_settings"] = "Open settings"
