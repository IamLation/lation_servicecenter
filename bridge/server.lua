-- Get framework
if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
    Framework = 'esx'
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = 'qb'
else
    -- Add support for a custom framework here
    return
end

-- Get player from source
GetPlayer = function(source)
    if Framework == 'esx' then
        return ESX.GetPlayerFromId(source)
    elseif Framework == 'qb' then
        return QBCore.Functions.GetPlayer(source)
    else
        -- Add support for a custom framework here
    end
end

-- Function to return total number of players online with specified job(s)
GetPlayersWithJob = function(jobs)
    local jobCount = 0
    if Framework == 'esx' then
        for _, player in pairs(ESX.GetExtendedPlayers()) do
            local job = player.getJob()
            for _, jobs in pairs(jobs) do
                local jobNames = jobs
                if job.name == jobNames then
                    jobCount = jobCount + 1
                end
            end
        end
    elseif Framework == 'qb' then
        for _, players in pairs(QBCore.Functions.GetPlayers()) do
            local player = QBCore.Functions.GetPlayer(players)
            local job = player.PlayerData.job
            for _, jobs in pairs(jobs) do
                local jobNames = jobs
                if job.name == jobNames then
                    jobCount = jobCount + 1
                end
            end
        end
    else
        -- Add support for a custom framework here
    end
    return jobCount
end

-- Function used to get a players account balance
GetPlayerAccountFunds = function(source, moneyType)
    local player = GetPlayer(source)
    moneyType = ConvertMoneyType(moneyType)
    if Framework == 'qb' then
        return player.PlayerData.money[moneyType]
    elseif Framework == 'esx' then
        return player.getAccount(moneyType).money
    else
        -- Add support for a custom framework here
    end
end

-- Function to remove money from a player's account
--- @param source number
--- @param moneyType string
--- @param amount number
RemoveMoney = function(source, moneyType, amount)
    local player = GetPlayer(source)
    moneyType = ConvertMoneyType(moneyType)
    if player then
        if Framework == 'esx' then
            player.removeAccountMoney(moneyType, amount)
        elseif Framework == 'qb' then
            player.Functions.RemoveMoney(moneyType, amount)
        else
            -- Add support for a custom framework here
        end
    end
end

-- Function to convert moneyType to match framework
ConvertMoneyType = function(moneyType)
    if moneyType == 'money' and Framework == 'qb' then
        moneyType = 'cash'
    elseif moneyType == 'cash' and Framework == 'esx' then
        moneyType = 'money'
    else
        -- Add support for a custom framework here
    end
    return moneyType
end