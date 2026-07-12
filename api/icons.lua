-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---@namespace Reskins.Api

---@type Reskins.SpriteUtils.Icons
local __icons = require("__reskins-sprite-utils__.icons")

--- Provides methods for manipulating icons.
---
---### Examples
---```lua
---local _icons = require("__reskins-library__.api.icons")
---```
---@class Icons
local _icons = {
	---@type Icons.Pipes
	pipes = require("__reskins-library__.api.icons.pipes"),
}

---Basic Icon Utilities

---
---Gets an empty icon.
---
---### Returns
---```lua
---local icon_data = {
---    icon = "__core__/graphics/empty.png",
---    icon_size = 1,
---    scale = 32,
---}
---```
---
---### Examples
---```lua
---local icon_data = _icons.empty_icon()
---```
---@return data.IconData
---@deprecated Use reskins-sprite-utils.icons.empty_icon()
function _icons.empty_icon()
	return __icons.empty_icon()
end

---
---Gets an empty technology icon.
---
---### Returns
---```lua
---local icon_data = {
---    icon = "__core__/graphics/empty.png",
---    icon_size = 1,
---    scale = 256,
---}
---```
---
---### Examples
---```lua
---local icon_data = _icons.empty_technology_icon()
---```
---@return data.IconData
---@deprecated Use reskins-sprite-utils.icons.empty_icon("technology")
function _icons.empty_technology_icon()
	return __icons.empty_icon("technology")
end

---
---Checks if the given `icon_datum` is using images from Artisanal Reskins.
---
---### Returns
---@return boolean # `true` if the icon is using images from Artisanal Reskins.
---
---### Parameters
---@param icon_datum data.IconData # An `IconData` object.
local function is_icon_using_reskins_images(icon_datum)
	return icon_datum and icon_datum.icon:find("__reskins%-") ~= nil
end

---
---Checks if the given `icon_data` is using images from Artisanal Reskins.
---
---### Returns
---@return boolean # `true` if any of the icons in `icon_data` are using images from Artisanal Reskins.
---
---### Parameters
---@param icon_data data.IconData[] # An icon represented by an array of `IconData` objects.
function _icons.is_icons_using_reskins_images(icon_data)
	if icon_data then
		for i = #icon_data, 1, -1 do
			if is_icon_using_reskins_images(icon_data[i]) then
				return true
			end
		end
	end

	return false
end

---
---Scales the given `icon_data` by the given `scalar`.
---
---### Returns
---@return data.IconData[] # A copy of `icon_data` rescaled by the given `scalar`.
---
---### Examples
---```lua
------@type data.IconData[]
---local icon_data = {
---    {
---        icon = "__base__/graphics/icons/iron-plate.png",
---        icon_size = 64,
---        scale = 0.5,
---    },
---    {
---        icon = "__base__/graphics/icons/copper-wire.png",
---        icon_size = 64,
---        scale = 0.25,
---        shift = { -16, 16 }
---    },
---}
---
----- Increase the size of the icon by a factor of 2.
---icon_data = _icons.scale_icon(icon_data, 2)
---```
---
---### Parameters
---@param icon_data data.IconData[]
---@param scalar double # The scalar to rescale the icon by.
---@param is_technology_icon? boolean # When `true`, indicates that `icon_data` represents a technology icon.
---@deprecated Use reskins-sprite-utils.icons.scale_icon
function _icons.scale_icon(icon_data, scalar, is_technology_icon)
	return __icons.scale_icon(icon_data, scalar, is_technology_icon and "technology" or "default")
end

---
---Clears all icon fields from the given `prototype` object.
---
---Warning! This leaves the prototype in an invalid state!
---Be sure to set a new icon after calling this function.
---
---### Examples
---```
---_icons.clear_icon_from_prototype_by_reference(data.raw.item["iron-plate"])
---```
---
---### Parameters
---@param prototype data.EntityPrototype|data.ItemPrototype|data.FluidPrototype|data.RecipePrototype|data.TechnologyPrototype # The prototype object.
---@deprecated Use reskins-sprite-utils.clear_icon_from_prototype(prototype)
function _icons.clear_icon_from_prototype_by_reference(prototype)
	__icons.clear_icon_from_prototype(prototype)
end

---
---Clears all icon fields from the prototype object with the given `name` and `type_name`.
---
---Warning! This leaves the prototype in an invalid state!
---Be sure to set a new icon after calling this function.
---
---### Examples
---```
---_icons.clear_icon_from_prototype_by_name("iron-plate", "item")
---```
---
---### Parameters
---@param name string # The name of the prototype.
---@param type_name string # The type name of the prototype.
---@deprecated Use reskins-sprite-utils.clear_icon_from_named_prototype(name, type_name)
function _icons.clear_icon_from_prototype_by_name(name, type_name)
	__icons.clear_icon_from_named_prototype(name, type_name)
end

---
---Adds default values to missing fields from the given `icon_datum`.<br>
---`icon_data` is not modified.
---
---### Returns
---@return data.IconData # A copy of `icon_datum` with missing fields set to default values.
---
---### Examples
---```lua
------@type data.IconData
---local icon_datum = {
---    icon = "__base__/graphics/icons/iron-plate.png",
---    icon_size = 64,
---    scale = 0.5,
---}
---
---icon_datum = _icons.add_missing_icon_defaults(icon_datum)
---```
---
---### Parameters
---@param icon_datum data.IconData # An `IconData` object.
---@param is_technology_icon? boolean # When `true`, indicates that `icon_datum` represents a technology icon.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_dataum` is `nil`<br/>
---*@throws* `string` — Thrown when `icon_dataum.icon` is not a mod-prefixed absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when `icon_dataum.icon_size` is not a positive integer.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.add_missing_icon_defaults(icon_datum, ...)
function _icons.add_missing_icon_defaults(icon_datum, is_technology_icon)
	return __icons.add_missing_icon_defaults(icon_datum, is_technology_icon and "technology" or "default")
