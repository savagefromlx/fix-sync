RegisterCommand('fix', function(source, args, rawCommand)
	local src = source
	local ply = ESX.GetPlayerFromId(src)
	if ply ~= nil then
		if hasPermission(ply) then
			TriggerClientEvent('fix-sync:GetVehicleToFix', src)
		end
	end
end)

RegisterServerEvent('fix-sync:TrowEvent', function(vehId)
	if vehId ~= nil then
		local entityCoords = GetEntityCoords(NetworkGetEntityFromNetworkId(vehId))

		for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
			local src = xPlayer.source
			local ped = GetPlayerPed(src)
			local plyCoords = GetEntityCoords(ped)
			if #(entityCoords - plyCoords) <= 200 then
				print('Event fired for player: ' .. GetPlayerName(src))
				TriggerClientEvent('fix-sync:FixTheVehicle', src, vehId)
			end
		end
	end
end)

function hasPermission(xPlayer)
	if xPlayer and xPlayer ~= nil then
		if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod' then
			return true
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, 'No permission.')
		return false
	end
end
