-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---@namespace Reskins.Api

---Provides access to the Artisanal Reskin's library of API functions.
---
---### Examples
---```lua
---local reskins_api = require("__reskins-library__.api")
---```
---@class Library
local _library = {
	defines = require("api.defines"),
	icons = require("api.icons"),
	prototypes = require("api.prototypes"),
	settings = require("api.settings"),
	sprites = require("api.sprites"),
	tiers = require("api.tiers"),
	---@deprecated Use helpers.compare_versions
	version = require("api.version"),
}

return _library
