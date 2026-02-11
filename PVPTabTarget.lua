-- ============================================================================
-- PVPTabTarget — Smart TAB Targeting for WoW
-- Refactored with AceAddon-3.0, AceDB-3.0, AceEvent-3.0, AceConsole-3.0,
-- AceTimer-3.0, AceLocale-3.0 & AceDBOptions-3.0
-- ============================================================================

local AddonName, ns = ...

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("PVPTabTarget")

-- Create addon with Ace mixins
local PVPTabTarget = LibStub("AceAddon-3.0"):NewAddon("PVPTabTarget",
	"AceConsole-3.0",
	"AceEvent-3.0",
	"AceTimer-3.0"
)
ns.Addon = PVPTabTarget

-- ============================================================================
-- LOCALIZED WOW API (Performance)
-- ============================================================================
local issecurevariable = issecurevariable
local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local GetCurrentBindingSet = GetCurrentBindingSet
local GetZonePVPInfo = C_PvP.GetZonePVPInfo
local GetBindingKey = GetBindingKey
local GetBindingAction = GetBindingAction
local SetBinding = SetBinding
local SaveBindings = SaveBindings
local pairs = pairs

-- ============================================================================
-- CONSTANTS
-- ============================================================================

-- Targeting Modes
local MODE_PLAYERS_ONLY = "PLAYERS"
local MODE_ALL_ENEMIES = "ALL"

-- Zone Types
local ZONE_PVP = "PVP"
local ZONE_PVE = "PVE"
local ZONE_WORLD = "WORLD"

-- UI Color Codes
local COLORS = {
	ADDON   = "|cFF74D06C",
	SUCCESS = "|cFF74D06C",
	WARNING = "|cFFFFD700",
	DANGER  = "|cFFFF6B6B",
	INFO    = "|cFF69B4FF",
	MUTED   = "|cFF888888",
	WHITE   = "|cFFFFFFFF",
}

-- Friendly Display Names (using locale)
local ZONE_NAMES = {
	[ZONE_PVP]   = function() return L["zone_pvp"] end,
	[ZONE_PVE]   = function() return L["zone_pve"] end,
	[ZONE_WORLD] = function() return L["zone_world"] end,
}

local MODE_NAMES = {
	[MODE_PLAYERS_ONLY] = function() return L["mode_players_only"] end,
	[MODE_ALL_ENEMIES]  = function() return L["mode_all_enemies"] end,
}

-- Icon Choices for Players Only mode (PvP themed)
local PLAYERS_ONLY_ICONS = {
	["pvp_1"] = "Interface\\Icons\\Achievement_Arena_2v2_7",
	["pvp_2"] = "Interface\\Icons\\Achievement_Arena_3v3_7",
	["pvp_3"] = "Interface\\Icons\\Achievement_PVP_H_01",
	["pvp_4"] = "Interface\\Icons\\Achievement_PVP_A_01",
	["pvp_5"] = "Interface\\Icons\\Ability_Rogue_Shadowstrike",
	["pvp_6"] = "Interface\\Icons\\Achievement_BG_KillXEnemies_GeneralsRoom",
	["pvp_7"] = "Interface\\Icons\\INV_Misc_Head_Human_01",
}

local ALL_ENEMIES_ICONS = {
	["pve_1"] = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
	["pve_2"] = "Interface\\Icons\\INV_Misc_Head_Dragon_Black",
	["pve_3"] = "Interface\\Icons\\Ability_Hunter_SniperShot",
	["pve_4"] = "Interface\\Icons\\Achievement_PVP_H_01",
	["pve_5"] = "Interface\\Icons\\Achievement_PVP_A_01",
}

-- ============================================================================
-- ICON HELPERS
-- ============================================================================

local function GetPlayersOnlyIconValues()
	local values = {}
	for key, path in pairs(PLAYERS_ONLY_ICONS) do
		values[key] = "|T" .. path .. ":16:16|t Icon " .. key:match("%d+")
	end
	return values
end

local function GetAllEnemiesIconValues()
	local values = {}
	for key, path in pairs(ALL_ENEMIES_ICONS) do
		values[key] = "|T" .. path .. ":16:16|t Icon " .. key:match("%d+")
	end
	return values
end

