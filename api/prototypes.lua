-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---@namespace Reskins.Api

---@type Reskins.SpriteUtils.Sprites
local __sprites = require("__reskins-sprite-utils__.sprites")

--- Provides methods for working with prototypes.
---
---### Examples
---```lua
---local _prototypes = require("__reskins-library__.api.prototypes")
---```
---@class Prototypes
local _prototypes = {}

---
---Gets the name of the first item found in `data.raw.items` from among the given list of names.
---
---### Parameters
---@param ... string # An ordered list of item names to check.
---### Returns
---@return string|nil # The name of the first item found.
function _prototypes.get_name_of_first_item_that_exists(...)
	for _, name in pairs({ ... }) do
		if data.raw.item[name] then
			return name
		end
	end
end

---Resizes the given `prototype` by the given `scalar`.
---
---Recursively iterates through the given `prototype` and applies the given `scalar` to all the numeric values
---in the fields listed in `included_fields`.
---
---### Remarks
---`scalar` is recommended to be the ratio of the new tile and the original tile size.
---For example, if rescaling a 5 x 5 tile entity to a 3 x 3 tile entity, `scalar` should be `3 / 5`.
---
---### Examples
---```lua
----- Rescale the "big-electric-pole" by a factor of 2.
----- The resulting entity will have a 4 x 4 tile footprint, and sprite to match.
---prototype_tools.rescale_prototype(data.raw["electric-pole"]["big-electric-pole"], 2)
---
----- Rescale the "oil-refinery" by a factor of 3 / 5.
----- The resulting entity will have a 3 x 3 tile footprint, and sprite to match.
---prototype_tools.rescale_prototype(data.raw["assembling-machine"]["oil-refinery"], 3 / 5)
---```
---
---### Parameters
---@param entity_prototype any # The entity prototype to rescale.
---@param scalar double # The scale factor to resize the prototype by.
---@deprecated Use reskins-sprite-utils.sprites.rescale_prototype or new get_rescaled_prototype.
function _prototypes.rescale_prototype(entity_prototype, scalar)
	__sprites.rescale_prototype(entity_prototype, scalar)
end

---Resizes a copy of the `CorpsePrototype` associated with the given `prototype` by the given
---`scalar`, and assigns the rescaled copy to `prototype`. The name of the rescaled copy is
---prefixed with "rescaled-".
---
---### Remarks
---`scalar` is recommended to be the ratio of the new tile and the original tile size.
---For example, if rescaling a 5 x 5 tile entity to a 3 x 3 tile entity, `scalar` should be `3 / 5`.
---
---### Examples
---```lua
----- Rescale the remnants of the "big-electric-pole" by a factor of 2.
----- The resulting entity will have a 4 x 4 tile footprint, and sprite to match.
---prototype_tools.rescale_remnants_of_prototype(data.raw["electric-pole"]["big-electric-pole"], 2)
---```
---
---### Parameters
---@param prototype data.EntityWithHealthPrototype # The entity with the remnants to rescale.
---@param scalar double # The scale factor to resize the prototype by.
---
---### See Also
---@see Prototypes.rescale_prototype
---@deprecated Use reskins-sprite-utils.sprites.rescale_remnants_of_prototype
function _prototypes.rescale_remnants_of_prototype(prototype, scalar)
	__sprites.rescale_remnants_of_prototype(prototype, scalar)
end

return _prototypes
