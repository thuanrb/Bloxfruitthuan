local Loader = {}
Loader.Config = {
    AutoFarm = false,
    AutoFarmMethod = "Level",
    SelectedTool = "Melee",
    AttackMob = true,
    BringMobs = true,
    AutoBuso = true,
    FastAttack = true,
    BoostFPS = false,
    HopTTK = false,
    DistanceY = 35,
    AutoSeaEvent = false,
    AutoTerrorshark = false,
    AutoLeviathan = false,
    AutoKitsune = false,
    AutoDojoBelt = false
}

function Loader:Start()
    task.spawn(function()
        pcall(function()
            local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/UI.lua"))()
            if UI then UI:Init(self) end

            local Performance = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Performance.lua"))()
            if Performance then Performance:Init(self) end

            local Combat = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Combat.lua"))()
            if Combat then Combat:Init(self) end

            local Event = loadstring(game:HttpGet("https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/Event.lua"))()
            if Event then Event:Init(self) end
        end)
    end)
end

Loader:Start()
return Loader