local function GetModeIcon(mode)
	if mode == MODE_PLAYERS_ONLY then
		local iconKey = PVPTabTarget.db and PVPTabTarget.db.profile.PlayersOnlyIcon or "pvp_1"
		return PLAYERS_ONLY_ICONS[iconKey] or PLAYERS_ONLY_ICONS["pvp_1"]
	else
		local iconKey = PVPTabTarget.db and PVPTabTarget.db.profile.AllEnemiesIcon or "pve_1"
		return ALL_ENEMIES_ICONS[iconKey] or ALL_ENEMIES_ICONS["pve_1"]
	end
end

-- ============================================================================
-- ACEDB DEFAULTS
-- ============================================================================
local defaults = {
	profile = {
		-- Behavior
		UseDefaultKeys = true,
		SilentMode = false,
		ShowMinimap = true,

		-- Targeting modes per zone
		PVPMode = MODE_PLAYERS_ONLY,
		PVEMode = MODE_ALL_ENEMIES,
		WorldMode = MODE_ALL_ENEMIES,

		-- Icons for each mode
		PlayersOnlyIcon = "pvp_1",
		AllEnemiesIcon = "pve_1",

		-- Custom keybinds
		TargetKey = "TAB",
		PreviousTargetKey = "SHIFT-TAB",

		-- LibDBIcon minimap position (nested table expected by LibDBIcon)
		minimap = {
			hide = false,
			minimapPos = 225,
		},
	},
}

-- ============================================================================
-- ADDON STATE (non-persistent)
-- ============================================================================
PVPTabTarget.BindingFailed = false
PVPTabTarget.CurrentZoneType = ZONE_WORLD
PVPTabTarget.CurrentTargetMode = MODE_ALL_ENEMIES
PVPTabTarget.TemporaryOverride = false
PVPTabTarget.TemporaryMode = nil

-- ============================================================================
-- DISPLAY HELPERS
-- ============================================================================

local function FormatMode(mode, includeIcon)
	local icon = includeIcon and ("|T" .. GetModeIcon(mode) .. ":14:14|t ") or ""
	local name = MODE_NAMES[mode] and MODE_NAMES[mode]() or mode
	if mode == MODE_PLAYERS_ONLY then
		return icon .. COLORS.DANGER .. name .. "|r"
	end
	return icon .. COLORS.SUCCESS .. name .. "|r"
end

local function GetModeDropdownValues()
	return {
		[MODE_PLAYERS_ONLY] = "|T" .. GetModeIcon(MODE_PLAYERS_ONLY) .. ":14:14|t " ..
			COLORS.DANGER .. L["mode_players_only"] .. "|r",
		[MODE_ALL_ENEMIES] = "|T" .. GetModeIcon(MODE_ALL_ENEMIES) .. ":14:14|t " ..
			COLORS.SUCCESS .. L["mode_all_enemies"] .. "|r",
	}
end

local function FormatZone(zoneType)
	local zoneName = ZONE_NAMES[zoneType] and ZONE_NAMES[zoneType]() or zoneType
	if zoneType == ZONE_PVP then
		return COLORS.DANGER .. zoneName .. "|r"
	elseif zoneType == ZONE_PVE then
		return COLORS.WARNING .. zoneName .. "|r"
	end
	return COLORS.SUCCESS .. zoneName .. "|r"
end

local function GetStatusText()
	local zoneText = FormatZone(PVPTabTarget.CurrentZoneType)
	local modeText = FormatMode(PVPTabTarget.CurrentTargetMode, true)

	local status = L["current_zone"] .. ": " .. zoneText
	if PVPTabTarget.TemporaryOverride then
		status = status .. " " .. COLORS.WARNING .. "[" .. L["temporary_override"] .. "]|r"
	end
	status = status .. "\n" .. L["targeting"] .. ": " .. modeText

	return status
end

-- ============================================================================
-- ZONE DETECTION
-- ============================================================================

local function GetZoneTypeString()
	local pvpType = GetZonePVPInfo()
	local _, instanceType = IsInInstance()

	if instanceType == "arena" or instanceType == "pvp" or pvpType == "combat" then
		return ZONE_PVP
	end

	if instanceType == "party" or instanceType == "raid" or instanceType == "scenario" then
		return ZONE_PVE
	end

	return ZONE_WORLD
end

local function GetModeForZone(zoneType)
	if PVPTabTarget.TemporaryOverride and PVPTabTarget.TemporaryMode then
		return PVPTabTarget.TemporaryMode
	end

	local p = PVPTabTarget.db.profile
	if zoneType == ZONE_PVP then
		return p.PVPMode or MODE_PLAYERS_ONLY
	elseif zoneType == ZONE_PVE then
		return p.PVEMode or MODE_ALL_ENEMIES
	else
		return p.WorldMode or MODE_ALL_ENEMIES
	end
