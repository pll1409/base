-- Função para dividir uma string com base em um separador
local function stringsplit(inputstr, sep)
	sep = sep or "%s"
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

-- Função para verificar se uma string começa com um prefixo específico
local function starts_with(str, start)
	return str:sub(1, #start) == start
end

-- Função para processar o arquivo de configurações
local function processSettings()
	local settingsFile = LoadResourceFile(GetCurrentResourceName(), "control/data-side/visualsettings.dat")
	local lines = stringsplit(settingsFile, "\n")
	for _, line in ipairs(lines) do
		-- Remove comentários e linhas vazias
		if not starts_with(line, '#') and not starts_with(line, '//') and line:match("%S") then
			line = line:gsub("%s+", " ")
			local setting = stringsplit(line, " ")
			local key = setting[1]
			local value = tonumber(setting[2])
			
			if key and value then
				-- Define as configurações visuais, ignorando 'weather.CycleDuration'
				if key ~= 'weather.CycleDuration' then
					Citizen.InvokeNative(GetHashKey('SET_VISUAL_SETTING_FLOAT') & 0xFFFFFFFF, key, value + 0.0)
				end
			end
		end
	end
end

-- Chama a função para processar as configurações imediatamente
processSettings()
