local AutoFarmModule = {}

function AutoFarmModule:Init(Hub)
    local Players = Hub.Services.Players
    local RunService = Hub.Services.RunService
    local TweenService = game:GetService("TweenService")
    local Workspace = Hub.Services.Workspace
    local LocalPlayer = Players.LocalPlayer

    local farmConnection
    local activeTween

    local function enableNoclip()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end

    local function getNearestEnemy()
        local dist = math.huge
        local target = nil
        local enemies = Workspace:FindFirstChild("Enemies")
        
        if enemies then
            for _, v in ipairs(enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local mag = (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                        if mag < dist then
                            dist = mag
                            target = v
                        end
                    end
                end
            end
        end
        return target
    end

    local function tweenTo(targetCFrame)
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local root = char.HumanoidRootPart
        local distance = (root.Position - targetCFrame.Position).Magnitude
        local speed = 300 
        local time = distance / speed
        
        local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
        activeTween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame * CFrame.new(0, 5, 0)})
        activeTween:Play()
        return activeTween
    end

    task.spawn(function()
        while task.wait() do
            if Hub.Config.AutoFarm then
                pcall(function()
                    enableNoclip()
                    local enemy = getNearestEnemy()
                    if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                        local tw = tweenTo(enemy.HumanoidRootPart.CFrame)
                        if tw then tw.Completed:Wait() end
                    else
                        if activeTween then
                            activeTween:Cancel()
                        end
                    end
                end)
            end
        end
    end)
end

return AutoFarmModule
