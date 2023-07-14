--Creating Blips
CreateThread(function()
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

-- Function that actually performs the repair or clean
local function performService(conditions, repair, vehicle, price)
	if conditions then
		if repair then
			-- Repair vehicle
			SetVehicleDoorOpen(vehicle, 4, false, false)
			if lib.progressCircle({
				duration = Config.RepairTime,
				label = Config.RepairProgressLabel,
				position = Config.ProgressPosition,
				useWhileDead = false,
				canCancel = true,
				disable = {car = true}
			}) then
				SetVehicleFixed(vehicle)
				SetVehicleDoorShut(vehicle, 4, false)
				local success = lib.callback.await('lation_servicecenter:payService', false, price)
				if success then
					lib.notify({ id = 'repairSuccess', description = Notifications.repairSuccess ..price, type = 'success', position = Config.NotifyPosition })
				else
					-- Something went wrong
				end
			else
				SetVehicleDoorShut(vehicle, 4, false)
				lib.notify({ id = 'repairCancelled', description = Notifications.repairCancelled, type = 'error', position = Config.NotifyPosition })
			end
		else
			-- Clean vehicle
			if lib.progressCircle({
				duration = Config.CleanTime,
				label = Config.CleaningProgressLabel,
				position = Config.ProgressPosition,
				useWhileDead = false,
				canCancel = true,
				disable = {car = true}
				}) then
					SetVehicleDirtLevel(vehicle, 0.0)
					local success = lib.callback.await('lation_servicecenter:payService', false, price)
					if success then
						lib.notify({ description = Notifications.cleanSuccess ..price, type = 'success', position = Config.NotifyPosition })
					else
						-- Something went wrong
					end
				else
				lib.notify({ description = Notifications.cleanCancelled, type = 'error', position = Config.NotifyPosition })
			end
		end
	end
end

-- Condition check before repairing or cleaning vehicle
local function serviceConditionCheck(repair)
	local price, mechanicsOnline = 0, 0
	if Config.RandomCosts then
		price =  repair and math.random(Config.RepairCostMinimum, Config.RepairCostMaximum) or math.random(Config.CleanCostMinimum, Config.CleanCostMaximum)
	else
		price = repair and Config.RepairCost or Config.CleanCost
	end
	local vehicle = lib.getClosestVehicle(cache.coords, 3, true)
	local checkBalance = lib.callback.await('lation_servicecenter:checkBalance', false)
	if checkBalance >= price then
		if vehicle then
			if DoesEntityExist(vehicle) then
				if IsPedInAnyVehicle(cache.ped, false) then
					vehicle = GetVehiclePedIsIn(cache.ped, false)
					if Config.DisableIfMechanicOnline then
						mechanicsOnline = lib.callback.await('lation_servicecenter:getMechanics', false)
						if mechanicsOnline >= Config.MechanicsOnline then
							lib.notify({ id = 'tooManyMechanics', description = Notifications.tooManyMechanics, type = 'error', position = Config.NotifyPosition })
						else
							if repair then
								performService(true, true, vehicle, price)
							else
								performService(true, false, vehicle, price)
							end
						end
					else
						if repair then
							performService(true, true, vehicle, price)
						else
							performService(true, false, vehicle, price)
						end
					end
				else
					lib.notify({ id = 'notInVehicle', description = Notifications.notInVehicle, type = 'error', position = Config.NotifyPosition, })
				end
			end
		end
	else
		lib.notify({ id = 'notEnoughMoney', description = Notifications.notEnoughMoney, type = 'error', position = Config.NotifyPosition })
	end
end

-- Register the radial menu options if using radial menu
if not Config.EnablePressKey then
	lib.registerRadial({
		id = 'repair_shop',
		items = {
			{
				label = Config.RadialSubMenuRepairLabel,
				icon = Config.RadialSubMenuRepairIcon,
				onSelect = function()
					serviceConditionCheck(true)
				end
			},
			{
				label = Config.RadialSubMenuCleanLabel,
				icon = Config.RadialSubMenuCleanIcon,
				onSelect = function()
					serviceConditionCheck(false)
				end
			},
		}
	})
end

-- Create shop locations
local points = {}
for k,v in pairs(Config.ServiceCenters) do
    local point = lib.points.new({ coords = v, distance = 5 })
	if not Config.EnablePressKey then
		function point:onEnter()
			if IsPedInAnyVehicle(cache.ped, false) then
				if GetPedInVehicleSeat(GetVehiclePedIsUsing(cache.ped), -1) == cache.ped then
					lib.showTextUI(Config.TextUILabel, { position = Config.TextUIPosition, icon = Config.TextUIIcon })
					lib.addRadialItem({ id = 'serviceCenters', icon = Config.RadialIcon, label = Config.RadialLabel, menu = 'repair_shop' })
				end
			end
		end
		function point:onExit()
			lib.hideTextUI()
			lib.removeRadialItem('serviceCenters')
		end
    	points[k] = point
	else
		function point:nearby()
			if IsControlJustPressed(0, Config.RepairKey) then
				serviceConditionCheck(true)
			elseif IsControlJustPressed(0, Config.CleanKey) then
				serviceConditionCheck(false)
			end
		end
		function point:onEnter()
			if IsPedInAnyVehicle(cache.ped, false) then
				if GetPedInVehicleSeat(GetVehiclePedIsUsing(cache.ped), -1) == cache.ped then
					lib.showTextUI(Config.TextUILabelP, { position = Config.TextUIPositionP, icon = Config.TextUIIconP })
				end
			end
		end
		function point:onExit()
			lib.hideTextUI()
		end
	end
end