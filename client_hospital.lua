local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_hospital",src)
vSERVER = Tunnel.getInterface("vrp_hospital")

local segundos = 0

----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE TRATAMENTO
----------------------------------------------------------------------------------------------------------------------------------------
local in_area = 0 
local deitado = false
local tratamento = false
local segundosT = 0
local vida = 0

local macas = {
    [1] = { -469.39,-285.68,34.92 , deitado = { -469.71,-284.6,35.84,20.3 } },
    [2] = { -467.78,-290.03,34.92 , deitado = { -467.08,-291.08,35.84,210.82 } },
    [3] = { -464.31,-288.63,34.92 , deitado = { -463.99,-289.6,35.84,204.2 } },
    [4] = { -460.93,-287.23,34.92 , deitado = { -460.52,-288.22,35.84,199.23 } },
    [5] = { -455.53,-285.02,34.92 , deitado = { -454.99,-286.1,35.84,195.4 } },
    [6] = { -452.21,-283.66,34.92 , deitado = { -451.7,-284.62,35.84,197.75 } },
    [7] = { -449.02,-282.34,34.92 , deitado = { -448.58,-283.44,35.84,200.55 } },
    [8] = { -454.4,-279.44,34.92 , deitado = { -454.93,-278.38,35.84,25.89 } },
    [9] = { -458.44,-281.01,34.92 , deitado = { -458.82,-280.05,35.84,12.52 } },
    [10] = { -462.15,-282.68,34.92 , deitado = { -462.43,-281.51,35.84,19.58 } },
    [11] = { -465.86,-284.19,34.92 , deitado = { -466.25,-283.17,35.84,21.38 } },
    [12] = { -426.54,1072.09,323.85 , deitado = { -427.45,1072.44,324.76,168.50 } },
    [13] = { -421.37,1076.05,323.84 , deitado = { -422.17,1076.23,324.76,343.04 } },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR AREA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

		for k,v in pairs(macas) do
            local entrada = (GetDistanceBetweenCoords(v[1],v[2],v[3],x,y,z,true) <= 2)

			if entrada then
				in_area = tonumber(k)
			end 
		end

		Citizen.Wait(time)
	end
end)

function src.retirarMascaraH()
    SetPedComponentVariation(PlayerPedId(), 1, 0,0,2)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE MACAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

		if tonumber(in_area) > 0 and not deitado then
			if GetDistanceBetweenCoords(macas[tonumber(in_area)][1],macas[tonumber(in_area)][2],macas[tonumber(in_area)][3],x,y,z,true) <= 1.5 then
				time = 5
				DrawText3Ds(macas[tonumber(in_area)][1],macas[tonumber(in_area)][2],macas[tonumber(in_area)][3], "~b~[MACA: "..tonumber(tonumber(in_area)).."]\n~w~[~g~E~w~] Deitar\n~w~[~b~F~w~] Iniciar tratamento")


                if IsControlJustReleased(1, 51) and segundos <= 0 and vSERVER.checkPagamento(3000) then
                    segundos = 5
                    DoScreenFadeOut(1000)

                    Citizen.Wait(2000)
                    SetEntityHeading(ped, macas[tonumber(in_area)].deitado[4])
                    SetEntityCoords(ped, macas[tonumber(in_area)].deitado[1],macas[tonumber(in_area)].deitado[2],macas[tonumber(in_area)].deitado[3]-0.9)
                    vRP.playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a",1}},true)

                    Citizen.Wait(2000)
                    DoScreenFadeIn(1000)

                    if vSERVER.checkUNZIK() then
                        deitado = true
                        tratamento = false
                        segundosT = 0
                        TriggerServerEvent("blockcel", true)
                    else
                        deitado = true
                        tratamento = true
                        segundosT = 30
                        vida = 400
                        SetEntityHealth(ped, vida)
                        vSERVER._blockCommands(30)
                        TriggerEvent("Notify","importante","Nenhum medico em expediente, você esta sendo tratado pelos medicos da prefeitura", 5000)
                        TriggerServerEvent("blockcel", true)
                    end
                end

                if IsControlJustReleased(1, 49) and segundos <= 0 then
                    segundos = 5
                    if vSERVER.checkTratamento() then
                        TriggerEvent("Notify","importante","Você iniciou tratamento nesse jogador.", 5000)
                    end
                end
            end

			if GetDistanceBetweenCoords(macas[tonumber(in_area)][1],macas[tonumber(in_area)][2],macas[tonumber(in_area)][3],x,y,z,true) >= 3 then
				in_area = 0
			end
		end
	
		Citizen.Wait(time)
	end
