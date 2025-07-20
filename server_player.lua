

function RegisterTunnel.CheckPlayers()
	return GetNumPlayerIndices()
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- plates placa
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Evento de spawn do jogador (servidor)
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if source then
        TriggerClientEvent("updateLicensePlates", source)
    end
end)
------------------------------------------------------------------------------
---- 30s    --   smaby#9295 --
------------------------------------------------------------------------------
RegisterCommand('30s', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source, 70)

    -- Verifica se um jogador foi encontrado
    if nplayer then
        local nuser_id = vRP.getUserId(nplayer)
        if vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id, "perm.ilegal") then
            -- Notificações e progresso
            TriggerClientEvent("Notify", source, "negado", "Importante", "Contagem dos 30 segundos de ação", 5000)
            TriggerClientEvent("Notify", nplayer, "importante", "Contagem dos 30 segundos de ação iniciada", 5000)
            TriggerClientEvent("Notify", source, "importante", "Contagem dos 30 segundos de ação iniciada", 5000)
            TriggerClientEvent("progress", source, 30000, "trinta")
            TriggerClientEvent("progress", nplayer, 30000, "trinta")
        else
            -- Sem permissão
            TriggerClientEvent("Notify", source, "negado", "Negado", "Você não tem permissão para acessar esse comando.", 5000)
        end
    else
        -- Nenhum jogador próximo foi encontrado
        TriggerClientEvent("Notify", source, "negado", "Erro", "Nenhum jogador próximo foi encontrado.", 5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RGB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rgbcar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	 if user_id then
		 if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.rgb") then -- permissão entre "Admin"
			 TriggerClientEvent('rbgcar',source)
			 TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> RGB com sucesso.")
		 end
	 end
 end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spec', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source) 
    if user_id ~= nil then
        if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
            if args[1] then
                local target_id = tonumber(args[1]) 
                if target_id and target_id ~= user_id then
                    local target_source = vRP.getUserSource(target_id) 
                    if target_source then
                        TriggerClientEvent('toggleSpec', source, target_source)
                        TriggerClientEvent("Notify", source, "sucesso", "Você está agora no modo espectador do jogador com ID " .. target_id) 
                    else
                        TriggerClientEvent("Notify", source, "erro", "Jogador alvo não encontrado!")
                    end
                else
                    TriggerClientEvent('toggleSpec', source, nil) 
                    TriggerClientEvent("Notify", source, "sucesso", "Você saiu do modo espectador.") 
                end
            else
                TriggerClientEvent('toggleSpec', source, nil) 
                TriggerClientEvent("Notify", source, "sucesso", "Você saiu do modo espectador.") 
            end
        else
            TriggerClientEvent("Notify", source, "erro", "Você não tem permissão para usar este comando.")
        end
    else
        TriggerClientEvent("Notify", source, "erro", "Você não está logado.")
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
-- FESTA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('festa',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        vRPclient.setDiv(-1,"festinha"," @keyframes blinking {    0%{ background-color: #ff3d50; border: 2px solid #871924; opacity: 0.8; } 25%{ background-color: #d22d99; border: 2px solid #901f69; opacity: 0.8; } 50%{ background-color: #55d66b; border: 2px solid #126620; opacity: 0.8; } 75%{ background-color: #22e5e0; border: 2px solid #15928f; opacity: 0.8; } 100%{ background-color: #222291; border: 2px solid #6565f2; opacity: 0.8; }  } .div_festinha { font-size: 11px; font-family: arial; color: rgba(255, 255, 255,1); padding: 20px; bottom: 30%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; animation: blinking 1s infinite; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Festeiro(a): "..identity.nome.." "..identity.sobrenome)
        SetTimeout(30000,function()
            vRPclient.removeDiv(-1,"festinha")
        end)
    end
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then 
		local status, time = exports['vrp']:getCooldown(user_id, "status")
        if status then
            exports['vrp']:setCooldown(user_id, "status", 5)
			local onlinePlayers = GetNumPlayerIndices()
			
			local policia = vRP.getUsersByPermission("perm.baupolicialiderThunder")
			local policiaPtr = 0
			for k,v in pairs(policia) do
				local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
				if patrulhamento then
					policiaPtr = policiaPtr + 1
				end
			end

			local policiacivil = vRP.getUsersByPermission("perm.policiacivil")
			local policiaCivilPtr = 0
			for k,v in pairs(policiacivil) do
				local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
				if patrulhamento then
					policiaCivilPtr = policiaCivilPtr + 1
				end
			end

			local paramedico = vRP.getUsersByPermission("perm.unizk")	
			local paramedicoPtr = 0
			for k,v in pairs(paramedico) do
				local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
				if patrulhamento then
					paramedicoPtr = paramedicoPtr + 1
				end
			end

			local mecanica = vRP.getUsersByPermission("perm.mecanica")	
			local mecanicaPtr = 0
			for k,v in pairs(mecanica) do
				local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
				if patrulhamento then
					mecanicaPtr = mecanicaPtr + 1
				end
			end

			local staff = vRP.getUsersByPermission("perm.ptr.staff")
			
			TriggerClientEvent("Notify",source,"importante","Jogadores Online: <b>".. onlinePlayers .."</b><br>Policiais Militares: <b>"..policiaPtr.."</b><br>Policiais Civis: <b>"..policiaCivilPtr.."</b><br>Paramedicos: <b>"..paramedicoPtr.."</b><br>Mecânicos: <b>"..mecanicaPtr.."</b><br>Administração: <b>"..#staff.."</b> .")
		end
	end
    
end)





local garage = Proxy.getInterface("garages")
RegisterCommand('veh',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "vender" then
			local veh = vRP.query("vRP/get_Veiculos", {user_id = user_id})
			local mensagem = ""
			for k,v in pairs(veh) do
				mensagem = mensagem..v.veiculo..","
			end

			local veiculos = vRP.prompt(source, "Digite o nome do veiculo: ", "Seus Veiculos: ".. mensagem)
			if veiculos and veiculos ~= nil and veiculos ~= "" then
				local myveh = vRP.query("vRP/get_veiculos_status", {user_id = user_id, veiculo = veiculos })
				if myveh[1] ~= nil then

					veiculos = string.lower(veiculos) 

					if garage.getVehicleType(veiculos) == "vip" or garage.getVehicleType(veiculos) == "exclusive" or veiculos == "f250deboxe" or veiculos == "africatag" or veiculos == "rmodx6" then
						TriggerClientEvent("Notify",source,"negado","Negado","Você não pode vender esse veiculo.", 5000)
						return 
					end 

					local nuser_id = vRP.prompt(source, "Digite o ID do jogador: ", "")
					if nuser_id and tonumber(nuser_id) and tonumber(nuser_id) > 0 and nuser_id ~= nil and nuser_id ~= "" then
						if parseInt(nuser_id) ~= parseInt(user_id) then
							local nplayer = vRP.getUserSource(parseInt(nuser_id))
							if nplayer then
								local valor = vRP.prompt(source, "Digite o valor que você deseja no veiculo: ", "")
								if tonumber(valor) > 0 and tonumber(valor) < 99999999 and valor ~= nil and valor ~= "" then
									if vRP.request(nplayer, "Você deseja comprar o veiculo <b>"..veiculos.."</b> por <b>$ "..vRP.format(valor).."</b> do id <b>"..user_id.."</b>", 30) then
										local status, time = exports['vrp']:getCooldown(user_id, "veh")
										if status then
											exports['vrp']:setCooldown(user_id, "veh", 10)
											local myveh2 = vRP.query("vRP/get_veiculos_status", {user_id = user_id, veiculo = veiculos })

											if myveh2[1] ~= nil then
												if vRP.tryFullPayment(parseInt(nuser_id), parseInt(valor)) then
													vRP.giveMoney(user_id, parseInt(valor))
													vRP.execute("vRP/update_owner_vehicle", { nuser_id = tonumber(nuser_id), user_id = tonumber(user_id), veiculo = veiculos })
													vRP.updatePlate(myveh2[1].placa, nuser_id)

													TriggerClientEvent("Notify",source,"sucesso","Sucesso","Parabens, Você acaba de vender seu veiculo.", 5000)
													TriggerClientEvent("Notify",nplayer,"sucesso","Sucesso","Parabens, Você acaba de comprar este veiculo.", 5000)
													vRP.sendLog("", "thunder - [ID]: "..user_id.." vendeu o carro para o [ID]: "..nuser_id.." [MODELO]: "..veiculos.." [VALOR]: "..vRP.format(valor).." ")
												else
													TriggerClientEvent("Notify",source,"negado","Negado","O Jogador não possui dinheiro.", 5000)
													TriggerClientEvent("Notify",nplayer,"negado","Negado","Você não possui dinheiro.", 5000)
												end
											else
												TriggerClientEvent("Notify",source,"negado","Negado","O Jogador recusou a proposta.", 5000)
												TriggerClientEvent("Notify",nplayer,"negado","Negado","Você recusou a proposta.", 5000)
											end
										end
									end
								end
							else
								TriggerClientEvent("Notify",source,"negado","Negado","Este jogador não se encontra na cidade no momento.", 5000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Negado","Você não pode vender para si mesmo.", 5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Negado","Você não possui ou não digitou corretamente o nome do veiculo.", 5000)
				end
			end
		end
	end
end)


RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"perm.disparo" ) then
			if user_id then
				TriggerClientEvent('chatMessage',-1,identity.nome.." "..identity.sobrenome,{64,64,255},rawCommand:sub(4))
			end
		end
	end
end)

