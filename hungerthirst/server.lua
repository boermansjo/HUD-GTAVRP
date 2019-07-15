-- Save hunger and thirst to database
RegisterServerEvent("saveHungerThirst")
AddEventHandler("saveHungerThirst", function(hunger, thirst)
  TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.getIdentifier()
		MySQL.Async.execute("UPDATE hungerthirst SET hunger=@hunger, thirst=@thirst WHERE idSteam=@identifier", {['@identifier'] = player, ['@hunger'] = hunger, ['@thirst'] = thirst})
	end)
end)

-- Get hunger and thirst from database at spawn
RegisterServerEvent("getPlayerHungerThirst")
AddEventHandler("getPlayerHungerThirst", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local _source = source
    local player = user.getIdentifier()
    MySQL.Async.fetchAll('SELECT hunger, thirst FROM hungerthirst WHERE idSteam=@identifier', {['@identifier'] = player}, function(result)
      if(result)then
        TriggerClientEvent("PlayerHungerThirst", _source, result)
      end
    end)
  end)
end)
