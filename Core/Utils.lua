-- InMemoryLoot Utility Functions
InMemoryLootUtils = {}

-- Print message to chat
function InMemoryLootUtils:Print(message)
    DEFAULT_CHAT_FRAME:AddMessage(message)
end

-- Debug print (only if debug mode enabled)
function InMemoryLootUtils:Debug(message)
    if InMemoryLootDB:GetSetting("debugMode") then
        DEFAULT_CHAT_FRAME:AddMessage(INMEMORYLOOT_COLORS.INFO .. "[DEBUG] " .. message .. INMEMORYLOOT_COLORS.CLOSE)
    end
end

-- Get Class Color
function InMemoryLootUtils:GetClassColor(class)
    local colors = {
        WARRIOR = "|cffc79c6e",
        PALADIN = "|cfff58cba",
        HUNTER = "|cffabd473",
        ROGUE = "|cfffff569",
        PRIEST = "|cffffffff",
        SHAMAN = "|cff0070de",
        MAGE = "|cff69ccf0",
        WARLOCK = "|cff9482c9",
        DRUID = "|cffff7d0a",
    }
    return colors[string.upper(class)] or "|cffffffff"
end

-- Format Player Name with Class Color
function InMemoryLootUtils:ColorPlayerName(name, class)
    local color = self:GetClassColor(class)
    return color .. name .. INMEMORYLOOT_COLORS.CLOSE
end

-- Get Item Link from ID
function InMemoryLootUtils:GetItemLink(itemId)
    if not itemId or itemId == 0 then
        return "Unknown Item"
    end
    
    local itemName, itemLink = GetItemInfo(itemId)
    if itemLink then
        return itemLink
    end
    
    -- Return formatted link if item not cached
    return "|cffff8000|Hitem:" .. itemId .. ":0:0:0:0:0:0:0|h[Item " .. itemId .. "]|h|r"
end

-- Detect Raid Type from Zone
function InMemoryLootUtils:DetectCurrentRaid()
    local zone = GetRealZoneText()
    
    for raidType, patterns in pairs(INMEMORYLOOT_RAID_PATTERNS) do
        for _, pattern in ipairs(patterns) do
            if string.find(string.lower(zone), pattern) then
                return raidType
            end
        end
    end
    
    return nil
end

-- Format Time (Unix timestamp to readable)
function InMemoryLootUtils:FormatTime(timestamp)
    return date("%Y-%m-%d %H:%M:%S", timestamp)
end

-- Parse Item Link to Get Item ID
function InMemoryLootUtils:ParseItemLink(itemLink)
    if not itemLink then
        return nil
    end
    
    local itemId = string.match(itemLink, "item:(%d+)")
    return tonumber(itemId)
end

-- Get SR Color Based on Points
function InMemoryLootUtils:GetSRColor(points)
    if points >= 20 then
        return INMEMORYLOOT_COLORS.SR_HIGH
    elseif points >= 10 then
        return INMEMORYLOOT_COLORS.SR_MEDIUM
    else
        return INMEMORYLOOT_COLORS.SR_LOW
    end
end

-- Copy Text to Clipboard (using EditBox trick)
function InMemoryLootUtils:CopyToClipboard(text)
    -- Create hidden editbox for copying
    if not InMemoryLootCopyFrame then
        InMemoryLootCopyFrame = CreateFrame("Frame", "InMemoryLootCopyFrame", UIParent)
        InMemoryLootCopyFrame:SetPoint("CENTER")
        InMemoryLootCopyFrame:SetWidth(400)
        InMemoryLootCopyFrame:SetHeight(200)
        InMemoryLootCopyFrame:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = { left = 11, right = 12, top = 12, bottom = 11 }
        })
        InMemoryLootCopyFrame:EnableMouse(true)
        InMemoryLootCopyFrame:SetMovable(true)
        InMemoryLootCopyFrame:RegisterForDrag("LeftButton")
        InMemoryLootCopyFrame:SetScript("OnDragStart", function() this:StartMoving() end)
        InMemoryLootCopyFrame:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
        InMemoryLootCopyFrame:Hide()
        
        -- Title
        local title = InMemoryLootCopyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOP", 0, -15)
        title:SetText("Copy to Clipboard")
        
        -- EditBox
        local editBox = CreateFrame("EditBox", nil, InMemoryLootCopyFrame)
        editBox:SetPoint("TOPLEFT", 20, -40)
        editBox:SetPoint("BOTTOMRIGHT", -20, 40)
        editBox:SetMultiLine(true)
        editBox:SetAutoFocus(true)
        editBox:SetFontObject(GameFontHighlightSmall)
        editBox:SetScript("OnEscapePressed", function() InMemoryLootCopyFrame:Hide() end)
        InMemoryLootCopyFrame.editBox = editBox
        
        -- Close Button
        local closeBtn = CreateFrame("Button", nil, InMemoryLootCopyFrame, "UIPanelButtonTemplate")
        closeBtn:SetPoint("BOTTOM", 0, 15)
        closeBtn:SetWidth(80)
        closeBtn:SetHeight(22)
        closeBtn:SetText("Close")
        closeBtn:SetScript("OnClick", function() InMemoryLootCopyFrame:Hide() end)
    end
    
    InMemoryLootCopyFrame.editBox:SetText(text)
    InMemoryLootCopyFrame.editBox:HighlightText()
    InMemoryLootCopyFrame:Show()
end

-- Check if Player is in Raid
function InMemoryLootUtils:IsInRaid()
    return GetNumRaidMembers() > 0
end

-- Check if Player is Raid Leader or Assistant
function InMemoryLootUtils:IsRaidLeader()
    if not self:IsInRaid() then
        return false
    end
    
    for i = 1, GetNumRaidMembers() do
        local name, rank = GetRaidRosterInfo(i)
        if name == UnitName("player") then
            return rank >= 1  -- 2 = Leader, 1 = Assistant
        end
    end
    
    return false
end

-- Send Raid Warning
function InMemoryLootUtils:SendRaidWarning(message)
    if self:IsRaidLeader() then
        SendChatMessage(message, "RAID_WARNING")
    else
        SendChatMessage(message, "RAID")
    end
end

-- Format Number with Separators
function InMemoryLootUtils:FormatNumber(num)
    local formatted = tostring(num)
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return formatted
end