RegisterCommand('pd',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "perm.disparo" 
		if GetEntityHealth(GetPlayerPed(source)) > 105 then
			if vRP.hasPermission(user_id,permission) then
				local soldado = vRP.getUsersByPermission(permission)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						TriggerClientEvent('chatMessage',player,identity.nome.." "..identity.sobrenome,{64,179,255},rawCommand:sub(3))
					end
				end
			end
		end
	end
end)

RegisterCommand('hp',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "perm.unizk"
		if vRP.hasPermission(user_id,permission) then
			local colaboradordmla = vRP.getUsersByPermission(permission)
			for l,w in pairs(colaboradordmla) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					TriggerClientEvent('chatMessage',player,"[ Hospital Copacabana ] "..identity.nome.." "..identity.sobrenome,{255,0,0},rawCommand:sub(3))
				end
			end
		end
	end
end)


RegisterCommand('ilegal',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "perm.ilegal"
		if vRP.hasPermission(user_id,permission) then
			local colaboradordmla = vRP.getUsersByPermission(permission)
			for l,w in pairs(colaboradordmla) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					TriggerClientEvent('chatMessage',player,"[ Ilegal ] "..identity.nome.." "..identity.sobrenome,{0,0,0},rawCommand:sub(3))
				end
			end
		end
	end
end)

