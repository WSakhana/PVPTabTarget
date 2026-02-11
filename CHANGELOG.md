# Changelog

All notable changes to PVPTabTarget will be documented in this file.

## [2.0.0] — Major Refactor

### Added
- **Ace3 Framework Integration**: Full rewrite using AceAddon-3.0, AceEvent-3.0, AceConsole-3.0, AceTimer-3.0, AceDB-3.0, AceDBOptions-3.0, AceLocale-3.0
- **Profile System**: Per-character or shared profiles with copy, reset, and delete support via AceDB/AceDBOptions
- **Localization**: Full translations for 10 languages — English, French, German, Spanish, Portuguese (BR), Russian, Korean, Chinese Simplified, Chinese Traditional, Italian
- **Tabbed Settings UI**: Reorganized settings into Targeting, Keybinds, Appearance, and Profiles tabs
- **Automatic Migration**: Existing settings from v1.x are automatically imported into the new profile system

### Changed
- Replaced manual event frame with AceEvent-3.0 for cleaner event handling
- Replaced manual slash commands with AceConsole-3.0
- Replaced raw `C_Timer.After` with AceTimer-3.0 `ScheduleTimer`
- Replaced flat SavedVariables with AceDB-3.0 profile database
- Improved UI/UX with better organization, descriptions, and color coding
- Settings panel now refreshes live status display

### Removed
- XML-based event frame (`PVPTabTargetFrame`) — no longer needed with AceAddon lifecycle

## [1.2.0]

### Added
- CurseForge project integration (ID: 1442795)
- Addon icon (PVPTabTargetLogo)

### Changed
- Simplified .toc file by removing redundant localized category entries

## [1.1.0]

### Added
- Minimap button with LibDBIcon support
- Option to hide/show minimap button in settings
- Settings panel accessible via minimap button click

### Changed
- Improved settings UI organization

## [1.0.0]

### Added
- Initial release
- Smart TAB targeting based on zone type
- Automatic switching between player-only targeting (PvP) and all enemies (PvE)
- Zone detection for battlegrounds, arenas, and world PvP areas
- Manual override options in settings
