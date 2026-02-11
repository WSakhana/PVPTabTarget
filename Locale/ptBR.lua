local L = LibStub("AceLocale-3.0"):NewLocale("PVPTabTarget", "ptBR")
if not L then return end

-- Modes
L["mode_players_only"] = "Apenas jogadores"
L["mode_all_enemies"] = "Todos os inimigos"

-- Zone Types
L["zone_pvp"] = "Zona PvP"
L["zone_pve"] = "Instância PvE"
L["zone_world"] = "Mundo aberto"

-- Status
L["current_zone"] = "Zona atual"
L["targeting"] = "Seleção de alvo"
L["temporary_override"] = "Substituição temporária"
L["override_resets"] = "A substituição é redefinida ao mudar de zona"

-- Tab names
L["tab_targeting"] = "Alvos"
L["tab_keybinds"] = "Teclas de atalho"
L["tab_appearance"] = "Aparência"
L["tab_profiles"] = "Perfis"

-- Settings: Targeting
L["header_targeting"] = "Comportamento de alvo por zona"
L["targeting_desc"] = "Escolha o que sua tecla TAB seleciona em diferentes zonas:"
L["mode_players_desc"] = "Alterna apenas entre jogadores inimigos (ótimo para PvP)"
L["mode_all_desc"] = "Alterna entre todos os inimigos, incluindo NPCs e mascotes"
L["pvp_zones_label"] = "Zonas PvP (Arenas e Campos de Batalha)"
L["pvp_zones_desc"] = "O que selecionar em conteúdo PvP competitivo como arenas, campos de batalha e áreas de combate do Modo de Guerra."
L["pve_zones_label"] = "Instâncias PvE (Masmorras e Raides)"
L["pve_zones_desc"] = "O que selecionar em masmorras, raides e cenários."
L["world_zones_label"] = "Mundo aberto (Missões e Exploração)"
L["world_zones_desc"] = "O que selecionar no mundo aberto."

-- Settings: Keybinds
L["header_keybinds"] = "Configuração de teclas"
L["keybind_desc"] = "Personalize as teclas para alternar entre inimigos. Clique em um botão e pressione a combinação de teclas desejada."
L["next_enemy"] = "Próximo inimigo"
L["next_enemy_desc"] = "Tecla para selecionar o próximo inimigo à sua frente."
L["prev_enemy"] = "Inimigo anterior"
L["prev_enemy_desc"] = "Tecla para selecionar o inimigo anterior."
L["use_default_keys"] = "Usar TAB / Shift-TAB como padrão"
L["use_default_keys_desc"] = "Se nenhuma tecla personalizada for definida, usar automaticamente TAB e Shift-TAB."

-- Settings: Icons
L["header_icons"] = "Personalização de ícones"
L["icon_desc"] = "Escolha os ícones exibidos para cada modo de seleção. Esses ícones aparecem no botão do minimapa, nos menus suspensos e nas mensagens de status."
L["players_icon_label"] = "Ícone Apenas jogadores"
L["players_icon_desc"] = "Ícone exibido ao selecionar apenas jogadores."
L["all_icon_label"] = "Ícone Todos os inimigos"
L["all_icon_desc"] = "Ícone exibido ao selecionar todos os inimigos."

-- Settings: Display
L["header_display"] = "Opções de exibição"
L["show_minimap"] = "Mostrar botão do minimapa"
L["show_minimap_desc"] = "Exibe um botão no minimapa para alternar rapidamente o modo e ver o status de relance."
L["silent_mode"] = "Modo silencioso (ocultar mensagens do chat)"
L["silent_mode_desc"] = "Para de mostrar atualizações de status no chat ao mudar de zona. Mensagens de erro ainda serão exibidas."

-- Settings: Help
L["header_help"] = "Ajuda rápida"
L["help_slash"] = "Comandos de barra:"
L["help_slash_desc"] = "/pvptab ou /ptt — Abrir este painel de configurações"
L["help_minimap"] = "Botão do minimapa:"
L["help_left_click"] = "Clique esquerdo — Alternar temporariamente o modo de seleção"
L["help_right_click"] = "Clique direito — Abrir configurações"
L["help_temp_info"] = "Substituições temporárias são redefinidas ao mudar de zona ou recarregar a interface."

-- Tooltip
L["tooltip_next_target"] = "Próximo alvo:"
L["tooltip_prev_target"] = "Alvo anterior:"

-- Messages
L["msg_override"] = "[Substituição] Selecionando agora:"
L["msg_combat_error"] = "Não é possível abrir as configurações durante o combate!"
L["msg_settings_unavailable"] = "Painel de configurações não disponível."

-- Minimap tooltip
L["minimap_left_click"] = "Clique esquerdo"
L["minimap_right_click"] = "Clique direito"
L["minimap_toggle_mode"] = "Alternar modo rapidamente"
L["minimap_open_settings"] = "Abrir configurações"
