local ESPModule = {}

function ESPModule:Init(Hub)
    local RunService = Hub.Services.RunService
    local Players = Hub.Services.Players
    local LocalPlayer = Players.LocalPlayer

    local espCache = {}

    local function createESP(target, color)
        if not espCache[target] then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = target
            highlight.FillColor = color
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            
            local coreGui = game:GetService("CoreGui")
            highlight.Parent = coreGui
            espCache[target] = highlight
        end
    end

    local function clearESP()
        for target, highlight in pairs(espCache) do
            if highlight then highlight:Destroy() end
        end
        table.clear(espCache)
    end

    RunService.RenderStepped:Connect(function()
        if Hub.Config.ESPEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    createESP(player.Character, Color3.new(1, 0, 0))
                end
            end
        else
            if next(espCache) ~= nil then
                clearESP()
            end
        end
    end)
end

return ESPModule
