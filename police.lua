-- Noclip Toggle Function
local noclip = false

function tvRP.toggleNoclip()
    noclip = not noclip
    local ped = PlayerPedId()
    if noclip then
        SetEntityInvincible(ped, true)  -- Player is invincible in noclip
        SetEntityVisible(ped, false, false)
    else
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
    end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if noclip then
            time = 5
            local ped = PlayerPedId()
            local x, y, z = tvRP.getPosition()
            local dx, dy, dz = tvRP.getCamDirection()
            local speed = 1.0

            SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001) -- Neutralize inertia

            -- Speed boost with Shift key
            if IsControlPressed(0, 21) then
                speed = 5.0
            end

            -- Forward movement (W key)
            if IsControlPressed(0, 32) then
                x = x + speed * dx
                y = y + speed * dy
                z = z + speed * dz
            end

            -- Backward movement (S key)
            if IsControlPressed(0, 269) then
                x = x - speed * dx
                y = y - speed * dy
                z = z - speed * dz
            end

            -- Set new position without physics interference
            SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
        end
        Citizen.Wait(time)
    end
end)

-- Handcuff Toggle Functionality
local handcuffed = false

function tvRP.toggleHandcuff()
    handcuffed = not handcuffed
    SetEnableHandcuffs(PlayerPedId(), handcuffed)
    if handcuffed then
        if GetEntityHealth(PlayerPedId()) >= 105 then
            tvRP.playAnim(true, {{"mp_arresting", "idle"}}, true)
        end
    else
        tvRP.stopAnim(true)
    end
end

function tvRP.setHandcuffed(flag)
    if handcuffed ~= flag then
        tvRP.toggleHandcuff()
    end
end

function tvRP.isHandcuffed()
    return handcuffed
end

Citizen.CreateThread(function()
    while true do
        local time = 10000
        if handcuffed then
            time = 3000
            if GetEntityHealth(PlayerPedId()) >= 105 then
                tvRP.playAnim(true, {{"mp_arresting", "idle"}}, true)
            end
        end
        Citizen.Wait(time)
    end
end)

-- Function to Place Player into Nearest Vehicle as a Passenger
function tvRP.putInNearestVehicleAsPassenger(radius)
    local veh = tvRP.getNearestVehicle(radius)
    if IsEntityAVehicle(veh) then
        for i = 1, math.max(GetVehicleMaxNumberOfPassengers(veh), 3) do
            if IsVehicleSeatFree(veh, i) then
                SetPedIntoVehicle(PlayerPedId(), veh, i)
                return true
            end
        end
    end
    return false
end

-- Weapon Check Functions
function tvRP.checkWeapon(weapon)
    local ped = PlayerPedId()
    return GetSelectedPedWeapon(ped) == GetHashKey(weapon)
end 

function tvRP.getAmmo(weapon)
    local ped = PlayerPedId()
    return GetAmmoInPedWeapon(ped, GetHashKey(weapon))
end 

-- Trunk Toggle Functionality
local mala = false

function tvRP.toggleMalas()
    mala = not mala
    local ped = PlayerPedId()
    local vehicle = tvRP.getNearestVehicle(7)

    if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) ~= 8 and GetVehicleClass(vehicle) ~= 13 then
        if mala then
            AttachEntityToEntity(ped, vehicle, GetEntityBoneIndexByName(vehicle, "bumper_r"), 0.6, -0.4, -0.1, 60.0, -90.0, 180.0, false, false, false, true, 2, true)
            SetEntityVisible(ped, false)
            SetEntityInvincible(ped, true) -- Ensures player safety inside the trunk
        else
            DetachEntity(ped, true, true)
            SetEntityVisible(ped, true)
            SetEntityInvincible(ped, false)
        end
        TriggerServerEvent("trymala", VehToNet(vehicle))
    end

    -- Disable exiting the vehicle while in trunk
    CreateThread(function()
        while mala do
            DisableControlAction(0, 75) -- Disable F key
            Wait(0)
        end
    end)
end

RegisterNetEvent("syncmala")
AddEventHandler("syncmala", function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToVeh(index)
        if DoesEntityExist(v) and IsEntityAVehicle(v) then
            SetVehicleDoorOpen(v, 5, 0, 0)
            Citizen.Wait(1000)
            SetVehicleDoorShut(v, 5, 0)
        end
    end
end)

function tvRP.setMalas(flag)
    if mala ~= flag then
        tvRP.toggleMalas()
    end
end

function tvRP.isMalas()
    return mala
end

-- Check if Player is in a Vehicle
function tvRP.getNoCarro()
    return IsPedInAnyVehicle(PlayerPedId())
end

-- Hood Toggle Functionality
local capuz = false

function tvRP.setCapuz(flag)
    if flag then
        capuz = true
        tvRP.setDiv("capuz", ".div_capuz { background: #000; margin: 0; width: 100%; height: 100%; }", "")
        SetPedComponentVariation(PlayerPedId(), 1, 69, 2, 2) -- Apply hood visual
    else
        capuz = false
        tvRP.removeDiv("capuz")
        SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2) -- Remove hood visual
    end
end

function tvRP.isCapuz()
    return capuz
end

-- Control Blocker for Specific States (Trunk, Hood, Handcuffed)
Citizen.CreateThread(function()
    while true do
        local time = 1000

        if mala or capuz or handcuffed then
            time = 5
            BlockWeaponWheelThisFrame()
            local disabledControls = {
                20, 21, 22, 23, 24, 25, 29, 32, 33, 34, 35, 56, 57, 58, 73, 75, 137,
                140, 141, 142, 143, 166, 167, 170, 177, 178, 182, 187, 188, 189, 190,
                243, 257, 263, 264, 268, 269, 270, 271, 288, 289, 311, 344
            }
            for _, control in ipairs(disabledControls) do
                DisableControlAction(0, control, true)
            end
        end

        Citizen.Wait(time)
    end
end)
