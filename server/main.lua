-- Event to pay for the service
RegisterNetEvent('lation_servicecenter:payService', function(source, price)
    local source = source
    local player = GetPlayer(source)
    if not player then return end
    RemoveMoney(source, Config.UseAccount, price)
end)

-- Callback used to retrieve player balance
lib.callback.register('lation_servicecenter:checkBalance', function(source)
    local source = source
    local player = GetPlayer(source)
    if not player then return end
    local balance = GetPlayerAccountFunds(source, Config.UseAccount)
    return balance
end)

-- Callback to get online mechanics and return the total count
lib.callback.register('lation_servicecenter:getMechanics', function()
    local count = GetPlayersWithJob(Config.MechanicJobs)
    return count
end)