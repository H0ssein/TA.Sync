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

	Citizen.Trace('	^0[^5Debug^0] SyncT:Client :: Counted '..Count)
	
	if (Count ~= nil) then
		Config.iPlayers = (Count * Config.Static)
	end

	Wait(100)
	Config.Switch = true
	Citizen.Trace('	^0[^5Debug^0] SyncT:Client :: Deductions '..Config.iPlayers)
	Citizen.Trace('	^0[^5Debug^0] SyncT:Client :: Traffic now @  '..(Config.TrafficX - Config.iPlayers))
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
	
	while true do			
		Citizen.Wait(0)										-- Every Frame!
		if Config.Switch then								-- If switch = true
			Citizen.Wait(0)									-- Every Frame!
			for i = 0, 15 do								-- For all gangs and emergancy services.	
				EnableDispatchService(i, Config.Dispatch)	-- Disable responding/dispatch.
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
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		Clients()
		Citizen.Trace('	^0[^5Debug^0] SyncT:Client :: Syncing Traffic. ')
	end
end)

------------------------------------------------------------------------------