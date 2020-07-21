ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('h4ci:locajetski')
AddEventHandler('h4ci:locajetski', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 250
    local xMoney = xPlayer.getMoney()

        xPlayer.removeMoney(price)
        
        TriggerClientEvent('esx:showNotification', source, "~g~Jetski~w~ obtenu ! ~r~-250$")
    
end)