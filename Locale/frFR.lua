local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "frFR")
if not L then return end

-- Modes
L["mode_players_only"] = "Joueurs uniquement"
L["mode_all_enemies"] = "Tous les ennemis"

-- Zone Types
L["zone_pvp"] = "Zone PvP"
L["zone_pve"] = "Instance PvE"
L["zone_world"] = "Monde ouvert"

-- Status
L["current_zone"] = "Zone actuelle"
L["targeting"] = "Ciblage"
L["temporary_override"] = "Remplacement temporaire"
L["override_resets"] = "Le remplacement se réinitialise au changement de zone"

-- Tab names
L["tab_targeting"] = "Ciblage"
L["tab_keybinds"] = "Raccourcis"
L["tab_appearance"] = "Apparence"
L["tab_profiles"] = "Profils"

-- Settings: Targeting
L["header_targeting"] = "Comportement de ciblage par zone"
L["targeting_desc"] = "Choisissez ce que votre touche TAB cible dans les différentes zones :"
L["mode_players_desc"] = "Cible uniquement les joueurs ennemis (idéal pour le PvP)"
L["mode_all_desc"] = "Cible tous les ennemis, y compris les PNJ et familiers"
L["pvp_zones_label"] = "Zones PvP (Arènes et Champs de bataille)"
L["pvp_zones_desc"] = "Ciblage dans le contenu PvP compétitif comme les arènes, champs de bataille et zones de combat en mode Guerre."
L["pve_zones_label"] = "Instances PvE (Donjons et Raids)"
L["pve_zones_desc"] = "Ciblage dans les donjons, raids et scénarios."
L["world_zones_label"] = "Monde ouvert (Quêtes et Exploration)"
L["world_zones_desc"] = "Ciblage dans le monde ouvert."

-- Settings: Keybinds
L["header_keybinds"] = "Configuration des raccourcis"
L["keybind_desc"] = "Personnalisez les touches pour parcourir les ennemis. Cliquez sur un bouton et appuyez sur la combinaison de touches souhaitée."
L["next_enemy"] = "Ennemi suivant"
L["next_enemy_desc"] = "Touche pour cibler le prochain ennemi devant vous."
L["prev_enemy"] = "Ennemi précédent"
L["prev_enemy_desc"] = "Touche pour cibler l'ennemi précédent."
L["use_default_keys"] = "Utiliser TAB / Maj-TAB par défaut"
L["use_default_keys_desc"] = "Si aucun raccourci personnalisé n'est défini, utiliser automatiquement TAB et Maj-TAB."

-- Settings: Icons
L["header_icons"] = "Personnalisation des icônes"
L["icon_desc"] = "Choisissez les icônes affichées pour chaque mode de ciblage. Ces icônes apparaissent sur le bouton de la minicarte, dans les menus déroulants et dans les messages d'état."
L["players_icon_label"] = "Icône Joueurs uniquement"
L["players_icon_desc"] = "Icône affichée lors du ciblage des joueurs uniquement."
L["all_icon_label"] = "Icône Tous les ennemis"
L["all_icon_desc"] = "Icône affichée lors du ciblage de tous les ennemis."

-- Settings: Display
L["header_display"] = "Options d'affichage"
L["show_minimap"] = "Afficher le bouton de minicarte"
L["show_minimap_desc"] = "Affiche un bouton sur la minicarte pour basculer rapidement le mode et voir l'état en un coup d'œil."
L["silent_mode"] = "Mode silencieux (masquer les messages)"
L["silent_mode_desc"] = "Arrête d'afficher les mises à jour d'état dans le chat lors des changements de zone. Les messages d'erreur seront toujours affichés."

-- Settings: Help
L["header_help"] = "Aide rapide"
L["help_slash"] = "Commandes slash :"
L["help_slash_desc"] = "/pvptab ou /ptt — Ouvrir ce panneau de paramètres"
L["help_minimap"] = "Bouton de minicarte :"
L["help_left_click"] = "Clic gauche — Basculer temporairement le mode de ciblage"
L["help_right_click"] = "Clic droit — Ouvrir les paramètres"
L["help_temp_info"] = "Les remplacements temporaires se réinitialisent lorsque vous changez de zone ou rechargez votre interface."

-- Tooltip
L["tooltip_next_target"] = "Cible suivante :"
L["tooltip_prev_target"] = "Cible précédente :"

-- Messages
L["msg_override"] = "[Remplacement] Ciblage actuel :"
L["msg_combat_error"] = "Impossible d'ouvrir les paramètres pendant le combat !"
L["msg_settings_unavailable"] = "Panneau de paramètres non disponible."

-- Minimap tooltip
L["minimap_left_click"] = "Clic gauche"
L["minimap_right_click"] = "Clic droit"
L["minimap_toggle_mode"] = "Basculer le mode rapidement"
L["minimap_open_settings"] = "Ouvrir les paramètres"
