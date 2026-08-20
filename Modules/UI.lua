local UIModule = {}

function UIModule:Init(Hub)
    local success, RedzLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
    end)

    if not success or not RedzLib then return end

    local Window = RedzLib:MakeWindow({
        Title = "⚡ BLOOS HUB : PAID EDITION ⚡",
        SubTitle = "by ThuanRB",
        SaveFolder = "BloosHubConfig"
    })

    local TabKey = Window:MakeTab({"Key System", "key"})
    local TabMain = Window:MakeTab({"Main Farm", "home"})
    local TabCombat = Window:MakeTab({"Combat & PvP", "swords"})
    local TabVisual = Window:MakeTab({"Visual & ESP", "eye"})

    TabKey:AddTextBox({
        Name = "Enter Key",
        Default = "",
        PlaceholderText = "Paste your key here...",
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
        Name = "Fast Attack (No Kick)",
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
