-- =========================================================================
-- TEDDY HUB V10 - ULTIMATE ENTERPRISE CORE (RINNEGAN EDITION)
-- =========================================================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = Library:MakeWindow({
    Name = "Teddy Hub | Ultimate Enterprise V10 (Rinnegan Edition)", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "TeddyHub_Config"
})

-- =========================================================================
-- RINNEGAN VISUAL SYSTEM (CUSTOM UI OVERLAY & ANIMATIONS)
-- =========================================================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local RinneganScreenGui = Instance.new("ScreenGui")
RinneganScreenGui.Name = "TeddyRinneganOverlay"
RinneganScreenGui.Parent = CoreGui
RinneganScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
RinneganScreenGui.IgnoreGuiInset = true

-- Floating Rotating Rinnegan Button (Menu Toggle / Floating Widget)
local RinneganButton = Instance.new("ImageButton")
RinneganButton.Name = "RinneganButton"
RinneganButton.Parent = RinneganScreenGui
RinneganButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RinneganButton.BackgroundTransparency = 1
RinneganButton.Position = UDim2.new(0, 30, 0.5, -35)
RinneganButton.Size = UDim2.new(0, 70, 0, 70)
RinneganButton.Image = "rbxassetid://6023426915" -- Standard glowing ring / custom asset placeholder for eye texture
RinneganButton.Draggable = true

-- Inner Ripples to simulate Rinnegan pattern rings
local RinneganRing = Instance.new("UIStroke")
RinneganRing.Parent = RinneganButton
RinneganRing.Color = Color3.fromRGB(150, 0, 255)
RinneganRing.Thickness = 3

-- Big Center Rinnegan Overlay (Appears during runtime/running or toggles)
local BigRinnegan = Instance.new("ImageLabel")
BigRinnegan.Name = "BigRinneganRunning"
BigRinnegan.Parent = RinneganScreenGui
BigRinnegan.BackgroundTransparency = 1
BigRinnegan.AnchorPoint = Vector2.new(0.5, 0.5)
BigRinnegan.Position = UDim2.new(0.85, 0, 0.15, 0)
BigRinnegan.Size = UDim2.new(0, 90, 0, 90)
BigRinnegan.Image = "rbxassetid://6023426915"
BigRinnegan.ImageTransparency = 0.3

local BigRinneganRing = Instance.new("UIStroke")
BigRinneganRing.Parent = BigRinnegan
BigRinneganRing.Color = Color3.fromRGB(180, 50, 255)
BigRinneganRing.Thickness = 4

-- Continuous Rotation Animations
RunService.RenderStepped:Connect(function()
    RinneganButton.Rotation = RinneganButton.Rotation + 2
    BigRinnegan.Rotation = BigRinnegan.Rotation - 1.5
end)

-- Toggle Menu Visibility via Rinnegan Button
local menuVisible = true
RinneganButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    pcall(function()
        -- Orion library UI container hook to hide/show
        local mainUI = CoreGui:FindFirstChild("Orion")
        if mainUI then
            mainUI.Enabled = menuVisible
        end
    end)
    
    -- Click pulse effect
    TweenService:Create(RinneganButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 85, 0, 85)}):Play()
    task.wait(0.1)
    TweenService:Create(RinneganButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 70, 0, 70)}):Play()
end)

