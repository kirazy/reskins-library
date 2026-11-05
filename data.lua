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
		triggers = require("__reskins-angels__.prototypes.functions.triggers"),
	}
end

if mods["reskins-bobs"] then
	reskins.bobs = {
		triggers = require("__reskins-bobs__.prototypes.functions.triggers"),
	}
end

if mods["reskins-compatibility"] then
	reskins.compatibility = {
		triggers = require("__reskins-compatibility__.prototypes.functions.triggers"),
	}
end

require("prototypes.functions.functions")
require("prototypes.functions.tints")
require("prototypes.functions.icon-handling")
require("prototypes.functions.label-items")
require("prototypes.functions.entity-functions")

----------------------------------------------------------------------------------------------------
-- ENTITIES
----------------------------------------------------------------------------------------------------
-- Base
-- The require below is disabled because Artisanal Reskins: Bob's Mods reskins the belt entities of the base game with
-- the Assets API.
-- require("prototypes.entity.base.belt-entities")

----------------------------------------------------------------------------------------------------
-- TECHNOLOGIES
----------------------------------------------------------------------------------------------------
-- Base
require("prototypes.technology.base.logistics")
