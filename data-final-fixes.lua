-- Copyright (c) 2020 Kirazy
-- Part of Artisanal Reskins: Function Library
--     
-- See LICENSE.md in the project directory for license information.

----------------------------------------------------------------------------------------------------
-- DEFERRED ICON ASSIGNMENTS
----------------------------------------------------------------------------------------------------
-- Item Icons
if reskins.lib.icons and reskins.lib.icons["data-final-fixes"] then
    for name, inputs in pairs(reskins.lib.icons["data-final-fixes"]) do
        reskins.lib.assign_icons(name, inputs)
    end
end

-- Technology Icons
if reskins.lib.technology and reskins.lib.technology["data-final-fixes"] then
    for name, inputs in pairs(reskins.lib.technology["data-final-fixes"]) do
        reskins.lib.assign_technology_icons(name, inputs)
    end
end

----------------------------------------------------------------------------------------------------
-- COMPATIBILITY
----------------------------------------------------------------------------------------------------
-- require("prototypes.compatibility.mini-machines") -- This must be called after icons are handled
-- require("prototypes.compatibility.deadlock-crating") -- DeadlockCrating sets up machines in data-final-fixes