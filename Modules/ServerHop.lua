local ServerHopModule = {}

function ServerHopModule:Init(Hub)
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    CentralPlayer = game:GetService("Players").LocalPlayer

    local function hop()
        local placeId = game.PlaceId
        local serversUrl = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
        
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(serversUrl))
        end)

        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(placeId, server.id, CentralPlayer)
                    break
                end
            end
        end
    end

    Hub.HopServer = hop

    task.spawn(function()
        while task.wait(3) do
            if Hub.Config.HopOnEvent then
                pcall(function()
                    -- Logic kiem tra Event (Full Moon / Mirage Island / Fruit)
                    local workspace = game:GetService("Workspace")
                    local hasEvent = workspace:FindFirstChild("Locations") and workspace.Locations:FindFirstChild("Mirage Island")
                    
                    if hasEvent then
                        print("Event Found!")
                    else
                        hop()
                    end
                end)
            end
        end
    end)
end

return ServerHopModule
