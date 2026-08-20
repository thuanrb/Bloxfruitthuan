-- [BLOOS HUB - ULTIMATE EDITION v2]
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local CommF = RS:WaitForChild("Remotes"):WaitForChild("CommF_")

getgenv().HubConfig = {
    AutoFarm = false,
    FastAttack = true,
    AttackSpeed = 0.05,
    FarmHeight = 10,
    UseSkills = true,
    WeaponType = "Melee",
    BringMob = true,
    SafeMode = true,
    AutoRejoin = true,
    FruitESP = false,
    EnableSkyPlatform = true,
    EventMirageKitsune = false
}

local _G_IsFlying = false

if getgenv().HubConfig.AutoRejoin then
    pcall(function()
        local CoreGui = game:GetService("CoreGui")
        CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
            if child.Name == 'ErrorPrompt' then
                task.spawn(function()
                    while task.wait(3) do
                        TeleportService:Teleport(game.PlaceId, LocalPlayer)
                    end
                end)
            end
        end)
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    _G_IsFlying = false
    task.wait(1)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if hrp and hrp:FindFirstChild("AntiGravity") then
        hrp.AntiGravity:Destroy()
    end
end)

local function CreateUI()
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "UltimateHubV2"
    
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 360, 0, 480)
    MainFrame.Position = UDim2.new(0.5, -180, 0.5, -240)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Draggable = true
    MainFrame.Active = true

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    Title.Text = "⚡ BLOX FRUIT MASTER HUB ⚡"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

    local ToggleButton = Instance.new("TextButton", ScreenGui)
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    ToggleButton.Text = "UI"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 18
    ToggleButton.Font = Enum.Font.GothamBold
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
    
    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local function CreateToggle(name, yPos, configKey)
        local btn = Instance.new("TextButton", MainFrame)
        btn.Size = UDim2.new(0.9, 0, 0, 32)
        btn.Position = UDim2.new(0.05, 0, 0, yPos)
        btn.BackgroundColor3 = getgenv().HubConfig[configKey] and Color3.fromRGB(40, 160, 80) or Color3.fromRGB(60, 60, 80)
        btn.Text = name .. ": " .. (getgenv().HubConfig[configKey] and "ON" or "OFF")
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamMedium
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            getgenv().HubConfig[configKey] = not getgenv().HubConfig[configKey]
            btn.BackgroundColor3 = getgenv().HubConfig[configKey] and Color3.fromRGB(40, 160, 80) or Color3.fromRGB(60, 60, 80)
            btn.Text = name .. ": " .. (getgenv().HubConfig[configKey] and "ON" or "OFF")
        end)
    end

    CreateToggle("Auto Farm Level", 55, "AutoFarm")
    CreateToggle("Fast Attack", 95, "FastAttack")
    CreateToggle("Auto Skills (Z X C V)", 135, "UseSkills")
    CreateToggle("Bring Mob", 175, "BringMob")
    CreateToggle("Safe Mode", 215, "SafeMode")
    CreateToggle("Fruit ESP", 255, "FruitESP")
    CreateToggle("Event Mirage & Kitsune", 295, "EventMirageKitsune")

    local infoLabel = Instance.new("TextLabel", MainFrame)
    infoLabel.Size = UDim2.new(0.9, 0, 0, 100)
    infoLabel.Position = UDim2.new(0.05, 0, 0, 345)
    infoLabel.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
    infoLabel.Text = "⚙️ Config Info:\n• Farm Height: " .. getgenv().HubConfig.FarmHeight .. " studs\n• Attack Speed: " .. getgenv().HubConfig.AttackSpeed .. "s"
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.TextSize = 12
    infoLabel.Font = Enum.Font.Code
    infoLabel.TextWrapped = true
    Instance.new("UICorner", infoLabel).CornerRadius = UDim.new(0, 6)
end

task.spawn(CreateUI)