end

-- ============================================================================
-- MINIMAP BUTTON
-- ============================================================================

local function UpdateMinimapIcon()
	local LDB = LibStub("LibDataBroker-1.1", true)
	if not LDB then return end

	local dataObj = LDB:GetDataObjectByName("PVPTabTarget")
	if not dataObj then return end

	dataObj.icon = GetModeIcon(PVPTabTarget.CurrentTargetMode)

	local iconLib = LibStub("LibDBIcon-1.0", true)
	if iconLib then
		local button = iconLib:GetMinimapButton("PVPTabTarget")
		if button and button.icon then
			button.icon:SetTexture(dataObj.icon)
		end
	end
end

local function ToggleTargetMode()
	local newMode
	if PVPTabTarget.TemporaryOverride then
		newMode = (PVPTabTarget.TemporaryMode == MODE_PLAYERS_ONLY)
			and MODE_ALL_ENEMIES or MODE_PLAYERS_ONLY
	else
		PVPTabTarget.TemporaryOverride = true
		newMode = (PVPTabTarget.CurrentTargetMode == MODE_PLAYERS_ONLY)
			and MODE_ALL_ENEMIES or MODE_PLAYERS_ONLY
	end

	PVPTabTarget.TemporaryMode = newMode
	PVPTabTarget:ApplyBindings(true)
end

function PVPTabTarget:SetupMinimapButton()
	local LDB = LibStub("LibDataBroker-1.1", true)
	local iconLib = LibStub("LibDBIcon-1.0", true)

	if not LDB or not iconLib then return end

	local dataObj = LDB:NewDataObject("PVPTabTarget", {
		type = "launcher",
		text = "PVPTabTarget",
		icon = GetModeIcon(self.CurrentTargetMode or MODE_ALL_ENEMIES),

		OnClick = function(_, button)
			if button == "LeftButton" then
				ToggleTargetMode()
			elseif button == "RightButton" then
				self:OpenSettings()
			end
		end,

		OnTooltipShow = function(tooltip)
			tooltip:AddLine(COLORS.ADDON .. "PVPTabTarget|r")
			tooltip:AddLine(" ")
			tooltip:AddLine(GetStatusText())
			tooltip:AddLine(" ")

			local p = self.db.profile
			tooltip:AddDoubleLine(
				L["tooltip_next_target"], p.TargetKey or "TAB",
				1, 1, 1, 0.7, 0.9, 1
			)
			tooltip:AddDoubleLine(
				L["tooltip_prev_target"], p.PreviousTargetKey or "SHIFT-TAB",
				1, 1, 1, 0.7, 0.9, 1
			)
			tooltip:AddLine(" ")
			tooltip:AddLine(COLORS.INFO .. L["minimap_left_click"] .. "|r — " .. L["minimap_toggle_mode"])
			tooltip:AddLine(COLORS.INFO .. L["minimap_right_click"] .. "|r — " .. L["minimap_open_settings"])

			if self.TemporaryOverride then
				tooltip:AddLine(" ")
				tooltip:AddLine(COLORS.MUTED .. L["override_resets"] .. "|r")
			end
		end,
	})

	iconLib:Register("PVPTabTarget", dataObj, self.db.profile.minimap)
end

-- ============================================================================
-- SETTINGS PANEL
-- ============================================================================

function PVPTabTarget:OpenSettings()
	if InCombatLockdown() then
		self:Print(COLORS.DANGER .. L["msg_combat_error"] .. "|r")
		return
	end

	if self.optionsCategory and self.optionsCategory.name then
		Settings.OpenToCategory(self.optionsCategory.name)
	else
		self:Print(COLORS.DANGER .. L["msg_settings_unavailable"] .. "|r")
	end
end

-- ============================================================================
-- ACE OPTIONS TABLE — Tabbed Layout
-- ============================================================================