end

---
---Adds default values to missing fields from each element of the given `icon_data` array.<br>
---`icon_data` is not modified.
---
---### Returns
---@return data.IconData[] # A copy of `icon_data` with missing fields on each element set to default values.
---
---### Examples
---```
------@type data.IconData[]
---local icon_data = {
---    {
---        icon = "__base__/graphics/icons/iron-plate.png",
---        icon_size = 64,
---        scale = 0.5,
---    },
---    {
---        icon = "__base__/graphics/icons/copper-wire.png",
---        icon_size = 64,
---        scale = 0.25,
---        shift = { -16, 16 }
---    },
---}
---
---icon_data = _icons.add_missing_icons_defaults(icon_data)
---```
---
---### Parameters
---@param icon_data data.IconData[] # An icon represented by an array of `IconData` objects.
---@param is_technology_icon? boolean # When `true`, indicates that `icon_data` represents a technology icon.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_data` is `nil`.<br/>
---*@throws* `string` — Thrown when `icon_data[n].icon` is not an absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when `icon_data[n].icon_size` is not a positive integer.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.add_missing_icons_defaults(icon_data, ...)
function _icons.add_missing_icons_defaults(icon_data, is_technology_icon)
	return __icons.add_missing_icons_defaults(icon_data, is_technology_icon and "technology" or "default")
end

---
---Creates an entity, item or recipe `IconData` object with the specified parameters.
---
---### Returns
---@return data.IconData # An `IconData` object representing the created icon.
---
---### Examples
---```
---local icon_data = _icons.create_icon("__base__/graphics/icons/iron-plate.png", 64, 4, 0.5)
---```
---
---### Parameters
---@param icon data.FileName # The file name of the icon to use.
---@param icon_size data.SpriteSizeType # The size of the icon.
---@param scale? double # The scale of the icon. Default `32 / icon_size`.
---@param shift? data.Vector # The shift of the icon. Default `nil`.
---@param tint? data.Color # The tint of the icon. Default `nil`.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon` is not a mod-prefixed absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when `icon_size` is not a positive integer.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.create_icon(...)
function _icons.create_icon(icon, icon_size, scale, shift, tint)
	return __icons.create_icon(icon, icon_size, scale, shift, tint)
end

---
---Creates a technology `IconData` object with the specified parameters.
---
---### Returns
---@return data.IconData # An `IconData` object representing the created technology icon.
---
---### Examples
---```
---local icon_data = _icons.create_technology_icon("__base__/graphics/technology/logistics-1.png", 256, 4)
---```
---
---### Parameters
---@param icon data.FileName # The file name of the icon to use.
---@param icon_size data.SpriteSizeType # The size of the icon.
---@param scale? double # The scale of the icon. Default `256 / icon_size`.
---@param shift? data.Vector # The shift of the icon. Default `nil`.
---@param tint? data.Color # The tint of the icon. Default `nil`.
---@nodiscard
---
---### Exceptions
---*@throws* `string` — Thrown when `icon` is not a mod-prefixed absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when `icon_size` is not a positive integer.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.create_technology_icon(...)
function _icons.create_technology_icon(icon, icon_size, scale, shift, tint)
	return __icons.create_technology_icon(icon, icon_size, scale, shift, tint)
end

---
---Gets an array of `IconData` objects directly from the given `prototype`.
---
---### Remarks
---- If `prototype` is a `RecipePrototype` object, the `icon` or `icons` field must be defined,
---  otherwise an exception is thrown.
---- Missing icon fields are set to default values as appropriate.
---- `prototype` is not modified.
---
---### Returns
---@return data.IconData[]|nil # A copy of the icon retrieved from the prototype, or `nil` if the prototype does not exist.
---
---### Examples
---```
---local icon_data = _icons.get_icon_from_prototype_by_reference(data.raw.item["iron-plate"])
---```
---
---### Parameters
---@param prototype data.EntityPrototype|data.ItemPrototype|data.FluidPrototype|data.RecipePrototype|data.TechnologyPrototype # The prototype to get the icon from.
---
---### Exceptions
---*@throws* `string` — Thrown when `prototype` has no defined field `icon` or `icons`.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.get_icon_from_prototype(prototype)
function _icons.get_icon_from_prototype_by_reference(prototype)
	return __icons.get_icon_from_prototype(prototype)
end

---
---Gets a fully defined `IconData` array from the prototype with the given `name` and `type_name`.<br>
---If `type_name` is `"recipe"`, the `icon` or `icons` field on the `RecipePrototype` object must be defined.
---
---Missing icon fields are set to default values as appropriate.
---The prototype is not modified.
---
---### Returns
---@return data.IconData[]|nil # A copy of the icon retrieved from the prototype, or `nil` if the prototype does not exist.
---
---### Examples
---```
---local icon_data = _icons.get_icon_from_prototype_by_name("iron-plate", "item")
---```
---
---### Parameters
---@param name string # The name of the prototype.
---@param type_name string # The type name of the prototype.
---
---### Exceptions
---*@throws* `string` — Thrown when `name` is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when `type_name` is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when the prototype has no defined field `icon` or `icons`.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.get_icon_from_named_prototype
function _icons.get_icon_from_prototype_by_name(name, type_name)
	return __icons.get_icon_from_named_prototype(name, type_name)
