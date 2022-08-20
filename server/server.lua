local QBCore = exports['qb-core']:GetCoreObject()

local function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

local function createToken(value) 
    local item = Config.Items.filled
    local token = Config.Tokens[value]
    local info = {}
    if token then
        info.value = token.value
        info.label = token.label
    else
        print("The added token does not exist in the Config.Lua")
        info.value = value
    end

    return item, info
end

local function getQBItem(item)
    local qbItem = QBCore.Shared.Items[item]
    if qbItem then
        return qbItem
    else
        print('Someone forgot to add the item')
    end
end

-- ADD TOKEN

RegisterServerEvent('cw-tokens:server:GiveToken', function(value)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    local item, info = createToken(value)

    Player.Functions.AddItem(item, 1, nil, info)
    TriggerClientEvent('inventory:client:ItemBox', source, getQBItem(item), "add")
end)

-- TAKE TOKEN
RegisterNetEvent('cw-tokens:server:TakeToken', function(value)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Items.filled

    local ped = QBCore.Functions.GetPlayer(src)
    local id = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
	local Player = QBCore.Functions.GetPlayer(src)
    local tokens = Player.Functions.GetItemsByName(Config.Items.filled)

    local slot = nil
    if tokens then
        for _, item in ipairs(tokens) do
            if item.info.value == value then
                slot = item.slot
            end
        end
    end
    Player.Functions.RemoveItem(item, 1, slot)
    TriggerClientEvent('inventory:client:ItemBox', src, getQBItem(item), "remove")
end)

-- Fill Token

local function fillToken(source, value, trade)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local itemFrom = Config.Items.empty
    local itemTo = Config.Items.filled

    local ped = QBCore.Functions.GetPlayer(src)
    local id = ped.PlayerData.citizenid
	local Player = ped
    local tokens = Player.Functions.GetItemsByName(Config.Items.empty)
    local slot = nil
    if #tokens>0 then
        if trade then
	        Player.Functions.RemoveMoney("cash", Config.Tokens[value].price)
        end

        Player.Functions.RemoveItem(itemFrom, 1, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, getQBItem(itemFrom), "remove")
        local item, info = createToken(value)

        Player.Functions.AddItem(item, 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', source, getQBItem(item), "add")
    else
        TriggerClientEvent('QBCore:Notify', src, "You got no empty tokens", 'error')
    end
end

RegisterNetEvent('cw-tokens:server:FillToken', function(value)
    local src = source
    fillToken(src, value)
end)

RegisterNetEvent('cw-tokens:server:TradeToken', function(value)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money['cash'] >= Config.Tokens[value].price then
		Player.Functions.RemoveMoney('cash', Config.Tokens[value].price, "Running Costs")
        fillToken(src, value, trade)
	else
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"damn"})
		TriggerClientEvent('QBCore:Notify', src, "Not enough money", 'error')
	end

end)


-- COMMANDS
QBCore.Commands.Add('createtoken', 'give token with value. (Admin Only)',{ { name = 'value', help = 'what value should the token contain' }}, true, function(source, args)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    
    local item, info = createToken(args[1])
    
    Player.Functions.AddItem(item, 1, nil, info)
    TriggerClientEvent('inventory:client:ItemBox', source, getQBItem(item), "add")
end, 'admin')

QBCore.Commands.Add('filltoken', 'exchange empty token to filled with value. (Admin Only)',{ { name = 'value', help = 'what value should the token contain' }}, true, function(source, args)
    local src = source
    fillToken(src, args[1])
end, 'admin')