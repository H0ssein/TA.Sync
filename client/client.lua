--			Sync Traffic | Alter Traffic and Vechile Spawns					--
--				By DK - 2019...	Dont forget your Bananas!					--
------------------------------------------------------------------------------

------------------------------------------------------------------------------
--	Global Variables
------------------------------------------------------------------------------



------------------------------------------------------------------------------
--	Local Variables
------------------------------------------------------------------------------



------------------------------------------------------------------------------
--	Functions
------------------------------------------------------------------------------

function Clients()
	Count = 0
	Config.iPlayers = 0	
	Config.Switch = false
	for _,v in ipairs(GetActivePlayers()) do
		Count = Count + 1
	end
	if (Count ~= nil) then
		Config.iPlayers = (Count * Config.Static)
	end
	Wait(100)
	Config.Switch = true
end

------------------------------------------------------------------------------
--	Events
------------------------------------------------------------------------------



------------------------------------------------------------------------------
--	Threads
------------------------------------------------------------------------------

Citizen.CreateThread(function()
	local iPlayer = GetEntityCoords(PlayerPedId())			-- Your Ped as an Entity. Vector3 (x,y,z)
	local iPlayerID = GetPlayerServerId()					-- Your Ped's ID.
	DisablePlayerVehicleRewards(iPlayerID)					-- Call it once.
	
	while Config.Switch  do			
		Citizen.Wait(0)										-- Every Frame!
		for i = 0, 15 do									-- For all gangs and emergancy services.	
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		Clients()
	end
end)

------------------------------------------------------------------------------