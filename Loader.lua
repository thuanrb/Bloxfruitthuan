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

function Loader:Start()
    pcall(function()
        -- Load UI
        local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/UI.lua"))()
        if UI then UI:Init(self) end

        -- Load Performance (Tối ưu hiệu năng & Chống AFK)
        local Performance = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Performance.lua"))()
        if Performance then Performance:Init(self) end
    end)
end

Loader:Start()
return Loader
