local Performance = {}

function Performance:Init(Loader)
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    task.spawn(function()
        while task.wait(0.5) do
            if Loader.Config.BoostFPS then
                pcall(function()
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 9e9
                    settings():GetService("RenderSettings").RenderingEnabled = true
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("Part") or v:IsA("MeshPart") then
                            v.Material = Enum.Material.SmoothPlastic
                            v.Reflectance = 0
                        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                            v.Enabled = false
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
