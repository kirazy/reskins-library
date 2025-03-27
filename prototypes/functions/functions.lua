-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

-- Library directory
reskins.lib.directory = "__reskins-library__"

--- Searches through a nested table based on a sequence of keys and returns the final value.
---
--- This function takes a root table and a series of keys, then attempts to locate the value
--- at the nested position defined by the keys. If any key in the sequence does not exist or the
--- current value is not a table during traversal, the function returns `nil`.
---
--- This mimics the behavior of the null-conditional operator in C#, safely accessing deeply nested properties.
---
--- @param root table The table from which to begin the search.
--- @param ... string|integer A list of keys defining the path to traverse within the root table.
--- @return any #The value at the end of the key sequence if it exists; otherwise, `nil`.
local function try_get_value(root, ...)
    for i = 1, select('#', ...) do
        if type(root) ~= "table" then return nil end
        local key = select(i, ...)
        root = root[key]
        if root == nil then
            return nil
        end
    end

    return root
end

---@class SetupStandardEntityInputs : ParseInputsInputs, CreateExplosionsAndParticlesInputs, CreateRemnantInputs, ConstructIconInputsOld

---Most entities have a common process for reskinning, so consolidate the other functions under one superfunction for ease of use
---@param name string # The name of the entity prototype to be reskinned.
---@param tier integer # The tier of the entity. An integer value from 0 to 6. Default `0`.
---@param inputs SetupStandardEntityInputs
function reskins.lib.setup_standard_entity(name, tier, inputs)
    -- Parse inputs
    reskins.lib.set_inputs_defaults(inputs)

    -- Create particles and explosions
    if inputs.make_explosions then
        reskins.lib.create_explosions_and_particles(name, inputs)
    end

    -- Create remnants
    if inputs.make_remnants then
        reskins.lib.create_remnant(name, inputs)
    end

    -- Create icons
    if inputs.make_icons then
        reskins.lib.construct_icon(name, tier, inputs)
    end
end

---@class ParseInputsInputs
---@field icon_size? data.SpriteSizeType # Default `64`.
---@field technology_icon_size? data.SpriteSizeType # Default `128`.
---@field make_explosions? boolean # Default `true`, creates explosions in `standard_setup_entity`.
---@field make_remnants? boolean # Default `true`, creates corpses in `standard_setup_entity`.
---@field make_icons? boolean # Default `true`, create icons in `standard_setup_entity`.
---@field tier_labels? boolean # Default `true`, displays tier labels on icons.
---@field make_icon_pictures? boolean # Default `true`, creates pictures for item-on-ground icons.

---Adds missing default values to the given `inputs` table.
---@param inputs ParseInputsInputs
---@return ParseInputsInputs inputs
---```lua
--- inputs = {
---     icon_size = 64,
---     technology_icon_size = 128,
---     make_explosions = true,
---     make_remnants = true,
---     make_icons = true,
---     tier_labels = true,
---     make_icon_pictures = true,
--- }
---```
function reskins.lib.set_inputs_defaults(inputs)
    inputs.icon_size = inputs.icon_size or 64
    inputs.technology_icon_size = inputs.technology_icon_size or 128
    inputs.make_explosions = (inputs.make_explosions ~= false)
    inputs.make_remnants = (inputs.make_remnants ~= false)
    inputs.make_icons = (inputs.make_icons ~= false)
    inputs.tier_labels = (inputs.tier_labels ~= false)
    inputs.make_icon_pictures = (inputs.make_icon_pictures ~= false)

    return inputs
end

---Assigns a consistent `order` property to a given entity prototype and the associated items, explosions, and remnants if they exist
---@param name string
---@param inputs AssignOrderInputs
function reskins.lib.assign_order(name, inputs)
    -- Initialize paths
    local entity
    if inputs.type then
        entity = data.raw[inputs.type][name]
    end
    local item = data.raw["item"][name]
    local explosion = data.raw["explosion"][name .. "-explosion"]
    local remnant = data.raw["corpse"][name .. "-remnants"]

    if entity then
        entity.order = inputs.sort_order
        entity.group = inputs.sort_group
        entity.subgroup = inputs.sort_subgroup
    end

    if item then
        item.order = inputs.sort_order
        -- item.group = inputs.sort_group
        item.subgroup = inputs.sort_subgroup
    end

    if explosion then
        explosion.order = inputs.sort_order
        -- explosion.group = inputs.sort_group
        explosion.subgroup = inputs.sort_subgroup
    end

    if remnant then
        remnant.order = inputs.sort_order
        -- remnant.group = inputs.sort_group
        remnant.subgroup = inputs.sort_subgroup
    end
end

---@class CreateRemnantInputs
---@field base_entity_name string # The type name of the entity to copy an existing `CorpsePrototype` from.
---@field type string # The type name of the entity to be assigned the new `CorpsePrototype`.

