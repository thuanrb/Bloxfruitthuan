local UIModule = {}

function UIModule:Init(Hub)
    local success, Rayfield = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/gen2"))()
    end)

    if not success or not Rayfield then
        warn("[BloosHub]: Failed to load Rayfield UI!")
        return
    end

    local Window = Rayfield:CreateWindow({
        Name = "⚡ BLOOS HUB : ENTERPRISE EDITION ⚡",
        LoadingTitle = "Initializing Modular System...",
        LoadingSubtitle = "by ThuanRB",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "BloosHubConfig",
            FileName = "EnterpriseConfig"
        },
        KeySystem = false
    })

    local MainTab = Window:CreateTab({ Name = "Main Control", Icon = "cpu" })
    local VisualTab = Window:CreateTab({ Name = "Visual & ESP", Icon = "eye" })

    MainTab:CreateToggle({
        Name = "Auto Farm Level",
        CurrentValue = Hub.Config.AutoFarm,
        Callback = function(Value)
            Hub.Config.AutoFarm = Value
        end,
    })

    MainTab:CreateToggle({
        Name = "Fast Attack",
        CurrentValue = Hub.Config.FastAttack,
        Callback = function(Value)
            Hub.Config.FastAttack = Value
        end,
    })

    VisualTab:CreateToggle({
        Name = "Player & Object ESP",
        CurrentValue = Hub.Config.ESPEnabled,
        Callback = function(Value)
            Hub.Config.ESPEnabled = Value
        end,
    })

    Rayfield:Notify({
        Title = "Success",
        Content = "Modular system loaded successfully!",
        Duration = 5,
        Image = 4483362458,
    })
end

return UIModule
