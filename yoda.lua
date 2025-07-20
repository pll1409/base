local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Config = {}

-- Lista de frentistas
Config.pedlist = {

	{ ['x'] = 265.03, ['y'] = -1263.29, ['z'] = 29.3, ['h'] = 80.98, ['hash'] = 0xEDA0082D, ['hash2'] = "ig_jimmyboston" },
	{ ['x'] = 265.11, ['y'] = -1255.15, ['z'] = 29.3, ['h'] = 80.98, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 173.95, ['y'] = -1557.98, ['z'] = 29.33, ['h'] = 210.33, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	
-- Posto Paleto
	{ ['x'] = 187.24, ['y'] = 6604.27, ['z'] = 31.87, ['h'] = 188.19, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 172.6, ['y'] = 6601.51, ['z'] = 31.87, ['h'] = 188.84, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 179.89, ['y'] = 6602.99, ['z'] = 31.87, ['h'] = 190.01, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	
-- Posto Zancudo
	{ ['x'] = -2554.92, ['y'] = 2327.03, ['z'] = 33.08, ['h'] = 274.55, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = -2555.1, ['y'] = 2334.44, ['z'] = 33.08, ['h'] = 101.13, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = -2555.88, ['y'] = 2341.67, ['z'] = 33.08, ['h'] = 273.32, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

-- Posto Praia 
	{ ['x'] = -2088.61, ['y'] = -325.43, ['z'] = 13.03, ['h'] = 175.83, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = -2097.25, ['y'] = -324.41, ['z'] = 13.03, ['h'] = 175.83, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = -2105.86, ['y'] = -323.31, ['z'] = 13.03, ['h'] = 175.83, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

-- Posto Marinha (Helicoptero)	
	{ ['x'] = -706.16, ['y'] = -1464.24, ['z'] = 5.05, ['h'] = 50.07, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

-- Posto Benny's
	{ ['x'] = -312.06, ['y'] = -1467.23, ['z'] = 30.55, ['h'] = 124.90, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = -319.3, ['y'] = -1471.91, ['z'] = 30.55, ['h'] = 31.66, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = -327.35, ['y'] = -1475.95, ['z'] = 30.55, ['h'] = 298.56, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

-- Posto Palomino
	{ ['x'] = 2573.79, ['y'] = 362.09, ['z'] = 108.47, ['h'] = 88.72, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 2581.21, ['y'] = 361.69, ['z'] = 108.47, ['h'] = 3.92, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 2588.45, ['y'] = 361.45, ['z'] = 108.47, ['h'] = 85.67, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

-- Posto Barney
	{ ['x'] = 2540.26, ['y'] = 2594.06, ['z'] = 37.95, ['h'] = 103.62, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

-- Posto Los Santos Custons Sandy Shores
	{ ['x'] = 1208.19, ['y'] = 2660.68, ['z'] = 37.9, ['h'] = 311.82, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 1039.18, ['y'] = 2667.83, ['z'] = 39.56, ['h'] = 7.50, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 1039.22, ['y'] = 2674.22, ['z'] = 39.56, ['h'] = 7.50, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 264.03, ['y'] = 2607.61, ['z'] = 44.99, ['h'] = 9.08, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

-- Posto Galaxy
	{ ['x'] = 611.86, ['y'] = 268.77, ['z'] = 103.09, ['h'] = 272.81, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 620.86, ['y'] = 269.35, ['z'] = 103.09, ['h'] = 179.72, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	{ ['x'] = 629.71, ['y'] = 268.95, ['z'] = 103.09, ['h'] = 92.59, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },

}

-- Função que retorna o dinheiro que o jogador tem 
-- retorno: Dinheiro do player 
function returnMoney(source)
	local user_id = vRP.getUserId(source)
	return parseInt(vRP.getBankMoney(user_id) + vRP.getMoney(user_id))
end

-- Função para um jogador realizar pagamento
-- retorno: True caso tenha conseguido retirar o dinheiro falso caso contrário
function checkPayment(source, amount)
	local user_id = vRP.getUserId(source)
	if vRP.tryFullPayment(user_id,amount) then
		return true
	else 
		TriggerClientEvent("Notify", source, "negado", "Dinheiro insuficiente para abastecer.")
		return false
	end
end

-- Se true o frentista sempre ira até a roda mais próxima da bomba, porém sua movimentação pode bugar em alguns casos. 
--(mais realista)
-- Se false, o frentista sempre abastecerá na roda esquerda, evitando bugs na movimentação do mesmo.
--(mais seguro)
Config.nearWheel = false

-- Se true, os frentistas irão assoviar assim que algum jogador se aproximar
Config.whistle = true

-- Cooldown do assovio dos frentistas (segundos)
Config.whistleCD = 180

-- Som do frentista abastecendo o carro
Config.sound = true

-- Volume do som
Config.volume = 0.2

-- Preço por Litro da Gasolina
Config.tax = 5

-- Preço do galao
Config.canPrice = 600

-- Botão para abrir a tampa do veículo
Config.openButton = 47

-- Taxa de velocidade do abastecimento manual (Quanto menor mais rapido e maior o "ms")
Config.vel = 2.5

-- Velocidade de abastecimento do frentista
Config.velFrontMan = 0.2

-- Id do decorador utilizado
Config.FuelDecor = "FUEL_LEVEL"

-- Controles desabilitados no momento do abastecimento
Config.DisableKeys = { 0,22,23,24,29,30,31,37,44,56,82,140,166,167,168,170,288,289,311,323 }

-- Hash dos modelos da bomba aceitos
Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Taxa de perda de gasolina para cada tipo de classe de veículo
Config.Classes = {
	[0] = 1.2, -- Compacts
	[1] = 1.2, -- Sedans
	[2] = 1.2, -- SUVs
	[3] = 1.2, -- Coupes
	[4] = 1.2, -- Muscle
	[5] = 1.2, -- Sports Classics
	[6] = 1.2, -- Sports
	[7] = 1.2, -- Super
	[8] = 1.2, -- Motorcycles
	[9] = 1.2, -- Off-road
	[10] = 1.2, -- Industrial
	[11] = 1.2, -- Utility
	[12] = 1.2, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 1.0, -- Boats
	[15] = 0.7, -- Helicopters
	[16] = 0.0, -- Planes
	[17] = 1.0, -- Service
	[18] = 1.0, -- Emergency
	[19] = 1.0, -- Military
	[20] = 1.2, -- Commercial
	[21] = 1.2, -- Trains
}

-- Não alterar
Config.FuelUsage = {
	[1.0] = 1.0,
	[0.9] = 0.9,
	[0.8] = 0.8,
	[0.7] = 0.7,
	[0.6] = 0.6,
	[0.5] = 0.5,
	[0.4] = 0.4,
	[0.3] = 0.3,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

-- Não alterar
Config.money = returnMoney
Config.payment = checkPayment