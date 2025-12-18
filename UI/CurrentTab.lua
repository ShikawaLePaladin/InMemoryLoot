-- InMemoryLoot Current SR Tab
InMemoryLootCurrentTab = {}

function InMemoryLootCurrentTab:Create(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints()
    frame:Hide()
    
    -- Event Info
    local eventInfo = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    eventInfo:SetPoint("TOP", 0, -10)
    eventInfo:SetText("")
    frame.eventInfo = eventInfo
    
    -- Filter Buttons
    local filterFrame = CreateFrame("Frame", nil, frame)
    filterFrame:SetHeight(30)
    filterFrame:SetPoint("TOP", 0, -35)
    filterFrame:SetWidth(parent:GetWidth() - 40)
    
    local filterLabel = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    filterLabel:SetPoint("LEFT", 10, 0)
    filterLabel:SetText(INMEMORYLOOT_COLORS.INFO .. "Filter:" .. INMEMORYLOOT_COLORS.CLOSE)
    
    -- Filter Dropdown
    local filterDropdown = CreateFrame("Frame", "InMemoryLootFilterDropdown", filterFrame, "UIDropDownMenuTemplate")
    filterDropdown:SetPoint("LEFT", 60, 0)
    UIDropDownMenu_SetWidth(150, filterDropdown)
    UIDropDownMenu_SetText("All Items", filterDropdown)
    
    -- Scroll Frame for SR List
    local scrollFrame = CreateFrame("ScrollFrame", "InMemoryLootSRScroll", frame, "FauxScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 10, -75)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)
    
    -- Create SR Rows
    local numRows = 15
    local rows = {}
    for i = 1, numRows do
        local row = self:CreateSRRow(scrollFrame, i)
        table.insert(rows, row)
    end
    
    scrollFrame.rows = rows
    scrollFrame.numRows = numRows
    
    -- Update on scroll
    scrollFrame:SetScript("OnVerticalScroll", function()
        FauxScrollFrame_OnVerticalScroll(INMEMORYLOOT_UI.ROW_HEIGHT, function() InMemoryLootCurrentTab:UpdateList() end)
    end)
    
    self.frame = frame
    self.scrollFrame = scrollFrame
    self.filterType = "all"
end

function InMemoryLootCurrentTab:CreateSRRow(parent, index)
    local row = CreateFrame("Frame", nil, parent)
    row:SetHeight(INMEMORYLOOT_UI.ROW_HEIGHT)
    row:SetPoint("TOPLEFT", 10, -(index - 1) * INMEMORYLOOT_UI.ROW_HEIGHT - 5)
    row:SetPoint("RIGHT", -5, 0)
    
    -- Highlight on hover
    row:EnableMouse(true)
    row:SetScript("OnEnter", function()
        row:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            tile = true,
            tileSize = 16,
        })
        row:SetBackdropColor(0.2, 0.2, 0.5, 0.3)
    end)
    row:SetScript("OnLeave", function()
        row:SetBackdrop(nil)
    end)
    
    -- Points
    local points = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    points:SetPoint("LEFT", 5, 0)
    points:SetWidth(50)
    points:SetJustifyH("LEFT")
    row.points = points
    
    -- Item Name
    local itemName = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    itemName:SetPoint("LEFT", 60, 0)
    itemName:SetWidth(250)
    itemName:SetJustifyH("LEFT")
    row.itemName = itemName
    
    -- Player Name
    local playerName = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    playerName:SetPoint("LEFT", 315, 0)
    playerName:SetWidth(150)
    playerName:SetJustifyH("LEFT")
    row.playerName = playerName
    
    -- Previous Week Tag
    local previousTag = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    previousTag:SetPoint("LEFT", 470, 0)
    previousTag:SetWidth(80)
    previousTag:SetJustifyH("LEFT")
    row.previousTag = previousTag
    
    -- Actions Button
    local actionBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
    actionBtn:SetPoint("RIGHT", -5, 0)
    actionBtn:SetWidth(80)
    actionBtn:SetHeight(18)
    actionBtn:SetText("Assign")
    actionBtn:SetScript("OnClick", function()
        if row.data then
            InMemoryLootAttribution:AssignLoot(row.data.itemName, row.data.itemId, row.data.player)
        end
    end)
    row.actionBtn = actionBtn
    
    row:Hide()
    return row
end

function InMemoryLootCurrentTab:UpdateList()
    local srItems = InMemoryLootDB:GetAllSRItems()
    
    if not srItems or #srItems == 0 then
        -- Show "No Data" message
        for i = 1, self.scrollFrame.numRows do
            self.scrollFrame.rows[i]:Hide()
        end
        return
    end
    
    -- Setup scroll
    local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
    local numToDisplay = #srItems
    
    FauxScrollFrame_Update(self.scrollFrame, numToDisplay, self.scrollFrame.numRows, INMEMORYLOOT_UI.ROW_HEIGHT)
    
    -- Update rows
    for i = 1, self.scrollFrame.numRows do
        local dataIndex = i + offset
        local row = self.scrollFrame.rows[i]
        
        if dataIndex <= numToDisplay then
            local sr = srItems[dataIndex]
            
            -- Points with color
            local pointsColor = InMemoryLootUtils:GetSRColor(sr.points)
            row.points:SetText(pointsColor .. sr.points .. " pts" .. INMEMORYLOOT_COLORS.CLOSE)
            
            -- Item Name
            row.itemName:SetText(sr.itemName)
            
            -- Player Name with class color
            local playerColor = InMemoryLootUtils:GetClassColor(sr.class)
            row.playerName:SetText(playerColor .. sr.player .. INMEMORYLOOT_COLORS.CLOSE)
            
            -- Previous Week Tag
            if sr.fromPrevious then
                row.previousTag:SetText(INMEMORYLOOT_COLORS.WARNING .. "(Prev)" .. INMEMORYLOOT_COLORS.CLOSE)
            else
                row.previousTag:SetText("")
            end
            
            -- Store data for actions
            row.data = sr
            
            row:Show()
        else
            row:Hide()
        end
    end
end

function InMemoryLootCurrentTab:Refresh()
    local event = InMemoryLootDB:GetCurrentEvent()
    
    if event then
        self.frame.eventInfo:SetText(
            INMEMORYLOOT_COLORS.GOLD .. event.name .. INMEMORYLOOT_COLORS.CLOSE .. 
            " (" .. INMEMORYLOOT_COLORS.PURPLE .. event.raidType .. INMEMORYLOOT_COLORS.CLOSE .. ")"
        )
    else
        self.frame.eventInfo:SetText(INMEMORYLOOT_COLORS.WARNING .. "No Event Loaded" .. INMEMORYLOOT_COLORS.CLOSE)
    end
    
    self:UpdateList()
end

function InMemoryLootCurrentTab:Show()
    self.frame:Show()
end

function InMemoryLootCurrentTab:Hide()
    self.frame:Hide()
end
