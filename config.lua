Config = {}

-- Do you want to be notified via server console if an update is available?
-- True if yes, false if no
Config.VersionCheck = true

-- Shop Locations (you can add as many as you wish here)
Config.ServiceCenters = {
	vec3(110.24, 6626.63, 31.77),
	vec3(1141.54, -779.90, 57.58),
	vec3(2511.34, 4109.47, 38.10),
	vec3(-69.38, -1341.15, 28.80),
	vec3(479.27, -1888.36, 25.64),
	vec3(1174.78, 2640.26, 37.31),
}

--Blip Locations (if you want a blip to display at the above locations, add it here)
Config.ShopBlips = {
    {title = 'Service Center', color = 0, sprite = 566, scale = 0.8, coords = vec3(110.24, 6626.63, 31.77)},
    {title = 'Service Center', color = 0, sprite = 566, scale = 0.8, coords = vec3(1141.54, -779.90, 57.58)},
    {title = 'Service Center', color = 0, sprite = 566, scale = 0.8, coords = vec3(2511.34, 4109.47, 38.10)},
    {title = 'Service Center', color = 0, sprite = 566, scale = 0.8, coords = vec3(-69.38, -1341.15, 28.80)},
    {title = 'Service Center', color = 0, sprite = 566, scale = 0.8, coords = vec3(479.27, -1888.36, 25.64)},
    {title = 'Service Center', color = 0, sprite = 566, scale = 0.8, coords = vec3(1174.78, 2640.26, 37.31)},
}

-- Miscellaneous configurations
Config.DisableIfMechanicOnline = true -- If true, you cannot use the service centers while mechanics are online. If false, you can use all the time.
Config.MechanicsOnline = 3 -- How many mechanics should be online to disable the service centers? (Only used if Config.DisableIfMechanicOnline = true)
Config.MechanicJobs = { 'mechanic', 'greasemonkey' } -- All jobs that are mechanic jobs (only used if Config.DisableIfMechanicOnline = true)
Config.UseTextUI = false -- Have players press a key to start a repair or clean (this will disable the radial menu completely)
Config.RepairEngineKey = 38 -- The key to press to start repairing the engine if EnablePressKey is true (view all control IDs here: https://docs.fivem.net/docs/game-references/controls/#controls)
Config.RepairBodyKey = 44 -- The key to press to start repairing the body if EnablePressKey is true
Config.CleanKey = 47 -- The key to press to start cleaning the vehicle if EnablePressKey is true
Config.RandomCosts = true -- If true, costs to repair/clean a vehicle can be randomized within the ranges (minimum/maximum) below
Config.RepairEngineCost = 500 -- Only used if Config.RandomCosts is false, otherwise can be ignored
Config.RepairBodyCost = 400 -- Only used if Config.RandomCosts is false, otherwise can be ignored
Config.CleanCost = 200 -- Only used if Config.RandomCosts is false, otherwise can be ignored
Config.UseAccount = 'bank' -- How you want to charge the player for a service - either with 'bank' or 'money'/'cash'
Config.ProgressType = 'cirlce' -- Select your ox_lib progress UI preference - options are 'circle' and 'bar'

-- Repair engine configurations
Config.RepairEngineTime = 10000 -- How long in milliseconds the repair process should take
Config.RepairEngineCostMinimum = 425 -- If Config.RandomCosts is true, then how much a repair should cost at minimum?
Config.RepairEngineCostMaximum = 1050 -- If Config.RandomCosts is true, then how much a repair should cost at most?
Config.RepairEngineLabel = 'Repairing engine..'

-- Repair body configurations
Config.RepairBodyTime = 10000 -- How long in milliseconds repairing the body should take
Config.RepairBodyCostMin = 300 -- If Config.RandomCosts is true, then how much should a repair cost at minimum?
Config.RepairBodyCostMax = 675 -- If Config.RandomCosts is true, then how much should a repair cost at maximum?
Config.RepairBodyLabel = 'Repairing body..'

-- Clean vehicle configurations
Config.CleanTime = 10000 -- How long in milliseconds the cleaning process should take
Config.CleanCostMinimum = 75 -- If Config.RandomCosts is true, then how much a cleaning should cost at minimum?
Config.CleanCostMaximum = 300 -- If Config.RandomCosts is true, then how much a cleaning should cost at most?
Config.CleaningLabel = 'Cleaning..'

-- TextUI configurations for Radial Menu (only used if Config.UseTextUI = false)
Config.TextUILabel = 'Z - Service Center' -- The text displayed on the TextUI when entering the service center locations
Config.TextUIPosition = 'left-center' -- The location of the TextUI when entering the service center locations (right-center/left-center/top-center)
Config.TextUIIcon = 'tools' -- The icon displayed on the TextUI when entering the service center locations (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)

-- TextUI confirmations (only used if Config.UseTextUI = true)
Config.TextUILabelP = '**Service Center**  \n **E** - Repair Engine  \n **Q** - Repair Body  \n **G** - Clean Vehicle' -- The text displayed on the TextUI when entering the service center locations
Config.TextUIPositionP = 'left-center' -- The location of the TextUI when entering the service center locations (right-center/left-center/top-center)
Config.TextUIIconP = 'tools' -- The icon displayed on the TextUI when entering the service center locations (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)

-- Radial menu configurations (only used if Config.UseTextUI = false)
Config.RadialIcon = 'tools' -- The icon displayed on the main radial menu option when entering a service center location
Config.RadialLabel = 'Service' -- The text displayed on the main radial menu option when entering a service center location
Config.RadialSubMenuRepairEngineIcon = 'tools' -- The icon displayed on the radial submenu for the repair option (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)
Config.RadialSubMenuRepairEngineLabel = 'Repair Engine' -- The text displayed on the radial submenu for the repair option
Config.RadialSubMenuRepairBodyIcon = 'car'
Config.RadialSubMenuRepairBodyLabel = 'Repair Body'
Config.RadialSubMenuCleanIcon = 'soap'
Config.RadialSubMenuCleanLabel = 'Clean'

-- ox_lib progress bars/circles configurations
Config.Progress = {
    clean = {
        duration = Config.CleanTime,
		label = Config.CleaningLabel,
		position = 'bottom',
		useWhileDead = false,
		canCancel = true,
		disable = { car = true, move = true, combat = true }
    },
    repairEngine = {
        duration = Config.RepairEngineTime,
		label = Config.RepairEngineLabel,
		position = 'bottom',
		useWhileDead = false,
		canCancel = true,
		disable = { car = true, move = true, combat = true }
    },
    repairBody = {
        duration = Config.RepairBodyTime,
		label = Config.RepairBodyLabel,
		position = 'bottom',
		useWhileDead = false,
		canCancel = true,
		disable = { car = true, move = true, combat = true }
    }
}