TabMisc:AddToggle({
    Name = "Hop Server On Event",
    Default = false,
    Callback = function(Value)
        Hub.Config.HopOnEvent = Value
    end
})

TabMisc:AddButton({
    Name = "Server Hop Now",
    Callback = function()
        if Hub.HopServer then
            Hub.HopServer()
        end
    end
})
