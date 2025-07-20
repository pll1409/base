-----------------------------------------------------------------------------------------------------------------------------------------
-- GetCoordsFromCam
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(distance,coords)
	local rotation = GetGameplayCamRot()
	local adjustedRotation = vector3((math.pi / 180) * rotation["x"],(math.pi / 180) * rotation["y"],(math.pi / 180) * rotation["z"])
	local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.sin(adjustedRotation[1]))

	return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- objectCoords
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.objectCoords(model)
	local ped = PlayerPedId()
	local objectProgress = true
	local aplicationObject = false
	local mHash = GetHashKey(model)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	local coords = GetEntityCoords(ped)
	local pedHeading = GetEntityHeading(ped)
	local newObject = CreateObject(mHash,coords["x"],coords["y"],coords["z"],false,false,false)
	SetEntityCollision(newObject,false,false)
	SetEntityHeading(newObject,pedHeading)
	SetEntityAlpha(newObject,100,false)

	while objectProgress do
		local ped = PlayerPedId()
		local cam = GetGameplayCamCoord()
		local handle = StartExpensiveSynchronousShapeTestLosProbe(cam,GetCoordsFromCam(10.0,cam),-1,ped,4)
		local _,_,coords = GetShapeTestResult(handle)

		SetEntityCoordsNoOffset(newObject,coords["x"],coords["y"],coords["z"],1,0,0)

		dwText("~g~F~w~  CANCELAR",4,0.015,0.86,0.38,255,255,255,255)
		dwText("~g~E~w~  COLOCAR OBJETO",4,0.015,0.89,0.38,255,255,255,255)
		dwText("~y~SETA ESQUERDA~w~  GIRA ESQUERDA",4,0.015,0.92,0.38,255,255,255,255)
		dwText("~y~SETA DIREITA~w~  GIRA DIREITA",4,0.015,0.95,0.38,255,255,255,255)

		if IsControlJustPressed(1,38) then
			aplicationObject = true
			objectProgress = false
		end

		if IsControlJustPressed(1,49) then
			objectProgress = false
		end

		if IsControlJustPressed(1,189) then
			local headObject = GetEntityHeading(newObject)
			SetEntityHeading(newObject,headObject + 2.5)
		end

		if IsControlJustPressed(1,190) then
			local headObject = GetEntityHeading(newObject)
			SetEntityHeading(newObject,headObject - 2.5)
		end

		Citizen.Wait(1)
	end

	local headObject = GetEntityHeading(newObject)
	local coordsObject = GetEntityCoords(newObject)
	local _,GroundZ = GetGroundZFor_3dCoord(coordsObject["x"],coordsObject["y"],coordsObject["z"])

	local newCoords = {
		["x"] = coordsObject["x"],
		["y"] = coordsObject["y"],
		["z"] = coordsObject["z"]
		-- ["z"] = GroundZ
	}

	DeleteEntity(newObject)

	return aplicationObject,newCoords,headObject
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end