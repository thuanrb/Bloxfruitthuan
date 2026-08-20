local CombatModule = {}

function CombatModule:Init(Hub)
    local RS = Hub.Services.ReplicatedStorage
    local RunService = Hub.Services.RunService
    local lastAttackTick = 0

    RunService.Heartbeat:Connect(function()
        if Hub.Config.FastAttack and Hub.Config.AutoFarm then
            local currentTime = tick()
            if currentTime - lastAttackTick >= Hub.Config.AttackSpeed then
                lastAttackTick = currentTime
                pcall(function()
                    local netModule = RS:FindFirstChild("Modules") and RS.Modules:FindFirstChild("Net")
                    if netModule and netModule:FindFirstChild("RegisterAttack") then
                        netModule.RegisterAttack:FireServer(0.7)
                    end
                end)
            end
        end
    end)
end

return CombatModule
