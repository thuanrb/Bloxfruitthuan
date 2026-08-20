local Loader = {}
Loader.Config = {
    AutoFarm = false,
    AutoFarmNearest = false,
    AutoStats = false,
    FastAttack = false,
    BringMobs = false,
    ESPEnabled = false,
    ChestESP = false,
    BoostFPS = false,
    HopTTK = false,
    SelectedWeapon = "Melee",
    SelectedStat = "Melee"
}

Loader.Services = {
    Players = game:GetService("Players"),
    Workspace = game:GetService("Workspace"),
    RunService = game:GetService("RunService"),
    VirtualUser = game:GetService("VirtualUser"),
    TweenService = game:GetService("TweenService"),
    HttpService = game:GetService("HttpService"),
    TeleportService = game:GetService("TeleportService")
}

function Loader:AntiCheatBypass()
    pcall(function()
        local gm = getrawmetatable(game)
        if not gm then return end
        
        setreadonly(gm, false)
        local namecall = gm.__namecall
        
        gm.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "kick" then
                return nil
            end
            return namecall(self, ...)
        end)
        setreadonly(gm, true)
    end)
end

function Loader:Start()
    self:AntiCheatBypass()

    local success, err = pcall(function()
        local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/UI.lua"))()
        local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/AutoFarm.lua"))()
        local Combat = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Combat.lua"))()
        local Performance = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Performance.lua"))()
        local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/ESP.lua"))()
        local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/ServerHop.lua"))()

        if UI then UI:Init(self) end
        if Performance then Performance:Init(self) end
        if AutoFarm then AutoFarm:Init(self) end
        if Combat then Combat:Init(self) end
        if ESP then ESP:Init(self) end
        if ServerHop then ServerHop:Init(self) end
    end)
    
    if not success then
        warn("Bloos Hub Loader Error: " .. tostring(err))
    end
end

Loader:Start()
return Loader