end

local related_prototypes = {
	["item"] = true,
	["item-with-entity-data"] = true,
	["explosion"] = true,
	["corpse"] = true,
}

---
---Sets the given `icon_data` on the prototype with the given `name` and `type_name`, and the
---related prototypes that follow standard naming conventions, such as the item, explosion and
---remnant prototypes.
---
---Optionally sets the `pictures` field as appropriate with the given `pictures`.
---
---### Examples
---```
------@type data.IconData
---local icon_datum = {
---    icon = "__base__/graphics/icons/assembling-machine-1.png",
---    icon_size = 64,
---    scale = 0.5,
---}
---
-----Get a sprite for display in-world without tier labels.
---local unlabeled_pictures = sprite_tools.create_sprite_from_icon(icon_datum, 1.0)
---
-----Add tier labels to the assembling machine icon.
---local labeled_icon = tier_tools.add_tier_labels_to_icon(1, icon_datum)
---
-----Update the tier-1 assembly machine prototype and its related prototypes.
---_icons.assign_icons_to_prototype_and_related_prototypes("assembling-machine-1", "assembling-machine", labeled_icon, unlabeled_pictures)
---```
---
---### Parameters
---@param name string # The name of the prototype.
---@param type_name? string # The type name of the prototype.
---@param icon_data data.IconData[] # An icon represented by an array of `IconData` objects.
---@param pictures? data.SpriteVariations # A `SpriteVariations` object. Typical use is when `icon_data` has tier labels and the in-world sprite should not.
---
---### Exceptions
---*@throws* `string` — Thrown when `name` is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when `icon_data` is `nil`.<br/>
---*@throws* `string` — Thrown when `icon_data[n].icon` is not an absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when `icon_data[n].icon_size` is not a positive integer.<br/>
---@deprecated Use reskins-sprite-utils.icons.assign_icons_to_prototype_and_related_prototypes
function _icons.assign_icons_to_prototype_and_related_prototypes(name, type_name, icon_data, pictures)
	__icons.assign_icons_to_prototype_and_related_prototypes(name, type_name, icon_data, pictures)
end

---Icon Assignment Utilities

---
---Performs validation and sanitization of the given `deferrable_icon`, and adds it to the
---given `deferred_icons` dictionary of `DeferrableIconData` for later assignment in the
---given `stage`.
---
---Pass the same `deferrable_icon` table to the method `_icons.assign_icons_deferred_to_stage` with
---the same `stage` during appropriate stage, to assign the deferred icons to the associated prototypes.
---
---### Examples
---```lua
----- To store an icon created in the data stage for later assignment in the data-updates stage.
---
----- Create the empty table to hold the stored icons. No pre-configuration is required.
----- The lifetime of this variable must continue between stages.
---globals.deferred_icons = {}
---
----- Create the icon data (or use a pre-existing one).
------@type DeferrableIconsData
---local deferrable_icon = {
---    name = "iron-plate",
---    type_name = "item",
---    icon_data = { {
---        icon = "__base__/graphics/icons/iron-plate.png",
---        icon_size = 64,
---        scale = 0.5,
---    } },
---}
---
----- Store the icon for deferred assignment in the data-updates stage.
---_icons.store_icon_for_deferred_assigment_in_stage(deferred_icons, reskins.defines.stage.data_updates, deferrable_icon)
---```
---
---### Parameters
---@param deferred_icons { [Stage]: (DeferrableIconData|DeferrableIconDatum)[] } # The dictionary of deferrable icons, indexed by stage, to add the deferrable icon to.
---@param stage Stage # The key to the data stage to store the deferrable icon in.
---@param deferrable_icon DeferrableIconData|DeferrableIconDatum # The icon data to store for deferred assignment.
---
---### Exceptions
---*@throws* `string` — Thrown when `deferred_icons` is `nil`.<br/>
---*@throws* `string` — Thrown when `stage` is `nil` <br/>
---*@throws* `string` — Thrown when `deferrable_icon` is `nil`.<br/>
---*@throws* `string` — Thrown when `deferrable_icon.name` is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when `deferrable_icon.type_name` is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when both `deferrable_icon.icon_data` and `deferrable_icon.icon_datum` is `nil`, or `deferrable_icon.icon_data` is not an array of `IconData` objects, or the `IconData` objects are invalid.
---
---### See Also
---@see Icons.assign_icons_deferred_to_stage
---@deprecated Use reskins-sprite-utils.store_icon_for_deferred_assignment_in_stage
function _icons.store_icon_for_deferred_assigment_in_stage(deferred_icons, stage, deferrable_icon)
	__icons.store_icon_for_deferred_assignment_in_stage(deferred_icons, stage, deferrable_icon)
end

---
---Assigns the given `deferrable_icon` to the associated prototype.
---
---### Examples
---```lua
------@type DeferrableIconData
---local deferrable_icon = {
---    name = "iron-plate",
---    type_name = "item",
---    icon_data = { {
---        icon = "__base__/graphics/icons/iron-plate.png",
---        icon_size = 64,
---        scale = 0.5,
---    } },
---}
---
---_icons.assign_deferrable_icon(deferrable_icon)
---```
---
---### Parameters
---@param deferrable_icon DeferrableIconData|DeferrableIconDatum # An icon configured for deferrable assignment to a prototype.
---
---### Exceptions
---*@throws* `string` — Thrown when a deferred icon's `name` field is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when a deferred icon's `type_name` field is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when a deferred icon's `icon_data` field is `nil`<br/>
---*@throws* `string` — Thrown when a deferred icon's `icon_data[n].icon` field is not an absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when a deferred icon's `icon_data[n].icon_size` field is not a positive integer.<br/>
---
---### See Also
---@see Icons.assign_icons_to_prototype_and_related_prototypes
---@deprecated Use reskins-sprite-utils.icons.assign_deferrable_icon
function _icons.assign_deferrable_icon(deferrable_icon)
	__icons.assign_deferrable_icon(deferrable_icon)
