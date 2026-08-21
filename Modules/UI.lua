local UI = {}

function UI:Init(Loader)
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    if CoreGui:FindFirstChild("BloosHub_TeddyStyle") then
        CoreGui.BloosHub_TeddyStyle:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloosHub_TeddyStyle"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Position = UDim2.new(0, 20, 0, 200)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    ToggleButton.Text = "Bloos"
    ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 128)
    ToggleButton.TextSize = 12
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Parent = ScreenGui

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleButton

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
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
    TopBar.BackgroundColor3 = Color3.fromRGB(28, 33, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 8)
    TopCorner.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "BLOOS HUB : BLOX FRUITS"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    local ContentArea = Instance.new("ScrollingFrame")
    ContentArea.Size = UDim2.new(1, -20, 1, -60)
    ContentArea.Position = UDim2.new(0, 10, 0, 50)
    ContentArea.BackgroundTransparency = 1
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, 400)
    ContentArea.ScrollBarThickness = 4
    ContentArea.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = ContentArea

    local function CreateToggle(name, defaultState, callback)
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(1, 0, 0, 40)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(28, 33, 45)
        ToggleBtn.Text = "    " .. name
        ToggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        ToggleBtn.TextSize = 13
        ToggleBtn.Font = Enum.Font.GothamMedium
        ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
        ToggleBtn.Parent = ContentArea

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = ToggleBtn

        local StatusIndicator = Instance.new("Frame")
        StatusIndicator.Size = UDim2.new(0, 16, 0, 16)
        StatusIndicator.Position = UDim2.new(1, -30, 0.5, -8)
        StatusIndicator.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(70, 80, 100)
        StatusIndicator.Parent = ToggleBtn

        local IndCorner = Instance.new("UICorner")
        IndCorner.CornerRadius = UDim.new(1, 0)
        IndCorner.Parent = StatusIndicator

        local state = defaultState
        ToggleBtn.MouseButton1Click:Connect(function()
            state = not state
            if state then
                StatusIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
            else
                StatusIndicator.BackgroundColor3 = Color3.fromRGB(70, 80, 100)
            end
            if callback then callback(state) end
        end)
    end

    CreateToggle("Auto Farm Level", Loader.Config.AutoFarm, function(state)
        Loader.Config.AutoFarm = state
    end)

    CreateToggle("Fast Attack", Loader.Config.FastAttack, function(state)
        Loader.Config.FastAttack = state
    end)

    CreateToggle("Auto Server Hop TTK", Loader.Config.HopTTK, function(state)
        Loader.Config.HopTTK = state
    end)

    CreateToggle("Boost FPS", Loader.Config.BoostFPS, function(state)
        Loader.Config.BoostFPS = state
    end)
end

return UI
