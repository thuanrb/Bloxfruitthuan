-- =========================================================================
-- TEDDY HUB V6 - ULTIMATE ENTERPRISE CORE (NO VIETNAMESE INSTRUCTIONS)
-- =========================================================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = Library:MakeWindow({
    Name = "Teddy Hub | Ultimate Enterprise V6", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "TeddyHub_Config"
})

local MainTab = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local EventTab = Window:MakeTab({ Name = "Events & Boss", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local ItemsTab = Window:MakeTab({ Name = "Items & Fruits", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local VisualTab = Window:MakeTab({ Name = "Visual & ESP", Icon = "rbxassetid://4483345998", PremiumOnly = false })
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

local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
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
        if (_G.AutoFarm or _G.AutoBoss or _G.AutoSeaBeast) and _G.AutoHaki then
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
                                if (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude < 400 then
                                    v.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
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
            end)
        end
    end
end)

-- AUTO CHEST
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoChest then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if string.find(v.Name, "Chest") and v:IsA("Model") and v:FindFirstChild("Part") then
                        Player.Character.HumanoidRootPart.CFrame = v.Part.CFrame
                        task.wait(0.2)
                    elseif string.find(v.Name, "Chest") and v:IsA("Part") then
                        Player.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.2)
                    end
                end
            end)
        end
    end
end)

-- FRUIT SNIPER
task.spawn(function()
    while task.wait(1) do
        if _G.FruitSniper then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                        Player.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
end)

-- PLAYER ESP
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
        end)
    end
end)

-- SERVER HOP FUNCTION
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

EventTab:AddToggle({ Name = "Auto Boss Hunter", Default = false, Callback = function(Value) _G.AutoBoss = Value end })

ItemsTab:AddToggle({ Name = "Auto Collect Chests", Default = false, Callback = function(Value) _G.AutoChest = Value end })
ItemsTab:AddToggle({ Name = "Auto Fruit Sniper", Default = false, Callback = function(Value) _G.FruitSniper = Value end })

VisualTab:AddToggle({ Name = "Enable Player ESP", Default = false, Callback = function(Value) _G.PlayerESP = Value end })

MiscTab:AddToggle({ Name = "Auto Buso Haki", Default = true, Callback = function(Value) _G.AutoHaki = Value end })
MiscTab:AddToggle({ Name = "Super Fast Attack", Default = true, Callback = function(Value) _G.FastAttack = Value end })
MiscTab:AddButton({ Name = "Server Hop", Callback = function() ServerHop() end })

Library:Init()
