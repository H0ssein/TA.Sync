-- 		 LosOceanic_TA =  Traffic / Pedestrian / Parked Cars Adjuster		--
--		Every 5 Minutes, count player total and update the calculation		--
--			By DK - 2019			...	Dont forget your Bananas!			--
------------------------------------------------------------------------------

--[[ Loading ESX Object Dependancies ]]--

ESX = nil

Citizen.CreateThread(function()
		if ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
end)

--[[ ESX Loaded - Generate Code Below ]]--

------------------------------------------------------------------------------

-- The math is, ( ( (Config.Amount of Players * 2.25 ) - Config.Static Number) / Config.Into One thousand)
-- The deal is to reduce the overal feel of the city as the player population is introduced.
		
-- The natives take a [0 as nothing, 1 as normal, 2 as doubled etc] value. 
-- So why not make it like 0.102324232834763725467182713618 @ 128 Players

------------------------------------------------------------------------------

------------------------------------------------------------------------------

Citizen.CreateThread(function()
	local PlayerPed = GetPlayerPed(-1)
	local iPlayer 	= GetEntityCoords(PlayerPed, true)
	local 
	
	while true do														-- Every Frame!
		SetVehicleDensityMultiplierThisFrame((Config['TrafficX'] - Config['iPlayers']) / Config['Divider'])
		SetPedDensityMultiplierThisFrame((Config['PedestrianX'] - Config['iPlayers']) / Config['Divider'])
		SetRandomVehicleDensityMultiplierThisFrame((Config['TrafficX'] - Config['iPlayers']) / Config['Divider'])
		SetParkedVehicleDensityMultiplierThisFrame((Config['ParkedX'] - Config['iPlayers']) / Config['Divider'])
		SetScenarioPedDensityMultiplierThisFrame((Config['PedestrianX'] - Config['iPlayers']) / Config['Divider']), ((Config['PedestrianX'] - Config['iPlayers']) / Config.[Divider])				
		ClearAreaOfCops(iPlayer['x'] iPlayer['y'] iPlayer['z'], 5000.0)			-- To Ensure Police dont spawn.	
		RemoveVehiclesFromGeneratorsInArea(iPlayer['x'] - 35.0, iPlayer['y'] - 35.0, iPlayer['z'] - 35.0, iPlayer['x'] + 35.0, iPlayer['y'] + 35.0, iPlayer['z'] + 35.0);
		SetGarbageTrucks(0)
		SetRandomBoats(0)
		SetPoliceIgnorePlayer(PlayerPed, true)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		for i = 1, 15 do													-- For all gangs and emergancy services.	
			EnableDispatchService(i, Config['Dispatch'])						-- Disable responding/dispatch.
		end	
		Citizen.Wait(0)		
	end
end)

------------------------------------------------------------------------------

------------------------------------------------------------------------------

RegisterNetEvent('LosOce_TA:Force')
AddEventHandler('LosOce_TA:Force', function(xPlayers)
	local xPlayers  = ESX.GetPlayers()
	local iPlayer   = PlayerID()
	
	for _, v in pairs(xPlayers) do
		if xPlayers.v == iPlayer then
			Check()
		end
	end

end)

------------------------------------------------------------------------------

------------------------------------------------------------------------------

function Check()								-- Tell that Global Variable to be beautiful.

	local Multiplier = 0						-- Player Count.

	for i in ipairs(GetActivePlayers()) do
		local iPed = GetPlayerPed(i)

		if DoesEntityExist(iPed) then
			Multiplier = Multiplier + 1
		else
		print('	^0[^1Alert^0] : | Traffic has not been altered. - Nill players. | : [^1Alert^0] ')	
		end
	end
		
	if Multiplier ~= 0 then
		Config[iPlayers] = (Config[Static] * Multiplier)
		print('	^0[^1Alert^0] : | Traffic Adjusted by [' .. Multiplier .. '] players, [-' .. Config[iPlayers] ..  '] total. | : [^1Alert^0] ')		
	elseif Multiplier == 0 then
		print('	^0[^1Alert^0] : | Traffic has not been altered as there are no players. ' .. Config[iPlayers] .. '| : [^1Alert^0] ')	
	end	
	
end
