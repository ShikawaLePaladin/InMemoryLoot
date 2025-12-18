-- InMemoryLoot Import Tab
InMemoryLootImportTab = {}

function InMemoryLootImportTab:Create(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints()
    frame:Hide()
    
    -- Title
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -10)
    title:SetText(INMEMORYLOOT_COLORS.HEADER .. "Import SR Data from Website" .. INMEMORYLOOT_COLORS.CLOSE)
    
    -- Instructions
    local instructions = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    instructions:SetPoint("TOP", 0, -35)
    instructions:SetWidth(parent:GetWidth() - 40)
    instructions:SetJustifyH("LEFT")
    instructions:SetText(
        INMEMORYLOOT_COLORS.INFO .. "1. Go to inmemory.fyi → Events → Select your raid event\n" ..
        "2. Click 'Export for WoW Addon' to download the Lua file\n" ..
        "3. Copy and paste the Lua data below:" .. INMEMORYLOOT_COLORS.CLOSE
    )
    
    -- Scroll Frame for EditBox
    local scrollFrame = CreateFrame("ScrollFrame", "InMemoryLootImportScroll", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 20, -90)
    scrollFrame:SetPoint("BOTTOMRIGHT", -40, 60)
    
    -- EditBox
    local editBox = CreateFrame("EditBox", "InMemoryLootImportEditBox", scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject(GameFontHighlightSmall)
    editBox:SetWidth(scrollFrame:GetWidth())
    editBox:SetHeight(300)
    editBox:SetScript("OnEscapePressed", function() this:ClearFocus() end)
    
    scrollFrame:SetScrollChild(editBox)
    
    -- Buttons
    local importBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    importBtn:SetPoint("BOTTOM", -50, 20)
    importBtn:SetWidth(120)
    importBtn:SetHeight(30)
    importBtn:SetText("Import Data")
    importBtn:SetScript("OnClick", function()
        InMemoryLootImportTab:ImportData(editBox:GetText())
    end)
    
    local clearBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    clearBtn:SetPoint("BOTTOM", 50, 20)
    clearBtn:SetWidth(120)
    clearBtn:SetHeight(30)
    clearBtn:SetText("Clear")
    clearBtn:SetScript("OnClick", function()
        editBox:SetText("")
        editBox:SetFocus()
    end)
    
    -- Status Text
    local status = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    status:SetPoint("TOP", 0, -70)
    status:SetText("")
    frame.status = status
    
    self.frame = frame
    self.editBox = editBox
end

function InMemoryLootImportTab:ImportData(luaData)
    if not luaData or luaData == "" then
        self.frame.status:SetText(INMEMORYLOOT_COLORS.ERROR .. "Error: No data to import" .. INMEMORYLOOT_COLORS.CLOSE)
        return
    end
    
    local success, message = InMemoryLootDB:ImportEvent(luaData)
    
    if success then
        self.frame.status:SetText(INMEMORYLOOT_COLORS.SUCCESS .. message .. INMEMORYLOOT_COLORS.CLOSE)
        self.editBox:SetText("")
        InMemoryLootUtils:Print(INMEMORYLOOT_MESSAGES.IMPORT_SUCCESS)
        
        -- Switch to Current SR tab
        InMemoryLootUI:ShowTab(2)
    else
        self.frame.status:SetText(INMEMORYLOOT_COLORS.ERROR .. "Error: " .. message .. INMEMORYLOOT_COLORS.CLOSE)
        InMemoryLootUtils:Print(INMEMORYLOOT_MESSAGES.IMPORT_ERROR)
    end
end

function InMemoryLootImportTab:Show()
    self.frame:Show()
end

function InMemoryLootImportTab:Hide()
    self.frame:Hide()
end
