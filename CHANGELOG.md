# Changelog

All notable changes to InMemoryLoot will be documented in this file.

## [1.0.0] - 2024-12-18

### Added
- Initial release
- SR data import from guild website
- Beautiful tabbed UI interface with color-coded priorities
- Current SR display with class colors
- Loot history tracking
- Multiple attribution methods (SR Only, LC Only, SR + LC)
- Automatic raid announcements
- Export loot results back to website
- Support for all major raids (NAXX, KZ, MC, BWL, AQ40, ZG)
- Slash commands (/iml, /inmemory, /inmemoryloot)
- Previous week SR carryover system
- Weekly bonus point calculation (+5/week, max +20)
- Debug mode for troubleshooting
- Automatic loot tracking during raids
- Copy-to-clipboard functionality for exports
- Settings panel with customization options

### Features
- Class-colored player names
- SR points with visual priority colors
- Item link support with tooltips
- Raid leader/assistant permission checks
- Database cleanup functionality
- Minimap button (planned)
- Integration with AtlasLoot (optional)
- Ace2 library compatibility

### Commands
- `/iml` - Toggle main window
- `/iml import` - Open import tab
- `/iml export` - Export loot results
- `/iml sr` - Show SR list in chat
- `/iml cleanup` - Clean old data
- `/iml debug` - Toggle debug mode
- `/iml help` - Show help

### Localization
- English (en-US) - Primary language
- French (fr-FR) - Planned for v1.1

### Known Issues
None

### Compatibility
- WoW Version: 1.12 (Vanilla)
- Tested on: Turtle WoW
- Dependencies: None (optional: Ace2, AtlasLoot)
