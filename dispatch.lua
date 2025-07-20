-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NAO ATIRAR COM RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
		local time = 500
        local ped = PlayerPedId()

		if GetSelectedPedWeapon(ped) ~= -1569615261 then
			time = 5
			 
			if IsEntityPlayingAnim(ped, "random@arrests","generic_radio_enter", 3) then
				DisablePlayerFiring(PlayerId() , true)
			end
		end 

		Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR DIRIGIVEL + NPCS 
-----------------------------------------------------------------------------------------------------------------------------------------
-- Atualiza a densidade do tráfego a cada 500 milissegundos
CreateThread(function()
    while true do
        SetTrafficDensity(0.0)
        Wait(500)
    end
end)

-- Configura a densidade do tráfego e o comportamento do blimp
function SetTrafficDensity(density)
    SetParkedVehicleDensityMultiplierThisFrame(density)
    SetVehicleDensityMultiplierThisFrame(density)
    SetRandomVehicleDensityMultiplierThisFrame(density)
    SetVehicleModelIsSuppressed(GetHashKey("blimp"), true)
end

-- Variáveis de configuração
DisableBikeWings = true --false para usar asas em bicicletas, true para não usar
DisableVehicleJump = true --false para ativar saltos de carro, true para não ativar
DisableVehicleTransform = true --false para ativar a transformação, true para não ativar
DisableVehicleWeapons = true --false para ativar armas de carro, true para não ativar

