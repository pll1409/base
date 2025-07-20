
local user_id 

RegisterNetEvent("loginPly:init",function(userId)
    user_id = userId
    SetRichPresence('[ID: '..user_id.. '] '..GlobalState["playersOn"]..'/2048')
end)

AddStateBagChangeHandler('playersOn', 'global', function(_bagName, _key, _value) -- New handler
    while not user_id do
		SetRichPresence('Se conectando! ('.._value..'/2048)')
		Citizen.Wait(10000)
	end
    SetRichPresence('[ID: '..user_id.. '] '.._value..'/2048')
end)

CreateThread(function()
    SetDiscordAppId(1279971435934388264)

    -- Here you will have to put the image name for the "large" icon.
    SetDiscordRichPresenceAsset('512_1024')
    
    -- (11-11-2018) New Natives:

    -- Here you can add hover text for the "large" icon.
    SetDiscordRichPresenceAssetText('discord.gg/foxzincommunity')
   
    -- Here you will have to put the image name for the "small" icon.
    SetDiscordRichPresenceAssetSmall('512_1024')

    -- Here you can add hover text for the "small" icon.
    SetDiscordRichPresenceAssetSmallText('discord.gg/foxzincommunity')

    SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/cmMtaGZqgD")
    SetDiscordRichPresenceAction(1, "Conectar!", "fivem://connect/localhost")

    -- SetRichPresence('Se conectando! ('..GlobalState["playersOn"]..'/2048)')
    
end)