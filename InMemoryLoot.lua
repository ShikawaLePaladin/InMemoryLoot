-- InMemoryLoot - Main Entry Point
InMemoryLoot = {}

-- Initialize Addon
function InMemoryLoot:OnLoad()
    -- Register Events
    this:RegisterEvent("ADDON_LOADED")
    this:RegisterEvent("LOOT_OPENED")
    this:RegisterEvent("LOOT_CLOSED")
    this:RegisterEvent("CHAT_MSG_LOOT")
    this:RegisterEvent("PLAYER_ENTERING_WORLD")
    
    -- Register Slash Commands
    SLASH_INMEMORYLOOT1 = "/iml"
    SLASH_INMEMORYLOOT2 = "/inmemory"
    SLASH_INMEMORYLOOT3 = "/inmemoryloot"
    SlashCmdList["INMEMORYLOOT"] = function(msg)
        InMemoryLoot:HandleCommand(msg)
    end
    
    DEFAULT_CHAT_FRAME:AddMessage(INMEMORYLOOT_COLORS.INFO .. "InMemoryLoot loading..." .. INMEMORYLOOT_COLORS.CLOSE)
end

-- Handle Events
function InMemoryLoot:OnEvent(event)
    if event == "ADDON_LOADED" and arg1 == "InMemoryLoot" then
        self:Initialize()
    elseif event == "LOOT_OPENED" then
        InMemoryLootTracker:OnLootOpened()
    elseif event == "LOOT_CLOSED" then
        InMemoryLootTracker:OnLootClosed()
    elseif event == "CHAT_MSG_LOOT" then
        InMemoryLootTracker:OnChatLoot(arg1)
    elseif event == "PLAYER_ENTERING_WORLD" then
        self:OnEnterWorld()
    end
end

-- Initialize Addon
function InMemoryLoot:Initialize()
    -- Initialize Database
    InMemoryLootDB:Init()
    
    -- Create UI
    InMemoryLootUI:Create()
    
    -- Initialize Modules
    InMemoryLootSR:Init()
    InMemoryLootTracker:Init()
    InMemoryLootAttribution:Init()
    InMemoryLootAnnounce:Init()
    
    -- Success message
    DEFAULT_CHAT_FRAME:AddMessage(INMEMORYLOOT_MESSAGES.ADDON_LOADED)
    
    self.initialized = true
end

-- On Enter World
function InMemoryLoot:OnEnterWorld()
    if not self.initialized then
        return
    end
    
    -- Auto-detect raid
    local raidType = InMemoryLootUtils:DetectCurrentRaid()
    if raidType then
        InMemoryLootUtils:Debug("Detected raid: " .. raidType)
    end
end

-- Handle Slash Commands
function InMemoryLoot:HandleCommand(msg)
    msg = string.lower(msg)
    
    if msg == "" or msg == "show" then
        InMemoryLootUI:Toggle()
    elseif msg == "hide" then
        InMemoryLootUI:Hide()
    elseif msg == "import" then
        InMemoryLootUI:ShowImportTab()
        InMemoryLootUI:Show()
    elseif msg == "export" then
        local export = InMemoryLootDB:ExportResults()
        if export then
            InMemoryLootUtils:CopyToClipboard(export)
            InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.SUCCESS .. "Export copied to clipboard!" .. INMEMORYLOOT_COLORS.CLOSE)
        else
            InMemoryLootUtils:Print(INMEMORYLOOT_MESSAGES.NO_DATA)
        end
    elseif msg == "sr" then
        self:ShowSRList()
    elseif msg == "cleanup" then
        InMemoryLootDB:Cleanup(5)
    elseif msg == "debug" then
        local current = InMemoryLootDB:GetSetting("debugMode")
        InMemoryLootDB:SetSetting("debugMode", not current)
        InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.INFO .. "Debug mode: " .. tostring(not current) .. INMEMORYLOOT_COLORS.CLOSE)
    elseif msg == "help" then
        self:ShowHelp()
    else
        InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.WARNING .. "Unknown command. Type /iml help" .. INMEMORYLOOT_COLORS.CLOSE)
    end
end

-- Show SR List in Chat
function InMemoryLoot:ShowSRList()
    local srItems = InMemoryLootDB:GetAllSRItems()
    
    if #srItems == 0 then
        InMemoryLootUtils:Print(INMEMORYLOOT_MESSAGES.NO_DATA)
        return
    end
    
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.HEADER .. "=== SR List ===" .. INMEMORYLOOT_COLORS.CLOSE)
    
    local lastItem = nil
    for _, sr in ipairs(srItems) do
        if sr.itemName ~= lastItem then
            local srColor = InMemoryLootUtils:GetSRColor(sr.points)
            local playerColor = InMemoryLootUtils:GetClassColor(sr.class)
            
            local line = srColor .. "[" .. sr.points .. " pts] " .. INMEMORYLOOT_COLORS.CLOSE .. 
                        sr.itemName .. " → " .. 
                        playerColor .. sr.player .. INMEMORYLOOT_COLORS.CLOSE
            
            if sr.fromPrevious then
                line = line .. INMEMORYLOOT_COLORS.WARNING .. " (Previous)" .. INMEMORYLOOT_COLORS.CLOSE
            end
            
            InMemoryLootUtils:Print(line)
            lastItem = sr.itemName
        end
    end
end

-- Show Help
function InMemoryLoot:ShowHelp()
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.HEADER .. "=== InMemoryLoot Commands ===" .. INMEMORYLOOT_COLORS.CLOSE)
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.GOLD .. "/iml" .. INMEMORYLOOT_COLORS.CLOSE .. " - Toggle main window")
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.GOLD .. "/iml import" .. INMEMORYLOOT_COLORS.CLOSE .. " - Open import tab")
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.GOLD .. "/iml export" .. INMEMORYLOOT_COLORS.CLOSE .. " - Export loot results")
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.GOLD .. "/iml sr" .. INMEMORYLOOT_COLORS.CLOSE .. " - Show SR list in chat")
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.GOLD .. "/iml cleanup" .. INMEMORYLOOT_COLORS.CLOSE .. " - Clean old events")
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.GOLD .. "/iml debug" .. INMEMORYLOOT_COLORS.CLOSE .. " - Toggle debug mode")
    InMemoryLootUtils:Print(INMEMORYLOOT_COLORS.GOLD .. "/iml help" .. INMEMORYLOOT_COLORS.CLOSE .. " - Show this help")
end

-- Create Main Frame
InMemoryLootFrame = CreateFrame("Frame", "InMemoryLootFrame", UIParent)
InMemoryLootFrame:SetScript("OnLoad", function() InMemoryLoot:OnLoad() end)
InMemoryLootFrame:SetScript("OnEvent", function() InMemoryLoot:OnEvent(event) end)
InMemoryLootFrame:SetScript("OnUpdate", function() InMemoryLoot:OnUpdate() end)

-- Call OnLoad immediately
InMemoryLoot:OnLoad()
