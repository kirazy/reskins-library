-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---@using data

---@namespace Reskins.Library

--- Provides methods for retrieving and validating startup settings.
---
---### Examples
---```lua
---local _settings = require("__reskins-library__.api.settings")
---```
---@class Settings
local _settings = {}

---
---Gets the value of the startup setting with the given `name`.
---
---### Returns
---@return boolean|string|Color|double|int|nil # The value of the startup setting, if it exists; otherwise, `nil`.
---
---### Examples
---```lua
----- Check if the user has enabled custom furnace variants.
------@type boolean
---local value = setting_tools.get_value("reskins-bobs-do-custom-furnace-variants")
---
----- Get the color of the standard furnace variant.
------@type Color
---local color = setting_tools.get_value("reskins-bobs-standard-furnace-color")
---```
---
---### Parameters
---@param name string # The name of a startup setting.
function _settings.get_value(name)
	local value = nil
	if settings.startup[name] then
		value = settings.startup[name].value
	end

	---@diagnostic disable-next-line: return-type-mismatch
	return value
end

---
---Gets the blend mode to use for applying the highlights layer of Artisanal Reskins sprite sets.
---
---@type BlendMode
_settings.blend_mode = _settings.get_value("reskins-lib-blend-mode")

return _settings
