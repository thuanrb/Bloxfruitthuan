local ServerHopModule = {}

function ServerHopModule:Init(Hub)
    local TeleportService = Hub.Services.TeleportService
    local HttpService = Hub.Services.HttpService
    local LocalPlayer = Hub.Services.Players.LocalPlayer

    local function hop()
        pcall(function()
            local placeId = game.PlaceId
            local serversUrl = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
            
            local success, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(serversUrl))
            end)

            if success and result and result.data then
                for _, server in ipairs(result.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                        break
                    end
                end
            end
        end)
    end

    Hub.HopServer = hop

    local function checkLegendarySwordDealer()
        local npcs = game:GetService("Workspace"):FindFirstChild("NPCs")
        if npcs and npcs:FindFirstChild("Legendary Sword Dealer") then
            return true
        end
        return false
    end

    task.spawn(function()
        while task.wait(5) do
            if Hub.Config.HopTTK then
                pcall(function()
                    if checkLegendarySwordDealer() then
                        print("Legendary Sword Dealer Found!")
                    else
                        hop()
                    end
                end)
            end
        end
    end)
end

return ServerHopModule
