local AddonName, Addon = ...
PVPTabTarget = Addon

-- ============================================================================
-- LOCALIZED GLOBALS (Performance optimization)
-- ============================================================================
local issecretvalue = issecretvalue
local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local GetCurrentBindingSet = GetCurrentBindingSet
local GetZonePVPInfo = C_PvP.GetZonePVPInfo
local GetBindingKey = GetBindingKey
local GetBindingAction = GetBindingAction
local SetBinding = SetBinding
local SaveBindings = SaveBindings
local print = print
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
	ADDON = "|cFF74D06C",      -- Green (addon name)
	SUCCESS = "|cFF74D06C",    -- Green (success/enabled)
	WARNING = "|cFFFFD700",    -- Yellow (warnings/temp)
	DANGER = "|cFFFF6B6B",     -- Red (PVP/disabled)
	INFO = "|cFF69B4FF",       -- Light blue (info)
	MUTED = "|cFF888888",      -- Gray (muted text)
	WHITE = "|cFFFFFFFF",      -- White (normal text)
}

-- Friendly Display Names
local ZONE_NAMES = {
	[ZONE_PVP] = "PvP Zone",
	[ZONE_PVE] = "PvE Instance",
	[ZONE_WORLD] = "Open World",
}

local MODE_NAMES = {
	[MODE_PLAYERS_ONLY] = "Players Only",
	[MODE_ALL_ENEMIES] = "All Enemies",
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

local PLAYERS_ONLY_ICON_NAMES = {
	["pvp_1"] = "Icon 1",
	["pvp_2"] = "Icon 2",
	["pvp_3"] = "Icon 3",
	["pvp_4"] = "Icon 4",
	["pvp_5"] = "Icon 5",
	["pvp_6"] = "Icon 6",
	["pvp_7"] = "Icon 7",
}

-- Icon Choices for All Enemies mode (PvE/Monster themed)
local ALL_ENEMIES_ICONS = {
	["pve_1"] = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
	["pve_2"] = "Interface\\Icons\\INV_Misc_Head_Dragon_Black",
	["pve_3"] = "Interface\\Icons\\Ability_Hunter_SniperShot",
	["pve_4"] = "Interface\\Icons\\Achievement_PVP_H_01",
	["pve_5"] = "Interface\\Icons\\Achievement_PVP_A_01",
}

local ALL_ENEMIES_ICON_NAMES = {
	["pve_1"] = "Icon 1",
	["pve_2"] = "Icon 2",
	["pve_3"] = "Icon 3",
	["pve_4"] = "Icon 4",
	["pve_5"] = "Icon 5",
}

-- Helper to get icon values for Players Only dropdown
local function GetPlayersOnlyIconValues()
	local values = {}
	for key, path in pairs(PLAYERS_ONLY_ICONS) do
		values[key] = "|T" .. path .. ":16:16|t " .. PLAYERS_ONLY_ICON_NAMES[key]
	end
	return values
end

-- Helper to get icon values for All Enemies dropdown
local function GetAllEnemiesIconValues()
	local values = {}
	for key, path in pairs(ALL_ENEMIES_ICONS) do
		values[key] = "|T" .. path .. ":16:16|t " .. ALL_ENEMIES_ICON_NAMES[key]
	end
	return values
end

-- Helper to get the current icon path for a mode
local function GetModeIcon(mode)
	if mode == MODE_PLAYERS_ONLY then
		local iconKey = Addon.Settings and Addon.Settings.PlayersOnlyIcon or "pvp_1"
		return PLAYERS_ONLY_ICONS[iconKey] or PLAYERS_ONLY_ICONS["pvp_1"]
	else
		local iconKey = Addon.Settings and Addon.Settings.AllEnemiesIcon or "pve_1"
		return ALL_ENEMIES_ICONS[iconKey] or ALL_ENEMIES_ICONS["pve_1"]
	end
end

-- ============================================================================
-- DEFAULT CONFIGURATION
-- ============================================================================
Addon.DefaultConfig = {
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
	
	-- Minimap position
	minimapPos = 225,
}

-- ============================================================================
-- ADDON STATE
-- ============================================================================
Addon.BindingFailed = false
Addon.CurrentZoneType = ZONE_WORLD
Addon.CurrentTargetMode = MODE_ALL_ENEMIES
Addon.TemporaryOverride = false
Addon.TemporaryMode = nil
Addon.OptionsCategory = nil
Addon.IsInitialized = false

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================

-- Print formatted addon message
local function PrintMessage(message, isError)
	if Addon.Settings and Addon.Settings.SilentMode and not isError then
		return
	end
	local prefix = COLORS.ADDON .. "[PVPTabTarget]|r "
	print(prefix .. message)
end

-- Print error message (always shown regardless of SilentMode)
local function PrintError(message)
	PrintMessage(COLORS.DANGER .. message .. "|r", true)
end

-- Get the current zone type based on instance and PvP info
local function GetZoneTypeString()
	local pvpType = GetZonePVPInfo()
	local _, instanceType = IsInInstance()
	
	-- PvP zones: arenas, battlegrounds, war mode combat
	if instanceType == "arena" or instanceType == "pvp" or pvpType == "combat" then
		return ZONE_PVP
	end
	
	-- PvE instances: dungeons, raids, scenarios
	if instanceType == "party" or instanceType == "raid" or instanceType == "scenario" then
		return ZONE_PVE
	end
	
	-- Everything else is open world
	return ZONE_WORLD
end

-- Get the targeting mode for a given zone type
local function GetModeForZone(zoneType)
	-- Temporary override takes priority
	if Addon.TemporaryOverride and Addon.TemporaryMode then
		return Addon.TemporaryMode
	end
	
	local settings = Addon.Settings
	if not settings then
		return MODE_ALL_ENEMIES
	end
	
	if zoneType == ZONE_PVP then
		return settings.PVPMode or MODE_PLAYERS_ONLY
	elseif zoneType == ZONE_PVE then
		return settings.PVEMode or MODE_ALL_ENEMIES
	else
		return settings.WorldMode or MODE_ALL_ENEMIES
	end
end

-- Format mode for display with color and icon
local function FormatMode(mode, includeIcon)
	local icon = includeIcon and ("|T" .. GetModeIcon(mode) .. ":14:14|t ") or ""
	if mode == MODE_PLAYERS_ONLY then
		return icon .. COLORS.DANGER .. MODE_NAMES[mode] .. "|r"
	end
	return icon .. COLORS.SUCCESS .. MODE_NAMES[mode] .. "|r"
end

-- Get mode values for dropdown with dynamic icons
local function GetModeDropdownValues()
	return {
		[MODE_PLAYERS_ONLY] = "|T" .. GetModeIcon(MODE_PLAYERS_ONLY) .. ":14:14|t |cFFFF6B6BPlayers Only|r",
		[MODE_ALL_ENEMIES] = "|T" .. GetModeIcon(MODE_ALL_ENEMIES) .. ":14:14|t |cFF74D06CAll Enemies|r",
	}
end

-- Format zone type for display with color
local function FormatZone(zoneType)
	local zoneName = ZONE_NAMES[zoneType] or zoneType
	if zoneType == ZONE_PVP then
		return COLORS.DANGER .. zoneName .. "|r"
	elseif zoneType == ZONE_PVE then
		return COLORS.WARNING .. zoneName .. "|r"
	end
	return COLORS.SUCCESS .. zoneName .. "|r"
end

-- Get formatted status text for tooltips/display
local function GetStatusText()
	local zoneText = FormatZone(Addon.CurrentZoneType)
	local modeText = FormatMode(Addon.CurrentTargetMode, true)
	
	local status = "Current Zone: " .. zoneText
	if Addon.TemporaryOverride then
		status = status .. COLORS.WARNING .. " [Temporary Override]" .. "|r"
	end
	status = status .. "\nTargeting: " .. modeText
	
	return status
end

-- Open the addon settings panel
local function OpenSettings()
	if InCombatLockdown() then
		PrintError("Cannot open settings during combat!")
		return
	end
	
	if Addon.OptionsCategory and Addon.OptionsCategory.name then
		Settings.OpenToCategory(Addon.OptionsCategory.name)
	else
		PrintError("Settings panel not available.")
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
	
	-- Update icon based on current mode using configured icons
	dataObj.icon = GetModeIcon(Addon.CurrentTargetMode)
	
	-- Force icon texture update
	local iconLib = LibStub("LibDBIcon-1.0", true)
	if iconLib then
		local button = iconLib:GetMinimapButton("PVPTabTarget")
		if button and button.icon then
			button.icon:SetTexture(dataObj.icon)
		end
	end
end

local function ToggleTargetMode()
	-- Toggle between modes
	local newMode
	if Addon.TemporaryOverride then
		-- Already in temp mode, toggle it
		newMode = (Addon.TemporaryMode == MODE_PLAYERS_ONLY) and MODE_ALL_ENEMIES or MODE_PLAYERS_ONLY
	else
		-- Enable temp override with opposite of current mode
		Addon.TemporaryOverride = true
		newMode = (Addon.CurrentTargetMode == MODE_PLAYERS_ONLY) and MODE_ALL_ENEMIES or MODE_PLAYERS_ONLY
	end
	
	Addon.TemporaryMode = newMode
	Addon:ApplyBindings(true)
end

local function SetupMinimapButton()
	local LDB = LibStub("LibDataBroker-1.1", true)
	local iconLib = LibStub("LibDBIcon-1.0", true)
	
	if not LDB or not iconLib then
		return
	end
	
	local dataObj = LDB:NewDataObject("PVPTabTarget", {
		type = "launcher",
		text = "PVPTabTarget",
		icon = GetModeIcon(Addon.CurrentTargetMode or MODE_ALL_ENEMIES),
		
		OnClick = function(_, button)
			if button == "LeftButton" then
				ToggleTargetMode()
			elseif button == "RightButton" then
				OpenSettings()
			end
		end,
		
		OnTooltipShow = function(tooltip)
			tooltip:AddLine(COLORS.ADDON .. "PVPTabTarget|r")
			tooltip:AddLine(" ")
			
			-- Status
			tooltip:AddLine(GetStatusText())
			tooltip:AddLine(" ")
			
			-- Current keybinds
			local targetKey = Addon.Settings.TargetKey or "TAB"
			local prevKey = Addon.Settings.PreviousTargetKey or "SHIFT-TAB"
			tooltip:AddDoubleLine("Next Target:", targetKey, 1, 1, 1, 0.7, 0.9, 1)
			tooltip:AddDoubleLine("Previous Target:", prevKey, 1, 1, 1, 0.7, 0.9, 1)
			tooltip:AddLine(" ")
			
			-- Instructions
			tooltip:AddLine(COLORS.INFO .. "Left-Click|r - Quick toggle mode")
			tooltip:AddLine(COLORS.INFO .. "Right-Click|r - Open settings")
			
			if Addon.TemporaryOverride then
				tooltip:AddLine(" ")
				tooltip:AddLine(COLORS.MUTED .. "Override resets on zone change")
			end
		end,
	})
	
	iconLib:Register("PVPTabTarget", dataObj, {
		hide = not Addon.Settings.ShowMinimap,
		minimapPos = Addon.Settings.minimapPos or 225,
		radius = 80,
	})
end

-- ============================================================================
-- ACE CONFIG GUI (Settings Panel)
-- ============================================================================

Addon.AceConfig = {
	type = "group",
	name = COLORS.ADDON .. "PVPTabTarget|r",
	args = {
		-- ================================================================
		-- STATUS SECTION
		-- ================================================================
		statusHeader = {
			type = "header",
			name = "Current Status",
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
		
		-- ================================================================
		-- ZONE TARGETING MODES
		-- ================================================================
		modeHeader = {
			type = "header",
			name = "Targeting Behavior by Zone",
			order = 10,
		},
		modeDescription = {
			type = "description",
			name = "Choose what your TAB key targets in different zones:\n\n" ..
				   COLORS.DANGER .. "Players Only|r — Only cycles through enemy players (great for PvP)\n" ..
				   COLORS.SUCCESS .. "All Enemies|r — Cycles through all enemies including NPCs and pets\n",
			fontSize = "medium",
			order = 11,
		},
		
		PVPMode = {
			type = "select",
			name = COLORS.DANGER .. "PvP Zones|r (Arenas & Battlegrounds)",
			desc = "What to target in competitive PvP content like arenas, battlegrounds, and war mode combat areas.",
			values = function() return GetModeDropdownValues() end,
			width = "full",
			order = 12,
			set = function(_, val)
				Addon.Settings.PVPMode = val
				Addon:ApplyBindings()
			end,
			get = function()
				return Addon.Settings.PVPMode
			end,
		},
		
		PVEMode = {
			type = "select",
			name = COLORS.WARNING .. "PvE Instances|r (Dungeons & Raids)",
			desc = "What to target in dungeons, raids, and scenarios.",
			values = function() return GetModeDropdownValues() end,
			width = "full",
			order = 13,
			set = function(_, val)
				Addon.Settings.PVEMode = val
				Addon:ApplyBindings()
			end,
			get = function()
				return Addon.Settings.PVEMode
			end,
		},
		
		WorldMode = {
			type = "select",
			name = COLORS.SUCCESS .. "Open World|r (Questing & Exploration)",
			desc = "What to target while out in the open world.",
			values = function() return GetModeDropdownValues() end,
			width = "full",
			order = 14,
			set = function(_, val)
				Addon.Settings.WorldMode = val
				Addon:ApplyBindings()
			end,
			get = function()
				return Addon.Settings.WorldMode
			end,
		},
		
		-- ================================================================
		-- ICON CUSTOMIZATION
		-- ================================================================
		iconHeader = {
			type = "header",
			name = "Icon Customization",
			order = 20,
		},
		iconDescription = {
			type = "description",
			name = "Choose the icons displayed for each targeting mode. These icons appear on the minimap button, in dropdowns, and in status messages.\n",
			fontSize = "medium",
			order = 21,
		},
		
		PlayersOnlyIcon = {
			type = "select",
			name = COLORS.DANGER .. "Players Only|r Icon",
			desc = "Icon to display when targeting players only.",
			values = function() return GetPlayersOnlyIconValues() end,
			width = "full",
			order = 22,
			set = function(_, val)
				Addon.Settings.PlayersOnlyIcon = val
				UpdateMinimapIcon()
				LibStub("AceConfigRegistry-3.0"):NotifyChange("PVPTabTarget")
			end,
			get = function()
				return Addon.Settings.PlayersOnlyIcon
			end,
		},
		
		AllEnemiesIcon = {
			type = "select",
			name = COLORS.SUCCESS .. "All Enemies|r Icon",
			desc = "Icon to display when targeting all enemies.",
			values = function() return GetAllEnemiesIconValues() end,
			width = "full",
			order = 23,
			set = function(_, val)
				Addon.Settings.AllEnemiesIcon = val
				UpdateMinimapIcon()
				LibStub("AceConfigRegistry-3.0"):NotifyChange("PVPTabTarget")
			end,
			get = function()
				return Addon.Settings.AllEnemiesIcon
			end,
		},
		
		-- ================================================================
		-- KEYBIND SETTINGS
		-- ================================================================
		keybindHeader = {
			type = "header",
			name = "Keybinds",
			order = 30,
		},
		keybindDescription = {
			type = "description",
			name = "Customize which keys cycle through enemies. Click a button and press your desired key combination.\n",
			fontSize = "medium",
			order = 31,
		},
		
		TargetKey = {
			type = "keybinding",
			name = "Next Enemy",
			desc = "Key to target the next enemy in front of you.",
			width = "full",
			order = 32,
			set = function(_, val)
				Addon.Settings.TargetKey = (val ~= "") and val or nil
				Addon:ApplyBindings()
			end,
			get = function()
				return Addon.Settings.TargetKey
			end,
		},
		
		PreviousTargetKey = {
			type = "keybinding",
			name = "Previous Enemy",
			desc = "Key to target the previous enemy.",
			width = "full",
			order = 33,
			set = function(_, val)
				Addon.Settings.PreviousTargetKey = (val ~= "") and val or nil
				Addon:ApplyBindings()
			end,
			get = function()
				return Addon.Settings.PreviousTargetKey
			end,
		},
		
		UseDefaultKeys = {
			type = "toggle",
			name = "Use TAB / Shift-TAB as fallback",
			desc = "If no custom keybinds are set above, automatically use TAB and Shift-TAB.",
			width = "full",
			order = 34,
			set = function(_, val)
				Addon.Settings.UseDefaultKeys = val
				Addon:ApplyBindings()
			end,
			get = function()
				return Addon.Settings.UseDefaultKeys
			end,
		},
		
		-- ================================================================
		-- GENERAL OPTIONS
		-- ================================================================
		generalHeader = {
			type = "header",
			name = "Display Options",
			order = 40,
		},
		
		ShowMinimap = {
			type = "toggle",
			name = "Show Minimap Button",
			desc = "Display a minimap button for quick mode toggling and status at a glance.",
			width = "full",
			order = 41,
			set = function(_, val)
				Addon.Settings.ShowMinimap = val
				local iconLib = LibStub("LibDBIcon-1.0", true)
				if iconLib then
					if val then
						iconLib:Show("PVPTabTarget")
					else
						iconLib:Hide("PVPTabTarget")
					end
				end
			end,
			get = function()
				return Addon.Settings.ShowMinimap
			end,
		},
		
		SilentMode = {
			type = "toggle",
			name = "Quiet Mode (hide chat messages)",
			desc = "Stop showing status updates in the chat window when zones change. Error messages will still appear.",
			width = "full",
			order = 42,
			set = function(_, val)
				Addon.Settings.SilentMode = val
			end,
			get = function()
				return Addon.Settings.SilentMode
			end,
		},
		
		-- ================================================================
		-- HELP SECTION
		-- ================================================================
		helpHeader = {
			type = "header",
			name = "Quick Help",
			order = 50,
		},
		helpText = {
			type = "description",
			name = "\n" ..
				   COLORS.INFO .. "Slash Commands:|r\n" ..
				   "  /pvptab or /ptt — Open this settings panel\n\n" ..
				   COLORS.INFO .. "Minimap Button:|r\n" ..
				   "  Left-click — Temporarily toggle targeting mode\n" ..
				   "  Right-click — Open settings\n\n" ..
				   COLORS.MUTED .. "Temporary overrides reset when you change zones or reload your UI.|r\n",
			fontSize = "medium",
			order = 51,
		},
	},
}

-- ============================================================================
-- BINDING LOGIC
-- ============================================================================

-- Determine the keybind to use, with fallback logic
local function ResolveKeybind(customKey, primaryAction, secondaryAction, defaultKey)
	-- Custom key takes priority
	if customKey and customKey ~= "" then
		return customKey
	end
	
	-- Try to find existing binding for the action
	local existingKey = GetBindingKey(primaryAction)
	if not existingKey then
		existingKey = GetBindingKey(secondaryAction)
	end
	
	if existingKey then
		return existingKey
	end
	
	-- Use default if enabled
	if Addon.Settings.UseDefaultKeys and defaultKey then
		return defaultKey
	end
	
	return nil
end

function Addon:ApplyBindings(isTemporaryToggle)
	-- Validate binding set
	local bindSet = GetCurrentBindingSet()
	if bindSet ~= 1 and bindSet ~= 2 then
		return
	end
	
	-- Cannot modify bindings in combat
	if InCombatLockdown() then
		Addon.BindingFailed = true
		return
	end
	
	-- Update zone and mode state
	Addon.CurrentZoneType = GetZoneTypeString()
	Addon.CurrentTargetMode = GetModeForZone(Addon.CurrentZoneType)
	
	-- Resolve keybinds
	local targetKey = ResolveKeybind(
		Addon.Settings.TargetKey,
		"TARGETNEARESTENEMYPLAYER",
		"TARGETNEARESTENEMY",
		"TAB"
	)
	
	local previousKey = ResolveKeybind(
		Addon.Settings.PreviousTargetKey,
		"TARGETPREVIOUSENEMYPLAYER",
		"TARGETPREVIOUSENEMY",
		"SHIFT-TAB"
	)
	
	-- Determine binding actions based on mode
	local targetAction, previousAction
	if Addon.CurrentTargetMode == MODE_PLAYERS_ONLY then
		targetAction = "TARGETNEARESTENEMYPLAYER"
		previousAction = "TARGETPREVIOUSENEMYPLAYER"
	else
		targetAction = "TARGETNEARESTENEMY"
		previousAction = "TARGETPREVIOUSENEMY"
	end
	
	-- Check if binding already correct (optimization)
	if targetKey then
		local currentAction = GetBindingAction(targetKey)
		if currentAction == targetAction then
			UpdateMinimapIcon()
			return
		end
	end
	
	-- Apply new bindings
	local success = true
	
	if targetKey then
		success = SetBinding(targetKey, targetAction)
	end
	
	if previousKey and success then
		SetBinding(previousKey, previousAction)
	end
	
	-- Save and notify
	if success then
		SaveBindings(bindSet)
		Addon.BindingFailed = false
		UpdateMinimapIcon()
		
		-- Refresh settings panel if open
		LibStub("AceConfigRegistry-3.0"):NotifyChange("PVPTabTarget")
		
		-- Show status message
		if not Addon.Settings.SilentMode then
			local modeText = FormatMode(Addon.CurrentTargetMode)
			local zoneText = FormatZone(Addon.CurrentZoneType)
			
			if Addon.TemporaryOverride then
				PrintMessage(COLORS.WARNING .. "[Override]|r Now targeting: " .. modeText)
			else
				PrintMessage(zoneText .. " → " .. modeText)
			end
		end
	else
		Addon.BindingFailed = true
	end
end

-- ============================================================================
-- EVENT HANDLING
-- ============================================================================

function Addon:OnLoad(frame)
	frame:RegisterEvent("ADDON_LOADED")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame:RegisterEvent("DUEL_REQUESTED")
	frame:RegisterEvent("DUEL_FINISHED")
	frame:RegisterEvent("CHAT_MSG_SYSTEM")
end

function Addon:InitializeSettings()
	-- Create saved variables table if needed
	if not PVPTabTargetSettings then
		PVPTabTargetSettings = {}
	end
	
	Addon.Settings = PVPTabTargetSettings
	
	-- Migrate old settings key names
	if Addon.Settings.DefaultKey ~= nil then
		Addon.Settings.UseDefaultKeys = Addon.Settings.DefaultKey
		Addon.Settings.DefaultKey = nil
	end
	
	-- Apply defaults for any missing settings
	for key, defaultValue in pairs(Addon.DefaultConfig) do
		if Addon.Settings[key] == nil then
			Addon.Settings[key] = defaultValue
		end
	end
end

function Addon:SetupInterface()
	-- Register with Ace Config
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("PVPTabTarget", Addon.AceConfig)
	Addon.OptionsCategory = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PVPTabTarget", "PVPTabTarget")
	
	-- Setup minimap button
	SetupMinimapButton()
	
	-- Register slash commands
	SLASH_PVPTABTARGET1 = "/pvptab"
	SLASH_PVPTABTARGET2 = "/ptt"
	SlashCmdList["PVPTABTARGET"] = OpenSettings
end

function Addon:OnEvent(frame, event, arg1, ...)
	-- ================================================================
	-- ADDON INITIALIZATION
	-- ================================================================
	if event == "ADDON_LOADED" and arg1 == AddonName then
		self:InitializeSettings()
		self:SetupInterface()
		frame:UnregisterEvent("ADDON_LOADED")
		return
	end
	
	-- ================================================================
	-- INITIAL WORLD ENTRY
	-- ================================================================
	if event == "PLAYER_ENTERING_WORLD" then
		-- Delay initial binding to ensure everything is loaded
		C_Timer.After(1, function()
			Addon:ApplyBindings()
			Addon.IsInitialized = true
		end)
		return
	end
	
	-- ================================================================
	-- ZONE CHANGES
	-- ================================================================
	if event == "ZONE_CHANGED_NEW_AREA" then
		-- Clear temporary override when changing zones
		Addon.TemporaryOverride = false
		Addon.TemporaryMode = nil
		Addon:ApplyBindings()
		return
	end
	
	-- ================================================================
	-- COMBAT END (Retry failed bindings)
	-- ================================================================
	if event == "PLAYER_REGEN_ENABLED" and Addon.BindingFailed then
		Addon:ApplyBindings()
		return
	end
	
	-- ================================================================
	-- DUEL HANDLING
	-- ================================================================
	if event == "DUEL_REQUESTED" then
		-- Force PvP mode during duels
		Addon.CurrentZoneType = ZONE_PVP
		Addon:ApplyBindings()
		return
	end
	
	if event == "DUEL_FINISHED" then
		Addon:ApplyBindings()
		return
	end
	
	-- ================================================================
	-- SYSTEM MESSAGES (Duel request detection)
	-- ================================================================
	if event == "CHAT_MSG_SYSTEM" then
		-- Check for duel request message
		if not issecretvalue(arg1) and arg1 == ERR_DUEL_REQUESTED then
			Addon.CurrentZoneType = ZONE_PVP
			Addon:ApplyBindings()
		end
		return
	end
end
