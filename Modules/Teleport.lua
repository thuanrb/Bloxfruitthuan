-- Modules/Teleport.lua
local TeleportModule = {}

function TeleportModule:Init(Loader)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local TweenService = game:GetService("TweenService")

    function TeleportModule:TweenTo(targetCFrame, speed)
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                local dist = (root.Position - targetCFrame.Position).Magnitude
                
                speed = speed or 300
                if dist > 2000 then
                    root.CFrame = targetCFrame
                else
                    local tweenInfo = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear)
                    local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
                    tween:Play()
                    tween.Completed:Wait()
                end
            end
        end)
    end
end

return TeleportModule
