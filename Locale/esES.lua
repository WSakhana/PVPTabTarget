local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "esES")
if not L then return end

-- Modes
L["mode_players_only"] = "Solo jugadores"
L["mode_all_enemies"] = "Todos los enemigos"

-- Zone Types
L["zone_pvp"] = "Zona PvP"
L["zone_pve"] = "Instancia PvE"
L["zone_world"] = "Mundo abierto"

-- Status
L["current_zone"] = "Zona actual"
L["targeting"] = "Selección de objetivo"
L["temporary_override"] = "Anulación temporal"
L["override_resets"] = "La anulación se restablece al cambiar de zona"

-- Tab names
L["tab_targeting"] = "Objetivos"
L["tab_keybinds"] = "Atajos de teclado"
L["tab_appearance"] = "Apariencia"
L["tab_profiles"] = "Perfiles"

-- Settings: Targeting
L["header_targeting"] = "Comportamiento de objetivos por zona"
L["targeting_desc"] = "Elige a quién selecciona tu tecla TAB en diferentes zonas:"
L["mode_players_desc"] = "Solo alterna entre jugadores enemigos (ideal para PvP)"
L["mode_all_desc"] = "Alterna entre todos los enemigos incluyendo NPCs y mascotas"
L["pvp_zones_label"] = "Zonas PvP (Arenas y Campos de batalla)"
L["pvp_zones_desc"] = "A quién seleccionar en contenido PvP competitivo como arenas, campos de batalla y zonas de combate en Modo Guerra."
L["pve_zones_label"] = "Instancias PvE (Mazmorras y Bandas)"
L["pve_zones_desc"] = "A quién seleccionar en mazmorras, bandas y escenarios."
L["world_zones_label"] = "Mundo abierto (Misiones y Exploración)"
L["world_zones_desc"] = "A quién seleccionar en el mundo abierto."

-- Settings: Keybinds
L["header_keybinds"] = "Configuración de atajos"
L["keybind_desc"] = "Personaliza las teclas para alternar entre enemigos. Haz clic en un botón y presiona la combinación de teclas deseada."
L["next_enemy"] = "Siguiente enemigo"
L["next_enemy_desc"] = "Tecla para seleccionar al siguiente enemigo frente a ti."
L["prev_enemy"] = "Enemigo anterior"
L["prev_enemy_desc"] = "Tecla para seleccionar al enemigo anterior."
L["use_default_keys"] = "Usar TAB / Mayús-TAB como predeterminado"
L["use_default_keys_desc"] = "Si no se configuraron atajos personalizados, usar automáticamente TAB y Mayús-TAB."

-- Settings: Icons
L["header_icons"] = "Personalización de iconos"
L["icon_desc"] = "Elige los iconos mostrados para cada modo de selección. Estos iconos aparecen en el botón del minimapa, en menús desplegables y en mensajes de estado."
L["players_icon_label"] = "Icono Solo jugadores"
L["players_icon_desc"] = "Icono mostrado al seleccionar solo jugadores."
L["all_icon_label"] = "Icono Todos los enemigos"
L["all_icon_desc"] = "Icono mostrado al seleccionar todos los enemigos."

-- Settings: Display
L["header_display"] = "Opciones de visualización"
L["show_minimap"] = "Mostrar botón del minimapa"
L["show_minimap_desc"] = "Muestra un botón en el minimapa para cambiar rápidamente el modo y ver el estado de un vistazo."
L["silent_mode"] = "Modo silencioso (ocultar mensajes del chat)"
L["silent_mode_desc"] = "Deja de mostrar actualizaciones de estado en el chat cuando cambias de zona. Los mensajes de error seguirán apareciendo."

-- Settings: Help
L["header_help"] = "Ayuda rápida"
L["help_slash"] = "Comandos de barra:"
L["help_slash_desc"] = "/pvptab o /ptt — Abrir este panel de configuración"
L["help_minimap"] = "Botón del minimapa:"
L["help_left_click"] = "Clic izquierdo — Cambiar temporalmente el modo de selección"
L["help_right_click"] = "Clic derecho — Abrir configuración"
L["help_temp_info"] = "Las anulaciones temporales se restablecen al cambiar de zona o recargar la interfaz."

-- Tooltip
L["tooltip_next_target"] = "Siguiente objetivo:"
L["tooltip_prev_target"] = "Objetivo anterior:"

-- Messages
L["msg_override"] = "[Anulación] Seleccionando ahora:"
L["msg_combat_error"] = "¡No se puede abrir la configuración durante el combate!"
L["msg_settings_unavailable"] = "Panel de configuración no disponible."

-- Minimap tooltip
L["minimap_left_click"] = "Clic izquierdo"
L["minimap_right_click"] = "Clic derecho"
L["minimap_toggle_mode"] = "Cambiar modo rápidamente"
L["minimap_open_settings"] = "Abrir configuración"
