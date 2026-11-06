-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- Setup the reskins global.
reskins = {}

reskins.lib = require("api")

require("internal")

-- Setup function hosts
if mods["reskins-angels"] then
	reskins.angels = {}
end

if mods["reskins-bobs"] then
	reskins.bobs = {}
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
-- The require below is disabled because Artisanal Reskins: Bob's Mods and Artisanal Reskins: Angel's Mods reskin the
-- logistics technologies of the base game and Bob's mods with the Assets API.
-- require("prototypes.technology.base.logistics")
