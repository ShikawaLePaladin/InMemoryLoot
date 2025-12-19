# Installation Guide - InMemoryLoot

## Prerequisites
- World of Warcraft 1.12 client (Vanilla / Turtle WoW)
- InMemory Guild membership
- Access to [inmemory.cloud](https://inmemory.cloud)

## Installation Steps

### Step 1: Download the AddOn

**Option A: Download ZIP**
1. Go to [https://github.com/InMemoryGuild/InMemoryLoot](https://github.com/InMemoryGuild/InMemoryLoot)
2. Click the green **Code** button
3. Select **Download ZIP**
4. Extract the ZIP file

**Option B: Git Clone** (for developers)
```bash
cd "C:\Program Files\World of Warcraft\Interface\AddOns\"
git clone https://github.com/InMemoryGuild/InMemoryLoot.git
```

### Step 2: Install to WoW Directory

1. Locate your WoW installation folder:
   - **Windows**: `C:\Program Files\World of Warcraft\`
   - **Linux**: `~/.wine/drive_c/Program Files/World of Warcraft/`
   - **Mac**: `/Applications/World of Warcraft/`

2. Navigate to: `Interface\AddOns\`

3. Copy the `InMemoryLoot` folder here

4. Your directory should look like:
   ```
   World of Warcraft/
   └── Interface/
       └── AddOns/
           ├── Blizzard_*
           ├── InMemoryLoot/          ← Here!
           │   ├── Core/
           │   ├── UI/
           │   ├── Modules/
           │   ├── InMemoryLoot.toc
           │   └── InMemoryLoot.lua
           └── (other addons)
   ```

### Step 3: Enable the AddOn

1. Launch World of Warcraft
2. At the character selection screen, click **AddOns** button (bottom-left)
3. Find "InMemory Loot" in the list
4. Check the box to enable it
5. Click **Okay**
6. Select your character and enter the game

### Step 4: Verify Installation

In-game, type:
```
/iml
```

You should see the InMemoryLoot main window appear. If you see it, **installation successful!** ✅

If the addon doesn't appear:
- Check the AddOns folder path
- Make sure the folder is named exactly `InMemoryLoot`
- Try `/reload` in-game
- Check for errors with `/console scriptErrors 1`

## First-Time Setup

### Import Your First Event

1. **On the Website** ([inmemory.cloud](https://inmemory.cloud)):
   - Navigate to **Events**
   - Find your upcoming raid (e.g., "Naxx Week 12")
   - Click **Export for WoW Addon**
   - Copy the Lua code that appears

2. **In-Game**:
   - Type `/iml import`
   - The Import tab will open
   - Paste the Lua code into the large text box
   - Click **Import Data**
   - You should see a success message

3. **View Your SR**:
   - The UI will automatically switch to the **Current SR** tab
   - You'll see all players' SR choices with their points

### Configure Settings

Type `/iml` and go to the **Settings** tab:

- **Attribution Method**: Choose how loot is distributed
  - `SR Only`: Pure SR priority (highest points wins)
  - `LC Only`: Manual Loot Council decisions only
  - `SR + LC`: SR priority with council validation (recommended)
  
- **Auto Announce**: Enable to automatically announce loot in raid chat

- **Track All Loots**: Record all loot drops, not just SR items

- **Debug Mode**: Enable if you encounter issues (for troubleshooting)

## Usage During Raids

### View Current SR List

**Option 1: UI Window**
```
/iml
```
Navigate to **Current SR** tab to see the full list.

**Option 2: Chat Command**
```
/iml sr
```
Displays SR list directly in your chat window.

### Assign Loot

When an item drops:

1. Open the addon: `/iml`
2. Go to **Current SR** tab
3. Find the item in the list
4. Click the **Assign** button next to the winner's name
5. The addon will:
   - Record the loot in history
   - Announce to raid (if enabled)
   - Update the database

### After the Raid

Export results back to the website:

1. Type `/iml export`
2. A window will appear with Lua code
3. Copy all the text (Ctrl+A, Ctrl+C)
4. Go to the website event page
5. Click **Import Loot Results**
6. Paste the code and submit

The website will update:
- Loot history for the event
- Player SR points
- Next week's available SR

## Troubleshooting

### "AddOn not found" Error
- Check folder name is exactly `InMemoryLoot` (case-sensitive)
- Verify it's in the correct `Interface\AddOns\` path
- Make sure all files are present (18 files total)

### "No SR data" Message
- You haven't imported an event yet
- Use `/iml import` and paste event data from website

### UI Window Won't Open
- Try `/reload` to reload UI
- Enable script errors: `/console scriptErrors 1`
- Check for conflicts with other addons
- Try disabling other addons temporarily

### SR Points Don't Match Website
- Make sure you imported the latest event data
- Re-export from website and import again
- Check that the correct event is selected in the addon

### Loot Assignment Doesn't Work
- You must be **Raid Leader** or **Raid Assistant**
- Make sure an event is imported (check with `/iml`)
- Verify the item is in the current SR list

### Export Doesn't Copy
- Try manually selecting all text in the window
- Use Ctrl+A then Ctrl+C
- If still failing, check your WoW client version

## Advanced Tips

### Keyboard Shortcuts
- `ESC` key: Close any InMemoryLoot window
- `Ctrl+A`: Select all text in edit boxes
- `Ctrl+C`: Copy selected text

### Slash Command Shortcuts
- `/iml` = `/inmemory` = `/inmemoryloot`
- All commands are case-insensitive

### Database Cleanup
Old events are kept indefinitely. To clean up:
```
/iml cleanup
```
This keeps only the 5 most recent events.

### Debug Mode
If something isn't working:
```
/iml debug
```
This will show detailed messages in your chat about what the addon is doing.

## Updating the AddOn

When a new version is released:

1. Download the new version
2. **Delete** the old `InMemoryLoot` folder
3. Copy the new folder to `Interface\AddOns\`
4. `/reload` in-game
5. Your saved data (events, history) is preserved

## Getting Help

- **In-Game**: Whisper Natolie (Guild Master)
- **Discord**: Ask in the InMemory guild Discord
- **GitHub**: [Open an issue](https://github.com/InMemoryGuild/InMemoryLoot/issues)
- **Website**: Contact via inmemory.cloud

---

**Enjoy raiding with InMemoryLoot!** 🎉