function PVPTabTarget:GetOptionsTable()
	local options = {
		type = "group",
		name = COLORS.ADDON .. "PVPTabTarget|r",
		childGroups = "tab",
		args = {
			-- ============================================================
			-- STATUS (always visible at top, before tabs)
			-- ============================================================
			statusHeader = {
				type = "header",
				name = "",
				order = 1,
			},
			statusDisplay = {
				type = "description",
				name = function()
					return "\n" .. GetStatusText() .. "\n"
				end,
				fontSize = "medium",
				order = 2,
			},

			-- ============================================================
			-- TAB 1: TARGETING
			-- ============================================================
			targeting = {
				type = "group",
				name = L["tab_targeting"],
				order = 10,
				args = {
					modeDescription = {
						type = "description",
						name = L["targeting_desc"] .. "\n\n" ..
							COLORS.DANGER .. L["mode_players_only"] .. "|r — " .. L["mode_players_desc"] .. "\n" ..
							COLORS.SUCCESS .. L["mode_all_enemies"] .. "|r — " .. L["mode_all_desc"] .. "\n",
						fontSize = "medium",
						order = 1,
					},

					spacer1 = { type = "description", name = " ", order = 9 },

					PVPMode = {
						type = "select",
						name = COLORS.DANGER .. L["pvp_zones_label"] .. "|r",
						desc = L["pvp_zones_desc"],
						values = function() return GetModeDropdownValues() end,
						width = "full",
						order = 10,
						set = function(_, val)
							self.db.profile.PVPMode = val
							self:ApplyBindings()
						end,
						get = function() return self.db.profile.PVPMode end,
					},

					PVEMode = {
						type = "select",
						name = COLORS.WARNING .. L["pve_zones_label"] .. "|r",
						desc = L["pve_zones_desc"],
						values = function() return GetModeDropdownValues() end,
						width = "full",
						order = 11,
						set = function(_, val)
							self.db.profile.PVEMode = val
							self:ApplyBindings()
						end,
						get = function() return self.db.profile.PVEMode end,
					},

					WorldMode = {
						type = "select",
						name = COLORS.SUCCESS .. L["world_zones_label"] .. "|r",
						desc = L["world_zones_desc"],
						values = function() return GetModeDropdownValues() end,
						width = "full",
						order = 12,
						set = function(_, val)
							self.db.profile.WorldMode = val
							self:ApplyBindings()
						end,
						get = function() return self.db.profile.WorldMode end,
					},
				},
			},

			-- ============================================================
			-- TAB 2: KEYBINDS
			-- ============================================================
			keybinds = {
				type = "group",
				name = L["tab_keybinds"],
				order = 20,
				args = {
					keybindDescription = {
						type = "description",
						name = L["keybind_desc"] .. "\n",
						fontSize = "medium",
						order = 1,
					},

					TargetKey = {
						type = "keybinding",
						name = L["next_enemy"],
						desc = L["next_enemy_desc"],
						width = "full",
						order = 10,
						set = function(_, val)
							self.db.profile.TargetKey = (val ~= "") and val or nil
							self:ApplyBindings()
						end,
						get = function() return self.db.profile.TargetKey end,
					},

					PreviousTargetKey = {
						type = "keybinding",
						name = L["prev_enemy"],
						desc = L["prev_enemy_desc"],
						width = "full",
						order = 11,
						set = function(_, val)
							self.db.profile.PreviousTargetKey = (val ~= "") and val or nil
							self:ApplyBindings()
						end,
						get = function() return self.db.profile.PreviousTargetKey end,
					},

					spacer1 = { type = "description", name = " ", order = 19 },

					UseDefaultKeys = {
						type = "toggle",
						name = L["use_default_keys"],
						desc = L["use_default_keys_desc"],
						width = "full",
						order = 20,
						set = function(_, val)
							self.db.profile.UseDefaultKeys = val
							self:ApplyBindings()
						end,
						get = function() return self.db.profile.UseDefaultKeys end,
					},
				},
			},

			-- ============================================================
			-- TAB 3: APPEARANCE
			-- ============================================================
			appearance = {
				type = "group",
				name = L["tab_appearance"],
				order = 30,
				args = {
					-- Icons section
					iconHeader = {
						type = "header",
						name = L["header_icons"],
						order = 1,
					},
					iconDescription = {
						type = "description",
						name = L["icon_desc"] .. "\n",
						fontSize = "medium",
						order = 2,
					},

					PlayersOnlyIcon = {
						type = "select",
						name = COLORS.DANGER .. L["players_icon_label"] .. "|r",
						desc = L["players_icon_desc"],
						values = function() return GetPlayersOnlyIconValues() end,
						width = "full",
						order = 10,
						set = function(_, val)
							self.db.profile.PlayersOnlyIcon = val
							UpdateMinimapIcon()
							LibStub("AceConfigRegistry-3.0"):NotifyChange("PVPTabTarget")
						end,
						get = function() return self.db.profile.PlayersOnlyIcon end,
					},

					AllEnemiesIcon = {
						type = "select",
						name = COLORS.SUCCESS .. L["all_icon_label"] .. "|r",
						desc = L["all_icon_desc"],
						values = function() return GetAllEnemiesIconValues() end,
						width = "full",
						order = 11,
						set = function(_, val)
							self.db.profile.AllEnemiesIcon = val
							UpdateMinimapIcon()
							LibStub("AceConfigRegistry-3.0"):NotifyChange("PVPTabTarget")
						end,
						get = function() return self.db.profile.AllEnemiesIcon end,
					},

					-- Display section
					displayHeader = {
						type = "header",
						name = L["header_display"],
						order = 20,
					},

					ShowMinimap = {
						type = "toggle",
						name = L["show_minimap"],
						desc = L["show_minimap_desc"],
						width = "full",
						order = 21,
						set = function(_, val)
							self.db.profile.ShowMinimap = val
							self.db.profile.minimap.hide = not val
							local iconLib = LibStub("LibDBIcon-1.0", true)
							if iconLib then
								if val then
									iconLib:Show("PVPTabTarget")
								else
									iconLib:Hide("PVPTabTarget")
								end
							end
						end,
						get = function() return self.db.profile.ShowMinimap end,
					},

					SilentMode = {
						type = "toggle",
						name = L["silent_mode"],
						desc = L["silent_mode_desc"],
						width = "full",
						order = 22,
						set = function(_, val) self.db.profile.SilentMode = val end,
						get = function() return self.db.profile.SilentMode end,
					},

					-- Help section
					helpHeader = {
						type = "header",
						name = L["header_help"],
						order = 30,
					},
					helpText = {
						type = "description",
						name = "\n" ..
							COLORS.INFO .. L["help_slash"] .. "|r\n" ..
							"  " .. L["help_slash_desc"] .. "\n\n" ..
							COLORS.INFO .. L["help_minimap"] .. "|r\n" ..
							"  " .. L["help_left_click"] .. "\n" ..
							"  " .. L["help_right_click"] .. "\n\n" ..
							COLORS.MUTED .. L["help_temp_info"] .. "|r\n",
						fontSize = "medium",
						order = 31,
					},
				},
			},
		},
	}

	return options
