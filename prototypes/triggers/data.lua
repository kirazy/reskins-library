-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- Set the Mini Machines triggers.
if reskins.compatibility then
	local minimachines = reskins.compatibility.triggers.minimachines

	if
		not (reskins.bobs and (reskins.bobs.triggers.assembly.entities == false))
		and not (reskins.angels and (reskins.angels.triggers.petrochem.entities == false))
	then
		minimachines.refineries = true
	end

	if reskins.bobs then
		local triggers = reskins.bobs.triggers

		if triggers.assembly.entities then
			minimachines.centrifuges = true
			minimachines.electrolysers = true
			minimachines.refineries = true
		end

		if triggers.assembly.entities or triggers.plates.entities then
			minimachines.furnaces = true
		end

		if triggers.logistics.entities then
			minimachines.storagetanks = true
		end

		-- The trigger is set with or without Classic Mining Drill or Semi-Classic Mining Drill.
		if triggers.mining.entities then
			minimachines.miners = true
		end

		-- The trigger is set with or without Classic Beacon.
		if triggers.modules.entities then
			minimachines.beacons = true
		end

		if triggers.warfare.entities then
			minimachines.radar = true
		end
	end

	if reskins.angels and reskins.angels.triggers.petrochem.entities then
		minimachines.chemplants.angels = true
	end
end

-- Determine which tint we're using for the bob-hydrazine-generator
if reskins.bobs and reskins.bobs.triggers.power.entities and reskins.bobs.triggers.power.fluidgenerator then
	if reskins.lib.settings.get_value("reskins-bobs-hydrazine-is-blue") == true then
		reskins.bobs.hydrazine_tint = util.color("#7ac1de")
	else
		reskins.bobs.hydrazine_tint = nil
	end
end
