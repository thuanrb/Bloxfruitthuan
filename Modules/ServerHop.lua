-- Modules/ServerHop.lua
local ServerHop = {}

function ServerHop:Init(Loader)
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    function ServerHop:Hop()
        pcall(function()
            local servers = {}
            local cursor = ""
            
            repeat
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                if cursor ~= "" then
                    url = url .. "&cursor=" + cursor
                end
                
                local success, response = pcall(function()
                    return HttpService:JSONDecode(game:HttpGet(url))
                end)
                
                if success and response and response.data then
                    for _, server in ipairs(response.data) do
                        if type(server) == "table" and server.maxPlayers and server.playing and server.playing < server.maxPlayers - 2 then
                            if server.id ~= game.JobId then
                                table.insert(servers, server.id)
                            end
                        end
                    end
                    cursor = response.nextPageCursor or ""
                else
                    break
                end
            until cursor == "" or #servers > 0

            if #servers > 0 then
                local targetServer = servers[math.random(1, #servers)]
                TeleportService:TeleportToPlaceInstance(game.PlaceId, targetServer, LocalPlayer)
            else
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end
        end)
    end
end

return ServerHop
