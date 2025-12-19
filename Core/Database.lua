-- InMemoryLoot Database Management
InMemoryLootDB = {}

-- Initialize Database
function InMemoryLootDB:Init()
    if not InMemoryDB then
        InMemoryDB = {
            version = INMEMORYLOOT_VERSION,
            events = {},
            currentEvent = nil,
            lootHistory = {},
            settings = {
                attributionMethod = "SR_WITH_LC",
                autoAnnounce = true,
                trackAllLoots = true,
                minimapButton = true,
                debugMode = false,
            }
        }
    end
    
    -- Migrate old data if needed
    if InMemoryDB.version ~= INMEMORYLOOT_VERSION then
        self:Migrate()
    end
end

-- Migrate Database
function InMemoryLootDB:Migrate()
    DEFAULT_CHAT_FRAME:AddMessage(INMEMORYLOOT_COLORS.INFO .. "Migrating database to v" .. INMEMORYLOOT_VERSION .. INMEMORYLOOT_COLORS.CLOSE)
    InMemoryDB.version = INMEMORYLOOT_VERSION
end

-- Import Event Data from Lua String
function InMemoryLootDB:ImportEvent(luaString)
    -- Secure load of Lua data
    local loadFunc = loadstring("return " .. luaString)
    if not loadFunc then
        return false, "Invalid Lua syntax"
    end
    
    local success, eventData = pcall(loadFunc)
    if not success or type(eventData) ~= "table" then
        return false, "Invalid event data format"
    end
    
    -- Validate required fields
    if not eventData.eventId or not eventData.eventName or not eventData.raidType then
        return false, "Missing required fields (eventId, eventName, raidType)"
    end
    
    -- Store event
    InMemoryDB.events[eventData.eventId] = {
        id = eventData.eventId,
        name = eventData.eventName,
        date = eventData.eventDate or date("%Y-%m-%d"),
        raidType = eventData.raidType,
        attendees = eventData.attendees or {},
        importedAt = time(),
    }
    
    -- Set as current event
    InMemoryDB.currentEvent = eventData.eventId
    
    return true, "Event imported: " .. eventData.eventName
end

-- Get Current Event
function InMemoryLootDB:GetCurrentEvent()
    if not InMemoryDB.currentEvent then
        return nil
    end
    return InMemoryDB.events[InMemoryDB.currentEvent]
end

-- Get SR for Player
function InMemoryLootDB:GetPlayerSR(playerName)
    local event = self:GetCurrentEvent()
    if not event or not event.attendees then
        return nil
    end
    
    for _, attendee in ipairs(event.attendees) do
        if attendee.name == playerName then
            return attendee.srChoices or {}
        end
    end
    
    return nil
end

-- Get All SR Items (sorted by priority)
function InMemoryLootDB:GetAllSRItems()
    local event = self:GetCurrentEvent()
    if not event or not event.attendees then
        return {}
    end
    
    local srItems = {}
    
    for _, attendee in ipairs(event.attendees) do
        if attendee.srChoices then
            for _, sr in ipairs(attendee.srChoices) do
                table.insert(srItems, {
                    player = attendee.name,
                    class = attendee.class,
                    itemName = sr.itemName,
                    itemId = sr.itemId,
                    points = sr.points or 0,
                    priority = sr.priority or 99,
                    fromPrevious = sr.fromPreviousWeek or false,
                })
            end
        end
    end
    
    -- Sort by points (descending)
    table.sort(srItems, function(a, b)
        return a.points > b.points
    end)
    
    return srItems
end

-- Record Loot Assignment
function InMemoryLootDB:RecordLoot(itemLink, itemId, winner, method, notes)
    local event = self:GetCurrentEvent()
    if not event then
        return false
    end
    
    local lootRecord = {
        timestamp = time(),
        eventId = event.id,
        eventName = event.name,
        itemLink = itemLink,
        itemId = itemId,
        winner = winner,
        method = method or "SR",
        notes = notes or "",
    }
    
    table.insert(InMemoryDB.lootHistory, lootRecord)
    
    return true
end

-- Export Loot Results (for website import)
function InMemoryLootDB:ExportResults()
    local event = self:GetCurrentEvent()
    if not event then
        return nil
    end
    
    -- Filter loot history for current event
    local eventLoots = {}
    for _, loot in ipairs(InMemoryDB.lootHistory) do
        if loot.eventId == event.id then
            table.insert(eventLoots, {
                itemName = loot.itemLink or "Unknown",
                itemId = loot.itemId,
                winner = loot.winner,
                timestamp = loot.timestamp,
                method = loot.method,
            })
        end
    end
    
    -- Generate Lua export string
    local export = string.format([[
{
    eventId = "%s",
    completedAt = "%s",
    lootHistory = {
]], event.id, date("%Y-%m-%dT%H:%M:%S"))
    
    for _, loot in ipairs(eventLoots) do
        export = export .. string.format([[
        { itemName = "%s", itemId = %d, winner = "%s", timestamp = %d, method = "%s" },
]], loot.itemName, loot.itemId or 0, loot.winner, loot.timestamp, loot.method)
    end
    
    export = export .. "    }\n}"
    
    return export
end

-- Get Settings
function InMemoryLootDB:GetSetting(key)
    return InMemoryDB.settings[key]
end

-- Set Settings
function InMemoryLootDB:SetSetting(key, value)
    InMemoryDB.settings[key] = value
end

-- Clear Old Data (keep last N events)
function InMemoryLootDB:Cleanup(keepCount)
    keepCount = keepCount or 10
    
    -- Sort events by import time
    local sortedEvents = {}
    for id, event in pairs(InMemoryDB.events) do
        table.insert(sortedEvents, {id = id, time = event.importedAt or 0})
    end
    
    table.sort(sortedEvents, function(a, b)
        return a.time > b.time
    end)
    
    -- Keep only recent events
    for i = keepCount + 1, table.getn(sortedEvents) do
        InMemoryDB.events[sortedEvents[i].id] = nil
    end
    
    DEFAULT_CHAT_FRAME:AddMessage(INMEMORYLOOT_COLORS.INFO .. "Database cleaned. Kept " .. math.min(keepCount, table.getn(sortedEvents)) .. " events." .. INMEMORYLOOT_COLORS.CLOSE)
end
