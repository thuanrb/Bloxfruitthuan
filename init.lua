-- Teddy Hub - Ultimate Clean Single Script (V7 - Advanced Optimized)
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local Config = {
    AutoFarm = false,
    AutoQuest = true,
    FastAttack = true,
    BringMobs = true,
    AutoBuso = true,
    AutoMarine = true,
    DistanceY = 30
}

-- Auto Select Team (Marine)
task.spawn(function()
    if Config.AutoMarine then
        pcall(function()
            local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
            if remotes and remotes:FindFirstChild("CommF_") then
                remotes.CommF_:InvokeServer("SetTeam", "Marines")
            end
        end)
    end
end)

-- Create Simple Clean UI
pcall(function()
    if CoreGui:FindFirstChild("TeddyHub_V7") then
        CoreGui.TeddyHub_V7:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TeddyHub_V7"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 180)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    ToggleBtn.Text = "BL"
    ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
    ToggleBtn.TextSize = 14
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ScreenGui
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 260)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130)
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = "TEDDY HUB - ULTIMATE V7"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local function AddToggleUI(name, configKey, posY)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -20, 0, 35)
        btn.Position = UDim2.new(0, 10, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(22, 28, 38)
        btn.Text = "    " .. name
        btn.TextColor3 = Color3.fromRGB(230, 230, 230)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = MainFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 14, 0, 14)
        indicator.Position = UDim2.new(1, -25, 0.5, -7)
        indicator.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 85)
        indicator.Parent = btn
        Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

        btn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            indicator.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 85)
        end)
    end

    AddToggleUI("Auto Farm Level", "AutoFarm", 50)
    AddToggleUI("Fast Attack", "FastAttack", 95)
    AddToggleUI("Bring Mobs", "BringMobs", 140)
    AddToggleUI("Auto Buso Haki", "AutoBuso", 185)
end)

-- Anti-AFK
task.spawn(function()
    pcall(function()
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)
end)

-- Core Farm Loop
task.spawn(function()
    while task.wait(0.15) do
        if Config.AutoFarm then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
                local rootPart = char.HumanoidRootPart
                local humanoid = char.Humanoid

                if humanoid.Health < (humanoid.MaxHealth * 0.25) then
                    rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 150, 0)
                    task.wait(1.5)
                    return
                end

                if Config.AutoBuso and not char:FindFirstChild("HasBuso") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end

                local weaponName = Config.SelectedTool or "Melee"
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                if backpack and not char:FindFirstChildOfClass("Tool") then
                    local tool = backpack:FindFirstChild(weaponName) or backpack:FindFirstChildOfClass("Tool")
                    if tool then humanoid:EquipTool(tool) end
                end

                local enemiesFolder = Workspace:FindFirstChild("Enemies")
                if enemiesFolder then
                    local targetEnemy, shortestDist = nil, math.huge
                    for _, enemy in pairs(enemiesFolder:GetChildren()) do
                        local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                        local eHum = enemy:FindFirstChild("Humanoid")
                        if eRoot and eHum and eHum.Health > 0 then
                            local dist = (eRoot.Position - rootPart.Position).Magnitude
                            if dist < shortestDist then
                                shortestDist = dist
                                targetEnemy = enemy
                            end
                        end
                    end

                    if targetEnemy then
                        local eRoot = targetEnemy.HumanoidRootPart
                        if Config.BringMobs then
                            for _, otherEnemy in pairs(enemiesFolder:GetChildren()) do
                                local oRoot = otherEnemy:FindFirstChild("HumanoidRootPart")
                                local oHum = otherEnemy:FindFirstChild("Humanoid")
                                if oRoot and oHum and oHum.Health > 0 and otherEnemy.Name == targetEnemy.Name then
                                    if (oRoot.Position - eRoot.Position).Magnitude < 400 then
                                        oRoot.CFrame = eRoot.CFrame
                                        oRoot.CanCollide = false
                                        oRoot.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                    end
                                end
                            end
                        end

                        rootPart.CFrame = eRoot.CFrame * CFrame.new(0, Config.DistanceY, 0)
                        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(1280, 672))
                    end
                end
            end)
        end
    end
end)

-- Fast Attack Stream
task.spawn(function()
    RunService.Stepped:Connect(function()
        if Config.AutoFarm and Config.FastAttack then
            pcall(function()
                local combatTool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if combatTool then combatTool:Activate() end
            end)
        end
    end)
end)
