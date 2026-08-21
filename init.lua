-- Teddy Hub - Ultimate Universe Master Edition (Full Premium Features & God Mode)
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
    AutoChest = false,
    AutoStats = false,
    AutoBoss = false,
    AutoMastery = false,
    AutoRaceV4 = false,
    SeaEvent_Leviathan = false,
    SeaEvent_SeaBeast = false,
    FindMirage = false,
    FindLegend = false,
    FruitSniper = false,
    AutoBuyHaki = false,
    PlayerESP = false,
    Fullbright = false,
    RemoveFog = false,
    FastAttack = true,
    BringMobs = true,
    AutoBuso = true,
    AutoMarine = true,
    DistanceY = 28
}

-- Automated Team Initialization
task.spawn(function()
    pcall(function()
        if Config.AutoMarine then
            local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
            if remotes and remotes:FindFirstChild("CommF_") then
                remotes.CommF_:InvokeServer("SetTeam", "Marines")
            end
        end
    end)
end)

-- Fullbright & Remove Fog Visual Engine
task.spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if Config.Fullbright then
                game:GetService("Lighting").Brightness = 2
                game:GetService("Lighting").ClockTime = 14
                game:GetService("Lighting").GlobalShadows = false
            end
            if Config.RemoveFog then
                for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
                    if v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("PostEffect") then
                        v.Enabled = false
                    end
                end
            end
        end)
    end)
end)

