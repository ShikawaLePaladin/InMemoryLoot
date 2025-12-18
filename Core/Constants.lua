-- InMemoryLoot Constants
INMEMORYLOOT_VERSION = "1.0.0"
INMEMORYLOOT_NAME = "InMemory Loot"

-- Color Constants
INMEMORYLOOT_COLORS = {
    HEADER = "|cff00ffff",      -- Cyan
    SUCCESS = "|cff00ff00",      -- Green
    ERROR = "|cffff0000",        -- Red
    WARNING = "|cffffa500",      -- Orange
    INFO = "|cffffffff",         -- White
    SR_HIGH = "|cffff6b6b",      -- High SR (Red)
    SR_MEDIUM = "|cffffd93d",    -- Medium SR (Yellow)
    SR_LOW = "|cff95e1d3",       -- Low SR (Light Blue)
    GOLD = "|cffffd700",         -- Gold
    PURPLE = "|cffa435f",        -- Purple
    CLOSE = "|r",                -- Reset color
}

-- Raid Type Constants
INMEMORYLOOT_RAIDS = {
    "NAXX",
    "KZ",
    "MC",
    "BWL",
    "AQ40",
    "ZG"
}

-- Raid Detection Patterns
INMEMORYLOOT_RAID_PATTERNS = {
    ["NAXX"] = { "naxx", "naxxramas", "nax" },
    ["KZ"] = { "karazhan", "kara", "kz" },
    ["MC"] = { "molten core", "mc", "molten" },
    ["BWL"] = { "blackwing lair", "bwl", "blackwing" },
    ["AQ40"] = { "aq40", "ahn'qiraj", "temple" },
    ["ZG"] = { "zg", "zul'gurub", "gurub" }
}

-- Item Quality Colors (WoW Standard)
INMEMORYLOOT_QUALITY_COLORS = {
    [0] = "|cff9d9d9d",  -- Poor (Gray)
    [1] = "|cffffffff",  -- Common (White)
    [2] = "|cff1eff00",  -- Uncommon (Green)
    [3] = "|cff0070dd",  -- Rare (Blue)
    [4] = "|cffa335ee",  -- Epic (Purple)
    [5] = "|cffff8000",  -- Legendary (Orange)
}

-- UI Constants
INMEMORYLOOT_UI = {
    WINDOW_WIDTH = 700,
    WINDOW_HEIGHT = 500,
    PADDING = 10,
    BUTTON_HEIGHT = 25,
    TAB_HEIGHT = 30,
    ROW_HEIGHT = 20,
}

-- Loot Attribution Methods
INMEMORYLOOT_ATTRIBUTION = {
    SR_ONLY = "SR Only",
    LC_ONLY = "Loot Council Only",
    SR_WITH_LC = "SR Priority + LC Validation",
}

-- Messages
INMEMORYLOOT_MESSAGES = {
    ADDON_LOADED = INMEMORYLOOT_COLORS.HEADER .. INMEMORYLOOT_NAME .. " v" .. INMEMORYLOOT_VERSION .. " loaded!" .. INMEMORYLOOT_COLORS.CLOSE,
    IMPORT_SUCCESS = INMEMORYLOOT_COLORS.SUCCESS .. "SR data imported successfully!" .. INMEMORYLOOT_COLORS.CLOSE,
    IMPORT_ERROR = INMEMORYLOOT_COLORS.ERROR .. "Failed to import SR data. Check format." .. INMEMORYLOOT_COLORS.CLOSE,
    NO_DATA = INMEMORYLOOT_COLORS.WARNING .. "No SR data available. Import from website first." .. INMEMORYLOOT_COLORS.CLOSE,
    LOOT_ASSIGNED = INMEMORYLOOT_COLORS.SUCCESS .. "Loot assigned: %s → %s" .. INMEMORYLOOT_COLORS.CLOSE,
}