end

---
---Assigns the deferrable icons in `deferred_icons[stage]` to the associated prototypes.
---
---### Examples
---```
----- Using the variable created earlier to store deferrable icons.
---reskins._internal.assign_icons_deferred_to_stage(globals.deferred_icons, reskins.defines.stage.data_updates)
---```
---
---### Parameters
---@param deferred_icons { [Stage]: (DeferrableIconData|DeferrableIconDatum)[] } # The dictionary of deferrable icons, indexed by stage, to assign the deferrable icons from.
---@param stage Stage # The index of the data stage to source deferrable icons from.
---
---### Exceptions
---*@throws* `string` — Thrown when a deferred icon's `name` field is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when a deferred icon's `type_name` field is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when a deferred icon's `icon_data` field is `nil`<br/>
---*@throws* `string` — Thrown when a deferred icon's `icon_data[n].icon` field is not an absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when a deferred icon's `icon_data[n].icon_size` field is not a positive integer.<br/>
---
---### See Also
---@see Icons.store_icon_for_deferred_assigment_in_stage
---@see Icons.assign_deferrable_icon
---@deprecated Use reskins-sprite-utils.icons.assign_icons_deferred_to_stage
function _icons.assign_icons_deferred_to_stage(deferred_icons, stage)
	__icons.assign_icons_deferred_to_stage(deferred_icons, stage)
end

---Composite Icon Utilities

---
---Combines the given set of icons defined by `IconData` objects or arrays of `IconData` objects
---into a single icon, with the first icon at the base of the stack and the last icon at the top.
---
---### Returns
---@return data.IconData[] # A single icon built from combining the input icons.
---
---### Remarks
---- Missing icon fields are set to default values as appropriate.
---- Inputs are not modified.
---
---### Parameters
---@param is_technology_icon boolean # When `true`, indicates that the inputs represent a technology icon.
---@param ... data.IconData|data.IconData[] # An variable set of `IconData` or `IconData` arrays to combine.
---
---### See Also
---@see Icons.add_missing_icon_defaults
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.compose_icons(...)
function _icons.combine_icons(is_technology_icon, ...)
	return __icons.compose_icons(is_technology_icon and "technology" or "default", ...)
end

---
---Transforms the given `icon_data` array by applying the given `scale`, `shift` and `tint` to each
---element of the array.
---
---### Returns
---@return data.IconData[] # A copy of `icon_data` with the transformations applied.
---
---### Remarks
---- Missing icon fields are set to default values as appropriate.
---- `icon_data` is not modified.
---
---### Examples
---```lua
------@type data.IconData[]
---local icon_data = {
---    {
---        icon = "__base__/graphics/icons/iron-plate.png",
---        icon_size = 64,
---        scale = 0.5,
---    },
---    {
---        icon = "__base__/graphics/icons/copper-wire.png",
---        icon_size = 64,
---        scale = 0.25,
---        shift = { -16, 16 }
---    },
---}
---
----- Transform the icon by scaling it to 1.5 times its original size
----- and shifting it by 16 pixels to the right.
---local transformed_icon_data = _icons.transform_icon(icon_data, 1.5, { 16, 0 })
---```
---
---### Parameters
---@param icon_data data.IconData[] # An array of `IconData` objects to be transformed.
---@param scale? double # The scale to apply to the sourced icon. Default `nil`.
---@param shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@param tint? data.Color # The tint to apply to the sourced icon. Default `nil`.
---@param is_technology_icon? boolean # When `true`, indicates that `icon_data` represents a technology icon.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_data` is `nil`.<br/>
---*@throws* `string` — Thrown when `icon_data[n].icon` is not an absolute file path with a valid extension.<br/>
---*@throws* `string` — Thrown when `icon_data[n].icon_size` is not a positive integer.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.transform_icon(icon_data, scale, shift, tint, ...)
function _icons.transform_icon(icon_data, scale, shift, tint, is_technology_icon)
	return __icons.transform_icon(icon_data, scale, shift, tint, is_technology_icon and "technology" or "default")
end

---
---Adds the icon from the given `prototype` to a copy the given `icon_data` array, and applies any
---of the optional transformations given by `scale`, `shift` or `tint`.
---
---### Returns
---@return data.IconData[] # A copy of `icon_data` with the icon data from `prototype`, if it exists; otherwise, a straight, unmodified copy of `icon_data`.
---
---### Remarks
---- This method assumes that `icon_data` is for a technology icon for purposes of setting
---  missing defaults if `prototype.type == "technology"`.
---- Missing icon fields are set to default values as appropriate.
---- `icon_data` and `prototype` are not modified.
---
---### Examples
---```
------@type data.IconData[]
---local icon_data = {
---    {
---        icon = "__base__/graphics/icons/iron-plate.png",
---        icon_size = 64,
---        scale = 0.5,
---    },
---}
---
----- Add the copper wire icon at one-half scale to the bottom left corner of the icon.
---local prototype = data.raw["item"]["copper-wire"]
---local iron_plate_with_copper_wire = _icons.add_icons_from_prototype_to_icons_by_reference(icon_data, prototype, 0.5, { -16, 16 })
---```
---
---### Parameters
---@param icon_data data.IconData[] # An array of `IconData` objects to receive the icon from `prototype`.
---@param prototype data.EntityPrototype|data.ItemPrototype|data.FluidPrototype|data.RecipePrototype|data.TechnologyPrototype # The prototype to source the icon from.
---@param scale? double # The scale to apply to the sourced icon. Default `nil`.
---@param shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@param tint? data.Color # The tint to apply to the sourced icon. Default `nil`.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_data` is `nil`.
---
---### See Also
---@see Icons.add_missing_icons_defaults
---@see Icons.get_icon_from_prototype_by_reference
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.add_icons_from_prototype_to_icons
function _icons.add_icons_from_prototype_to_icons_by_reference(icon_data, prototype, scale, shift, tint)
	return __icons.add_icons_from_prototype_to_icons(icon_data, prototype, scale, shift, tint)