-- Universe Master Multi-Tab Commercial UI Setup
pcall(function()
    if CoreGui:FindFirstChild("TeddyHub_UniverseMaster") then
        CoreGui.TeddyHub_UniverseMaster:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TeddyHub_UniverseMaster"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 180)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    ToggleBtn.Text = "GOD"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 0, 128)
    ToggleBtn.TextSize = 12
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ScreenGui
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 460, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -230, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 38)
    Title.BackgroundTransparency = 1
    Title.Text = "TEDDY HUB [UNIVERSE GOD EDITION]"
    Title.TextColor3 = Color3.fromRGB(255, 215, 0)
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Tab Bar Containers (Scrollable for 6 Tabs)
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(1, -20, 0, 32)
    TabContainer.Position = UDim2.new(0, 10, 0, 42)
    TabContainer.BackgroundTransparency = 1
    TabContainer.CanvasSize = UDim2.new(0, 520, 0, 0)
    TabContainer.ScrollBarThickness = 0
    TabContainer.Parent = MainFrame

    local function CreateTabButton(name, posX)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 80, 1, 0)
        btn.Position = UDim2.new(0, posX, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(20, 24, 34)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(170, 170, 170)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamBold
        btn.Parent = TabContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        return btn
    end

    local tabFarm = CreateTabButton("Farm/Boss", 0)
    local tabSea = CreateTabButton("Sea Events", 85)
    local tabStats = CreateTabButton("Race V4/Stats", 170)
    local tabShop = CreateTabButton("Shop/Sniper", 255)
    local tabMisc = CreateTabButton("Visual/PVP", 340)
    local tabExtra = CreateTabButton("Mastery", 425)

    local ContentPages = Instance.new("Folder")
    ContentPages.Name = "Pages"
    ContentPages.Parent = MainFrame

    local function CreatePage()
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -20, 1, -85)
        page.Position = UDim2.new(0, 10, 0, 80)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.CanvasSize = UDim2.new(0, 0, 0, 350)
        page.ScrollBarThickness = 4
        page.Visible = false
        page.Parent = ContentPages
        return page
    end

    local pageFarm = CreatePage()
    local pageSea = CreatePage()
    local pageStats = CreatePage()
    local pageShop = CreatePage()
    local pageMisc = CreatePage()
    local pageExtra = CreatePage()

    pageFarm.Visible = true

    local tabs = { 
        {tabFarm, pageFarm}, 
        {tabSea, pageSea}, 
        {tabStats, pageStats}, 
        {tabShop, pageShop}, 
        {tabMisc, pageMisc},
        {tabExtra, pageExtra}
    }
    
    for _, t in ipairs(tabs) do
        t[1].MouseButton1Click:Connect(function()
            for _, o in ipairs(tabs) do
                o[2].Visible = (o[2] == t[2])
                o[1].TextColor3 = (o[1] == t[1]) and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(170, 170, 170)
            end
        end)
    end
    tabFarm.TextColor3 = Color3.fromRGB(0, 255, 200)

    local function AddToggleToPage(parentPage, name, configKey, posY)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 34)
        btn.Position = UDim2.new(0, 0, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
        btn.Text = "    " .. name
        btn.TextColor3 = Color3.fromRGB(240, 240, 240)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = parentPage
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 12, 0, 12)
        indicator.Position = UDim2.new(1, -22, 0.5, -6)
        indicator.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 90)
        indicator.Parent = btn
        Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

        btn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            indicator.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(60, 70, 90)
        end)
    end

    -- Tab 1: Farm & Boss
    AddToggleToPage(pageFarm, "Auto Farm Level", "AutoFarm", 0)
    AddToggleToPage(pageFarm, "Auto Boss Hunter (All Bosses)", "AutoBoss", 38)
    AddToggleToPage(pageFarm, "Auto Raid (Awakening)", "AutoRaid", 76)
    AddToggleToPage(pageFarm, "Auto Collect Chests", "AutoChest", 114)
    AddToggleToPage(pageFarm, "Fast Attack (God Mode)", "FastAttack", 152)
    AddToggleToPage(pageFarm, "Bring Mobs", "BringMobs", 190)

    -- Tab 2: Sea Events & Island Finder
    AddToggleToPage(pageSea, "Auto Sea Beast Hunter", "SeaEvent_SeaBeast", 0)
    AddToggleToPage(pageSea, "Auto Leviathan Hunter", "SeaEvent_Leviathan", 38)
    AddToggleToPage(pageSea, "Auto Find Mirage Island", "FindMirage", 76)
    AddToggleToPage(pageSea, "Auto Find Legend/Kitsune Shrine", "FindLegend", 114)

    -- Tab 3: Race V4 & Stats
    AddToggleToPage(pageStats, "Auto Stats (Melee/Defense/Sword)", "AutoStats", 0)
    AddToggleToPage(pageStats, "Auto Race V4 & Trial Solver", "AutoRaceV4", 38)

    -- Tab 4: Shop & Sniper
    AddToggleToPage(pageShop, "Auto Devil Fruit Sniper (Collect Drops)", "FruitSniper", 0)
    AddToggleToPage(pageShop, "Auto Buy Haki / Enhancements", "AutoBuyHaki", 38)

    -- Tab 5: Visual & Misc / PVP
    AddToggleToPage(pageMisc, "Player ESP (View Enemy Players)", "PlayerESP", 0)
    AddToggleToPage(pageMisc, "Fullbright (No Darkness)", "Fullbright", 38)
    AddToggleToPage(pageMisc, "Remove Fog & Atmosphere", "RemoveFog", 76)
    AddToggleToPage(pageMisc, "Auto Buso Haki", "AutoBuso", 114)
    AddToggleToPage(pageMisc, "Auto Select Marines Team", "AutoMarine", 152)

    -- Tab 6: Mastery Extra
    AddToggleToPage(pageExtra, "Auto Farm Mastery (Skills Spammer)", "AutoMastery", 0)
end)

-- Anti-AFK Engine
task.spawn(function()
    pcall(function()
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)
end)

-- Auto Mastery Skill Spammer
task.spawn(function()
    while task.wait(0.3) do
        if Config.AutoMastery then
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                for _, key in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}) do
                    vim:SendKeyEvent(true, key, false, game)
                    task.wait(0.05)
                    vim:SendKeyEvent(false, key, false, game)
                end
            end)
        end
    end
end)

-- Auto Race V4 & Trial Solver Tracker
task.spawn(function()
    while task.wait(2) do
        if Config.AutoRaceV4 then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Tự động tìm cổng Trial hoặc kích hoạt gear V4 nếu đầy thanh năng lượng
                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                    if remotes and remotes:FindFirstChild("CommF_") then
                        remotes.CommF_:InvokeServer("ActivateAbility")
                    end
                end
            end)
        end
    end
end)

