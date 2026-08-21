local Combat = {}

function Combat:Init(Loader)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local VirtualUser = game:GetService("VirtualUser")
    local RunService = game:GetService("RunService")

    local function EquipWeapon()
        pcall(function()
            local weaponName = Loader.Config.SelectedTool or "Melee"
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            local character = LocalPlayer.Character
            if backpack and character and character:FindFirstChild("Humanoid") then
                if not character:FindFirstChildOfClass("Tool") then
                    local tool = backpack:FindFirstChild(weaponName) or backpack:FindFirstChildOfClass("Tool")
                    if tool then
                        character.Humanoid:EquipTool(tool)
                    end
                end
            end
        end)
    end

    task.spawn(function()
        while task.wait(0.2) do
            if Loader.Config.AutoFarm then
                pcall(function()
                    local character = LocalPlayer.Character
                    if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then return end
                    local rootPart = character.HumanoidRootPart
                    local humanoid = character.Humanoid

                    if humanoid.Health < (humanoid.MaxHealth * 0.25) then
                        rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 150, 0)
                        task.wait(2)
                        return
                    end

                    if Loader.Config.AutoBuso and not character:FindFirstChild("HasBuso") then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                    end

                    EquipWeapon()

                    local enemiesFolder = Workspace:FindFirstChild("Enemies")
                    if enemiesFolder then
                        local targetEnemy = nil
                        local shortestDist = math.huge

                        for _, enemy in pairs(enemiesFolder:GetChildren()) do
                            local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                            local eHum = enemy:FindFirstChild("Humanoid")
                            if eRoot and eHum and eHum.Health > 0 then
                                local dist = (eRoot.Position - rootPart.Position).Magnitude
                                if dist < shortestDist then
                                    shortestDist = dist
                                    targetEnemy = enemy
                                end
                            end
                        end

                        if targetEnemy then
                            local eRoot = targetEnemy.HumanoidRootPart

                            if Loader.Config.BringMobs then
                                for _, otherEnemy in pairs(enemiesFolder:GetChildren()) do
                                    local oRoot = otherEnemy:FindFirstChild("HumanoidRootPart")
                                    local oHum = otherEnemy:FindFirstChild("Humanoid")
                                    if oRoot and oHum and oHum.Health > 0 and otherEnemy.Name == targetEnemy.Name then
                                        if (oRoot.Position - eRoot.Position).Magnitude < 350 then
                                            oRoot.CFrame = eRoot.CFrame
                                            oRoot.CanCollide = false
                                        end
                                    end
                                end
                            end

                            rootPart.CFrame = eRoot.CFrame * CFrame.new(0, Loader.Config.DistanceY or 30, 0)
                            rootPart.Velocity = Vector3.new(0, 0, 0)

                            if Loader.Config.AttackMob then
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(1280, 672))
                            end
                        end
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        RunService.RenderStepped:Connect(function()
            if Loader.Config.AutoFarm and Loader.Config.FastAttack then
                pcall(function()
                    local combatTool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if combatTool then
                        combatTool:Activate()
                    end
                end)
            end
        end)
    end)
end

return Combat
