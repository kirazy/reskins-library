-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- Set the Mini Machines triggers for assembling machines and chemical plants.
if reskins.compatibility and reskins.bobs and reskins.bobs.triggers.assembly.entities then
	reskins.compatibility.triggers.minimachines.assemblers = true

	if reskins.lib.settings.get_value("bobmods-assembly-chemicalplants") then
		reskins.compatibility.triggers.minimachines.chemplants.bobs = true
	end
end

-- Set the trigger for pipes that use the colors of Angel's materials.
if
	reskins.lib.settings.get_value("reskins-angels-use-angels-material-colors-pipes") ~= false
	and (reskins.angels and reskins.angels.triggers.smelting.entities)
	and (reskins.bobs and reskins.bobs.triggers.logistics.entities)
then
	reskins.angels.triggers.smelting.pipes_use_material_colors = true
end
