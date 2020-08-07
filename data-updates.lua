-- Copyright (c) 2020 Kirazy
-- Part of Artisanal Reskins: Function Library
--     
-- See LICENSE.md in the project directory for license information.

-- Compatibility with ShinyBobGFX/ShinyAngelGFX
if mods["ShinyBobGFX"] or mods["ShinyAngelGFX"] then
    require("shiny-bob-compatibility")
end

----------------------------------------------------------------------------------------------------
-- DEFERRED ICON ASSIGNMENTS
----------------------------------------------------------------------------------------------------
-- Item Icons
if reskins.lib.icons and reskins.lib.icons["data-updates"] then
    for name, inputs in pairs(reskins.lib.icons["data-updates"]) do
        reskins.lib.assign_icons(name, inputs)
    end
end

-- Technology Icons
if reskins.lib.technology and reskins.lib.technology["data-updates"] then
    for name, inputs in pairs(reskins.lib.technology["data-updates"]) do
        reskins.lib.assign_technology_icons(name, inputs)
    end
end