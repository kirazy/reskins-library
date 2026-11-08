-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- util global is not available during settings stage and must be imported.
local util = require("util")

-- Leaving this as a soft-removal so that savvy users may enable the setting if they choose
-- Simply comment out the first override, and uncomment the second

-- NOTE: With the new color masks the result is very flat colors, as the highlight layers are much softer
-- In general the new masks should perform better and be much closer to how additive-soft behaved previously, with some improvements
reskins.lib.setting_override("string-setting", "reskins-lib-blend-mode", "additive")
-- reskins.lib.setting_override("string-setting", "reskins-lib-blend-mode", "additive-soft")

-- Hide the reskin scope settings.
reskins.lib.setting_override("bool-setting", "reskins-lib-scope-entities", true)
reskins.lib.setting_override("bool-setting", "reskins-lib-scope-equipment", true)
reskins.lib.setting_override("bool-setting", "reskins-lib-scope-items-and-fluids", true)
reskins.lib.setting_override("bool-setting", "reskins-lib-scope-technologies", true)
reskins.lib.setting_override("bool-setting", "reskins-lib-scope-interface", true)

---Sets the given `setting` in place as a hidden startup setting and adds it, if no setting with the same name exists.
---@param setting data.BoolSettingPrototype|data.ColorSettingPrototype
local function add_hidden_setting(setting)
	if data.raw[setting.type][setting.name] then
		return
	end

	setting.setting_type = "startup"
	setting.hidden = true
	if setting.type == "bool-setting" then
		setting.forced_value = setting.default_value
	end

	data:extend({ setting })
end

-- Add the hidden startup settings for Artisanal Reskins: Bob's Mods and Artisanal Reskins: Angel's Mods.
if mods["reskins-bobs"] then
	local bobs_mods = {
		"bobassembly",
		"bobelectronics",
		"bobenemies",
		"bobequipment",
		"bobgreenhouse",
		"boblogistics",
		"bobmining",
		"bobmodules",
		"bobores",
		"bobplates",
		"bobpower",
		"bobrevamp",
		"bobtech",
		"bobvehicleequipment",
		"bobwarfare",
	}

	for _, mod in pairs(bobs_mods) do
		if mods[mod] then
			add_hidden_setting({ type = "bool-setting", name = "reskins-bobs-do-" .. mod, default_value = true })
		end
	end

	if mods["boblogistics"] or mods["bobpower"] then
		add_hidden_setting({ type = "bool-setting", name = "reskins-bobs-do-pipe-tier-labeling", default_value = true })
	end

	if mods["boblogistics"] then
		add_hidden_setting({
			type = "bool-setting",
			name = "reskins-bobs-do-belt-entity-tier-labeling",
			default_value = true,
		})
		add_hidden_setting({ type = "bool-setting", name = "reskins-bobs-do-basic-belts-separately", default_value = true })
		add_hidden_setting({
			type = "color-setting",
			name = "reskins-bobs-basic-belts-color",
			default_value = util.color("#bfbfbf"),
		})
	end
end

if mods["reskins-angels"] then
	local angels_mods = {
		"angelsbioprocessing",
		"angelsexploration",
		"angelsindustries",
		"angelspetrochem",
		"angelsrefining",
		"angelssmelting",
		"angelsaddons-cab",
		"angelsaddons-mobility",
		"angelsaddons-storage",
	}

	for _, mod in pairs(angels_mods) do
		if mods[mod] then
			add_hidden_setting({ type = "bool-setting", name = "reskins-angels-do-" .. mod, default_value = true })
		end
	end
end
