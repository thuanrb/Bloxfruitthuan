local BaseURL = "https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/"

local BloosHub = {
    Config = {
        AutoFarm = false,
        FastAttack = true,
        AttackSpeed = 0.05,
        ESPEnabled = false
    },
    Services = {
        Players = game:GetService("Players"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        Workspace = game:GetService("Workspace"),
        TweenService = game:GetService("TweenService"),
        RunService = game:GetService("RunService")
    }
}

local function LoadModule(name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(BaseURL .. name .. ".lua"))()
    end)
    if not success then
        warn("[BloosHub Error]: Failed to load " .. name .. " -> " .. tostring(result))
        return nil
    end
    return result
end

BloosHub.UI = LoadModule("UI")
BloosHub.Combat = LoadModule("Combat")
BloosHub.AutoFarm = LoadModule("AutoFarm")

if BloosHub.UI then
    BloosHub.UI:Init(BloosHub)
end

if BloosHub.Combat then
    BloosHub.Combat:Init(BloosHub)
end

if BloosHub.AutoFarm then
    BloosHub.AutoFarm:Init(BloosHub)
end
