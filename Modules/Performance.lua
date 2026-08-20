local PerformanceModule = {}

function PerformanceModule:Init(Hub)
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")

    local function boostFPS()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.ShadowSoftness = 0
        
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 0
        end

        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.Visible = false
            end
        end
    end

    Hub.Config.BoostFPS = false
    
    Hub.TogglePerformance = function(state)
        Hub.Config.BoostFPS = state
        if state then
            pcall(boostFPS)
        end
    end
end

return PerformanceModule
