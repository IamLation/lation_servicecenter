ESX = exports["es_extended"]:getSharedObject()

--Blip Locations
local shops = {
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = 110.24,  y = 6626.63,  z = 31.77}, -- Paleto Bay @ zip 1012
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = 1141.54, y = -779.90,  z = 57.58}, -- Mirror Park
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = -35.92,  y = -1052.32, z = 28.38}, -- Bennys near PDM (A Gabz MLO)
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = 2511.34, y = 4109.47,  z = 38.10}, -- Sandy Shores @ zip 2048
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = -69.38,  y = -1341.15, z = 28.80}, -- South Los Santos @ zip 9044
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = 479.27,  y = -1888.36, z = 25.64}, -- South Los Santos @ zip 9181
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = 1174.78, y = 2640.26,  z = 37.31}, -- Grand Senora @ zip 4025
    {title = Config.BlipName, colour = Config.BlipColor, id = Config.BlipIcon, x = 831.24,  y = -812.67,  z = 25.89}, -- Ottos @ zip 8190 (A Gabz MLO)
}

--Creating Blips
Citizen.CreateThread(function()
    for _, info in pairs(shops) do
    info.shops = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.shops, info.id)
        SetBlipDisplay(info.shops, 4)
        SetBlipScale(info.shops, 0.8)
        SetBlipColour(info.shops, info.colour)
        SetBlipAsShortRange(info.shops, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.shops)
    end
end)

-- Repair Vehicle
RegisterNetEvent('salt_servicecenter:repairVehicle')
AddEventHandler('salt_servicecenter:repairVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end
		if DoesEntityExist(vehicle) then
            SetVehicleDoorOpen(vehicle, 4, false, false)
            if lib.progressCircle({
                duration = Config.RepairTime,
                label = Config.RepairProgressLabel,
                position = Config.ProgressPosition,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                }
                }) then
                    CreateThread(function()
                        Wait(100)
                        SetVehicleFixed(vehicle)
                        SetVehicleDoorShut(vehicle, 4, false)
                    end)
                    TriggerServerEvent('salt_servicecenter:payRepair')
                else
                SetVehicleDoorShut(vehicle, 4, false)
                lib.notify({ description = Notifications.repairCancelled, type = 'error', position = Config.NotifyPosition })
            end
		end
	end
end)

--Clean Vehicle
RegisterNetEvent('salt_servicecenter:cleanVehicle')
AddEventHandler('salt_servicecenter:cleanVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end
		if DoesEntityExist(vehicle) then
            if lib.progressCircle({
                duration = Config.CleanTime,
                label = Config.CleaningProgressLabel,
                position = Config.ProgressPosition,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                }
                }) then
                    CreateThread(function()
                        Wait(100)
                        SetVehicleDirtLevel(vehicle, 0.0)
                    end)
                    TriggerServerEvent('salt_servicecenter:payClean')
                else
                lib.notify({ description = Notifications.cleanCancelled, type = 'error', position = Config.NotifyPosition })
            end
		end
	end
end)

-- Radial Menu
local pointServiceCenter1 = lib.points.new(vec3(110.24, 6626.63, 31.77), 4) -- Repair Shop @ zip 1012
local pointServiceCenter2 = lib.points.new(vec3(1141.54, -779.90, 57.58), 4) -- Repair Shop @ zip 7326
local pointServiceCenter3 = lib.points.new(vec3(-35.92, -1052.32, 28.38), 4) -- Benny's next to PDM
local pointServiceCenter4 = lib.points.new(vec3(2511.34, 4109.47, 38.10), 4) -- Repair Shop @ zip 2048
local pointServiceCenter5 = lib.points.new(vec3(-69.38, -1341.15, 28.80), 4) -- Repair Shop @ zip 9044
local pointServiceCenter6 = lib.points.new(vec3(479.27, -1888.36, 25.64), 4) -- Repair Shop @ zip 9181
local pointServiceCenter7 = lib.points.new(vec3(1174.78, 2640.26, 37.31), 4) -- Repair Shop @ zip 4025
local pointServiceCenter8 = lib.points.new(vec3(831.24, -812.67, 25.89), 8) -- Ottos @ zip 8190

lib.registerRadial({
id = 'repair_shop',
items = {
		{
			label = Config.RadialSubMenuRepairLabel,
			icon = Config.RadialSubMenuRepairIcon,
			onSelect = function()
				TriggerEvent("salt_servicecenter:repairVehicle")
			end
		},
		{
			label = Config.RadialSubMenuCleanLabel,
			icon = Config.RadialSubMenuCleanIcon,
			onSelect = function()
				TriggerEvent("salt_servicecenter:cleanVehicle")
			end
		},
	}
})

function pointServiceCenter1:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({id = 'ServiceCenter1', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter1:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter1')
end

function pointServiceCenter2:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({id = 'ServiceCenter2', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter2:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter2')
end

function pointServiceCenter3:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({id = 'ServiceCenter3', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter3:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter3')
end

function pointServiceCenter4:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({ id = 'ServiceCenter4', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter4:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter4')
end

function pointServiceCenter5:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({id = 'ServiceCenter5', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter5:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter5')
end

function pointServiceCenter6:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({id = 'ServiceCenter6', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter6:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter6')
end

function pointServiceCenter7:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({id = 'ServiceCenter7', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter7:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter7')
end

function pointServiceCenter8:onEnter()
	lib.showTextUI(Config.TextUILabel, {position = Config.TextUIPosition, icon = Config.TextUIIcon})
	lib.addRadialItem({id = 'ServiceCenter8', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop'})
end

function pointServiceCenter8:onExit()
	lib.hideTextUI()
	lib.removeRadialItem('ServiceCenter8')
end