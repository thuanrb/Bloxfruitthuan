local CombatModule = {}

function CombatModule:Init(Hub)
    local Players = Hub.Services.Players
    local Workspace = Hub.Services.Workspace
    local RunService = Hub.Services.RunService
    local VirtualUser = Hub.Services.VirtualUser
    local LocalPlayer = Players.LocalPlayer

    local bringConnection

    local function getTargetCFrame()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            return char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        end
        return nil
    end

    local function bringEnemiesAround()
        local targetCFrame = getTargetCFrame()
        if not targetCFrame then return end

        local enemies = Workspace:FindFirstChild("Enemies")
        if not enemies then return end

        for _, enemy in ipairs(enemies:GetChildren()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChildOfClass("Humanoid") then
                local hum = enemy:FindFirstChildOfClass("Humanoid")
                if hum.Health > 0 then
                    local root = enemy.HumanoidRootPart
                    if (root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 350 then
                        root.CFrame = targetCFrame
                        root.CanCollide = false
                        root.Size = Vector3.new(60, 60, 60)
                        root.Transparency = 1
                    end
                end
            end
        end
    end

    task.spawn(function()
        while task.wait() do
            if Hub.Config.FastAttack then
                pcall(function()
                    local character = LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool and tool:FindFirstChild("Damage") then
                            tool:Activate()
                            VirtualUser:Button1Down(Vector2.new(1, 1))
                            task.wait(0.01)
                            VirtualUser:Button1Up(Vector2.new(1, 1))
                        end
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.1) do
            if Hub.Config.BringMobs then
                pcall(bringEnemiesAround)
            end
        end
    end)
end

return CombatModule
