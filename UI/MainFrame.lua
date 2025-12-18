-- InMemoryLoot Main UI Frame
InMemoryLootUI = {}

-- Create Main Window
function InMemoryLootUI:Create()
    if self.frame then
        return  -- Already created
    end
    
    -- Main Frame
    local frame = CreateFrame("Frame", "InMemoryLootMainFrame", UIParent)
    frame:SetWidth(INMEMORYLOOT_UI.WINDOW_WIDTH)
    frame:SetHeight(INMEMORYLOOT_UI.WINDOW_HEIGHT)
    frame:SetPoint("CENTER", 0, 0)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function() this:StartMoving() end)
    frame:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
    frame:Hide()
    
    -- Background
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    
    -- Title Bar
    local titleBar = CreateFrame("Frame", nil, frame)
    titleBar:SetHeight(40)
    titleBar:SetPoint("TOPLEFT", 15, -10)
    titleBar:SetPoint("TOPRIGHT", -15, -10)
    titleBar:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    titleBar:SetBackdropColor(0.1, 0.1, 0.2, 0.9)
    titleBar:SetBackdropBorderColor(0.4, 0.4, 0.8, 1)
    
    -- Title Text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", 10, 0)
    title:SetText(INMEMORYLOOT_COLORS.GOLD .. "InMemory Loot Manager" .. INMEMORYLOOT_COLORS.CLOSE)
    
    -- Version Text
    local version = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    version:SetPoint("RIGHT", -10, 0)
    version:SetText(INMEMORYLOOT_COLORS.INFO .. "v" .. INMEMORYLOOT_VERSION .. INMEMORYLOOT_COLORS.CLOSE)
    
    -- Close Button
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function() frame:Hide() end)
    
    -- Tab Container
    local tabContainer = CreateFrame("Frame", nil, frame)
    tabContainer:SetHeight(INMEMORYLOOT_UI.TAB_HEIGHT)
    tabContainer:SetPoint("TOPLEFT", 15, -55)
    tabContainer:SetPoint("TOPRIGHT", -15, -55)
    
    -- Create Tabs
    self.tabs = {}
    local tabNames = {"Import", "Current SR", "History", "Settings"}
    local tabWidth = (INMEMORYLOOT_UI.WINDOW_WIDTH - 40) / #tabNames
    
    for i, name in ipairs(tabNames) do
        local tab = self:CreateTab(tabContainer, name, i, tabWidth)
        table.insert(self.tabs, tab)
    end
    
    -- Content Frame
    local content = CreateFrame("Frame", nil, frame)
    content:SetPoint("TOPLEFT", 15, -90)
    content:SetPoint("BOTTOMRIGHT", -15, 15)
    content:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    content:SetBackdropColor(0, 0, 0, 0.6)
    content:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
    
    frame.content = content
    self.frame = frame
    self.currentTab = 1
    
    -- Create Tab Contents
    InMemoryLootImportTab:Create(content)
    InMemoryLootCurrentTab:Create(content)
    InMemoryLootHistoryTab:Create(content)
    InMemoryLootSettingsTab:Create(content)
    
    -- Show first tab
    self:ShowTab(1)
end

-- Create Tab Button
function InMemoryLootUI:CreateTab(parent, text, index, width)
    local tab = CreateFrame("Button", nil, parent)
    tab:SetWidth(width - 5)
    tab:SetHeight(INMEMORYLOOT_UI.TAB_HEIGHT)
    tab:SetPoint("LEFT", (index - 1) * width, 0)
    
    -- Background
    tab:SetNormalTexture("Interface\\ChatFrame\\ChatFrameTab")
    tab:SetHighlightTexture("Interface\\ChatFrame\\ChatFrameTab")
    
    -- Text
    local label = tab:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    label:SetPoint("CENTER")
    label:SetText(text)
    tab.label = label
    
    -- Click Handler
    tab:SetScript("OnClick", function()
        InMemoryLootUI:ShowTab(index)
    end)
    
    tab.index = index
    return tab
end

-- Show Tab
function InMemoryLootUI:ShowTab(index)
    -- Update tab appearance
    for i, tab in ipairs(self.tabs) do
        if i == index then
            tab:SetAlpha(1.0)
            tab.label:SetTextColor(1, 1, 0)  -- Yellow
        else
            tab:SetAlpha(0.7)
            tab.label:SetTextColor(0.8, 0.8, 0.8)  -- Gray
        end
    end
    
    -- Hide all content
    InMemoryLootImportTab:Hide()
    InMemoryLootCurrentTab:Hide()
    InMemoryLootHistoryTab:Hide()
    InMemoryLootSettingsTab:Hide()
    
    -- Show selected tab
    if index == 1 then
        InMemoryLootImportTab:Show()
    elseif index == 2 then
        InMemoryLootCurrentTab:Show()
        InMemoryLootCurrentTab:Refresh()
    elseif index == 3 then
        InMemoryLootHistoryTab:Show()
        InMemoryLootHistoryTab:Refresh()
    elseif index == 4 then
        InMemoryLootSettingsTab:Show()
    end
    
    self.currentTab = index
end

-- Toggle Window
function InMemoryLootUI:Toggle()
    if self.frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

-- Show Window
function InMemoryLootUI:Show()
    if not self.frame then
        self:Create()
    end
    self.frame:Show()
end

-- Hide Window
function InMemoryLootUI:Hide()
    if self.frame then
        self.frame:Hide()
    end
end

-- Show Import Tab
function InMemoryLootUI:ShowImportTab()
    self:ShowTab(1)
end
