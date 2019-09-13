--			Traffic Apendix | Alter Traffic and Vechile Spawns				--
--				By DK - 2019...	Dont forget your Bananas!					--
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Global Variables
------------------------------------------------------------------------------



------------------------------------------------------------------------------
-- Local Variables
------------------------------------------------------------------------------



------------------------------------------------------------------------------
-- Functions
------------------------------------------------------------------------------

function CountOfPlayers(count)
	local Server = count
	local Client = 0
	
	for _,v in ipairs(GetActivePlayers()) do 
		Client = Client + 1
	end
	
	return Client
end

------------------------------------------------------------------------------
-- Events
------------------------------------------------------------------------------

AddEventHandler('TrafficA:Switch', function(count)
	local Server = count
	local Client = CountOfPlayers(count)
	
	if (count ~= nil) then
		
		if Config.Switch then
			Config.Switch = false
		end
		
		print('Traffic Amended Locally.')
		print('Server Count:'..Server..' || Client Count:'..Client)
	end

end)

------------------------------------------------------------------------------
-- Threads
------------------------------------------------------------------------------

Citizen.CreateThread(function()
	local iPlayer = GetEntityCoords(PlayerPedId())	-- Your Ped as an Entity. Vector3 (x,y,z)
	local iPlayerID = GetPlayerServerId()			-- Your Ped's ID.
	
	DisablePlayerVehicleRewards(iPlayerID)		-- Call it once.
	
	while Config.Switch == true do				-- Call it all...
		Citizen.Wait(0)							-- Every Frame!
		for i = 0, 15 do						-- For all gangs and emergancy services.	
			EnableDispatchService(i, Config.Dispatch)		-- Disable responding/dispatch.
		end			
		SetVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
		SetPedDensityMultiplierThisFrame((Config.PedestrianX - Config.iPlayers) / Config.Divider)
		SetRandomVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
		SetParkedVehicleDensityMultiplierThisFrame((Config.ParkedX - Config.iPlayers) / Config.Divider)
		SetScenarioPedDensityMultiplierThisFrame((Config.PedestrianX - Config.iPlayers) / Config.Divider, (Config.PedestrianX - Config.iPlayers) / Config.Divider)
		ClearAreaOfCops(iPlayer.x, iPlayer.y, iPlayer.z, 5000.0)
		RemoveVehiclesFromGeneratorsInArea(iPlayer.x - 45.0, iPlayer.y - 45.0, iPlayer.z - 15.0, iPlayer.x + 45.0, iPlayer.y + 45.0, iPlayer.z + 15.0);
		SetGarbageTrucks(0)
		SetRandomBoats(0)
	end
end)

------------------------------------------------------------------------------