-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy  = module("vrp","lib/Proxy")
local config = module(GetCurrentResourceName(),"config")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
psRP = {}
Tunnel.bindInterface("thunder_staff",psRP)
vCLIENT = Tunnel.getInterface("thunder_staff")
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERYES
-----------------------------------------------------------------------------------------------------------------------------------------
DB.prepare("thunder_staff/get_warnings","SELECT * FROM thunder_staff_warnings WHERE user_id = @user_id")
DB.prepare("thunder_staff/get_warning","SELECT * FROM thunder_staff_warnings WHERE id = @id")
DB.prepare("thunder_staff/add_warnings","INSERT INTO thunder_staff_warnings (staff_user_id, user_id, reason, created) VALUES (@staff_user_id, @user_id, @reason, @created)")
DB.prepare("thunder_staff/bans","INSERT INTO mirtin_bans (user_id, motivo, banimento, desbanimento, time, hwid) VALUES (@user_id, @motivo, @banimento, @desbanimento, @time, @hwid)")
DB.prepare("thunder_staff/bans","INSERT INTO mirtin_bans (user_id, motivo, banimento, desbanimento, time, hwid) VALUES (@user_id, @motivo, @banimento, @desbanimento, @time, @hwid)")
DB.prepare("thunder_staff/edit_warning","UPDATE mirtin_bans SET user_id = @user_id, banimento = @banimento, time = @time WHERE user_id = @user_id")
DB.prepare("thunder_staff/delete_warning","DELETE FROM thunder_staff_warnings WHERE id = @id")
vRP.prepare("painelstaff/smartphone_instagram", "SELECT * FROM smartphone_instagram WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local staffperms = {}
local chatactive = {}
local chats      = {}
local messages   = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- getStaffData
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getStaffData()
    local source  = source
    local user_id = getUserId(source)
    local data    = {}
    if user_id then
        data.nome    = getUserFullName(user_id)
        data.user_id = user_id
        data.role    = getStaffName(user_id)
        data.perms   = {}

        if staffperms[user_id] ~= nil then
            data.perms = staffperms[user_id]
        end
    end
    return data
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- checkPermission
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.checkPermission()
    local source  = source
    local user_id = getUserId(source)
    if user_id then
        for k, v in pairs(config.permissions) do
            if getHasPermission(user_id, k) then
                staffperms[user_id] = v
                return true
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- checkChatOpen
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.checkChatOpen()
    local source  = source
    local user_id = getUserId(source)
    if user_id then
        if chatactive[user_id] then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getAllUsers
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getAllUsers()
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        return getUsersList()
    end

    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUser
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getUser(id)
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        local userdata = getUserInfo(tonumber(id))
        userdata.warnings = {}

        local warnings = DB.query("thunder_staff/get_warnings", { user_id = tonumber(id) })
        if #warnings > 0 then
            userdata.warnings = warnings
        end

        return userdata
    end

    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getAllGroups
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getAllGroups()
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        return getAllGroups()
    end

    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getAllVehicles
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getAllVehicles()
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        return getAllVehicles()
    end

    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getAllItems
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getAllItems()
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        return getAllItems()
    end

    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- addGroup
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.addGroup(id, group)
    local source = source
    local user_id = vRP.getUserId(source)
    
    -- Verifica se o usuário é válido e tem permissão
    if not user_id or not vRP.hasPermission(user_id, "admin.permissao") then
        return false -- Usuário não tem permissão
    end

    local idNumber = tonumber(id)

    -- Valida se o ID é numérico e o grupo é uma string válida
    if not (idNumber and type(group) == "string") then
        return false -- ID ou grupo inválido
    end

    -- Previne mudanças em grupos críticos, como 'owner'
    if group == "owner" then
        return false -- Bloqueia a adição ao grupo "owner"
    end

    -- Adiciona o usuário ao grupo
    local check = addUserGroup(idNumber, group)
    if check then
        registerWebhookAction(user_id, idNumber, group, "add") -- Registra a ação no webhook
        return true
    end

    return false -- Operação falhou
end

function psRP.remGroup(id, group)
    local source = source
    local user_id = vRP.getUserId(source)
    
    -- Verifica se o usuário é válido e tem permissão
    if not user_id or not vRP.hasPermission(user_id, "admin.permissao") then
        print("Erro: Usuário não tem permissão ou ID inválido")
        return false -- Usuário não tem permissão
    end

    local idNumber = tonumber(id)
    print("Removendo grupo:", group, "do ID:", idNumber)

    -- Valida se o ID é numérico e o grupo é uma string válida
    if not (idNumber and type(group) == "string") then
        print("Erro: ID ou grupo inválido")
        return false -- ID ou grupo inválido
    end

    -- Previne remoção de grupos críticos, como 'owner'
    if group == "owner" then
        print("Erro: Tentativa de remover o grupo 'owner'")
        return false -- Bloqueia a remoção do grupo "owner"
    end

    -- Remove o usuário do grupo
    local check = remUserGroup(idNumber, group)
    if check then
        registerWebhookAction(user_id, idNumber, group, "remove") -- Registra a ação no webhook
        return true
    else
        print("Erro: Falha ao remover o grupo:", group)
    end

    return false -- Operação falhou
end


-- Função auxiliar para registrar ações no webhook
function registerWebhookAction(user_id, idNumber, group, action)
    local actionText = action == "add" and "REGISTRO DE ADICIONAR GRUPO" or "REGISTRO DE REMOVER GRUPO"
    local webhookURL = action == "add" and config.webhooks.addgroup or config.webhooks.remgroup

    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                title = actionText .. ":\n⠀",
                thumbnail = { url = config.webhooks.webhookimage },
                fields = {
                    { 
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. getUserFullName(user_id) .. "** [**" .. user_id .. "**]\n⠀"
                    },
                    { 
                        name = "**ID & GROUP:**",
                        value = "**" .. idNumber .. " no grupo: " .. group .. "**"
                    }
                },
                footer = { 
                    text = config.webhooks.webhooktext .. os.date("%d/%m/%Y | %H:%M:%S"), 
                    icon_url = config.webhooks.webhookimage 
                },
                color = config.webhooks.webhookcolor
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- addBan
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.addBan(id, time)
    local source  = source
    local user_id = getUserId(source)

    if user_id then

        local origtime = os.time()
		local newtime  = time + 1 * 24 * tonumber(time) * 60

        -- DB.prepare("thunder_staff/bans","INSERT INTO bans (user_id, motivo, banimento, desbanimento, time, hwid) VALUES (@user_id, @motivo, @banimento, @desbanimento, @time, @hwid)")

        DB.execute("thunder_staff/bans", {
            -- staff_user_id    = user_id,
            user_id          = tonumber(id),
            motivo           = "Sem Motivo",
            banimento        = os.date("%Y-%m-%d %H:%I:%S"),
            desbanimento     = "N/A",
            time      = newtime,
            hwid           = 1,

        })

        local motivo = "Sem Motivo" -- você pode alterar esta variável para passar o motivo real do banimento
        local banimento = os.date("%Y-%m-%d %H:%I:%S")
        local desbanimento = "N/A" -- você pode alterar esta variável para passar a data de desbanimento, se houver
        local nsource = vRP.getUserSource(tonumber(id))

        -- print("Usuário banido com sucesso:")
        -- print("Motivo: " .. motivo)
        -- print("Data do banimento: " .. banimento)
        -- print("Data do desbanimento: " .. desbanimento)
        -- print("user_id: " .. user_id)

        vRP.kick(nsource, "\nVocê foi banido do servidor.\nMotivo: "..motivo.."\nData do Banimento: "..banimento.."\nData do Desbanimento: "..desbanimento.." ")
        -- vRP.setBanned(nsource, true)
        PerformHttpRequest(config.webhooks.addban, function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                { 
                    title = "REGISTRO DE ADICIONAR BANIMENTO:\n⠀",
                    thumbnail = {
                        url = config.webhooks.remgroup
                    }, 
                    fields = {
                        { 
                            name = "**COLABORADOR DA EQUIPE:**",
                            value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                        },
                        {
                            name = "**ID: **",
                            value = "**"..tonumber(id).."**"
                        },
                        {
                            name = "**TEMPO: **",
                            value = "**"..tonumber(time).."**"
                        }
                    }, 
                    footer = { 
                        text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhooks.webhookimage
                    },
                    color = config.webhooks.webhookcolor
                }
            }
        }), { ['Content-Type'] = 'application/json' })
        return true
    end

    return false
