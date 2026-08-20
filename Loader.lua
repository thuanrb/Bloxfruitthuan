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
    TweenService = game:GetService("TweenService"),
    RunService = game:GetService("RunService"),
    VirtualUser = game:GetService("VirtualUser")
}

local CorrectKey = "BLOO-FREE-2026"

function Loader:VerifyKey(inputKey)
    if inputKey == CorrectKey then
        return true
    end
    return false
end

function Loader:Start()
    local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/UI.lua"))()
    local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/AutoFarm.lua"))()
    local Combat = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Combat.lua"))()

    UI:Init(self)
    AutoFarm:Init(self)
    Combat:Init(self)
end

Loader:Start()
return Loader
