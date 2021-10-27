RegisterNetEvent('fix-sync:GetVehicleToFix', function()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsIn(ped, false)
		if veh and veh ~= nil then
			TriggerServerEvent('fix-sync:TrowEvent', VehToNet(veh))
		end
	end
end)

RegisterNetEvent('fix-sync:FixTheVehicle', function(vehId)
	local debug = false
	if vehId ~= nil then
    	if NetworkDoesNetworkIdExist(vehId) then
	        local vehicle = NetToEnt(vehId)
	        if DoesEntityExist(vehicle) then
				SetVehicleEngineHealth(vehicle, 1000)
				SetVehicleFixed(vehicle)
				SetVehicleDirtLevel(vehicle, 0.0)
				SetVehicleOnGroundProperly(vehicle)
				if debug then
					print('Sync | Fixed vehicle with plate ' .. GetVehicleNumberPlateText(vehicle))
				end
	        end
	    end
	end
end)
