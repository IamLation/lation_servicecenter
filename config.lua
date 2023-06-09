Config = {}

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
    {title = 'Service Center', colour = 0, id = 566, x = 110.24,  y = 6626.63,  z = 31.77},
    {title = 'Service Center', colour = 0, id = 566, x = 1141.54, y = -779.90,  z = 57.58},
    {title = 'Service Center', colour = 0, id = 566, x = 2511.34, y = 4109.47,  z = 38.10},
    {title = 'Service Center', colour = 0, id = 566, x = -69.38,  y = -1341.15, z = 28.80},
    {title = 'Service Center', colour = 0, id = 566, x = 479.27,  y = -1888.36, z = 25.64},
    {title = 'Service Center', colour = 0, id = 566, x = 1174.78, y = 2640.26,  z = 37.31},
}

-- Miscellaneous Configs
Config.DisableIfMechanicOnline = true -- If true, you cannot use the service centers while mechanics are online. If false, you can use all the time.
Config.MechanicsOnline = 1 -- How many mechanics should be online to disable the service centers? (Only used if Config.DisableIfMechanicOnline = true)
Config.MechanicJobs = { 'mechanic', 'greasemonkey' } -- All jobs that are mechanic jobs (only used if Config.DisableIfMechanicOnline = true)
Config.EnablePressKey = false -- Have players press a key to start the repair or clean (this will disable the radial menu completely)
Config.RepairKey = 38 -- The key to press to start repairing the vehicle if Config.EnablePressKey = true (view all control IDs here: https://docs.fivem.net/docs/game-references/controls/#controls)
Config.CleanKey = 47 -- The key to press to start cleaning the vehicle if Config.EnablePressKey = true (view all control IDs here: https://docs.fivem.net/docs/game-references/controls/#controls)
Config.NotifyPosition = 'top' -- The location of your notifications (top/top-right/top-left/bottom/bottom-right/bottom-left/center-right/center-left)
Config.ProgressPosition = 'middle' -- The location of the progress circle (middle/bottom)
Config.RandomCosts = true -- If true, costs to repair/clean a vehicle can be randomized within the ranges (minimum/maximum) below
Config.RepairCost = 500 -- Only used if "Config.RandomCosts = false", otherwise can be ignored
Config.CleanCost = 200 -- Only used if "Config.RandomCosts = false", otherwise can be ignored
Config.UseAccount = 'money' -- How you want to charge the player. Either with their bank (Config.UseAccount = 'bank'), or with cash (set Config.useAccount = 'money')
Config.BankTransactionLabel = 'Service Center' -- If Config.UseAccount = 'bank', then this is the description of the transaction displayed in the banking interface (if applicable)

-- Repair Configs
Config.RepairTime = 10000 -- How long in milliseconds the repair process should take
Config.RepairCostMinimum = 425 -- If "Config.RandomCosts = true", then how much a repair should cost at minimum
Config.RepairCostMaximum = 1050 -- If "Config.RandomCosts = true", then how much a repair should cost at most
Config.RepairProgressLabel = 'Repairing..'

-- Cleaning Configs
Config.CleanTime = 10000 -- How long in milliseconds the cleaning process should take
Config.CleanCostMinimum = 75 -- If "Config.RandomCosts = true", then how much a cleaning should cost at minimum
Config.CleanCostMaximum = 300 -- If "Config.RandomCosts = true", then how much a cleaning should cost at most
Config.CleaningProgressLabel = 'Cleaning..'

-- TextUI Configs for Radial Menu (only used if Config.EnablePressKey = false)
Config.TextUILabel = 'Z - Service Center' -- The text displayed on the TextUI when entering the service center locations
Config.TextUIPosition = 'left-center' -- The location of the TextUI when entering the service center locations (right-center/left-center/top-center)
Config.TextUIIcon = 'tools' -- The icon displayed on the TextUI when entering the service center locations (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)

-- TextUI Configs for PressKey (only used if Config.EnablePressKey = true)
Config.TextUILabelP = 'E - Repair  \n G - Clean' -- The text displayed on the TextUI when entering the service center locations
Config.TextUIPositionP = 'left-center' -- The location of the TextUI when entering the service center locations (right-center/left-center/top-center)
Config.TextUIIconP = 'tools' -- The icon displayed on the TextUI when entering the service center locations (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)

-- Radial Menu Configs (only used if Config.EnablePressKey = false)
Config.RadialIcon = 'tools' -- The icon displayed on the main radial menu option when entering a service center location
Config.RadialLabel = 'Service' -- The text displayed on the main radial menu option when entering a service center location
Config.RadialSubMenuRepairIcon = 'tools' -- The icon displayed on the radial submenu for the repair option (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)
Config.RadialSubMenuRepairLabel = 'Repair' -- The text displayed on the radial submenu for the repair option
Config.RadialSubMenuCleanIcon = 'soap' -- The icon displayed on the radial submenu for the cleaning option (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)
Config.RadialSubMenuCleanLabel = 'Clean' -- The text displayed on the radial submenu for the cleaning option

Notifications = {
    repairSuccess = 'Your vehicle was repaired and you were charged $',
    cleanSuccess = 'Your vehicle was cleaned and you were charged $',
    repairCancelled = 'You cancelled the repair.',
    cleanCancelled = 'You cancelled the cleaning.',
    tooManyMechanics = 'There are Mechanics available, you should visit them instead.'
}