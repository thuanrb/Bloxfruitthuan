-- Modules/UI.lua
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

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleButton

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 620, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(22, 27, 36)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 8)
    TopCorner.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 300, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "TEDDY HUB (BLOOS V3) - PREMIUM"
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
    TabBar.CanvasSize = UDim2.new(0, 700, 0, 0)
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
        TabBtn.Size = UDim2.new(0, 100, 1, 0)
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
    local ItemPage = CreateTab("Items & Belts")
    local HopPage = CreateTab("Hop & Boss")
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

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = ToggleBtn

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 16, 0, 16)
        Indicator.Position = UDim2.new(1, -28, 0.5, -8)
        Indicator.BackgroundColor3 = default and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 85)
        Indicator.Parent = ToggleBtn

        local IndCorner = Instance.new("UICorner")
        IndCorner.CornerRadius = UDim.new(1, 0)
        IndCorner.Parent = Indicator

        local state = default
        ToggleBtn.MouseButton1Click:Connect(function()
            state = not state
            Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 85)
            if callback then callback(state) end
        end)
    end

    AddToggle(FarmPage, "Start Farm", Loader.Config.AutoFarm, function(state) Loader.Config.AutoFarm = state end)
    AddToggle(FarmPage, "Fast Attack", Loader.Config.FastAttack, function(state) Loader.Config.FastAttack = state end)
    AddToggle(FarmPage, "Attack Mob", Loader.Config.AttackMob, function(state) Loader.Config.AttackMob = state end)
    AddToggle(FarmPage, "Bring Mobs", Loader.Config.BringMobs, function(state) Loader.Config.BringMobs = state end)
    AddToggle(FarmPage, "Auto Turn on Buso", Loader.Config.AutoBuso, function(state) Loader.Config.AutoBuso = state end)

    AddToggle(SeaPage, "Auto Sea Event (Săn sự kiện biển)", Loader.Config.AutoSeaEvent, function(state) Loader.Config.AutoSeaEvent = state end)
    AddToggle(SeaPage, "Auto Terrorshark", Loader.Config.AutoTerrorshark, function(state) Loader.Config.AutoTerrorshark = state end)
    AddToggle(SeaPage, "Auto Leviathan", Loader.Config.AutoLeviathan, function(state) Loader.Config.AutoLeviathan = state end)
    AddToggle(SeaPage, "Auto Kitsune Island", Loader.Config.AutoKitsune, function(state) Loader.Config.AutoKitsune = state end)

    AddToggle(ItemPage, "Auto Dojo Belt (Lấy đai)", Loader.Config.AutoDojoBelt, function(state) Loader.Config.AutoDojoBelt = state end)
    AddToggle(ItemPage, "Auto Cursed Dual Katana", false, function(state) end)
    AddToggle(ItemPage, "Auto Soul Guitar", false, function(state) end)

    AddToggle(HopPage, "Auto Server Hop Săn TTK", Loader.Config.HopTTK, function(state) Loader.Config.HopTTK = state end)
    AddToggle(HopPage, "Hop Boss (Dough King, Indra)", false, function(state) end)

    AddToggle(StatPage, "Boost FPS (Tối ưu game)", Loader.Config.BoostFPS, function(state) Loader.Config.BoostFPS = state end)
end

return UI
