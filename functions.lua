-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy  = module("vrp","lib/Proxy")
local Tools  = module("vrp","lib/Tools")
local config = module(GetCurrentResourceName(),"config")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
psRP = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- variabless
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local vips = {
    "Inicial",
    "VipNatal",
    "VipWipe",
    "VipCrianca",
    "VipBronze",
    "VipPrata",
    "VipOuro",
    "VipPlatina",
    "VipDiamante",
    "Vipthunder",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- database set
-----------------------------------------------------------------------------------------------------------------------------------------
DB = {}

DB.prepare = function(name, query)
    vRP.prepare(name, query)
end

DB.execute = function(name, param)
    return vRP.execute(name, param)
end

DB.query = function(name, param)
    return vRP.query(name, param)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERYES
-----------------------------------------------------------------------------------------------------------------------------------------
DB.prepare("thunder_staff/all_users","SELECT I.*, U.* FROM vrp_user_identities AS I INNER JOIN vrp_users AS U ON U.id = I.user_id WHERE U.deleted = 0")
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserSource
-----------------------------------------------------------------------------------------------------------------------------------------
getUserSource = function(user_id)
    return vRP.getUserSource(tonumber(user_id))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserId
-----------------------------------------------------------------------------------------------------------------------------------------
getUserId = function(source)
    return vRP.getUserId(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserIdentity
-----------------------------------------------------------------------------------------------------------------------------------------
getUserIdentity = function(user_id)
    return vRP.getUserIdentity(user_id)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserFullName
-----------------------------------------------------------------------------------------------------------------------------------------
getUserFullName = function(user_id)
    
    local identity = getUserIdentity(user_id)
    local name = identity.nome .. " " .. identity.sobrenome
    return name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserImage
-----------------------------------------------------------------------------------------------------------------------------------------
getUserImage = function(user_id)
    local identity = getUserIdentity(user_id)
    local infos = vRP.query("painelstaff/smartphone_instagram", {user_id = parseInt(user_id)})
    
    if infos[1] and infos[1].avatarURL and infos[1].avatarURL ~= "" then
        return infos[1].avatarURL
    else
        return "https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png"
    end
end

psRP.CheckImagePlayer = function(user_id)
    local infos = vRP.query("painelstaff/smartphone_instagram", {user_id = parseInt(user_id)})
    if infos[1] and infos[1].avatarURL and infos[1].avatarURL ~= "" then
        return infos[1].avatarURL
    else
        return "https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png"
    end
end 
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserFines
-----------------------------------------------------------------------------------------------------------------------------------------
getUserFines = function(user_id)
    local identity = getUserIdentity(user_id)
    local fines = identity.multas or 0
    return tonumber(fines)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- getProfission
-----------------------------------------------------------------------------------------------------------------------------------------
getProfission = function(user_id)
    local profission = 'Desempregado'
    local primary    = vRP.getUserGroupByType(user_id,'job')
    local hie        = vRP.getUserGroupByType(user_id,'org')

    if primary ~= '' then
        profission = primary
    end

    if hie ~= '' then
        profission = hie
    end

    return profission
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getVipName
-----------------------------------------------------------------------------------------------------------------------------------------
getVipName = function(user_id)
    local name = "Nenhum"
    local list = {}

    for k, v in pairs(vips) do
        local vip = vRP.getUserGroupByType(user_id,v)
        if vip ~= '' then
            table.insert(list, vip)
        end
    end

    if #list > 0 then
        name = table.concat(list, ", ")
    end

    return name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getStaffName
-----------------------------------------------------------------------------------------------------------------------------------------
getStaffName = function(user_id)
    local staff = vRP.getUserGroupByType(user_id,'staff')

    if staff == '' then
        staff = 'Nenhum'
    end

    return staff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUsersList
-----------------------------------------------------------------------------------------------------------------------------------------
getUsersList = function()
    local rows = DB.query("thunder_staff/all_users", {})
    if #rows > 0 then
        local data = {}
        for k, v in pairs(rows) do
            local source = getUserSource(tonumber(v.user_id))

            local userdata = {
                user_id = tonumber(v.user_id),
                name    = getUserFullName(tonumber(v.user_id)),
                online  = false
            }

            if source ~= nil then
                userdata.online = true
            end
            table.insert(data, userdata)
        end
        return data
    end
    return {}
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserInfo
-----------------------------------------------------------------------------------------------------------------------------------------
getUserInfo = function(user_id)
    local identity = getUserIdentity(user_id)
    local banned   = false
    local userdata = {
        user_id      = user_id,
        name         = getUserFullName(user_id),
        phone        = identity.telefone,
        registration = identity.registro,
        age          = identity.idade,
        image        = getUserImage(user_id),
        banned       = banned,
        bank         = identity.banco,
        fines        = getUserFines(user_id),
        inventory    = {},
        groups       = {}
    }

    -- local checkbanned = exports.oxmysql:executeSync("SELECT * FROM vrp_identifiers WHERE user_id = @user_id AND banned = 1", { user_id = user_id})
    local checkbanned = exports.oxmysql:executeSync("SELECT * FROM mirtin_bans WHERE user_id = @user_id", { user_id = user_id})

    if #checkbanned > 0 then
        userdata.banned = true
    end

    local source = getUserSource(user_id)
    if source ~= nil then
        local inv = vRP.getInventory(user_id)

		if not inv then
			local data = vRP.getUserDataTable(user_id)
			inv = data.inventory
		end

        if inv then
            local inventory = {}
            for k, v in pairs(inv) do
                if not v.item or v.item == "" then
                    print(string.format("[ERRO] Item inválido! Índice: %s, Valor: %s", k, json.encode(v)))
        
                    -- Defina um valor padrão para evitar erro de concatenação
                    v.item = "item_desconhecido"
                end
        
                local itemdata = {
                    index  = v.item,
                    image  = config.IPItems..v.item..".png",
                    amount = tonumber(v.amount) or 0,
                    name   = vRP.getItemName(v.item) or "Desconhecido",
                }
        
                table.insert(inventory, itemdata)
            end
            userdata.inventory = inventory
        end
        
        local groupslist = vRP.getUserGroups(user_id)

        if groupslist then
			local groups = {}
            for k, v in pairs(groupslist) do
                if v then
                    local groupdata = {
                        group = k,
                        name  = vRP.getGroupTitle(k)
                    }

                    table.insert(groups, groupdata)
                end
            end

            userdata.groups = groups
        end
    else
        local datatable = getUserData(user_id, "vRP:datatable")
        datatable = json.decode(datatable)

        local inv = datatable.inventorys

		if inv then
			local inventory = {}
			for k,v in pairs(inv) do
                local itemdata = {
                    index  = v.item,
                    image  = config.IPItems..v.item..".png",
                    amount = tonumber(v.amount),
                    name   = vRP.getItemName(v.item),
                }

                table.insert(inventory, itemdata)
            end

            userdata.inventory = inventory
        end

        local groupslist = datatable.groups

        if groupslist then
			local groups = {}
            for k, v in pairs(groupslist) do
                if v then
                    local groupdata = {
                        group = k,
                        name  = vRP.getGroupTitle(k)
                    }

                    table.insert(groups, groupdata)
                end
            end

            userdata.groups = groups
        end
    end

    return userdata
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getAllGroups
-----------------------------------------------------------------------------------------------------------------------------------------
getAllGroups = function()
    local cfg = module("cfg/groups")
    local listgroups = cfg.groups
    local groups = {}
    for k, v in pairs(listgroups) do
        local groupdata = {
            group = k,
            name  = vRP.getGroupTitle(k),
        }
        table.insert(groups, groupdata)
    end
    return groups
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getAllVehicles
-----------------------------------------------------------------------------------------------------------------------------------------
getAllVehicles = function()
    local vehicles = {}
    local listvehicles = exports["thunder_garages"]:getListVehicles()
    for k, v in pairs(listvehicles) do
        local vehicledata = {
            vehicle = v.model,
            image   = config.IPVehicles..v.model..".png",
            name    = v.name
        }
        table.insert(vehicles, vehicledata)
    end
    return vehicles
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- getAllItems
-----------------------------------------------------------------------------------------------------------------------------------------
getAllItems = function()
    local listitems = vRP.getAllItens()
    local items = {}
    for k, v in pairs(listitems) do
        local itemdata = {
            item  = k,
            image = config.IPItems..k..".png",
            name  = v.name
        }
        table.insert(items, itemdata)
    end

    return items
end

-- index  = vRP.getItemName(v.item),
-- image  = config.IPItems..vRP.getItemName(v.item)..".png",
-- amount = tonumber(v.amount),
-- name   = vRP.itemNameList(v.item),
-----------------------------------------------------------------------------------------------------------------------------------------
-- addUserGroup
-----------------------------------------------------------------------------------------------------------------------------------------
addUserGroup = function(user_id, group)
    local source = getUserSource(user_id)
    if source then
        vRP.addUserGroup(user_id,group)
    else
        local data = vRP.query("vRP/get_userdata",{ user_id = user_id, key = "vRP:datatable" })
        if not data[1] then
            sendnotify(source,"negado","ID não encontrado no banco de dados")
            return false
        end
        local index = json.decode(data[1].dvalue)
        for k,v in pairs(index.groups) do
            if k == group then
                sendnotify(source,"negado","Esse id já tem esse cargo")
                return false
            end
        end
        index.groups[group] = true
        vRP.setUData(user_id,"vRP:datatable",json.encode(index))
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- remUserGroup
-----------------------------------------------------------------------------------------------------------------------------------------
remUserGroup = function(user_id, group)
    local source = getUserSource(user_id)
    if source then
        vRP.removeUserGroup(user_id, group)
    else
        local data = vRP.query("vRP/get_userdata",{ user_id = user_id, key = "vRP:datatable" })
        if not data[1] then
            sendnotify(source,"negado","ID não encontrado no banco de dados")
            return false
        end
        local index = json.decode(data[1].dvalue)
        for k,v in pairs(index.groups) do
            if k == group then
                index.groups[k] = nil
            end
        end
        vRP.setUData(user_id,"vRP:datatable",json.encode(index))
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getHasPermission
-----------------------------------------------------------------------------------------------------------------------------------------
getHasPermission = function(user_id, perm)
    return vRP.hasPermission(user_id,perm)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getBankMoney
-----------------------------------------------------------------------------------------------------------------------------------------
getBankMoney = function(user_id)
    local source = getUserSource(user_id)
    if source then
        return identity.banco
    else
        local rows = vRP.query("vRP/get_money",{ user_id = user_id })
		if #rows > 0 then
			return tonumber(rows[1].bank)
		end
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- giveInventoryItem
-----------------------------------------------------------------------------------------------------------------------------------------
giveInventoryItem = function(user_id, item, amount)
    local source = getUserSource(user_id)
    if source then
        vRP.giveInventoryItem(user_id, item, amount)
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserData
-----------------------------------------------------------------------------------------------------------------------------------------
getUserData = function(user_id, key)
    return vRP.getUData(user_id, key)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- setUserData
-----------------------------------------------------------------------------------------------------------------------------------------
setUserData = function(user_id, key, data)
    vRP.setUData(user_id, key, data)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- spawnVehicle
-----------------------------------------------------------------------------------------------------------------------------------------
spawnVehicle = function(user_id, vehicle)
    local source = getUserSource(user_id)
    if source then
        local plate = vRP.generatePlateNumber()
        TriggerClientEvent('spawnarveiculopp',source,vehicle, plate)
        -- TriggerEvent("setPlateEveryone",plate)
        -- TriggerEvent("setPlateAdmin",plate,user_id)
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- addVehicle
-----------------------------------------------------------------------------------------------------------------------------------------
addVehicle = function(user_id, vehicle)
    vRP.execute("vRP/inserir_veh",{ user_id = user_id, veiculo = vehicle, placa = vRP.generatePlateNumber(), ipva = os.time(), expired = "{}" })
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- sendnotify
-----------------------------------------------------------------------------------------------------------------------------------------
sendnotify = function(source, type, message, time)
    if time == nil then
        time = 5000
    end
    if source then 
        TriggerClientEvent("Notify",source,type,message,time)
    end
end