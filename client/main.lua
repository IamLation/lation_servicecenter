-- Initialize variables
local progressType = Config.ProgressType == 'bar' and 'progressBar' or 'progressCircle'

-- Function used to create blips
local CreateBlips = function()
	for _, blip in pairs(Config.ShopBlips) do
		local shopBlip = AddBlipForCoord(blip.coords.x, blip.coords.y, blip.coords.z)
		SetBlipSprite(shopBlip, blip.sprite)
		SetBlipColour(shopBlip, blip.color)
		SetBlipScale(shopBlip, blip.scale)
		SetBlipAsShortRange(shopBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blip.title)
		EndTextCommandSetBlipName(shopBlip)
	end
end

-- Event handler to add blips to the map onPlayerLoaded
AddEventHandler('lation_servicecenter:onPlayerLoaded', function()
    CreateBlips()
end)

-- Function used to make numbers prettier (Credits to ESX for the function)
--- @param value number
local GroupDigits = function(value)
	local left, num, right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1,'):reverse()) .. right
end

-- Function used to handle repairing of the engine
--- @param vehicle number
--- @param price number
local RepairEngine = function(vehicle, price)
	SetVehicleDoorOpen(vehicle, 4, false, false)
	if lib[progressType](Config.Progress.repairEngine) then
		SetVehicleEngineHealth(vehicle, 1000.0)
		SetVehicleDoorShut(vehicle, 4, false)
		TriggerServerEvent('lation_servicecenter:payService', cache.serverId, price)
		ShowNotification('success', Strings.Notify.success ..GroupDigits(price), 'success')
	else
		SetVehicleDoorShut(vehicle, 4, false)
		ShowNotification('cancelled', Strings.Notify.cancel, 'info')
	end
end

-- Function used to handle repairing of the body
--- @param vehicle number
--- @param price number
local RepairBody = function(vehicle, price)
	if lib[progressType](Config.Progress.repairBody) then
		local windows = {0, 1, 2, 3, 4, 5, 6, 7}
		SetVehicleDeformationFixed(vehicle)
		RemoveDecalsFromVehicle(vehicle)
		for _, window in pairs(windows) do
			FixVehicleWindow(vehicle, window)
		end
		SetVehicleBodyHealth(vehicle, 1000.0)
		TriggerServerEvent('lation_servicecenter:payService', cache.serverId, price)
		ShowNotification('success', Strings.Notify.success ..GroupDigits(price), 'success')
	else
		ShowNotification('cancelled', Strings.Notify.cancel, 'info')
	end
end

-- Function used to handle cleaning the vehicle
--- @param vehicle number
--- @param price number
local CleanVehicle = function(vehicle, price)
	if lib[progressType](Config.Progress.clean) then
		SetVehicleDirtLevel(vehicle, 0.0)
		TriggerServerEvent('lation_servicecenter:payService', cache.serverId, price)
		ShowNotification('success', Strings.Notify.success ..GroupDigits(price), 'success')
	else
		ShowNotification('cancelled', Strings.Notify.cancel, 'info')
	end
end

-- Function used to confirm price before continuing
--- @param price number
local ConfirmDialog = function(price)
	local alert = lib.alertDialog({
		header = Strings.Dialog.title,
		content = Strings.Dialog.confirm1 ..GroupDigits(price).. Strings.Dialog.confirm2,
		centered = true,
		cancel = true
	})
	if not alert then return end
	if alert == 'confirm' then
		return true
	end
	return false
end

-- Function used to verify specific conditions before proceeding
--- @param type string
local ConditionChecks = function(type)
	local vehicle = lib.getClosestVehicle(cache.coords, 2.0, true)
	local balance = lib.callback.await('lation_servicecenter:checkBalance', false)
	if not vehicle then return end
	if not DoesEntityExist(vehicle) then return end
	if not IsPedInAnyVehicle(cache.ped, false) then return end
	vehicle = GetVehiclePedIsIn(cache.ped, false)
	if Config.DisableIfMechanicOnline then
		local mechanics = lib.callback.await('lation_servicecenter:getMechanics', false)
		if mechanics >= Config.MechanicsOnline then
			ShowNotification('tooMany', Strings.Notify.mechanics, 'error')
			return
		end
	end
	if type == 'clean' then -- Clean vehicle
		local price = Config.RandomCosts and math.random(Config.CleanCostMinimum, Config.CleanCostMaximum) or Config.CleanCost
		if balance < price then
			ShowNotification('notEnough', Strings.Notify.noMoney, 'error')
			return
		end
		local confirm = ConfirmDialog(price)
		if not confirm then return end
		CleanVehicle(vehicle, price)
	elseif type == 'repairE' then -- Repair engine
		local price = Config.RandomCosts and math.random(Config.RepairEngineCostMinimum, Config.RepairEngineCostMaximum) or Config.RepairEngineCost
		if balance < price then
			ShowNotification('notEnough', Strings.Notify.noMoney, 'error')
			return
		end
		local confirm = ConfirmDialog(price)
		if not confirm then return end
		RepairEngine(vehicle, price)
	else -- Repair body
		local price = Config.RandomCosts and math.random(Config.RepairBodyCostMin, Config.RepairBodyCostMax) or Config.RepairBodyCost
		if balance < price then
			ShowNotification('notEnough', Strings.Notify.noMoney, 'error')
			return
		end
		local confirm = ConfirmDialog(price)
		if not confirm then return end
		RepairBody(vehicle, price)
	end
end

-- Register the radial menu options if using radial menu
if not Config.UseTextUI then
	lib.registerRadial({
		id = 'repair_shop',
		items = {
			{
				label = Config.RadialSubMenuRepairEngineLabel,
				icon = Config.RadialSubMenuRepairEngineIcon,
				onSelect = function()
					ConditionChecks('repairE')
				end
			},
			{
				label = Config.RadialSubMenuRepairBodyLabel,
				icon = Config.RadialSubMenuRepairBodyIcon,
				onSelect = function()
					ConditionChecks('repairB')
				end
			},
			{
				label = Config.RadialSubMenuCleanLabel,
				icon = Config.RadialSubMenuCleanIcon,
				onSelect = function()
					ConditionChecks('clean')
				end
			},
		}
	})
end

-- Create shop locations
local points = {}
for k, v in pairs(Config.ServiceCenters) do
    local point = lib.points.new({ coords = v, distance = 5 })
	if not Config.UseTextUI then
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
			if IsControlJustPressed(0, Config.RepairEngineKey) then
				ConditionChecks('repairE')
			elseif IsControlJustPressed(0, Config.CleanKey) then
				ConditionChecks('clean')
			elseif IsControlJustPressed(0, Config.RepairBodyKey) then
				ConditionChecks('repairB')
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