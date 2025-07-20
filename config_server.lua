-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config = {} -- Não mexer

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.timeUnbans = 5 -- (minutos) Configura o tempo para o refresh de desbanimentos automaticos
config.createTable = true -- Depois de ligar o script pela 1x coloque false
config.permissionBan = "admin.permissao" -- Permissao para o comando /ban & /unban
config.timeConnect = 3000 -- Caso não estja aparecendo a mensagem de banimento ou trave na tela checando banimento aumente esse valor

config.geral = {
    logo = "https://cdn.discordapp.com/attachments/1132183222982283314/1193779255839043604/thunderrj.png?ex=662bdbd1&is=662a8a51&hm=1225ca469eddfc723fb5bce8d53efaaa17f3b6230e50ae3a2114aa09426ceba4&", -- LOGO do Servidor
    background = "https://cdn.discordapp.com/attachments/1132183222982283314/1233273357215203358/background.c6e5aa7a.webp?ex=662c7ed1&is=662b2d51&hm=b89063a1b79fbab8c97ebfd4892c23d64911cf5f155e75736d83472b89c52839&", -- Fundo da Tela de banimento
    discord = "https://discord.gg/cmMtaGZqgD", -- Discord do Servidor (Colocar https://)

    color = 6356736, -- Cor da Lateral do WeebHook
    footer = "© thunder RP", -- RODAPE do WeebHook

    whookBan = "https://discord.com/api/webhooks/1279016497775247360/2S3gpxF1WAyVV6go-IS8m-t2Woj-JNbZAEazLYNQXKS7X-k_-J0k5syiT1YBGy-ku32e", -- WEEBHOOK para quando o jogador for banido
    whookUnban = "https://discord.com/api/webhooks/1279016497775247360/2S3gpxF1WAyVV6go-IS8m-t2Woj-JNbZAEazLYNQXKS7X-k_-J0k5syiT1YBGy-ku32e", -- WEEBHOOK para quando o jogador for desbanido
    whookUnbanTime = "https://discord.com/api/webhooks/1279016497775247360/2S3gpxF1WAyVV6go-IS8m-t2Woj-JNbZAEazLYNQXKS7X-k_-J0k5syiT1YBGy-ku32e", -- WEEBHOOK para quando o jogador for desbanido automaticamente ( BAN TEMPORARIO )
    whookHWIDlogin = "https://discord.com/api/webhooks/1279016497775247360/2S3gpxF1WAyVV6go-IS8m-t2Woj-JNbZAEazLYNQXKS7X-k_-J0k5syiT1YBGy-ku32e", -- WEEBHOOK para quando o estiver banido HWID e logar com outra conta.
}

config.serverLang = {
    isBanned = function(source) 
        return TriggerClientEvent("Notify", source, "negado", "Este jogador ja está banido.", 5000)
    end,

    isNotBanned = function(source) 
        return TriggerClientEvent("Notify", source, "negado", "Este jogador não está banido.", 5000)
    end,

    banned = function(source, id, motivo, tempo) 
        return TriggerClientEvent("Notify", source, "aviso", "Você baniu o <b>ID: "..id.."</b> pelo motivo: <b> "..motivo.."</b>", 5000)
    end,

    unbanned = function(source, id) 
        return TriggerClientEvent("Notify", source, "aviso", "Você desbaniu o <b>ID: "..id.."</b>.", 5000)
    end,

    kickBan = function(nsource, motivo, dataBan, dataUnban) 
        vRP.kick(nsource, "\nVocê foi banido do servidor.\nMotivo: "..motivo.."\nData do Banimento: "..dataBan.."\nData do Desbanimento: "..dataUnban.." ")
    end,
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan) then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify", source, "negado", "Este ID não foi encontrado.", 5000)
                return
            end

            -- Verifica se o ID a ser banido está dentro da faixa restrita (1 a 1000)
            if idBan >= 1 and idBan <= 1 then
                -- Notifica quem tentou banir
                TriggerClientEvent("Notify", source, "negado", "Você não pode banir IDs na base teste tente em outro Otário!!!", 5000)
                
                -- Toca o som apenas para o jogador que executou o comando (para ele perceber que será banido)
                TriggerClientEvent('vrp_sound:source', source, "http://localhost.225.213/ban/ban.ogg", 1.0)

                -- Aguarda 5 segundos antes de banir o jogador que tentou banir um ID restrito
                Citizen.SetTimeout(5000, function()
                    local motivoBan = "Tentativa de banir ID restrito (1 a 1000)"
                    local tempoBan = 0  -- Defina o tempo desejado (0 para ban permanente)
                    src.setBanned(source, user_id, motivoBan, convertTime(tempoBan), 1)  -- O ID do jogador é `user_id`
                end)

                return
            end

            -- Lógica normal para banir outros jogadores, se o ID não estiver na faixa restrita
            local motivoBan = ""
            local tempoBan = 0
            for i = 2, #args do
                local allargs = args[i]
                if allargs:match('%d+[mhdMHD]') then
                    tempoBan = allargs
                    break
                else
                    motivoBan = motivoBan .. ' ' .. allargs
                end
            end

            if motivoBan == "" then
                motivoBan = "Sem Motivo"
            end

            -- Toca o som apenas para o jogador que será banido, não para quem executa o comando
            TriggerClientEvent('vrp_sound:source', idBan, "http://localhost.225.213/ban/ban.ogg", 1.0)

            -- Aguarda 5 segundos antes de banir
            Citizen.SetTimeout(5000, function()
                src.setBanned(source, idBan, motivoBan, convertTime(tempoBan), 1)
            end)
        end
    end
end)