-- Controla a lógica de ações do veículo
CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) then
            time = 0

            -- Desativa controles de acordo com as configurações
            if DisableBikeWings then
                DisableControlAction(0, 354, true)
            end

            if DisableVehicleJump then
                DisableControlAction(0, 350, true)
            end

            if DisableVehicleTransform then
                DisableControlAction(0, 357, true)
            end

            -- Desativa armas do veículo, se necessário
            if DisableVehicleWeapons then
                local veh = GetVehiclePedIsIn(playerPed, false)
                if DoesVehicleHaveWeapons(veh) then
                    local vehicleWeapon, vehicleWeaponHash = GetCurrentPedVehicleWeapon(playerPed)
                    if vehicleWeapon == 1 and vehicleWeaponHash ~= 1422046295 then
                        DisableVehicleWeapon(true, vehicleWeaponHash, veh, playerPed)
                        SetCurrentPedWeapon(playerPed, GetHashKey("weapon_unarmed"))
                    end
                end
            end
        end

        Wait(time)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local idle = 1000
        
        -- Verifica se o jogador está armado
        if IsPedArmed(ped, 6) then
            idle = 5
            DisableControlAction(0, 140, true) -- Desativa o controle de arma primária
            DisableControlAction(0, 141, true) -- Desativa o controle de arma secundária
            DisableControlAction(0, 142, true) -- Desativa o controle de arma corpo a corpo
        end
        
        -- Verifica se o jogador está em um veículo e atirando
        if IsPedInAnyVehicle(ped, false) and IsPedShooting(ped) then
            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.01)
            SetGameplayCamShakeAmplitude(0.08)
        end

        Wait(idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAO RECUPERAR VIDA
-----------------------------------------------------------------------------------------------------------------------------------------
local playerId = PlayerId()

CreateThread(function()
    while true do
        -- Define a taxa de recarga de saúde do jogador para 0
        SetPlayerHealthRechargeMultiplier(playerId, 0)
        -- Aguarda 5 segundos para reduzir a carga de processamento
        Wait(5000)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- STAMINA INFINITA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local playerId = PlayerId()
    local playerPed = PlayerPedId()
    
    while true do
        -- Verifica se o jogador está a pé antes de restaurar a estamina
        if IsPedOnFoot(playerPed) then
            -- Restaura a estamina
            RestorePlayerStamina(playerId, 1.0)
        end

        -- Aguarda por um período mais longo para reduzir a frequência de execução
        Wait(5000) -- Ajuste conforme necessário
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVAR WEAPONS NPCS E DROP
-----------------------------------------------------------------------------------------------------------------------------------------
local playerId = PlayerId()
local lastWantedLevel = GetPlayerWantedLevel(playerId)

CreateThread(function()
    while true do
        Wait(1000) -- Intervalo ajustado para verificar menos frequentemente

        -- Bloqueia o nível de procurado do jogador
        local currentWantedLevel = GetPlayerWantedLevel(playerId)
        if currentWantedLevel ~= lastWantedLevel then
            if currentWantedLevel > 0 then
                SetPlayerWantedLevel(playerId, 0, false)
                SetPlayerWantedLevelNow(playerId, false)
            end
            lastWantedLevel = currentWantedLevel
        end

        -- Permite que NPCs carreguem armas (não remove armas dos NPCs)
        local peds = GetGamePool("CPed") -- Obtém todos os NPCs carregados no jogo
        for _, ped in pairs(peds) do
            if not IsPedAPlayer(ped) then -- Garante que não está afetando jogadores
                if IsPedArmed(ped, 7) then -- 7 cobre todos os tipos de armas
                    SetPedCanSwitchWeapon(ped, true) -- Permite que NPCs usem e troquem de armas
                end
                -- Impede o drop de armas quando o NPC morrer
                SetPedDropsWeaponsWhenDead(ped, false) -- Não deixa armas quando o NPC morre
            end
        end

        -- Impede o jogador de pegar armas de drops
        local items = GetGamePool("CObject") -- Obtém todos os objetos no mundo
        for _, item in pairs(items) do
            if DoesEntityExist(item) then
                -- Verifica se o item é uma arma e está no chão
                if IsWeaponObject(item) then
                    SetEntityCollision(item, false, false) -- Desativa a colisão com o jogador
                    SetEntityInvincible(item, true) -- Torna o item invulnerável, impedindo que o jogador o pegue
                end
            end
        end
    end
end)

-- Função para verificar se o item é uma arma
function IsWeaponObject(object)
    local weaponHash = GetEntityModel(object)
    return IsWeaponValid(weaponHash)
end

-- Função para verificar se a arma é válida
function IsWeaponValid(weaponHash)
    -- Lista de hashes de armas válidas
    local validWeapons = {
        `WEAPON_PISTOL`, `WEAPON_SMG`, `WEAPON_RIFLE`, `WEAPON_SHOTGUN`, `WEAPON_SNIPERRIFLE`, `WEAPON_MACHINEPISTOL`
        -- Adicione mais armas conforme necessário
    }

    for _, validWeapon in ipairs(validWeapons) do
        if weaponHash == validWeapon then
            return true
        end
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FICAR NO BANCO ESCOLHIDO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local time = 500

        if IsPedInAnyVehicle(ped, false) and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, 0) == ped then
                if GetIsTaskActive(ped, 165) then
                    SetPedIntoVehicle(ped, vehicle, 0)
                    time = 100  -- Ajusta o tempo de espera se a condição for atendida
                end
            end
        end

        Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURAR OS PNEUS QUANDO CAPOTA
-----------------------------------------------------------------------------------------------------------------------------------------
local checkInterval = 300  -- Intervalo padrão para verificação

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if IsPedInAnyVehicle(ped, false) then
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local roll = GetEntityRoll(vehicle)
                local speed = GetEntitySpeed(vehicle)

                if (roll > 75.0 or roll < -75.0) and speed < 2 then
                    if IsVehicleTyreBurst(vehicle, 0, false) == false then
                        for i = 0, 5 do
                            SetVehicleTyreBurst(vehicle, i, true)
                            Wait(100)
                        end
                    end
                end

                checkInterval = 100
            else
                checkInterval = 300
            end
        else
            checkInterval = 300
        end

        Wait(checkInterval)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER HUD DANO DE SOCO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	--AddTextEntry("FE_THDR_GTAO","Thunder City prr")
	AddTextEntry('PM_PANE_LEAVE', 'Sair')
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
	SetAudioFlag("PoliceScannerDisabled",true);

	for i = 1,51 do
		if i ~= 10 and i ~= 14 and i ~= 16 and i ~= 19 then
			SetHudComponentPosition(i,  1000.0001, 1000.0001)
		end
	end

	while true do
		DisableControlAction(0,44,true)
		DisableControlAction(0,36,true)
		DisableControlAction(0,157,false)
		
		N_0xf4f2c0d4ee209e20()
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.5) -- REGULA O DANO
		N_0x4757f00bc6323cfe(-1553120962, 0.0) 
		
		DisableVehicleDistantlights(true)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedSuffersCriticalHits(PlayerPedId(), true)
			
		Citizen.Wait(5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ AUTO CAPACETE ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do
		local time = 1000
        
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if veh ~= 0 then 
			time = 5
            SetPedConfigFlag(PlayerPedId(),35,false) 
        end

		Citizen.Wait(time)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
-- Configuração de recuo para armas
local recoilSettings = {
    [453432689] = 0,  -- PISTOL
    [3219281620] = 0, -- PISTOL MK2
    [584646201] = 0, -- AP PISTOL
    -- ... Adicione aqui os outros IDs de armas e seus valores de recuo
}

-- Função para verificar e ajustar a aderência do veículo
local function checkVehicleGrip()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        local speed = GetEntitySpeed(vehicle) * 3.6  -- Converter m/s para km/h
        if GetPedInVehicleSeat(vehicle, -1) == ped and speed <= 40.0 then
            -- Ajusta a aderência com base no controle pressionado
            SetVehicleReduceGrip(vehicle, IsControlPressed(1, 21))
        end
    end
end

-- Função para aplicar recuo às armas
local function applyWeaponRecoil()
    local ped = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(ped)
    local recoilValue = recoilSettings[weaponHash]
    if recoilValue ~= nil and recoilValue ~= 0 then
        N_0x4757f00bc6323cfe(weaponHash, recoilValue)
    end
end

-- Função principal para gerenciar veículos, armas e recuo
CreateThread(function()
    while true do
        -- Verificar e ajustar a aderência do veículo
        checkVehicleGrip()

        -- Verificar e aplicar recuo à arma
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) and IsPedShooting(ped) then
            local weaponHash = GetSelectedPedWeapon(ped)
            local weaponRecoil = recoilSettings[weaponHash]
            if weaponRecoil and weaponRecoil ~= 0 then
                Wait(1000)  -- Aguarda 1 segundo para aplicar o recuo
                local currentPitch = GetGameplayCamRelativePitch()
                if not IsPedInAnyHeli(ped) then
                    SetGameplayCamRelativePitch(currentPitch + weaponRecoil, 1.2)
                end
            end
        end

        -- Aguarda para equilibrar desempenho e resposta
        Wait(100)  -- Ajuste o tempo de espera conforme necessário
    end
end)

