-- =========================================================================
-- TEDDY HUB V2 - PREMIUM ENTERPRISE CORE (NO DELAY & BYPASS)
-- =========================================================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = Library:MakeWindow({
    Name = "Teddy Hub | Premium Enterprise", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "TeddyHub_Config"
})

local MainTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local CombatTab = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

_G.AutoFarm = false
_G.FastAttack = false
_G.FarmDistance = 5

-- [1] METATABLE ANTI-CHEAT HOOK (SERVER BYPASS)
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "Kick" or method == "kick" then
        return nil 
    end
    
    if method == "FireServer" and tostring(self) == "MainEvent" then
        if args[1] == "Banned" or args[1] == "WalkSpeed" or args[1] == "JumpPower" then
            return nil
        end
    end
    
    return oldNamecall(self, unpack(args))
end)
setreadonly(mt, true)

-- [2] TARGETING ALGORITHM
local function getClosestMob()
    local closest = nil
    local dist = math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            local magnitude = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
            if magnitude < dist then
                dist = magnitude
                closest = v
            end
        end
    end
    return closest
end

-- [3] AUTO FARM LOOP (OPTIMIZED)
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local mob = getClosestMob()
                if mob then
                    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, _G.FarmDistance)
                    
                    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                    end
                end
            end)
        end
    end
end)

-- [4] SUPER FAST ATTACK (NO DELAY / NO ANIMATION)
task.spawn(function()
    while task.wait(0.01) do
        if _G.FastAttack then
            pcall(function()
                local combatTool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if combatTool and combatTool:FindFirstChild("Cooldown") then
                    combatTool.Cooldown.Value = 0 
                end
                
                local anims = game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()
                for _, v in pairs(anims) do
                    v:Stop()
                end
                
                if combatTool then
                    combatTool:Activate()
                end
            end)
        end
    end
end)

-- [5] UI TOGGLES
MainTab:AddToggle({
    Name = "Enable Auto Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
    end    
})

MainTab:AddSlider({
    Name = "Farm Distance",
    Min = 0,
    Max = 20,
    Default = 5,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Studs",
    Callback = function(Value)
        _G.FarmDistance = Value
    end    
})

CombatTab:AddToggle({
    Name = "Enable Super Fast Attack",
    Default = false,
    Callback = function(Value)
        _G.FastAttack = Value
    end    
})

Library:Init()
