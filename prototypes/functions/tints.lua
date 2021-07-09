-- Copyright (c) 2021 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- The intention of this script is to determine belt tints, and make them available to anything using belt tints.

-- Shift the rgb values of a given tint by shift amount, and optionally adjust the alpha value
function reskins.lib.adjust_tint(tint, shift, alpha)
    local adjusted_tint = {}

    -- Adjust the tint
    adjusted_tint.r = tint.r + shift
    adjusted_tint.g = tint.g + shift
    adjusted_tint.b = tint.b + shift
    adjusted_tint.a = alpha or tint.a

    -- Check boundary conditions
    if adjusted_tint.r > 1 then
        adjusted_tint.r = 1
    elseif adjusted_tint.r < 0 then
        adjusted_tint.r = 0
    end

    if adjusted_tint.g > 1 then
        adjusted_tint.g = 1
    elseif adjusted_tint.g < 0 then
        adjusted_tint.g = 0
    end

    if adjusted_tint.b > 1 then
        adjusted_tint.b = 1
    elseif adjusted_tint.b < 0 then
        adjusted_tint.b = 0
    end

    return adjusted_tint
end

-- Adjust the alpha value of a given RGB tint
function reskins.lib.adjust_alpha(tint, alpha)
    local adjusted_tint = {r = tint.r, g = tint.g, b = tint.b, a = alpha}
    return adjusted_tint
end

-- The following functions are adapted from work done by Maxreader, and implement the formulas for HSV/HSL to RGB and
-- vice versa from https://en.wikipedia.org/wiki/HSL_and_HSV
function reskins.lib.RGBtoHSV(tint)
	local r,g,b = tint.r, tint.g, tint.b
	local max = math.max(r,g,b)
	local min = math.min(r,g,b)
	local range = max - min
	local h

	if range == 0 then
		h = 0
	elseif max == r then
		h = (g-b)/range*60
	elseif max == g then
		h = (2+(b-r)/range)*60
	elseif max == b then
		h = (4+(r-g)/range)*60
	end

	if h < 0 then
		h = h + 360
	end

	local v = max
	local s = range/max

	return
    {
		h = h,
		s = s,
		v = v,
		a = tint.a or 1
	}
end

function reskins.lib.RGBtoHSL(tint)
	local r,g,b = tint.r, tint.g, tint.b
	local max = math.max(r,g,b)
	local min = math.min(r,g,b)
	local range = max - min
	local h

	if max == min then
		h = 0
	elseif max == r then
		h = (g-b)/range*60
	elseif max == g then
		h = (2+(b-r)/range)*60
	elseif max == b then
		h = (4+(r-g)/range)*60
	end

	if h < 0 then
		h = h + 360
	end

	local l = (min+max)/2
	local s = 0

	if not (min == 1 or max == 0) then
		s = (max-l)/math.min(l,1-l)
	end

	return
    {
		h = h,
		s = s,
		l = l,
		a = tint.a or 1
	}
end

function reskins.lib.HSVtoRGB(tint)
	local h,s,v = tint.h, tint.s, tint.v

	local function f(n)
		local k = (n + h/60) % 6
		return v - v*s*math.max(math.min(k,4-k,1),0)
	end
	return
    {
		r = f(5),
		g = f(3),
		b = f(1),
		a = tint.a or 1
	}
end

function reskins.lib.HSLtoRGB(tint)
	local h,s,l = tint.h, tint.s, tint.l

	local function f(n)
		local k = (n + h/30) % 12
		local x = s * math.min(l,1-l)
		return l - x*math.max(math.min(k-3,9-k,1),-1)
	end

	return
    {
		r = f(0),
		g = f(8),
		b = f(4),
		a = tint.a or 1
	}
end

-- DEFINE STANDARD TINT TABLES
local custom_tints = {
    [0] = util.color(settings.startup["reskins-lib-custom-colors-tier-0"].value),
    [1] = util.color(settings.startup["reskins-lib-custom-colors-tier-1"].value),
    [2] = util.color(settings.startup["reskins-lib-custom-colors-tier-2"].value),
    [3] = util.color(settings.startup["reskins-lib-custom-colors-tier-3"].value),
    [4] = util.color(settings.startup["reskins-lib-custom-colors-tier-4"].value),
    [5] = util.color(settings.startup["reskins-lib-custom-colors-tier-5"].value),
    [6] = util.color(settings.startup["reskins-lib-custom-colors-tier-6"].value),
}

local bobs_tints = {
    [0] = util.color("808080"), -- Old: 4d4d4d
    [1] = util.color("ffb726"), -- Old: de9400
    [2] = util.color("ff0800"), -- Old: c20600
    [3] = util.color("33b4ff"), -- Old: 0099ff, Historical 1b87c2
    [4] = util.color("b459ff"), -- Old: a600bf
    [5] = util.color("2ee55c"), -- Old: 16c746, Historical 23de55
    [6] = util.color("ff8533"), -- Old: ff7700
}

local angels_tints = {
    -- Core Angel's set
    [1] = util.color("595959"), -- Gray
    [2] = util.color("2957cc"), -- Blue
    [3] = util.color("cc2929"), -- Red
    [4] = util.color("ccae29"), -- Yellow

    -- Pending
    [0] = util.color("262626"),
    [5] = util.color("16c746"),
    [6] = util.color("ff8533"),
}

-- SETUP ENTITY COLORS
-- Determine which set of colors to use
if settings.startup["reskins-lib-customize-tier-colors"].value == true then
    -- Setup custom colors
    reskins.lib.tint_index = custom_tints

    -- Use Angel color presets
elseif reskins.lib.setting("reskins-angels-use-angels-tier-colors") then
    reskins.lib.tint_index = angels_tints
else
    -- Use default (Bob) color presets
    reskins.lib.tint_index = bobs_tints
end

-- SETUP BELT COLORS
-- Determine which set of colors to use
if settings.startup["reskins-lib-customize-tier-colors"].value == true then
    reskins.lib.belt_tint_index = custom_tints
elseif reskins.lib.setting("reskins-angels-use-angels-tier-colors") and reskins.lib.setting("reskins-angels-belts-use-angels-tier-colors") then
    reskins.lib.belt_tint_index = angels_tints
else
    reskins.lib.belt_tint_index = bobs_tints
end

-- Check if we're using an alternative tier-0 color for belts
if reskins.lib.setting("reskins-bobs-do-basic-belts-separately") == true then
    reskins.lib.belt_tint_index[0] = util.color(reskins.lib.setting("reskins-bobs-basic-belts-color"))
end