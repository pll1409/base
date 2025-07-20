local aExpediente2 = {
	{ ['grupo1'] = "admin", ['grupo2'] = "adminoff"},
	{ ['grupo1'] = "owner", ['grupo2'] = "owneroff"},
	{ ['grupo1'] = "moderador", ['grupo2'] = "moderadoroff"},
	{ ['grupo1'] = "suporte", ['grupo2'] = "suporteoff"}
} 

RegisterCommand('staff', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    
    if user_id then
        local x, y, z = vRPclient.getPosition(source)
        local area_permitida = {minX = -557.89, minY = -222.21, minZ = 37.61, maxX = -457.89, maxY = -122.21, maxZ = 137.61} -- Coordenadas da área permitida com raio de 100 metros -557.89,  -222.21,  37.61, -457.89,  -122.21,137.61

        if x >= area_permitida.minX and x <= area_permitida.maxX and
           y >= area_permitida.minY and y <= area_permitida.maxY and
           z >= area_permitida.minZ and z <= area_permitida.maxZ then
            for k,v in pairs(aExpediente2) do
                if vRP.hasGroup(user_id, v.grupo2) then
                    vRP.addUserGroup(user_id, v.grupo1)
                    TriggerClientEvent("Notify",source,"sucesso","[ADMIN] Você entrou no modo STAFF com sucesso.", 8000)
                    vRP.sendLog("https://discord.com/api/webhooks/1279018511628242977/LP8spL90s4EZmjZGOrvlSTy1CMIXaMI7YGJyGVOh5z_RmF2jUn0oRVbbhv1_r0bPkxur", "```css\n** BATER PONTO **\n"..os.date("[%d/%m/%Y as %X]").." ["..string.upper(v.grupo1).."] O(a) ["..identity.nome.." " ..identity.sobrenome.." ("..user_id..")] acabou de entrar em expediente.```")
                else
                    if vRP.hasGroup(user_id, v.grupo1) then
                        vRP.addUserGroup(user_id, v.grupo2)
                        TriggerClientEvent("Notify",source,"negado","[ADMIN] Você saiu do modo STAFF com sucesso.", 8000)
                        vRP.sendLog("https://discord.com/api/webhooks/1279018511628242977/LP8spL90s4EZmjZGOrvlSTy1CMIXaMI7YGJyGVOh5z_RmF2jUn0oRVbbhv1_r0bPkxur", "```css\n** BATER PONTO **\n"..os.date("[%d/%m/%Y as %X]").." ["..string.upper(v.grupo1).."] O(a) ["..identity.nome.. " " ..identity.sobrenome.." ("..user_id..")] acabou de sair em expediente.```")
                    end
                end
            end
        else
            TriggerClientEvent("Notify",source,"negado","[ADMIN] Você não pode entrar no modo STAFF fora da área permitida.", 8000)
        end
    end
end)




-- Tabela para armazenar os jogadores que participaram do evento
local eventoPlayers = {}

RegisterCommand('evento', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    if not user_id then return end

    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "ilegal.permissao") then
        local action = args[1]

        -- Se o comando for para iniciar o evento
        if action == "iniciar" then
            local users = vRP.getUsers()
            local coords = GetEntityCoords(GetPlayerPed(source))
            local dimension = GetPlayerRoutingBucket(source)

            -- Armazenar a posição e dimensão originais do jogador que iniciou o evento
            local originalCoords = GetEntityCoords(GetPlayerPed(source))
            local originalDimension = GetPlayerRoutingBucket(source)

            eventoPlayers[source] = {
                coords = originalCoords,
                dimension = originalDimension
            }

            -- Notificar todos sobre o início do evento
            TriggerClientEvent('Notify', -1, 'importante', 'O jogador ' .. GetPlayerName(source) .. ' iniciou um evento!', 5000)

            for k, v in pairs(users) do
                async(function()
                    local src = vRP.getUserSource(tonumber(k))
                    if src and src ~= source then
                        local request = vRP.request(src, 'Você deseja participar do evento iniciado por ' .. GetPlayerName(source) .. '?', 15)
                        if request then
                            -- Armazenar a posição e dimensão originais do jogador
                            local originalCoords = GetEntityCoords(GetPlayerPed(src))
                            local originalDimension = GetPlayerRoutingBucket(src)

                            eventoPlayers[src] = {
                                coords = originalCoords,
                                dimension = originalDimension
                            }

                            -- Teleportar o jogador para o evento
                            SetEntityCoords(GetPlayerPed(src), coords.x, coords.y, coords.z)
                            SetPlayerRoutingBucket(src, dimension)

                            -- Confirmar teleporte
                            TriggerClientEvent('Notify', src, 'sucesso', 'Você foi teleportado para o evento!', 5000)
                        end
                    end
                end)
            end

        -- Se o comando for para encerrar o evento
        elseif action == "sair" then
            for src, data in pairs(eventoPlayers) do
                if data.coords and data.dimension then
                    -- Restaurar saúde para jogadores mortos
                    vRPclient.setHealth(src, 400)

                    -- Retornar o jogador à posição e dimensão originais
                    SetEntityCoords(GetPlayerPed(src), data.coords.x, data.coords.y, data.coords.z)
                    SetPlayerRoutingBucket(src, data.dimension)

                    -- Confirmar retorno
                    TriggerClientEvent('Notify', src, 'importante', 'Você foi retornado à sua posição original!', 5000)
                end
            end

            -- Limpar a tabela de jogadores no evento
            eventoPlayers = {}

            -- Notificar o jogador que encerrou o evento
            TriggerClientEvent('Notify', source, 'sucesso', 'Todos os jogadores foram retornados às suas posições originais e revividos, se necessário!', 5000)
        else
            -- Mensagem de uso correto do comando
            TriggerClientEvent('Notify', source, 'importante', 'Use: /evento iniciar ou /evento sair', 5000)
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Você não tem permissão para usar este comando.', 5000)
    end
end)


RegisterCommand('godarea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasPermission(user_id,"perm.evento") or vRP.hasPermission(user_id,"ilegal.permissao") then
		if args[1] then
			local users = vRP.getUsers()
			local coords = GetEntityCoords(GetPlayerPed(source))
			for k,v in pairs(users) do
				local id = vRP.getUserSource(parseInt(k))
				if id then
					local cds = GetEntityCoords(GetPlayerPed(id))
					if #(cds-coords) <= parseInt(args[1]) then
						vRPclient.killGod(id)
						vRPclient.setHealth(id,400)
					end
				end
			end
		else
			TriggerClientEvent('Notify',source, 'negado', 'Você não informou a area exemplo /godarea 5!', 5000)
		end
    end
end)