-- =========================================================================
-- TABS & CONFIGURATION SETUP
-- =========================================================================
local MainTab = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local EventTab = Window:MakeTab({ Name = "Boss & Sea Events", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local RaidTab = Window:MakeTab({ Name = "Auto Raid", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local ItemsTab = Window:MakeTab({ Name = "Items & Fruits", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local VisualTab = Window:MakeTab({ Name = "Visual & ESP", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local TeleportTab = Window:MakeTab({ Name = "Teleport", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local MiscTab = Window:MakeTab({ Name = "Misc & Hop", Icon = "rbxassetid://4483345998", PremiumOnly = false })

_G.AutoFarm = false
_G.FastAttack = true
_G.BringMob = false
_G.AutoHaki = true
_G.FarmDistance = 5
_G.AutoBoss = false
_G.AutoSeaBeast = false
_G.AutoChest = false
_G.FruitSniper = false
_G.PlayerESP = false
_G.MobESP = false
_G.ChestESP = false
_G.FruitESP = false
_G.AutoRaid = false
_G.SelectedRaid = "Flame"
_G.KillAuraRange = 90
_G.AutoAwakening = false
_G.GodmodeBypass = true

local Player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "Kick" or method == "kick" then return nil end
    if method == "FireServer" and tostring(self) == "MainEvent" then
        if args[1] == "Banned" or args[1] == "WalkSpeed" or args[1] == "JumpPower" then return nil end
    end
    return oldNamecall(self, unpack(args))
end)
setreadonly(mt, true)

task.spawn(function()
    while task.wait(2) do
        if (_G.AutoFarm or _G.AutoBoss or _G.AutoSeaBeast or _G.AutoRaid) and _G.AutoHaki then
            pcall(function()
                if not Player.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end
end)

local function getClosestMob()
    local closest = nil
    local dist = math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            if not string.find(v.Name, "Boss") then
                local magnitude = (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
                if magnitude < dist then
                    dist = magnitude
                    closest = v
                end
            end
        end
    end
    return closest
end

task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local mob = getClosestMob()
                if mob then
                    if _G.BringMob then
                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == mob.Name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude < 500 then
                                    v.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(15, 15, 15)
                                end
                            end
                        end
                    end

                    Player.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmDistance, 0)
                    
                    if Player.Character:FindFirstChildOfClass("Tool") then
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(0,0))
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AutoBoss then
            pcall(function()
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if string.find(v.Name, "Boss") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
                            if Player.Character:FindFirstChildOfClass("Tool") then
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(0,0))
                            end
                        end
                        break
                    end
                end
            end)
        end
        
        if _G.AutoSeaBeast then
            pcall(function()
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if (string.find(v.Name, "Sea Beast") or string.find(v.Name, "Rumbling")) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                         if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
                            if Player.Character:FindFirstChildOfClass("Tool") then
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(0,0))
                            end
                        end
                        break
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.01) do
        if _G.FastAttack then
            pcall(function()
                local combatTool = Player.Character:FindFirstChildOfClass("Tool")
                if combatTool and combatTool:FindFirstChild("Cooldown") then combatTool.Cooldown.Value = 0 end
                local anims = Player.Character.Humanoid:GetPlayingAnimationTracks()
                for _, v in pairs(anims) do v:Stop() end
                if combatTool then combatTool:Activate() end
                
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        if (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude <= _G.KillAuraRange then
                            v.Humanoid.Health = 0
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AutoRaid then
            pcall(function()
                local args = {
                    [1] = "Raids",
                    [2] = "Start",
                    [3] = _G.SelectedRaid
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                            if Player.Character:FindFirstChildOfClass("Tool") then
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(0,0))
                            end
                        end
                    end
                end
            end)
        end
        
        if _G.AutoAwakening then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakening", "Key")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.4) do
        if _G.AutoChest then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if string.find(v.Name, "Chest") and v:IsA("Model") and v:FindFirstChild("Part") then
                        Player.Character.HumanoidRootPart.CFrame = v.Part.CFrame
                        task.wait(0.1)
                    elseif string.find(v.Name, "Chest") and v:IsA("Part") then
                        Player.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.1)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.4) do
        if _G.FruitSniper then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                        Player.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                        task.wait(0.2)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if _G.PlayerESP then
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if not p.Character.HumanoidRootPart:FindFirstChild("TeddyESP") then
                            local esp = Instance.new("BillboardGui", p.Character.HumanoidRootPart)
                            esp.Name = "TeddyESP"
                            esp.Size = UDim2.new(0, 50, 0, 15)
                            esp.AlwaysOnTop = true
                            esp.StudsOffset = Vector3.new(0, 3, 0)
                            local text = Instance.new("TextLabel", esp)
                            text.Size = UDim2.new(1,0,1,0)
                            text.Text = p.Name
                            text.TextColor3 = Color3.fromRGB(255, 0, 0)
                            text.BackgroundTransparency = 1
                            text.Font = Enum.Font.SourceSansBold
                            text.TextSize = 12
                        end
                    end
                end
            else
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("TeddyESP") then
                        p.Character.HumanoidRootPart.TeddyESP:Destroy()
                    end
                end
            end
            
            if _G.MobESP then
                for _, m in pairs(workspace.Enemies:GetChildren()) do
                    if m:FindFirstChild("HumanoidRootPart") and not m.HumanoidRootPart:FindFirstChild("TeddyMobESP") then
                        local esp = Instance.new("BillboardGui", m.HumanoidRootPart)
                        esp.Name = "TeddyMobESP"
                        esp.Size = UDim2.new(0, 50, 0, 15)
                        esp.AlwaysOnTop = true
                        esp.StudsOffset = Vector3.new(0, 3, 0)
                        local text = Instance.new("TextLabel", esp)
                        text.Size = UDim2.new(1,0,1,0)
                        text.Text = m.Name
                        text.TextColor3 = Color3.fromRGB(0, 255, 255)
                        text.BackgroundTransparency = 1
                        text.Font = Enum.Font.SourceSansBold
                        text.TextSize = 12
                    end
                end
            else
                for _, m in pairs(workspace.Enemies:GetChildren()) do
                    if m:FindFirstChild("HumanoidRootPart") and m.HumanoidRootPart:FindFirstChild("TeddyMobESP") then
                        m.HumanoidRootPart.TeddyMobESP:Destroy()
                    end
                end
            end
            
            if _G.FruitESP then
                for _, f in pairs(workspace:GetChildren()) do
                    if f:IsA("Tool") and string.find(f.Name, "Fruit") and f:FindFirstChild("Handle") and not f.Handle:FindFirstChild("TeddyFruitESP") then
                        local esp = Instance.new("BillboardGui", f.Handle)
                        esp.Name = "TeddyFruitESP"
                        esp.Size = UDim2.new(0, 50, 0, 15)
                        esp.AlwaysOnTop = true
                        esp.StudsOffset = Vector3.new(0, 3, 0)
                        local text = Instance.new("TextLabel", esp)
                        text.Size = UDim2.new(1,0,1,0)
                        text.Text = f.Name
                        text.TextColor3 = Color3.fromRGB(0, 255, 0)
                        text.BackgroundTransparency = 1
                        text.Font = Enum.Font.SourceSansBold
                        text.TextSize = 12
                    end
                end
            else
                for _, f in pairs(workspace:GetChildren()) do
                    if f:IsA("Tool") and string.find(f.Name, "Fruit") and f:FindFirstChild("Handle") and f.Handle:FindFirstChild("TeddyFruitESP") then
                        f.Handle.TeddyFruitESP:Destroy()
                    end
                end
            end
        end)
    end
end)

local function ServerHop()
    pcall(function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, v in pairs(servers.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, Player)
                break
            end
        end
    end)
end

MainTab:AddToggle({ Name = "Enable Auto Farm", Default = false, Callback = function(Value) _G.AutoFarm = Value end })
MainTab:AddToggle({ Name = "Bring Mobs", Default = false, Callback = function(Value) _G.BringMob = Value end })
MainTab:AddSlider({ Name = "Farm Distance", Min = 0, Max = 30, Default = 5, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Studs", Callback = function(Value) _G.FarmDistance = Value end })
MainTab:AddSlider({ Name = "Kill Aura Range", Min = 10, Max = 200, Default = 90, Color = Color3.fromRGB(255,255,255), Increment = 5, ValueName = "Studs", Callback = function(Value) _G.KillAuraRange = Value end })

EventTab:AddToggle({ Name = "Auto Boss Hunter", Default = false, Callback = function(Value) _G.AutoBoss = Value end })
EventTab:AddToggle({ Name = "Auto Sea Beast Hunter", Default = false, Callback = function(Value) _G.AutoSeaBeast = Value end })

RaidTab:AddDropdown({
    Name = "Select Raid Chip",
    Default = "Flame",
    Options = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Buddha", "Bird: Phoenix", "Portal", "Pain", "Spider", "Sound", "Blizzard"},
    Callback = function(Value) _G.SelectedRaid = Value end    
})
RaidTab:AddToggle({ Name = "Enable Auto Raid", Default = false, Callback = function(Value) _G.AutoRaid = Value end })
RaidTab:AddToggle({ Name = "Auto Awakening", Default = false, Callback = function(Value) _G.AutoAwakening = Value end })

ItemsTab:AddToggle({ Name = "Auto Collect Chests", Default = false, Callback = function(Value) _G.AutoChest = Value end })
ItemsTab:AddToggle({ Name = "Auto Fruit Sniper", Default = false, Callback = function(Value) _G.FruitSniper = Value end })

VisualTab:AddToggle({ Name = "Enable Player ESP", Default = false, Callback = function(Value) _G.PlayerESP = Value end })
VisualTab:AddToggle({ Name = "Enable Mob ESP", Default = false, Callback = function(Value) _G.MobESP = Value end })
VisualTab:AddToggle({ Name = "Enable Fruit ESP", Default = false, Callback = function(Value) _G.FruitESP 