-- Announce Module
InMemoryLootAnnounce = {}

function InMemoryLootAnnounce:Init()
    InMemoryLootUtils:Debug("Announce module initialized")
end

function InMemoryLootAnnounce:AnnounceLoot(itemLink, winner)
    local message = string.format("Loot assigned: %s → %s", itemLink, winner)
    InMemoryLootUtils:SendRaidWarning(message)
end