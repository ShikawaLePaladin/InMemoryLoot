-- Loot Attribution Module
InMemoryLootAttribution = {}

function InMemoryLootAttribution:Init()
    InMemoryLootUtils:Debug("Attribution module initialized")
end

function InMemoryLootAttribution:AssignLoot(itemName, itemId, winner)
    if not InMemoryLootUtils:IsRaidLeader() then
        InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.ERROR .. "You must be raid leader or assistant to assign loot" .. INMEMORYLOOT_COLORS.CLOSE)
        return
    end
    
    local itemLink = InMemoryLootUtils:GetItemLink(itemId)
    InMemoryLootDB:RecordLoot(itemLink, itemId, winner, "SR", "")
    
    InMemoryLootUtils:Print(string.format(INMEMORYLOOT_MESSAGES.LOOT_ASSIGNED, itemLink, winner))
    
    if InMemoryLootDB:GetSetting("autoAnnounce") then
        InMemoryLootAnnounce:AnnounceLoot(itemLink, winner)
    end
end