local function SmartBypassTween(targetCFrame)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local dist = (hrp.Position - targetCFrame.Position).Magnitude
    if dist < 20 then
        hrp.CFrame = targetCFrame
        return
    end

    _G_IsFlying = true
    local speed = 300

    if dist > 200 then
        local upPoint = CFrame.new(hrp.Position.X, 500, hrp.Position.Z)
        local tweenUp = TS:Create(hrp, TweenInfo.new((hrp.Position - upPoint.Position).Magnitude / speed, Enum.EasingStyle.Linear), {CFrame = upPoint})
        tweenUp:Play() tweenUp.Completed:Wait()

        local overTarget = CFrame.new(targetCFrame.Position.X, 500, targetCFrame.Position.Z)
        local tweenCross = TS:Create(hrp, TweenInfo.new((upPoint.Position - overTarget.Position).Magnitude / speed, Enum.EasingStyle.Linear), {CFrame = overTarget})
        tweenCross:Play() tweenCross.Completed:Wait()
    end

    local tweenDown = TS:Create(hrp, TweenInfo.new((hrp.Position - targetCFrame.Position).Magnitude / speed, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tweenDown:Play() tweenDown.Completed:Wait()
    
    _G_IsFlying = false
end

RunService.Stepped:Connect(function()
    if _G_IsFlying then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

local skyPlatform = Instance.new("Part")
skyPlatform.Size = Vector3.new(15, 1, 15)
skyPlatform.Anchored = true
skyPlatform.Transparency = 1
skyPlatform.Parent = WS

RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        local nearPlayer = false
        if getgenv().HubConfig.SafeMode and hrp then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude < 150 then
                        nearPlayer = true
                        break
                    end
                end
            end
        end

        if getgenv().HubConfig.AutoFarm and getgenv().HubConfig.EnableSkyPlatform and hrp and not _G_IsFlying and not nearPlayer then
            skyPlatform.CFrame = hrp.CFrame * CFrame.new(0, -3.6, 0)
            if not hrp:FindFirstChild("AntiGravity") then
                local antiG = Instance.new("BodyVelocity")
                antiG.Name = "AntiGravity"
                antiG.MaxForce = Vector3.new(0, math.huge, 0)
                antiG.Velocity = Vector3.new(0, 0, 0)
                antiG.Parent = hrp
            end
        else
            skyPlatform.CFrame = CFrame.new(0, -9999, 0)
            if hrp and hrp:FindFirstChild("AntiGravity") then
                hrp.AntiGravity:Destroy()
            end
        end
    end)
end)

task.spawn(function()
    while task.wait(1) do
        if getgenv().HubConfig.FruitESP then
            pcall(function()
                for _, v in pairs(WS:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("Handle") then
                        if not v.Handle:FindFirstChild("FruitBillboard") then
                            local billboard = Instance.new("BillboardGui", v.Handle)
                            billboard.Name = "FruitBillboard"
                            billboard.Size = UDim2.new(0, 200, 0, 50)
                            billboard.AlwaysOnTop = true

                            local textLabel = Instance.new("TextLabel", billboard)
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Text = "🍎 " .. v.Name
                            textLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                            textLabel.TextSize = 14
                            textLabel.Font = Enum.Font.GothamBold
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if getgenv().HubConfig.EventMirageKitsune then
            pcall(function()
                for _, v in pairs(WS:GetChildren()) do
                    if v.Name:find("Mirage") or v.Name:find("Kitsune") or v.Name:find("Haunted") then
                        local islandPart = v:FindFirstChild("Model") or v:FindFirstChildWhichIsA("BasePart")
                        if islandPart then
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                SmartBypassTween(islandPart.CFrame * CFrame.new(0, 100, 0))
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(getgenv().HubConfig.AttackSpeed)
        if getgenv().HubConfig.FastAttack and getgenv().HubConfig.AutoFarm and not _G_IsFlying then
            pcall(function()
                RS.Modules.Net.RegisterAttack:FireServer(0)
                RS.Modules.Net.RegisterHit:FireServer()
            end)
        end
    end
end)

local function EquipWeapon(weaponType)
    local char = LocalPlayer.Character
    if not char then return end
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == weaponType then
            char.Humanoid:EquipTool(tool) return tool
        end
    end
end

local QuestDatabase = {
    Sea1 = {
        {Min = 1, Max = 9, Quest = "BanditQuest1", Lvl = 1, Mob = "Bandit", Npc = CFrame.new(1059, 16, 1549), MobPos = CFrame.new(1145, 16, 1630)},
        {Min = 10, Max = 29, Quest = "JungleQuest", Lvl = 1, Mob = "Monkey", Npc = CFrame.new(-1598, 36, 153), MobPos = CFrame.new(-1498, 30, 50)},
        {Min = 30, Max = 59, Quest = "BuggyQuest1", Lvl = 1, Mob = "Pirate", Npc = CFrame.new(-1140, 4, 3828), MobPos = CFrame.new(-1201, 19, 3915)},
        {Min = 60, Max = 89, Quest = "DesertQuest", Lvl = 1, Mob = "Desert Bandit", Npc = CFrame.new(896, 6, 4390), MobPos = CFrame.new(944, 7, 4381)},
        {Min = 90, Max = 119, Quest = "SnowQuest", Lvl = 1, Mob = "Snow Bandit", Npc = CFrame.new(1389, 87, -1298), MobPos = CFrame.new(1327, 105, -1437)},
        {Min = 120, Max = 149, Quest = "MarineQuest2", Lvl = 1, Mob = "Chief Petty Officer", Npc = CFrame.new(-5035, 27, 4324), MobPos = CFrame.new(-4885, 21, 4277)},
        {Min = 150, Max = 174, Quest = "SkyQuest", Lvl = 1, Mob = "Sky Bandit", Npc = CFrame.new(-4842, 717, -2623), MobPos = CFrame.new(-4981, 290, -2831)},
        {Min = 175, Max = 189, Quest = "SkyQuest", Lvl = 2, Mob = "Dark Master", Npc = CFrame.new(-4842, 717, -2623), MobPos = CFrame.new(-5253, 395, -2273)},
        {Min = 190, Max = 209, Quest = "PrisonerQuest", Lvl = 1, Mob = "Prisoner", Npc = CFrame.new(5308, 2, 474), MobPos = CFrame.new(5131, 1, 626)},
        {Min = 210, Max = 249, Quest = "ColosseumQuest", Lvl = 1, Mob = "Toga Warrior", Npc = CFrame.new(-1580, 7, -2985), MobPos = CFrame.new(-1842, 51, -3085)},
        {Min = 250, Max = 299, Quest = "MagmaQuest", Lvl = 1, Mob = "Military Spy", Npc = CFrame.new(-5316, 12, 8515), MobPos = CFrame.new(-5802, 80, 8835)},
        {Min = 300, Max = 374, Quest = "FishmanQuest", Lvl = 1, Mob = "Fishman Warrior", Npc = CFrame.new(61123, 18, 1569), MobPos = CFrame.new(60875, 19, 1279)},
        {Min = 375, Max = 449, Quest = "HopQuest", Lvl = 1, Mob = "God's Guard", Npc = CFrame.new(-4721, 845, -1954), MobPos = CFrame.new(-4689, 846, -1928)},
        {Min = 450, Max = 524, Quest = "FountainQuest", Lvl = 1, Mob = "Galley Pirate", Npc = CFrame.new(5259, 38, 4050), MobPos = CFrame.new(5560, 60, 3968)},
        {Min = 525, Max = 700, Quest = "FountainQuest", Lvl = 2, Mob = "Galley Captain", Npc = CFrame.new(5259, 38, 4050), MobPos = CFrame.new(5349, 41, 4880)}
    },
    Sea2 = {
        {Min = 700, Max = 724, Quest = "Area1Quest", Lvl = 1, Mob = "Raider", Npc = CFrame.new(-425, 72, 1837), MobPos = CFrame.new(-746, 72, 2392)},
        {Min = 725, Max = 749, Quest = "Area1Quest", Lvl = 2, Mob = "Mercenary", Npc = CFrame.new(-425, 72, 1837), MobPos = CFrame.new(-893, 72, 1530)},
        {Min = 750, Max = 799, Quest = "Area2Quest", Lvl = 1, Mob = "Swan Pirate", Npc = CFrame.new(638, 73, 918), MobPos = CFrame.new(878, 122, 1220)},
        {Min = 800, Max = 849, Quest = "FactoryStaffQuest", Lvl = 1, Mob = "Factory Staff", Npc = CFrame.new(602, 102, -282), MobPos = CFrame.new(315, 131, -210)},
        {Min = 850, Max = 899, Quest = "MarineQuest3", Lvl = 1, Mob = "Marine Lieutenant", Npc = CFrame.new(-2443, 73, -3219), MobPos = CFrame.new(-2840, 74, -3098)},
        {Min = 900, Max = 949, Quest = "MarineQuest3", Lvl = 2, Mob = "Marine Captain", Npc = CFrame.new(-2443, 73, -3219), MobPos = CFrame.new(-2183, 74, -3194)},
        {Min = 950, Max = 999, Quest = "ZombieQuest", Lvl = 1, Mob = "Zombie", Npc = CFrame.new(-5497, 48, -795), MobPos = CFrame.new(-5694, 60, -712)},
        {Min = 1000, Max = 1049, Quest = "ZombieQuest", Lvl = 2, Mob = "Vampire", Npc = CFrame.new(-5497, 48, -795), MobPos = CFrame.new(-6014, 16, -1314)},
        {Min = 1050, Max = 1099, Quest = "SnowMountainQuest", Lvl = 1, Mob = "Snow Trooper", Npc = CFrame.new(607, 401, -5370), MobPos = CFrame.new(469, 429, -5312)},
        {Min = 1100, Max = 1149, Quest = "SnowMountainQuest", Lvl = 2, Mob = "Winter Warrior", Npc = CFrame.new(607, 401, -5370), MobPos = CFrame.new(1159, 458, -5143)},
        {Min = 1150, Max = 1199, Quest = "IceSideQuest", Lvl = 1, Mob = "Lab Subordinate", Npc = CFrame.new(-6062, 16, -4907), MobPos = CFrame.new(-5770, 61, -4467)},
        {Min = 1200, Max = 1249, Quest = "IceSideQuest", Lvl = 2, Mob = "Horned Warrior", Npc = CFrame.new(-6062, 16, -4907), MobPos = CFrame.new(-6285, 16, -5842)},
        {Min = 1250, Max = 1299, Quest = "FireSideQuest", Lvl = 1, Mob = "Magma Ninja", Npc = CFrame.new(-5428, 16, -5967), MobPos = CFrame.new(-5395, 76, -5255)},
        {Min = 1300, Max = 1349, Quest = "FireSideQuest", Lvl = 2, Mob = "Lava Pirate", Npc = CFrame.new(-5428, 16, -5967), MobPos = CFrame.new(-5125, 41, -4718)},
        {Min = 1350, Max = 1424, Quest = "ShipQuest1", Lvl = 1, Mob = "Ship Deckhand", Npc = CFrame.new(1038, 125, 32910), MobPos = CFrame.new(1160, 150, 33110)},
        {Min = 1425, Max = 1500, Quest = "ShipQuest1", Lvl = 2, Mob = "Ship Engineer", Npc = CFrame.new(1038, 125, 32910), MobPos = CFrame.new(919, 150, 32770)}
    },
    Sea3 = {
        {Min = 1500, Max = 1524, Quest = "PiratePortQuest", Lvl = 1, Mob = "Pirate Millionaire", Npc = CFrame.new(-290, 44, 5581), MobPos = CFrame.new(-318, 44, 5971)},
        {Min = 1525, Max = 1549, Quest = "PiratePortQuest", Lvl = 2, Mob = "Pistol Billionaire", Npc = CFrame.new(-290, 44, 5581), MobPos = CFrame.new(-480, 75, 6092)},
        {Min = 1550, Max = 1574, Quest = "AmazonQuest", Lvl = 1, Mob = "Dragon Crew Warrior", Npc = CFrame.new(5833, 51, -1102), MobPos = CFrame.new(6233, 100, -1451)},
        {Min = 1575, Max = 1599, Quest = "AmazonQuest", Lvl = 2, Mob = "Dragon Crew Archer", Npc = CFrame.new(5833, 51, -1102), MobPos = CFrame.new(6639, 150, -1141)},
        {Min = 1600, Max = 1624, Quest = "MarineTreeIsland", Lvl = 1, Mob = "Female Islander", Npc = CFrame.new(2340, 73, -6507), MobPos = CFrame.new(2125, 51, -6863)},
        {Min = 1625, Max = 1649, Quest = "MarineTreeIsland", Lvl = 2, Mob = "Giant Islander", Npc = CFrame.new(2340, 73, -6507), MobPos = CFrame.new(2628, 105, -7123)},
        {Min = 1650, Max = 1699, Quest = "MarineTreeIsland", Lvl = 3, Mob = "Marine Commodore", Npc = CFrame.new(2340, 73, -6507), MobPos = CFrame.new(2438, 73, -7389)},
        {Min = 1700, Max = 1724, Quest = "DeepForestIsland", Lvl = 1, Mob = "Forest Pirate", Npc = CFrame.new(-13232, 332, -7625), MobPos = CFrame.new(-13456, 333, -7912)},
        {Min = 1725, Max = 1749, Quest = "DeepForestIsland", Lvl = 2, Mob = "Mythological Pirate", Npc = CFrame.new(-13232, 332, -7625), MobPos = CFrame.new(-13689, 412, -7001)},
        {Min = 1750, Max = 1799, Quest = "DeepForestIsland", Lvl = 3, Mob = "Jungle Pirate", Npc = CFrame.new(-13232, 332, -7625), MobPos = CFrame.new(-12123, 333, -7812)},
        {Min = 1800, Max = 1824, Quest = "HauntedQuest1", Lvl = 1, Mob = "Reborn Skeleton", Npc = CFrame.new(-9516, 172, 6078), MobPos = CFrame.new(-8892, 140, 5971)},
        {Min = 1825, Max = 1849, Quest = "HauntedQuest1", Lvl = 2, Mob = "Living Zombie", Npc = CFrame.new(-9516, 172, 6078), MobPos = CFrame.new(-10123, 140, 6012)},
        {Min = 1850, Max = 1899, Quest = "HauntedQuest2", Lvl = 1, Mob = "Demonic Soul", Npc = CFrame.new(-9516, 172, 6078), MobPos = CFrame.new(-9523, 175, 6214)},
        {Min = 1900, Max = 1924, Quest = "HauntedQuest2", Lvl = 2, Mob = "Posessed Mummy", Npc = CFrame.new(-9516, 172, 6078), MobPos = CFrame.new(-9123, 200, 6012)},
        {Min = 1950, Max = 1974, Quest = "NutsIslandQuest", Lvl = 1, Mob = "Peanut Scout", Npc = CFrame.new(-21043, 30, -10194), MobPos = CFrame.new(-21234, 45, -10356)},
        {Min = 1975, Max = 1999, Quest = "NutsIslandQuest", Lvl = 2, Mob = "Peanut President", Npc = CFrame.new(-21043, 30, -10194), MobPos = CFrame.new(-22123, 75, -10612)},
        {Min = 2000, Max = 2024, Quest = "IceCreamIslandQuest", Lvl = 1, Mob = "Ice Cream Chef", Npc = CFrame.new(-820, 65, -10965), MobPos = CFrame.new(-612, 85, -11123)},
        {Min = 2025, Max = 2049, Quest = "IceCreamIslandQuest", Lvl = 2, Mob = "Ice Cream Commander", Npc = CFrame.new(-820, 65, -10965), MobPos = CFrame.new(-1123, 115, -11412)},
        {Min = 2050, Max = 2099, Quest = "CakeQuest1", Lvl = 1, Mob = "Cookie Cracker", Npc = CFrame.new(-2021, 38, -12024), MobPos = CFrame.new(-2341, 78, -12124)}
    }
}