---@class remnant # See [Prototype/Corpse](https://wiki.factorio.com/Prototype/Corpse)

---Copies the Factorio corpse specified by `inputs.base_entity_name`, extends `data` with a new
---corpse with the name `[name]-remnants`, and assigns it to the named entity
---@param name string
---@param inputs CreateRemnantInputs
---```
--- inputs = {
---     base_entity_name = string -- Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---     type = string -- See https://wiki.factorio.com/Prototype_definitions
--- }
---```
function reskins.lib.create_remnant(name, inputs)
    ---@type data.CorpsePrototype
    local remnant = util.copy(data.raw["corpse"][inputs.base_entity_name .. "-remnants"])
    remnant.name = name .. "-remnants"
    data:extend({ remnant })

    -- Assign corpse to originating entity
    data.raw[inputs.type][name]["corpse"] = remnant.name
end

---@class CreateExplosionInputs : CreateRemnantInputs

---Copies the Factorio explosion specified by `inputs.base_entity_name`, extends `data` with a new
---explosion with the name `[name]-explosion`, and assigns it to the named entity
---@param name string
---@param inputs CreateExplosionInputs
---```
--- inputs = {
---     base_entity_name = string -- Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---     type = string -- See https://wiki.factorio.com/Prototype_definitions
--- }
---```
function reskins.lib.create_explosion(name, inputs)
    local explosion = util.copy(data.raw["explosion"][inputs.base_entity_name .. "-explosion"])
    explosion.name = name .. "-explosion"
    data:extend({ explosion })

    -- Assign explosion to originating entity
    data.raw[inputs.type][name]["dying_explosion"] = explosion.name
end

---Copies the Factorio particle specified by `base_entity_name`, applies tints, extends `data`
---with a new particle with the name `[name]-[base-particle-name]-tinted`, and assigns it to the named explosion
---@param name string #
---@param base_entity_name string # Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---@param base_particle_name string # Key for `reskins.lib.particle_index`
---@param key integer # Index corresponding to the particle within the `explosion` prototype
---@param tint data.Color
function reskins.lib.create_particle(name, base_entity_name, base_particle_name, key, tint)
    local particle = util.copy(data.raw["optimized-particle"][base_entity_name .. "-" .. base_particle_name])
    particle.name = name .. "-" .. base_particle_name .. "-tinted"
    particle.pictures.sheet.tint = tint
    data:extend({ particle })

    -- Assign particle to originating explosion
    ---@type table|nil
    local target_effects = try_get_value(data.raw.explosion, name .. "-explosion", "created_effect", "action_delivery", "target_effects")
    if not target_effects or #target_effects == 0 then return end

    -- Check if the target_effects table has at least one member, check if that member is of type =
    -- "create-explosion", and if so, collection the entity name and then go find THAT explosion.
    if target_effects[1].type == "create_explosion" then
        local explosion_reference_name = target_effects[1].entity_name

        target_effects = try_get_value(data.raw.explosion, explosion_reference_name, "created_effect", "action_delivery", "target_effects")
    end

    local target_effect = try_get_value(target_effects, key)
    if target_effect and target_effect.type == "create_particle" then
        target_effect.particle_name = particle.name
    end
end

---@class CreateExplosionsAndParticlesInputs : CreateExplosionInputs
---@field particles? table # Table of keys for `reskins.lib.particle_index` and the target index within the explosion particle table to copy
---@field tint table # [Types/Color](https://wiki.factorio.com/Types/Color)

---Batches the `create_explosion` and `create_particle` function together for ease of use
---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param inputs CreateExplosionsAndParticlesInputs @
---```
--- inputs = {
---     base_entity_name = string -- Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---     type = string -- See https://wiki.factorio.com/Prototype_definitions
---     tint = table -- See https://wiki.factorio.com/Types/Color
---     particles? = {
---         [string] = integer, -- reskins.lib.particle_index key, and associated target particle index
---         ...
---     }
--- }
---```
function reskins.lib.create_explosions_and_particles(name, inputs)
    reskins.lib.create_explosion(name, inputs)

    if inputs.particles then
        for particle, key in pairs(inputs.particles) do
            -- Create and assign the particle
            reskins.lib.create_particle(name, inputs.base_entity_name, reskins.lib.particle_index[particle], key, inputs.tint)
        end
    end
end

reskins.lib.particle_index = {
    ["tiny-stone"] = "stone-particle-tiny",
    ["small"] = "metal-particle-small",
    ["small-stone"] = "stone-particle-small",
    ["medium"] = "metal-particle-medium",
    ["medium-long"] = "long-metal-particle-medium",
    ["medium-stone"] = "stone-particle-medium",
    ["big"] = "metal-particle-big",
    ["big-stone"] = "stone-particle-big",
    ["big-tint"] = "metal-particle-big-tint",
}
