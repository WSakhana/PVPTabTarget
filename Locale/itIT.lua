local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "itIT")
if not L then return end

-- Modes
L["mode_players_only"] = "Solo giocatori"
L["mode_all_enemies"] = "Tutti i nemici"

-- Zone Types
L["zone_pvp"] = "Zona PvP"
L["zone_pve"] = "Istanza PvE"
L["zone_world"] = "Mondo aperto"

-- Status
L["current_zone"] = "Zona attuale"
L["targeting"] = "Selezione bersaglio"
L["temporary_override"] = "Sostituzione temporanea"
L["override_resets"] = "La sostituzione viene ripristinata al cambio zona"

-- Tab names
L["tab_targeting"] = "Bersagli"
L["tab_keybinds"] = "Tasti"
L["tab_appearance"] = "Aspetto"
L["tab_profiles"] = "Profili"

-- Settings: Targeting
L["header_targeting"] = "Comportamento di selezione per zona"
L["targeting_desc"] = "Scegli cosa seleziona il tasto TAB nelle diverse zone:"
L["mode_players_desc"] = "Alterna solo tra giocatori nemici (ideale per il PvP)"
L["mode_all_desc"] = "Alterna tra tutti i nemici inclusi PNG e compagni"
L["pvp_zones_label"] = "Zone PvP (Arene e Campi di battaglia)"
L["pvp_zones_desc"] = "Cosa selezionare in contenuti PvP competitivi come arene, campi di battaglia e zone di combattimento in Modalità Guerra."
L["pve_zones_label"] = "Istanze PvE (Spedizioni e Incursioni)"
L["pve_zones_desc"] = "Cosa selezionare in spedizioni, incursioni e scenari."
L["world_zones_label"] = "Mondo aperto (Missioni ed Esplorazione)"
L["world_zones_desc"] = "Cosa selezionare nel mondo aperto."

-- Settings: Keybinds
L["header_keybinds"] = "Impostazioni tasti"
L["keybind_desc"] = "Personalizza i tasti per alternare tra i nemici. Clicca su un pulsante e premi la combinazione di tasti desiderata."
L["next_enemy"] = "Nemico successivo"
L["next_enemy_desc"] = "Tasto per selezionare il prossimo nemico di fronte a te."
L["prev_enemy"] = "Nemico precedente"
L["prev_enemy_desc"] = "Tasto per selezionare il nemico precedente."
L["use_default_keys"] = "Usa TAB / Maiusc-TAB come predefinito"
L["use_default_keys_desc"] = "Se non sono impostati tasti personalizzati, usa automaticamente TAB e Maiusc-TAB."

-- Settings: Icons
L["header_icons"] = "Personalizzazione icone"
L["icon_desc"] = "Scegli le icone visualizzate per ogni modalità di selezione. Queste icone appaiono sul pulsante della minimappa, nei menu a tendina e nei messaggi di stato."
L["players_icon_label"] = "Icona Solo giocatori"
L["players_icon_desc"] = "Icona visualizzata quando si selezionano solo giocatori."
L["all_icon_label"] = "Icona Tutti i nemici"
L["all_icon_desc"] = "Icona visualizzata quando si selezionano tutti i nemici."

-- Settings: Display
L["header_display"] = "Opzioni di visualizzazione"
L["show_minimap"] = "Mostra pulsante minimappa"
L["show_minimap_desc"] = "Mostra un pulsante sulla minimappa per cambiare rapidamente modalità e vedere lo stato a colpo d'occhio."
L["silent_mode"] = "Modalità silenziosa (nascondi messaggi chat)"
L["silent_mode_desc"] = "Non mostrare aggiornamenti di stato nella chat quando cambi zona. I messaggi di errore verranno comunque mostrati."

-- Settings: Help
L["header_help"] = "Guida rapida"
L["help_slash"] = "Comandi slash:"
L["help_slash_desc"] = "/pvptab o /ptt — Apri questo pannello impostazioni"
L["help_minimap"] = "Pulsante minimappa:"
L["help_left_click"] = "Clic sinistro — Cambia temporaneamente la modalità di selezione"
L["help_right_click"] = "Clic destro — Apri impostazioni"
L["help_temp_info"] = "Le sostituzioni temporanee vengono ripristinate al cambio zona o al ricaricamento dell'interfaccia."

-- Tooltip
L["tooltip_next_target"] = "Prossimo bersaglio:"
L["tooltip_prev_target"] = "Bersaglio precedente:"

-- Messages
L["msg_override"] = "[Sostituzione] Selezionando ora:"
L["msg_combat_error"] = "Impossibile aprire le impostazioni durante il combattimento!"
L["msg_settings_unavailable"] = "Pannello impostazioni non disponibile."

-- Minimap tooltip
L["minimap_left_click"] = "Clic sinistro"
L["minimap_right_click"] = "Clic destro"
L["minimap_toggle_mode"] = "Cambia modalità rapidamente"
L["minimap_open_settings"] = "Apri impostazioni"