end

---
---Adds the icon from the given `prototype` to a new `IconData[]` array with the given `icon_datum`
---as the base layer, and applies any of the optional transformations given by `scale`, `shift` or
---`tint`.
---
---### Returns
---@return data.IconData[] # An array of `IconData` with a copy of `icon_datum` as the base layer, and the added icon data from `prototype`, if it exists; otherwise, `icon_datum` reformatted as an array of `IconData`.
---
---### Remarks
---- This method assumes that `icon_datum` is for a technology icon for purposes of setting
---  missing defaults if `prototype.type == "technology"`.
---- Missing icon fields are set to default values as appropriate.
---- `icon_datum` and `prototype` are not modified.
---
---### Examples
---```
------@type data.IconData
---local icon_datum = {
---    icon = "__base__/graphics/icons/iron-plate.png",
---    icon_size = 64,
---    scale = 0.5,
---}
---
----- Add the copper wire icon at one-half scale to the bottom left corner of the icon.
---local prototype = data.raw["item"]["copper-wire"]
---local iron_plate_with_copper_wire = _icons.add_icons_from_prototype_to_icon_by_reference(icon_datum, prototype, 0.5, { -16, 16 })
---```
---
---### Parameters
---@param icon_datum data.IconData # An `IconData` object to be combined with the icon from `prototype`.
---@param prototype data.EntityPrototype|data.ItemPrototype|data.FluidPrototype|data.RecipePrototype|data.TechnologyPrototype # The prototype to source the icon from.
---@param scale? double # The scale to apply to the sourced icon. Default `nil`.
---@param shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@param tint? data.Color # The tint to apply to the sourced icon. Default `nil`.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_datum` is `nil`.<br/>
---*@throws* `string` — Thrown when `icon_datum` is not an IconData object with a defined `icon` field.
---
---### See Also
---@see Icons.add_icons_from_prototype_to_icons_by_reference
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.add_icons_from_prototype_to_icon
function _icons.add_icons_from_prototype_to_icon_by_reference(icon_datum, prototype, scale, shift, tint)
	return __icons.add_icons_from_prototype_to_icon(icon_datum, prototype, scale, shift, tint)
end

---
---Adds the icon from the prototype with the given `name` and `type_name` a copy the given
---`icon_data` array, and applies any of the optional transformations given by `scale`, `shift` or
---`tint`.
---
---### Returns
---@return data.IconData[] # A copy of `icon_data` with the icon data from `prototype`, if it exists; otherwise, a straight, unmodified copy of `icon_data`.
---
---### Remarks
---- This method assumes that `icon_data` is for a technology icon for purposes of setting
---  missing defaults if the prototype has `type == "technology"`.
---- Missing icon fields are set to default values as appropriate.
---- `icon_data` and the prototype are not modified.
---
---### Parameters
---@param icon_data data.IconData[] # An array of `IconData` objects to receive the icon from `prototype`.
---@param name string # The name of the prototype to source the icon from.
---@param type_name string # The type name of the prototype to source the icon from.
---@param scale? double # The scale to apply to the sourced icon. Default `nil`.
---@param shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@param tint? data.Color # The tint to apply to the sourced icon. Default `nil`.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_data` is `nil`.<br/>
---*@throws* `string` — Thrown when `name` is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when `type_name` is `nil` or an empty string.
---
---### See Also
---@see Icons.add_icons_from_prototype_to_icons_by_reference
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.add_icons_from_prototype_to_icons_by_name
function _icons.add_icons_from_prototype_to_icons_by_name(icon_data, name, type_name, scale, shift, tint)
	return __icons.add_icons_from_prototype_to_icons_by_name(icon_data, name, type_name, scale, shift, tint)
end

