-- Teddy Hub - VIP Premium Edition (Clean & Optimized)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local Config = {
    AutoFarm = false,
    AutoRaid = false,
    FastAttack = true,
    BringMobs = true,
    AutoBuso = true,
    AutoMarine = true,
    DistanceY = 30
}

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

pcall(function()
    if CoreGui:FindFirstChild("TeddyHub_VIP") then
        CoreGui.TeddyHub_VIP:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TeddyHub_VIP"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 180)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    ToggleBtn.Text = "VIP"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
    ToggleBtn.TextSize = 13
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ScreenGui
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 340, 0, 310)
    MainFrame.Position = UDim2.new(0.5, -170, 0.5, -155)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 16, 25)
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundTransparency = 1
    Title.Text = "TEDDY HUB [PREMIUM VIP]"
    Title.TextColor3 = Color3.fromRGB(255, 215, 0)
    Title.TextSize = 15
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local function AddToggleUI(name, configKey, posY)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -24, 0, 38)
        btn.Position = UDim2.new(0, 12, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(28, 24, 38)
        btn.Text = "    " .. name
        btn.TextColor3 = Color3.fromRGB(240, 240, 240)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = MainFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 14, 0, 14)
        indicator.Position = UDim2.new(1, -25, 0.5, -7)
        indicator.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(70, 60, 90)
        indicator.Parent = btn
        Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

        btn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            indicator.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(70, 60, 90)
        end)
    end

    AddToggleUI("Auto Farm Level", "AutoFarm", 50)
    AddToggleUI("Auto Raid (Awakening)", "AutoRaid", 95)
    AddToggleUI("Fast Attack (VIP)", "FastAttack", 140)
    AddToggleUI("Bring Mobs", "BringMobs", 185)
    AddToggleUI("Auto Buso Haki", "AutoBuso", 230)
end)

task.spawn(function()
    pcall(function()
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)
end)

task.spawn(function()
    while task.wait(1) do
        if Config.AutoRaid then
            pcall(function()
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes and remotes:FindFirstChild("CommF_") then
                    remotes.CommF_:InvokeServer("RaidsNpc", "Select")
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.12) do
        if Config.AutoFarm then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
                local rootPart = char.HumanoidRootPart
                local humanoid = char.Humanoid

                if humanoid.Health < (humanoid.MaxHealth * 0.25) then
                    rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 180, 0)
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
                                    if (oRoot.Position - eRoot.Position).Magnitude < 450 then
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

task.spawn(function()
    RunService.Stepped:Connect(function()
        if (Config.AutoFarm or Config.AutoRaid) and Config.FastAttack then
            pcall(function()
                local combatTool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if combatTool then combatTool:Activate() end
            end)
        end
    end)
end)
