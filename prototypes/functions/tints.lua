-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- The intention of this script is to determine belt tints, and make them available to anything using belt tints.

-- The following functions are adapted from work done by Maxreader, and implement the formulas for HSV/HSL to RGB and
-- vice versa from https://en.wikipedia.org/wiki/HSL_and_HSV

_colors = require("__reskins-sprite-utils__.colors")

---@deprecated Use reskins-sprite-utils.colors.rgba_to_hsva
function reskins.lib.RGBtoHSV(tint)
	return _colors.rgba_to_hsva(tint)
end

---@deprecated Use reskins-sprite-utils.colors.rgba_to_hsla
function reskins.lib.RGBtoHSL(tint)
	return _colors.rgba_to_hsla(tint)
end

---@deprecated Use reskins-sprite-utils.colors.hsva_to_rgba
function reskins.lib.HSVtoRGB(tint)
	return _colors.hsva_to_rgba(tint)
end

---@deprecated Use reskins-sprite-utils.colors.hsla_to_rgba
function reskins.lib.HSLtoRGB(tint)
	return _colors.hsla_to_rgba(tint)
end
