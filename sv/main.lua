RegisterCommand('fix', function(source, args, rawCommand)
	local src = source
	if src ~= nil then
		if hasPermission(ESX.GetPlayerFromId(src)) then
			TriggerClientEvent('fix-sync:GetVehicleToFix', src)
		end
	end
end)

RegisterServerEvent('fix-sync:TrowEvent', function(vehId)
	local _source = source
	if _source ~= nil then
		if hasPermission(ESX.GetPlayerFromId(_source)) then
			if vehId ~= nil then
				local entityCoords = GetEntityCoords(NetworkGetEntityFromNetworkId(vehId))

				for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
					if xPlayer ~= nil then
						local src = xPlayer.source
						local ped = GetPlayerPed(src)
						local plyCoords = GetEntityCoords(ped)
						if #(entityCoords - plyCoords) <= 200 then
							print('Event fired for player: ' .. GetPlayerName(src))
							TriggerClientEvent('fix-sync:FixTheVehicle', src, vehId)
						end
					end
				end
			end
		else
			TriggerClientEvent('esx:showNotification', source, 'No permission.')
		end
	end
end)

function hasPermission(xPlayer)
	if xPlayer and xPlayer ~= nil then
		if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod' or xPlayer.getJob().name == 'mechanic' then
			return true
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, 'No permission.')
		return false
	end
end
