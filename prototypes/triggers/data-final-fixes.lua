-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- Only reskin chemical plants when Mini-machines pulls from the vanilla chemical plants
-- until such time as we handle the angels chemical plants as well
if reskins.compatibility and mods["angelspetrochem"] then
	reskins.compatibility.triggers.minimachines.chemplants.bobs = false
end
