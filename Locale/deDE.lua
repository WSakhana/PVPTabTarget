local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "deDE")
if not L then return end

-- Modes
L["mode_players_only"] = "Nur Spieler"
L["mode_all_enemies"] = "Alle Feinde"

-- Zone Types
L["zone_pvp"] = "PvP-Zone"
L["zone_pve"] = "PvE-Instanz"
L["zone_world"] = "Offene Welt"

-- Status
L["current_zone"] = "Aktuelle Zone"
L["targeting"] = "Zielauswahl"
L["temporary_override"] = "Temporäre Überschreibung"
L["override_resets"] = "Überschreibung wird beim Zonenwechsel zurückgesetzt"

-- Tab names
L["tab_targeting"] = "Zielauswahl"
L["tab_keybinds"] = "Tastenbelegung"
L["tab_appearance"] = "Darstellung"
L["tab_profiles"] = "Profile"

-- Settings: Targeting
L["header_targeting"] = "Zielverhalten nach Zone"
L["targeting_desc"] = "Wähle, was deine TAB-Taste in verschiedenen Zonen anvisiert:"
L["mode_players_desc"] = "Wechselt nur zwischen feindlichen Spielern (ideal für PvP)"
L["mode_all_desc"] = "Wechselt zwischen allen Feinden einschließlich NPCs und Begleitern"
L["pvp_zones_label"] = "PvP-Zonen (Arenen und Schlachtfelder)"
L["pvp_zones_desc"] = "Zielauswahl in kompetitiven PvP-Inhalten wie Arenen, Schlachtfeldern und Kriegsmodus-Kampfgebieten."
L["pve_zones_label"] = "PvE-Instanzen (Dungeons und Schlachtzüge)"
L["pve_zones_desc"] = "Zielauswahl in Dungeons, Schlachtzügen und Szenarien."
L["world_zones_label"] = "Offene Welt (Quests und Erkundung)"
L["world_zones_desc"] = "Zielauswahl in der offenen Welt."

-- Settings: Keybinds
L["header_keybinds"] = "Tastenbelegung"
L["keybind_desc"] = "Passe die Tasten zum Durchschalten der Feinde an. Klicke auf eine Schaltfläche und drücke die gewünschte Tastenkombination."
L["next_enemy"] = "Nächster Feind"
L["next_enemy_desc"] = "Taste zum Anvisieren des nächsten Feindes vor dir."
L["prev_enemy"] = "Vorheriger Feind"
L["prev_enemy_desc"] = "Taste zum Anvisieren des vorherigen Feindes."
L["use_default_keys"] = "TAB / Umschalt-TAB als Standard verwenden"
L["use_default_keys_desc"] = "Wenn keine benutzerdefinierten Tasten festgelegt sind, automatisch TAB und Umschalt-TAB verwenden."

-- Settings: Icons
L["header_icons"] = "Symbol-Anpassung"
L["icon_desc"] = "Wähle die Symbole für jeden Zielmodus. Diese Symbole erscheinen auf der Minikartenachaltfläche, in Dropdowns und in Statusmeldungen."
L["players_icon_label"] = "Symbol für Nur Spieler"
L["players_icon_desc"] = "Symbol, das beim Anvisieren von nur Spielern angezeigt wird."
L["all_icon_label"] = "Symbol für Alle Feinde"
L["all_icon_desc"] = "Symbol, das beim Anvisieren aller Feinde angezeigt wird."

-- Settings: Display
L["header_display"] = "Anzeigeoptionen"
L["show_minimap"] = "Minikartenknopf anzeigen"
L["show_minimap_desc"] = "Zeigt einen Knopf auf der Minikarte zum schnellen Umschalten des Modus."
L["silent_mode"] = "Stiller Modus (Chat-Nachrichten ausblenden)"
L["silent_mode_desc"] = "Keine Statusmeldungen im Chat anzeigen, wenn sich die Zone ändert. Fehlermeldungen werden weiterhin angezeigt."

-- Settings: Help
L["header_help"] = "Schnellhilfe"
L["help_slash"] = "Slash-Befehle:"
L["help_slash_desc"] = "/pvptab oder /ptt — Dieses Einstellungsfenster öffnen"
L["help_minimap"] = "Minikartenknopf:"
L["help_left_click"] = "Linksklick — Zielmodus vorübergehend umschalten"
L["help_right_click"] = "Rechtsklick — Einstellungen öffnen"
L["help_temp_info"] = "Temporäre Überschreibungen werden beim Zonenwechsel oder Neuladen der Oberfläche zurückgesetzt."

-- Tooltip
L["tooltip_next_target"] = "Nächstes Ziel:"
L["tooltip_prev_target"] = "Vorheriges Ziel:"

-- Messages
L["msg_override"] = "[Überschreibung] Aktuelles Ziel:"
L["msg_combat_error"] = "Einstellungen können im Kampf nicht geöffnet werden!"
L["msg_settings_unavailable"] = "Einstellungsfenster nicht verfügbar."

-- Minimap tooltip
L["minimap_left_click"] = "Linksklick"
L["minimap_right_click"] = "Rechtsklick"
L["minimap_toggle_mode"] = "Modus schnell umschalten"
L["minimap_open_settings"] = "Einstellungen öffnen"
