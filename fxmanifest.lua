fx_version "bodacious"
game "gta5"
ui_page "vipsystem/nui/index.html"
shared_scripts {
    "@vrp/lib/utils.lua",
    "lib/*.lua",
    "rastreador/ngs_cf.lua",
    "anticl/config_anticl.lua",
 }
client_scripts {
    "@vrp/lib/utils.lua",
    "animacoes/client-side/animacoes_client.lua",
    "anticl/client_anticl.lua",
    "carry/client-side/carry_client.lua",
    "safezone/safezone.lua",
    "rastreador/ngs_cl.lua",
    "control/client-side/*.lua",
    "admin/client-side/client_admin.lua",
    "player/client-side/client_player.lua",
    "policia/client-side/client_policia.lua",
    "fps/client-side/client_fps.lua",
    "discord/client-side/discord_client.lua",
    "desmanche/client-side/client_desmanche.lua",
    "desmanche/config-side/config_desmanche.lua",
    "hospital/client-side/client_hospital.lua",
   
}
server_scripts {
    "@vrp/lib/utils.lua",
    "animacoes/server-side/animacoes_server.lua",
    "anticl/server_anticl.lua",
    "carry/server-side/carry_server.lua",
    "control/server-side/*.lua",
    "rastreador/ngs_sv.lua",
    "admin/server-side/server_admin.lua",
    "player/server-side/server_player.lua",
    "policia/server-side/server_policia.lua",
    "desmanche/server-side/server_desmanche.lua",
    "desmanche/config-side/config_desmanche.lua",
    "hospital/server-side/server_hospital.lua",
}
files {
    -- "vipsystem/nui/*",
    "control/data-side/visualsettings.dat",
}