local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

src = {}
Tunnel.bindInterface('zFuel',src)
vCLIENT = Tunnel.getInterface('zFuel')

local peds = {}
local attList = {}

function src.returnMoney()
	local source = source
	return Config.money(source)
end

function src.checkPayment(amount)
	local source = source
	return Config.payment(source, amount)
end

function src.syncMove(index,x,y,z)
	TriggerClientEvent('pedMove', -1, index,x,y,z)
end

function src.syncObject(index,x,y,z)
	TriggerClientEvent('syncObject', -1, index,x,y,z)
end

function src.syncDeleteObject(index)
	TriggerClientEvent('syncDeleteObject', -1, index)
end

function src.syncFuel(index, amount)
	TriggerClientEvent('syncFuel', -1, index,amount)
end

function src.syncFace(index, target, time)
	TriggerClientEvent('syncFace', -1, index,target,time)
end

function src.syncAnim(index, toggle, type)
	TriggerClientEvent('syncAnim', -1, index,toggle,type)
end

function src.syncWhistle(index, target, time)
	TriggerClientEvent('syncWhistle', -1, index, target, time)
end

function src.addList(ped)
	local source = source
	local user_id = vRP.getUserId(source)
	attList[user_id] = ped
end

function src.removeList()
	local source = source
	local user_id = vRP.getUserId(source)
	attList[user_id] = nil
end

function src.getService(ped)
	return peds[ped].service
end

function src.setService(ped, toggle)
	peds[ped].service = toggle
	if not toggle then
		peds[ped].unbug = 0
	end
end

function src.getWhistle(ped)
	return peds[ped].whistle
end

function src.isOnGarage()
	if GetPlayerRoutingBucket(source) ~= 0 then
		return true
	else
		return false
	end
end

function src.setWhistle(ped, toggle)
	peds[ped].whistle = toggle
	peds[ped].wtime = Config.whistleCD
end

AddEventHandler('vRP:playerLeave',function(user_id,source)
	if attList[user_id] ~= nil then
		local id = attList[user_id]
		peds[id].service = false
		attList[user_id] = nil
		TriggerClientEvent('pedReturn', -1, id,Config.pedlist[id].x,Config.pedlist[id].y,Config.pedlist[id].z)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.pedlist) do
		table.insert(peds, {
			id = k,
			whistle = false,
			wtime = 0, 
			service = false,
			unbug = 0
		})
	end
end)

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(peds) do
			if v.service then
				v.unbug = v.unbug + 1
				if v.unbug > 360 then
					v.service = false
					TriggerClientEvent('pedReturn', -1, v.id,Config.pedlist[v.id].x,Config.pedlist[v.id].y,Config.pedlist[v.id].z)
					TriggerClientEvent('syncAnim', -1, v.id,false,'')
				end
			else
				v.unbug = 0
			end
			if Config.whistle then
				if v.wtime > 0 then
					v.wtime = v.wtime - 1
					if v.wtime == 0 then
						v.whistle = false
					end
				end
			end
		end
		Citizen.Wait(1000)
	end
end)