---
---Adds the icon from the prototype with the given `name` and `type_name` to a new `IconData[]`
---array with the given `icon_datum` as the base layer, and applies any of the optional
---transformations given by `scale`, `shift` or `tint`.
---
---### Returns
---@return data.IconData[] # An array of `IconData` with a copy of `icon_datum` as the base layer, and the added icon data from the prototype, if it exists; otherwise, `icon_datum` reformatted as an array of `IconData`.
---
---### Remarks
---- This method assumes that `icon_datum` is for a technology icon for purposes of setting
---  missing defaults if the prototype has `type == "technology"`.
---- Missing icon fields are set to default values as appropriate.
---- `icon_datum` and the prototype are not modified.
---
---### Examples
---```
------@type data.IconData
---local icon_datum = {
---    icon = "__base__/graphics/icons/iron-plate.png",
---    icon_size = 64,
---    scale = 0.5,
---}
---
----- Add the copper wire icon at one-half scale to the bottom left corner of the icon.
---local iron_plate_with_copper_wire = _icons.add_icons_from_prototype_to_icon_by_name(icon_datum, "copper-wire", "item", 0.5, { -16, 16 })
---```
---
--- ### Parameters
---@param icon_datum data.IconData # An `IconData` object to be combined with the icon from `prototype`.
---@param name string # The name of the prototype to source the icon from.
---@param type_name string # The type name of the prototype to source the icon from.
---@param scale? double # The scale to apply to the sourced icon. Default `nil`.
---@param shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@param tint? data.Color # The tint to apply to the sourced icon. Default `nil`.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_datum` is `nil`.<br/>
---*@throws* `string` — Thrown when `icon_datum` is not an IconData object with a defined `icon` field.<br/>
---*@throws* `string` — Thrown when `name` is `nil` or an empty string.<br/>
---*@throws* `string` — Thrown when `type_name` is `nil` or an empty string.
---
---### See Also
---@see Icons.add_icons_from_prototype_to_icons_by_reference
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.add_icons_from_prototype_to_icon_by_name
function _icons.add_icons_from_prototype_to_icon_by_name(icon_datum, name, type_name, scale, shift, tint)
	return __icons.add_icons_from_prototype_to_icon_by_name(icon_datum, name, type_name, scale, shift, tint)
end

---Provides the icon and optional transformations to a sourced `IconData` object.
---@class IconDatumSource
---@field icon_datum data.IconData # The icon data to be used for the icon.
---@field is_technology_icon? boolean # When `true`, indicates that `icon_datum` represents a technology icon.
---@field scale? double # The scale to apply to the sourced icon. Default `nil`.
---@field shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@field tint? data.Color # The tint to apply to the sourced icon. Default `nil`.

---Provides the icon and optional transformations to a sourced array of `IconData` objects.
---@class IconDataSource
---@field icon_data data.IconData[] # The icon data to be used for the icon.
---@field is_technology_icon? boolean # When `true`, indicates that `icon_data` represents a technology icon.
---@field scale? double # The scale to apply to the sourced icon. Default `nil`.
---@field shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@field tint? data.Color # The tint to apply to the sourced icon. Default `nil`.

---Provides the name and type information necessary to directly retrieve an icon
---from a source prototype, and apply a shift and scale to that icon.
---@class PrototypeIconSource
---@field name string # The name of the prototype to source the icon from.
---@field type_name string # The type name of the prototype to source the icon from.
---@field scale? double # The scale to apply to the sourced icon. Default `nil`.
---@field shift? data.Vector # The shift to apply to the sourced icon. Default `nil`.
---@field tint? data.Color # The tint to apply to the sourced icon. Default `nil`.

---@alias IconSource IconDatumSource|IconDataSource|PrototypeIconSource

---@alias IconSources (IconDatumSource|IconDataSource|PrototypeIconSource)[]

---@param source IconSource
---@return Reskins.SpriteUtils.IconSource
---@nodiscard
local function convert_icon_source(source)
	if source.icon_data then
		---@type Reskins.SpriteUtils.IconDataSource
		local converted = {
			icon_data = source.icon_data,
			defaults_type = source.is_technology_icon and "technology" or "default",
			scale = source.scale,
			shift = source.shift,
			tint = source.tint,
		}
		return converted
	elseif source.icon_datum then
		---@type Reskins.SpriteUtils.IconDatumSource
		local converted = {
			icon_datum = source.icon_datum,
			defaults_type = source.is_technology_icon and "technology" or "default",
			scale = source.scale,
			shift = source.shift,
			tint = source.tint,
		}
		return converted
	else
		return source--[[@as Reskins.SpriteUtils.PrototypeIconSource]]
	end
end

