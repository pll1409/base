local cfg = {}

cfg.groups = {
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ADMINISTRAÇÃO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["owner"] = { _config = { gtype = "staff", salario = 0 }, "admin.permissao", "dv.permissao","player.som", "ticket.permissao", "developer.permissao","player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff", "player.som", "perm.algemar", "perm.portearmas" },
	["owneroff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff" },
	["admin"] = { _config = { gtype = "staff", salario = 15000 }, "admin.permissao", "dv.permissao","player.som", "ticket.permissao", "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff", "perm.algemar", "player.som" },
	["adminoff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff" },
	["moderador"] = { _config = { gtype = "staff", salario = 12000 }, "moderador.permissao", "player.som","dv.permissao", "ticket.permissao", "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff", "perm.algemar", "player.som" },
	["moderadoroff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff" },
	["suporte"] = { _config = { gtype = "staff", salario = 8000 }, "suporte.permissao", "dv.permissao", "player.som","ticket.permissao", "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff", "perm.algemar", "player.som" },
	["suporteoff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff" },
	["user"] = { "perm.user"},
	["streamer"] = { _config = { gtype = "staff" }, "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall", "mqcu.permissao", "streamer.permissao", "perm.algemar", "player.som" },
	["investidoranjo"] = { _config = { gtype = "staff" }, "investidoranjo.permissao" },


	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- VIPS 
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---- VIPS  
	["GaragemVip"] = { _config = { salario = 0, ptr = nil }, "perm.garagemvip" },
	["Inicial"] = { _config = { gtype = "Inicial", salario = 4000, ptr = nil }, "perm.vips", "perm.inicial" },
	["VipNatal"] = { _config = { gtype = "Vip Natal", salario = 50000, ptr = nil }, "perm.vips", "perm.vipnatal", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["VipWipe"] = { _config = { gtype = "Vip Wipe", salario = 20000, ptr = nil }, "perm.vips", "perm.vipwipe", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	--["VipCrianca"] = { _config = { gtype = "Vip Crianca", salario = 3000, ptr = nil }, "perm.vips", "perm.crianca", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["VipBronze"] = { _config = { gtype = "Vip Bronze", salario = 12000, ptr = nil }, "perm.bronze", "perm.booster", "perm.roupas", "player.som"},
	["VipPrata"] = { _config = { gtype = "Vip Prata", salario = 14000, ptr = nil }, "perm.prata", "perm.booster", "perm.roupas", "player.som" },
    ["VipOuro"] = { _config = { gtype = "Vip Ouro", salario = 17000, ptr = nil }, "perm.vipouro", "perm.booster", "perm.roupas","player.som" },
	["VipPlatina"] = { _config = { gtype = "Vip Platina", salario = 22000, ptr = nil }, "perm.vips", "perm.vipplatina", "perm.booster", "perm.roupas", "player.som" },
	["VipDiamante"] = { _config = { gtype = "Vip Diamante", salario = 24000, ptr = nil }, "perm.vips", "perm.vipdiamante", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["Vipthunder"] = { _config = { gtype = "Vip thunder", salario = 25000, ptr = nil }, "perm.vips", "perm.vipthunder", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["VipSupremothunder"] = { _config = { gtype = "VipSupremo thunder", salario = 32000, ptr = nil }, "perm.vips", "perm.vipsupremothunder", "perm.booster", "perm.roupas", "perm.mochila","player.som", "perm.fixvip" },
	["VipMonster"] = { _config = { gtype = "Vip Monster", salario = 37000, ptr = nil }, "perm.vips", "perm.vipmonster", "perm.booster", "perm.roupas", "perm.mochila","player.som", "perm.fixvip" },
	["VipGod"] = { _config = { gtype = "Vip God", salario = 47000, ptr = nil }, "perm.vips","perm.vipgod","perm.booster", "perm.roupas", "perm.mochila","player.som", "perm.fixvip" },
	["VipRubi"] = { _config = { gtype = "Vip Rubi", salario = 69000, ptr = nil }, "perm.vips","perm.viprubi","perm.booster", "perm.roupas", "perm.mochila","player.som", "perm.fixvip" },
	["VipEsmeralda"] = { _config = { gtype = "Vip Esmeralda", salario = 80000, ptr = nil }, "perm.vips","perm.vipesmeralda", "perm.booster", "perm.roupas", "perm.mochila","player.som", "perm.fixvip" },
	

     ["PilotoParticular"] = { _config = { salario = 0, ptr = nil }, "piloto.permissao" },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BENEFICIOS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["Estagiario"] = { _config = { gtype = "jobdois", salario = 2000, ptr = nil }, "perm.estagiario"},
	["Funcionario"] = { _config = { gtype = "jobtres", salario = 4000, ptr = nil }, "perm.funcionario"},
	["Gerente"] = { _config = { gtype = "jobquatro", salario = 6000, ptr = nil }, "perm.gerente"},
	["Patrao"] = { _config = { gtype = "jobcinco", salario = 8000, ptr = nil }, "perm.patrao"},
	["CasaDoFranklin"] = { _config = { gtype = "jobseis", salario = 0, ptr = nil }, "perm.franklin"},
	["spotify"] = { _config = { gtype = "spotify", salario = 0, ptr = nil },"player.som", "perm.spotify" },
	["Booster"] = { _config = { salario = 0, ptr = nil }, "perm.booster" },
	["Verificado"] = { _config = { salario = 0, ptr = nil }, "perm.verificado"},
	["Vagas"] = { _config = { salario = 0, ptr = nil }, "perm.vagastres"},
	["VagasQuarenta"] = { _config = { salario = 0, ptr = nil }, "perm.vagasquarenta"}, 
	
	["valecasa"] = { _config = { salario = 0, ptr = nil }, "valecasa.permissao"}, 
	["valegaragem"] = { _config = { salario = 0, ptr = nil }, "valegaragem.permissao"}, 
	["cirurgia"] = { _config = { salario = 0, ptr = nil }, "cirurgia.permissao"}, 
	["foxzin"] = { _config = { salario = 0, ptr = nil }, "foxzin.permissao"}, 
	["rgb"] = { _config = { salario = 0, ptr = nil }, "perm.rgb"}, 
	["ilegal"] = { _config = { salario = 25000, ptr = nil }, "ilegal.permissao"}, 
	["evento"] = { _config = { salario = 25000, ptr = nil }, "perm.evento"}, 

	["ValeCasaEsmeralda"] = { _config = { salario = 0, ptr = nil }, "valecasaesmeralda.permissao"}, 
	["ValeCasaRubi"] = { _config = { salario = 0, ptr = nil }, "valecasarubi.permissao"}, 

	["playboy"] = { _config = { salario = 0, ptr = nil }, "playboy.permissao"}, 
	["malibu"] = { _config = { salario = 0, ptr = nil }, "perm.malibu"}, 

	["starckhouse"] = { _config = { salario = 0, ptr = nil }, "perm.starckhouse"}, 
	["snakehouse"] = { _config = { salario = 0, ptr = nil }, "perm.snakehouse"}, 
	["beiramarhouse"] = { _config = { salario = 0, ptr = nil }, "perm.beiramarhouse"}, 
	["casadolado"] = { _config = { salario = 0, ptr = nil }, "perm.casadolago"}, 

	["manobras"] = { _config = { salario = 0, ptr = nil }, "perm.manobras"}, 

	-- barcos

	["sr650fly"] = { _config = { salario = 0, ptr = nil }, "sr650fly.permissao"}, 
	["yacht2"] = { _config = { salario = 0, ptr = nil }, "yacht2.permissao"}, 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MANSÃO PERMS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["fox"] = { _config = { salario = 0, ptr = nil }, "perm.fox"},
["m1"] = { _config = { salario = 0, ptr = nil }, "perm.m1"},  
["m2"] = { _config = { salario = 0, ptr = nil }, "perm.m2"},
["m3"] = { _config = { salario = 0, ptr = nil }, "perm.m3"},
["m4"] = { _config = { salario = 0, ptr = nil }, "perm.m4"},
["m5"] = { _config = { salario = 0, ptr = nil }, "perm.m5"},
["m6"] = { _config = { salario = 0, ptr = nil }, "perm.m6"},
["m7"] = { _config = { salario = 0, ptr = nil }, "perm.m7"},
["m8"] = { _config = { salario = 0, ptr = nil }, "perm.m8"},
["m9"] = { _config = { salario = 0, ptr = nil }, "perm.m9"},
["m10"] = { _config = { salario = 0, ptr = nil }, "perm.m10"},
["m11"] = { _config = { salario = 0, ptr = nil }, "perm.m11"},
["m12"] = { _config = { salario = 0, ptr = nil }, "perm.m12"},
["m13"] = { _config = { salario = 0, ptr = nil }, "perm.m13"},
["m14"] = { _config = { salario = 0, ptr = nil }, "perm.m14"},
["m15"] = { _config = { salario = 0, ptr = nil }, "perm.m15"},
["m16"] = { _config = { salario = 0, ptr = nil }, "perm.m16"},
["m17"] = { _config = { salario = 0, ptr = nil }, "perm.m17"},
["m17"] = { _config = { salario = 0, ptr = nil }, "perm.m17"},
["ilha"] = { _config = { salario = 0, ptr = nil }, "perm.ilha"},
["cabana"] = { _config = { salario = 0, ptr = nil }, "perm.cabana"},

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PEDS PERMS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["abelha"] = { _config = { salario = 0, ptr = nil }, "perm.abelha"},
["Abelinha"] = { _config = { salario = 0, ptr = nil }, "perm.Abelinha"},  
["anaabelinha"] = { _config = { salario = 0, ptr = nil }, "perm.anaabelinha"},
["Aninha"] = { _config = { salario = 0, ptr = nil }, "perm.Aninha"},
["Aninha2"] = { _config = { salario = 0, ptr = nil }, "perm.Aninha2"},
["Anna"] = { _config = { salario = 0, ptr = nil }, "perm.Anna"},
["arlequina"] = { _config = { salario = 0, ptr = nil }, "perm.arlequina"},
["Arthur"] = { _config = { salario = 0, ptr = nil }, "perm.Arthur"},
["AuroraMonteiro"] = { _config = { salario = 0, ptr = nil }, "perm.AuroraMonteiro"},
["Baby02_DNA_MODS"] = { _config = { salario = 0, ptr = nil }, "perm.Baby02_DNA_MODS"},
["Baby03_DNA_MODS"] = { _config = { salario = 0, ptr = nil }, "perm.Baby03_DNA_MODS"},
["Baby04_DNA_MODS"] = { _config = { salario = 0, ptr = nil }, "perm.Baby04_DNA_MODS"},
["BabyAlanys"] = { _config = { salario = 0, ptr = nil }, "perm.BabyAlanys"},
["BabyLuna"] = { _config = { salario = 0, ptr = nil }, "perm.BabyLuna"},
["BabyTevin"] = { _config = { salario = 0, ptr = nil }, "perm.BabyTevin"},
["bebehomemaranha2"] = { _config = { salario = 0, ptr = nil }, "perm.bebehomemaranha2"},
["bebehomemaranha4"] = { _config = { salario = 0, ptr = nil }, "perm.bebehomemaranha4"},
["bento"] = { _config = { salario = 0, ptr = nil }, "perm.bia"},
["bia"] = { _config = { salario = 0, ptr = nil }, "perm.m17"},
["Carolzinha"] = { _config = { salario = 0, ptr = nil }, "perm.Carolzinha"},
["Cris"] = { _config = { salario = 0, ptr = nil }, "perm.Cris"},
["danny"] = { _config = { salario = 0, ptr = nil }, "perm.Cris"},
["darkzinho"] = { _config = { salario = 0, ptr = nil }, "perm.danny"},
["Emily"] = { _config = { salario = 0, ptr = nil }, "perm.Emily"},
["George"] = { _config = { salario = 0, ptr = nil }, "perm.George"},
["HB_Mandy"] = { _config = { salario = 0, ptr = nil }, "perm.HB_Mandy"},
["Helena"] = { _config = { salario = 0, ptr = nil }, "perm.Helena"},
["homemaranha"] = { _config = { salario = 0, ptr = nil }, "perm.homemaranha"},
["hopezinha"] = { _config = { salario = 0, ptr = nil }, "perm.hopezinha"},
["itachi"] = { _config = { salario = 0, ptr = nil }, "perm.itachi"},
["Izabela"] = { _config = { salario = 0, ptr = nil }, "perm.Izabela"},
["Jade"] = { _config = { salario = 0, ptr = nil }, "perm.Jade"},
["jenial"] = { _config = { salario = 0, ptr = nil }, "perm.jenial"},
["Kevin"] = { _config = { salario = 0, ptr = nil }, "perm.Kevin"},
["Kid01_DNA_MODS"] = { _config = { salario = 0, ptr = nil }, "perm.Kid01_DNA_MODS"},
["Kid02_DNA_MODS"] = { _config = { salario = 0, ptr = nil }, "perm.Kid02_DNA_MODS"},
["Kid03_DNA_MODS"] = { _config = { salario = 0, ptr = nil }, "perm.Kid03_DNA_MODS"},
["Kid04_DNA_MODS"] = { _config = { salario = 0, ptr = nil }, "perm.Kid04_DNA_MODS"},
["KidFelps"] = { _config = { salario = 0, ptr = nil }, "perm.KidFelps"},
["KidNero2"] = { _config = { salario = 0, ptr = nil }, "perm.KidNero2"},
["kitsune"] = { _config = { salario = 0, ptr = nil }, "perm.kitsune"},
["KS_FXMp"] = { _config = { salario = 0, ptr = nil }, "perm.KS_FXMp"},
["Laurinha"] = { _config = { salario = 0, ptr = nil }, "perm.Laurinha"},
["Lily"] = { _config = { salario = 0, ptr = nil }, "perm.Lily"},
["Lud"] = { _config = { salario = 0, ptr = nil }, "perm.Lily"},
["marcelinho"] = { _config = { salario = 0, ptr = nil }, "perm.marcelinho"},
["marian"] = { _config = { salario = 0, ptr = nil }, "perm.marian"},
["muuhbarbie"] = { _config = { salario = 0, ptr = nil }, "perm.muuhbarbie"},
["Nessa"] = { _config = { salario = 0, ptr = nil }, "perm.Nessa"},
["Pedrinho"] = { _config = { salario = 0, ptr = nil }, "perm.Pedrinho"},
["proerd"] = { _config = { salario = 0, ptr = nil }, "perm.proerd"},
["pumaanao"] = { _config = { salario = 0, ptr = nil }, "perm.pumaanao"},
["Rayan"] = { _config = { salario = 0, ptr = nil }, "perm.Rayan"},
["rayan2"] = { _config = { salario = 0, ptr = nil }, "perm.rayan2"},
["Rway"] = { _config = { salario = 0, ptr = nil }, "perm.Rway"},
["Sophia"] = { _config = { salario = 0, ptr = nil }, "perm.Sophia"},
["TeenMorgan"] = { _config = { salario = 0, ptr = nil }, "perm.TeenMorgan"},
["valentina"] = { _config = { salario = 0, ptr = nil }, "perm.valentina"},
["Vampira"] = { _config = { salario = 0, ptr = nil }, "perm.Vampira"},
["Vitoria"] = { _config = { salario = 0, ptr = nil }, "perm.Vitoria"},

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  PERMS SKINS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["Abelinha"] = { _config = { salario = 0, ptr = nil }, "perm.Abelinha"},
["anaabelinha"] = { _config = { salario = 0, ptr = nil }, "perm.anaabelinha"},
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA Thunder
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["ComandoThunder"] = { _config = { gtype = "org", salario = 17000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "perm.recrutamentopm", "perm.baupolicialiderThunder", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder" },
["CoronelThunder"] = { _config = { gtype = "org", salario = 17000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "perm.recrutamentopm", "perm.baupolicialiderThunder", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder" },
["TenenteCoronelThunder"] = { _config = { gtype = "org", salario = 18000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "perm.baupolicialiderThunder","perm.recrutamentopm", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["MajorThunder"] = { _config = { gtype = "org", salario = 17000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia",  "perm.policiathunder", "player.blips","perm.recrutamentopm","perm.baupolicialiderThunder", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["CapitaoThunder"] = { _config = { gtype = "org", salario = 16000, ptr = nil , orgName = "PoliciaThunder"}, "perm.policia", "perm.policiathunder", "player.blips","perm.recrutamentopm","perm.baupolicialiderThunder", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["PrimeiroTenenteThunder"] = { _config = { gtype = "org", salario = 15000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["SegundoTenenteThunder"] = { _config = { gtype = "org", salario = 14000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["SubTenenteThunder"] = { _config = { gtype = "org", salario = 13000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips", "perm.disparo","perm.recrutamentopm", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["PrimeiroSargentoThunder"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["SegundoSargentoThunder"] = { _config = { gtype = "org", salario = 11000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["TerceiroSargentoThunder"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["CaboThunder"] = { _config = { gtype = "org", salario = 9000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips", "perm.disparo","perm.recrutamentopm", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["SoldadoThunder"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },
["AlunoThunder"] = { _config = { gtype = "org", salario = 7000, ptr = nil, orgName = "PoliciaThunder" }, "perm.policia", "perm.policiathunder", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioThunder"  },


["Chamado Policia"] = { _config = { salario = 0, ptr = nil }, "perm.chamadoPolicia" },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA PMERJ
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["ComandoPMERJ"] = { _config = { gtype = "org", salario = 17000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "perm.recrutamentopm", "perm.baupolicialiderpmerj", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj" },
["CoronelPMERJ"] = { _config = { gtype = "org", salario = 17000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "perm.recrutamentopm", "perm.baupolicialiderpmerj", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj" },
["TenenteCoronelPMERJ"] = { _config = { gtype = "org", salario = 18000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "perm.baupolicialiderpmerj","perm.recrutamentopm", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["MajorPMERJ"] = { _config = { gtype = "org", salario = 17000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips","perm.recrutamentopm","perm.baupolicialiderpmerj", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["CapitaoPMERJ"] = { _config = { gtype = "org", salario = 16000, ptr = nil , orgName = "PoliciaPMERJ"}, "perm.policia", "perm.policiapmerj", "player.blips","perm.recrutamentopm","perm.baupolicialiderpmerj", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["PrimeiroTenentePMERJ"] = { _config = { gtype = "org", salario = 15000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["SegundoTenentePMERJ"] = { _config = { gtype = "org", salario = 14000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["SubTenentePMERJ"] = { _config = { gtype = "org", salario = 13000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips", "perm.disparo","perm.recrutamentopm", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["PrimeiroSargentoPMERJ"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["SegundoSargentoPMERJ"] = { _config = { gtype = "org", salario = 11000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["TerceiroSargentoPMERJ"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips","perm.recrutamentopm", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["CaboPMERJ"] = { _config = { gtype = "org", salario = 9000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips", "perm.disparo","perm.recrutamentopm", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["SoldadoPMERJ"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["AlunoPMERJ"] = { _config = { gtype = "org", salario = 7000, ptr = nil, orgName = "PoliciaPMERJ" }, "perm.policia", "perm.policiapmerj", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiopmerj"  },
["PilotoGam"] = { _config = { salario = 0, ptr = nil }, "perm.policia"}, 
["Corregedoria"] = { _config = { salario = 0, ptr = nil }, "perm.policia"}, 

["Chamado Policia"] = { _config = { salario = 0, ptr = nil }, "perm.chamadoPolicia" },

	
-------------------------------------------------
-- POLICIA EXERCITO ---------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["Coronel"] = { _config = { gtype = "org", salario = 30000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "perm.baupolicialider","perm.recrutamentoexercito", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito" },
["TenenteCoronel"] = { _config = { gtype = "org", salario = 28000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "perm.baupolicialider","perm.recrutamentoexercito", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["Major"] = { _config = { gtype = "org", salario = 26000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips", "perm.disparo","perm.recrutamentoexercito", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["Capitao"] = { _config = { gtype = "org", salario = 24000, ptr = nil , orgName = "PoliciaExercito"}, "perm.policia", "perm.policiaexercito", "player.blips", "perm.disparo","perm.recrutamentoexercito", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["PrimeiroTenente"] = { _config = { gtype = "org", salario = 22000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips","perm.recrutamentoexercito", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["SegundoTenente"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips","perm.recrutamentoexercito", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["SubTenente"] = { _config = { gtype = "org", salario = 18000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips","perm.recrutamentoexercito", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["PrimeiroSargento"] = { _config = { gtype = "org", salario = 16000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips","perm.recrutamentoexercito", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["SegundoSargento"] = { _config = { gtype = "org", salario = 14000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips", "perm.recrutamentoexercito","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["TerceiroSargento"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips","perm.recrutamentoexercito", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["Cabo"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },
["Soldado"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "PoliciaExercito" }, "perm.policia", "perm.policiaexercito", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioexercito"  },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA CIVIL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["DelegadoGeral"] = { _config = { gtype = "org", salario = 25000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia","perm.recrutamentocivil", "perm.baupoliciacivillider", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["ComandanteCore"] = { _config = { gtype = "org", salario = 25000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia","perm.recrutamentocivil", "perm.baupoliciacivillider", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["SubComandanteCore"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia","perm.recrutamentocivil", "perm.baupoliciacivillider", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["Delegado"] = { _config = { gtype = "org", salario = 15000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.recrutamentocivil", "perm.policia","player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["Core"] = { _config = { gtype = "org", salario = 15000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia","perm.recrutamentocivil", "player.blips", "perm.disparo", "perm.policia.radio", "perm.portasolicia", "perm.algemar", "perm.radiocivil" },
["Perito"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia","perm.recrutamentocivil", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["Escrivao"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia","perm.recrutamentocivil", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["Investigador"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia","perm.recrutamentocivil", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["Agente"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },
["Recruta"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "PoliciaCivil" }, "perm.policiacivil","perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiocivil"  },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA BOPE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["CoronelBope"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "perm.baupolicialider","perm.recrutamentobope", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope" },
["Ten.CoronelBope"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "perm.baupolicialider","perm.recrutamentobope", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope" },
["MajorBope"] = { _config = { gtype = "org", salario = 18000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "perm.baupolicialider","perm.recrutamentobope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope"  },
["CapitaoBope"] = { _config = { gtype = "org", salario = 16000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "perm.baupolicialider","perm.recrutamentobope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope"  },
["TenenteBope"] = { _config = { gtype = "org", salario = 14000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "perm.baupolicialider","perm.recrutamentobope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope"  },
["SargentoBope"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "perm.baupolicialider","perm.recrutamentobope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope"  },
["CaboBope"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "player.blips", "perm.disparo","perm.recrutamentobope", "perm.portasolicia", "perm.algemar", "perm.radiobope"  },
["SoldadoBope"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope"  },
["RecrutaBope"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "PoliciaBope" }, "perm.policia", "perm.bope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiobope"  },


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA FEDERAL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["ComandoGeralPF"] = { _config = { gtype = "org", salario = 28000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal" },
["DelegadoPF"] = { _config = { gtype = "org", salario = 25000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal" },
["DelegadoADJ.PF"] = { _config = { gtype = "org", salario = 22000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal" },
["PeritoPF"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal" },
["EscrivaoPF"] = { _config = { gtype = "org", salario = 18000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal" },
["InspetorPF"] = { _config = { gtype = "org", salario = 16000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal"  },
["Agente.Cl1"] = { _config = { gtype = "org", salario = 14000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal"  },
["Agente.Cl2"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal"  },
["Agente.Cl3"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "perm.baupolicialider","perm.recrutamentofederal", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal"  },
["Agente.Cl4"] = { _config = { gtype = "org", salario = 80000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "player.blips", "perm.disparo","perm.recrutamentofederal", "perm.portasolicia", "perm.algemar", "perm.radiofederal"  },
["Agente.Cl5"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal"  },
["AlunoPF"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "PoliciaFederal" }, "perm.policia", "perm.federal", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radiofederal"  },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA PRF
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["ComandoGeralPRF"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "perm.baupolicialider","perm.recrutamentoprf", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioprf" },
["Sub.ComandoPRF"] = { _config = { gtype = "org", salario = 18000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "perm.baupolicialider","perm.recrutamentoprf", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioprf"  },
["DiretorPRF"] = { _config = { gtype = "org", salario = 16000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "perm.baupolicialider","perm.recrutamentoprf", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioprf"  },
["InspetorPRF"] = { _config = { gtype = "org", salario = 14000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "perm.baupolicialider","perm.recrutamentoprf", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioprf"  },
["Agente.especialPRF"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "perm.baupolicialider","perm.recrutamentoprf", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioprf"  },
["Clase3.PRF"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "player.blips", "perm.disparo","perm.recrutamentoprf", "perm.portasolicia", "perm.algemar", "perm.radioprf"  },
["Clase2.PRF"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioprf"  },
["Clase1.PRF"] = { _config = { gtype = "org", salario = 5000, ptr = nil, orgName = "PoliciaPRF" }, "perm.policia", "perm.prf", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.radioprf"  },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HOSPITAL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["Diretor"] = { _config = { gtype = "org", salario = 16000, ptr = nil, orgName = "Hospital" },"dv.permissao","perm.recrutamentohp", "hospital.permissao","perm.unizk","perm.hplider","perm.radiohp","samu.permissao" },
["ViceDiretor"] = { _config = { gtype = "org", salario = 14000, ptr = nil, orgName = "Hospital"},"dv.permissao","perm.recrutamentohp", "hospital.permissao","perm.unizk","perm.hplider","perm.radiohp", "samu.permissao" },
["Medico"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "Hospital"},"dv.permissao","perm.recrutamentohp", "hospital.permissao","perm.unizk", "perm.radiohp","samu.permissao" },
["Enfermeiro"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "Hospital"}, "hospital.permissao","perm.recrutamentohp","perm.unizk","perm.radiohp", "samu.permissao" },
["Socorrista"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "Hospital"}, "hospital.permissao","perm.unizk","perm.radiohp", "samu.permissao" },
["Estagiario"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Hospital"},"dv.permissao", "hospital.permissao","perm.unizk", "perm.radiohp","samu.permissao" },

["Chamado Hospital"] = { _config = { salario = 0, ptr = nil }, "perm.chamadoHospital" },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BOMBEIROS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["CoronelBombeiros"] = { _config = { gtype = "org", salario = 27000, ptr = nil, orgName = "bombeiro" },"dv.permissao","perm.recrutamentobombeiro","bombeiroslider.permissao", "perm.radiobombeiros", "perm.unizk" },
["MajorBombeiros"] = { _config = { gtype = "org", salario = 25000, ptr = nil, orgName = "bombeiro"},"dv.permissao","bombeiroslider.permissao","perm.recrutamentobombeiro", "perm.radiobombeiros", "perm.unizk" },
["SargentoBombeiros"] = { _config = { gtype = "org", salario = 23000, ptr = nil, orgName = "bombeiro"},"dv.permissao","bombeiroslider.permissao","perm.recrutamentobombeiro","perm.radiobombeiros",  "perm.unizk" },
["TenenteBombeiros"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "bombeiro"},"dv.permissao","bombeiroslider.permissao", "perm.recrutamentobombeiro","perm.radiobombeiros", "perm.unizk" },
["SubTenenteBombeiros"] = { _config = { gtype = "org", salario = 17000, ptr = nil, orgName = "bombeiro"},"dv.permissao", "perm.unizk" },
["SocorristaBombeiros"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "bombeiro"}, "perm.unizk" },

["Chamado Hospital"] = { _config = { salario = 0, ptr = nil }, "perm.chamadoBombeiro" },
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JUDICIARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
["Ministro"] = { _config = { gtype = "org", salario = 20000, ptr = nil, orgName = "Judiciario"}, "perm.judiciario","perm.policia","perm.radiojudiciario", "perm.recrutamentojudiciario" },
["Juiz"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "Judiciario"}, "perm.judiciario","perm.policia", "perm.radiojudiciario","perm.recrutamentojudiciario"},
["Desembargador"] = { _config = { gtype = "org", salario = 10000, orgName = "Judiciario"}, "perm.judiciario","perm.policia","perm.radiojudiciario","perm.recrutamentojudiciario" },
["Promotor"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "Judiciario"}, "perm.judiciario","perm.policia","perm.radiojudiciario","perm.recrutamentojudiciario" },
["Advogado"] = { _config = { gtype = "org", salario = 5000, ptr = nil, orgName = "Judiciario"}, "perm.judiciario","perm.policia","perm.radiojudiciario","perm.recrutamentojudiciario" },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  /groupadd 1 "lider bloods"
-- ARMAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--DEMONIKE--
["Lider [DEMONIKE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Demonike", orgType = "Armas"}, "perm.demonike","perm.recrutamentodemonike", "perm.liderdemonike", "perm.arma", "perm.ilegal", "perm.baudemonike"},
["Sub-Lider [DEMONIKE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Demonike", orgType = "Armas"}, "perm.liderdemonike","perm.recrutamentodemonike", "perm.demonike", "perm.arma", "perm.ilegal", "perm.baudemonike"},
["Gerente [DEMONIKE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Demonike", orgType = "Armas"}, "perm.demonike","perm.recrutamentodemonike", "perm.arma", "perm.ilegal", "perm.baudemonike"},
["Recrutador [DEMONIKE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Demonike", orgType = "Armas"}, "perm.demonike","perm.recrutamentodemonike", "perm.arma", "perm.ilegal", "perm.baudemonike"},
["Membro [DEMONIKE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Demonike", orgType = "Armas"}, "perm.demonike","perm.recrutamentodemonike", "perm.arma", "perm.ilegal", "perm.baudemonike"},
["Aviaozinho [DEMONIKE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Demonike", orgType = "Armas"}, "perm.demonike", "perm.arma", "perm.ilegal"},

--PCC--
["Lider [PCC]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "PCC", orgType = "Armas"}, "perm.pcc", "perm.liderpcc","perm.recrutamentopcc", "perm.arma", "perm.ilegal", "perm.baupcc"},
["Sub-Lider [PCC]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "PCC", orgType = "Armas"}, "perm.liderpcc", "perm.pcc","perm.recrutamentopcc", "perm.arma", "perm.ilegal", "perm.baupcc"},
	["Gerente [PCC]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "PCC", orgType = "Armas"}, "perm.pcc", "perm.arma","perm.recrutamentopcc", "perm.ilegal", "perm.baupcc"},
	["Recrutador [PCC]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "PCC", orgType = "Armas"}, "perm.pcc", "perm.arma","perm.recrutamentopcc", "perm.ilegal", "perm.baupcc"},
	["Membro [PCC]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "PCC", orgType = "Armas"}, "perm.pcc", "perm.arma","perm.recrutamentopcc", "perm.ilegal", "perm.baupcc"},
	["Aviaozinho [PCC]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "PCC", orgType = "Armas"}, "perm.pcc", "perm.arma", "perm.ilegal"},
	
	--MAFIA--
	["Lider [MAFIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mafia", orgType = "Municao"}, "perm.mafia", "perm.lidermafia","perm.recrutamentomafia", "perm.arma", "perm.ilegal", "perm.baumafia"},
	["Sub-Lider [MAFIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mafia", orgType = "Municao"}, "perm.lidermafia", "perm.mafia","perm.recrutamentomafia", "perm.arma", "perm.ilegal", "perm.baumafia"},
	["Gerente [MAFIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mafia", orgType = "Municao"}, "perm.mafia", "perm.arma", "perm.ilegal","perm.recrutamentomafia", "perm.baumafia"},
	["Recrutador [MAFIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mafia", orgType = "Municao"}, "perm.mafia", "perm.arma", "perm.ilegal","perm.recrutamentomafia", "perm.baumafia"},
	["Membro [MAFIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mafia", orgType = "Municao"}, "perm.mafia", "perm.arma", "perm.ilegal","perm.recrutamentomafia", "perm.baumafia"},
	["Aviaozinho [MAFIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mafia", orgType = "Municao"}, "perm.mafia", "perm.arma","perm.recrutamentomafia", "perm.ilegal"},
	
	--Cartel--
	["Lider [CARTEL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cartel", orgType = "Armas"}, "perm.cartel", "perm.recrutamentocartel", "perm.lidercartel", "perm.arma", "perm.ilegal", "perm.baucartel"},
	["Sub-Lider [CARTEL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cartel", orgType = "Armas"}, "perm.lidercartel","perm.recrutamentocartel",  "perm.cartel", "perm.arma", "perm.ilegal", "perm.baucartel"},
	["Gerente [CARTEL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cartel", orgType = "Armas"}, "perm.cartel","perm.recrutamentocartel",  "perm.arma", "perm.ilegal", "perm.baucartel"},
	["Recrutador [CARTEL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cartel", orgType = "Armas"}, "perm.cartel","perm.recrutamentocartel",  "perm.arma", "perm.ilegal", "perm.baucartel"},
	["Membro [CARTEL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cartel", orgType = "Armas"}, "perm.cartel","perm.recrutamentocartel",  "perm.arma", "perm.ilegal", "perm.baucartel"},
	["Aviaozinho [CARTEL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cartel", orgType = "Armas"}, "perm.cartel", "perm.arma", "perm.ilegal"},
	
	
	--CROACIA--
	["Lider [CROACIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Croacia", orgType = "Armas"}, "perm.croacia","perm.recrutamentocroacia",  "perm.lidercroacia", "perm.arma", "perm.ilegal", "perm.baucroacia"},
	["Sub-Lider [CROACIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Croacia", orgType = "Armas" }, "perm.lidercroacia","perm.recrutamentocroacia", "perm.croacia", "perm.arma", "perm.ilegal", "perm.baucroacia"},
	["Gerente [CROACIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Croacia", orgType = "Armas" }, "perm.croacia","perm.recrutamentocroacia", "perm.arma", "perm.ilegal", "perm.baucroacia"},
	["Recrutador [CROACIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Croacia", orgType = "Armas" }, "perm.croacia", "perm.arma","perm.recrutamentocroacia", "perm.ilegal", "perm.baucroacia"},
	["Membro [CROACIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Croacia", orgType = "Armas" }, "perm.croacia","perm.recrutamentocroacia", "perm.arma", "perm.ilegal", "perm.baucroacia"},
	["Aviaozinho [CROACIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Croacia", orgType = "Armas" }, "perm.croacia", "perm.arma", "perm.ilegal"},

	
	--FRANCA--
	["Lider [FRANCA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Franca", orgType = "Armas"}, "perm.franca","perm.recrutamentofranca", "perm.liderfranca", "perm.arma", "perm.ilegal", "perm.baufranca"},
	["Sub-Lider [FRANCA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Franca", orgType = "Armas"}, "perm.liderfranca","perm.recrutamentofranca", "perm.franca", "perm.arma", "perm.ilegal", "perm.baufranca"},
	["Gerente [FRANCA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Franca", orgType = "Armas"}, "perm.franca","perm.recrutamentofranca", "perm.arma", "perm.ilegal", "perm.baufranca"},
	["Recrutador [FRANCA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Franca", orgType = "Armas"}, "perm.franca", "perm.recrutamentofranca","perm.arma", "perm.ilegal", "perm.baufranca"},
	["Membro [FRANCA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Franca", orgType = "Armas"}, "perm.franca", "perm.recrutamentofranca","perm.arma", "perm.ilegal", "perm.baufranca"},
	["Aviaozinho [FRANCA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Franca", orgType = "Armas"}, "perm.franca", "perm.arma", "perm.ilegal"},
	
	--WOLVES--
	["Lider [WOLVES]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Wolves", orgType = "Armas"}, "perm.wolves","perm.recrutamentowolves", "perm.liderwolves", "perm.arma", "perm.ilegal", "perm.bauwolves"},
	["Sub-Lider [WOLVES]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Wolves", orgType = "Armas"}, "perm.liderwolves","perm.recrutamentowolves", "perm.wolves", "perm.arma", "perm.ilegal", "perm.bauwolves"},
	["Gerente [WOLVES]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Wolves", orgType = "Armas"}, "perm.wolves","perm.recrutamentowolves", "perm.arma", "perm.ilegal", "perm.bauwolves"},
	["Recrutador [WOLVES]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Wolves", orgType = "Armas"}, "perm.wolves", "perm.recrutamentowolves","perm.arma", "perm.ilegal", "perm.bauwolves"},
	["Membro [WOLVES]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Wolves", orgType = "Armas"}, "perm.wolves", "perm.recrutamentowolves","perm.arma", "perm.ilegal", "perm.bauwolves"},
	["Aviaozinho [WOLVES]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Wolves", orgType = "Armas"}, "perm.wolves", "perm.arma", "perm.ilegal"},
	
	--Yakuza--
	["Lider [YAKUZA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Yakuza", orgType = "Armas"}, "perm.lideryakuza", "perm.recrutamentoyakuza","perm.yakuza", "perm.armas", "perm.ilegal", "perm.bauyakuza"},
	["Sub-Lider [YAKUZA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Yakuza", orgType = "Armas"}, "perm.lideryakuza","perm.recrutamentoyakuza", "perm.yakuza", "perm.armas", "perm.ilegal", "perm.bauyakuza"},
	["Gerente [YAKUZA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Yakuza", orgType = "Armas"}, "perm.yakuza","perm.recrutamentoyakuza", "perm.armas", "perm.ilegal", "perm.bauyakuza"},
	["Recrutador [YAKUZA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Yakuza", orgType = "Armas"}, "perm.yakuza","perm.recrutamentoyakuza", "perm.armas", "perm.ilegal", "perm.bauyakuza"},
	["Membro [YAKUZA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Yakuza", orgType = "Armas"}, "perm.yakuza", "perm.recrutamentoyakuza","perm.armas", "perm.ilegal", "perm.bauyakuza"},
	["Aviaozinho [YAKUZA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Yakuza", orgType = "Armas"}, "perm.yakuza", "perm.armas", "perm.ilegal"},
	
	--Triade--
	["Lider [TRIADE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Triade", orgType = "Armas"}, "perm.lidertriade", "perm.recrutamentotriade","perm.triade", "perm.armas", "perm.ilegal", "perm.bautriade"},
	["Sub-Lider [TRIADE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Triade", orgType = "Armas"}, "perm.lidertriade","perm.recrutamentotriade", "perm.triade", "perm.armas", "perm.ilegal", "perm.bautriade"},
	["Gerente [TRIADE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Triade", orgType = "Armas"}, "perm.triade","perm.recrutamentotriade", "perm.armas", "perm.ilegal", "perm.bautriade"},
	["Recrutador [TRIADE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Triade", orgType = "Armas"}, "perm.triade","perm.recrutamentotriade", "perm.armas", "perm.ilegal", "perm.bautriade"},
	["Membro [TRIADE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Triade", orgType = "Armas"}, "perm.triade", "perm.recrutamentotriade","perm.armas", "perm.ilegal", "perm.bautriade"},
	["Aviaozinho [TRIADE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Triade", orgType = "Armas"}, "perm.triade", "perm.armas", "perm.ilegal"},
	
	--Merlim--
	["Lider [MERLIM]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "c", orgType = "Armas"}, "perm.lidermerlim", "perm.recrutamentomerlim","perm.merlim", "perm.armas", "perm.ilegal", "perm.baumerlim"},
	["Sub-Lider [MERLIM]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Merlim", orgType = "Armas"}, "perm.lidermerlim","perm.recrutamentomerlim", "perm.merlim", "perm.armas", "perm.ilegal", "perm.baumerlim"},
	["Gerente [MERLIM]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Merlim", orgType = "Armas"}, "perm.merlim","perm.recrutamentomerlim", "perm.armas", "perm.ilegal", "perm.baumerlim"},
	["Recrutador [MERLIM]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Merlim", orgType = "Armas"}, "perm.merlim","perm.recrutamentomerlim", "perm.armas", "perm.ilegal", "perm.baumerlim"},
	["Membro [MERLIM]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Merlim", orgType = "Armas"}, "perm.merlim", "perm.recrutamentomerlim","perm.armas", "perm.ilegal", "perm.baumerlim"},
	["Aviaozinho [MERLIM]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Merlim", orgType = "Armas"}, "perm.merlim", "perm.armas", "perm.ilegal"},
	
	--GROTA--
	["Lider [GROTA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Grota", orgType = "Municao"}, "perm.gerentegrota","perm.recrutamentogrota",  "perm.grota", "perm.lidergrota", "perm.arma", "perm.ilegal", "perm.baugrota", "perm.baulidergrota"},
	["Sub-Lider [GROTA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Grota", orgType = "Municao"}, "perm.gerentegrota","perm.recrutamentogrota","perm.lidergrota", "perm.grota", "perm.arma", "perm.ilegal", "perm.baugrota", "perm.baulidergrota"},
	["Gerente [GROTA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Grota", orgType = "Municao"}, "perm.gerentegrota","perm.recrutamentogrota","perm.grota", "perm.arma", "perm.ilegal", "perm.baugrota", "perm.baulidergrota"},
	["Recrutador [GROTA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Grota", orgType = "Municao"}, "perm.grota","perm.recrutamentogrota", "perm.arma", "perm.ilegal", "perm.baugrota"},
	["Membro [GROTA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Grota", orgType = "Municao"}, "perm.grota", "perm.arma","perm.recrutamentogrota", "perm.ilegal", "perm.baugrota"},
	["Aviaozinho [GROTA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Grota", orgType = "Municao"}, "perm.grota", "perm.arma", "perm.ilegal"},
	
	
	--TURQUIA--
	["Lider [TURQUIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Turquia", orgType = "Municao"}, "perm.gerenteturquia", "perm.turquia","perm.recrutamentoturquia", "perm.liderturquia", "perm.arma", "perm.ilegal", "perm.bauturquia", "perm.bauliderturquia"},
	["Sub-Lider [TURQUIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Turquia", orgType = "Municao"}, "perm.gerenteturquia","perm.liderturquia","perm.recrutamentoturquia", "perm.turquia", "perm.arma", "perm.ilegal", "perm.bauturquia", "perm.bauliderturquia"},
	["Gerente [TURQUIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Turquia", orgType = "Municao"}, "perm.gerenteturquia","perm.turquia","perm.recrutamentoturquia", "perm.arma", "perm.ilegal", "perm.bauturquia", "perm.bauliderturquia"},
	["Recrutador [TURQUIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Turquia", orgType = "Municao"}, "perm.turquia", "perm.arma", "perm.ilegal","perm.recrutamentoturquia", "perm.bauturquia"},
	["Membro [TURQUIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Turquia", orgType = "Municao"}, "perm.turquia", "perm.arma", "perm.ilegal","perm.recrutamentoturquia", "perm.bauturquia"},
	["Aviaozinho [TURQUIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Turquia", orgType = "Municao"}, "perm.turquia", "perm.arma", "perm.ilegal"},
	
	--BLACKOUT--
	["Lider [BLACKOUT]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "BlackOut", orgType = "Armas"}, "perm.gerenteblackout", "perm.blackout","perm.recrutamentoblackout", "perm.liderblackout", "perm.arma", "perm.ilegal", "perm.baublackout", "perm.bauliderblackout"},
	["Sub-Lider [BLACKOUT]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "BlackOut", orgType = "Armas"}, "perm.gerenteblackout","perm.liderblackout","perm.recrutamentoblackout", "perm.blackout", "perm.arma", "perm.ilegal", "perm.baublackout", "perm.bauliderblackout"},
	["Gerente [BLACKOUT]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "BlackOut", orgType = "Armas"}, "perm.gerenteblackout","perm.blackout","perm.recrutamentoblackout", "perm.arma", "perm.ilegal", "perm.baublackout", "perm.bauliderblackout"},
	["Recrutador [BLACKOUT]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "BlackOut", orgType = "Armas"}, "perm.blackout", "perm.arma", "perm.ilegal","perm.recrutamentoblackout", "perm.baublackout"},
	["Membro [BLACKOUT]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "BlackOut", orgType = "Armas"}, "perm.blackout", "perm.arma", "perm.ilegal","perm.recrutamentoblackout", "perm.baublackout"},
	["Aviaozinho [BLACKOUT]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "BlackOut", orgType = "Armas"}, "perm.blackout", "perm.arma", "perm.ilegal"},
	
	
	
	
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- MUNIÇÃO E DESMANCHE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--Milicia--
	["Lider [MILICIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Milicia", orgType = "Municao"}, "perm.gerentemilicia","perm.recrutamentomilicia", "perm.milicia", "perm.lidermilicia", "perm.arma", "perm.ilegal", "perm.baumilicia", "perm.baulidermilicia"},
	["Sub-Lider [MILICIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Milicia", orgType = "Municao"}, "perm.gerentemilicia","perm.lidermilicia","perm.recrutamentomilicia", "perm.milicia", "perm.arma", "perm.ilegal", "perm.baumilicia", "perm.baulidermilicia"},
	["Gerente [MILICIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Milicia", orgType = "Municao"}, "perm.gerentemilicia","perm.milicia","perm.recrutamentomilicia", "perm.arma", "perm.ilegal", "perm.baumilicia", "perm.baulidermilicia"},
	["Recrutador [MILICIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Milicia", orgType = "Municao"}, "perm.milicia", "perm.arma","perm.recrutamentomilicia", "perm.ilegal", "perm.baumilicia"},
	["Membro [MILICIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Milicia", orgType = "Municao"}, "perm.milicia", "perm.arma", "perm.ilegal","perm.recrutamentomilicia", "perm.baumilicia"},
	["Aviaozinho [MILICIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Milicia", orgType = "Municao"}, "perm.milicia", "perm.arma", "perm.ilegal"},

	--Alemao--
	["Lider [ALEMAO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Alemao", orgType = "Municao"}, "perm.gerentealemao","perm.recrutamentoalemao", "perm.alemao", "perm.lideralemao", "perm.arma", "perm.ilegal", "perm.baualemao", "perm.baulideralemao"},
	["Sub-Lider [ALEMAO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Alemao", orgType = "Municao"}, "perm.gerentealemao","perm.recrutamentoalemao","perm.lideralemao", "perm.alemao", "perm.arma", "perm.ilegal", "perm.baualemao", "perm.baulideralemao"},
	["Gerente [ALEMAO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Alemao", orgType = "Municao"}, "perm.gerentealemao","perm.recrutamentoalemao","perm.alemao", "perm.arma", "perm.ilegal", "perm.baualemao", "perm.baulideralemao"},
	["Recrutador [ALEMAO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Alemao", orgType = "Municao"}, "perm.alemao", "perm.arma","perm.recrutamentoalemao", "perm.ilegal", "perm.baualemao"},
	["Membro [ALEMAO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Alemao", orgType = "Municao"}, "perm.alemao", "perm.arma","perm.recrutamentoalemao", "perm.ilegal", "perm.baualemao"},
	["Aviaozinho [ALEMAO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Alemao", orgType = "Municao"}, "perm.alemao", "perm.arma", "perm.ilegal"},
	
	--Helipa--
	["Lider [HELIPA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Helipa", orgType = "Desmanche"}, "perm.gerentehelipa","perm.recrutamentohelipa", "perm.helipa", "perm.liderhelipa", "perm.arma", "perm.ilegal", "perm.bauhelipa", "perm.bauliderhelipa"},
	["Sub-Lider [HELIPA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Helipa", orgType = "Desmanche"}, "perm.gerentehelipa","perm.recrutamentohelipa","perm.liderhelipa", "perm.helipa", "perm.arma", "perm.ilegal", "perm.bauhelipa", "perm.bauliderhelipa"},
	["Gerente [HELIPA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Helipa", orgType = "Desmanche"}, "perm.gerentehelipa","perm.recrutamentohelipa","perm.helipa", "perm.arma", "perm.ilegal", "perm.bauhelipa", "perm.bauliderhelipa"},
	["Recrutador [HELIPA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Helipa", orgType = "Desmanche"}, "perm.helipa","perm.recrutamentohelipa", "perm.arma", "perm.ilegal", "perm.bauhelipa"},
	["Membro [HELIPA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Helipa", orgType = "Desmanche"}, "perm.helipa","perm.recrutamentohelipa", "perm.arma", "perm.ilegal", "perm.bauhelipa"},
	["Aviaozinho [HELIPA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Helipa", orgType = "Desmanche"}, "perm.helipa", "perm.arma", "perm.ilegal"},
	
	--Rocinha--
	["Lider [ROCINHA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Rocinha", orgType = "Desmanche"}, "perm.gerenterocinha","perm.recrutamentorocinha", "perm.rocinha", "perm.liderrocinha", "perm.arma", "perm.ilegal", "perm.baurocinha", "perm.bauliderrocinha"},
	["Sub-Lider [ROCINHA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Rocinha", orgType = "Desmanche"}, "perm.gerenterocinha","perm.recrutamentorocinha","perm.liderrocinha", "perm.rocinha", "perm.arma", "perm.ilegal", "perm.baurocinha", "perm.bauliderrocinha"},
	["Gerente [ROCINHA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Rocinha", orgType = "Desmanche"}, "perm.gerenterocinha","perm.recrutamentorocinha","perm.rocinha", "perm.arma", "perm.ilegal", "perm.baurocinha", "perm.bauliderrocinha"},
	["Recrutador [ROCINHA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Rocinha", orgType = "Desmanche"}, "perm.rocinha", "perm.arma","perm.recrutamentorocinha", "perm.ilegal", "perm.baurocinha"},
	["Membro [ROCINHA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Rocinha", orgType = "Desmanche"}, "perm.rocinha","perm.recrutamentorocinha", "perm.arma", "perm.ilegal", "perm.baurocinha"},
	["Aviaozinho [ROCINHA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Rocinha", orgType = "Desmanche"}, "perm.rocinha", "perm.arma", "perm.ilegal"},
	
		--CRIPS--
	["Lider [CRIPS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Crips", orgType = "Municao"}, "perm.crips", "perm.lidercrips","perm.recrutamentocrips", "perm.drogas", "perm.metanfetamina", "perm.ilegal", "perm.baucrips"},
	["Sub-Lider [CRIPS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Crips", orgType = "Municao"}, "perm.lidercrips", "perm.crips","perm.recrutamentocrips", "perm.drogas", "perm.ilegal", "perm.metanfetamina", "perm.baucrips"},
	["Gerente [CRIPS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Crips", orgType = "Municao"}, "perm.crips", "perm.drogas", "perm.ilegal","perm.recrutamentocrips", "perm.metanfetamina", "perm.baucrips"},
	["Recrutador [CRIPS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Crips", orgType = "Municao"}, "perm.crips", "perm.drogas", "perm.ilegal","perm.recrutamentocrips", "perm.metanfetamina", "perm.baucrips"},
	["Membro [CRIPS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Crips", orgType = "Municao"}, "perm.crips", "perm.drogas", "perm.ilegal","perm.recrutamentocrips", "perm.metanfetamina", "perm.baucrips"},
	["Aviaozinho [CRIPS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Crips", orgType = "Municao"}, "perm.crips", "perm.drogas", "perm.metanfetamina", "perm.ilegal"},

	--FURIOUS--
	["Lider [FURIOUS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Furious", orgType = "Desmanche"}, "perm.furious","perm.recrutamentofurious", "perm.liderfurious", "perm.gerentefurious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Sub-Lider [FURIOUS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Furious", orgType = "Desmanche"}, "perm.liderfurious","perm.recrutamentofurious", "perm.gerentefurious", "perm.furious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Gerente [FURIOUS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Furious", orgType = "Desmanche"}, "perm.gerentefurious","perm.recrutamentofurious", "perm.furious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Recrutador [FURIOUS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Furious", orgType = "Desmanche"}, "perm.furious", "perm.recrutamentofurious","perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Membro [FURIOUS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Furious", orgType = "Desmanche"}, "perm.furious","perm.recrutamentofurious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Aviaozinho [FURIOUS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Furious", orgType = "Desmanche"}, "perm.furious", "perm.desmanche", "perm.ilegal"},

	--Motoclub--
	["Lider [MOTOCLUB]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Motoclub", orgType = "Desmanche"}, "perm.motoclub","perm.recrutamentomotoclub", "perm.desmanche", "perm.lidermotoclub", "perm.ilegal", "perm.baumotoclub"},
	["Sub-Lider [MOTOCLUB]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Motoclub", orgType = "Desmanche"}, "perm.lidermotoclub","perm.recrutamentomotoclub", "perm.motoclub", "perm.desmanche", "perm.ilegal", "perm.baumotoclub"},
	["Gerente [MOTOCLUB]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Motoclub", orgType = "Desmanche"}, "perm.motoclub","perm.recrutamentomotoclub", "perm.desmanche", "perm.ilegal", "perm.baumotoclub"},
	["Recrutador [MOTOCLUB]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Motoclub", orgType = "Desmanche"}, "perm.motoclub","perm.recrutamentomotoclub", "perm.desmanche", "perm.ilegal", "perm.baumotoclub"},
	 ["Membro [MOTOCLUB]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Motoclub", orgType = "Desmanche"}, "perm.motoclub","perm.recrutamentomotoclub", "perm.desmanche", "perm.ilegal", "perm.baumotoclub"},
	 ["Aviaozinho [MOTOCLUB]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Motoclub", orgType = "Desmanche"}, "perm.motoclub", "perm.desmanche", "perm.ilegal"},

 	--B13--
	 ["Lider [B13]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "B13", orgType = "Desmanche"}, "perm.b13", "perm.desmanche","perm.recrutamentob13", "perm.liderb13", "perm.ilegal", "perm.baub13"},
	 ["Sub-Lider [B13]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "B13", orgType = "Desmanche"}, "perm.liderb13", "perm.b13","perm.recrutamentob13", "perm.desmanche", "perm.ilegal", "perm.baub13"},
	 ["Gerente [B13]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "B13", orgType = "Desmanche"}, "perm.b13", "perm.desmanche","perm.recrutamentob13", "perm.ilegal", "perm.baub13"},
	 ["Recrutador [B13]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "B13", orgType = "Desmanche"}, "perm.b13", "perm.desmanche","perm.recrutamentob13", "perm.ilegal", "perm.baub13"},
	 ["Membro [B13]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "B13", orgType = "Desmanche"}, "perm.b13", "perm.desmanche", "perm.recrutamentob13","perm.ilegal", "perm.baub13"},
	 ["Aviaozinho [B13]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "B13", orgType = "Desmanche"}, "perm.b13", "perm.desmanche", "perm.ilegal"},
	 
	 
	 --LACOSTE--
	 ["Lider [LACOSTE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Lacoste", orgType = "Desmanche"}, "perm.lacoste","perm.recrutamentolacoste", "perm.liderlacoste", "perm.desmanche", "perm.ilegal", "perm.baulacoste"},
	["Sub-Lider [LACOSTE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Lacoste", orgType = "Desmanche"}, "perm.liderlacoste", "perm.lacoste","perm.recrutamentolacoste", "perm.desmanche", "perm.ilegal", "perm.baulacoste"},
	["Gerente [LACOSTE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Lacoste", orgType = "Desmanche"}, "perm.lacoste", "perm.desmanche","perm.recrutamentolacoste", "perm.ilegal", "perm.baulacoste"},
	["Recrutador [LACOSTE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Lacoste", orgType = "Desmanche"}, "perm.lacoste", "perm.desmanche","perm.recrutamentolacoste", "perm.ilegal", "perm.baulacoste"},
	["Membro [LACOSTE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Lacoste", orgType = "Desmanche"}, "perm.lacoste", "perm.desmanche","perm.recrutamentolacoste", "perm.ilegal", "perm.baulacoste"},
	["Aviaozinho [LACOSTE]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Lacoste", orgType = "Desmanche"}, "perm.lacoste", "perm.desmanche", "perm.ilegal"},
	
	 --HELLSANGELS--
	 ["Lider [HELLSANGELS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "HellsAngels", orgType = "Desmanche"}, "perm.hellsamgels","perm.recrutamentohellsamgels", "perm.desmanche", "perm.liderhellsamgels", "perm.ilegal", "perm.bauhellsamgels"},
	["Sub-Lider [HELLSANGELS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "HellsAngels", orgType = "Desmanche"}, "perm.liderhellsamgels","perm.recrutamentohellsamgels", "perm.hellsamgels", "perm.desmanche", "perm.ilegal", "perm.bauhellsamgels"},
	["Gerente [HELLSANGELS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "HellsAngels", orgType = "Desmanche"}, "perm.hellsamgels", "perm.recrutamentohellsamgels","perm.desmanche", "perm.ilegal", "perm.bauhellsamgels"},
	["Recrutador [HELLSANGELS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "HellsAngels", orgType = "Desmanche"}, "perm.hellsamgels","perm.recrutamentohellsamgels", "perm.desmanche", "perm.ilegal", "perm.bauhellsamgels"},
	["Membro [HELLSANGELS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "HellsAngels", orgType = "Desmanche"}, "perm.hellsamgels","perm.recrutamentohellsamgels", "perm.desmanche", "perm.ilegal", "perm.bauhellsamgels"},
	["Aviaozinho [HELLSANGELS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "HellsAngels", orgType = "Desmanche"}, "perm.hellsamgels", "perm.desmanche", "perm.ilegal"},
	
	-- --BENNYS--
	["Lider [BENNYS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bennys", orgType = "Desmanche"}, "perm.bennys","perm.recrutamentobennys", "perm.desmanche", "perm.liderbennys", "perm.ilegal", "perm.baubennys"},
	["Sub-Lider [BENNYS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bennys", orgType = "Desmanche"}, "perm.liderbennys","perm.recrutamentobennys", "perm.bennys", "perm.desmanche", "perm.ilegal", "perm.baubennys"},
	["Gerente [BENNYS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bennys", orgType = "Desmanche"}, "perm.bennys","perm.recrutamentobennys", "perm.desmanche", "perm.ilegal", "perm.baubennys"},
	["Recrutador [BENNYS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bennys", orgType = "Desmanche"}, "perm.bennys","perm.recrutamentobennys", "perm.desmanche", "perm.ilegal", "perm.baubennys"},
	["Membro [BENNYS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bennys", orgType = "Desmanche"}, "perm.bennys","perm.recrutamentobennys", "perm.desmanche", "perm.ilegal", "perm.baubennys"},
	["Aviaozinho [BENNYS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bennys", orgType = "Desmanche"}, "perm.bennys", "perm.desmanche", "perm.ilegal"},
	
	
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- LAVAGEM
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--VANILLA--
	["Lider [VANILLA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Vanilla", orgType = "Lavagem"}, "perm.lidervanilla","perm.recrutamentovanilla", "perm.vanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},
	["Sub-Lider [VANILLA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Vanilla",orgType = "Lavagem"}, "perm.lidervanilla","perm.recrutamentovanilla", "perm.vanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},	
	["Gerente [VANILLA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Vanilla",orgType = "Lavagem"}, "perm.vanilla","perm.recrutamentovanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},
	["Recrutador [VANILLA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Vanilla",orgType = "Lavagem"}, "perm.vanilla","perm.recrutamentovanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},
	["Membro [VANILLA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Vanilla",orgType = "Lavagem"}, "perm.vanilla","perm.recrutamentovanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},
	["Aviaozinho [VANILLA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Vanilla",orgType = "Lavagem"}, "perm.vanilla", "perm.lavagem", "perm.ilegal"},
	
	--BAHAMAS--
	["Lider [BAHAMAS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bahamas", orgType = "Lavagem"}, "perm.liderbahamas", "perm.recrutamentobahamas", "perm.bahamas", "perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Sub-Lider [BAHAMAS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bahamas", orgType = "Lavagem"}, "perm.liderbahamas","perm.recrutamentobahamas", "perm.bahamas", "perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Gerente [BAHAMAS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bahamas", orgType = "Lavagem"}, "perm.bahamas","perm.recrutamentobahamas", "perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Recrutador [BAHAMAS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bahamas", orgType = "Lavagem"}, "perm.bahamas", "perm.lavagem","perm.recrutamentobahamas", "perm.ilegal", "perm.baubahamas"},
	["Membro [BAHAMAS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bahamas", orgType = "Lavagem"}, "perm.bahamas", "perm.recrutamentobahamas","perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Aviaozinho [BAHAMAS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bahamas", orgType = "Lavagem"}, "perm.bahamas", "perm.lavagem", "perm.ilegal"},
	
	--BRATVA--
	["Lider [BRATVA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bratva", orgType = "Lavagem"}, "perm.liderbratva", "perm.recrutamentobratva", "perm.bratva", "perm.lavagem", "perm.ilegal", "perm.baubratva"},
	["Sub-Lider [BRATVA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bratva", orgType = "Lavagem"}, "perm.liderbratva","perm.recrutamentobratva", "perm.bratva", "perm.lavagem", "perm.ilegal", "perm.baubratva"},
	["Gerente [BRATVA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bratva", orgType = "Lavagem"}, "perm.bratva","perm.recrutamentobratva", "perm.lavagem", "perm.ilegal", "perm.baubratva"},
	["Recrutador [BRATVA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bratva", orgType = "Lavagem"}, "perm.bratva", "perm.lavagem","perm.recrutamentobratva", "perm.ilegal", "perm.baubratva"},
	["Membro [BRATVA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bratva", orgType = "Lavagem"}, "perm.bratva", "perm.recrutamentobratva","perm.lavagem", "perm.ilegal", "perm.baubratva"},
	["Aviaozinho [BRATVA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Bratva", orgType = "Lavagem"}, "perm.bratva", "perm.lavagem", "perm.ilegal"},
	
	--TEQUILA--
	["Lider [TEQUILA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Tequila", orgType = "Lavagem"}, "perm.lidertequila", "perm.recrutamentotequila", "perm.tequila", "perm.lavagem", "perm.ilegal", "perm.bautequila"},
	["Sub-Lider [TEQUILA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Tequila", orgType = "Lavagem"}, "perm.lidertequila","perm.recrutamentotequila", "perm.tequila", "perm.lavagem", "perm.ilegal", "perm.bautequila"},
	["Gerente [TEQUILA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Tequila", orgType = "Lavagem"}, "perm.tequila","perm.recrutamentotequila", "perm.lavagem", "perm.ilegal", "perm.bautequila"},
	["Recrutador [TEQUILA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Tequila", orgType = "Lavagem"}, "perm.tequila", "perm.lavagem","perm.recrutamentotequila", "perm.ilegal", "perm.bautequila"},
	["Membro [TEQUILA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Tequila", orgType = "Lavagem"}, "perm.tequila", "perm.recrutamentotequila","perm.lavagem", "perm.ilegal", "perm.bautequila"},
	["Aviaozinho [TEQUILA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Tequila", orgType = "Lavagem"}, "perm.tequila", "perm.lavagem", "perm.ilegal"},
	
	--ILUMINATIS--
	["Lider [ILUMINATIS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Iluminatis", orgType = "Lavagem"}, "perm.lideriluminatis", "perm.recrutamentoiluminatis", "perm.iluminatis", "perm.lavagem", "perm.ilegal", "perm.bauiluminatis"},
	["Sub-Lider [ILUMINATIS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Iluminatis", orgType = "Lavagem"}, "perm.lideriluminatis","perm.recrutamentoiluminatis", "perm.iluminatis", "perm.lavagem", "perm.ilegal", "perm.bauiluminatis"},
	["Gerente [ILUMINATIS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Iluminatis", orgType = "Lavagem"}, "perm.iluminatis","perm.recrutamentoiluminatis", "perm.lavagem", "perm.ilegal", "perm.bauiluminatis"},
	["Recrutador [ILUMINATIS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Iluminatis", orgType = "Lavagem"}, "perm.iluminatis", "perm.lavagem","perm.recrutamentoiluminatis", "perm.ilegal", "perm.bauiluminatis"},
	["Membro [ILUMINATIS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Iluminatis", orgType = "Lavagem"}, "perm.iluminatis", "perm.recrutamentoiluminatis","perm.lavagem", "perm.ilegal", "perm.bauiluminatis"},
	["Aviaozinho [ILUMINATIS]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Iluminatis", orgType = "Lavagem"}, "perm.iluminatis", "perm.lavagem", "perm.ilegal"},

	--LUXURY--
	["Lider [LUXURY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Luxury", orgType = "Lavagem"}, "perm.liderluxury", "perm.recrutamentoluxury", "perm.luxury", "perm.lavagem", "perm.ilegal", "perm.bauluxury"},
	["Sub-Lider [LUXURY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Luxury", orgType = "Lavagem"}, "perm.liderluxury","perm.recrutamentoluxury", "perm.luxury", "perm.lavagem", "perm.ilegal", "perm.bauluxury"},
	["Gerente [LUXURY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Luxury", orgType = "Lavagem"}, "perm.luxury","perm.recrutamentoluxury", "perm.lavagem", "perm.ilegal", "perm.bauluxury"},
	["Recrutador [LUXURY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Luxury", orgType = "Lavagem"}, "perm.luxury", "perm.lavagem","perm.recrutamentoluxury", "perm.ilegal", "perm.bauluxury"},
	["Membro [LUXURY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Luxury", orgType = "Lavagem"}, "perm.luxury", "perm.recrutamentoluxury","perm.lavagem", "perm.ilegal", "perm.bauluxury"},
	["Aviaozinho [LUXURY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Luxury", orgType = "Lavagem"}, "perm.luxury", "perm.lavagem", "perm.ilegal"},
	
		--GALAXY--
	["Lider [GALAXY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Galaxy", orgType = "Lavagem"}, "perm.lidergalaxy", "perm.recrutamentogalaxy", "perm.galaxy", "perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Sub-Lider [GALAXY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Galaxy", orgType = "Lavagem"}, "perm.lidergalaxy","perm.recrutamentogalaxy", "perm.galaxy", "perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Gerente [GALAXY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Galaxy", orgType = "Lavagem"}, "perm.galaxy","perm.recrutamentogalaxy", "perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Recrutador [GALAXY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Galaxy", orgType = "Lavagem"}, "perm.galaxy", "perm.lavagem","perm.recrutamentogalaxy", "perm.ilegal", "perm.baugalaxy"},
	["Membro [GALAXY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Galaxy", orgType = "Lavagem"}, "perm.galaxy", "perm.recrutamentogalaxy","perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Aviaozinho [GALAXY]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Galaxy", orgType = "Lavagem"}, "perm.galaxy", "perm.lavagem", "perm.ilegal"},

		--CASSINO--
	["Lider [CASSINO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cassino", orgType = "Lavagem"}, "perm.lidercassino", "perm.recrutamentocassino", "perm.cassino", "perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Sub-Lider [CASSINO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cassino", orgType = "Lavagem"}, "perm.lidercassino","perm.recrutamentocassino", "perm.cassino", "perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Gerente [CASSINO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cassino", orgType = "Lavagem"}, "perm.cassino","perm.recrutamentocassino", "perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Recrutador [CASSINO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cassino", orgType = "Lavagem"}, "perm.cassino", "perm.lavagem","perm.recrutamentocassino", "perm.ilegal", "perm.baucassino"},
	["Membro [CASSINO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cassino", orgType = "Lavagem"}, "perm.cassino", "perm.recrutamentogalaxy","perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Aviaozinho [CASSINO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cassino", orgType = "Lavagem"}, "perm.cassino", "perm.lavagem", "perm.ilegal"},
	

	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- DROGAS
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--CANADA--
	["Lider [CANADA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Canada", orgType = "Drogas"}, "perm.canada","perm.recrutamentocanada", "perm.lidercanada", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucanada"},
	["Sub-Lider [CANADA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Canada", orgType = "Drogas"}, "perm.lidercanada", "perm.recrutamentocanada","perm.canada", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucanada"},
	["Gerente [CANADA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Canada", orgType = "Drogas"}, "perm.canada","perm.recrutamentocanada", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucanada"},
	["Recrutador [CANADA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Canada", orgType = "Drogas"}, "perm.canada","perm.recrutamentocanada", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucanada"},
	["Membro [CANADA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Canada", orgType = "Drogas"}, "perm.canada","perm.recrutamentocanada", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucanada"},
	["Aviaozinho [CANADA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Canada", orgType = "Drogas"}, "perm.canada", "perm.drogas", "perm.maconha", "perm.ilegal"},

	--BRASIL--
	["Lider [BRASIL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Brasil", orgType = "Drogas"}, "perm.brasil","perm.recrutamentobrasil", "perm.liderbrasil", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baubrasil"},
	["Sub-Lider [BRASIL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Brasil", orgType = "Drogas"}, "perm.liderbrasil","perm.recrutamentobrasil", "perm.brasil", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baubrasil"},
	["Gerente [BRASIL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Brasil", orgType = "Drogas"}, "perm.brasil","perm.recrutamentobrasil", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baubrasil"},
	["Recrutador [BRASIL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Brasil", orgType = "Drogas"}, "perm.brasil","perm.recrutamentobrasil", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baubrasil"},
	["Membro [BRASIL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Brasil", orgType = "Drogas"}, "perm.brasil","perm.recrutamentobrasil", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baubrasil"},
	["Aviaozinho [BRASIL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Brasil", orgType = "Drogas"}, "perm.brasil", "perm.drogas", "perm.maconha", "perm.ilegal"},
	
	-- --NIGERIA--
	["Lider [NIGERIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria","perm.recrutamentonige", "perm.lidernigeria", "perm.balinha", "perm.ilegal", "perm.baunigeria"},
	["Sub-Lider [NIGERIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.lidernigeria","perm.recrutamentonige", "perm.nigeria", "perm.balinha", "perm.ilegal", "perm.baunigeria"},
	["Gerente [NIGERIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria","perm.recrutamentonige", "perm.balinha", "perm.ilegal", "perm.baunigeria"},
	["Recrutador [NIGERIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria","perm.recrutamentonige", "perm.balinha", "perm.ilegal", "perm.baunigeria"},
	["Membro [NIGERIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria", "perm.recrutamentonige","perm.balinha", "perm.ilegal", "perm.baunigeria"},
	["Aviaozinho [NIGERIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria", "perm.balinha", "perm.ilegal"},

	 --COLOMBIA--
	 ["Lider [COLOMBIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia","perm.recrutamentocolombia", "perm.lidercolombia", "perm.balinha", "perm.ilegal", "perm.baucolombia"},
	["Sub-Lider [COLOMBIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.lidercolombia","perm.recrutamentocolombia", "perm.colombia", "perm.balinha", "perm.ilegal", "perm.baucolombia"},
	["Gerente [COLOMBIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia","perm.recrutamentocolombia", "perm.balinha", "perm.ilegal", "perm.baucolombia"},
	["Recrutador [COLOMBIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia","perm.recrutamentocolombia", "perm.balinha", "perm.ilegal", "perm.baucolombia"},
	["Membro [COLOMBIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia","perm.recrutamentocolombia", "perm.balinha", "perm.ilegal", "perm.baucolombia"},
	["Aviaozinho [COLOMBIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia", "perm.balinha", "perm.ilegal"},
	
	--ARGENTINA--
	["Lider [ARGENTINA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Argentina", orgType = "Drogas"}, "perm.argentina","perm.recrutamentoargentina", "perm.liderargentina", "perm.balinha", "perm.ilegal", "perm.bauargentina"},
	["Sub-Lider [ARGENTINA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Argentina", orgType = "Drogas"}, "perm.liderargentina","perm.recrutamentoargentina", "perm.argentina", "perm.balinha", "perm.ilegal", "perm.bauargentina"},
	["Gerente [ARGENTINA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Argentina", orgType = "Drogas"}, "perm.argentina","perm.recrutamentoargentina", "perm.balinha", "perm.ilegal", "perm.bauargentina"},
	["Recrutador [ARGENTINA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Argentina", orgType = "Drogas"}, "perm.argentina","perm.recrutamentoargentina", "perm.balinha", "perm.ilegal", "perm.bauargentina"},
	["Membro [ARGENTINA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Argentina", orgType = "Drogas"}, "perm.argentina", "perm.recrutamentoargentina","perm.balinha", "perm.ilegal", "perm.bauargentina"},
	["Aviaozinho [ARGENTINA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Argentina", orgType = "Drogas"}, "perm.argentina", "perm.balinha", "perm.ilegal"},
	
	-- --PORTUGAL--
	["Lider [PORTUGAL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Portugal", orgType = "Drogas"}, "perm.portugal","perm.recrutamentoportugal", "perm.liderportugal", "perm.balinha", "perm.ilegal", "perm.bauportugal"},
	["Sub-Lider [PORTUGAL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Portugal", orgType = "Drogas"}, "perm.liderportugal", "perm.recrutamentoportugal","perm.portugal", "perm.balinha", "perm.ilegal", "perm.bauportugal"},
	["Gerente [PORTUGAL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Portugal", orgType = "Drogas"}, "perm.portugal","perm.recrutamentoportugal", "perm.balinha", "perm.ilegal", "perm.bauportugal"},
	["Recrutador [PORTUGAL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Portugal", orgType = "Drogas"}, "perm.portugal","perm.recrutamentoportugal", "perm.balinha", "perm.ilegal", "perm.bauportugal"},
	["Membro [PORTUGAL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Portugal", orgType = "Drogas"}, "perm.portugal","perm.recrutamentoportugal", "perm.balinha", "perm.ilegal", "perm.bauportugal"},
	["Aviaozinho [PORTUGAL]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Portugal", orgType = "Drogas"}, "perm.portugal", "perm.balinha", "perm.ilegal"},
	
	--CV--
	["Lider [CV]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cv", orgType = "Contrabando"}, "perm.cv", "perm.lidercv","perm.recrutamentocv", "perm.arma", "perm.ilegal", "perm.baucv"},
	["Sub-Lider [CV]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cv", orgType = "Contrabando"}, "perm.lidercvi", "perm.cv","perm.recrutamentocv", "perm.arma", "perm.ilegal", "perm.baucv"},
	["Gerente [CV]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cv", orgType = "Contrabando"}, "perm.cv", "perm.arma", "perm.ilegal","perm.recrutamentocv", "perm.baucv"},
	["Recrutador [CV]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cv", orgType = "Contrabando"}, "perm.cv", "perm.arma", "perm.ilegal","perm.recrutamentocv", "perm.baucv"},
	["Membro [CV]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cv", orgType = "Contrabando"}, "perm.cv", "perm.arma", "perm.ilegal","perm.recrutamentocv", "perm.baucv"},
	["Aviaozinho [CV]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Cv", orgType = "Contrabando"}, "perm.cv", "perm.arma", "perm.ilegal"},

	--CAMORRA--
	["Lider [CAMORRA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Camorra", orgType = "Contrabando"}, "perm.camorra", "perm.lidercamorra","perm.recrutamentocamorra", "perm.arma", "perm.ilegal", "perm.baucamorra"},
	["Sub-Lider [CAMORRA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Camorra", orgType = "Contrabando"}, "perm.lidercamorrai", "perm.camorra","perm.recrutamentocamorra", "perm.arma", "perm.ilegal", "perm.baucamorra"},
	["Gerente [CAMORRA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Camorra", orgType = "Contrabando"}, "perm.camorra", "perm.arma", "perm.ilegal","perm.recrutamentocamorra", "perm.baucamorra"},
	["Recrutador [CAMORRA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Camorra", orgType = "Contrabando"}, "perm.camorra", "perm.arma", "perm.ilegal","perm.recrutamentocamorra", "perm.baucamorra"},
	["Membro [CAMORRA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Camorra", orgType = "Contrabando"}, "perm.camorra", "perm.arma", "perm.ilegal","perm.recrutamentocamorra", "perm.baucamorra"},
	["Aviaozinho [CAMORRA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Camorra", orgType = "Contrabando"}, "perm.camorra", "perm.arma", "perm.ilegal"},
	
	--MEXICO--
	["Lider [MEXICO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mexico", orgType = "Contrabando"}, "perm.mexico", "perm.lidermexico","perm.recrutamentomexico", "perm.arma", "perm.ilegal", "perm.baumexico"},
	["Sub-Lider [MEXICO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mexico", orgType = "Contrabando"}, "perm.lidermexicoi", "perm.mexico","perm.recrutamentomexico", "perm.arma", "perm.ilegal", "perm.baumexico"},
	["Gerente [MEXICO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mexico", orgType = "Contrabando"}, "perm.mexico", "perm.arma", "perm.ilegal","perm.recrutamentomexico", "perm.baumexico"},
	["Recrutador [MEXICO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mexico", orgType = "Contrabando"}, "perm.mexico", "perm.arma", "perm.ilegal","perm.recrutamentomexico", "perm.baumexico"},
	["Membro [MEXICO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mexico", orgType = "Contrabando"}, "perm.mexico", "perm.arma", "perm.ilegal","perm.recrutamentomexico", "perm.baumexico"},
	["Aviaozinho [MEXICO]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mexico", orgType = "Contrabando"}, "perm.mexico", "perm.arma", "perm.ilegal"},
	
	--JAMAICA--
	["Lider [JAMAICA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Jamaica", orgType = "Contrabando"}, "perm.jamaica", "perm.liderjamaica","perm.recrutamentojamaica", "perm.arma", "perm.ilegal", "perm.baujamaica"},
	["Sub-Lider [JAMAICA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Jamaica", orgType = "Contrabando"}, "perm.liderjamaicai", "perm.jamaica","perm.recrutamentojamaica", "perm.arma", "perm.ilegal", "perm.baujamaica"},
	["Gerente [JAMAICA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Jamaica", orgType = "Contrabando"}, "perm.jamaica", "perm.arma", "perm.ilegal","perm.recrutamentojamaica", "perm.baujamaica"},
	["Recrutador [JAMAICA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Jamaica", orgType = "Contrabando"}, "perm.jamaica", "perm.arma", "perm.ilegal","perm.recrutamentojamaica", "perm.baujamaica"},
	["Membro [JAMAICA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Jamaica", orgType = "Contrabando"}, "perm.jamaica", "perm.arma", "perm.ilegal","perm.recrutamentojamaica", "perm.baujamaica"},
	["Aviaozinho [JAMAICA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Jamaica", orgType = "Contrabando"}, "perm.jamaica", "perm.arma", "perm.ilegal"},
	
	--AUSTRALIA--
	["Lider [AUSTRALIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Australia", orgType = "Contrabando"}, "perm.australia", "perm.lideraustralia","perm.recrutamentoaustralia", "perm.arma", "perm.ilegal", "perm.bauaustralia"},
	["Sub-Lider [AUSTRALIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Australia", orgType = "Contrabando"}, "perm.lideraustraliai", "perm.australia","perm.recrutamentoaustralia", "perm.arma", "perm.ilegal", "perm.bauaustralia"},
	["Gerente [AUSTRALIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Australia", orgType = "Contrabando"}, "perm.australia", "perm.arma", "perm.ilegal","perm.recrutamentoaustralia", "perm.bauaustralia"},
	["Recrutador [AUSTRALIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Australia", orgType = "Contrabando"}, "perm.australia", "perm.arma", "perm.ilegal","perm.recrutamentoaustralia", "perm.bauaustralia"},
	["Membro [AUSTRALIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Australia", orgType = "Contrabando"}, "perm.australia", "perm.arma", "perm.ilegal","perm.recrutamentoaustralia", "perm.bauaustralia"},
	["Aviaozinho [AUSTRALIA]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Australia", orgType = "Contrabando"}, "perm.australia", "perm.arma", "perm.ilegal"},

	
	
	
	
	
	
	

	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- PAISANA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	

