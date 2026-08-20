local Loader = {}
Loader.Config = {
    AutoFarm = false,
    FastAttack = false,
    ESPEnabled = false,
    Key = ""
}

Loader.Services = {
    Players = game:GetService("Players"),
    Workspace = game:GetService("Workspace"),
    RunService = game:GetService("RunService"),
    VirtualUser = game:GetService("VirtualUser")
}

local CorrectKey = "BLOO-FREE-2026"

function Loader:VerifyKey(inputKey)
    return inputKey == CorrectKey
end

function Loader:AntiCheatBypass()
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
end

function Loader:Start()
    pcall(function() self:AntiCheatBypass() end)

    local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/UI.lua"))()
    local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/AutoFarm.lua"))()
    local Combat = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Combat.lua"))()
    local Performance = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Performance.lua"))()

    if UI then UI:Init(self) end
    if Performance then Performance:Init(self) end
    if AutoFarm then AutoFarm:Init(self) end
    if Combat then Combat:Init(self) end
end

Loader:Start()
return Loader
