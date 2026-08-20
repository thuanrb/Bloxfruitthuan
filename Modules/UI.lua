local UIModule = {}

function UIModule:Init(Hub)
    local success, RedzLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
    end)

    if not success or not RedzLib then
        warn("[BloosHub]: Failed to load RedzLib UI!")
        return
    end

    local Window = RedzLib:MakeWindow({
        Title = "⚡ BLOOS HUB : ENTERPRISE ⚡",
        SubTitle = "by ThuanRB",
        SaveFolder = "BloosHubConfig"
    })

    local TabMain = Window:MakeTab({"Main Farm", "home"})
    local TabCombat = Window:MakeTab({"Combat & PvP", "swords"})
    local TabTeleport = Window:MakeTab({"Teleport", "map"})
    local TabVisual = Window:MakeTab({"Visual & ESP", "eye"})

    local SectionMain = TabMain:AddSection({"Farm Settings"})
    
    TabMain:AddToggle({
        Name = "Auto Farm Level",
        Default = Hub.Config.AutoFarm,
        Callback = function(Value)
            Hub.Config.AutoFarm = Value
        end
    })

    TabMain:AddToggle({
        Name = "Fast Attack",
        Default = Hub.Config.FastAttack,
        Callback = function(Value)
            Hub.Config.FastAttack = Value
        end
    })

    local SectionCombat = TabCombat:AddSection({"Combat Options"})
    
    TabCombat:AddButton({
        Name = "Bring Mobs",
        Callback = function()
            print("Bring mobs activated")
        end
    })

    local SectionTeleport = TabTeleport:AddSection({"World Teleports"})
    
    TabTeleport:AddDropdown({
        Name = "Select Island",
        Options = {"Café", "Mansion", "Castle on the Sea", "Hydra Island"},
        Default = "Café",
        Callback = function(Value)
            print("Teleporting to: " + Value)
        end
    })

    local SectionVisual = TabVisual:AddSection({"ESP Options"})
    
    TabVisual:AddToggle({
        Name = "Player ESP",
        Default = Hub.Config.ESPEnabled,
        Callback = function(Value)
            Hub.Config.ESPEnabled = Value
        end
    })
    
    TabVisual:AddToggle({
        Name = "Fruit ESP",
        Default = false,
        Callback = function(Value)
            print("Fruit ESP: " + tostring(Value))
        end
    })
end

return UIModule
