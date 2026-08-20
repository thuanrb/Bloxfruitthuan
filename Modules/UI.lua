TabMisc:AddToggle({
    Name = "Hop Server On Event",
    Default = false,
    Callback = function(Value)
        Hub.Config.HopOnEvent = Value
    end
})

TabMisc:AddButton({
    Name = "Server Hop Now",
    Callback = function()
        if Hub.HopServer then
            Hub.HopServer()
        end
    end
})
local UIModule = {}

function UIModule:Init(Hub)
    Hub.Config.AutoBoss = false
    Hub.Config.AutoMastery = false
    Hub.Config.BringMobs = false
    Hub.Config.AutoChest = false
    Hub.Config.AutoRaid = false

    local success, RedzLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
    end)

    if not success or not RedzLib then return end

    local Window = RedzLib:MakeWindow({
        Title = "⚡ BLOOS HUB : PAID EDITION ⚡",
        SubTitle = "by ThuanRB",
        SaveFolder = "BloosHubConfig"
    })

    local TabKey = Window:MakeTab({"Get Key", "key"})
    local TabMain = Window:MakeTab({"Main Farm", "home"})
    local TabCombat = Window:MakeTab({"Combat & PvP", "swords"})
    local TabVisual = Window:MakeTab({"Visual & ESP", "eye"})

    local SectionKey = TabKey:AddSection({"Key System"})

    -- Nút bấm để copy link vượt link cho người chơi
    TabKey:AddButton({
        Name = "Get Key Link (Copy Link Vượt)",
        Callback = function()
            local keyLink = "https://work.ink/12345/bloos-hub-key" -- Thay link quảng cáo của bạn vào đây
            setclipboard(keyLink)
            print("Copied Key Link!")
        end
    })

    TabKey:AddTextBox({
        Name = "Enter Key",
        Default = "",
        PlaceholderText = "Paste Key Here...",
        ClearText = false,
        Callback = function(Value)
            Hub.Config.Key = Value
        end
    })

    TabKey:AddButton({
        Name = "Check Key",
        Callback = function()
            if Hub:VerifyKey(Hub.Config.Key) then
                print("Key Validated!")
            else
                warn("Invalid Key!")
            end
        end
    })

    TabMain:AddToggle({
        Name = "Auto Farm Level",
        Default = Hub.Config.AutoFarm,
        Callback = function(Value) Hub.Config.AutoFarm = Value end
    })

    TabCombat:AddToggle({
        Name = "Fast Attack",
        Default = Hub.Config.FastAttack,
        Callback = function(Value) Hub.Config.FastAttack = Value end
    })

    TabVisual:AddToggle({
        Name = "Player ESP",
        Default = Hub.Config.ESPEnabled,
        Callback = function(Value) Hub.Config.ESPEnabled = Value end
    })
end

return UIModule
