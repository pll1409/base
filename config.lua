Config = {}

Config.commandName = "servico" -- Alterar o comando (padrão é /servico).

Config.permissionMessage = "Você não tem permissão para isso." -- Alterar mensagem de falta de permissão.

Config.noDistanceAreaMessage = "Você deve estar na área da sua organização para entrar ou sair de serviço!" -- Alterar mensagem de fora da área de cada org.

Config.organizations = {
    PMERJ = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",                         --METROS--
        area = { centerX = -1641.87, centerY = 179.82, centerZ = 61.62, radius = 50 },  -- -1641.87,179.82,61.62 PMERJ
        groups = {
            ["ComandoPMERJ"] = "PComandoPMERJ",
            ["CoronelPMERJ"] = "PCoronelPMERJ",
            ["TenenteCoronelPMERJ"] = "PTenenteCoronelPMERJ",
            ["MajorPMERJ"] = "PMajorPMERJ",
            ["CapitaoPMERJ"] = "PCapitaoPMERJ",
            ["PrimeiroTenentePMERJ"] = "PPrimeiroTenentePMERJ",
            ["SegundoTenentePMERJ"] = "PSegundoTenentePMERJ",
            ["SubTenentePMERJ"] = "PSubTenentePMERJ",
            ["PrimeiroSargentoPMERJ"] = "PPrimeiroSargentoPMERJ",
            ["SegundoSargentoPMERJ"] = "PSegundoSargentoPMERJ",
            ["TerceiroSargentoPMERJ"] = "PTerceiroSargentoPMERJ",
            ["CaboPMERJ"] = "PCaboPMERJ",
            ["SoldadoPMERJ"] = "PSoldadoPMERJ",
            ["AlunoPMERJ"] = "PAlunoPMERJ",
            ["PComandoPMERJ"] = "ComandoPMERJ",
            ["PCoronelPMERJ"] = "CoronelPMERJ",
            ["PTenenteCoronelPMERJ"] = "TenenteCoronelPMERJ",
            ["PMajorPMERJ"] = "MajorPMERJ",
            ["PCapitaoPMERJ"] = "CapitaoPMERJ",
            ["PPrimeiroTenentePMERJ"] = "PrimeiroTenentePMERJ",
            ["PSegundoTenentePMERJ"] = "SegundoTenentePMERJ",
            ["PSubTenentePMERJ"] = "SubTenentePMERJ",
            ["PPrimeiroSargentoPMERJ"] = "PrimeiroSargentoPMERJ",
            ["PSegundoSargentoPMERJ"] = "SegundoSargentoPMERJ",
            ["PTerceiroSargentoPMERJ"] = "TerceiroSargentoPMERJ",
            ["PCaboPMERJ"] = "CaboPMERJ",
            ["PSoldadoPMERJ"] = "SoldadoPMERJ",
            ["PAlunoPMERJ"] = "AlunoPMERJ"
        },
        webhook = "https://discord.com/api/webhooks/1263722776079106078/-uXx4IML2hRjCW70Idmkx0WwWvYOz7ks8eBKHdkTVJcY5Eb6_glUGZUHcd-tuOuEYda8"
    },
    Exercito = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = -2174.38, centerY = 3186.66, centerZ = 32.81, radius = 50 }, -- -2174.38,3186.66,32.81  EXERCITO
        groups = {
            ["Coronel"] = "PCoronel",
            ["TenenteCoronel"] = "PTenenteCoronel",
            ["Major"] = "PMajor",
            ["Capitao"] = "PCapitao",
            ["PrimeiroTenente"] = "PPrimeiroTenente",
            ["SegundoTenente"] = "PSegundoTenente",
            ["SubTenente"] = "PSubTenente",
            ["PrimeiroSargento"] = "PPrimeiroSargento",
            ["SegundoSargento"] = "PSegundoSargento",
            ["TerceiroSargento"] = "PTerceiroSargento",
            ["Cabo"] = "PCabo",
            ["Soldado"] = "PSoldado",
            ["PCoronel"] = "Coronel",
            ["PTenenteCoronel"] = "TenenteCoronel",
            ["PMajor"] = "Major",
            ["PCapitao"] = "Capitao",
            ["PPrimeiroTenente"] = "PrimeiroTenente",
            ["PSegundoTenente"] = "SegundoTenente",
            ["PSubTenente"] = "SubTenente",
            ["PPrimeiroSargento"] = "PrimeiroSargento",
            ["PSegundoSargento"] = "SegundoSargento",
            ["PTerceiroSargento"] = "TerceiroSargento",
            ["PCabo"] = "Cabo",
            ["PSoldado"] = "Soldado"
        },
        webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
    BOPE = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = 2515.36, centerY = -421.08, centerZ = 94.39, radius = 50 }, -- 2515.36,-421.08,94.39     BOPE
        groups = {
            ["CoronelBope"] = "PCoronelBope",
            ["Ten.CoronelBope"] = "PTen.CoronelBope",
            ["MajorBope"] = "PMajorBope",
            ["CapitaoBope"] = "PCapitaoBope",
            ["TenenteBope"] = "PTenenteBope",
            ["SargentoBope"] = "PSargentoBope",
            ["CaboBope"] = "PCaboBope",
            ["SoldadoBope"] = "PSoldadoBope",
            ["RecrutaBope"] = "PRecrutaBope",
            ["PCoronelBope"] = "CoronelBope",
            ["PTen.CoronelBope"] = "Ten.CoronelBope",
            ["PMajorBope"] = "MajorBope",
            ["PCapitaoBope"] = "CapitaoBope",
            ["PTenenteBope"] = "TenenteBope",
            ["PSargentoBope"] = "SargentoBope",
            ["PCaboBope"] = "CaboBope",
            ["PSoldadoBope"] = "SoldadoBope",
            ["PRecrutaBope"] = "RecrutaBope"
        },
        webhook = "https://discord.com/api/webhooks/1263725306405982239/ltxyCWf09EmUib_75Bh5KdALjsdvZpFawXaQPxbRXPmUkSnSs1BE2nJH5oOkKRhE9hvf"
    },
    PF = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = -429.65, centerY = 1108.65, centerZ = 327.8, radius = 50 },  -- -429.65,1108.65,327.8 POLICIA FEDERAL
        groups = {
            ["ComandoGeralPF"] = "PComandoGeralPF",
            ["DelegadoPF"] = "PDelegadoPF",
            ["DelegadoADJ.PF"] = "PDelegadoADJ.PF",
            ["PeritoPF"] = "PPeritoPF",
            ["EscrivaoPF"] = "PEscrivaoPF",
            ["InspetorPF"] = "PInspetorPF",
            ["Agente.Cl1"] = "PAgente.Cl1",
            ["Agente.Cl2"] = "PAgente.Cl2",
            ["Agente.Cl3"] = "PAgente.Cl3",
            ["Agente.Cl4"] = "PAgente.Cl4",
            ["Agente.Cl5"] = "PAgente.Cl5",
            ["AlunoPF"] = "PAlunoPF",
            ["PComandoGeralPF"] = "ComandoGeralPF",
            ["PDelegadoPF"] = "DelegadoPF",
            ["PDelegadoADJ.PF"] = "DelegadoADJ.PF",
            ["PPeritoPF"] = "PeritoPF",
            ["PEscrivaoPF"] = "EscrivaoPF",
            ["PInspetorPF"] = "InspetorPF",
            ["PAgente.Cl1"] = "Agente.Cl1",
            ["PAgente.Cl2"] = "Agente.Cl2",
            ["PAgente.Cl3"] = "Agente.Cl3",
            ["PAgente.Cl4"] = "Agente.Cl4",
            ["PAgente.Cl5"] = "Agente.Cl5",
            ["PAlunoPF"] = "AlunoPF"
        },
        webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
    PRF = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = 2909.2, centerY = 4162.59, centerZ = 50.6, radius = 50 },  -- 2909.2,4162.59,50.6  PRF
        groups = {
            ["ComandoGeralPRF"] = "PComandoGeralPRF",
            ["Sub.ComandoPRF"] = "PSub.ComandoPRF",
            ["DiretorPRF"] = "PDiretorPRF",
            ["InspetorPRF"] = "PInspetorPRF",
            ["Agente.especialPRF"] = "PAgente.especialPRF",
            ["Clase3.PRF"] = "PClase3.PRF",
            ["Clase2.PRF"] = "PClase2.PRF",
            ["Clase1.PRF"] = "PClase1.PRF",
            ["PComandoGeralPRF"] = "ComandoGeralPRF",
            ["PSub.ComandoPRF"] = "Sub.ComandoPRF",
            ["PDiretorPRF"] = "DiretorPRF",
            ["PInspetorPRF"] = "InspetorPRF",
            ["PAgente.especialPRF"] = "Agente.especialPRF",
            ["PClase3.PRF"] = "Clase3.PRF",
            ["PClase2.PRF"] = "Clase2.PRF",
            ["PClase1.PRF"] = "Clase1.PRF"
        }, 
         webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
    PC = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = -912.46, centerY = -2040.87, centerZ = 9.4, radius = 50 },  -- ['x'] = -912.46, ['y'] = -2040.87, ['z'] = 9.4  CIVIL
        groups = {
            ["DelegadoGeral"] = "PDelegadoGeral",
            ["ComandanteCore"] = "PComandanteCore",
            ["SubComandanteCore"] = "PSubComandanteCore",
            ["Delegado"] = "PDelegado",
            ["Core"] = "PCore",
            ["Perito"] = "PPerito",
            ["Escrivao"] = "PEscrivao",
            ["Investigador"] = "PInvestigador",
            ["Agente"] = "PAgente",
            ["Recruta"] = "PRecruta",
            ["PDelegadoGeral"] = "DelegadoGeral",
            ["PComandanteCore"] = "ComandanteCore",
            ["PSubComandanteCore"] = "SubComandanteCore",
            ["PDelegado"] = "Delegado",
            ["PCore"] = "Core",
            ["PPerito"] = "Perito",
            ["PEscrivao"] = "Escrivao",
            ["PInvestigador"] = "Investigador",
            ["PAgente"] = "Agente",
            ["PRecruta"] = "Recruta"
        },
        webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
    Hospital = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = -453.38, centerY = -340.08, centerZ = 34.36, radius = 50 },  -- ['x'] = -453.38, ['y'] = -340.08, ['z'] = 34.36  HOSPITAL
        groups = {
            ["Diretor"] = "PDiretor",
            ["ViceDiretor"] = "PViceDiretor",
            ["Medico"] = "PMedico",
            ["Enfermeiro"] = "PEnfermeiro",
            ["Socorrista"] = "PSocorrista",
            ["Estagiario"] = "PEstagiario",
            ["PDiretor"] = "Diretor",
            ["PViceDiretor"] = "ViceDiretor",
            ["PMedico"] = "Medico",
            ["PEnfermeiro"] = "Enfermeiro",
            ["PSocorrista"] = "Socorrista",
            ["PEstagiario"] = "Estagiario"
        },
        webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
    Bombeiros = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = 1548.3, centerY = 823.38, centerZ = 78.5, radius = 50 },  -- ['x'] = 1548.3, ['y'] = 823.38, ['z'] = 78.5 BOMBEIRO
        groups = {
            ["CoronelBombeiros"] = "PCoronelBombeiros",
            ["MajorBombeiros"] = "PMajorBombeiros",
            ["SargentoBombeiros"] = "PSargentoBombeiros",
            ["TenenteBombeiros"] = "PTenenteBombeiros",
            ["SubTenenteBombeiros"] = "PSubTenenteBombeiros",
            ["SocorristaBombeiros"] = "PSocorristaBombeiros",
            ["PCoronelBombeiros"] = "CoronelBombeiros",
            ["PMajorBombeiros"] = "MajorBombeiros",
            ["PSargentoBombeiros"] = "SargentoBombeiros",
            ["PTenenteBombeiros"] = "TenenteBombeiros",
            ["PSubTenenteBombeiros"] = "SubTenenteBombeiros",
            ["PSocorristaBombeiros"] = "SocorristaBombeiros"
        },
        webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
    Custom = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",
        area = { centerX = 968.43, centerY = -1021.59, centerZ = 40.84, radius = 50 },  -- ['x'] = 968.43, ['y'] = -1021.59, ['z'] = 40.84 MECANICA
        groups = {
            ["LiderCustom"] = "PLiderCustom",
            ["SubLiderCustom"] = "PSubLiderCustom",
            ["GerenteCustom"] = "PGerenteCustom",
            ["MecanicoCustom"] = "PMecanicoCustom",
            ["AprendizCustom"] = "PAprendizCustom",
            ["PLiderCustom"] = "LiderCustom",
            ["PSubLiderCustom"] = "SubLiderCustom",
            ["PGerenteCustom"] = "GerenteCustom",
            ["PMecanicoCustom"] = "MecanicoCustom",
            ["PAprendizCustom"] = "AprendizCustom"
        },
        webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
    StreetRacing = {
        enterMessage = "Você entrou em serviço!",
        exitMessage = "Você saiu de serviço!",        
        area = { centerX = 768.91, centerY = -805.04, centerZ = 26.35, radius = 50 },  -- ['x'] = 768.91, ['y'] = -805.04, ['z'] = 26.35 MECANICO
        groups = {
            ["LiderStreetRacing"] = "PLiderStreetRacing",
            ["SubLiderStreetRacing"] = "PSubLiderStreetRacing",
            ["GerenteStreetRacing"] = "PGerenteStreetRacing",
            ["MecanicoStreetRacing"] = "PMecanicoStreetRacing",
            ["AprendizStreetRacing"] = "PAprendizStreetRacing",
            ["PLiderStreetRacing"] = "LiderStreetRacing",
            ["PSubLiderStreetRacing"] = "SubLiderStreetRacing",
            ["PGerenteStreetRacing"] = "GerenteStreetRacing",
            ["PMecanicoStreetRacing"] = "MecanicoStreetRacing",
            ["PAprendizStreetRacing"] = "AprendizStreetRacing"
        },
        webhook = "https://discord.com/api/webhooks/WEBHOOK_ID_PMERJ"
    },
}