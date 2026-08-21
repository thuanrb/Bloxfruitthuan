local AutoStats = {}

function AutoStats:Init(Loader)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    task.spawn(function()
        while task.wait(0.5) do
            if Loader.Config.AutoStatsEnabled then
                pcall(function()
                    local statType = Loader.Config.SelectedStat or "Melee"
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", statType, Loader.Config.StatAmount or 1)
                end)
            end
        end
    end)
end

return AutoStats
