local AutoQuest = {}

function AutoQuest:Init(Loader)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")

    local function GetQuestLevel()
        pcall(function()
            local level = LocalPlayer.Data.Level.Value
            local questData = {
                {Level = 1, Name = "BanditQuest1", Mob = "Bandit", Npc = CFrame.new(1060, 16, 1547), QuestIndex = 1},
                {Level = 10, Name = "JungleQuest", Mob = "Monkey", Npc = CFrame.new(-1598, 36, 153), QuestIndex = 1},
                {Level = 15, Name = "JungleQuest", Mob = "Gorilla", Npc = CFrame.new(-1598, 36, 153), QuestIndex = 2},
                {Level = 30, Name = "BuggyQuest", Mob = "Pirate", Npc = CFrame.new(-1140, 4, 3827), QuestIndex = 1},
                {Level = 60, Name = "DesertQuest", Mob = "Desert Bandit", Npc = CFrame.new(896, 6, 4390), QuestIndex = 1},
                {Level = 75, Name = "DesertQuest", Mob = "Desert Officer", Npc = CFrame.new(896, 6, 4390), QuestIndex = 2},
                {Level = 90, Name = "SnowQuest", Mob = "Snow Bandit", Npc = CFrame.new(1389, 87, -1298), QuestIndex = 1},
                {Level = 100, Name = "SnowQuest", Mob = "Snowman", Npc = CFrame.new(1389, 87, -1298), QuestIndex = 2},
                {Level = 120, Name = "MarineQuest", Mob = "Chief Petty Officer", Npc = CFrame.new(-5035, 20, 4324), QuestIndex = 1},
            }
            
            local currentQuest = nil
            for _, q in ipairs(questData) do
                if level >= q.Level then
                    currentQuest = q
                end
            end
            return currentQuest
        end)
    end

    task.spawn(function()
        while task.wait(1) do
            if Loader.Config.AutoFarm and Loader.Config.AutoQuest then
                pcall(function()
                    local qInfo = GetQuestLevel()
                    if qInfo then
                        local activeQuest = LocalPlayer.PlayerGui.Main.Quest.Visible
                        if not activeQuest then
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = qInfo.Npc
                                task.wait(0.5)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", qInfo.Name, qInfo.QuestIndex)
                            end
                        end
                    end
                end)
            end
        end
    end)
end

return AutoQuest