end


RegisterCommand('sallu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"streamer.permissao") or vRP.hasPermission(user_id,"perm.spawner") then
        vRP.kick(source, "\nVocê foi banido do servidor.\nMotivo: ..banimento..")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- addWarning
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.addWarning(id, reason)
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        DB.execute("thunder_staff/add_warnings", {
            staff_user_id    = user_id,
            user_id          = tonumber(id),
            reason           = reason,
            -- banned           = 0,
            -- banned_time      = "",
            -- banned_real_time = "",
            created          = os.date("%Y-%m-%d %H:%I:%S"),
        })

        PerformHttpRequest(config.webhooks.addban, function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                { 
                    title = "REGISTRO DE ADICIONAR ADVERTÊNCIA:\n⠀",
                    thumbnail = {
                        url = config.webhooks.remgroup
                    }, 
                    fields = {
                        { 
                            name = "**COLABORADOR DA EQUIPE:**",
                            value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                        },
                        {
                            name = "**ID: **",
                            value = "**"..tonumber(id).."**"
                        },
                        {
                            name = "**MOTIVO: **",
                            value = "**"..reason.."**"
                        }
                    }, 
                    footer = { 
                        text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhooks.webhookimage
                    },
                    color = config.webhooks.webhookcolor
                }
            }
        }), { ['Content-Type'] = 'application/json' })
        return true
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- editBan
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.editBan(id, time)
    local source  = source
    local user_id = getUserId(source)

    if user_id then

        local check = DB.query("thunder_staff/get_warning", { id = tonumber(id) })
        if #check > 0 then
            local origtime = os.time()
            local newtime  = time + 1 * 24 * tonumber(time) * 60

            DB.execute("thunder_staff/edit_warning", {
                user_id   = tonumber(id),
                banimento = tonumber(time),
                time      = newtime,
            })

            PerformHttpRequest(config.webhooks.editban, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE EDITAR BANIMENTO:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**COLABORADOR DA EQUIPE:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**ID: **",
                                value = "**"..tonumber(id).."**"
                            },
                            {
                                name = "**TEMPO: **",
                                value = "**"..tonumber(time).."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- deleteWarning
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.deleteWarning(id)
    local source  = source
    local user_id = getUserId(source)

    if user_id then

        local check = DB.query("thunder_staff/get_warning", { id = tonumber(id) })
        if #check > 0 then
            DB.execute("thunder_staff/delete_warning", { id = tonumber(id) })

            PerformHttpRequest(config.webhooks.deletewarning, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE APAGAR ADVERTÊNCIA/BANIMENTO:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**COLABORADOR DA EQUIPE:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**ID: **",
                                value = "**"..tonumber(id).."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getMessages
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getMessages(id)
    local source  = source
    local user_id = getUserId(source)
    local data    = {}

    if user_id then
        id = tonumber(id)
        if chatactive[id] then
            chatid = chats[id]
            data   = messages[chatid]
        end
    end

    return data
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- sendMessage
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.sendMessage(id, message)
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        
        id = tonumber(id)

        local nsource = getUserSource(id)

        if nsource == nil then
            sendnotify(source, "negado", "O player está offline", 5000)
            return false
        end

        if chatactive[id] == nil or chatactive[id] == false then
            chatactive[id] = true

            local chatid = math.random(1,10000)
    
            if messages[chatid] ~= nil then
                repeat
                    chatid = math.random(1,10000)
                    Citizen.Wait(0)
                until messages[chatid] == nil
            end

            chats[id] = chatid
            messages[chatid] = {}

            local messagedata = {
                user_id = user_id,
                staff   = true,
                name    = getUserFullName(user_id),
                image   = getUserImage(user_id),
                message = message
            }

            table.insert(messages[chatid], messagedata)
            sendnotify(nsource, "aviso", "Você recebeu uma nova mensagem da staff, utilize <b>/"..config.commands.openchat.."</b> para responder", 10000)
            TriggerClientEvent("thunder_staff:updatechatplayer",nsource)

            PerformHttpRequest(config.webhooks.sendmessage, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE ENVIAR MENSAGEM:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**COLABORADOR DA EQUIPE:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**ID: **",
                                value = "**"..tonumber(id).."**"
                            },
                            {
                                name = "**MENSAGEM: **",
                                value = "**"..message.."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
        else
            local chatid = chats[id]
            local messagedata = {
                user_id = user_id,
                staff   = true,
                name    = getUserFullName(user_id),
                image   = getUserImage(user_id),
                message = message
            }

            table.insert(messages[chatid], messagedata)
            sendnotify(nsource, "aviso", "Você recebeu uma nova mensagem da staff, utilize <b>/"..config.commands.openchat.."</b> para responder", 10000)
            TriggerClientEvent("thunder_staff:updatechatplayer",nsource)

            PerformHttpRequest(config.webhooks.sendmessage, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE ENVIAR MENSAGEM:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**COLABORADOR DA EQUIPE:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**ID: **",
                                value = "**"..tonumber(id).."**"
                            },
                            {
                                name = "**MENSAGEM: **",
                                value = "**"..message.."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
        end

        return true
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getChatMessages
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.getChatMessages()
    local source  = source
    local user_id = getUserId(source)
    local data    = {}

    if user_id then
        if chatactive[user_id] then
            chatid = chats[user_id]
            data   = messages[chatid]
        end
    end

    return data
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- sendMessagePlayer
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.sendMessagePlayer(message)
    local source  = source
    local user_id = getUserId(source)

    if user_id then
        if chatactive[user_id] then
            chatid = chats[user_id]

            local messagedata = {
                user_id = user_id,
                staff   = false,
                name    = getUserFullName(user_id),
                image   = getUserImage(user_id),
                message = message
            }
            
            local players = {}
            for k,v in pairs(messages[chatid]) do
                if v.staff then
                    if players[v.user_id] == nil then
                        table.insert(players, v.user_id)
                    end
                end
            end

            for k, v in pairs(players) do
                local nsource = getUserSource(v)
                if nsource then
                    TriggerClientEvent("thunder_staff:updatechat",nsource, user_id)
                end
            end

            table.insert(messages[chatid], messagedata)

            PerformHttpRequest(config.webhooks.sendmessageplayer, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE RESPONDER MENSAGEM:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**PLAYER:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**MENSAGEM: **",
                                value = "**"..message.."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- spawnItem
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.spawnItem(item, amount, id)
    local source  = source
    local user_id = getUserId(source)

    if user_id then

        if id == nil then
            id = user_id
        else
            id = tonumber(id)
        end

        local check = giveInventoryItem(id, item, tonumber(amount))
        if check then
            PerformHttpRequest(config.webhooks.spawnitem, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE SPAWN ITEM:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**COLABORADOR DA EQUIPE:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**ID: **",
                                value = "**"..tonumber(id).."**"
                            },
                            {
                                name = "**ITEM: **",
                                value = "**"..item.."**"
                            },
                            {
                                name = "**QUANTIDADE: **",
                                value = "**"..tonumber(amount).."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })

            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- spawnVehicle
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.spawnVehicle(id, vehicle)
    local source  = source
    local user_id = getUserId(source)

    if user_id then

        if id == "" then
            id = user_id
        else
            id = tonumber(id)
        end
        local check = spawnVehicle(id, vehicle)
        if check then
            PerformHttpRequest(config.webhooks.spawnvehicle, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE SPAWN VEÍCULO:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**COLABORADOR DA EQUIPE:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**ID: **",
                                value = "**"..tonumber(id).."**"
                            },
                            {
                                name = "**VEÍCULO: **",
                                value = "**"..vehicle.."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })

            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- addVehicle
-----------------------------------------------------------------------------------------------------------------------------------------
function psRP.addVehicle(id, vehicle)
    local source  = source
    local user_id = getUserId(source)

    if user_id then

        if id == "" then
            id = user_id
        else
            id = tonumber(id)
        end
        local check = addVehicle(id, vehicle)
        if check then
            PerformHttpRequest(config.webhooks.addvehicle, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    { 
                        title = "REGISTRO DE ADICIONAR VEÍCULO:\n⠀",
                        thumbnail = {
                            url = config.webhooks.remgroup
                        }, 
                        fields = {
                            { 
                                name = "**COLABORADOR DA EQUIPE:**",
                                value = "**"..getUserFullName(user_id).."** [**"..user_id.."**]\n⠀"
                            },
                            {
                                name = "**ID: **",
                                value = "**"..tonumber(id).."**"
                            },
                            {
                                name = "**VEÍCULO: **",
                                value = "**"..vehicle.."**"
                            }
                        }, 
                        footer = { 
                            text = config.webhooks.webhooktext..os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhooks.webhookimage
                        },
                        color = config.webhooks.webhookcolor
                    }
                }
            }), { ['Content-Type'] = 'application/json' })

            return true
        end
    end

    return false
end