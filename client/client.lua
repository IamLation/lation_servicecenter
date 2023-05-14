--Creating Blips
Citizen.CreateThread(function()
    for _, info in pairs(Config.ShopBlips) do
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
function repairVehicle()
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
                    SetVehicleFixed(vehicle)
                    SetVehicleDoorShut(vehicle, 4, false)
					lib.callback.await('salt_servicecenter:payRepair')
                else
                SetVehicleDoorShut(vehicle, 4, false)
                lib.notify({ description = Notifications.repairCancelled, type = 'error', position = Config.NotifyPosition })
            end
		end
	end
end

--Clean Vehicle
function cleanVehicle()
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
                    SetVehicleDirtLevel(vehicle, 0.0)
					lib.callback.await('salt_servicecenter:payClean')
                else
                lib.notify({ description = Notifications.cleanCancelled, type = 'error', position = Config.NotifyPosition })
            end
		end
	end
end

-- Register the radial menu options
lib.registerRadial({
id = 'repair_shop',
items = {
		{
			label = Config.RadialSubMenuRepairLabel,
			icon = Config.RadialSubMenuRepairIcon,
			onSelect = function()
				repairVehicle()
			end
		},
		{
			label = Config.RadialSubMenuCleanLabel,
			icon = Config.RadialSubMenuCleanIcon,
			onSelect = function()
				cleanVehicle()
			end
		},
	}
})

-- Create shop locations
local points = {}
for k,v in pairs(Config.ServiceCenters) do
    local point = lib.points.new({ coords = v, distance = 5 })
	if not Config.EnablePressKey then
		function point:onEnter()
			lib.showTextUI(Config.TextUILabel, { position = Config.TextUIPosition, icon = Config.TextUIIcon })
			lib.addRadialItem({ id = 'serviceCenters', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop' })
		end
		function point:onExit()
			lib.hideTextUI()
			lib.removeRadialItem('serviceCenters')
		end
    	points[k] = point
	elseif Config.EnablePressKey then
		function point:nearby()
			if IsControlJustPressed(0, Config.RepairKey) then
				repairVehicle()
			elseif IsControlJustPressed(0, Config.CleanKey) then
				cleanVehicle()
			end
		end
		function point:onEnter()
			lib.showTextUI(Config.TextUILabelP, { position = Config.TextUIPositionP, icon = Config.TextUIIconP })
		end
		function point:onExit()
			lib.hideTextUI()
		end
	end
end