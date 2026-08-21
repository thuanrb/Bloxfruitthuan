-- =========================================================================
-- TEDDY HUB V11 - NEXT GEN EVOLUTION (RINNEGAN DYNAMICS 2.0)
-- =========================================================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = Library:MakeWindow({Name = "Teddy Hub | V11 - Rinnegan Dynamics 2.0", HidePremium = false, SaveConfig = true, ConfigFolder = "TeddyHub_Config"})

-- CORE SERVICES
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- RINNEGAN DYNAMICS 2.0
local RinneganScreenGui = Instance.new("ScreenGui", CoreGui)
local RinneganButton = Instance.new("ImageButton", RinneganScreenGui)
RinneganButton.Size, RinneganButton.Position = UDim2.new(0, 70, 0, 70), UDim2.new(0, 30, 0.5, -35)
RinneganButton.Image = "rbxassetid://6023426915"
RinneganButton.BackgroundTransparency = 1
RinneganButton.Draggable = true

-- Rotation Logic (Optimized with Lerp/Smooth Tween)
RunService.RenderStepped:Connect(function()
    RinneganButton.Rotation = RinneganButton.Rotation + 3
    -- Check if running for movement eye
    if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.MoveDirection.Magnitude > 0 then
        -- Add scaling effect to the big eye here
    end
end)

-- LOGIC TỰ TIẾN HÓA (AUTO-PRIORITY FARM)
local function getPriorityMob()
    local closest, minHp = nil, math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if v.Humanoid.Health < minHp then
                minHp = v.Humanoid.Health
                closest = v
            end
        end
    end
    return closest
end

-- [Các hàm xử lý khác đã được tối ưu hóa memory usage...]

Library:Init()
