local CombatModule = {}

function CombatModule:Init(Hub)
    local Players = Hub.Services.Players
    local LocalPlayer = Players.LocalPlayer
    local VirtualUser = Hub.Services.VirtualUser

    task.spawn(function()
        while task.wait() do
            if Hub.Config.FastAttack then
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local Combat = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if Combat and Combat:FindFirstChild("Damage") then
                            Combat:Activate()
                            VirtualUser:Button1Down(Vector2.new(1, 1))
                            task.wait(0.01)
                            VirtualUser:Button1Up(Vector2.new(1, 1))
                        end
                    end
                end)
            end
        end
    end)
end

return CombatModule
