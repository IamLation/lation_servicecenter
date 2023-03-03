ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('salt_servicecenter:payRepair')
AddEventHandler('salt_servicecenter:payRepair', function()
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

RegisterNetEvent('salt_servicecenter:payClean')
AddEventHandler('salt_servicecenter:payClean', function()
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