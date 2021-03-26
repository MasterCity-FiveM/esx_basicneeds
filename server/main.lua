ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for k, v in pairs(Config.Food) do
	ESX.RegisterUsableItem(v, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(v, 1)

		TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)
		TriggerClientEvent('esx_basicneeds:onEat', source)
		TriggerClientEvent("pNotify:SendNotification", source, { text = _U('used_bread'), type = "info", timeout = 5000, layout = "bottomCenter"})
	end)
end

for k, v in pairs(Config.Drinks) do
	ESX.RegisterUsableItem(v, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(v, 1)

		TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
		TriggerClientEvent('esx_basicneeds:onDrink', source)
		TriggerClientEvent("pNotify:SendNotification", source, { text = _U('used_water'), type = "info", timeout = 5000, layout = "bottomCenter"})
	end)
end

ESX.RunCustomFunction("AddCommand", {"heal"}, 1, function(xPlayer, args)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, {
	{name = 'playerId', type = 'player'},
}, '.heal PlayerID', '.')