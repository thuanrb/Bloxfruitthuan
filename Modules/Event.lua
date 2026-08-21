local Event = {}

function Event:Init(Loader)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local VirtualUser = game:GetService("VirtualUser")

    task.spawn(function()
        while task.wait(0.5) do
            if Loader.Config.AutoSeaEvent or Loader.Config.AutoTerrorshark then
                pcall(function()
                    local character = LocalPlayer.Character
                    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                    local rootPart = character.HumanoidRootPart

                    local targetFound = false
                    for _, v in pairs(Workspace:GetChildren()) do
                        if v:IsA("Model") and (string.find(v.Name, "SeaBeast") or string.find(v.Name, "Terrorshark") or string.find(v.Name, "Piranha") or string.find(v.Name, "Ship")) then
                            local enemyRoot = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("PrimaryPart")
                            local enemyHum = v:FindFirstChild("Humanoid")
                            
                            if enemyRoot and enemyHum and enemyHum.Health > 0 then
                                targetFound = true
                                rootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, 45, 0)
                                rootPart.Velocity = Vector3.new(0, 0, 0)

                                if Loader.Config.AttackMob then
                                    VirtualUser:CaptureController()
                                    VirtualUser:Button1Down(Vector2.new(1280, 672))
                                end
                                break
                            end
                        end
                    end

                    if not targetFound and not Loader.Config.AutoFarm then
                        if rootPart.Position.Y < 50 then
                            rootPart.CFrame = CFrame.new(rootPart.Position.X, 100, rootPart.Position.Z)
                            rootPart.Velocity = Vector3.new(0, 0, 0)
                        end
                    end
                end)
            end

            if Loader.Config.AutoDojoBelt then
                pcall(function()
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("DojoQuest")
                end)
            end
        end
    end)
end

return Event
