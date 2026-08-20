local PerformanceModule = {}

function PerformanceModule:Init(Hub)
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")

    local memoryConnection = nil

    local function applyDeepOptimization()
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.ShadowSoftness = 0
            Lighting.Technology = Enum.Technology.Compatibility
            
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 0
            end

            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                    if not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
                        v.CastShadow = false
                    end
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
                    v.Enabled = false
                end
            end
        end)
    end

    Hub.TogglePerformance = function(state)
        Hub.Config.BoostFPS = state
        if state then
            applyDeepOptimization()
            -- Tự động dọn rác bộ nhớ RAM mỗi 4 giây tránh tràn bộ nhớ khi cắm máy xuyên đêm
            memoryConnection = task.spawn(function()
                while Hub.Config.BoostFPS do
                    task.wait(4)
                    collectgarbage("collect")
                end
            end)
        else
            if memoryConnection then
                task.cancel(memoryConnection)
                memoryConnection = nil
            end
        end
    end
end

return PerformanceModule