RegisterCommand('dm',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ticket.permissao") then
        if args[1] then
            local mensagem = vRP.prompt(source,"Mensagem:","")
            if mensagem == "" then
                return
            end
            local tplayer = vRP.getUserSource(parseInt(args[1]))

            if tplayer then
                TriggerClientEvent('chatMessage',tplayer,"(Privado Atendimento)",{255, 0, 0},mensagem)
                vRPclient._playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
            end
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"perm.user") then
        local users = vRP.getUsers()
        local players = ""
		local quantidade = 0
		
        for k,v in pairs(users) do
			players = players..k..","
            quantidade = quantidade + 1 
		end
		
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0}, quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0}, players)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------
-- flash
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("flash", function(source, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            TriggerClientEvent("CachicasFlash", source)
            TriggerClientEvent("API.setEnergetico", source, true)
            TriggerClientEvent("Notify", source, "sucesso", "Modo Flash Ativado</br>", 5000)
            SetTimeout(300000, function() -- 5 minutos em milissegundos
                TriggerClientEvent("API.setEnergetico", source, false)
                TriggerClientEvent("Notify", source, "sucesso", "Modo Flash Desativado</br>", 5000)
            end)
        else
            TriggerClientEvent("Notify", source, "erro", "Você não tem permissão para usar este comando.</br>", 5000)
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------
-- item
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			if args[1] == "money" then
				local creturn = vRP.getItemInSlot(user_id, "money", false)
				if creturn then
					vRP.giveInventoryItem(user_id,""..args[1].."",parseInt(args[2]), true, creturn)
				else
					vRP.giveInventoryItem(user_id,""..args[1].."",parseInt(args[2]), true)
				end
			else
				vRP.giveInventoryItem(user_id,""..args[1].."",parseInt(args[2]), true)
			end
			
			vRP.sendLog("ITEM", "O ID "..user_id.." givou o item "..args[1].." na quantidade de "..args[2].." x")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAR ITEM OFFLINE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("selectDataTable", "SELECT dvalue from vrp_user_data WHERE dkey = 'vRP:datatable' and user_id = @user_id")
vRP.prepare("updateDataTable", "UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id")

lock = {}

AddEventHandler("fstore:send_item",function(user_id, item, amount)
	while lock[user_id] do Wait(10) end

	lock[user_id] = true
	if lock[user_id] then
		local source = vRP.getUserSource(user_id)
		if source then
			print("FIVEM-STORE: Adicionado item: "..item.." "..amount.."x user_id: "..user_id.. " jogador: online")
			vRP.giveInventoryItem(user_id, item, amount, true)
		else
			local rows = vRP.query("selectDataTable", { user_id = user_id })
			if #rows > 0 then
				local decode = json.decode(rows[1].dvalue)
				local inventory = decode.inventory

				local count = 0
				repeat 
					count = count + 1
				until inventory[tostring(count)] == nil

				print("FIVEM-STORE: Adicionado item: "..item.." "..amount.."x user_id: "..user_id.. " slot: "..count.. " jogador: offline")

				inventory[tostring(count)] = { item = item, amount = amount }
				vRP.execute("updateDataTable", { user_id = user_id, dvalue = json.encode(decode) })
			
			else
				print("Ocorreu um problema ao entregar o item para o user_id: "..user_id)
			end
		end
	end

	lock[user_id] = nil
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Verificar id na radio
-----------------------------------------------------------------------------------------------------------------------------------------

local pradio = {}

RegisterCommand('pradio', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
        if args[1] then
            local channel = tonumber(args[1])
            if channel then
                local players = exports['pma-voice']:getPlayersInRadioChannel(channel)
                for source2, isTalking in pairs(players) do
                    local nid = vRP.getUserId(source2)
                    table.insert(pradio, nid)  -- Adiciona o user_id dos jogadores na tabela
                end
                -- Envia os dados para o lado cliente
                TriggerClientEvent('displayRadioPlayers', source, pradio)
                pradio = {} -- Limpa a tabela após enviar os dados
            else
                TriggerClientEvent('chatMessage', source, "^1Erro: Canal inválido.") -- Mensagem de erro no chat
            end
        else
            TriggerClientEvent('chatMessage', source, "^1Erro: Você deve especificar o canal de rádio.") -- Mensagem de erro no chat
        end
    else
        TriggerClientEvent('chatMessage', source, "^1Você não tem permissão para usar este comando.") -- Mensagem de erro no chat
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped",function(index)
	TriggerClientEvent("syncdeleteped",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
	local entity = NetworkGetEntityFromNetworkId(index)
    if entity and entity ~= 0 then 
        DeleteEntity(entity)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE PRISAO ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prenderadm', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") then
        local idPlayer = vRP.prompt(source, "Digite o ID:", "")
        if tonumber(idPlayer) then
            local nplayer = vRP.getUserSource(tonumber(idPlayer))
            if nplayer then
                local tempoPrisao = vRP.prompt(source, "Digite o tempo da prisão", "")
                if tonumber(tempoPrisao) then
                    local motivoPrisao = vRP.prompt(source, "Digite o motivo da prisão", "")
                    if motivoPrisao ~= nil and motivoPrisao ~= "" then
                        local nidentity = vRP.getUserIdentity(tonumber(idPlayer))
                        if nidentity then
                            -- Enviar mensagens de prisão para todos os jogadores
                            TriggerClientEvent('chatMessage', -1, 'PRISÃO ADM', { 0, 0, 0 }, '^0 O ^3' .. nidentity.nome .. ' ' .. nidentity.sobrenome .. ' ^0 foi preso(a) por ^3' .. tonumber(tempoPrisao) .. ' ^0minutos ^0 pelo motivo: ^3 ' .. motivoPrisao)
                            TriggerClientEvent('chatMessage', nplayer, 'PRISÃO ADM', { 0, 0, 0 }, '^0Você foi preso pelo admin: ^2' .. GetPlayerName(source) .. ' (' .. user_id .. ')^0.')
                            vRPclient._teleport(nplayer, 1678.6, 2513.39, 45.57)
                            prison_lock_adm(tonumber(idPlayer))
                            TriggerClientEvent('prisaoADM', nplayer, true)
							vRP.setUData(tonumber(idPlayer), "vRP:prisao", json.encode(tonumber(tempoPrisao)))
                            vRP.setUData(tonumber(idPlayer), "vRP:prisao:ADM", json.encode(tonumber(tempoPrisao)))
                            vRP.sendLog("PRENDERADM", "O ADMIN " .. user_id .. " PRENDEU O ID: " .. idPlayer .. "PELO MOTIVO: " .. motivoPrisao)
                            vRP.clearInventory(tonumber(idPlayer))
                            TriggerClientEvent("Notify", nplayer, "importante", "Os guardas apreenderam seus itens.", 8000)
                            
                            -- Adicionar log no console do servidor
                            print(string.format("ADMIN %s prendeu o jogador %s (%s) por %s minutos. Motivo: %s", user_id, idPlayer, GetPlayerName(source), tempoPrisao, motivoPrisao))
                        end
                    else
                        TriggerClientEvent('chatMessage', source, '^2Digite o Motivo Corretamente.')
                    end
                else
                    TriggerClientEvent('chatMessage', source, '^2Digite o Tempo da Prisao Corretamente.')
                end
            else
                local tempoPrisao = vRP.prompt(source, "Digite o tempo da prisão", "")
                if tonumber(tempoPrisao) then
                    local motivoPrisao = vRP.prompt(source, "Digite o motivo da prisão", "")
                    if motivoPrisao ~= nil and motivoPrisao ~= "" then
                        -- Adicionar log no console do servidor para jogador offline
                        print(string.format("ADMIN %s prendeu offline o jogador %s por %s minutos. Motivo: %s", user_id, idPlayer, tempoPrisao, motivoPrisao))
                        
                        TriggerClientEvent('chatMessage', source, '** Jogador Offline ** ^2 Você prendeu ' .. idPlayer .. ' por ' .. tempoPrisao .. ' mese(s)')
						vRP.setUData(tonumber(idPlayer), "vRP:prisao", json.encode(tonumber(tempoPrisao)))
                        vRP.setUData(tonumber(idPlayer), "vRP:prisao:ADM", json.encode(tonumber(tempoPrisao)))
                        vRP.sendLog("PRENDERADM", "O ADMIN " .. user_id .. " PRENDEU O ID: " .. idPlayer .. "PELO MOTIVO: " .. motivoPrisao)
                    end
                end
            end
        else
            TriggerClientEvent('chatMessage', source, '^2Digite o ID Do player Corretamente.')
        end
    end
end)


RegisterCommand('rprender', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    print("Comando rprender executado. ID do usuário: " .. user_id)
    
    if vRP.hasPermission(user_id, "developer.permissao") or
       vRP.hasPermission(user_id, "perm.evento") or
       vRP.hasPermission(user_id, "perm.policia") or
       vRP.hasPermission(user_id, "ilegal.permissao") then
        print("Usuário tem permissão.")

        local idPlayer = vRP.prompt(source, "Digite o ID:", "")
        if tonumber(idPlayer) then
            print("ID do jogador: " .. idPlayer)
            local nplayer = vRP.getUserSource(tonumber(idPlayer))
            if nplayer then
                print("Jogador encontrado.")
                vRP.setUData(tonumber(idPlayer), "vRP:prisao", json.encode(-1))   
                vRP.setUData(tonumber(idPlayer), "vRP:prisao:ADM", json.encode(-1))   

                Wait(500)
                
                print("Comando de liberação aplicado.")
                TriggerClientEvent("Notify", source, "sucesso", "Você soltou o jogador com sucesso.", 5000)
            else
                print("Jogador não encontrado. ID: " .. idPlayer)
                vRP.setUData(tonumber(idPlayer), "vRP:prisao", json.encode(-1))   
                vRP.setUData(tonumber(idPlayer), "vRP:prisao:ADM", json.encode(-1))   
            end
        else
            TriggerClientEvent("Notify", source, "importante", "Digite o id do player corretamente.", 5000)
        end
    else
        print("Usuário não tem permissão.")
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO ADM
--------------------------------------------------------------------------------------------------------------------------------------------------
-- AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
-- 	if source then
-- 		local value = vRP.getUData(parseInt(user_id),"vRP:prisao:ADM")
-- 		local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
-- 		local tempo = json.decode(value)
-- 		if tempo ~= nil then 
-- 			if tempo == nil then 
-- 				tempo = 7
-- 			end

-- 			if parseInt(tempo) > 0 then
-- 				TriggerClientEvent('prisaoADM',source,true)
-- 				vRPclient.teleport(source, 1678.6,2513.39,45.5)
-- 				prison_lock_adm(parseInt(user_id))
-- 			end
-- 		end
-- 	end
-- end)

function prison_lock_adm(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao:ADM")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent('chatMessage', player, 'PRISAO ADM', { 0, 0, 0 }, '^0Você Ainda vai passar ^5'..parseInt(tempo)..'m^0 preso.')
				vRP.setUData(parseInt(target_id),"vRP:prisao:ADM",json.encode(parseInt(tempo)-1))
				prison_lock_adm(parseInt(target_id))
				vRPclient._setHealth(player,300)
				vRP.setHunger(parseInt(target_id), 0)
				vRP.setThirst(parseInt(target_id), 0)
			elseif parseInt(tempo) == 0  or parseInt(tempo) == -1 then
				TriggerClientEvent('prisaoADM',player,false)
				vRPclient.teleport(player, 1847.94,2586.04,45.68)
				vRP.setUData(parseInt(target_id),"vRP:prisao:ADM",json.encode(-1))
			end
		end)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookURL = "https://discord.com/api/webhooks/1279019007847956490/-Xh2pwo5pwQNrfMIRmQEdtfDIkbF6rPdIZhvSDPwNfb6ounpfrTbkUS8vPfTqt_vBJL7" -- Substitua pelo URL do seu webhook

RegisterCommand('fix', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "ticket.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then
            TriggerClientEvent('reparar', source, vehicle)
            TriggerClientEvent("Notify", source, "sucesso", "Você fixou o veículo com sucesso.", 5000)

            local playerName = GetPlayerName(source)
            local logMessage = string.format("[FIX] %s consertou um veículo.", playerName)

            PerformHttpRequest(webhookURL, function(err, text, headers)
                if err == 200 then

                else

                end
            end, 'POST', json.encode({ content = logMessage }), { ['Content-Type'] = 'application/json' })
        end
    end
end)

-- RegisterCommand('reparar', function(source, args)
--     local user_id = vRP.getUserId(source)
--     if user_id then
--         if vRP.hasPermission(user_id, "mecanico.permissao") or vRP.hasPermission(user_id, "perm.mecanica") then
--             if vRP.checkPatrulhamento(user_id) then
--                 if not vRPclient.isInVehicle(source) then
--                     local vehicle = vRPclient.getNearestVehicle(source, 7)
--                     if vehicle then
--                         vRPclient._playAnim(source, false, {{"mini@repair", "fixing_a_player"}}, true)
--                         TriggerClientEvent("progress", source, 15) -- Barra de progresso
--                         vRP.blockCommands(user_id, 15) -- Bloqueia comandos por 15 segundos
--                         SetTimeout(15000, function()
--                             TriggerClientEvent("reparar", source, vehicle) -- Evento para reparar o veículo
--                             vRPclient._stopAnim(source, false) -- Para a animação
--                             TriggerClientEvent("Notify", source, "sucesso", "Você reparou o veículo.", 5000)
--                         end)
--                     else
--                         TriggerClientEvent("Notify", source, "negado", "Nenhum veículo encontrado nas proximidades.", 5000)
--                     end
--                 else
--                     TriggerClientEvent("Notify", source, "negado", "Você precisa estar fora do veículo para repará-lo.", 5000)
--                 end
--             else
--                 TriggerClientEvent("Notify", source, "negado", "Você precisa estar em serviço para usar este comando. Bate o ponto primeiro.", 5000)
--             end
--         else
--             TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para usar este comando.", 5000)
--         end
--     else
--         TriggerClientEvent("Notify", source, "negado", "Erro ao identificar o usuário.", 5000)
--     end
-- end)


RegisterCommand('reparar', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "perm.mecanica") then
        if vRP.checkPatrulhamento(user_id) then
            if not vRPclient.isInVehicle(source) then
                local vehicle = vRPclient.getNearestVehicle(source, 7)
                if vehicle then
                    TriggerClientEvent("fixvip:openHood", source, vehicle)

                    vRPclient._playAnim(source, false, {{"mini@repair", "fixing_a_player"}}, true)
                    TriggerClientEvent("progress", source, 15)
                    vRP.blockCommands(user_id, 15)

                    SetTimeout(15000, function()
                        TriggerClientEvent("reparar", source, vehicle)
                        vRPclient._stopAnim(source, false)

                        TriggerClientEvent("fixvip:closeHood", source, vehicle)

                        TriggerClientEvent("Notify", source, "sucesso", "Você reparou o veículo.", 5000)
                    end)
                else
                    TriggerClientEvent("Notify", source, "negado", "Nenhum veículo próximo encontrado.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Precisa estar próximo ou fora do veículo para efetuar os reparos.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você precisa estar em serviço para usar este comando. Bate o ponto primeiro.", 5000)
        end
    end
end)


RegisterCommand('fixvip', function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "perm.fixvip") then
        if not vRPclient.isInVehicle(source) then
            local vehicle = vRPclient.getNearestVehicle(source, 7)
            vRPclient._playAnim( source, false, {{"mini@repair", "fixing_a_player"}}, true )
            TriggerClientEvent("progress", source, 15)
            vRP.blockCommands(user_id, 15)
            SetTimeout(15000,function()
                TriggerClientEvent("reparar", source, vehicle)
                vRPclient._stopAnim(source, false)
                TriggerClientEvent( "Notify", source, "sucesso", "Você reparou o veiculo.", 5000 )
            end)
        else
            TriggerClientEvent( "Notify", source, "negado", "Precisa estar próximo ou fora do veículo para efetuar os reparos.", 5000 )
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS 2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local mensagem = ""
	--if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if user_id then

			--[[ STAFF ON ]]
			local admin = vRP.getUsersByPermission("ticket.permissao")
			local adminTotal = ""
			for k,v in pairs(admin) do
				adminTotal = adminTotal.. parseInt(v)..", "
			end
			if adminTotal == "" then adminTotal = "Nenhum(a)" end
			mensagem = mensagem.."<br><br> <b>👑 IDS de STAFFS em Serviço: </b>"..adminTotal

			--[[ STAFF FORA DE SERVICO ]]
			local adminFora = vRP.getUsersByPermission("staffoff.permissao")
			local adminForaTotal = ""
			for k,v in pairs(adminFora) do
				adminForaTotal = adminForaTotal.. parseInt(v)..", "
			end
			if adminForaTotal == "" then adminForaTotal = "Nenhum(a)" end
			mensagem = mensagem.."<br><b>👑 IDS de STAFFs fora de Serviço: </b>"..adminForaTotal

			--[[ POLICIAIS ]]
			local policiais = vRP.getUsersByPermission("perm.policia")
			local totalPolicia = ""
			for k,v in pairs(policiais) do
				totalPolicia = totalPolicia.. parseInt(v)..", "
			end
			if totalPolicia == "" then totalPolicia = "Nenhum(a)" end
			mensagem = mensagem.."<br><br> <b>👮 IDS de Policiais: </b>"..totalPolicia

			local totalPoliciaPtr = ""
			for k,v in pairs(policiais) do
				local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
				if patrulhamento then
					totalPoliciaPtr = totalPoliciaPtr.. parseInt(v)..", "
				end
			end
			if totalPoliciaPtr == "" then totalPoliciaPtr = "Nenhum(a)" end
			mensagem = mensagem.."<br> <b>👮 IDS de Policiais em PTR: </b>"..totalPoliciaPtr

			--[[ UNIZK ]]
			local unizk = vRP.getUsersByPermission("perm.unizk")
			local unizkTotal = ""
			for k,v in pairs(unizk) do
				unizkTotal = unizkTotal.. parseInt(v)..", "
			end
			if unizkTotal == "" then unizkTotal = "Nenhum(a)" end
			mensagem = mensagem.."<br><br> <b>⛑️ IDS de HOSPITAL CENTER: </b>"..unizkTotal

			local totalUnizkPtr = ""
			for k,v in pairs(unizk) do
				local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
				if patrulhamento then
					totalUnizkPtr = totalUnizkPtr.. parseInt(v)..", "
				end
			end
			if totalUnizkPtr == "" then totalUnizkPtr = "Nenhum(a)" end
			mensagem = mensagem.."<br> <b>⛑️ IDS do HOSPITAL CENTER  em PTR: </b>"..totalUnizkPtr

			--[[ MECANICO ]]
			local mec = vRP.getUsersByPermission("perm.mecanica")
			local mecTotal = ""
			for k,v in pairs(mec) do
				mecTotal = mecTotal.. parseInt(v)..", "
			end
			if mecTotal == "" then mecTotal = "Nenhum(a)" end
			mensagem = mensagem.."<br><br> <b>🔧 IDS DAS MECANICAS ONLINE: </b>"..mecTotal

			local totalMecPtr = ""
			for k,v in pairs(mec) do
				local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
				if patrulhamento then
					totalMecPtr = totalMecPtr.. parseInt(v)..", "
				end
			end
			if totalMecPtr == "" then totalMecPtr = "Nenhum(a)" end
			mensagem = mensagem.."<br> <b>🔧 IDS de MECANICOS em PTR: </b>"..totalMecPtr

			local onlinePlayers = GetNumPlayerIndices()
			mensagem = mensagem.."<br><br> <b>🏘️ Total de jogadores Online: </b>"..onlinePlayers

			TriggerClientEvent("Notify",source,"importante","<b>thunder City:</b>"..mensagem, 10000)
		--end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTICULAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pm',function(source,args,rawCommand)
    local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") then
		if args[1] then
			local mensagem = vRP.prompt(source,"Mensagem:","")
			if mensagem == "" then
				return
			end
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			
			if tplayer then
				TriggerClientEvent('chatMessage',tplayer,"(Privado Atendimento)",{5, 230, 255},mensagem)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpararea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		TriggerClientEvent("syncarea",-1,x,y,z)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Limpar Inventario
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearinv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        if args[1] then
			TriggerClientEvent("Notify", source, "sucesso", "Você limpou o inventario com sucesso.", 5000)
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRP.clearInventory(parseInt(args[1]))

                local logMessage = "O ID: "..user_id.." limpou o inventario do ID: "..args[1]
                vRP.sendLog("", logMessage)
                SendToWebhook(logMessage)
            end
        else
            vRP.clearInventory(user_id)

            local logMessage = "O ID: "..user_id.." limpou o inventario do ID: "..user_id
            vRP.sendLog("", logMessage)
            SendToWebhook(logMessage)
        end
    end
end)

function SendToWebhook(message)
    local webhookURL = "https://discord.com/api/webhooks/1279016737064489002/06_2iprfQUKwA24wkKD7czPegM7D3zGFW0m-kAGGX4CjeGxSSekMCp3eQfbM-xUhtV2m" 

    PerformHttpRequest(webhookURL, function(err, text, headers) 
        if err == 200 then
        else
        end
    end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or 
       vRP.hasPermission(user_id, "perm.god") or 
       vRP.hasPermission(user_id, "moderador.permissao") or 
       vRP.hasPermission(user_id, "suporte.permissao") or 
       vRP.hasPermission(user_id, "streamer.permissao") or 
       vRP.hasPermission(user_id, "perm.spawner") then
        if args[1] then
            TriggerClientEvent("Notify", source, "sucesso", "Você deu god no player com sucesso.", 5000)
            local nplayer = vRP.getUserSource(tonumber(args[1]))
            if nplayer then
                vRP.setHunger(tonumber(args[1]), 100)
                vRP.setThirst(tonumber(args[1]), 100)
                vRPclient._killGod(nplayer)
                vRPclient._setHealth(nplayer, 400)
                

                --vRPclient._teleport(nplayer, -436.5, -329.61, 34.91) -- cds onde o player volta quando da god
                
                vRP.sendLog("GOID", "O ID "..user_id.." usou o /god no ID "..tonumber(args[1]).."")
            end
        else
            vRPclient._killGod(source)
            vRPclient._setHealth(source, 400)
            vRP.sendLog("GOD", "O ID "..user_id.." usou o /god ")
            vRP.setHunger(user_id, 100)
            vRP.setThirst(user_id, 100)
            

            --vRPclient._teleport(source, -436.5, -329.61, 34.91) -- cds onde o player volta quando da god
            
            TriggerClientEvent("Notify", source, "sucesso", "Você se deu god com sucesso.", 5000)
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cuff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient._toggleHandcuff(nplayer)
			end
		else
			vRPclient._toggleHandcuff(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('capuz',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setCapuz(nplayer, false)
			end
		else
			vRPclient.setCapuz(source, false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasPermission(user_id,"perm.evento") or vRP.hasPermission(user_id,"ilegal.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient._setHealth(nplayer, 0)
				SetTimeout(1000, function()
					vRPclient._killComa(nplayer)
				end)

				vRP.sendLog("KILL", "O ID "..user_id.." usou o /kill no ID "..parseInt(args[1]).."")
			end
		else
			vRPclient._setHealth(source, 0)
			SetTimeout(1000, function()
				vRPclient._killComa(source)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('parall', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("nzk:giveParachute", -1)
		end
	end
end)

RegisterCommand('aadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.4); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 15%; right: 4%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: Administrador")
		vRP.log("logs/admin/aadm/aadm.txt", "O Admin [ID: "..user_id.." escreveu "..mensagem.."")
		SetTimeout(20000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('aa', function(source, args, raw)
	local text = string.sub(raw, 4)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
			local admin = vRP.getUsersByPermission("ticket.permissao")
			for l,w in pairs(admin) do
				local player = vRP.getUserSource(parseInt(w))
				vRPclient._playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent('chatMessage', player, '^7**ADMIN CHAT** ^1('..user_id..') diz:  '..text)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpall', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"developer.permissao") then
			local plyCoords = GetEntityCoords(GetPlayerPed(player))
            local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
			
			TriggerClientEvent("nzk:tpall", -1, x, y, z)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER DETENCAO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rdet', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			if tonumber(args[1]) and args[2] then
				vRP.execute("vRP/set_detido",{ user_id = tonumber(args[1]), vehicle = args[2], detido = 0})
				TriggerClientEvent('chatMessage', source, '^2Você removeu o veiculo '..args[2]..' do [ID: '..tonumber(args[1])..'] da detencao/retencao.')
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Deleta todos Carros
---------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearallveh', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent('chatMessage', -1, "^1ADMIN: ^0Contagem Iniciada ^260s^0 para limpeza de veiculos. (Entre em seu veiculo para não ser removido)")
			Wait(60000)

			local deleteCount = 0
			local entityList = {}
            for k,v in ipairs(GetAllVehicles()) do 
                local ped = GetPedInVehicleSeat(v, -1)
                if not ped or ped <= 0 then 
                    DeleteEntity(v)

					if GetEntityScript(v) ~= nil then
						if not entityList[GetEntityScript(v)] then entityList[GetEntityScript(v)] = 0 end
						entityList[GetEntityScript(v)] = entityList[GetEntityScript(v)] + 1
					end

                    deleteCount = deleteCount + 1
                end
            end

			print(json.encode(entityList, { indent = true }))
			TriggerClientEvent('chatMessage', -1, "^1ADMIN: ^0"..deleteCount.." veiculo deletados!")
		end
	end
end)

RegisterCommand('admincv', function(source, args, rawCommand)
	if source == 0 then
		local deleteCount = 0
		for k,v in ipairs(GetAllVehicles()) do 
			DeleteEntity(v)
			
			deleteCount = deleteCount + 1
		end

		TriggerClientEvent('chatMessage', -1, "^1ADMIN: ^0"..deleteCount.." veiculo deletados!")
	end
end)


RegisterCommand('clearallobj', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasPermission(user_id,"perm.evento") or vRP.hasPermission(user_id,"ilegal.permissao") then
			local deleteCount = 0
			local entityList = {}
			for k,v in ipairs(GetAllObjects()) do 
				DeleteEntity(v)

				if GetEntityScript(v) ~= nil then
					if not entityList[GetEntityScript(v)] then entityList[GetEntityScript(v)] = 0 end
					entityList[GetEntityScript(v)] = entityList[GetEntityScript(v)] + 1
				end

				deleteCount = deleteCount + 1
			end

			print(json.encode(entityList, { indent = true }))
			TriggerClientEvent('chatMessage', -1, "^1ADMIN: ^0"..deleteCount.." objetos deletados!")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			vRP.prompt(source, "Hash Veiculo: ", vTunnel.returnHashVeh(source,vehicle))
		end
	end
end)

RegisterCommand('schack',function(source,args,command)
	local user_id = vRP.getUserId(source)
	if(vRP.hasPermission(user_id,"player.noclip"))then
	  TriggerClientEvent("MQCU:getfodido",source)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET CHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRP.execute("vRP/set_controller",{ user_id = parseInt(args[1]), controller = 0, rosto = "{}", roupas = "{}" })
				vRP.kick(parseInt(args[1]),"\n[thunder] Você foi kickado \n entre novamente para fazer sua aparencia")
				TriggerClientEvent("Notify",source,"sucesso","Você resetou o ID - "..parseInt(args[1])..".", 8000)
			else
				vRP.execute("vRP/set_controller",{ user_id = parseInt(args[1]), controller = 0, rosto = "{}", roupas = "{}" })
				TriggerClientEvent("Notify",source,"sucesso","Você resetou o ID - "..parseInt(args[1])..".", 8000)
			end

			vRP.sendLog("RESETCHAR", "O ID: "..user_id.." usou o comando /rchar no ID: "..args[1])
		end
	end
end)

RegisterCommand('addcar', function(source, args)
    local user_id = vRP.getUserId(source)

    if user_id then -- Verifica se o user_id foi obtido corretamente
        if vRP.hasPermission(user_id, "developer.permissao") then
            if args[1] and args[2] then -- Verifica se os argumentos necessários foram passados
                local veiculo = args[1]
                local target_id = tonumber(args[2]) -- Converte para número para evitar problemas de tipo
                if target_id then
                    local placa = vRP.gerarPlaca()
                    vRP.execute("vRP/inserir_veh", {
                        veiculo = veiculo,
                        user_id = target_id,
                        placa = placa,
                        ipva = os.time(),
                        expired = "{}"
                    })
                    TriggerClientEvent("Notify", source, "sucesso", "Veículo adicionado na garagem", 8000)
                    vRP.sendLog("ADDCARRO", "O ID " .. user_id .. " adicionou o carro " .. veiculo .. " na garagem do ID: " .. target_id)
                else
                    TriggerClientEvent("Notify", source, "erro", "ID do usuário inválido.", 8000)
                end
            else
                TriggerClientEvent("Notify", source, "erro", "Parâmetros insuficientes. Use /addcar [veículo] [ID do jogador].", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "erro", "Você não tem permissão para usar este comando.", 8000)
        end
    else
        TriggerClientEvent("Notify", source, "erro", "ID do usuário não encontrado.", 8000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rrcity', function(source,args)
	--os.exit()
	if source > 0 then return end
	--os.exit()
	print("^2Salvando Contas... Aguarde!")
	
	rrcity = true
	local contador = 0
	--os.exit()
	
	for _, v in pairs(GetPlayers()) do
		vRP.kick(v,"Reiniciando a Cidade!")
		contador = contador + 1
	end

	print("^2Contas Salvas: ^0"..contador)
	TriggerEvent("saveInventory")
	--os.exit()
end)


Citizen.CreateThread(function()
    while true do
        local hora = os.date("%H:%M")
        local reinicio1 = "04:30"
        local reinicio2 = "17:55"

        local proximoReinicio = nil
        if hora == reinicio1 then
            proximoReinicio = reinicio1
        elseif hora == reinicio2 then
            proximoReinicio = reinicio2
        end

        if proximoReinicio then
            iniciarReinicio()
        end

        Citizen.Wait(60000) -- Verifica a cada 1 minuto, o que é mais leve
    end
end)


function iniciarReinicio()
    print("Terremoto em 5 minutos - Notificações iniciadas.")
    for i = 5, 1, -1 do
        TriggerClientEvent("Notify", -1, "importante", "Terremoto em " .. i .. " minuto(s)", 60000)
        print("Notificação: Terremoto em " .. i .. " minuto(s)")
        Wait(60000) 
    end

    print("VOU DAR RR AGORA")

    local users = vRP.getUsers()
    for k, v in pairs(users) do
        local id = vRP.getUserSource(tonumber(k))
        if id then
            print("Expulsando usuário: " .. k)
            vRP.kick(id, "Reinicialização do servidor concluída.\nReinicie seu FiveM e entre novamente na cidade.")
        end
    end
    
    os.execute("start C:\\Users\\Administrator\\Desktop\\FoxzinV3\\start.bat +exec server.cfg")
    
    Wait(1000)
    os.exit()
end


RegisterCommand("forcarr", function()
    iniciarReinicio()
end, false)



-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehtuning',source,vehicle)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wladd', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then
            local target_id = tonumber(args[1])
            if target_id then
                exports.oxmysql:scalar("SELECT id FROM vrp_users WHERE id = ?", {target_id}, function(result)
                    if result then
                        exports.oxmysql:execute("UPDATE vrp_users SET whitelist = 1 WHERE id = ?", {target_id})
                        vRP.sendLog("WL", "O ID " .. user_id .. " adicionou o ID " .. target_id .. " na whitelist.")
                        TriggerClientEvent("Notify", source, "sucesso", "Você aprovou o ID " .. target_id .. " na whitelist!", 8000)
                    else
                        TriggerClientEvent("Notify", source, "erro", "ID não encontrado!", 8000)
                    end
                end)
            else
                TriggerClientEvent("Notify", source, "erro", "ID inválido!", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "erro", "Você deve fornecer um ID!", 8000)
        end
    else
        TriggerClientEvent("Notify", source, "erro", "Você não tem permissão para usar este comando!", 8000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wlrem', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        if args[1] then
            local target_id = tonumber(args[1])
            if target_id then
                exports.oxmysql:scalar("SELECT id FROM vrp_users WHERE id = ?", {target_id}, function(result)
                    if result then
                        exports.oxmysql:execute("UPDATE vrp_users SET whitelist = 0 WHERE id = ?", {target_id})
                        vRP.sendLog("WL", "O ID " .. user_id .. " removeu o ID " .. target_id .. " da whitelist.")
                        TriggerClientEvent("Notify", source, "sucesso", "Você removeu o ID " .. target_id .. " da whitelist!", 8000)
                    else
                        TriggerClientEvent("Notify", source, "erro", "ID não encontrado!", 8000)
                    end
                end)
            else
                TriggerClientEvent("Notify", source, "erro", "ID inválido!", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "erro", "Você deve fornecer um ID!", 8000)
        end
    else
        TriggerClientEvent("Notify", source, "erro", "Você não tem permissão para usar este comando!", 8000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- renomear
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('renomear',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"developer.permissao") then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local nome = vRP.prompt(source, "Novo nome", "")
        local firstname = vRP.prompt(source, "Novo sobrenome", "")
        local idade = vRP.prompt(source, "Nova idade", "")
        local identity = vRP.getUserIdentity(parseInt(idjogador))
        vRP.execute("vRP/update_user_identity",{
            user_id = idjogador,
            sobrenome = firstname,
            nome = nome,
            idade = idade,
            registro = identity.registro,
            telefone = identity.telefone
        })
		TriggerClientEvent("Notify",source,"sucesso","Você renomeou o nome com sucesso. Informe o mesmo para aguardar até o próximo rr da cidade para modificação ser aplicada.", 8000)
		vRP.sendLog("RENOMEAR", "O ID "..user_id.." renomeou o id "..idjogador)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- rg2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
        local nuser_id = parseInt(args[1])
        local identity = vRP.getUserIdentity(nuser_id)
        local bankMoney = vRP.getBankMoney(nuser_id)
        local walletMoney = vRP.getMoney(nuser_id)
        local sets = json.decode(vRP.getUData(nuser_id,"vRP:datatable")) or {}
		local multas = vRP.getMultas(nuser_id) or 0
		local consulta = vRP.getSData("ZoPorte:" .. nuser_id) 
		local resultado = json.decode(consulta) or {}
		resultado.possui = resultado.possui or 0
		local porteArma = "Não Possui"
		if resultado.possui == 1 then
			porteArma = "Sim Possui"
		end
              
        if args[1] then
           TriggerClientEvent("Notify",source,"sucesso","ID: <b>"..parseInt(nuser_id).."</b><br>Nome: <b>"..identity.nome.." "..identity.sobrenome.."</b><br>Idade: <b>"..identity.idade.."</b><br>Telefone: <b>"..identity.telefone.."</b><br>Carteira: <b>"..vRP.format(parseInt(walletMoney)).."</b><br>Banco: <b>"..vRP.format(parseInt(bankMoney)).."</b><br>Sets: <b>"..string.gsub(json.encode(sets.groups), ",", ", ").."</b><br>Multas: <b>"..vRP.format(multas).."</b><br>Porte de Arma: <b>"..porteArma.."</b>", 8000)    
        else
            TriggerClientEvent("Notify",source,"negado","Digite o ID desejado!")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESEMPREGADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('desempregados', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		local listPlys = ""
		local count_plys = 0
		for _,playerId in pairs(GetPlayers()) do
			local plyId = vRP.getUserId(playerId)

			if plyId then
				local org = vRP.getUserGroupByType(plyId, "org")
				if org == "" then
					count_plys = count_plys + 1
					listPlys = listPlys.. plyId..", "
				end
			end
		end

		TriggerClientEvent("Notify",source,"importante","<b>thunder City:</b><br>Total Desempregados: "..count_plys.."<br><br>IDS Desempregados: "..listPlys, 8000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCSDESEMPREGADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('locdesempregados', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id, "admin.permissao") then return end
		
		local status, time = exports['vrp']:getCooldown(user_id, "locdesempregados")
		if status then
			exports['vrp']:setCooldown(user_id, "locdesempregados", 60)

			local Plys = {}
			for _,playerId in pairs(GetPlayers()) do
				local plyId = vRP.getUserId(playerId)

				if plyId then
					local org = vRP.getUserGroupByType(plyId, "org")
					if org == "" then
						Plys[#Plys + 1] = GetEntityCoords(GetPlayerPed(playerId))
					end
				end
			end

			vTunnel._SetUnemployed(source, Plys)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RDESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("updatestatusvec", "UPDATE vrp_user_veiculos SET status = @status WHERE user_id = @user_id AND veiculo = @veiculo")
RegisterCommand('rdesmanche',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") then
		if args[1] then
			local query = vRP.query("bm_module/thunder_garages/getAllUserVehicles", { user_id = tonumber(args[1]) })

			local t = {}
			local formatVehs
			if #query > 0 then
				formatVehs = ""

				for k in pairs(query) do
					local class = exports["thunder_garages"]:getVehicleType(query[k].veiculo)
					if class ~= nil then
						t[query[k].veiculo:lower()] = query[k].veiculo
						formatVehs = formatVehs ..query[k].veiculo..","
					end
				end
			end

			if formatVehs == nil then
				TriggerClientEvent("Notify",source,"negado","Você não possui nenhum veiculo", 8000)
				return
			end

			local selectedVehicle = vRP.prompt(source, "Escolha o veiculo para remover o desmanche!", formatVehs)
			if formatVehs == "" or formatVehs == nil then
				TriggerClientEvent("Notify",source,"negado","Digite o nome do veiculo corretamente.", 8000)
				return
			end

			selectedVehicle = selectedVehicle:lower()
			if not t[selectedVehicle] then
				TriggerClientEvent("Notify",source,"negado","Veiculo não encontrado na garagem..", 8000)
				return
			end
			local vehName = exports["thunder_garages"]:getVehicleName(t[selectedVehicle])

			--vRP.execute("vRP/set_status",{ user_id = args[1], veiculo = vehName, status = 0})
			vRP._execute("updatestatusvec", { status = 0, user_id = args[1], veiculo = vehName })
			TriggerClientEvent("Notify",source,"sucesso","Retenção/Detido do veículo removida com sucesso!", 8000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"developer.permissao") then
        if args[1] then
            local amount = parseInt(args[1])
            vRP.giveMoney(user_id, amount)
            TriggerClientEvent("Notify", source, "sucesso", "Você spawnou <b>$"..amount.."</b> com sucesso!", 8000)
            vRP.sendLog("MONEY", "O ID "..user_id.." usou o /money na quantidade de "..amount.."")
        else
            TriggerClientEvent("Notify", source, "negado", "Você precisa informar uma quantidade válida!", 8000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE ITEM PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('itemp',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasPermission(user_id,"perm.evento") or vRP.hasPermission(user_id,"ilegal.permissao") then
		if args[1] and args[2] and args[3] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				TriggerClientEvent('chatMessage', source, "(ID: "..parseInt(args[1])..") Você givou o Item: "..args[2].." "..parseInt(args[3]).."x", {0, 170, 255})
				vRP.giveInventoryItem(parseInt(args[1]),""..args[2].."",parseInt(args[3]), true)
				vRP.sendLog("ITEM", "O STAFF ["..user_id.."] givou o item "..args[2].." na quantidade de "..args[3].." x para o ID ["..args[1].."]")
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"streamer.permissao") or vRP.hasPermission(user_id,"perm.spawner") then
		vRPclient._toggleNoclip(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		
		vRPclient._teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

		vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z))
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CDS2
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasGroup(user_id,"suporte") then
		local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cdsh',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

		vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z)..","..tD(vTunnel.myHeading(source)))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('debug', function(source, args, rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id ~= nil then
-- 		local player = vRP.getUserSource(user_id)
-- 		if vRP.hasPermission(user_id,"admin.permissao") then
-- 			TriggerClientEvent("NZK:ToggleDebug", player)
-- 		end
-- 	end
-- end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Combustível
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fuel',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("admfuel",source)
		end	
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('groupadd',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") then
		if args[1] and args[2] then
			if vRP.hasPermission(user_id,"developer.permissao") and args[2] == "owner" then
				return true
			end
			local nsource = vRP.getUserSource(parseInt(args[1]))
			if nsource then
				vRP.addUserGroup(parseInt(args[1]),args[2])
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
				vRP.sendLog("GROUPADD", "O ID "..user_id.." usou o setou "..parseInt(args[1]).." no grupo "..args[2].."")
			else
				local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
				if #rows > 0 then
					local data = json.decode(rows) or {}
					if data then
						if data then
							data.groups[args[2]] = true
						end
					end

					vRP.setUData(parseInt(args[1]),"vRP:datatable",json.encode(data))
					TriggerClientEvent("Notify",source,"sucesso","** OFFLINE ** Você adicionou o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
					vRP.sendLog("GROUPADD", "O ID "..user_id.." usou o setou "..parseInt(args[1]).." no grupo "..args[2].."")
				end
			end
		end
	end
end)

RegisterCommand('setdev',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") then
		if args[1] and args[2] then
			if not user_id == 1 then
				return true
			end
			local nsource = vRP.getUserSource(parseInt(args[1]))
			if nsource then
				vRP.addUserGroup(parseInt(args[1]),args[2])
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
				vRP.sendLog("GROUPADD", "O ID "..user_id.." usou o setou "..parseInt(args[1]).." no grupo "..args[2].."")
			else
				local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
				if #rows > 0 then
					local data = json.decode(rows) or {}
					if data then
						if data then
							data.groups[args[2]] = true
						end
					end

					vRP.setUData(parseInt(args[1]),"vRP:datatable",json.encode(data))
					TriggerClientEvent("Notify",source,"sucesso","** OFFLINE ** Você adicionou o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
					vRP.sendLog("GROUPADD", "O ID "..user_id.." usou o setou "..parseInt(args[1]).." no grupo "..args[2].."")
				end
			end
		end
	end
end)

RegisterCommand('foxzin',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	--if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasPermission(user_id,"perm.evento") or vRP.hasPermission(user_id,"ilegal.permissao") then
		if args[1] and args[2] then
			if not user_id == 1 then
				return true
			end
			local nsource = vRP.getUserSource(parseInt(args[1]))
			if nsource then
				vRP.addUserGroup(parseInt(args[1]),args[2])
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
				vRP.sendLog("GROUPADD", "O ID "..user_id.." usou o setou "..parseInt(args[1]).." no grupo "..args[2].."")
			else
				local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
				if #rows > 0 then
					local data = json.decode(rows) or {}
					if data then
						if data then
							data.groups[args[2]] = true
						end
					end

					vRP.setUData(parseInt(args[1]),"vRP:datatable",json.encode(data))
					TriggerClientEvent("Notify",source,"sucesso","** OFFLINE ** Você adicionou o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
					vRP.sendLog("GROUPADD", "O ID "..user_id.." usou o setou "..parseInt(args[1]).." no grupo "..args[2].."")
				end
			end
		end
	--end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GROUPREM
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('grouprem',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") then
		if args[1] and args[2] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			if nsource then
				vRP.removeUserGroup(parseInt(args[1]),args[2])

				TriggerClientEvent("Notify",source,"negado","Você removeu o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
				vRP.sendLog("GROUPREM", "O ID "..user_id.." removeu o grupo "..args[2].." do id "..args[1].."")
			else
				local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
				if #rows > 0 then
					local data = json.decode(rows) or {}
					if data then
						if data then
							data.groups[args[2]] = nil
						end
					end

					vRP.setUData(parseInt(args[1]),"vRP:datatable",json.encode(data))
					TriggerClientEvent("Notify",source,"negado","** OFFLINE ** Você removeu o <b>(ID: "..parseInt(args[1])..")</b> no grupo: <b>"..args[2].."</b>", 8000)
					vRP.sendLog("GROUPREM", "O ID "..user_id.." removeu o grupo "..args[2].." do id "..args[1].."")
				end
			end
		end
	end
end)

RegisterCommand('removeallgroups', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        if args[1] and tonumber(args[1]) then
            local target_id = tonumber(args[1])
            local nsource = vRP.getUserSource(target_id)
			TriggerClientEvent("Notify", source, "sucesso", "Você removeu o <b>(ID: "..target_id..")</b> de todos os grupos", 8000)
			vRP.sendLog("GROUPREM", "O ID "..user_id.." removeu todos os grupos do ID "..target_id)
            local function removeAllGroups(user_id)
                local rows = vRP.getUData(user_id, "vRP:datatable")
                if #rows > 0 then
                    local data = json.decode(rows) or {}
                    if data and data.groups then
                        for group, _ in pairs(data.groups) do
                            data.groups[group] = nil
                        end
                        vRP.setUData(user_id, "vRP:datatable", json.encode(data))
                        return true
                    end
                end
                return false
            end

            if nsource then
                local groups = vRP.getUserGroups(target_id)
                for group, _ in pairs(groups) do
                    vRP.removeUserGroup(target_id, group)
                end
                TriggerClientEvent("Notify", source, "sucesso", "Você removeu o <b>(ID: "..target_id..")</b> de todos os grupos", 8000)
                vRP.sendLog("GROUPREM", "O ID "..user_id.." removeu todos os grupos do ID "..target_id)
            else
                if removeAllGroups(target_id) then
                    TriggerClientEvent("Notify", source, "sucesso", "** OFFLINE ** Você removeu o <b>(ID: "..target_id..")</b> de todos os grupos", 8000)
                    vRP.sendLog("GROUPREM", "O ID "..user_id.." removeu todos os grupos do ID "..target_id)
                else
                    TriggerClientEvent("Notify", source, "negado", "Erro ao processar dados do usuário!", 8000)
                end
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Parâmetros inválidos!", 8000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para usar este comando!", 8000)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('display',function(source,args,rawCommand)
	local custom = vRPclient.getCustomization(source,{})
	if custom then
		if player_customs[source] then
			player_customs[source] = nil
			vRPclient._removeDiv(source,"customization")
		else
			local content = ""
			for k,v in pairs(custom) do
				content = content..k.." => "..json.encode(v).."<br />"
			end

			player_customs[source] = true
			vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local plyCoords = GetEntityCoords(GetPlayerPed(source))
            local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
			
			if tplayer then
				vRPclient._teleport(tplayer,x,y,z)

				vRP.sendLog("TPTOME", "O ID "..user_id.." puxou o id "..parseInt(args[1]))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient._teleport(source,vRPclient.getPosition(tplayer))

				vRP.sendLog("TPTO", "O ID "..user_id.." teleportou ate o id "..parseInt(args[1]))
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		TriggerClientEvent('tptoway',source)

		vRP.sendLog("TPWAY", "O ID "..user_id.." usou o /tpway")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.spawner") then
		if args[1] then
			TriggerClientEvent('spawnarveiculopp',source,args[1])
			vRP.sendLog("SPAWNCAR", "O ID "..user_id.." spawnou o veiculo "..args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Copy Preset
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('copypreset',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if tonumber(args[1]) then
			local nsource = vRP.getUserSource(tonumber(args[1]))
			if nsource then
				local ncustom = vRPclient.getCustomization(nsource, {})
				vRPclient._setCustomization(source, ncustom)
				vRP.sendLog("COPYPRESET", "O Admin "..user_id.. " copiou as customização do id "..tonumber(args[1]))
			else
				TriggerClientEvent("Notify",source,"negado","Este ID não se encontra online no momento.", 8000)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Set Preset
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setpreset',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if tonumber(args[1]) then
			local nsource = vRP.getUserSource(tonumber(args[1]))
			if nsource then
				local custom = vRPclient.getCustomization(source, {})
				vRPclient._setCustomization(nsource, custom)
				vRP.sendLog("SETPRESET", "O Admin "..user_id.. " setou as customização dele no id "..tonumber(args[1]))
			else
				TriggerClientEvent("Notify",source,"negado","Este ID não se encontra online no momento.", 8000)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end

		if mensagem then
			TriggerClientEvent('Notify', -1,'aviso', mensagem.. " Enviado: Prefeitura.", 20000)

			vRP.sendLog("AADM", "O ADMIN "..user_id.." ANUNCIOU "..mensagem)
		end
	end
end)

RegisterCommand('mecanuncio',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mecanico.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end

		if mensagem then
			TriggerClientEvent('Notify', -1,'aviso', mensagem.. " Enviado: Mecanica.", 20000)

			vRP.sendLog("AADM", "O ADMIN "..user_id.." ANUNCIOU "..mensagem)
		end
	end
end)

RegisterCommand('hpanuncio',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"perm.unizk") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end

		if mensagem then
			TriggerClientEvent('Notify', -1,'aviso', mensagem.. " Enviado: hospital.", 20000)

			vRP.sendLog("AADM", "O ADMIN "..user_id.." ANUNCIOU "..mensagem)
		end
	end
end)

RegisterCommand('adm2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end

		if mensagem then
			TriggerClientEvent('Notify', -1,'aviso', mensagem.. " Enviado: "..identity.nome.." "..identity.sobrenome..".", 20000)

			vRP.sendLog("AADM", "O ADMIN "..user_id.." ANUNCIOU "..mensagem)
		end
	end
end)

RegisterCommand("ar", function(source,args,rawCommand)
	if source == 0 then
		vRPclient._setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 40%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; word-wrap: break-word; } bold { font-size: 16px; }","<bold>".. rawCommand:sub(3) .."</bold><br><br>Mensagem enviada por: Administrador")
		SetTimeout(60*1000,function()
			vRPclient._removeDiv(-1,"anuncio")
		end)
	end
	print(rawCommand:sub(3))
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR QUEM ENTRA SEM ID
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("checkbugados",function(source) 
    local source = source; 
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then 
        local message = ""
        for _,v in ipairs(GetPlayers()) do 
            local pName = GetPlayerName(v)
            local uId = vRP.getUserId(tonumber(v))
            if not uId then 
                message = message .. string.format("</br> <b>%s</b> | Source: <b>%s</b> | Ready: %s",pName,v,((Player(v).state.ready) and 'Sim' or 'Não'))
            end
        end
        TriggerClientEvent("Notify",source,"sucesso",((message ~= "") and message or "Sem usuários bugados no momento!"))
    end
end)

RegisterCommand("kicksrc",function(source, args) 
    local source = source; 
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then 
        if #args > 0 and tonumber(args[1]) and tonumber(args[1]) > 0 then 
            DropPlayer(tonumber(args[1]),"Você foi expulso da cidade pelo administrador "..user_id)
        end
    end
end)

RegisterCommand("hackperma",function(source, args) 
    local source = source; 
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then 
        if #args > 0 and tonumber(args[1]) and tonumber(args[1]) > 0 then 
            TriggerClientEvent("_____get",tonumber(args[1]),true)
            Wait(1000)
            DropPlayer(tonumber(args[1]),"Você foi banido pelo usuário "..user_id)
        end
    end
end)

RegisterCommand("tptosrc",function(source, args) 
    local source = source; 
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then 
        if #args > 0 and tonumber(args[1]) and tonumber(args[1]) > 0 then 
            local playerCoords = GetEntityCoords(GetPlayerPed(tonumber(args[1])))
            if playerCoords.x ~= 0.0 then 
                SetEntityCoords(GetPlayerPed(source),playerCoords)
            end
        end
    end
end)

RegisterCommand("kickbugados",function(source) 
    local source = source; 
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then 
        local message = ""
        for _,v in ipairs(GetPlayers()) do 
            local pName = GetPlayerName(v)
            local uId = vRP.getUserId(tonumber(v))
            if not uId then 
                message = message .. string.format("</br> (Kickado) <b>%s</b> | Source: <b>%s</b>",pName,v)
                DropPlayer(v,"Você foi kikado por estar bugado!")
            end
        end
        TriggerClientEvent("Notify",source,"sucesso",((message ~= "") and message or "Sem usuários bugados no momento!"))
    end
end)

RegisterCommand('kitadm', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
	vRPclient._giveWeapons(source, { ["WEAPON_PISTOL_MK2"] = {ammo= 250} }, true)
	vRPclient._giveWeapons(source, { ["WEAPON_SPECIALCARBINE_MK2"] = {ammo= 250} }, true)
	vRP.giveInventoryItem(user_id,'radio',1)
	vRP.giveInventoryItem(user_id,'celular',1)
	vRP.giveInventoryItem(user_id,'roupa',1)
	vRP.giveInventoryItem(user_id,'bandagem',1)
	vRP.giveInventoryItem(user_id,'mochila',1)
	TriggerClientEvent("Notify",source,"sucesso","Você equipou o KIT DE ARMAS thunder.", 8000)
	vRP.sendLog("KITMALOKERO", "O ID "..user_id.." adicionou o kit dos maloka.")
	end
end)

RegisterCommand('kitmec', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mecanico.permissao") then
	vRPclient._giveWeapons(source, { ["WEAPON_STUNGUN"] = {ammo= 250} }, true)
	vRP.giveInventoryItem(user_id,'radio',1)
	vRP.giveInventoryItem(user_id,'celular',1)
	TriggerClientEvent("Notify",source,"sucesso","Você equipou o KIT DE MECANICO.", 8000)
	vRP.sendLog("KITMEC", "O ID "..user_id.." adicionou o kit dos Mecanicos.")
	end
end)


RegisterCommand('imortaladm', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        SetPlayerInvincible(source, true)
        TriggerClientEvent("Notify", source, "sucesso", "Você agora está imortal.", 8000)
        vRP.sendLog("IMORTALADMIN", "O ID " .. user_id .. " tornou-se imortal.")
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- DERRUBAR JOGADOR NO CHAO
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ney',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id,"developer.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                if nplayer then
                    TriggerClientEvent('derrubarwebjogador',nplayer,args[1])
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- CAR SEAT
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('carseat',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        TriggerClientEvent('SetarDentroDocarro',source)
    end
end)

RegisterCommand('efeitos', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "admin.permissao") then
			local effect = vRP.prompt(source, "Digite o efeito", "")

			vRPclient._playScreenEffect(source, effect, 5)
		end
	end
end)

RegisterCommand("forcedelete",function(source)
	local source = source 
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local plyCoords = GetEntityCoords(GetPlayerPed(source))
		for k,v in ipairs(GetAllObjects()) do 
			if #(GetEntityCoords(v) - plyCoords) < 150.0 then 
				print(GetEntityModel(v))
				DeleteEntity(v)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOP MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("mirtin/topMoney", "SELECT nome,sobrenome,user_id,banco FROM vrp_user_identities ORDER BY banco DESC LIMIT 20;")
RegisterCommand('topmoney',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "admin.permissao") then
			local query = vRP.query("mirtin/topMoney", {})
			if #query > 0 then
				local mensagem = ""
				local i = 0

				for k in pairs(query) do
					mensagem = mensagem.. " "..k.."º ["..query[k].user_id.."] - ("..query[k].nome.." " ..query[k].sobrenome..") ("..vRP.format(query[k].banco)..")<br>"
				end

				TriggerClientEvent("Notify",source, "importante",mensagem, 8000)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR cor
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"developer.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source,7)
        if vehicle then
            local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
            rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
            local r,g,b = table.unpack(splitString(rgb," "))
            TriggerClientEvent('vcolorv',source,vehicle,tonumber(r),tonumber(g),tonumber(b))
            
            TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Cor ^1alterada")
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnelcheckOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return true
	end
end

function RegisterTunnelpayment(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if valor == 0 then
			valor = 50
		end
		
		if vRP.tryFullPayment(user_id, tonumber(valor)) then
			TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..vRP.format(parseInt(valor)).." </b> em roupas e acessórios.",8000)
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.",8000)
		end
	end
end

RegisterCommand('oculos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "oculos", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('chapeu', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "chapeu", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('sapatos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "sapato", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('maos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "mao", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('colete', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "colete", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('jaqueta', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "jaqueta", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('mascara', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "mascara", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('acessorio', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "acessorio", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('blusa', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "blusa", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('calca', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			vTunnel.updateClothes(source, "calca", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('dm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    
    if vRP.hasPermission(user_id,"admin.permissao") then
        
        local staff = source
        
        local idPlayer = vRP.prompt(staff, "Digite o ID:", "")
        local Mensagem = vRP.prompt(staff, "Digite a mensagem:", "")
        
        if tonumber(idPlayer) ~= nil and tonumber(idPlayer) ~= 0 and Mensagem ~= nil then
            local staff_identity = vRP.getUserIdentity(tonumber(idPlayer))
            local identity = vRP.getUserIdentity(tonumber(idPlayer))
            if identity then
                local cliente = vRP.getUserSource(tonumber(idPlayer))
                
                TriggerClientEvent("vrp_sound:source", cliente, "mic_click_on", 0.5)
                
                TriggerClientEvent("Notify",cliente, "aviso","<b>MENSAGEM DE UM STAFF!</b><br><b>Staff: ["..user_id.."]: "..staff_identity.nome.."</b><br><br>"..Mensagem, 8000)
                TriggerClientEvent("Notify",staff, "sucesso","<b>Enviado:</b> "..Mensagem, 8000)
                
                if vRP.request(cliente, "Responder a mensagem?: "..Mensagem, 120) then
                    local Mensagem = vRP.prompt(cliente, "Digite a mensagem:", "")
                    if Mensagem then
                        ResponderStaff(staff,cliente,idPlayer,user_id,Mensagem)
                    end
                else
                    TriggerClientEvent("Notify",staff, "negado","Cidadão negou/não leu a mensagem.", 8000)
                end
            else
                TriggerClientEvent("Notify",source, "negado","ID informado inválido.", 8000)
            end
        else
            TriggerClientEvent("Notify",source, "importante","Verifique os dados digitados.", 8000)
        end
        
    end
    
end)

function ResponderStaff(staff,cliente,idPlayer,staff_id,Mensagem)
    
    local cliente_identity = vRP.getUserIdentity(tonumber(idPlayer))
    
    TriggerClientEvent("Notify",staff, "aviso","<b>MENSAGEM RESPONDIDA!</b><br><b>Cidadão: ["..idPlayer.."]: "..cliente_identity.nome.."</b><br><br>"..Mensagem, 8000)
    TriggerClientEvent("Notify",cliente, "sucesso","<b>Enviado:</b> "..Mensagem, 8000)
    
    TriggerClientEvent("vrp_sound:source", staff, "mic_click_on", 0.5)
    
    if vRP.request(staff, "[DM] ["..idPlayer.."]: "..cliente_identity.nome..": ("..Mensagem..") - Deseja responder?", 60) then
        local Mensagem = vRP.prompt(staff, "Digite a mensagem:", "")
        if Mensagem then
            ResponderCliente(staff,cliente,idPlayer,staff_id,Mensagem)
        end
    end
end

function ResponderCliente(staff,cliente,idPlayer,staff_id,Mensagem)
    
    local staff_identity = vRP.getUserIdentity(staff_id)
    
    TriggerClientEvent("Notify",cliente, "aviso","<b>MENSAGEM DE UM STAFF!</b><br><b>Staff: ["..staff_id.."]: "..staff_identity.nome.."</b><br><br>"..Mensagem, 8000)
    TriggerClientEvent("Notify",staff, "sucesso","<b>Enviado:</b> "..Mensagem, 5)
    
    TriggerClientEvent("vrp_sound:source", cliente, "mic_click_on", 0.5)
    
    if vRP.request(cliente, "[DM] ["..staff_id.."]: "..staff_identity.nome..": ("..Mensagem..") - Deseja responder?", 60) then
        local Mensagem = vRP.prompt(cliente, "Respondendo DM ("..staff_id..") - "..staff_identity.nome..":", "")
        if Mensagem then
            ResponderStaff(staff,cliente,idPlayer,staff_id,Mensagem)
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DV AREA
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dvall', function(a,b)
    user_id = vRP.getUserId(a)
    if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasPermission(user_id,"perm.evento") or vRP.hasPermission(user_id,"ilegal.permissao") then
        if tonumber(b[1]) then
            local vehicles = vRPclient.getNearestVehicles(a,tonumber(b[1]))
            for k,v in pairs(vehicles) do
                TriggerClientEvent('deleteVeh', a, k)
            end
            TriggerClientEvent('Notify',a, 'sucesso', '<b>Você deletou '.. tablelen(vehicles) ..'x veículos')
        else
            TriggerClientEvent('Notify',a, 'negado', 'Comando dado de forma incorreta, use a estrutura /dvall [raio]')
        end
    else
        TriggerClientEvent('Notify', a,'negado', 'Sem permissão!')
    end
end)

function tablelen(a)
    num = 0
    for k,v in pairs(a) do
        num = num + 1
    end
    return num
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONE POLICIA OBJETOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('addbarreira', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.policia") then
			TriggerClientEvent('barreira:b',source)
		else
			TriggerClientEvent("Notify",source, "negado","Sem permissao para utilizar esse comando!", 8000)
		end
	end
end)

RegisterCommand('addbarreira2', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.policia") then
			TriggerClientEvent('barreira2:b',source)
		else
			TriggerClientEvent("Notify",source, "negado","Sem permissao para utilizar esse comando!", 8000)
		end
	end
end)


RegisterCommand('addcone', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.policia") then
			TriggerClientEvent('cone:a',source)
		else
			TriggerClientEvent("Notify",source, "negado","Sem permissao para utilizar esse comando!", 8000)
		end
	end
end)

RegisterCommand('addpneu', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.policia") then
			TriggerClientEvent('spike:b',source)
		else
			TriggerClientEvent("Notify",source, "negado","Sem permissao para utilizar esse comando!", 8000)
		end
	end
end)

RegisterCommand('dellcone', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.policia") then
            local deleteCount = 0
            local entityList = {}
            local playerPed = GetPlayerPed(source)
            local playerCoords = GetEntityCoords(playerPed)
            local objects = GetAllObjects()
            
            for k,v in ipairs(objects) do
                local objectCoords = GetEntityCoords(v)
                local distance = #(playerCoords - objectCoords) -- Calcula a distância entre o jogador e o objeto

                if distance <= 2.0 then -- Verifica se o objeto está dentro do raio de 10 metros
                    DeleteEntity(v)

                    if GetEntityScript(v) ~= nil then
                        if not entityList[GetEntityScript(v)] then entityList[GetEntityScript(v)] = 0 end
                        entityList[GetEntityScript(v)] = entityList[GetEntityScript(v)] + 1
                    end

                    deleteCount = deleteCount + 1
                end
            end

            print(json.encode(entityList, { indent = true }))
            TriggerClientEvent('chatMessage', -1, "^1ADMIN: ^0"..deleteCount.." cone deletado!")
        end
    end
end)

RegisterCommand('dellbarreira', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.policia") then
            local deleteCount = 0
            local entityList = {}
            local playerPed = GetPlayerPed(source)
            local playerCoords = GetEntityCoords(playerPed)
            local objects = GetAllObjects()
            
            for k,v in ipairs(objects) do
                local objectCoords = GetEntityCoords(v)
                local distance = #(playerCoords - objectCoords) -- Calcula a distância entre o jogador e o objeto

                if distance <= 2.0 then -- Verifica se o objeto está dentro do raio de 10 metros
                    DeleteEntity(v)

                    if GetEntityScript(v) ~= nil then
                        if not entityList[GetEntityScript(v)] then entityList[GetEntityScript(v)] = 0 end
                        entityList[GetEntityScript(v)] = entityList[GetEntityScript(v)] + 1
                    end

                    deleteCount = deleteCount + 1
                end
            end

            print(json.encode(entityList, { indent = true }))
            TriggerClientEvent('chatMessage', -1, "^1ADMIN: ^0"..deleteCount.." barreira deletada!")
        end
    end
end)






 -----------------------------------------------------------------------------------------------------------------------------------------
-- luzes
-----------------------------------------------------------------------------------------------------------------------------------------


RegisterCommand("luzes", function(source, args, rawCommand)
    TriggerClientEvent("dj:activateLights", source)
    TriggerClientEvent("dj:activateLights2", source)
end)

RegisterCommand("luzes2", function(source, args, rawCommand)
    TriggerClientEvent("dj:activateLights2", source)
end)

RegisterCommand("luzes3", function(source, args, rawCommand)
    TriggerClientEvent("dj:activateLights3", source)
end)

RegisterCommand("desativarluzes", function(source, args, rawCommand)
    TriggerClientEvent("dj:deactivateLights", source)
end)



 -----------------------------------------------------------------------------------------------------------------------------------------
-- ADD COINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcoins", function(source, args, rawCommand)
    local user_id = tonumber(args[1]) 
    local amount = tonumber(args[2])  

    if user_id and amount then
        if amount > 0 then
            vRP.execute("vRP/add_coins", { user_id = user_id, coins = amount })
            print("^2[COINS]^7 Adicionados " .. amount .. " coins para o ID: " .. user_id)

            vRP.sendLog("COINSADD", "O ID " .. vRP.getUserId(source) .. " adicionou " .. amount .. " coins para o ID " .. user_id)

            TriggerClientEvent("Notify", source, "sucesso", "Adicionado " .. amount .. " coins ao ID: " .. user_id)
        else
            TriggerClientEvent("Notify", source, "negado", "A quantidade de coins deve ser maior que 0.")
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Uso correto: /addcoins <user_id> <quantidade>")
    end
end, false)


---------------------------------------------------------
-- /fome
---------------------------------------------------------
RegisterCommand("fome",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        vRP.varyThirst(user_id, -100)
        vRP.varyHunger(user_id, -100)
    end
end)
RegisterCommand('zerarnec',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRP.setHunger(parseInt(args[1]), 100)
                vRP.setThirst(parseInt(args[1]), 100)
            end
        else
            vRP.setHunger(user_id, 100)
            vRP.setThirst(user_id, 100)
        end
    end
end)