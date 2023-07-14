if Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    -- Custom framework
end

-- Event to pay for the service
lib.callback.register('lation_servicecenter:payService', function(source, price)
    local source = source
    local player = nil
    if Config.Framework == 'esx' then
        player = ESX.GetPlayerFromId(source)
        player.removeAccountMoney(Config.UseAccount, price)
        return true
    elseif Config.Framework == 'qbcore' then
        player = QBCore.Functions.GetPlayer(source)
        player.Functions.RemoveMoney(Config.UseAccount, price, 'Service Center')
        return true
    else
        -- Custom framework
    end
end)

-- Event to check player has enough money before service
lib.callback.register('lation_servicecenter:checkBalance', function(source)
    local source = source
    local player, balance = nil, nil
    if Config.Framework == 'esx' then
        player = ESX.GetPlayerFromId(source)
        balance = player.getAccount(Config.UseAccount)
        return balance.money
    elseif Config.Framework == 'qbcore' then
        player = QBCore.Functions.GetPlayer(source)
        balance = player.Functions.GetMoney(Config.UseAccount)
        return balance
    else
        -- Custom framework
    end
end)

-- Event to get online mechanics and return the total count
lib.callback.register('lation_servicecenter:getMechanics', function()
    local mechanicsOnline = 0
    if Config.Framework == 'esx' then
        for _, player in pairs(ESX.GetExtendedPlayers()) do
            local job = player.getJob()
            for _, jobs in pairs(Config.MechanicJobs) do
                local jobNames = jobs
                if job.name == jobNames then
                    mechanicsOnline = mechanicsOnline + 1
                end
            end
        end
    elseif Config.Framework == 'qbcore' then
        for _, players in pairs(QBCore.Functions.GetPlayers()) do
            local player = QBCore.Functions.GetPlayer(players)
            local job = player.PlayerData.job
            for _, jobs in pairs(Config.MechanicJobs) do
                local jobNames = jobs
                if job.name == jobNames then
                    mechanicsOnline = mechanicsOnline + 1
                end
            end
        end
    else
        -- Custom framework
    end
    return mechanicsOnline
end)