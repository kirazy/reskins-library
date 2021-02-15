-- Copyright (c) 2021 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE.md in the project directory for license information.

-- Concatenate the mod description string with the default description string for boolean settings
local function concatenate_bool(setting)
    if setting.default then
        string_default = "true"
    else
        string_default = "false"
    end

    -- Check for an already set localised_description
    if setting.localised_description then
        return {"", setting.localised_description, {"reskins-defaults."..string_default}}
    else
        return {"", {"mod-setting-description."..setting.name}, {"reskins-defaults."..string_default}}
    end
end

local valid_prefix = {
    "reskins%-lib",
    "reskins%-bobs",
    "reskins%-angels",
    "reskins%-compatibility",
}

-- Iterate through the boolean settings table and grab all the reskins settings and set the description
for _, setting in pairs(data.raw["bool-setting"]) do
    for _, prefix in pairs(valid_prefix) do
        if string.find(setting.name, prefix) then
            setting.localised_description = concatenate_bool(setting)
            goto continue
        end
    end

    ::continue::
end