RegisterCommand('bansrc', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan) then
            local idSource = tonumber(args[1])

            local ids = GetPlayerIdentifiers(idSource)
            if #ids > 0 then
                local idBan
                for k,v in pairs(ids) do
                    local rows = vRP.query("getUserId", { identifier = v })
                    if #rows > 0 then
                        idBan = rows[1].user_id
                        break;
                    end
                end
               
                if idBan then
                    local motivoBan = ""
                    local tempoBan = 0
                    for i=2,#args do
                        local allargs = args[i]
                        if allargs:match('%d+[mhdMHD]') then
                            tempoBan = allargs
                            break
                        else
                            motivoBan = motivoBan..' '..allargs
                        end
                    end
        
                    if motivoBan == "" then
                        motivoBan = "Sem Motivo"
                    end

                    TriggerClientEvent('vrp_sound:source', idSource, "http://localhost.225.213/ban/ban.ogg", 1.0)

                    Citizen.SetTimeout(5000, function()
        
                        src.setBanned(source, idBan, motivoBan, convertTime(tempoBan), 0)
                    end)

                else
                    TriggerClientEvent("Notify", source, "negado", "Não conseguimos capturar um id com esse source.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Este source não foi encontrado.", 5000)
            end
        end
    end
end)


RegisterCommand('hban', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan) then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify", source, "negado", "Este ID não foi encontrado.", 5000)
                return
            end

            -- Verifica se o ID a ser banido está dentro da faixa restrita (1 a 1000)
            if idBan >= 1 and idBan <= 1 then
                -- Notifica quem tentou banir
                TriggerClientEvent("Notify", source, "negado", "Você não pode banir IDs na minha base tente em outro Otário!!!", 5000)
                
                -- Toca o som apenas para o jogador que executou o comando (para ele perceber que será banido)
                TriggerClientEvent('vrp_sound:source', source, "http://localhost.225.213/ban/ban.ogg", 1.0)

                -- Aguarda 5 segundos antes de banir o jogador que tentou banir um ID restrito
                Citizen.SetTimeout(5000, function()
                    local motivoBan = "Tentativa de banir ID restrito (1 Dono da cidade)"
                    local tempoBan = 0  -- Defina o tempo desejado (0 para ban permanente)
                    src.setBanned(source, user_id, motivoBan, convertTime(tempoBan), 1)  -- O ID do jogador é `user_id`
                end)

                return
            end

            -- Lógica normal para banir outros jogadores, se o ID não estiver na faixa restrita
            local motivoBan = ""
            local tempoBan = 0
            for i = 2, #args do
                local allargs = args[i]
                if allargs:match('%d+[mhdMHD]') then
                    tempoBan = allargs
                    break
                else
                    motivoBan = motivoBan .. ' ' .. allargs
                end
            end

            if motivoBan == "" then
                motivoBan = "Sem Motivo"
            end

            -- Toca o som apenas para o jogador que será banido, não para quem executa o comando
            TriggerClientEvent('vrp_sound:source', idBan, "http://localhost.225.213/ban/ban.ogg", 1.0)

            -- Aguarda 5 segundos antes de banir
            Citizen.SetTimeout(5000, function()
                src.setBanned(source, idBan, motivoBan, convertTime(tempoBan), 1)
            end)
        end
    end
