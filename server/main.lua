ESX.RegisterCommand('eup', 'admin', function(xPlayer, args, showError)
	if not args.playerId then
		args.playerId = xPlayer.playerId
	end
	TriggerClientEvent('dd_eup:open', args.playerId, args.category)
end, true, {help = 'Open the EUP menu', validate = false, arguments = {
	{name = 'category', help = 'The EUP category', type = 'string'},
	{name = 'playerId', help = 'The player id', type = 'any'}
}})

ESX.RegisterCommand('eupoutfit', 'admin', function(xPlayer, args, showError)
	if not args.playerId then
		args.playerId = xPlayer.playerId
	end
	TriggerClientEvent('dd_eup:setOutfit', args.playerId, args.outfit)
end, true, {help = 'Open the EUP menu', validate = false, arguments = {
	{name = 'outfit', help = 'The EUP outfit', type = 'string'},
	{name = 'playerId', help = 'The player id', type = 'any'}
}})
