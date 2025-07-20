local cache = {}
cache['inArena'] = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SETARENA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.setArena(source, status)
    if status then
        cache['inArena'][source] = true
    else
        cache['inArena'][source] = nil
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIAR ITENS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local cfg = module("cfg/items")

vRP.items = {}

function vRP.defInventoryItem(idname, name, tipo, weight, fome, sede)
    weight = weight or 0  -- Usando 'or' para definir um valor padrão

    local item = { name = name, tipo = tipo, weight = weight, fome = fome, sede = sede }
    vRP.items[idname] = item
end

for k, v in pairs(cfg.items) do
    vRP.defInventoryItem(k, v[1], v[2], v[3], v[4], v[5])
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS PADROES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getAllItens()
    return vRP.items
end

function vRP.getItemName(idname)
    local args = vRP.parseItem(idname)
    local item = vRP.items[args[1]]
    if item then
        return vRP.computeItemName(item, args)
    end
    return args[1]
end

function vRP.getItemWeight(idname)
    local args = vRP.parseItem(idname)
    local item = vRP.items[args[1]]
    if item then
        return vRP.computeItemWeight(item, args)
    end
    return 0
end

function vRP.itemFood(args)
    local item = vRP.items[args]
    if item then
        return item.fome, item.sede
    end
end

function vRP.computeItemName(item, args)
    if type(item.name) == "string" then
        return item.name
    else
        return item.name(args)
    end
end

function vRP.computeItemWeight(item, args)
    if type(item.weight) == "number" then
        return item.weight
    else
        return item.weight(args)
    end
end

function vRP.getItemType(args)
    local item = vRP.items[args]
    if item then
        return item.tipo
    end
end

function vRP.computeInvWeight(user_id)
    local weight = 0
    local inventory = vRP.getInventory(user_id)
    if inventory then
        for k in pairs(inventory) do
            if vRP.items[inventory[k].item] then
                weight = weight + vRP.getItemWeight(inventory[k].item) * parseInt(inventory[k].amount)
            end
        end
        return weight
    end
    return 0
end 

function vRP.computeItemsWeight(items)
    local weight = 0
    if items then
        for k in pairs(items) do
            if vRP.items[items[k].item] then
                weight = weight + vRP.getItemWeight(items[k].item) * parseInt(items[k].amount)
            end
        end
        return weight
    end
    return 0
end 

function vRP.getInventoryItemAmount(user_id, idname)
    local data = vRP.getInventory(user_id)
    if data then
        for k in pairs(data) do
            if data[k].item == idname then
                return parseInt(data[k].amount)
            end
        end
    end
    return 0
end

function vRP.getItemInSlot(user_id, idname, target)
    local data = vRP.getInventory(user_id)
    if data then
        for k in pairs(data) do
            if data[k].item == idname then
                return k
            end
        end
    end
    return target
end

local organizing = {}

function vRP.setOrganizing(user_id)
    if organizing[user_id] then
        organizing[user_id] = false
        return false
    else
        organizing[user_id] = true
        return true
    end
end


