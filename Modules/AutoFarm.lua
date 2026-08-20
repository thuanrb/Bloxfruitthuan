local AutoFarmModule = {}

function AutoFarmModule:Init(Hub)
    local Players = Hub.Services.Players
    local RunService = Hub.Services.RunService
    local TweenService = Hub.Services.TweenService
    local Workspace = Hub.Services.Workspace
    local LocalPlayer = Players.LocalPlayer

    local activeTween = nil
    local cachedEnemiesFolder = Workspace:FindFirstChild("Enemies")

    Workspace.ChildAdded:Connect(function(child)
        if child.Name == "Enemies" then
            cachedEnemiesFolder = child
        end
    end)

    local function noclipCharacter()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end

    local function getNearestEnemyOptimized()
        if not cachedEnemiesFolder then return nil end
        
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
        local rootPos = char.HumanoidRootPart.Position

        local minDist = math.huge
        local bestTarget = nil

        for _, v in ipairs(cachedEnemiesFolder:GetChildren()) do
            local hrp = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - rootPos).Magnitude
                if dist < minDist then
                    minDist = dist
                    bestTarget = v
                end
            end
        end
        return bestTarget
    end

    RunService.Heartbeat:Connect(function()
        if not Hub.Config.AutoFarm then
            if activeTween then
                activeTween:Cancel()
                activeTween = nil
            end
            return
        end

        pcall(function()
            noclipCharacter()

            local target = getNearestEnemyOptimized()
            if target and target:FindFirstChild("HumanoidRootPart") then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    local targetCFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    
                    local distance = (root.Position - targetCFrame.Position).Magnitude
                    local speed = 400 -- Tăng tốc độ bay tối đa mượt mà
                    local travelTime = distance / speed
                    
                    if not activeTween or activeTween.PlaybackState ~= Enum.PlaybackState.Playing then
                        if activeTween then activeTween:Cancel() end
                        local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
                        activeTween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
                        activeTween:Play()
                    end
                end
            else
                if activeTween then
                    activeTween:Cancel()
                    activeTween = nil
                end
            end
        end)
    end)
end

return AutoFarmModule
