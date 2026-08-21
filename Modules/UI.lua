local UI = {}

function UI:Init(Loader)
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    if CoreGui:FindFirstChild("BloosHub_TeddyPro") then
        CoreGui.BloosHub_TeddyPro:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloosHub_TeddyPro"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 45, 0, 45)
    ToggleButton.Position = UDim2.new(0, 15, 0, 180)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    ToggleButton.Text = "BL"
    ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 128)
    ToggleButton.TextSize = 14
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Parent = ScreenGui
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 620, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(22, 27, 36)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 350, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "TEDDY HUB (BLOOS V6) - ULTIMATE STABLE"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    local TabBar = Instance.new("ScrollingFrame")
    TabBar.Size = UDim2.new(1, 0, 0, 35)
    TabBar.Position = UDim2.new(0, 0, 0, 40)
    TabBar.BackgroundColor3 = Color3.fromRGB(20, 25, 33)
    TabBar.BorderSizePixel = 0
    TabBar.CanvasSize = UDim2.new(0, 900, 0, 0)
    TabBar.ScrollBarThickness = 2
    TabBar.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 4)
    TabListLayout.Parent = TabBar

    local PagesContainer = Instance.new("Frame")
    PagesContainer.Size = UDim2.new(1, 0, 1, -75)
    PagesContainer.Position = UDim2.new(0, 0, 0, 75)
    PagesContainer.BackgroundTransparency = 1
    PagesContainer.Parent = MainFrame

    local function CreateTab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 110, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(26, 32, 44)
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.fromRGB(170, 175, 185)
        TabBtn.TextSize = 12
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Parent = TabBar

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.CanvasSize = UDim2.new(0, 0, 0, 800)
        Page.ScrollBarThickness = 4
        Page.Visible = false
        Page.Parent = PagesContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout.Parent = Page

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(PagesContainer:GetChildren()) do
                if p:IsA("ScrollingFrame") then p.Visible = false end
            end
            for _, b in pairs(TabBar:GetChildren()) do
                if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(170, 175, 185) end
            end
            Page.Visible = true
            TabBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
        end)

        return Page
    end

    local FarmPage = CreateTab("Main Farm")
    local SeaPage = CreateTab("Sea Events")
    local StatsPage = CreateTab("Auto Stats")
    local ESPPage = CreateTab("ESP/Visuals")
    local FruitPage = CreateTab("Devil Fruits")
    local StatPage = CreateTab("Settings")

    local function AddToggle(page, text, default, callback)
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(1, -16, 0, 38)
        ToggleBtn.Position = UDim2.new(0, 8, 0, 0)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 38)
        ToggleBtn.Text = "    " .. text
        ToggleBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
        ToggleBtn.TextSize = 13
        ToggleBtn.Font = Enum.Font.GothamMedium
        ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
        ToggleBtn.Parent = page
        Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 16, 0, 16)
        Indicator.Position = UDim2.new(1, -28, 0.5, -8)
        Indicator.BackgroundColor3 = default and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 85)
        Indicator.Parent = ToggleBtn
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

        local state = default
        ToggleBtn.MouseButton1Click:Connect(function()
            state = not state
            Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 85)
            if callback then callback(state) end
            if Loader.SaveSettings then Loader:SaveSettings() end
        end)
    end

    AddToggle(FarmPage, "Start Farm", Loader.Config.AutoFarm, function(s) Loader.Config.AutoFarm = s end)
    AddToggle(FarmPage, "Auto Quest", Loader.Config.AutoQuest, function(s) Loader.Config.AutoQuest = s end)
    AddToggle(FarmPage, "Fast Attack", Loader.Config.FastAttack, function(s) Loader.Config.FastAttack = s end)
    AddToggle(FarmPage, "Bring Mobs", Loader.Config.BringMobs, function(s) Loader.Config.BringMobs = s end)
    AddToggle(FarmPage, "Auto Turn on Buso", Loader.Config.AutoBuso, function(s) Loader.Config.AutoBuso = s end)

    AddToggle(SeaPage, "Auto Sea Event", Loader.Config.AutoSeaEvent, function(s) Loader.Config.AutoSeaEvent = s end)
    AddToggle(SeaPage, "Auto Terrorshark", Loader.Config.AutoTerrorshark, function(s) Loader.Config.AutoTerrorshark = s end)
    AddToggle(SeaPage, "Auto Dojo Belt", Loader.Config.AutoDojoBelt, function(s) Loader.Config.AutoDojoBelt = s end)

    AddToggle(StatsPage, "Auto Stats Enabled", Loader.Config.AutoStatsEnabled, function(s) Loader.Config.AutoStatsEnabled = s end)
    AddToggle(StatsPage, "Auto Melee", Loader.Config.AutoMelee, function(s) Loader.Config.AutoMelee = s end)
    AddToggle(StatsPage, "Auto Defense", Loader.Config.AutoDefense, function(s) Loader.Config.AutoDefense = s end)
    AddToggle(StatsPage, "Auto Sword", Loader.Config.AutoSword, function(s) Loader.Config.AutoSword = s end)
    AddToggle(StatsPage, "Auto Gun", Loader.Config.AutoGun, function(s) Loader.Config.AutoGun = s end)
    AddToggle(StatsPage, "Auto Devil Fruit", Loader.Config.AutoDevilFruit, function(s) Loader.Config.AutoDevilFruit = s end)

    AddToggle(ESPPage, "ESP Players", Loader.Config.ESPPlayer, function(s) Loader.Config.ESPPlayer = s end)
    AddToggle(ESPPage, "ESP Chests", Loader.Config.ESPChest, function(s) Loader.Config.ESPChest = s end)
    AddToggle(ESPPage, "ESP Fruits", Loader.Config.ESPFruit, function(s) Loader.Config.ESPFruit = s end)

    AddToggle(FruitPage, "Auto Random Fruit (Gacha)", Loader.Config.AutoGacha, function(s) Loader.Config.AutoGacha = s end)
    AddToggle(FruitPage, "Auto Store Fruit", Loader.Config.AutoStoreFruit, function(s) Loader.Config.AutoStoreFruit = s end)

    AddToggle(StatPage, "Auto Select Marine", Loader.Config.AutoMarine, function(s) Loader.Config.AutoMarine = s end)
    AddToggle(StatPage, "Boost FPS", Loader.Config.BoostFPS, function(s) Loader.Config.BoostFPS = s end)
end

return UI
