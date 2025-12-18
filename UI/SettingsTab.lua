-- InMemoryLoot Settings Tab
InMemoryLootSettingsTab = {}

function InMemoryLootSettingsTab:Create(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints()
    frame:Hide()
    
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -10)
    title:SetText(INMEMORYLOOT_COLORS.HEADER .. "Settings" .. INMEMORYLOOT_COLORS.CLOSE)
    
    self.frame = frame
end

function InMemoryLootSettingsTab:Show() self.frame:Show() end
function InMemoryLootSettingsTab:Hide() self.frame:Hide() end