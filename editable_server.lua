local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("mechanic",src)

Citizen.CreateThread(function()
   
    GetPlayer = function(Id)
        return vRP.getUserId(Id)
    end

    AddMoney = function(Id, amount)
        local xPlayer = vRP.getUserId(Id)
        if xPlayer then
            xPlayer.addMoney(amount)
        end
    end
    
    GetMoney = function(Id, st)
        --print(type, " type is this")
        local xPlayer = vRP.getUserId(Id)
        if xPlayer then
            if st == "card" then
                return xPlayer.getAccount("bank").money
            else
                return xPlayer.getMoney()
            end
        end
    end

    RemoveMoney = function(Id, amount, ts)
        local xPlayer = vRP.getUserId(Id)
        if xPlayer then
            if ts == "card" then
                xPlayer.removeAccountMoney("bank", amount)
            else
                xPlayer.removeMoney(amount)
            end
        end
    end

    Notification = function(Id, message)
        TriggerClientEvent("Notify", Id, 'importante', message, 5000)
    end

        
   
end)