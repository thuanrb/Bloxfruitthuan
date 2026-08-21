-- Modules/Event.lua
local Event = {}

function Event:Init(Loader)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    task.spawn(function()
        while task.wait(0.5) do
            if Loader.Config.AutoSeaEvent then
                pcall(function()
                    local character = LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local rootPart = character.HumanoidRootPart
                        local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
                        
                        if seaBeasts and #seaBeasts:GetChildren() > 0 then
                            for _, sb in pairs(seaBeasts:GetChildren()) do
                                if sb:FindFirstChild("HumanoidRootPart") and sb:FindFirstChild("Humanoid") and sb.Humanoid.Health > 0 then
                                    rootPart.CFrame = sb.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
                                    if Loader.Config.AttackMob then
                                        local tool = character:FindFirstChildOfClass("Tool")
                                        if tool then tool:Activate() end
                                    end
                                    break
                                end
                            end
                        else
                            rootPart.CFrame = CFrame.new(rootPart.Position.X, 100, rootPart.Position.Z)
                        end
                    end
                end)
            end

            if Loader.Config.AutoDojoBelt then
                pcall(function()
                    local args = {
                        [1] = "DojoQuest"
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end)
            end
        end
    end)
end

return Event
