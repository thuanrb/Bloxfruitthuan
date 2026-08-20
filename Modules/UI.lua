local UIModule = {}

local introImages = {
    "rbxassetid://10636836928",
    "rbxassetid://11440788661",
    "rbxassetid://10115049581",
    "rbxassetid://8885671168",
    "rbxassetid://11387600760"
}

function UIModule:Init(Hub)
    local TweenService = Hub.Services.TweenService
    local CoreGui = game:GetService("CoreGui")
    
    local splashGui = Instance.new("ScreenGui")
    splashGui.Name = "BloosSplashUltra"
    splashGui.Parent = CoreGui
    splashGui.IgnoreGuiInset = true
    splashGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local backgroundFrame = Instance.new("Frame")
    backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
    backgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    backgroundFrame.Parent = splashGui
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.Position = UDim2.new(-0.05, 0, -0.05, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.ImageTransparency = 1
    imageLabel.Image = introImages[math.random(1, #introImages)]
    imageLabel.ScaleType = Enum.ScaleType.Crop
    imageLabel.Parent = backgroundFrame
    
    local tweenIn = TweenService:Create(imageLabel, TweenInfo.new(1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0})
    local tweenOut = TweenService:Create(imageLabel, TweenInfo.new(1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {ImageTransparency = 1})
    local fadeBg = TweenService:Create(backgroundFrame, TweenInfo.new(1.0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
    
    local live2DTween = TweenService:Create(imageLabel, TweenInfo.new(3.0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(1.06, 0, 1.06, 0),
        Position = UDim2.new(-0.03, 0, -0.03, 0),
        Rotation = 1.0
    })
    
    live2DTween:Play()
    tweenIn:Play()
    tweenIn.Completed:Wait()
    
    task.wait(1.5) 
    
    tweenOut:Play()
    fadeBg:Play()
    tweenOut.Completed:Wait()
    
    live2DTween:Cancel()
    splashGui:Destroy()

    local success, RedzLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
    end)

    if not success or not RedzLib then return end

    local Window = RedzLib:MakeWindow({
        Title = "⚡ BLOOS HUB : ULTRA PREMIUM ⚡",
        SubTitle = "Version 2.0 | High Performance",
        SaveFolder = "BloosUltraConfig"
    })

    local TabMain = Window:MakeTab({"Main", "home"})
    local TabStats = Window:MakeTab({"Auto Stats", "signal"})
    local TabCombat = Window:MakeTab({"Combat", "swords"})
    local TabVisual = Window:MakeTab({"Visuals", "eye"})
    local TabMisc = Window:MakeTab({"Misc", "globe"})

    TabMain:AddSection({"Farm Settings"})
    TabMain:AddDropdown({
        Name = "Select Weapon",
        Options = {"Melee", "Sword", "Blox Fruit"},
        Default = "Melee",
        Callback = function(Value) Hub.Config.SelectedWeapon = Value end
    })
    TabMain:AddToggle({
        Name = "Auto Farm Level",
        Default = Hub.Config.AutoFarm,
        Callback = function(Value) Hub.Config.AutoFarm = Value end
    })
    TabMain:AddToggle({
        Name = "Auto Farm Nearest",
        Default = false,
        Callback = function(Value) Hub.Config.AutoFarmNearest = Value end
    })

    TabStats:AddSection({"Upgrades"})
    TabStats:AddDropdown({
        Name = "Select Stat",
        Options = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"},
        Default = "Melee",
        Callback = function(Value) Hub.Config.SelectedStat = Value end
    })
    TabStats:AddToggle({
        Name = "Auto Upgrade Stat",
        Default = false,
        Callback = function(Value) Hub.Config.AutoStats = Value end
    })

    TabCombat:AddSection({"PvE & PvP Aimbot"})
    TabCombat:AddToggle({
        Name = "Fast Attack (0 Delay)",
        Default = Hub.Config.FastAttack,
        Callback = function(Value) Hub.Config.FastAttack = Value end
    })
    TabCombat:AddToggle({
        Name = "Bring Mobs (Aura)",
        Default = Hub.Config.BringMobs,
        Callback = function(Value) Hub.Config.BringMobs = Value end
    })

    TabVisual:AddSection({"ESP Settings"})
    TabVisual:AddToggle({
        Name = "Player ESP",
        Default = Hub.Config.ESPEnabled,
        Callback = function(Value) Hub.Config.ESPEnabled = Value end
    })
    TabVisual:AddToggle({
        Name = "Chest ESP",
        Default = false,
        Callback = function(Value) Hub.Config.ChestESP = Value end
    })

    TabMisc:AddSection({"Performance & Servers"})
    TabMisc:AddToggle({
        Name = "FPS Boost (Deep Clean)",
        Default = false,
        Callback = function(Value) 
            if Hub.TogglePerformance then Hub.TogglePerformance(Value) end
        end
    })
    TabMisc:AddToggle({
        Name = "Hop Find TTK Dealer",
        Default = Hub.Config.HopTTK,
        Callback = function(Value) Hub.Config.HopTTK = Value end
    })
    TabMisc:AddButton({
        Name = "Server Hop Now",
        Callback = function()
            if Hub.HopServer then Hub.HopServer() end
        end
    })
    TabMisc:AddButton({
        Name = "Rejoin Server",
        Callback = function()
            Hub.Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Hub.Services.Players.LocalPlayer)
        end
    })
end

return UIModule