-- Função para obter o peso máximo do inventário de um usuário
function vRP.getInventoryMaxWeight(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        local mochila = data.mochila
        if user_id then
            if vRP.hasGroup(user_id, "developer") or vRP.hasGroup(user_id, "developeroff") then
                return 1000000 + 30 * tonumber(mochila.quantidade)
            elseif organizing[user_id] then
                return 1000000 + 30 * tonumber(mochila.quantidade)
            else
                return 10 + 30 * tonumber(mochila.quantidade)
            end
        end
    end
    return 10 -- Retorna um valor padrão se os dados não existirem
end

-- Função para limpar o inventário do usuário
function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.inventory = {}
    end
end

-- Função para dividir strings
function vRP.parseItem(idname)
    return splitString(idname, "|")
end

-- Adicionar item ao inventário
function vRP.giveInventoryItem(user_id, idname, amount, notify, slot)
    local source = vRP.getUserSource(user_id)
    local data = vRP.getInventory(user_id)
    if user_id then
        if idname ~= "money" then
            if source and cache['inArena'][source] ~= nil then
                return -- Impede a adição de itens se o jogador estiver na arena
            end
        end

        if vRP.items[idname] == nil and idname then
            TriggerClientEvent("Notify", source, "negado", "Este item <b>" .. idname .. "</b> não existe cadastrado na base.", 5)
            return
        end

        if data and parseInt(amount) > 0 then
            if not slot then
                local initial = 0
                repeat
                    initial = initial + 1
                until data[tostring(initial)] == nil or (data[tostring(initial)] and data[tostring(initial)].item == idname)
                
                initial = tostring(initial)
                
                if data[initial] == nil then
                    data[initial] = { item = idname, amount = parseInt(amount) }
                elseif data[initial] and data[initial].item == idname then
                    data[initial].amount = parseInt(data[initial].amount) + parseInt(amount)
                end

                if notify then
                    TriggerClientEvent("itensNotify", source, "sucesso", amount, vRP.getItemName(idname), idname, vRP.getItemWeight(idname) * amount)
                end
            else
                slot = tostring(slot)
                if data[slot] then
                    if data[slot].item == idname then
                        local oldAmount = parseInt(data[slot].amount)
                        data[slot] = { item = idname, amount = parseInt(oldAmount) + parseInt(amount) }
                    end
                else
                    data[slot] = { item = idname, amount = parseInt(amount) }
                end

                if notify then
                    TriggerClientEvent("itensNotify", source, "sucesso", amount, vRP.getItemName(idname), idname, vRP.getItemWeight(idname) * amount)
                end
            end
        end
    end
end

-- Função para tentar remover um item do inventário
function vRP.tryGetInventoryItem(user_id, idname, amount, notify, slot)
    local source = vRP.getUserSource(user_id)
    local data = vRP.getInventory(user_id)
    if user_id then
        if data then
            if not slot then
                for k, v in pairs(data) do
                    if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
                        v.amount = parseInt(v.amount) - parseInt(amount)
                        if parseInt(v.amount) <= 0 then
                            data[k] = nil
                        end

                        if notify then
                            TriggerClientEvent("itensNotify", source, "negado", amount, vRP.getItemName(idname), idname, vRP.getItemWeight(idname) * amount)
                        end
                        return true
                    end
                end
            else
                slot = tostring(slot)
                if data[slot] and data[slot].item == idname and parseInt(data[slot].amount) >= parseInt(amount) then
                    data[slot].amount = parseInt(data[slot].amount) - parseInt(amount)
                    if parseInt(data[slot].amount) <= 0 then
                        data[slot] = nil
                    end

                    if notify then
                        TriggerClientEvent("itensNotify", source, "negado", amount, vRP.getItemName(idname), idname, vRP.getItemWeight(idname) * amount)
                    end
                    return true
                end
            end
        end
    end
    return false
end

-- Função para remover item do inventário
function vRP.removeInventoryItem(user_id, idname, amount)
    local source = vRP.getUserSource(user_id)
    local data = vRP.getInventory(user_id)
    if user_id then
        if data then
            for k, v in pairs(data) do
                if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
                    v.amount = parseInt(v.amount) - parseInt(amount)
                    if parseInt(v.amount) <= 0 then
                        data[k] = nil
                    end
                    break
                end
            end

            TriggerClientEvent("itensNotify", source, "negado", amount, vRP.getItemName(idname), idname, vRP.getItemWeight(idname) * amount)
        end
    end
end

-- Função para adicionar uma mochila
function vRP.addMochila(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        local mochila = data.mochila or { quantidade = 0, perder = 0 }
        mochila.quantidade = (mochila.quantidade or 0) + 1
        data.mochila = mochila
        vRP.saveMochilaData(user_id, mochila)
    end
end

-- Função para remover a mochila
function vRP.remMochila(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        local mochila = data.mochila or { quantidade = 0, perder = 0 }
        mochila.quantidade = 0
        data.mochila = mochila
        vRP.saveMochilaData(user_id, mochila)
    end
end

-- Função para obter a quantidade de mochilas
function vRP.getMochilaAmount(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data and data.mochila then
        return data.mochila.quantidade or 0
    end
    return 0
end

-- Função para atualizar o tempo de "perder" da mochila
function vRP.atualizarMochila(user_id, time)
    local data = vRP.getUserDataTable(user_id)
    if data then
        local mochila = data.mochila or { quantidade = 0, perder = 0 }
        mochila.perder = time
        data.mochila = mochila
        vRP.saveMochilaData(user_id, mochila)
    end
end

-- Função para salvar os dados da mochila no banco de dados
function vRP.saveMochilaData(user_id, mochila)
    if user_id and mochila then
        local quantidade = mochila.quantidade or 0
        local perder = mochila.perder or 0
        exports.oxmysql:execute("UPDATE vrp_users_infos SET mochila = @quantidade, perder = @perder WHERE user_id = @user_id", {
            ['@user_id'] = user_id,
            ['@quantidade'] = quantidade,
            ['@perder'] = perder
        }, function(affectedRows)
            if type(affectedRows) == "number" and affectedRows > 0 then
                print("Mochila atualizada para user_id: " .. user_id .. ", quantidade: " .. quantidade .. ", perder: " .. perder)
            end
        end)
    end
end

-- Evento para carregar dados ao jogador entrar
AddEventHandler("vRP:playerJoin", function(user_id, source, name)
    local data = vRP.getUserDataTable(user_id)

    if not data.inventory then
        data.inventory = {}
    end

    if not data.mochila then
        exports.oxmysql:single('SELECT mochila, perder FROM vrp_users_infos WHERE user_id = ?', {user_id}, function(result)
            if result then
                data.mochila = {
                    quantidade = result.mochila or 0,
                    perder = result.perder or 0
                }
            else
                data.mochila = { quantidade = 0, perder = 0 }
            end
        end)
    end
end)

RegisterCommand("resetmochila", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)  -- Obtém o ID do usuário que executou o comando

    if user_id then
        local data = vRP.getUserDataTable(user_id)

        if data and data.mochila then
            -- Zera a mochila
            data.mochila.quantidade = 0
            data.mochila.perder = 0
            
            -- Atualiza a mochila no banco de dados
            vRP.saveMochilaData(user_id, { quantidade = 0, perder = 0 })

            -- Notifica o jogador que a mochila foi zerada
            TriggerClientEvent("Notify", source, "sucesso", "Sua mochila foi redefinida com sucesso.", 6000)
        else
            TriggerClientEvent("Notify", source, "negado", "Você não possui uma mochila para redefinir.", 6000)
        end
    else
        print("Erro: user_id não encontrado.")
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NATION GET INVENTARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.getVehicleName(name)
	return exports["thunder_garages"]:getVehicleName(name)
end

function vRP.getVehicleTrunk(name)
	return exports["thunder_garages"]:getVehicleTrunk(name)
end

function vRP.EnviarItens()
	return itemlist
 end





 