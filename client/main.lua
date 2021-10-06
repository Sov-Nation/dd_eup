function has_value(tab, val)
    for index, value in pairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function setOutfit(outfit)
    local ped = PlayerPedId()

    if GetEntityModel(ped) ~= GetHashKey(outfit.ped) then
		ESX.ShowNotification('~r~Wrong Gender', false, true, nil)
		return
    end

    RequestModel(outfit.ped)

    while not HasModelLoaded(outfit.ped) do
        Wait(0)
    end

    for _, comp in ipairs(outfit.components) do
       SetPedComponentVariation(ped, comp[1], comp[2] - 1, comp[3] - 1, 0)
    end

    for _, props in ipairs(outfit.props) do
        if props[2] == 0 then
            ClearPedProp(ped, props[1])
        else
            SetPedPropIndex(ped, props[1], props[2] - 1, props[3] - 1, true)
        end
    end
end

RegisterNetEvent('dd_eup:open')
AddEventHandler('dd_eup:open', function(category)
	ESX.UI.Menu.CloseAll()
	local elements = {}

	if category == 'all' then
		for k, v in pairs(Config.Outfits) do
			table.insert(elements, {
				label = k,
				value = v
			})
		end
	elseif type(category) == 'table' then
		for k, v in pairs(category) do
			if Config.Sets[category] then
				table.insert(elements, {
					label = category,
					value = Config.Sets[category]
				})
			end
		end
	elseif Config.Outfits[category] then
		elements[1] = {label = category, value = Config.Outfits[category]}
	end
	if not next(elements) then
		table.insert(elements, {label = 'No categories'})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'categories', {
		title    = 'EUP Categories',
		align    = 'top-left',
		elements = elements
	},
	function(data, menu)
		local elements = {}
		for k, v in pairs(data.current.value) do
			table.insert(elements, {
				label = k,
				value = v
			})
		end
		if not next(elements) then
			table.insert(elements, {label = 'None'})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'outfits', {
			title    = 'EUP - ' .. data.current.label,
			align    = 'top-left',
			elements = elements
		},
		function(data2, menu2)
			setOutfit(data2.current.value)
		end,
		function(data2, menu2)
			menu2.close()
		end)
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('dd_eup:setOutfit')
AddEventHandler('dd_eup:setOutfit', function(outfit)
	for k, v in pairs(Config.Outfits) do
		for k2, v2 in pairs(v) do
			if outfit == k2 then
				setOutfit(v2)
				return
			end
		end
	end
end)