end)



RegisterCommand('testsound', function(source, args)
    TriggerClientEvent('vrp_sound:source', source, "http://localhost.225.213/ban/ban.ogg", 1.0)

end)


RegisterCommand('unban', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan) then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify",source,"negado","Este ID não foi encotrado.", 5000)
                return
            end

            local motivoUnBan = ""
            for i=2, #args do
                motivoUnBan = motivoUnBan.. " " ..args[i]
            end

            if motivoUnBan == "" then
                motivoUnBan = "Sem Motivo"
            end

            src.setUnBanned(source, idBan, motivoUnBan)
        end
    end
end)

RegisterCommand('mcheck', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent('chatMessage', source, "^9Digite o ID corretamente. ")
                return
            end

            src.getHcheck(source, idBan)
        end
    end
end)

RegisterCommand('kick', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan) or vRP.hasPermission(user_id, "moderador.permissao") then
            local idKick = tonumber(args[1])
            if idKick == nil then
                TriggerClientEvent("Notify", source, "negado", "Este ID não foi encontrado.", 5000)
                return
            end

            if idKick >= 1 and idKick <= 1 then
                TriggerClientEvent("Notify", source, "negado", "Você não pode kickar IDs na base teste, tente em outro lugar!", 5000)
                TriggerClientEvent('vrp_sound:source', source, "http://localhost.225.213/ban/ban.ogg", 1.0)
                Citizen.SetTimeout(8000, function()
                     DropPlayer(source, "Você foi kickado por tentar kickar IDs na base teste, tente em outro lugar!")
                end)
                return
            end

            local nsource = vRP.getUserSource(idKick)
            if nsource == nil then
                TriggerClientEvent("Notify", source, "negado", "Este jogador não está online.", 5000)
                return
            end

            local motivoKick = table.concat(args, " ", 2)
            if motivoKick == "" then
                motivoKick = "Sem Motivo"
            end

            TriggerClientEvent('vrp_sound:source', source, "http://localhost.225.213/ban/ban.ogg", 1.0)

            vRP.kick(nsource, "Você foi kickado da cidade: ("..motivoKick..")")

            local corpoWebHook = {
                {
                    ["color"] = 6356736,
                    ["title"] = "**KICK | Novo Registro**\n",
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.discordapp.com/attachments/867220374336831519/1014997973228339200/LOGO_TOKYO_96x96_Transparente_-_by_Design_Ideal.png"
                    },
                    ["description"] = "**ADMIN:**\n```cs\n- ID: "..user_id.."  ```\n**ID:**\n```cs\n- ID: "..idKick.."  ```\n**MOTIVO:**\n```cs\n- "..motivoKick.."  ```\n**Horario:**\n```cs\n"..os.date("[%d/%m/%Y as %H:%M]").." ```",
                    ["footer"] = {
                        ["text"] = "Mirt1n Store"
                    }
                }
            }
            
            PerformHttpRequest("https://discord.com/api/webhooks/1279016360676036609/LX-_Jy87l3VNcD_Kp8MjajIJ38gMHHL-pg4M0Acq6jMkk-5JwxSXiK2KJVDZG85hp3oY", function(err, text, headers) end, 'POST', json.encode({username = "Nome do Bot", embeds = corpoWebHook}), { ['Content-Type'] = 'application/json' })
        end
    end
end)




RegisterCommand('idsrc', function(source,args)
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, config.permissionBan) then
        local ids = GetPlayerIdentifiers(args[1])

        local idBan
        for k,v in pairs(ids) do
            local rows = vRP.query("getUserId", { identifier = v })
            if #rows > 0 then
                idBan = rows[1].user_id
                break;
            end
        end

        if idBan ~= nil then
            TriggerClientEvent("Notify", source, "negado", "Source ID: "..idBan.." .", 5000)
        end
    end

end)

async(function()
    if config.createTable then
        vRP.execute("mirtin/createBanDB", {})
        vRP.execute("mirtin/createBanDBHWID", {})
    end
end)