RegisterCommand('ev',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "perm.evento"
		if vRP.hasPermission(user_id,permission) then
			local colaboradordmla = vRP.getUsersByPermission(permission)
			for l,w in pairs(colaboradordmla) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					TriggerClientEvent('chatMessage',player,"[ Evento ] "..identity.nome.." "..identity.sobrenome,{0,0,0},rawCommand:sub(3))
				end
			end
		end
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- status4
---------------------------------ARMAS-------------------------------------------------------------------------------------------------
local status4 = {
	{ permissao = "perm.demonike", title = "Armas:<br>🔫 Demonike: ", ultima = false },
	{ permissao = "perm.pcc", title = "🔫 PCC:", ultima = false },
	{ permissao = "perm.mafia", title = "🔫 Mafia:", ultima = false },
	{ permissao = "perm.cartel", title = "🔫 Cartel:", ultima = false },
	{ permissao = "perm.croacia", title = "🔫 Croacia:", ultima = false },
	{ permissao = "perm.franca", title = "🔫 Franca:", ultima = true },
	{ permissao = "perm.wolves", title = "🔫 Wolves:", ultima = true },
	{ permissao = "perm.yakuza", title = "🔫 Yakuza:", ultima = true },
	{ permissao = "perm.triade", title = "🔫 Triade:", ultima = true },
	{ permissao = "perm.merlim", title = "🔫 Merlim:", ultima = true },
	{ permissao = "perm.grota", title = "🔫 Grota:", ultima = true },
	{ permissao = "perm.turquia", title = "🔫 Turquia:", ultima = true },
	{ permissao = "perm.blackout", title = "🔫 BlackOut:", ultima = true },
-------------------------------MUNIÇÃO E DESMANCHE---------------------------------------------
	{ permissao = "perm.milicia", title = "Munição e Desmanche :<br>📦 Milicia: ", ultima = false },
	{ permissao = "perm.alemao", title = "📦 Alemao: ", ultima = false },
	{ permissao = "perm.helipa", title = "📦 Helipa: ", ultima = false },
	{ permissao = "perm.rocinha", title = "📦 Rocinha: ", ultima = false },
	{ permissao = "perm.crips", title = "📦 Crips: ", ultima = true },
	{ permissao = "perm.furious", title = "📦 Furious: ", ultima = true },
	{ permissao = "perm.motoclub", title = "📦 Motoclub: ", ultima = true },
	{ permissao = "perm.b13", title = "📦 B13: ", ultima = true },
	{ permissao = "perm.lacoste", title = "📦 Lacoste: ", ultima = true },
	{ permissao = "perm.hellsamgels", title = "📦 HellsAngels: ", ultima = true },
	{ permissao = "perm.bennys", title = "📦 Bennys: ", ultima = true },
-- -------------------------------LAVAGEM------------------------------------------------
-- 	{ permissao = "perm.vanilla", title = "Lavagem:<br>💵 Vanilla: ", ultima = false },
-- 	{ permissao = "perm.bahamas", title = "💵 Bahamas: ", ultima = false },
-- 	{ permissao = "perm.bratva", title = "💵 Bratva: ", ultima = false },
-- 	{ permissao = "perm.tequila", title = "💵 Tequila: ", ultima = false },
-- 	{ permissao = "perm.iluminatis", title = "💵 Iluminatis: ", ultima = true },
-- 	{ permissao = "perm.luxury", title = "💵 Luxury: ", ultima = true },
-- 	{ permissao = "perm.galaxy", title = "💵 Galaxy: ", ultima = true },
-- 	{ permissao = "perm.cassino", title = "💵 Cassino: ", ultima = true },
-- ---------------------------DROGAS---------------------------------------------------
-- 	{ permissao = "perm.nigeria", title = "Drogas:<br>💊 Nigeria: ", ultima = false },
-- 	{ permissao = "perm.palestina", title = "💊 Palestina: ", ultima = false },
-- 	{ permissao = "perm.canada", title = "💊 Canada: ", ultima = false },
-- 	{ permissao = "perm.brasil", title = "💊 Brasil: ", ultima = false },
-- 	{ permissao = "perm.argentina", title = "💊 Argentina: ", ultima = false },
-- 	{ permissao = "perm.portugal", title = "💊 Portugal: ", ultima = false },
-- 	{ permissao = "perm.cv", title = "💊 Cv: ", ultima = false },
-- 	{ permissao = "perm.camorra", title = "💊 Camorra: ", ultima = false },
-- 	{ permissao = "perm.mexico", title = "💊 Mexico: ", ultima = false },
-- 	{ permissao = "perm.jamaica", title = "💊 Jamaica: ", ultima = false },
-- 	{ permissao = "perm.australia", title = "💊 Australia: ", ultima = false },
}

RegisterCommand('status4',function(source,args)
    local user_id = vRP.getUserId(source)
	if user_id then
		local status, time = exports['vrp']:getCooldown(user_id, "status4")
        if status then
            exports['vrp']:setCooldown(user_id, "status4", 10)
			if vRP.hasPermission(user_id , "admin.permissao") or vRP.hasPermission(user_id,"perm.ilegal") then
				local onlinePlayers = GetNumPlayerIndices()
				local onlinefacs = vRP.getUsersByPermission("perm.ilegal")
				local formatText = ""

				for k,v in pairs(status4) do
					if not v.ultima then
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br>"
					else
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br><br>"
					end
				end

				TriggerClientEvent("Notify", source,"importante","<b>thunder City:</b><br><br> "..formatText.." <br> <b>🌇 Ilegal: </b>"..#onlinefacs.."<br><b>🏘️ Total de jogadores Online: </b>".. onlinePlayers .. ".", 10000)
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- status5
---------------------------------ARMAS-------------------------------------------------------------------------------------------------
local status5 = {
-------------------------------LAVAGEM------------------------------------------------
	{ permissao = "perm.vanilla", title = "Lavagem:<br>💵 Vanilla: ", ultima = false },
	{ permissao = "perm.bahamas", title = "💵 Bahamas: ", ultima = false },
	{ permissao = "perm.bratva", title = "💵 Bratva: ", ultima = false },
	{ permissao = "perm.tequila", title = "💵 Tequila: ", ultima = false },
	{ permissao = "perm.iluminatis", title = "💵 Iluminatis: ", ultima = true },
	{ permissao = "perm.luxury", title = "💵 Luxury: ", ultima = true },
	{ permissao = "perm.galaxy", title = "💵 Galaxy: ", ultima = true },
	{ permissao = "perm.cassino", title = "💵 Cassino: ", ultima = true },
---------------------------DROGAS---------------------------------------------------
	{ permissao = "perm.nigeria", title = "Drogas:<br>💊 Nigeria: ", ultima = false },
	{ permissao = "perm.palestina", title = "💊 Palestina: ", ultima = false },
	{ permissao = "perm.canada", title = "💊 Canada: ", ultima = false },
	{ permissao = "perm.brasil", title = "💊 Brasil: ", ultima = false },
	{ permissao = "perm.argentina", title = "💊 Argentina: ", ultima = false },
	{ permissao = "perm.portugal", title = "💊 Portugal: ", ultima = false },
	{ permissao = "perm.cv", title = "💊 Cv: ", ultima = false },
	{ permissao = "perm.camorra", title = "💊 Camorra: ", ultima = false },
	{ permissao = "perm.mexico", title = "💊 Mexico: ", ultima = false },
	{ permissao = "perm.jamaica", title = "💊 Jamaica: ", ultima = false },
	{ permissao = "perm.australia", title = "💊 Australia: ", ultima = false },
}

RegisterCommand('status5',function(source,args)
    local user_id = vRP.getUserId(source)
	if user_id then
		local status, time = exports['vrp']:getCooldown(user_id, "status5")
        if status then
            exports['vrp']:setCooldown(user_id, "status5", 10)
			if vRP.hasPermission(user_id , "admin.permissao") or vRP.hasPermission(user_id,"perm.ilegal") then
				local onlinePlayers = GetNumPlayerIndices()
				local onlinefacs = vRP.getUsersByPermission("perm.ilegal")
				local formatText = ""

				for k,v in pairs(status5) do
					if not v.ultima then
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br>"
					else
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br><br>"
					end
				end

				TriggerClientEvent("Notify", source,"importante","<b>thunder City:</b><br><br> "..formatText.." <br> <b>🌇 Ilegal: </b>"..#onlinefacs.."<br><b>🏘️ Total de jogadores Online: </b>".. onlinePlayers .. ".", 10000)
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- status policia
----------------------------------------------------------------------------------------------------------------------------------------
local status3 = {
	{ permissao = "perm.radioThunder", title = "Thunder Policia: ", ultima = false },
	{ permissao = "perm.radioexercito", title = "Exercito: ", ultima = false },
	{ permissao = "perm.radiocivil", title = "Policia Civil: ", ultima = false },
	{ permissao = "perm.disparo", title = "Total de Policiais: ", ultima = false },
}

RegisterCommand('status3',function(source,args)
    local user_id = vRP.getUserId(source)
	if user_id then
		local status, time = exports['vrp']:getCooldown(user_id, "status3")
        if status then
            exports['vrp']:setCooldown(user_id, "status3", 10)
			if vRP.hasPermission(user_id , "admin.permissao") or vRP.hasPermission(user_id,"perm.ilegal") then
				local onlinePlayers = GetNumPlayerIndices()
				local onlinefacs = vRP.getUsersByPermission("perm.ilegal")
				local formatText = ""

				for k,v in pairs(status3) do
					if not v.ultima then
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br>"
					else
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br><br>"
					end
				end

				TriggerClientEvent("Notify", source,"importante","<b>thunder City:</b><br><br> "..formatText.." <br><b>🏘️ Total de jogadores Online: </b>".. onlinePlayers .. ".", 10000)
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SEQUESTRAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local totalSequestro = {}
RegisterServerEvent('target:sequestrar')
AddEventHandler('target:sequestrar', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.getNearestPlayer(source,5)
		if nplayer then
			local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,_,_,mVeh = vRPclient.ModelName(source, 5)
			if mName and mVeh then
				if vRPclient.isMalas(nplayer) then
					vRPclient._setMalas(nplayer, false)
					TriggerClientEvent("Notify",source,"sucesso","Você retirou o jogador do porta malas.", 5000)

					totalSequestro[mPlaca] = totalSequestro[mPlaca] - 1
					if totalSequestro[mPlaca] <= 0 then
						totalSequestro[mPlaca] = 0
					end
				else
					if totalSequestro[mPlaca] == nil then
						totalSequestro[mPlaca] = 0
					end

					if vRPclient.isHandcuffed(nplayer) then
						if totalSequestro[mPlaca] >= 1 then
							TriggerClientEvent("Notify",source,"sucesso","Veiculo Cheio...", 5000)
							return
						end

						vRPclient._setMalas(nplayer, true)
						TriggerClientEvent("Notify",source,"sucesso","Você colocou o jogador no porta malas.", 5000)

						totalSequestro[mPlaca] = totalSequestro[mPlaca] + 1
					else
						TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.", 5000)
					end
				end
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKIN
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local totalVehicle = {} -- Certifique-se de que esta variável esteja definida em algum lugar do seu script

    RegisterServerEvent('target:trunkin')
    AddEventHandler('target:trunkin', function()
		local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,_,_,mVeh = vRPclient.ModelName(source, 5)
        if not mLock and mVeh then
            if vRPclient.isHandcuffed(source) then
                return
            end
            if totalVehicle[mPlaca] == nil then
                totalVehicle[mPlaca] = 0
            end
            if not vRPclient.isInVehicle(source) then
                if vRPclient.isMalas(source) then
                    vRPclient._setMalas(source, false)
                    vCLIENT._updateTrunkIn(source, nil, false)
                    TriggerClientEvent("Notify",source,"sucesso","Você saiu do porta malas.", 5)
                    totalVehicle[mPlaca] = totalVehicle[mPlaca] - 1
                    if totalVehicle[mPlaca] <= 0 then
                        totalVehicle[mPlaca] = 0
                    end
                else
                    if totalVehicle[mPlaca] >= 2 then
                        TriggerClientEvent("Notify",source,"sucesso","Veiculo Cheio...", 5)
                        return
                    end
                    vRPclient._setMalas(source, true)
                    vCLIENT._updateTrunkIn(source, mVeh, true)
                    TriggerClientEvent("Notify",source,"sucesso","Você entrou no porta malas.", 5)
                    totalVehicle[mPlaca] = totalVehicle[mPlaca] + 1
                end
            end
        end
    end)


RegisterCommand("trunkin",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
            TriggerClientEvent("ngs:OnTrunk",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa', function(source,args)
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id, "admin.permissao")  then
				local mPlaca,mName = vRPclient.ModelName(source, 5)
				local nuser_id = vRP.getUserByRegistration(mPlaca)
				if nuser_id then
					local identity = vRP.getUserIdentity(nuser_id)
				if identity then
					TriggerClientEvent("Notify",source,"importante","• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> <br>• Passaporte: <b>"..identity.user_id.."</b> .")
				end
			else
				local nuser_id = vRP.getUserByRegistration(string.gsub(mPlaca, " ", ""))
				local identity = vRP.getUserIdentity(nuser_id)
				if nuser_id then
					if identity then
						TriggerClientEvent("Notify",source,"importante","• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> <br>• Passaporte: <b>"..identity.user_id.."</b> .")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Não foi possivel consultar esse veiculo. ", 8000)
				end
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GMOCHILA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gmochila', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		local ok = vRP.request(source, "Você deseja guardar sua(s) <b>"..vRP.getMochilaAmount(user_id).."</b> mochila(s)?", 20000)
		local status, time = exports['vrp']:getCooldown(user_id, "mochila")
		if ok and GetEntityHealth(GetPlayerPed(source)) > 105 and status then
            exports['vrp']:setCooldown(user_id, "mochila", 10)
			
			vRP.giveInventoryItem(user_id, "mochila", vRP.getMochilaAmount(user_id), true)
			vRP.remMochila(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você guardou suas mochilas.", 5000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VER O ID PROXIMO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id', function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)

	if user_id then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			TriggerClientEvent("Notify",source,"importante","ID Próximo: "..nuser_id,8000)
			-- TriggerClientEvent("Notify",nplayer,"importante","O [ID:"..user_id.."] acabou de ver seu id.", 5)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.")
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] then
			if GetEntityHealth(GetPlayerPed(source)) > 105 then
				local nplayers = vRPclient.getNearestPlayers(source, 10)
				for k in pairs(nplayers) do
			    	TriggerClientEvent("vrp_player:pressMe", parseInt(k), source,rawCommand:sub(4),{ 10,250,0,255,100 })
				end

				TriggerClientEvent("vrp_player:pressMe", source, source,rawCommand:sub(4),{ 10,250,0,255,100 })
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /SKIN ADM
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookURL = "https://discord.com/api/webhooks/1279016737064489002/06_2iprfQUKwA24wkKD7czPegM7D3zGFW0m-kAGGX4CjeGxSSekMCp3eQfbM-xUhtV2m"
RegisterCommand('skin', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
	TriggerClientEvent("Notify", source, "sucesso", "SKIN ALTERADA COM SUCESSO !!!", 5000)
	--TriggerClientEvent("Notify", source, "sucesso", "SKIN NÃO CARREGOU UTILIZE O COMANDO /BVIDA !!!", 30000)
    if vRP.hasPermission(user_id, "developer.permissao") then
        if tonumber(args[1]) then
            local nplayer = vRP.getUserSource(tonumber(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu", nplayer, args[2])
                TriggerClientEvent("Notify", source, "sucesso", "Sucesso", "Você setou a skin <b>" .. args[2] .. "</b> no passaporte <b>" .. tonumber(args[1]) .. "</b>.", 5000)
                local payload = {
                    content = "O jogador com passaporte " .. tonumber(args[1]) .. " alterou sua skin para " .. args[2]
                }
                local payloadJson = json.encode(payload)
                PerformHttpRequest(webhookURL, function(statusCode, response, headers) end, 'POST', payloadJson, { ['Content-Type'] = 'application/json' })
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CHECAR COMANDO BLOQUEADO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.blockCommands(segundos)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		exports["vrp"]:setBlockCommand(user_id, segundos)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.deleteVeh(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		exports['thunder_garages']:deleteVehicle(source, vehicle)
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR DE BANCO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seat",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if GetEntityHealth(GetPlayerPed(source)) > 105 then
			if tonumber(args[1]) then
				vTunnel._seatPlayer(source, tonumber(args[1]))
			end
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR VIP OU BOOSTER
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.checkAttachs()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "perm.vips") or vRP.hasPermission(user_id, "perm.booster") then
			return true
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR MANOBRAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.checkPermVip()
    local source = source
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,"perm.manobras") or vRP.hasPermission(user_id,"admin.permissao") then
        return true
  --  end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE SALARIOS 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local cfg = module("cfg/groups")
local grupos = cfg.groups
local salarios = {}
local sound = {}
local userSalario = {}

function RegisterTunnel.rCountSalario()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		if salarios[user_id] == nil then 
			salarios[user_id] = 0 
		else
			salarios[user_id] = salarios[user_id] + 5
		end

		if salarios[user_id] >= 20 then
			pagarSalario(user_id)
			salarios[user_id] = 0
		end
	end
end

function pagarSalario(user_id)
	local source = vRP.getUserSource(user_id)
	if user_id then
		local groups = vRP.getUserGroups(user_id)

		if userSalario[user_id] ~= nil then
			if os.time() - userSalario[user_id] <= 40 then
				vRP.log("", "[thunder] Possivel tentativa de DUP de salario: "..user_id)
			end
		end
		
		for k,v in pairs(groups) do
			if grupos[k] and grupos[k]._config ~= nil and grupos[k]._config.salario ~= nil then
				if grupos[k]._config.salario > 0 then
					if grupos[k]._config.ptr then
						if vRP.checkPatrulhamento(user_id) then
							userSalario[user_id] = os.time()
							vRP.giveBankMoney(user_id, grupos[k]._config.salario)
                            TriggerClientEvent('chatMessage',source,"SALARIO:",{255,160,0}, "Você acaba de receber o salario de ^2"..k.."^0 no valor de ^2 $ "..vRP.format(grupos[k]._config.salario))
						end
					else
						userSalario[user_id] = os.time()
						vRP.giveBankMoney(user_id, grupos[k]._config.salario)
						TriggerClientEvent('chatMessage',source,"SALARIO:",{255,160,0}, "Você acaba de receber o salario de ^2"..k.."^0 no valor de ^2 $ "..vRP.format(grupos[k]._config.salario))
					end
				end
			end
		end
	end
end

RegisterCommand('salario', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if salarios[user_id] ~= nil then
			TriggerClientEvent('chatMessage',source,"SALARIO: ",{255,160,0}, " Ainda faltam ^2 ".. 40 - salarios[user_id].." minuto(s)^0 para você receber o seu salario.")
		end
	end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CHAMADOS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local servicesAn = {
	["perm.policia"] = { prefix = "^5[POLICIA]" },
	["perm.unizk"] = { prefix = "^1[HOSPITAL]" },
	["perm.mecanica"] = { prefix = "^2[MECANICA]" },
}

RegisterCommand('an',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
	
		if user_id then
			for k,v in pairs(servicesAn) do
				if vRP.hasPermission(user_id, k) then
					TriggerClientEvent('chatMessage',-1,v.prefix.. "^0 " ..identity.nome.." "..identity.sobrenome.. ": ",{64,64,255},rawCommand:sub(3))
					break;
				end
			end
		end
	end
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)

RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)

RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)

RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE RELACIONAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
local delayShip = {}

vRP._prepare("setRelacionamento", "UPDATE vrp_user_identities SET relacionamento = @relacionamento WHERE user_id = @user_id")
vRP._prepare("getRelacionamento", "SELECT relacionamento FROM vrp_user_identities WHERE user_id = @user_id")


RegisterServerEvent('target:namorar')
AddEventHandler('target:namorar', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local nplayer = vRPclient.getNearestPlayer(source, 5)
        if not delayShip[user_id] then 
            delayShip[user_id] = 0 
        end

        if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
            TriggerClientEvent("Notify", source, "negado", "Você não possui uma aliança.", 8000)
            return
        end

        if (os.time() - delayShip[user_id]) < 60 then
            TriggerClientEvent("Notify", source, "negado", "Aguarde para fazer um pedido novamente.", 8000)
            return
        end

        local shipUserId = getRelacionamento(user_id)
        if shipUserId.tipo ~= nil then
            TriggerClientEvent("Notify", source, "negado", "Você já está em uma relação no momento.", 8000)
            return
        end

        if nplayer then
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id then
                local nidentity = vRP.getUserIdentity(nuser_id)
                local identity = vRP.getUserIdentity(user_id) 
                local shipNUserId = getRelacionamento(nuser_id)
                if shipNUserId.tipo ~= nil then
                    TriggerClientEvent("Notify", source, "negado", "Este Jogador já está em uma relação no momento.", 8000)
                    return
                end

                TriggerClientEvent("Notify", source, "negado", "Você está fazendo o pedido de namoro...", 8000)

                TriggerClientEvent("emotes", nplayer, "cruzar")
                TriggerClientEvent("emotes", source, "ajoelhar")
                TriggerClientEvent("emotes", source, "rosa")


                local requestCasamento = vRP.request(nplayer, "O(a) " .. identity.nome .. " " .. identity.sobrenome .. " está pedindo sua mão em namoro, deseja aceitar?")
                if requestCasamento then
                    delayShip[user_id] = os.time()
                    delayShip[nuser_id] = os.time()

                    TriggerClientEvent('chat:addMessage', -1, {
                        template = '<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(98, 0, 255,0.8) 3%, rgba(98, 0, 255,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/928341690828345445/979172601610002453/hearts.png">' .. identity.nome .. ' ' .. identity.sobrenome .. ' está namorando ' .. nidentity.nome .. ' ' .. nidentity.sobrenome .. '</b></div>'
                    })

                    TriggerClientEvent("emotes", nplayer, "beijar")
                    TriggerClientEvent("emotes", source, "beijar")

                    vRP._execute("setRelacionamento", {
                        user_id = nuser_id,
                        relacionamento = json.encode({
                            tipo = "Namorando",
                            user_id = user_id,
                            data = os.date("%d/%m/%Y", os.time()),
                            name = identity.nome .. " " .. identity.sobrenome
                        })
                    })
                    vRP._execute("setRelacionamento", {
                        user_id = user_id,
                        relacionamento = json.encode({
                            tipo = "Namorando",
                            user_id = nuser_id,
                            data = os.date("%d/%m/%Y", os.time()),
                            name = nidentity.nome .. " " .. nidentity.sobrenome
                        })
                    })
                    vRP._updateIdentity(user_id)
                    vRP._updateIdentity(nuser_id)
                    vRP.tryGetInventoryItem(user_id, "alianca", 1)
                else
                    TriggerClientEvent("Notify", source, "negado", "Seu pedido foi recusado.", 8000)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Jogador próximo não encontrado.", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Nenhum jogador próximo encontrado.", 8000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "ID do usuário não encontrado.", 8000)
    end
end)


RegisterCommand('namorar', function(source)
    TriggerEvent("target:namorar")
end)


RegisterServerEvent('target:casar')
AddEventHandler('target:casar', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id) 

    if user_id then
        if not delayShip[user_id] then 
            delayShip[user_id] = 0 
        end

        if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
            TriggerClientEvent("Notify", source, "negado", "Você não possui uma aliança.", 8000)
            return
        end

        -- if (os.time() - delayShip[user_id]) < 60 then
        --     TriggerClientEvent("Notify", source, "negado", "Aguarde para fazer um pedido novamente.", 8000)
        --     return
        -- end

        local shipUserId = getRelacionamento(user_id)
        if shipUserId.tipo ~= nil then
            if shipUserId.tipo == "Casado(a)" then
                TriggerClientEvent("Notify", source, "negado", "Sossega! Você já está Casado(a).", 8000)
                return
            end

            local nplayer = vRPclient.getNearestPlayer(source, 5)
            if nplayer then
                local nuser_id = vRP.getUserId(nplayer)
                local nidentity = vRP.getUserIdentity(nuser_id)

                if nuser_id then
                    if shipUserId.user_id == nuser_id then
                        TriggerClientEvent("Notify", source, "negado", "Você está fazendo o pedido de casamento...", 8000)

						TriggerClientEvent("emotes", nplayer, "cruzar")
						TriggerClientEvent("emotes", source, "ajoelhar")
						TriggerClientEvent("emotes", source, "rosa")

                        local requestCasamento = vRP.request(nplayer, "O(a) " .. identity.nome .. " " .. identity.sobrenome .. " está pedindo você em casamento, deseja aceitar?")
                        if requestCasamento then
                            delayShip[user_id] = os.time()
                            delayShip[nuser_id] = os.time()
                            TriggerClientEvent('chat:addMessage', -1, {
                                template = '<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(98, 0, 255,0.8) 3%, rgba(98, 0, 255,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/928341690828345445/979172601610002453/hearts.png">' .. identity.nome .. ' ' .. identity.sobrenome .. ' e ' .. nidentity.nome .. ' ' .. nidentity.sobrenome .. ' acabaram de se casar.</b></div>'
                            })

                      
                            vRP._execute("setRelacionamento", {
                                user_id = nuser_id,
                                relacionamento = json.encode({
                                    tipo = "Casado(a)",
                                    user_id = user_id,
                                    data = os.date("%d/%m/%Y", os.time()),
                                    name = identity.nome .. " " .. identity.sobrenome
                                })
                            })
                            vRP._execute("setRelacionamento", {
                                user_id = user_id,
                                relacionamento = json.encode({
                                    tipo = "Casado(a)",
                                    user_id = nuser_id,
                                    data = os.date("%d/%m/%Y", os.time()),
                                    name = nidentity.nome .. " " .. nidentity.sobrenome
                                })
                            })
                            vRP._updateIdentity(user_id)
                            vRP._updateIdentity(nuser_id)
                            vRP.tryGetInventoryItem(user_id, "alianca", 1)
                        else
                            TriggerClientEvent("Notify", source, "negado", "Seu pedido foi recusado.", 8000)
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Essa pessoa não namora você.", 8000)
                    end
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Nenhum jogador próximo encontrado.", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você não está em uma relação no momento.", 8000)
            return
        end
    end
end)


RegisterCommand('terminar', function(source,args)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if not delayShip[user_id] then delayShip[user_id] = 0 end

		if (os.time() - delayShip[user_id]) < 60 then
			TriggerClientEvent("Notify",source,"negado","Aguarde para fazer isso.",8000)
			return
		end

		local shipUserId = getRelacionamento(user_id)
		if shipUserId.tipo == nil then
			TriggerClientEvent("Notify",source,"negado","Você não pode terminar uma relação que não existe.",8000)
			return
		end

		if shipUserId.tipo == "Namorando" then
			TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(135, 135, 135,0.8) 3%, rgba(105, 105, 105,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/928341690828345445/979177362212155413/broken-heart.png">'..identity.nome.. ' '..identity.sobrenome..' e '..shipUserId.name..' terminaram o namoro.</b></div>'})
			
			vRP._execute("setRelacionamento", { user_id = shipUserId.user_id, relacionamento = json.encode({}) })
			vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({}) })
			vRP._updateIdentity(user_id)
			vRP._updateIdentity(shipUserId.user_id)
			return
		end

		if shipUserId.tipo == "Casado(a)" then
			TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(135, 135, 135,0.8) 3%, rgba(105, 105, 105,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/928341690828345445/979177362212155413/broken-heart.png">'..identity.nome.. ' '..identity.sobrenome..' e '..shipUserId.name..' terminaram o casamento.</b></div>'})
			
			vRP._execute("setRelacionamento", { user_id = shipUserId.user_id, relacionamento = json.encode({}) })
			vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({}) })
			vRP._updateIdentity(user_id)
			vRP._updateIdentity(shipUserId.user_id)
		end
	end
end)

function getRelacionamento(user_id)
	local query = vRP.query("getRelacionamento", { user_id = user_id })
	if #query > 0 then
		return json.decode(query[1].relacionamento)
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- /BVIDA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("bvida")
AddEventHandler("bvida",function()
    local source = source
    vRPclient.setCustomization(source,vRPclient.getCustomization(source))
    vRP.removeCloak(source)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local source = source 
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setmascara",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end	
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local source = source 
	Wait(500)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
		return
	end
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
			TriggerClientEvent("setblusa",source,args[1],args[2])
		else
			TriggerClientEvent("Notify",source,"negado","Nega do","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
		end		
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local source = source 
	local user_id = vRP.getUserId(source)
	local ped = GetPlayerPed(source)
	local armour = GetPedArmour(ped)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
		return
	end
	
	if user_id then
		if not args[1] and not args[2] then
			vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
			Citizen.Wait(2500)
			TriggerClientEvent("removeColeteUser",source)
		else
			vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
			TriggerClientEvent("setColeteUser",source,args[1],args[2])
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local source = source 
	Wait(500)
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setjaqueta",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local source = source 
	--if exports["chat"]:statusChat(source) then
	Wait(500)
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setmaos",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end

	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maose
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maose',function(source,args,rawCommand)
	local source = source 
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setmaose",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maosd
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maosd',function(source,args,rawCommand)
	local source = source 
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setmaosd",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local source = source
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setcalca",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local source = source 
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setacessorios",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local source = source
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isInVehicle(source) or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setsapatos",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local source = source
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setchapeu",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local source = source
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setoculos",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /adesivos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adesivos',function(source,args,rawCommand)
	local source = source
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setsticker",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila.",8000)
			end
	--	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mochila',function(source,args,rawCommand)
	local source = source
	Wait(500)
	--if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) or vRP.searchReturn(source,user_id) then
			return
		end
		if user_id then
			if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id, "perm.vipgod") or vRP.hasPermission(user_id, "perm.viprubi") or vRP.hasPermission(user_id, "perm.vipesmeralda") or vRP.hasPermission(user_id, "perm.vipplatina")  or vRP.hasPermission(user_id, "perm.vipdiamante") or vRP.hasPermission(user_id, "perm.vipsupremothunder") or vRP.hasPermission(user_id, "perm.vipmonster") or vRP.hasPermission(user_id, "perm.vipthunder")  then
				TriggerClientEvent("setMochila",source,args[1],args[2])
			else
				TriggerClientEvent("Notify",source,"negado","Negado","Você não possui <b>Roupas Secundárias</b> na mochila..",8000)
			end
	--	end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /p1
-----------------------------------------------------------------------------------------------------------------------------------------

lugares = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30}
for k,v in pairs(lugares) do
    RegisterCommand("p"..k, function(source, args)
        if vRP.isHandcuffed() then
            return
        end
        local ped = PlayerPedId()
        SetPedConfigFlag(ped, 184, true)
        SetPedIntoVehicle(ped, GetVehiclePedIsIn(ped), v)
    end)
end

local servicesAn = {
	["perm.policia"] = { prefix = "^5[POLICIA]" },
	["perm.unizk"] = { prefix = "^1[HOSPITAL]" },
	["lscustom.permissao"] = { prefix = "^2[BENNYS]" },
	["perm.mecanica"] = { prefix = "^2[MECANICA]" },
}

RegisterCommand('anuncio',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
	
		if user_id then
			for k,v in pairs(servicesAn) do
				if vRP.hasPermission(user_id, k) then
					TriggerClientEvent('chatMessage',-1,v.prefix.. "^0 " ..identity.nome.." "..identity.sobrenome.. ": ",{64,64,255},rawCommand:sub(3))
					break;
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- dimensão
-----------------------------------------------------------------------------------------------------------------------------------------

local playerDimensions = {} -- Tabela para armazenar as dimensões dos jogadores
local playerPositions = {} -- Tabela para armazenar as posições dos jogadores antes de entrar na dimensão

AddEventHandler("playerDropped", function()
    local source = source
    playerDimensions[source] = nil -- Remover o jogador da tabela ao desconectar
    playerPositions[source] = nil -- Remover a posição do jogador da tabela ao desconectar
end)

RegisterCommand('dimensao', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    if user_id and vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "ilegal.permissao") or vRP.hasPermission(user_id, "admin.permissao") then
        if args[1] then
            if args[1] == "sair" then
                playerDimensions[source] = nil -- Remover a dimensão do jogador para voltar à dimensão principal
                SetPlayerRoutingBucket(source, 0)
                TriggerClientEvent("Notify", source, "sucesso", "Você voltou para a dimensão principal.", 2000)

                -- Verificar se o jogador estava em alguma posição antes de entrar na dimensão
                local position = playerPositions[source]
                if position then
                    -- Teleportar o jogador de volta para a posição anterior
                    vRPclient.teleport(source, position.x, position.y, position.z)
                end
            else
                local dimension = tonumber(args[1])

                if dimension then
                    playerDimensions[source] = dimension -- Salvar a dimensão escolhida pelo jogador

                    -- Salvar a posição atual do jogador antes de entrar na dimensão
                    local x, y, z = vRPclient.getPosition(source)
                    playerPositions[source] = { x = x, y = y, z = z }

                    SetPlayerRoutingBucket(source, dimension)
                    TriggerClientEvent("Notify", source, "sucesso", "Você está na dimensão <b>" .. dimension .. "</b>!", 2000)
                else
                    TriggerClientEvent("Notify", source, "negado", "A dimensão deve ser um número válido.", 2000)
                end
            end
        else
            playerDimensions[source] = 0 -- Definir a dimensão principal como 0 caso o jogador não tenha fornecido uma dimensão

            -- Salvar a posição atual do jogador antes de entrar na dimensão
            local x, y, z = vRPclient.getPosition(source)
            playerPositions[source] = { x = x, y = y, z = z }

            SetPlayerRoutingBucket(source, 0)
            TriggerClientEvent("Notify", source, "negado", "Você não forneceu uma dimensão. Retornou para a dimensão principal.", 2000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para usar este comando.", 2000)
    end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- sistema de like
-----------------------------------------------------------------------------------------------------------------------------------------
local delayLike = {}
local delayDislike = {}

vRP._prepare("setLike", "UPDATE vrp_user_identities SET `like` = `like` + 1 WHERE user_id = @user_id")
vRP._prepare("setDislike", "UPDATE vrp_user_identities SET `deslike` = `deslike` + 1 WHERE user_id = @user_id")
vRP._prepare("getLike", "SELECT `like`, `deslike` FROM vrp_user_identities WHERE user_id = @user_id")


RegisterServerEvent('player:like')
AddEventHandler('player:like', function(nplayer)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and nplayer[1] then
        local targetUserId = vRP.getUserId(nplayer[1])
        if targetUserId and targetUserId ~= user_id then
            if not delayLike[user_id] then 
                delayLike[user_id] = 0 
            end

            if (os.time() - delayLike[user_id]) < 36060 then
                TriggerClientEvent("Notify", source, "negado", "Aguarde antes de dar outro like.", 8000)
                return
            end

            vRP._execute("setLike", { user_id = targetUserId })
            delayLike[user_id] = os.time()
            TriggerClientEvent("Notify", source, "sucesso", "Você deu um like no jogador!", 6000)
            local targetSource = vRP.getUserSource(targetUserId)
            if targetSource then
                TriggerClientEvent("Notify", targetSource, "sucesso", "Você recebeu um novo like!", 6000)
            else
                print("O jogador " .. targetUserId .. " está offline, notificação não enviada.")
            end
            
            vRP.sendLog("LIKE", "O USER_ID: " .. user_id .. " deu um like no USER_ID: " .. targetUserId)
        else
            TriggerClientEvent("Notify", source, "negado", "Você não pode dar like em si mesmo ou ID inválido.", 6000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Você não está logado.", 6000)
    end
end, false)


RegisterServerEvent('player:deslike')
AddEventHandler('player:deslike', function(nplayer)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and nplayer[1] then
		local targetUserId = vRP.getUserId(nplayer[1])

        if targetUserId and targetUserId ~= user_id then
            if not delayDislike[user_id] then 
                delayDislike[user_id] = 0 
            end

            if (os.time() - delayDislike[user_id]) < 36060 then
                TriggerClientEvent("Notify", source, "negado", "Aguarde antes de dar outro dislike.", 8000)
                return
            end

            vRP._execute("setDislike", { user_id = targetUserId })
            delayDislike[user_id] = os.time()
            TriggerClientEvent("Notify", source, "sucesso", "Você deu um dislike no jogador!", 6000)
            local targetSource = vRP.getUserSource(targetUserId)
            if targetSource then
                TriggerClientEvent("Notify", targetSource, "sucesso", "Você recebeu um novo dislike!", 6000)
            else
                print("O jogador " .. targetUserId .. " está offline, notificação não enviada.")
            end
            
            vRP.sendLog("DESLIKE", "O USER_ID: " .. user_id .. " deu um dislike no USER_ID: " .. targetUserId)
        else
            TriggerClientEvent("Notify", source, "negado", "Você não pode dar dislike em si mesmo ou ID inválido.", 6000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Você não está logado.", 6000)
    end
end, false) 


-----------------------------------------------------------------------------------------------------------------------------------------
-- sistema de texto
-----------------------------------------------------------------------------------------------------------------------------------------
-- Preparar consultas SQL
vRP._prepare("save_text", "INSERT INTO foxzin_texto(user_id, textoidplayer, texto, emoji) VALUES(@user_id, @textoidplayer, @texto, @emoji)")
vRP._prepare("get_text", "SELECT texto, emoji FROM foxzin_texto WHERE user_id = @user_id")
vRP._prepare("remove_text", "DELETE FROM foxzin_texto WHERE user_id = @user_id")


RegisterNetEvent('me:foxzinServer')
AddEventHandler('me:foxzinServer', function()
    local source = source  -- Define o source do evento
    local user_id = vRP.getUserId(source)
    if user_id then
        local emoji = vRP.prompt(source, "Digite o emoji que deseja usar (máx. 1 caracteres) (ex: 👍, 👎, ❤):", "")
        if emoji == "" then
            emoji = "👍" 
        elseif #emoji > 5 then
            TriggerClientEvent("Notify", source, "negado", "O emoji pode ter no máximo 1 caracteres.", 6000)
            return 
        end

        local text = vRP.prompt(source, "Digite seu texto aqui (máx. 10 caracteres):", "")
        if text ~= "" then
            if #text <= 10 then  
                if GetEntityHealth(GetPlayerPed(source)) > 105 then
                    vRP._execute("save_text", { user_id = user_id, textoidplayer = user_id, texto = text, emoji = emoji })
                    local nplayers = vRPclient.getNearestPlayers(source, 10)
                    for k in pairs(nplayers) do
                        TriggerClientEvent("vrp_player:showMeText", parseInt(k), source, text, emoji, {10, 250, 0, 255})
                    end
                    TriggerClientEvent("vrp_player:showMeText", source, source, text, emoji, {10, 250, 0, 255})
                end
            else
                TriggerClientEvent("Notify", source, "negado", "O texto pode ter no máximo 10 caracteres.", 6000)
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você precisa digitar um texto.", 6000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Você não está logado.", 6000)
    end
end)



RegisterNetEvent('me:tirarServer')
AddEventHandler('me:tirarServer', function()
    local source = source  -- Define o source do evento
    local user_id = vRP.getUserId(source)
    if user_id then
        local nplayers = vRPclient.getNearestPlayers(source, 10)
        for k in pairs(nplayers) do
            TriggerClientEvent("vrp_player:removeMeText", parseInt(k), source)
        end
        TriggerClientEvent("vrp_player:removeMeText", source, source)

        vRP._execute("remove_text", { user_id = user_id })
    end
end)


AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if source and first_spawn then
        exports.oxmysql:execute("SELECT texto, emoji FROM foxzin_texto WHERE user_id = @user_id LIMIT 1", {
            ['@user_id'] = user_id
        }, function(result)
            if result[1] then
                local text = result[1].texto or "" 
                local emoji = result[1].emoji or "👍" 
                
                -- Exibir o texto e emoji apenas para o jogador atual
                TriggerClientEvent("vrp_player:showMeText", source, source, text, emoji, {10, 250, 0, 255})
            else
                -- Opcional: Log para quando não há texto/emoji no banco
                -- print("Nenhum texto ou emoji encontrado para o user_id: " .. user_id)
            end
        end)
    end
end)




RegisterCommand("simularspawn", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerEvent("vRP:playerSpawn", user_id, source, true)
        TriggerClientEvent("Notify", source, "sucesso", "Você simulou o spawn com sucesso!", 6000)
    else
        TriggerClientEvent("Notify", source, "negado", "Você não está logado.", 6000)
    end
end)