end) 

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEITADO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000

        if deitado and not tratamento and segundosT == 0 then
            time = 5
            drawTxt("VOCÊ ESTÁ ~r~DEITADO~w~, PARA LEVANTAR PRESSIONE ~b~[F6]~w~ OU AGUARDE UM MÉDICO VIR TE ATENDER.",4,0.5,0.96,0.50,255,255,255,180)

            if IsControlJustPressed(0, 167) then
                deitado = false
                segundosT = 0
                tratamento = false
                TriggerServerEvent("blockcel", false)
            end
            
            DisableControlAction(2, 37, true)
            if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
            end
        elseif deitado and tratamento and segundosT > 0 then
            time = 5
            drawTxt("VOCÊ ESTÁ EM ~b~TRATAMENTO~w~, AGUARDE ~b~"..segundosT.."~w~ SEGUNDO(s) PARA SE LEVANTAR.",4,0.5,0.96,0.50,255,255,255,180)

            DisableControlAction(2, 37, true)
            if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
            end
        elseif deitado and segundosT == -1 and not tratamento then
            time = 5
            drawTxt("SEU ~b~TRATAMENTO~w~ ACABOU, PRESSIONE ~b~[F6]~w~ PARA LEVANTAR.",4,0.5,0.96,0.50,255,255,255,180)
   
            if IsControlJustPressed(0, 167) then
                deitado = false
                segundosT = 0
                tratamento = false
                TriggerServerEvent("blockcel", false)
            end

            DisableControlAction(2, 37, true)
            if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
            end
        end

        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.iniciarTratamento()
    deitado = true
    tratamento = true
    segundosT = 30

    vida = 110
    SetEntityHealth(ped, vida)
end

function src.checkPaciente()
    return deitado,tratamento
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()

        if deitado and tratamento and segundosT > 0 then
            segundosT = segundosT - 1

            if vida >= 400 then
                SetEntityHealth(ped, 400)
            else
                vida = vida + 4
                SetEntityHealth(ped, vida)
            end

            if segundosT == 0 then
                tratamento = false
                segundosT = -1
            end
        end

        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkSexo()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        return "H"
    elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        return "M"
    end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if segundos > 0 then
            segundos = segundos - 1

            if segundos <= 0 then
                segundos = 0 
            end
        end

        Citizen.Wait(time)
    end
end)

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end



RegisterNetEvent('vrp_reanimar:reviver')
AddEventHandler('vrp_reanimar:reviver', function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    if health <= 102 then
        TriggerEvent("cancelando", true)  -- Marca que a reanimação está acontecendo
        Citizen.CreateThread(function()
            while GetEntityHealth(ped) < 400 do
                Citizen.Wait(100)  
                local currentHealth = GetEntityHealth(ped)
                SetEntityHealth(ped, currentHealth + 5)  
            end

            SetEntityHealth(ped, 400)
            local x, y, z = table.unpack(GetEntityCoords(ped))
            NetworkResurrectLocalPlayer(x, y, z, true, true, false)
            SetEntityInvincible(ped, false)
            if IsPedRagdoll(ped) then
                ClearPedTasksImmediately(ped)
            end
            local animDict = "missheist_agency3astumble_getup"
            local animName = "stumble_getup"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(8)
            end
            TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
            TriggerEvent("Notify", "sucesso", "Você foi reanimado com sucesso.")
            TriggerEvent("cancelando", false)  
        end)
    else
        TriggerEvent("Notify", "aviso", "Você já está saudável.")
    end
end)


RegisterNetEvent("vrp_reanimar:reviver2")
AddEventHandler("vrp_reanimar:reviver2", function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    
    if health <= 102 then
        TriggerEvent("cancelando", true)
        
        local x, y, z = table.unpack(GetEntityCoords(ped))
        NetworkResurrectLocalPlayer(x, y, z, true, true, false)
        SetEntityInvincible(ped, false)
        
        if IsPedRagdoll(ped) then
            ClearPedTasksImmediately(ped)
        end
        
        local animDict = "missheist_agency3astumble_getup"
        local animName = "stumble_getup"
        RequestAnimDict(animDict)
        
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(8)
        end
        
        TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
        
        TriggerEvent("Notify", "sucesso", "Você foi reanimado com sucesso.")
        TriggerEvent("cancelando", false)
    else
        TriggerEvent("Notify", "aviso", "Você já está saudável.")
    end
end)