-- Fruit Sniper (Auto pickup dropped fruits)
task.spawn(function()
    while task.wait(0.5) do
        if Config.FruitSniper then
            pcall(function()
                for _, v in pairs(Workspace:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("Handle") then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = v.Handle.CFrame
                        end
                    end
                end
            end)
        end
    end
end)

-- Player ESP Logic
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        pcall(function()
            if Config.PlayerESP then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = p.Character.HumanoidRootPart
                        if not hrp:FindFirstChild("TeddyESP") then
                            local bg = Instance.new("BillboardGui", hrp)
                            bg.Name = "TeddyESP"
                            bg.Size = UDim2.new(0, 50, 0, 25)
                            bg.AlwaysOnTop = true
                            bg.StudsOffset = Vector3.new(0, 3, 0)
                            local tl = Instance.new("TextLabel", bg)
                            tl.Size = UDim2.new(1, 0, 1, 0)
                            tl.BackgroundTransparency = 1
                            tl.TextColor3 = Color3.fromRGB(255, 0, 0)
                            tl.TextScaled = true
                            tl.Font = Enum.Font.GothamBold
                            tl.Text = p.Name
                        end
                    end
                end
            else
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local esp = p.Character.HumanoidRootPart:FindFirstChild("TeddyESP")
                        if esp then esp:Destroy() end
                    end
                end
            end
        end)
    end)
end)

-- Auto Boss Hunter (Elite, Rip_Indra, Dough King, etc.)
task.spawn(function()
    while task.wait(1) do
        if Config.AutoBoss then
            pcall(function()
                local bossFolder = Workspace:FindFirstChild("Enemies")
                if bossFolder then
                    for _, enemy in pairs(bossFolder:GetChildren()) do
                        local hum = enemy:FindFirstChild("Humanoid")
                        local root = enemy:FindFirstChild("HumanoidRootPart")
                        if hum and root and hum.Health > 0 and (enemy.Name:find("Boss") or enemy.Name:find("King") or enemy.Name:find("Rip_Indra") or enemy.Name:find("Elite")) then
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, Config.DistanceY, 0)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Sea Events (Sea Beast & Leviathan Tracking)
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if Config.SeaEvent_SeaBeast or Config.SeaEvent_Leviathan then
                local enemiesFolder = Workspace:FindFirstChild("Enemies")
                if enemiesFolder then
                    for _, enemy in pairs(enemiesFolder:GetChildren()) do
                        if enemy.Name:find("Sea Beast") or enemy.Name:find("Leviathan") or enemy.Name:find("Terror Shark") then
                            local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                            local char = LocalPlayer.Character
                            if eRoot and char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = eRoot.CFrame * CFrame.new(0, 50, 0)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Find Mirage & Legend Islands (Radar Scan)
task.spawn(function()
    while task.wait(3) do
        pcall(function()
            if Config.FindMirage or Config.FindLegend then
                local mapFolder = Workspace:FindFirstChild("_Map") or Workspace
                for _, obj in pairs(mapFolder:GetChildren()) do
                    if (Config.FindMirage and obj.Name:find("Mirage")) or (Config.FindLegend and (obj.Name:find("Prehistoric") or obj.Name:find("Kitsune"))) then
                        local char = LocalPlayer.Character
                        if obj:IsA("Model") and obj.PrimaryPart and char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = obj.PrimaryPart.CFrame + Vector3.new(0, 300, 0)
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Stats Core
task.spawn(function()
    while task.wait(3) do
        if Config.AutoStats then
            pcall(function()
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes and remotes:FindFirstChild("CommF_") then
                    remotes.CommF_:InvokeServer("AddPoint", "Melee", 3)
                    remotes.CommF_:InvokeServer("AddPoint", "Defense", 3)
                    remotes.CommF_:InvokeServer("AddPoint", "Sword", 3)
                end
            end)
        end
    end
end)

-- Auto Chest Collector
task.spawn(function()
    while task.wait(0.5) do
        if Config.AutoChest and not Config.AutoFarm then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local rootPart = char.HumanoidRootPart
                
                local chestFolder = Workspace:FindFirstChild("ChestSpawns") or Workspace
                for _, obj in pairs(chestFolder:GetChildren()) do
                    if obj.Name:find("Chest") and obj:IsA("BasePart") then
                        rootPart.CFrame = obj.CFrame
                        task.wait(0.2)
                        break
                    end
                end
            end)
        end
    end
end)

-- Auto Raid Core
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

-- High-Performance Farm Loop
task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoFarm and not Config.AutoBoss then
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
                        if eRoot and eHum and eHum.Health > 0 and not enemy.Name:find("Boss") then
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
 