end

-- ============================================================================
-- OPTIONS REGISTRATION
-- ============================================================================

function PVPTabTarget:SetupOptions()
	local options = self:GetOptionsTable()

	-- Inject AceDBOptions profile management as a tab
	local profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	profileOptions.order = 40
	profileOptions.name = L["tab_profiles"]
	options.args.profiles = profileOptions

	-- Register with AceConfig
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("PVPTabTarget", options)

	-- Add to Blizzard settings panel
	self.optionsCategory = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(
		"PVPTabTarget", "PVPTabTarget"
	)
end

-- ============================================================================
-- BINDING LOGIC
-- ============================================================================

local function ResolveKeybind(customKey, primaryAction, secondaryAction, defaultKey)
	if customKey and customKey ~= "" then
		return customKey
	end

	local existingKey = GetBindingKey(primaryAction)
	if not existingKey then
		existingKey = GetBindingKey(secondaryAction)
	end

	if existingKey then
		return existingKey
	end

	if PVPTabTarget.db.profile.UseDefaultKeys and defaultKey then
		return defaultKey
	end

	return nil
end

function PVPTabTarget:ApplyBindings(isTemporaryToggle)
	local bindSet = GetCurrentBindingSet()
	if bindSet ~= 1 and bindSet ~= 2 then return end

	if InCombatLockdown() then
		self.BindingFailed = true
		return
	end

	-- Update state
	self.CurrentZoneType = GetZoneTypeString()
	self.CurrentTargetMode = GetModeForZone(self.CurrentZoneType)

	local p = self.db.profile

	-- Resolve keybinds
	local targetKey = ResolveKeybind(
		p.TargetKey, "TARGETNEARESTENEMYPLAYER", "TARGETNEARESTENEMY", "TAB"
	)
	local previousKey = ResolveKeybind(
		p.PreviousTargetKey, "TARGETPREVIOUSENEMYPLAYER", "TARGETPREVIOUSENEMY", "SHIFT-TAB"
	)

	-- Determine actions
	local targetAction, previousAction
	if self.CurrentTargetMode == MODE_PLAYERS_ONLY then
		targetAction = "TARGETNEARESTENEMYPLAYER"
		previousAction = "TARGETPREVIOUSENEMYPLAYER"
	else
		targetAction = "TARGETNEARESTENEMY"
		previousAction = "TARGETPREVIOUSENEMY"
	end

	-- Skip if already correct
	if targetKey then
		local currentAction = GetBindingAction(targetKey)
		if currentAction == targetAction then
			UpdateMinimapIcon()
			return
		end
	end

	-- Apply bindings
	local success = true

	if targetKey then
		success = SetBinding(targetKey, targetAction)
	end
	if previousKey and success then
		SetBinding(previousKey, previousAction)
	end

	if success then
		SaveBindings(bindSet)
		self.BindingFailed = false
		UpdateMinimapIcon()

		LibStub("AceConfigRegistry-3.0"):NotifyChange("PVPTabTarget")

		if not p.SilentMode then
			local modeText = FormatMode(self.CurrentTargetMode)
			local zoneText = FormatZone(self.CurrentZoneType)

			if self.TemporaryOverride then
				self:Print(COLORS.WARNING .. L["msg_override"] .. "|r " .. modeText)
			else
				self:Print(zoneText .. " → " .. modeText)
			end
		end
	else
		self.BindingFailed = true
	end
