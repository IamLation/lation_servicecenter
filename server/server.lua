lib.callback.register('lation_servicecenter:payRepair', function()
    if Config.RandomCosts then
        local repairPrice = math.random(Config.RepairCostMinimum, Config.RepairCostMaximum)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeAccountMoney(Config.UseAccount, repairPrice, Config.BankTransactionLabel)
        TriggerClientEvent('ox_lib:notify', xPlayer.source, { description = Notifications.repairSuccess ..repairPrice..'.', type = 'success', position = Config.NotifyPosition })
    else
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeAccountMoney(Config.UseAccount, Config.RepairCost, Config.BankTransactionLabel)
        TriggerClientEvent('ox_lib:notify', xPlayer.source, { description = Notifications.repairSuccess ..Config.RepairCost..'.', type = 'success', position = Config.NotifyPosition })
    end
end)

lib.callback.register('lation_servicecenter:payClean', function()
    if Config.RandomCosts then
        local cleanPrice = math.random(Config.CleanCostMinimum, Config.CleanCostMaximum)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeAccountMoney(Config.UseAccount, cleanPrice, Config.BankTransactionLabel)
        TriggerClientEvent('ox_lib:notify', xPlayer.source, { description = Notifications.cleanSuccess ..cleanPrice..'.', type = 'success', position = Config.NotifyPosition })
    else
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeAccountMoney(Config.UseAccount, Config.CleanCost, Config.BankTransactionLabel)
        TriggerClientEvent('ox_lib:notify', xPlayer.source, { description = Notifications.cleanSuccess ..Config.CleanCost..'.', type = 'success', position = Config.NotifyPosition })
    end
end)

lib.callback.register('lation_servicecenter:getMechanics', function(mechanicsOnline)
    local mechanicsOnline = 0
    for _, player in pairs(ESX.GetExtendedPlayers()) do
    local job = player.getJob()
        for _, jobs in pairs(Config.MechanicJobs) do
            local jobNames = jobs
            if job.name == jobNames then 
                mechanicsOnline = mechanicsOnline + 1
            end
        end
    end
    print(mechanicsOnline)
    return mechanicsOnline
end)