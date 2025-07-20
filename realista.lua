local pedInSameVehicleLast = false
local vehicle
local lastVehicle
local vehicleClass

local quebrado = false
local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local function isPedDrivingAVehicle()
	local ped = PlayerPedId()
	vehicle = GetVehiclePedIsIn(ped)
	if IsPedInAnyVehicle(ped) then
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local class = GetVehicleClass(vehicle)
			if class ~= 13 and class ~= 14 then
				return true
			end
		end
	end
	return false
end

CreateThread(function()
    while true do
        local time = 1000 -- Tempo de espera padrão para reduzir a carga do loop

        if pedInSameVehicleLast then
            time = 10 -- Reduz a espera apenas quando o jogador está no veículo
            local factor = 1.0

            -- Ajusta o fator de torque do motor com base na saúde do motor
            if healthEngineNew < 900 then
                factor = (healthEngineNew + 200.0) / 1100
            end

            -- Aplica o multiplicador de torque ao motor do veículo
            SetVehicleEngineTorqueMultiplier(vehicle, factor)

            -- Verifica a inclinação do veículo
            local roll = GetEntityRoll(vehicle)
            if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
                DisableControlAction(2, 59, true) -- Desativa controle de direção à esquerda/direita
                DisableControlAction(2, 60, true) -- Desativa controle de direção para frente/trás
            end
        end

        Wait(time) -- Aguarda o tempo determinado antes de continuar o loop
    end
end)


CreateThread(function()
	while true do
		local roll = GetEntityRoll(vehicle)
		if roll > 75.0 or roll < -75.0 then
			local tyre = math.random(4)
			if math.random(100) <= 50 then
				if tyre == 1 then
					if not IsVehicleTyreBurst(vehicle,0,false) then
						SetVehicleTyreBurst(vehicle,0,true,1000.0)
					end
				elseif tyre == 2 then
					if not IsVehicleTyreBurst(vehicle,1,false) then
						SetVehicleTyreBurst(vehicle,1,true,1000.0)
					end
				elseif tyre == 3 then
					if not IsVehicleTyreBurst(vehicle,4,false) then
						SetVehicleTyreBurst(vehicle,4,true,1000.0)
					end
				elseif tyre == 4 then
					if not IsVehicleTyreBurst(vehicle,5,false) then
						SetVehicleTyreBurst(vehicle,5,true,1000.0)
					end
				end
			end
		end

		Wait(2000)
	end
end)

CreateThread(function()
	while true do
        local time = 5
		local ped = PlayerPedId()
		if isPedDrivingAVehicle() then
            time = 10
			vehicle = GetVehiclePedIsIn(ped)
			vehicleClass = GetVehicleClass(vehicle)
			healthEngineCurrent = GetVehicleEngineHealth(vehicle)

			if healthEngineCurrent >= 1000 then
				healthEngineLast = 1000.0
			end

			healthEngineNew = healthEngineCurrent
			healthEngineDelta = healthEngineLast - healthEngineCurrent
			healthEngineDeltaScaled = healthEngineDelta * 1.3 * 1.3
			healthBodyCurrent = GetVehicleBodyHealth(vehicle)

			if healthBodyCurrent == 1000 then
				healthBodyLast = 1000.0
			end

			healthBodyNew = healthBodyCurrent
			healthBodyDelta = healthBodyLast - healthBodyCurrent
			healthBodyDeltaScaled = healthBodyDelta * 1.3 * 1.3

			if healthEngineCurrent > 101.0 and quebrado then
				SetVehicleUndriveable(vehicle,false)
				quebrado = false
			end

			if healthEngineCurrent <= 101.0 then
				SetVehicleUndriveable(vehicle,true)
				quebrado = true
			end

			if vehicle ~= lastVehicle then
				pedInSameVehicleLast = false
			end

			if pedInSameVehicleLast then
				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 then
					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled,healthBodyDeltaScaled)
					if healthEngineCombinedDelta > (healthEngineCurrent - 100.0) then
						healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
					end

					if healthEngineCombinedDelta > healthEngineCurrent then
						healthEngineCombinedDelta = healthEngineCurrent - (210.0 / 5)
					end
					healthEngineNew = healthEngineLast - healthEngineCombinedDelta

					if healthEngineNew > (210.0 + 5) and healthEngineNew < 477.0 then
						healthEngineNew = healthEngineNew-(0.038 * 3.2)
					end

					if healthEngineNew < 210.0 then
						healthEngineNew = healthEngineNew-(0.1 * 0.9)
					end

					if healthEngineNew < 100.0 then
						healthEngineNew = 100.0
					end

					if healthBodyNew < 0 then
						healthBodyNew = 0.0
					end
				end
			else
				if healthBodyCurrent < 210.0 then
					healthBodyNew = 210.0
				end
				pedInSameVehicleLast = true
			end

			if healthEngineNew ~= healthEngineCurrent then
				SetVehicleEngineHealth(vehicle,healthEngineNew)
			end

			if healthBodyNew ~= healthBodyCurrent then
				SetVehicleBodyHealth(vehicle,healthBodyNew)
			end

			healthEngineLast = healthEngineNew
			healthBodyLast = healthBodyNew
			lastVehicle = vehicle
		else
			pedInSameVehicleLast = false
		end

		Wait(time)
	end
end)