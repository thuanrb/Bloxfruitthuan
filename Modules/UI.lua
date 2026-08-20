local UI = {}

function UI:Init(Loader)
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Xóa UI cũ nếu có
    if CoreGui:FindFirstChild("BloosHub_Pro") then
        CoreGui.BloosHub_Pro:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloosHub_Pro"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    -- Nút thu phóng/mở Hub ngoài màn hình
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Name = "ToggleBtn"
    ToggleBtn.Size = UDim2.new(0, 110, 0, 40)
    ToggleBtn.Position = UDim2.new(0, 20, 0, 150)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    ToggleBtn.Text = "Bloos Hub"
    ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
    ToggleBtn.TextSize = 14
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ScreenGui

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleBtn

    -- Khung chính của Hub (Main Frame)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Thanh tiêu đề (TopBar)
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 30, 42)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "BLOOS HUB : BLOX FRUITS"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    -- Khu vực chứa các Tab (Tab Buttons Container)
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(1, 0, 0, 40)
    TabContainer.Position = UDim2.new(0, 0, 0, 45)
    TabContainer.BackgroundColor3 = Color3.fromRGB(22, 27, 38)
    TabContainer.BorderSizePixel = 0
    TabContainer.CanvasSize = UDim2.new(0, 500, 0, 0)
    TabContainer.ScrollBarThickness = 2
    TabContainer.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.Parent = TabContainer

    -- Khu vực hiển thị nội dung từng Tab (Pages Container)
    local PagesContainer = Instance.new("Frame")
    PagesContainer.Size = UDim2.new(1, 0, 1, -85)
    PagesContainer.Position = UDim2.new(0, 0, 0, 85)
    PagesContainer.BackgroundTransparency = 1
    PagesContainer.Parent = MainFrame

    -- Hàm tạo Tab con giống Teddy Hub
    local tabs = {}
    local function CreateTab(tabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 90, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 36, 50)
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabBtn.TextSize = 13
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Parent = TabContainer

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.CanvasSize = UDim2.new(0, 0, 0, 600)
        Page.ScrollBarThickness = 4
        Page.Visible = false
        Page.Parent = PagesContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = Page

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(PagesContainer:GetChildren()) do
                if p:IsA("ScrollingFrame") then p.Visible = false end
            end
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(180, 180, 180) end
            end
            Page.Visible = true
            TabBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
        end)

        return Page
    end

    -- Khởi tạo các Tab mẫu
    local FarmTab = CreateTab("Farm")
    local HopTab = CreateTab("Hop & TTK")
    local SettingsTab = CreateTab("Settings")

    -- Hàm tạo Toggle (Bật/Tắt chức năng)
    local function AddToggle(parentPage, text, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, -20, 0, 45)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 42)
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Parent = parentPage

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = ToggleFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.7, 0, 1, 0)
        Label.Position = UDim2.new(0, 15, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(240, 240, 240)
        Label.TextSize = 14
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame

        local SwitchBtn = Instance.new("TextButton")
        SwitchBtn.Size = UDim2.new(0, 45, 0, 24)
        SwitchBtn.Position = UDim2.new(1, -60, 0.5, -12)
        SwitchBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 75)
        SwitchBtn.Text = ""
        SwitchBtn.Parent = ToggleFrame

        local SwitchCorner = Instance.new("UICorner")
        SwitchCorner.CornerRadius = UDim.new(1, 0)
        SwitchCorner.Parent = SwitchBtn

        local Circle = Instance.new("Frame")
        Circle.Size = UDim2.new(0, 18, 0, 18)
        Circle.Position = UDim2.new(0, 3, 0.5, -9)
        Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Circle.Parent = SwitchBtn

        local CircleCorner = Instance.new("UICorner")
        CircleCorner.CornerRadius = UDim.new(1, 0)
        CircleCorner.Parent = Circle

        local toggled = false
        SwitchBtn.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                SwitchBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
                Circle:TweenPosition(UDim2.new(1, -21, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            else
                SwitchBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 75)
                Circle:TweenPosition(UDim2.new(0, 3, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            end
            if callback then callback(toggled) end
        end)
    end

    -- Đưa các nút chức năng mẫu vào các Tab
    AddToggle(FarmTab, "Auto Farm Level", function(state)
        Loader.Config.AutoFarm = state
        print("Auto Farm set to:", state)
    end)

    AddToggle(HopTab, "Auto Server Hop Săn TTK", function(state)
        Loader.Config.HopTTK = state
        print("Hop TTK set to:", state)
    end)

    AddToggle(SettingsTab, "Boost FPS / Tối ưu hiệu năng", function(state)
        Loader.Config.BoostFPS = state
        print("Boost FPS set to:", state)
    end)

    print("Bloos Hub Pro UI Loaded Successfully!")
end

return UI
