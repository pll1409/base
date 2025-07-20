-- Helper function to check if the player is in a safezone
local function isInSafezone()
    return incorda
end

-- Helper function to handle animation dictionary loading
local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

-- Helper function to get the closest player within a radius
local function getClosestPlayer(radius)
    local players = GetActivePlayers()
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
    local closestPlayer, closestDistance = -1, -1

    for _, playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= PlayerPedId() then
            local targetCoords = GetEntityCoords(targetPed, 0)
            local distance = GetDistanceBetweenCoords(targetCoords, plyCoords, true)
            if (closestDistance == -1 or distance < closestDistance) and distance <= radius then
                closestPlayer, closestDistance = playerId, distance
            end
        end
    end
    return closestPlayer
end

-- Command to start/stop carrying
RegisterNetEvent('carregar_ombro')
AddEventHandler('carregar_ombro', function()
    if carryingBackInProgress then
        -- Stop carrying
        carryingBackInProgress = false
        TriggerEvent('cancelando', false)
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
        local closestPlayer = getClosestPlayer(3)
        if closestPlayer ~= -1 then
            TriggerServerEvent("cmg2_animations:stop479", GetPlayerServerId(closestPlayer))
        end
    elseif not isInSafezone() then
        if vTunnel.checkItem2() then
            carryingBackInProgress = true
            TriggerEvent('cancelando', true)
            local playerPed = PlayerPedId()
            local closestPlayer = getClosestPlayer(3)
            if closestPlayer ~= -1 then
                local target = GetPlayerServerId(closestPlayer)
                local params = {
                    lib = 'missfinale_c2mcs_1',
                    anim1 = 'fin_c2_mcs_1_camman',
                    lib2 = 'nm',
                    anim2 = 'firemans_carry',
                    distans = 0.15,
                    distans2 = 0.27,
                    height = 0.63,
                    spin = 0.0,
                    length = 100000,
                    controlFlagMe = 49,
                    controlFlagTarget = 33,
                    animFlagTarget = 1
                }
                TriggerServerEvent('carregar_ombro', target, params.lib, params.lib2, params.anim1, params.anim2, params.distans, params.distans2, params.height, target, params.length, params.spin, params.controlFlagMe, params.controlFlagTarget, params.animFlagTarget)
            else
                TriggerEvent("Notify", "negado", "Ninguém por perto", 5000)
            end
        else
            TriggerEvent("Notify", "negado", "Você não possui Cordas na mochila.", 5000)
        end
    else
        TriggerEvent("Notify", "negado", "Você não pode carregar alguém dentro de uma safezone!", 5000)
    end
end)

-- Sync target animation
RegisterNetEvent('cmg2_animations:syncTarget479')
AddEventHandler('cmg2_animations:syncTarget479', function(target, animationLib, animation2, distans, distans2, height, length, spin, controlFlag)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
    carryingBackInProgress = true
    loadAnimDict(animationLib)
    spin = spin or 180.0
    AttachEntityToEntity(playerPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
    controlFlag = controlFlag or 0
    TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

-- Sync player animation
RegisterNetEvent('cmg2_animations:syncMe479')
AddEventHandler('cmg2_animations:syncMe479', function(animationLib, animation, length, controlFlag, animFlag)
    local playerPed = PlayerPedId()
    loadAnimDict(animationLib)
    controlFlag = controlFlag or 0
    TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
    Wait(length)
end)

-- Stop carrying animation
RegisterNetEvent('cmg2_animations:cl_stop479')
AddEventHandler('cmg2_animations:cl_stop479', function()
    carryingBackInProgress = false
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
end)

-- Export function to set carrying status
exports("setcarregar2", function(status)
    incorda = status
end)