-- PAISANA PMERJ
	["PComandoPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "comandopmerj.paisana"},
	["PCoronelPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "coronelpmerj.paisana"},
	["PTenenteCoronelPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "tenentecoronelpmerj.paisana"},
	["PMajorPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "majorpmerj.paisana"},
	["PCapitaoPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "capitaopmerj.paisana"},
	["PPrimeiroTenentePMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "primtenentepmerj.paisana"},
	["PSegundoTenentePMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "segtenentepmerj.paisana"},
	["PSubTenentePMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "subtenpmerj.paisana"},
	["PPrimeiroSargentoPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "primsargentopmerj.paisana"},
	["PSegundoSargentoPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "segsargentopmerj.paisana"},
	["PTerceiroSargentoPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "tercsargentopmerj.paisana"},
	["PCaboPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "cabopmerj.paisana"},
	["PSoldadoPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "soldadopmerj.paisana"},
	["PAlunoPMERJ"] = { _config = { gtype = "org", salario = 0, ptr = nil },  "alunopmerj.paisana"},

	-- PAISANA EXÉRCITO
	["PCoronel"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "coronelexercito.paisana"},
	["PTenenteCoronel"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "tencoronelexercito.paisana"},
	["PMajor"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "majorexercito.paisana"},
	["PCapitao"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "capitaoexercito.paisana"},
	["PPrimeiroTenente"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "primtenenteexercito.paisana"},
	["PSegundoTenente"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "segteneteexercito.paisana"},
	["PSubTenente"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "subtenenteexercito.paisana"},
	["PPrimeiroSargento"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "primsargexercito.paisana"},
	["PSegundoSargento"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "segsargexercito.paisana"},
	["PTerceiroSargento"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "tercsargexercito.paisana"},
	["PCabo"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "caboexercito.paisana"},
	["PSoldado"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "soldadoexercito.paisana"},

	-- PAISANA BOPE
	["PCoronelBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "CoronelBope.paisana"},
	["PTen.CoronelBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "CoronelBope.paisana"},
	["PMajorBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "MajorBope.paisana"},
	["PCapitaoBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "CapitaoBope.paisana"},
	["PTenenteBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "TenenteBope.paisana"},
	["PSargentoBope"] ={ _config = { gtype = "org", salario = 0, ptr = nil }, "SargentoBope.paisana"},
	["PCaboBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "CaboBope.paisana"},
	["PSoldadoBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "SoldadoBope.paisana"},
	["PRecrutaBope"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "RecrutaBope.paisana"},

	-- PAISANA POLICIA FEDERAL
	["PComandoGeralPF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "EscrivaoPF.paisana"},
	["PDelegadoPF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "EscrivaoPF.paisana"},
	["PDelegadoADJ.PF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "EscrivaoPF.paisana"},
	["PPeritoPF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "EscrivaoPF.paisana"},
	["PEscrivaoPF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "EscrivaoPF.paisana"},
	["PInspetorPF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "InspetorPF.paisana"},
	["PAgente.Cl1"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Agente.Cl1.paisana"},
	["PAgente.Cl2"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Agente.Cl2.paisana"},
	["PAgente.Cl3"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Agente.Cl3.paisana"},
	["PAgente.Cl4"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Agente.Cl4.paisana"},
	["PAgente.Cl5"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Agente.Cl5.paisana"},
	["PAlunoPF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "AlunoPF.paisana"},

	-- PAISANA PRF
	["PComandoGeralPRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "ComandoGeralPRF.paisana"},
	["PSub.ComandoPRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Sub.ComandoPRF.paisana"},
	["PDiretorPRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "DiretorPRF.paisana"},
	["PInspetorPRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "InspetorPRF.paisana"},
	["PAgente.especialPRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Agente.especialPRF.paisana"},
	["PClase3.PRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Clase3.PRF.paisana"},
	["PClase2.PRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Clase2.PRF.paisana"},
	["PClase1.PRF"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Clase1.PRF.paisana"},

	-- PAISANA POLICIA CIVIL
	["PDelegadoGeral"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "DelegadoGeral.paisana"},
	["PComandanteCore"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "ComandanteCore.paisana"},
	["PSubComandanteCore"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "SubComandanteCore.paisana"},
	["PDelegado"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Delegado.paisana"},
	["PCore"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Core.paisana"},
	["PPerito"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Perito.paisana"},
	["PEscrivao"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Escrivao.paisana"},
	["PInvestigador"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Investigador.paisana"},
	["PAgente"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Agente.paisana"},
	["PRecruta"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Recruta.paisana"},

	-- PAISANA HOSPITAL
	["PDiretor"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Diretor.paisana"},
	["PViceDiretor"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "ViceDiretor.paisana"},
	["PMedico"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Medico.paisana"},
	["PEnfermeiro"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Enfermeiro.paisana"},
	["PSocorrista"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Socorrista.paisana"},
	["PEstagiario"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "Estagiario.paisana"},

	-- PAISANA BOMBEIROS
	["PCoronelBombeiros"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "CoronelBombeiros.paisana"},
	["PMajorBombeiros"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "MajorBombeiros.paisana"},
	["PSargentoBombeiros"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "SargentoBombeiros.paisana"},
	["PTenenteBombeiros"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "TenenteBombeiros.paisana"},
	["PSubTenenteBombeiros"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "SubTenenteBombeiros.paisana"},
	["PSocorristaBombeiros"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "SocorristaBombeiros.paisana"},

	-- PAISANA MECANICAS
	["PLiderCustom"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "LiderCustom.paisana"},
	["PSubLiderCustom"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "SubLiderCustom.paisana"},
	["PGerenteCustom"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "GerenteCustom.paisana"},
	["PMecanicoCustom"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "MecanicoCustom.paisana"},
	["PAprendizCustom"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "AprendizCustom.paisana"},
		
	["PLiderStreetRacing"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "LiderStreetRacing.paisana"},
	["PSubLiderStreetRacinge"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "SubLiderStreetRacinge.paisana"},
	["PGerenteStreetRacing"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "GerenteStreetRacing.paisana"},
	["PMecanicoStreetRacing"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "MecanicoStreetRacing.paisana"},
	["PAprendizStreetRacinge"] = { _config = { gtype = "org", salario = 0, ptr = nil }, "AprendizStreetRacinge.paisana"},
	

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Mecanicas
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["LiderCustom"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "Mecanica" }, "dv.permissao","perm.recrutamentomec", "mecanico.permissao",'perm.mecanica','perm.lidermecanica', "perm.algemar", "lscustom.permissao"},
	["SubLiderCustom"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "Mecanica" }, "dv.permissao", "mecanico.permissao","perm.recrutamentomec",'perm.mecanica','perm.lidermecanica', "perm.algemar", "lscustom.permissao"},
	["GerenteCustom"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "Mecanica" }, "dv.permissao", "mecanico.permissao","perm.recrutamentomec",'perm.mecanica', "perm.algemar", "lscustom.permissao"},
	["MecanicoCustom"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Mecanica" }, "dv.permissao", "mecanico.permissao","perm.recrutamentomec",'perm.mecanica', "perm.algemar", "lscustom.permissao"},
	["AprendizCustom"] = { _config = { gtype = "org", salario = 3000, ptr = nil, orgName = "Mecanica" }, "mecanico.permissao",'perm.mecanica', "lscustom.permissao"},
	
	["LiderStreetRacing"] = { _config = { gtype = "org", salario = 12000, ptr = nil, orgName = "Mecanica" }, "dv.permissao","perm.recrutamentomec2", "mecanico.permissao",'perm.mecanica','perm.lidersportrace','perm.mecanica2', "perm.algemar", "sportrace.permissao"}, 
	["SubLiderStreetRacinge"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "Mecanica" }, "dv.permissao", "mecanico.permissao","perm.recrutamentomec2",'perm.mecanica','perm.lidersportrace','perm.mecanica2', "perm.algemar", "sportrace.permissao"},
    ["GerenteStreetRacing"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "Mecanica" }, "dv.permissao", "mecanico.permissao","perm.recrutamentomec2",'perm.mecanica','perm.mecanica2', "perm.algemar", "sportrace.permissao"},
    ["MecanicoStreetRacing"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Mecanica" }, "dv.permissao", "mecanico.permissao","perm.recrutamentomec2",'perm.mecanica','perm.mecanica2', "perm.algemar", "sportrace.permissao"},
    ["AprendizStreetRacinge"] = { _config = { gtype = "org", salario = 3000, ptr = nil, orgName = "Mecanica" }, "mecanico.permissao","perm.recrutamentomec2",'perm.mecanica','perm.mecanica2', "sportrace.permissao"},



}

cfg.users = {
	[1] = { "owner" },
	[2] = { "owner" },
	[3] = { "owner" },
	[4] = { "owner" },
	[5] = { "owner" },
}

cfg.selectors = { }

return cfg