---@param sources IconSources
---@return Reskins.SpriteUtils.IconSources
---@nodiscard
local function convert_icon_sources(sources)
	---@type Reskins.SpriteUtils.IconSources
	local converted = {}
	for _, v in pairs(sources) do
		converted[#converted + 1] = convert_icon_source(v)
	end
	return converted
end

---
---Adds the icons from the given `sources` to a copy of the given `icon_data` array, and applies any
---of the optional transformations.
---
---### Returns
---@return data.IconData[], boolean # A copy of `icon_data` with the sourced icons from `sources` transformed and layered on top, if any exist; otherwise, a straight, unmodified copy of `icon_data`. When the second return value is `true`, a blank icon layer was created.
---
---### Remarks
---- Any layer of the icon using a `PrototypeIconSource` for a prototype that does not exist
---  will be replaced with a blank icon.
---- Missing icon fields are set to default values as appropriate.
---- `icon_data` and `sources` are not modified.
---
---### Parameters
---@param icon_data data.IconData[] # An `IconData` object to be combined with the sourced icons from `sources`.
---@param sources IconSources # An array of `IconData` sources to layer on `icon_data`.
---@param is_technology_icon? boolean # When `true`, indicates that `icon_data` represents a technology icon.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_data` is `nil`.<br/>
---*@throws* `string` — Thrown when `sources` is `nil`.
---
---### See Also
---@see Icons.add_missing_icons_defaults
---@see Icons.add_missing_icon_defaults
---@see Icons.get_icon_from_prototype_by_name
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.add_icons_from_sources_to_icons
function _icons.add_icons_from_sources_to_icons(icon_data, sources, is_technology_icon)
	return __icons.add_icons_from_sources_to_icons(
		icon_data,
		convert_icon_sources(sources),
		is_technology_icon and "technology" or "default"
	)
end

---
---Creates an icon from the given `source`, with the first element providing the base icon layer,
---and the remaining elements layered on top sequentially. Optional transformations are applied to
---each source, though only `tint` is applied to the base icon.
---
---### Returns
---@return data.IconData[], boolean # A new icon created from the sources, with the base icon from the first source, and icons from the remaining sources layered on top. When the second return value is `true`, a blank icon layer was created.
---
---### Remarks
---- Any layer of the icon using a `PrototypeIconSource` for a prototype that does not exist
---  will be replaced with a blank icon, including the base layer.
---- Missing icon fields are set to default values as appropriate.
---- `sources` is not modified.
---
---### Examples
---```lua
----- Define sources for an icon with an iron plate as the base, with two half-size icons sourced
----- from copper wire and copper plate layered on top and shifted to the left and right, respectively.
------@type (IconDatumSource|PrototypeIconSource)[]
---local sources = {
---    -- Define an icon directly.
---    {
---        icon_datum = {
---            icon = "__base__/graphics/icons/iron-plate.png",
---            icon_size = 64,
---            scale = 0.5,
---        },
---    },
---    -- Retrieve from existing item prototypes.
---    { name = "copper-wire", type_name = "item", scale = 0.5, shift = { -8, -8 } },
---    { name = "copper-plate", type_name = "item", scale = 0.5, shift = { 8, -8 } },
---}
---
----- Create the icon from the sources.
---local icon_data = _icons.create_icons_from_sources(sources)
---```
---
---### Parameters
---@param sources IconSources # An array of `IconData` sources to layer on `icon_data`.
---
---### Exceptions
---*@throws* `string` — Thrown when `sources` is `nil`.<br/>
---@nodiscard
---@deprecated Use reskins-sprite-utils.icons.create_icons_from_sources
function _icons.create_icons_from_sources(sources)
	return __icons.create_icons_from_sources(convert_icon_sources(sources))
end

---
---Assigns the given `icon_data` to the prototype with the given `name` and `type_name`, and to any
---related prototypes, such as items, entities, or recipes.
---
---### Remarks
---- Any layer of the icon using a `PrototypeIconSource` for a prototype that does not exist
---  will be replaced with a blank icon.
---- Missing icon fields are set to default values as appropriate.
---
---### Examples
---```lua
----- A dictionary of recipe names and the icon sources to use to create a combined icon.
----- The first entry in each IconSources is the first layer of the created icon.
------@type { [string]: IconSources }
---local recipe_icon_source_map = {
---    ["bio-resin-wood-reprocessing"] = {
---        { name = "resin", type_name = "item" },
---        { name = "wood", type_name = "item", scale = 0.5, shift = { -8, -8 } },
---    },
---}
---
---_icons.assign_combined_icons_from_sources_to_recipe(recipe_icon_source_map)
---```
---
---### Parameters
---@param recipe_icon_source_map { [string]: IconSources } # A map of recipe names to the icon sources used to create a combined icon. The first entry in each IconSources is the first layer of the created icon.
---@deprecated Use reskins-sprite-utils.icons.create_and_assign_combined_icons_from_sources_to_recipe
function _icons.create_and_assign_combined_icons_from_sources_to_recipe(recipe_icon_source_map)
	local converted = {}
	for k, v in pairs(recipe_icon_source_map) do
		converted[k] = convert_icon_sources(v)
	end

	__icons.create_and_assign_composed_icons_from_sources_to_recipe(converted)
end

---@alias IconSymbol
---| "area-drill"
---| "filter"
---| "shield"

local supported_symbols = {
	["area-drill"] = true,
	["filter"] = true,
	["shield"] = true,
}

---
---Gets an icon representing the given `letter` and colored with the given `tint`.
---
---### Returns
---@return data.IconData[] # An array of `IconData` objects representing the letter icon.
---
---### Examples
---```lua
----- Get the "area-drill" symbol icon in red.
---local icon_data = _icons.get_symbol("area-drill", { 1, 0, 0 })
---```
---
---### Parameters
---@param symbol IconSymbol # The symbol to get an icon for.
---@param tint data.Color # The color to tint the icon.
---
---### Exceptions
---*@throws* `string` — Thrown when `symbol` is not one of `"area-drill"`, `"filter"`, or `"shield"`.
---@nodiscard
function _icons.get_symbol(symbol, tint)
	assert(
		supported_symbols[symbol] ~= nil,
		"Invalid parameter: 'symbol' must be one of 'area-drill', 'filter', or 'shield'."
	)

	---@type data.IconData[]
	local icon_data = {
		{
			icon = "__reskins-library__/graphics/icons/symbols/" .. symbol:lower() .. "-symbol.png",
			icon_size = 64,
			scale = 0.5,
		},
		{
			icon = "__reskins-library__/graphics/icons/symbols/" .. symbol:lower() .. "-symbol.png",
			icon_size = 64,
			scale = 0.5,
			tint = util.get_color_with_alpha(tint, 0.75),
		},
	}

	return icon_data
end

---
---Removes any symbol icon layers from a copy of the given `icon_data`, if found.
---
---`icon_data` is not modified.
---
---### Returns
---@return data.IconData[] icon_data # A copy of `icon_data`, without the symbol icon layer.
---@return data.IconData[]|nil removed_layers  # A copy of the symbol icon layer removed from `icon_data`, if found; otherwise, `nil`.
---
---### Examples
---```lua
----- Assuming that the inserter icon has a filter symbol applied to it, do the following
----- to remove the symbol from the inserter icon.
---local icon_data = data.raw["inserter"]["inserter"].icons
---local icon_without_symbol = _tiers.remove_symbols_from_icons(icon_data)
---
----- Remove any symbols from the inserter icon and keep a copy of the removed symbol icon layers.
---local icon_without_tier_labels, removed_tier_labels = __tiers.remove_symbols_from_icons(icon_data)
---```
---
---### Parameters
---@param icon_data data.IconData[] # An icon represented by an array of `IconData` objects.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_data` is `nil`.
---@nodiscard
function _icons.remove_symbols_from_icons(icon_data)
	assert(icon_data ~= nil, "Invalid parameter: 'icon_data' must not be nil.")

	---@type data.IconData[]
	local icon_data_copy = util.copy(icon_data)

	---@type data.IconData[]
	local removed_layers = {}

	if #icon_data >= 2 then
		for i = #icon_data_copy, 1, -1 do
			if is_icon_using_reskins_images(icon_data_copy[i]) and icon_data_copy[i].icon:find("%-symbol.png") then
				table.insert(removed_layers, 1, table.remove(icon_data_copy, i))
			end
		end
	end

	return icon_data_copy, #removed_layers > 0 and removed_layers or nil
end

---@alias IconLetter
---| "F"
---| "H"
---| "L"
---| "M"
---| "S"

local supported_letters = {
	["F"] = true,
	["H"] = true,
	["L"] = true,
	["M"] = true,
	["S"] = true,
}

---
---Gets an icon representing the given `letter` and colored with the given `tint`.
---
---### Returns
---@return data.IconData[] # An array of `IconData` objects representing the letter icon.
---
---### Examples
---```lua
----- Get the "F" letter icon in red.
---local icon_data = _icons.get_letter("F", { 1, 0, 0 })
---```
---
---### Parameters
---@param letter IconLetter # The letter to get an icon for.
---@param tint data.Color # The color to tint the icon.
---
---### Exceptions
---*@throws* `string` — Thrown when `letter` is not one of `"F"`, `"H"`, `"L"`, `"M"`, or `"S"`.
---@nodiscard
function _icons.get_letter(letter, tint)
	assert(supported_letters[letter] ~= nil, "Invalid parameter: 'letter' must be one of 'F', 'H', 'L', 'M', or 'S'.")

	---@type data.IconData[]
	local icon_data = {
		{
			icon = "__reskins-library__/graphics/icons/letters/letter-" .. letter:lower() .. ".png",
			icon_size = 64,
			scale = 0.5,
		},
		{
			icon = "__reskins-library__/graphics/icons/letters/letter-" .. letter:lower() .. ".png",
			icon_size = 64,
			scale = 0.5,
			tint = util.get_color_with_alpha(tint, 0.75),
		},
	}

	return icon_data
end

---
---Removes any letter icon layers from a copy of the given `icon_data`, if found.
---
---`icon_data` is not modified.
---
---### Returns
---@return data.IconData[] icon_data # A copy of `icon_data`, without the letter icon layer.
---@return data.IconData[]|nil removed_layers  # A copy of the letter icon layer removed from `icon_data`, if found; otherwise, `nil`.
---
---### Examples
---```lua
----- Remove any letters from the solar-panel-small icon.
---local icon_data = data.raw["solar-panel"]["solar-panel-small"].icons
---local icon_without_letter = _tiers.remove_letters_from_icons(icon_data)
---
----- Remove any letters from the solar-panel-small icon and keep a copy of the removed letter icon layers.
---local icon_without_tier_labels, removed_tier_labels = __tiers.remove_letters_from_icons(icon_data)
---```
---
---### Parameters
---@param icon_data data.IconData[] # An icon represented by an array of `IconData` objects.
---
---### Exceptions
---*@throws* `string` — Thrown when `icon_data` is `nil`.
---@nodiscard
function _icons.remove_letters_from_icons(icon_data)
	assert(icon_data ~= nil, "Invalid parameter: 'icon_data' must not be nil.")

	---@type data.IconData[]
	local icon_data_copy = util.copy(icon_data)

	---@type data.IconData[]
	local removed_layers = {}

	if #icon_data > 2 then
		for i = #icon_data_copy, 1, -1 do
			if is_icon_using_reskins_images(icon_data_copy[i]) and icon_data_copy[i].icon:find("letter%-.%.png") then
				table.insert(removed_layers, 1, table.remove(icon_data_copy, i))
			end
		end
	end

	return icon_data_copy, #removed_layers > 0 and removed_layers or nil
end

---@alias EquipmentCategory
---| "defense" # A blue background for defense equipment.
---| "energy" # A green background for energy equipment.
---| "offense" # A red background for offense equipment.
---| "utility" # A gray background for utility equipment.

local equipment_background_tints = {
	["offense"] = util.color("#e62c2c"),
	["defense"] = util.color("#3282d1"),
	["energy"] = util.color("#32d167"),
	["utility"] = util.color("#cccccc"),
}

---
---Gets an icon representing the given `category` for equipment.
---
---### Returns
---@return data.IconData # An `IconData` object representing the equipment background icon.
---
---### Examples
---```lua
----- Get the defense equipment background icon.
---local icon_data = _icons.get_equipment_background("defense")
---```
---
---### Parameters
---@param category EquipmentCategory # The equipment background to get an icon for.
---
---### Exceptions
---*@throws* `string` — Thrown when `category` is not one of `"defense"`, `"energy"`, `"offense"`, or `"utility"`.
---@nodiscard
function _icons.get_equipment_icon_background(category)
	local tint = equipment_background_tints[category]
	assert(tint ~= nil, "Invalid parameter: 'category' must be one of 'defense', 'energy', 'offense', or 'utility'.")

	---@type data.IconData
	local icon_data = {
		icon = "__reskins-library__/graphics/icons/backgrounds/equipment-background.png",
		icon_size = 64,
		scale = 0.5,
		tint = tint,
	}

	return icon_data
end

return _icons
