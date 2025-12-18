# InMemory Loot - WoW AddOn

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/InMemoryGuild/InMemoryLoot)
[![WoW](https://img.shields.io/badge/WoW-1.12-orange.svg)](https://turtle-wow.org/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

**InMemory Loot** is a comprehensive Suicide Roll (SR) and loot management system for World of Warcraft Vanilla/Turtle WoW. Designed specifically for the InMemory Guild, it provides seamless integration between the guild website ([inmemory.fyi](https://inmemory.fyi)) and in-game loot distribution.

## ✨ Features

### 🎯 SR Management
- **Import SR Data**: Import raid SR selections directly from the guild website
- **Priority System**: Automatic SR point calculation with weekly bonuses (+5/week, max +20)
- **Previous Week Carryover**: Automatically reuse SR from previous raid if item wasn't won
- **Visual Priority**: Color-coded SR points (Red: High, Yellow: Medium, Blue: Low)

### 📊 Loot Tracking
- **Automatic Detection**: Tracks all loot drops automatically during raids
- **Multiple Attribution Methods**:
  - SR Only: Pure suicide roll priority
  - Loot Council Only: Manual LC decisions
  - SR + LC: SR priority with council validation (recommended)
- **History Log**: Complete loot history with timestamps and methods

### 🎨 Beautiful UI
- **Modern Interface**: Clean, colorful, and user-friendly design
- **Tabbed Navigation**: Import, Current SR, History, and Settings tabs
- **Class Colors**: Player names displayed with appropriate class colors
- **Item Links**: Full WoW item link support with tooltips

### 🔊 Raid Announcements
- **Auto-Announce**: Automatic raid warnings when loot is assigned
- **Custom Messages**: Configurable announcement formats
- **Role-Based**: Works for raid leaders and assistants

### 🔄 Website Integration
- **Export to Site**: Export loot results back to the guild website
- **Lua Format**: Easy copy-paste format for website import
- **Bidirectional Sync**: Complete workflow from site → game → site

## 📦 Installation

### Method 1: Manual Installation
1. Download the latest release from [Releases](https://github.com/InMemoryGuild/InMemoryLoot/releases)
2. Extract the `InMemoryLoot` folder
3. Copy it to your `World of Warcraft/Interface/AddOns/` directory
4. Restart WoW or reload UI (`/reload`)

### Method 2: Git Clone
```bash
cd "World of Warcraft/Interface/AddOns/"
git clone https://github.com/InMemoryGuild/InMemoryLoot.git
```

## 🚀 Quick Start

### 1. Import SR Data
1. Visit [inmemory.fyi](https://inmemory.fyi) → **Events**
2. Select your raid event (e.g., "Naxx Raid - Week 12")
3. Click **Export for WoW Addon**
4. Copy the Lua code
5. In-game, type `/iml import`
6. Paste the code into the import box
7. Click **Import Data**

### 2. During the Raid
- The addon automatically tracks SR for all raid members
- View current SR list: `/iml sr` or open UI → **Current SR** tab
- When loot drops, assign it using the **Assign** button next to the player's name

### 3. After the Raid
1. Type `/iml export`
2. Copy the generated Lua code
3. Go to the event page on the website
4. Click **Import Loot Results**
5. Paste the code and submit

## 🎮 Commands

| Command | Description |
|---------|-------------|
| `/iml` or `/inmemory` | Toggle main window |
| `/iml import` | Open import tab |
| `/iml export` | Export loot results to clipboard |
| `/iml sr` | Show SR list in chat |
| `/iml cleanup` | Clean old event data (keeps last 5) |
| `/iml debug` | Toggle debug mode |
| `/iml help` | Show command list |

## 🎨 UI Overview

### Import Tab
![Import Tab](docs/screenshots/import.png)
- Paste Lua data from website
- Clear and import buttons
- Status feedback

### Current SR Tab
![Current SR](docs/screenshots/current.png)
- Live SR list with points
- Class-colored player names
- Quick assign buttons
- Previous week indicators

### History Tab
- Complete loot history
- Filterable by date/player/item
- Export options

### Settings Tab
- Attribution method selection
- Auto-announce toggle
- Debug mode
- Minimap button

## 🛠️ Configuration

Settings are accessible via `/iml` → **Settings** tab:

- **Attribution Method**: Choose SR Only, LC Only, or SR + LC
- **Auto Announce**: Automatically announce loot in raid chat
- **Track All Loots**: Record all loot drops (not just SR items)
- **Minimap Button**: Show/hide minimap button
- **Debug Mode**: Enable verbose logging

## 📋 SR Point System

The addon supports the following point calculation:
- **Base Points**: Starting SR points for an item
- **Weekly Bonus**: +5 points per week waiting (max +20)
- **Carryover**: SR choices carry over if item not won

Example:
```
Week 1: Player wants "Dreadnaught Helmet" (5 base points) = 5 pts
Week 2: Item didn't drop, SR carries over = 10 pts (+5)
Week 3: Item didn't drop, SR carries over = 15 pts (+5)
Week 4: Item drops, player wins at 20 pts (+5)
```

## 🌐 Supported Raids

- **NAXX** - Naxxramas
- **KZ** - Karazhan (TBC content on Turtle WoW)
- **MC** - Molten Core
- **BWL** - Blackwing Lair
- **AQ40** - Temple of Ahn'Qiraj
- **ZG** - Zul'Gurub

Raid type is auto-detected from event name or can be manually specified.

## 🔗 Integration with InMemory Website

The addon is designed to work seamlessly with the guild management system:

1. **Event Creation**: Guild Master creates raid event on website
2. **SR Selection**: Raiders select their 2 SR items (or reuse previous)
3. **Export**: Website generates Lua export for the event
4. **Import**: Raid Leader imports into addon before raid
5. **Raid**: Addon tracks loot distribution during raid
6. **Results**: Raid Leader exports results after raid
7. **Update**: Website imports results, updates SR history

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Credits

**Developed for InMemory Guild**
- Guild Website: [inmemory.fyi](https://inmemory.fyi)
- Server: Turtle WoW
- Inspired by: RollFor addon

## 📞 Support

- **In-Game**: Contact Natolie (Guild Master)
- **Discord**: Join InMemory Discord server
- **Issues**: [GitHub Issues](https://github.com/InMemoryGuild/InMemoryLoot/issues)

## 📸 Screenshots

### Main Window
![Main Window](docs/screenshots/main.png)

### SR List with Colors
![SR List](docs/screenshots/sr-list.png)

### Export Results
![Export](docs/screenshots/export.png)

---

Made with ❤️ by the InMemory Guild
