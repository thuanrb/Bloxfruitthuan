local Extras = {}

function Extras:Init(Loader)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")

    task.spawn(function()
        while task.wait(0.5) do
            if Loader.Config.AutoMelee then
                pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) end)
            end
            if Loader.Config.AutoDefense then
                pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1) end)
            end
            if Loader.Config.AutoSword then
                pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1) end)
            end
            if Loader.Config.AutoGun then
                pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1) end)
            end
            if Loader.Config.AutoDevilFruit then
                pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1) end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(1) do
            if Loader.Config.AutoGacha then
                pcall(function()
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
                end)
            end
            
            if Loader.Config.AutoStoreFruit then
                pcall(function()
                    local backpack = LocalPlayer:FindFirstChild("Backpack")
                    local char = LocalPlayer.Character
                    
                    local function Store(folder)
                        if not folder then return end
                        for _, tool in pairs(folder:GetChildren()) do
                            if tool:IsA("Tool") and (string.find(tool.Name, "Fruit") or string.find(tool.Name, "Trái")) then
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool:GetAttribute("OriginalName"), tool)
                            end
                        end
                    end
                    
                    Store(backpack)
                    Store(char)
                end)
            end
        end
    end)

    local function CreateESP(target, name, color)
        pcall(function()
            if not target:FindFirstChild("Bloos_ESP") then
                local hl = Instance.new("Highlight")
                hl.Name = "Bloos_ESP"
                hl.FillColor = color
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 0
                hl.Parent = target
                
                local bg = Instance.new("BillboardGui")
                bg.Name = "Bloos_ESP_Tag"
                bg.Size = UDim2.new(0, 100, 0, 20)
                bg.AlwaysOnTop = true
                bg.Parent = target
                
                local txt = Instance.new("TextLabel")
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.Text = name
                txt.TextColor3 = color
                txt.TextStrokeTransparency = 0
                txt.Font = Enum.Font.GothamBold
                txt.TextSize = 12
                txt.Parent = bg
            end
        end)
    end

    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if not Loader.Config.ESPPlayer and not Loader.Config.ESPChest and not Loader.Config.ESPFruit then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v.Name == "Bloos_ESP" or v.Name == "Bloos_ESP_Tag" then v:Destroy() end
                    end
                    return
                end

                if Loader.Config.ESPPlayer then
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            CreateESP(p.Character, p.Name, Color3.fromRGB(255, 0, 0))
                        else
                            if p.Character and p.Character:FindFirstChild("Bloos_ESP") then
                                p.Character.Bloos_ESP:Destroy()
                                p.Character.Bloos_ESP_Tag:Destroy()
                            end
                        end
                    end
                end

                if Loader.Config.ESPChest then
                    for _, v in pairs(Workspace:GetChildren()) do
                        if string.find(v.Name, "Chest") then
                            CreateESP(v, "Chest", Color3.fromRGB(255, 255, 0))
                        end
                    end
                end

                if Loader.Config.ESPFruit then
                    for _, v in pairs(Workspace:GetChildren()) do
                        if string.find(v.Name, "Fruit") then
                            CreateESP(v, v.Name, Color3.fromRGB(0, 255, 0))
                        end
                    end
                end
            end)
        end
    end)
end

return Extras
