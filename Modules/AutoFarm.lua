local AutoFarmModule = {}

function AutoFarmModule:Init(Hub)
    local Players = Hub.Services.Players
    local Workspace = Hub.Services.Workspace
    local TweenService = Hub.Services.TweenService
    local LocalPlayer = Players.LocalPlayer

    local function FlyTo(targetPosition)
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = character.HumanoidRootPart
        local distance = (targetPosition - rootPart.Position).Magnitude
        local speed = 300
        
        local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(rootPart, info, {CFrame = CFrame.new(targetPosition)})
        
        tween:Play()
        return tween
    end

    task.spawn(function()
        while task.wait(0.5) do
            if Hub.Config.AutoFarm then
                pcall(function()
                    print("AutoFarm running...")
                end)
            end
        end
    end)
end

return AutoFarmModule
