--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CACHE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local cache = {}
cache['getBankMoney'] = {}
cache['getMultas'] = {}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CARTEIRA
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.getMoney(user_id)
	if user_id then
		return parseInt(vRP.getInventoryItemAmount(user_id, "money")) or 0
	end
end

function vRP.giveMoney(user_id,amount)
	if user_id then
		if amount > 0 then
			vRP.giveInventoryItem(user_id, "money", amount, false)
			vRP.sendLog("https://discord.com/api/webhooks/1279011917800669306/ajM5S7ciPpNQ6gxLEaoDYL7PCK7hTAM3bhy-5Dcu9aO3fs4vpzLL3_3Fp0dzY32dYYXv", "```css\n[CARTEIRA]\nID: "..user_id.."\nVALOR: "..amount.."\nRESOURCE: "..GetInvokingResource().."```")
		end
	end
end

function vRP.tryPayment(user_id, amount)
	if user_id then
		if amount > 0 then
			if vRP.getInventoryItemAmount(user_id, "money") >= amount then
				vRP.tryGetInventoryItem(user_id, "money", amount)
				return true
			end
		end
		return false
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BANCO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.giveBankMoney(user_id, amount)
	if user_id then
		if parseInt(amount) > 0 then
			cache['getBankMoney'][user_id] = parseInt(vRP.getBankMoney(user_id))+parseInt(amount)
			vRP.setBankMoney(user_id, cache['getBankMoney'][user_id])
			vRP.sendLog("https://discord.com/api/webhooks/1279011917800669306/ajM5S7ciPpNQ6gxLEaoDYL7PCK7hTAM3bhy-5Dcu9aO3fs4vpzLL3_3Fp0dzY32dYYXv", "```css\n[BANCO]\nID: "..user_id.."\nVALOR: "..amount.."\nRESOURCE: "..GetInvokingResource().."```")
		end
	end
end
 
function vRP.getBankMoney(user_id)
	local source = vRP.getUserSource(user_id)
	if source then
		if user_id then
			if cache['getBankMoney'][user_id] == nil then
				local rows = vRP.query("vRP/get_user_identity",{ user_id = user_id })
				if rows[1] then
					cache['getBankMoney'][user_id] = parseInt(rows[1].banco)
				end
			end
			
			return cache['getBankMoney'][user_id] or 0
		end
	else
		local rows = vRP.query("vRP/get_user_identity",{ user_id = user_id })
		if rows[1] then
			return parseInt(rows[1].banco)
		end
	end
end

function vRP.setBankMoney(user_id, amount)
	local source = vRP.getUserSource(user_id)
	if source then
		if user_id then
			if parseInt(amount) >= 0 then
				cache['getBankMoney'][user_id] = amount
				vRP.execute("vRP/update_banco",{ user_id = user_id, banco = cache['getBankMoney'][user_id] })
				return
			end
		end
	else
		vRP.execute("vRP/update_banco",{ user_id = user_id, banco = amount })
		return
	end
end

function vRP.tryWithdraw(user_id, amount)
	if user_id then
		if parseInt(amount) > 0 then
			local banco = vRP.getBankMoney(user_id)
			if parseInt(banco) >= parseInt(amount) then
				vRP.giveMoney(user_id, parseInt(amount))
				vRP.setBankMoney(user_id, parseInt(banco)-parseInt(amount))
				return true
			end
		end
		return false
	end
end

function vRP.tryDeposit(user_id, amount)
	if user_id then
		if parseInt(amount) > 0 then
			local money = vRP.getMoney(user_id)
			if money >= parseInt(amount) then
				vRP.tryGetInventoryItem(user_id, "money", parseInt(amount))
				vRP.setBankMoney(user_id, parseInt(vRP.getBankMoney(user_id))+parseInt(amount))
				return true
			end
		end
		return false
	end
end

function vRP.tryTransfer(user_id, target_id, amount)
	target_id = parseInt(target_id)
	if user_id then
		if parseInt(amount) > 0 then
			local banco = vRP.getBankMoney(user_id)
			local nbanco = vRP.getBankMoney(target_id)
			if nbanco then
				if parseInt(banco) >= parseInt(amount) then
					vRP.setBankMoney(user_id, parseInt(banco)-parseInt(amount))
					vRP.setBankMoney(target_id, parseInt(nbanco)+parseInt(amount))
					return true
				end
			end

		end
		return false
	end
end

function vRP.tryFullPayment(user_id, amount)
	if user_id then
		if amount > 0 then
			local money = vRP.getMoney(user_id)
			if money >= parseInt(amount) then
				return vRP.tryPayment(user_id, parseInt(amount))
			else
				if vRP.tryWithdraw(user_id, parseInt(amount)-money) then
					return vRP.tryPayment(user_id,parseInt(amount))
				end
			end
		end
		return false
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MULTAS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.getMultas(user_id)
	if user_id then
		if cache['getMultas'][user_id] == nil then
			local rows = vRP.query("vRP/get_user_identity",{ user_id = user_id })
			if rows[1] then
				cache['getMultas'][user_id] = parseInt(rows[1].multas)
			end
		end

		return cache['getMultas'][user_id] or 0
	end
end

function vRP.updateMultas(user_id, amount)
	if user_id then
		cache['getMultas'][user_id] = amount
		vRP.execute("vRP/update_multas",{ user_id = user_id, multas = cache['getMultas'][user_id] })
		return
	end
end

AddEventHandler("playerDropped", function(reason)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		cache['getBankMoney'][user_id] = nil
    end
end)