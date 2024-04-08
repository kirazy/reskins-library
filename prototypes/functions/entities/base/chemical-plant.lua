-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.


---Reskins the named assembling machine with vanilla-style chemical plant sprites and color masking, and sets up appropriate corpse, explosion, and particle prototypes
---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param tier integer # 1-6 are supported, 0 to disable
---@param tint? table # [Types/Color](https://wiki.factorio.com/Types/Color)
---@param make_tier_labels? boolean
function reskins.lib.apply_skin.chemical_plant(name, tier, tint, make_tier_labels)
    ---@type SetupStandardEntityInputs
    local inputs = {
        type = "assembling-machine",
        icon_name = "chemical-plant",
        base_entity_name = "chemical-plant",
        mod = "lib",
        group = "common",
        particles = { ["big"] = 1,["medium"] = 2 },
        tier_labels = make_tier_labels,
        tint = tint and tint or reskins.lib.tiers.get_tint(tier),
    }

    local entity = data.raw[inputs.type][name]
    if not entity then return end

    -- angelspetrochem at this version or earlier does icon work in data-final-fixes
    if reskins.lib.version.is_same_or_older(mods["angelspetrochem"], "0.9.19") and (name == "chemical-plant") then
        inputs.defer_to_data_final_fixes = true
    end

    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Fetch corpse
    local corpse = data.raw["corpse"][name .. "-remnants"]

    -- Reskin corpse
    corpse.animation = reskins.lib.sprites.chemical_plants.get_standard_remnants(inputs.tint)

    -- Reskin entity
    entity.animation = reskins.lib.sprites.chemical_plants.get_standard_animation(inputs.tint)
    entity.working_visualisations = reskins.lib.sprites.chemical_plants.get_standard_working_visualisations()
    entity.drawing_box = { { -1.5, -2.25 }, { 1.5, 1.5 } }
end
