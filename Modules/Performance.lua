local Performance = {}

function Performance:Init(Loader)
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")

    task.spawn(function()
        while task.wait(1) do
            if Loader.Config.BoostFPS then
                pcall(function()
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 9e9
                    Lighting.Brightness = 1
                    settings():GetService("RenderSettings").RenderingEnabled = true
                    
                    if Terrain then
                        Terrain.WaterWaveSize = 0
                        Terrain.WaterWaveSpeed = 0
                        Terrain.WaterReflectance = 0
                        Terrain.WaterTransparency = 0
                    end

                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                            v.Material = Enum.Material.SmoothPlastic
                            v.Reflectance = 0
                        elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                            v.Enabled = false
                            if v:IsA("Decal") or v:IsA("Texture") then
                                v.Transparency = 1
                            end
                        end
                    end
                end)
            end
        end
    end)

    pcall(function()
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)
end

return Performance
