Config = {}

-- Miscellaneous Configs
Config.NotifyPosition = 'top' -- The location of your notifications (top/top-right/top-left/bottom/bottom-right/bottom-left/center-right/center-left)
Config.ProgressPosition = 'bottom' -- The location of the progress circle (middle/bottom)
Config.RandomCosts = true -- If true, costs to repair/clean a vehicle can be randomized within the ranges (minimum/maximum) below
Config.RepairCost = 500 -- Only used if "Config.RandomCosts = false", otherwise can be ignored
Config.CleanCost = 200 -- Only used if "Config.RandomCosts = false", otherwise can be ignored
Config.UseAccount = 'money' -- How you want to charge the player. Either with their bank (Config.UseAccount = 'bank'), or with cash (set Config.useAccount = 'money')
Config.BankTransactionLabel = 'Service Center' -- If Config.UseAccount = 'bank', then this is the description of the transaction displayed in the banking interface (if applicable)

-- TextUI Configs
Config.TextUILabel = 'Z - Service Center' -- The text displayed on the TextUI when entering the service center locations
Config.TextUIPosition = 'left-center' -- The location of the TextUI when entering the service center locations (right-center/left-center/top-center)
Config.TextUIIcon = 'tools' -- The icon displayed on the TextUI when entering the service center locations (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)

-- Radial Menu Configs
Config.RadialIcon = 'tools' -- The icon displayed on the main radial menu option when entering a service center location
Config.RadialLabel = 'Service' -- The text displayed on the main radial menu option when entering a service center location
Config.RadialSubMenuRepairIcon = 'tools' -- The icon displayed on the radial submenu for the repair option (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)
Config.RadialSubMenuRepairLabel = 'Repair' -- The text displayed on the radial submenu for the repair option
Config.RadialSubMenuCleanIcon = 'soap' -- The icon displayed on the radial submenu for the cleaning option (You can find icons @ https://fontawesome.com/v5/search?o=r&m=free)
Config.RadialSubMenuCleanLabel = 'Clean' -- The text displayed on the radial submenu for the cleaning option

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

Notifications = {
    repairSuccess = 'Your vehicle was repaired and you were charged $',
    cleanSuccess = 'Your vehicle was cleaned and you were charged $',
    repairCancelled = 'You cancelled the repair.',
    cleanCancelled = 'You cancelled the cleaning.'
}