-- InMemoryLoot History Tab
InMemoryLootHistoryTab = {}

function InMemoryLootHistoryTab:Create(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints()
    frame:Hide()
    
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -10)
    title:SetText(INMEMORYLOOT_COLORS.HEADER .. "Loot History" .. INMEMORYLOOT_COLORS.CLOSE)
    
    self.frame = frame
end

function InMemoryLootHistoryTab:Show() self.frame:Show() end
function InMemoryLootHistoryTab:Hide() self.frame:Hide() end
function InMemoryLootHistoryTab:Refresh() end