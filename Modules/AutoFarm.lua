local AutoFarmModule = {}

function AutoFarmModule:Init(Hub)
    local Players = Hub.Services.Players
    local RunService = Hub.Services.RunService
    local LocalPlayer = Players.LocalPlayer

    local farmConnection

    local function optimizePhysicalState()
        local char = LocalPlayer.Character
        if not char then return end
        
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.Velocity = Vector3.new(0, 0, 0)
            root.RotVelocity = Vector3.new(0, 0, 0)
        end
    end

    local function startCoreLoop()
        if farmConnection then return end
        farmConnection = RunService.Heartbeat:Connect(function()
            if not Hub.Config.AutoFarm then
                farmConnection:Disconnect()
                farmConnection = nil
                return
            end
            pcall(optimizePhysicalState)
        end)
    end

    task.spawn(function()
        while task.wait(0.1) do
            if Hub.Config.AutoFarm and not farmConnection then
                startCoreLoop()
            end
        end
    end)
end

return AutoFarmModule
