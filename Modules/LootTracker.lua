-- Loot Tracker Module
InMemoryLootTracker = {}

function InMemoryLootTracker:Init()
    self.currentLoot = {}
    InMemoryLootUtils:Debug("Loot Tracker initialized")
end

function InMemoryLootTracker:OnLootOpened()
    if not InMemoryLootDB:GetSetting("trackAllLoots") then return end
    
    for i = 1, GetNumLootItems() do
        local itemLink = GetLootSlotLink(i)
        if itemLink then
            local itemId = InMemoryLootUtils:ParseItemLink(itemLink)
            if itemId then
                table.insert(self.currentLoot, {link = itemLink, id = itemId})
            end
        end
    end
end

function InMemoryLootTracker:OnLootClosed()
    self.currentLoot = {}
end

function InMemoryLootTracker:OnChatLoot(message)
    -- Parse loot messages
    -- Example: "Player receives: [Item Name]"
end