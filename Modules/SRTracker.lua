-- SR Tracker Module
InMemoryLootSR = {}

function InMemoryLootSR:Init()
    InMemoryLootUtils:Debug("SR Tracker initialized")
end

function InMemoryLootSR:GetPlayerSR(playerName)
    return InMemoryLootDB:GetPlayerSR(playerName)
end