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
        Title = "⚡ BLOOS HUB : ENTERPRISE ⚡",
        SubTitle = "by ThuanRB",
        SaveFolder = "BloosHubConfig"
    })

    local TabMain = Window:MakeTab({"Main Farm", "home"})
    local TabCombat = Window:MakeTab({"Combat & PvP", "swords"})
    local TabStats = Window:MakeTab({"Stats & Shop", "shopping-cart"})
    local TabTeleport = Window:MakeTab({"Teleport", "map"})
    local TabRaid = Window:MakeTab({"Raids & Dungeons", "shield"})
    local TabVisual = Window:MakeTab({"Visual & ESP", "eye"})
    local TabMisc = Window:MakeTab({"Misc & Settings", "settings"})

    TabMain:AddToggle({
        Name = "Auto Farm Level",
        Default = Hub.Config.AutoFarm,
        Callback = function(Value) Hub.Config.AutoFarm = Value end
    })

    TabMain:AddToggle({
        Name = "Auto Boss",
        Default = Hub.Config.AutoBoss,
        Callback = function(Value) Hub.Config.AutoBoss = Value end
    })

    TabMain:AddToggle({
        Name = "Auto Mastery",
        Default = Hub.Config.AutoMastery,
        Callback = function(Value) Hub.Config.AutoMastery = Value end
    })

    TabCombat:AddToggle({
        Name = "Fast Attack",
        Default = Hub.Config.FastAttack,
        Callback = function(Value) Hub.Config.FastAttack = Value end
    })

    TabCombat:AddToggle({
        Name = "Bring Mobs",
        Default = Hub.Config.BringMobs,
        Callback = function(Value) Hub.Config.BringMobs = Value end
    })

    TabStats:AddButton({
        Name = "Stat Melee",
        Callback = function() print("Upgraded Melee") end
    })
    TabStats:AddButton({
        Name = "Stat Defense",
        Callback = function() print("Upgraded Defense") end
    })
    TabStats:AddButton({
        Name = "Stat Sword",
        Callback = function() print("Upgraded Sword") end
    })

    TabRaid:AddToggle({
        Name = "Auto Raid",
        Default = Hub.Config.AutoRaid,
        Callback = function(Value) Hub.Config.AutoRaid = Value end
    })

    TabVisual:AddToggle({
        Name = "Player ESP",
        Default = Hub.Config.ESPEnabled,
        Callback = function(Value) Hub.Config.ESPEnabled = Value end
    })

    TabVisual:AddToggle({
        Name = "Fruit ESP",
        Default = false,
        Callback = function(Value) print("Fruit ESP: " .. tostring(Value)) end
    })
end

return UIModule
