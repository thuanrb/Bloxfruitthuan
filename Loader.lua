local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Loader = {}

local DefaultConfig = {
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
    AutoDojoBelt = false,
    AutoMelee = false,
    AutoDefense = false,
    AutoSword = false,
    AutoGun = false,
    AutoDevilFruit = false,
    ESPPlayer = false,
    ESPChest = false,
    ESPFruit = false,
    AutoGacha = false,
    AutoStoreFruit = false,
    AutoMarine = true
}

Loader.Config = DefaultConfig
local FileName = "TeddyHub_Config_V6.json"

function Loader:SaveSettings()
    if writefile then
        pcall(function()
            writefile(FileName, HttpService:JSONEncode(self.Config))
        end)
    end
end

function Loader:LoadSettings()
    if readfile and isfile and isfile(FileName) then
        pcall(function()
            local decoded = HttpService:JSONDecode(readfile(FileName))
            for k, v in pairs(decoded) do
                self.Config[k] = v
            end
        end)
    end
end

function Loader:Start()
    self:LoadSettings()

    -- Tự động chọn phe Hải quân ngay khi vào game nếu được bật
    task.spawn(function()
        if self.Config.AutoMarine then
            pcall(function()
                local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
                if remotes and remotes:FindFirstChild("CommF_") then
                    remotes.CommF_:InvokeServer("SetTeam", "Marines")
                end
            end)
        end
    end)

    -- Tải tuần tự các module chức năng
    task.spawn(function()
        pcall(function()
            local baseUrl = "https://raw.githubusercontent.com/thuanrb/Bloxfruitthuan/main/Modules/"
            
            local UI = loadstring(game:HttpGet(baseUrl .. "UI.lua"))()
            if UI then UI:Init(self) end

            local Performance = loadstring(game:HttpGet(baseUrl .. "Performance.lua"))()
            if Performance then Performance:Init(self) end

            local Combat = loadstring(game:HttpGet(baseUrl .. "Combat.lua"))()
            if Combat then Combat:Init(self) end

            local Event = loadstring(game:HttpGet(baseUrl .. "Event.lua"))()
            if Event then Event:Init(self) end

            local Extras = loadstring(game:HttpGet(baseUrl .. "Extras.lua"))()
            if Extras then Extras:Init(self) end
        end)
    end)
end

Loader:Start()
return Loader
