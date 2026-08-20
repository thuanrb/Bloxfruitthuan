local CombatModule = {}

function CombatModule:Init(Hub)
    local Players = Hub.Services.Players
    local LocalPlayer = Players.LocalPlayer
    local VirtualUser = Hub.Services.VirtualUser

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
        while task.wait(0.5) do
            if Hub.Config.BringMobs then
                pcall(function()
                    -- Logic Bring Mobs (Gom quái lại gần người chơi)
                end)
            end
        end
    end)
end

return CombatModule
