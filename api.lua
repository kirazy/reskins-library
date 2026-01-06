---Provides access to the Artisanal Reskin's library of API functions.
---
---### Examples
---```lua
---local reskins_api = require("__reskins-framework__.api")
---```
---@class Reskins.Library
local _library = {
	---@type Reskins.Lib.Defines
	defines = require("__reskins-framework__.api.defines"),

	---@type Reskins.Lib.Icons
	icons = require("__reskins-framework__.api.icons"),

	---@type Reskins.Lib.Prototypes
	prototypes = require("__reskins-framework__.api.prototypes"),

	---@type Reskins.Lib.Settings
	settings = require("__reskins-framework__.api.settings"),

	---@type Reskins.Lib.Sprites
	sprites = require("__reskins-framework__.api.sprites"),

	---@type Reskins.Lib.Tiers
	tiers = require("__reskins-framework__.api.tiers"),

	---@type Reskins.Lib.Version
	version = require("__reskins-framework__.api.version"),
}

return _library
