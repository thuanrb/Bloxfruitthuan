local Combat = {}

function Combat:Init(Loader)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")

    -- Luồng xử lý Auto Farm & Gom Quái (Bring Mobs) chạy ngầm đa luồng siêu mượt
    task.spawn(function()
        while task.wait(0.2) do
            if Loader.Config.AutoFarm then
                pcall(function()
                    local character = LocalPlayer.Character
                    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                    local rootPart = character.HumanoidRootPart

                    -- Kích hoạt Haki vũ trang tự động
                    if Loader.Config.AutoBuso and not character:FindFirstChild("HasBuso") then
                        local bb = LocalPlayer.Data:FindFirstChild("Buso")
                        if not bb or bb.Value == 0 then
                            local args = { [1] = "Buso" }
                            pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end)
                        end
                    end

                    -- Tìm quái vật gần nhất để farm
                    local enemies = Workspace:FindFirstChild("Enemies")
                    if enemies then
                        for _, enemy in pairs(enemies:GetChildren()) do
                            local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                            local eHumanoid = enemy:FindFirstChild("Humanoid")
                            if eRoot and eHumanoid and eHumanoid.Health > 0 then
                                -- Gom quái (Bring Mobs) kéo lại gần người chơi
                                if Loader.Config.BringMobs then
                                    eRoot.CFrame = rootPart.CFrame * CFrame.new(0, 0, -3)
                                    eRoot.CanCollide = false
                                    pcall(function() enemy.Head.CanCollide = false end)
                                end

                                -- Di chuyển người chơi đến đánh quái
                                if (eRoot.Position - rootPart.Position).Magnitude < 250 then
                                    rootPart.CFrame = eRoot.CFrame * CFrame.new(0, Loader.Config.DistanceY or 35, 3)
                                    
                                    -- Tự động đánh quái
                                    if Loader.Config.AttackMob then
                                        local tool = character:FindFirstChildOfClass("Tool")
                                        if tool then
                                            tool:Activate()
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
end

return Combat