end

-- ============================================================================
-- MIGRATION — Import old PVPTabTargetSettings into AceDB
-- ============================================================================

function PVPTabTarget:MigrateOldSettings()
	if not PVPTabTargetSettings then return end

	local old = PVPTabTargetSettings
	local p = self.db.profile

	-- Map old keys to new profile keys
	local migrations = {
		"UseDefaultKeys", "SilentMode", "ShowMinimap",
		"PVPMode", "PVEMode", "WorldMode",
		"PlayersOnlyIcon", "AllEnemiesIcon",
		"TargetKey", "PreviousTargetKey",
	}

	local migrated = false
	for _, key in ipairs(migrations) do
		if old[key] ~= nil then
			p[key] = old[key]
			migrated = true
		end
	end

	-- Handle renamed key
	if old.DefaultKey ~= nil then
		p.UseDefaultKeys = old.DefaultKey
		migrated = true
	end

	-- Migrate minimap position
	if old.minimapPos then
		p.minimap.minimapPos = old.minimapPos
		migrated = true
	end

	-- Sync ShowMinimap with minimap.hide
	p.minimap.hide = not p.ShowMinimap

	if migrated then
		-- Clear old saved variable so migration only happens once
		PVPTabTargetSettings = nil
		self:Print(COLORS.INFO .. "Settings migrated to the new profile system." .. "|r")
	end
end

-- ============================================================================
-- PROFILE CHANGE CALLBACK
-- ============================================================================

function PVPTabTarget:OnProfileChanged()
	self:ApplyBindings()

	local iconLib = LibStub("LibDBIcon-1.0", true)
	if iconLib then
		if self.db.profile.ShowMinimap then
			iconLib:Show("PVPTabTarget")
		else
			iconLib:Hide("PVPTabTarget")
		end
	end

	UpdateMinimapIcon()
end

-- ============================================================================
-- ACE ADDON LIFECYCLE
-- ============================================================================

function PVPTabTarget:OnInitialize()
	-- Create AceDB database
	self.db = LibStub("AceDB-3.0"):New("PVPTabTargetDB", defaults, true)

	-- Migrate from legacy saved variable
	self:MigrateOldSettings()

	-- Register AceDB profile callbacks
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

	-- Setup GUI and commands
	self:SetupOptions()
	self:SetupMinimapButton()

	-- Register slash commands via AceConsole
	self:RegisterChatCommand("pvptab", "OpenSettings")
	self:RegisterChatCommand("ptt", "OpenSettings")
end

function PVPTabTarget:OnEnable()
	-- Register events via AceEvent — handler methods match event names
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

-- ============================================================================
-- EVENT HANDLERS (AceEvent auto-dispatches to methods matching event names)
-- ============================================================================

function PVPTabTarget:PLAYER_ENTERING_WORLD()
	-- Delay initial binding to ensure everything is loaded
	self:ScheduleTimer("ApplyBindings", 1)
end

function PVPTabTarget:ZONE_CHANGED_NEW_AREA()
	self.TemporaryOverride = false
	self.TemporaryMode = nil
	self:ApplyBindings()
end

function PVPTabTarget:PLAYER_REGEN_ENABLED()
	if self.BindingFailed then
		self:ApplyBindings()
	end
end
