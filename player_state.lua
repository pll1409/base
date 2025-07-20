----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local jogando = false
local in_arena = false

function tvRP.setJogando(boolean)
	jogando = boolean
end

RegisterNetEvent("mirtin_survival:updateArena")
AddEventHandler("mirtin_survival:updateArena", function(boolean)
    in_arena = boolean
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SALVAMENTO DE DADOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local old_health  = 0
    local old_armor   = 0
    local old_clothes = {}
    local old_weapons = {}
    local last_update_time = GetGameTimer()

    while true do
        if not in_arena and jogando then
            if GetGameTimer() - last_update_time >= 1 * 1000 then
                local new_clothes = tvRP.getCustomization()
                local new_health  = GetEntityHealth(PlayerPedId())
                local new_armor   = GetPedArmour(PlayerPedId())
                local plyCds = GetEntityCoords(PlayerPedId())

                -- Atualiza a personalização no servidor
                vRPserver._updateCustomization(new_clothes)
                
                -- Atualiza saúde
                if old_health ~= new_health then
                    old_health = new_health
                    vRPserver._updateHealth(old_health)
                end

                -- Atualiza armadura
                if old_armor ~= new_armor then
                    old_armor = new_armor
                    vRPserver._updateArmor(old_armor)
                end

                -- Atualiza posição
                vRPserver._updatePos(plyCds.x, plyCds.y, plyCds.z)

                -- Atualiza as roupas se mudaram
                if not isTableEquals(old_clothes, new_clothes) then
                    old_clothes = new_clothes
                    vRPserver._updateClothes(old_clothes) -- Chamada para atualizar as roupas
                end

                last_update_time = GetGameTimer()
            end

            -- Atualiza armas se mudaram
            local new_weapons = tvRP.getWeapons()
            if not isTableEquals(old_weapons, new_weapons) then
                old_weapons = new_weapons
                vRPserver._updateWeapons(old_weapons)
            end
        end

        Citizen.Wait(1000) -- Intervalo de 1 segundo entre cada loop
    end 
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ARMAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local weapon_list = {}

local weapon_types = {
	"WEAPON_NAVYREVOLVER",
	"WEAPON_MILITARYRIFLE",
	"WEAPON_HAZARDCAN",
	"WEAPON_GADGETPISTOL",
	"WEAPON_COMBATSHOTGUN",
	"WEAPON_CERAMICPISTOL",
	"GADGET_PARACHUTE",
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_SWITCHBLADE",
	"WEAPON_POOLCUE",
	"WEAPON_PIPEWRENCH",
	"WEAPON_STONE_HATCHET",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_FLARE",
	"WEAPON_BALL",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	
	"WEAPON_FIREWORK",
	"WEAPON_SNOWBALL",

	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_RAYPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_RAYCARBINE",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_PIPEBOMB"
}

function tvRP.getWeapons()
    local player = PlayerPedId()
    local ammo_types = {}
    local weapons = {}
    
    for k, v in pairs(weapon_types) do
        local hash = GetHashKey(v)
        if HasPedGotWeapon(player, hash) then
            local weapon = {}
            weapons[v] = weapon
            local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
            
            if ammo_types[atype] == nil then
                ammo_types[atype] = true
                weapon.ammo = GetAmmoInPedWeapon(player, hash)
            else
                weapon.ammo = 0
            end
        end
    end
    
    return weapons
end

function tvRP.replaceWeapons(weapons)
    local old_weapons = tvRP.getWeapons()
    tvRP.giveWeapons(weapons, true)
    return old_weapons
end

function tvRP.giveWeapons(weapons, clear_before)
    local player = PlayerPedId()
    
    if clear_before then
        RemoveAllPedWeapons(player, true)
        weapon_list = {}
    end

    for k, weapon in pairs(weapons) do
        local hash = GetHashKey(k)
        local ammo = weapon.ammo or 0
        GiveWeaponToPed(player, hash, ammo, false)
        weapon_list[string.upper(k)] = weapon
    end
    TriggerServerEvent("skinweapon:check")
end

function tvRP.getWeaponsLegal()
    return weapon_list
end

function tvRP.legalWeaponsChecker(weapons)
    local weapons_legal = tvRP.getWeaponsLegal()
    local illegal = false
    local weapons_illegal = {}

    for weapon_name, weapon_data in pairs(weapons) do
        if not weapon_list[string.upper(weapon_name)] then
            print("Arma ilegal detectada: " .. string.upper(weapon_name))
            illegal = true
            table.insert(weapons_illegal, {name = string.upper(weapon_name), ammo = weapon_data.ammo})
        end
    end

    if illegal then
        tvRP.giveWeapons(weapons_legal, true) -- Remove armas ilegais
        TriggerServerEvent("LOG:ARMASiawjdwai12312ojwda", weapons_illegal) -- Log das armas ilegais
        return weapons_legal -- Retorna apenas as armas legais
    end

    return weapons -- Retorna as armas se todas forem legais
end

function tvRP.setArmour(amount)
    SetPedArmour(PlayerPedId(), amount)
end

function tvRP.getArmour()
    return GetPedArmour(PlayerPedId())
end

local function parse_part(key)
    if type(key) == "string" and string.sub(key, 1, 1) == "p" then
        return true, tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end

function tvRP.getDrawables(part)
    local isprop, index = parse_part(part)
    if isprop then
        return GetNumberOfPedPropDrawableVariations(PlayerPedId(), index)
    else
        return GetNumberOfPedDrawableVariations(PlayerPedId(), index)
    end
end

function tvRP.getDrawableTextures(part, drawable)
    local isprop, index = parse_part(part)
    if isprop then
        return GetNumberOfPedPropTextureVariations(PlayerPedId(), index, drawable)
    else
        return GetNumberOfPedTextureVariations(PlayerPedId(), index, drawable)
    end
end

function tvRP.getCustomization()
    local ped = PlayerPedId()
    local custom = {}
    custom.modelhash = GetEntityModel(ped)

    -- Verifica se o jogador é um ped válido
    if ped and DoesEntityExist(ped) then
        -- Coleta as variações de drawable para as partes do corpo (máximo de 12 partes em GTA V)
        for i = 0, 11 do
            -- Obtém a variação e as texturas da peça de roupa
            local drawable = GetPedDrawableVariation(ped, i)
            local texture = GetPedTextureVariation(ped, i)
            local palette = GetPedPaletteVariation(ped, i)

            -- Armazena no custom table
            custom[i] = {drawable, texture, palette}
        end

        -- Coleta as variações de props (máximo de 3 props)
        for i = 0, 2 do
            -- Obtém os props e as texturas
            local propIndex = GetPedPropIndex(ped, i)
            local propTexture = GetPedPropTextureIndex(ped, i)

            -- Armazena no custom table
            custom["p" .. i] = {propIndex, math.max(propTexture, 0)}
        end
    else
        print("PlayerPedId() returned an invalid ped.")
    end

    return custom
end

function tvRP.setCustomization(custom)
    local r = async()
    Citizen.CreateThread(function()
        if custom then
            local mhash = nil

            if custom.modelhash then
                mhash = custom.modelhash
            elseif custom.model then
                mhash = GetHashKey(custom.model)
            end

            if mhash then
                -- Carrega o modelo do ped
                while not HasModelLoaded(mhash) do
                    RequestModel(mhash)
                    Citizen.Wait(10)
                end

                if HasModelLoaded(mhash) then
                    -- Salva o estado atual do jogador
                    local weapons = tvRP.getWeapons()
                    local armour = GetPedArmour(PlayerPedId())
                    local health = tvRP.getHealth()

                    -- Aplica o novo modelo
                    ClearPedBloodDamage(PlayerPedId())
                    SetPlayerModel(PlayerId(), mhash)
                    tvRP.setHealth(health)
                    tvRP.giveWeapons(weapons, true)
                    tvRP.setArmour(armour)
                    SetModelAsNoLongerNeeded(mhash)
                end
            end

            -- Aplica as customizações (roupas e acessórios)
            for k, v in pairs(custom) do
                if k ~= "model" and k ~= "modelhash" then
                    local isprop, index = parse_part(k)
                    if isprop then
                        if v[1] < 0 then
                            ClearPedProp(PlayerPedId(), index)
                        else
                            -- Verifica se os valores de prop são válidos
                            if GetNumberOfPedPropDrawableVariations(PlayerPedId(), index) > v[1] and GetNumberOfPedPropTextureVariations(PlayerPedId(), index, v[1]) > v[2] then
                                SetPedPropIndex(PlayerPedId(), index, v[1], v[2], v[3] or 2)
                            else
                                print("Prop index or texture out of range: ", index, v[1], v[2])
                            end
                        end
                    else
                        -- Verifica se os valores de drawable são válidos
                        if GetNumberOfPedDrawableVariations(PlayerPedId(), index) > v[1] and GetNumberOfPedTextureVariations(PlayerPedId(), index, v[1]) > v[2] then
                            SetPedComponentVariation(PlayerPedId(), index, v[1], v[2], v[3] or 2)
                        else
                            print("Component variation out of range: ", index, v[1], v[2])
                        end
                    end
                end
            end

            -- Atualiza tatuagens e rosto
            TriggerEvent("reloadTattos")
            TriggerEvent("reloadFace") 
            
            -- Ajusta outras propriedades do ped
            SetPedMaxHealth(PlayerPedId(), 400)
            NetworkSetFriendlyFireOption(true)
            SetCanAttackFriendly(PlayerPedId(), true, true)
        end
        r()
    end)
    return r:wait()
end
