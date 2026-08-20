local Loader = {}
Loader.Config = { AutoFarm = false, AutoFarmNearest = false, AutoStats = false, FastAttack = false, BringMobs = false, ESPEnabled = false, ChestESP = false, BoostFPS = false, HopTTK = false, SelectedWeapon = "Melee", SelectedStat = "Melee" }

function Loader:Start()
    pcall(function()
        local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/UI.lua"))()
        if UI then UI:Init(self) end
    end)
end

Loader:Start()
return Loader
