local AutoFarmModule = {}

function AutoFarmModule:Init(Hub)
    local Players = Hub.Services.Players
    local RunService = Hub.Services.RunService
    local LocalPlayer = Players.LocalPlayer

    local noclipConnection

    local function enableNoclip()
        if noclipConnection then return end
        noclipConnection = RunService.Stepped:Connect(function()
            if not Hub.Config.AutoFarm then
                noclipConnection:Disconnect()
                noclipConnection = nil
                return
            end

            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end

    task.spawn(function()
        while task.wait(0.2) do
            if Hub.Config.AutoFarm then
                enableNoclip()
            end
        end
    end)
end

return AutoFarmModule
