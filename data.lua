-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- Setup the reskins global.
reskins = {}

reskins.lib = require("api")

require("internal")

-- Setup function hosts and import triggers
if mods["reskins-angels"] then
	reskins.angels = {
		triggers = require("prototypes.functions.angels.triggers"),
	}
end

if mods["reskins-bobs"] then
	reskins.bobs = {
		triggers = require("prototypes.functions.bobs.triggers"),
	}
end

if mods["reskins-compatibility"] then
	reskins.compatibility = {
		triggers = require("prototypes.functions.compatibility.triggers"),
	}
end

require("prototypes.functions.functions")
require("prototypes.functions.tints")
require("prototypes.functions.icon-handling")
require("prototypes.functions.label-items")
require("prototypes.functions.entity-functions")

-- Import the functions for Artisanal Reskins: Bob's Mods.
if mods["reskins-bobs"] then
	require("prototypes.functions.bobs.functions")
	require("prototypes.functions.entities.assembly.assembling-machine")
end

-- Import the functions for Artisanal Reskins: Angel's Mods.
if mods["reskins-angels"] then
	require("prototypes.functions.angels.functions")
	require("prototypes.functions.entities.petrochem.chemical-plant")
end

-- Import the functions for Artisanal Reskins: Compatibility.
if mods["reskins-compatibility"] then
	require("prototypes.functions.compatibility.functions")
end

----------------------------------------------------------------------------------------------------
-- TRIGGERS
----------------------------------------------------------------------------------------------------
require("prototypes.triggers.data")
