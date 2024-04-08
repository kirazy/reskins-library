---They're going away.
---@diagnostic disable: inject-field
-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---@deprecated Use `reskins.library.tiers.get_tint(tier)` instead.
reskins.lib.tint_index = {
    [0] = reskins.lib.tiers.get_tint(0),
    [1] = reskins.lib.tiers.get_tint(1),
    [2] = reskins.lib.tiers.get_tint(2),
    [3] = reskins.lib.tiers.get_tint(3),
    [4] = reskins.lib.tiers.get_tint(4),
    [5] = reskins.lib.tiers.get_tint(5),
    [6] = reskins.lib.tiers.get_tint(6),
}


---@deprecated Use `reskins.library.tiers.get_belt_tint(tier)` instead.
reskins.lib.belt_tint_index = {
    [0] = reskins.lib.tiers.get_belt_tint(0),
    [1] = reskins.lib.tiers.get_belt_tint(1),
    [2] = reskins.lib.tiers.get_belt_tint(2),
    [3] = reskins.lib.tiers.get_belt_tint(3),
    [4] = reskins.lib.tiers.get_belt_tint(4),
    [5] = reskins.lib.tiers.get_belt_tint(5),
    [6] = reskins.lib.tiers.get_belt_tint(6),
}

---Gets the value of the startup setting with the given `name`, if it exists. Otherwise, returns `nil`.
---@param name string # The name of a startup setting.
---@return boolean|string|Color|double|int|nil
---@deprecated Use `reskins.library.setting.get_value(name)` instead.
function reskins.lib.setting(name)
    local value = nil
    if settings.startup[name] then
        value = settings.startup[name].value
    end

    return value
end

---@alias mod_settings
---| '"angelsaddons-cab"'
---| '"angelsaddons-mobility"'
---| '"angelsaddons-storage"'
---| '"angelsbioprocessing"'
---| '"angelsexploration"'
---| '"angelsindustries"'
---| '"angelspetrochem"'
---| '"angelsrefining"'
---| '"angelssmelting"'
---| '"bobassembly"'
---| '"bobelectronics"'
---| '"bobenemies"'
---| '"bobequipment"'
---| '"bobgreenhouse"'
---| '"boblogistics"'
---| '"bobmining"'
---| '"bobmodules"'
---| '"bobores"'
---| '"bobplates"'
---| '"bobpower"'
---| '"bobrevamp"'
---| '"bobtech"'
---| '"bobvehicleequipment"'
---| '"bobwarfare"'

---@alias reskin_mods
---| '"angels"'
---| '"bobs"'
---| '"lib"'
---| '"compatibility"'

---@alias sprite_scopes
---| '"entities"'
---| '"equipment"'
---| '"items-and-fluids"'
---| '"technologies"'

---Checks to see if the reskin-toggle is enabled for a given setting, and if it is, checks if the given scope is also enabled.
---Returns true if both are true, returns false if one is false, and nil otherwise.
---@param scope sprite_scopes
---@param mod reskin_mods
---@param setting mod_settings
---@return boolean|nil
---@deprecated Use `reskins.library.is_feature_set_enabled(scope, mod, setting)` instead.
function reskins.lib.check_scope(scope, mod, setting)
    if reskins.lib.settings.get_value("reskins-" .. mod .. "-do-" .. setting) == true then
        if reskins.lib.settings.get_value("reskins-lib-scope-" .. scope) == true then
            return true
        else
            return false
        end
    elseif reskins.lib.settings.get_value("reskins-" .. mod .. "-do-" .. setting) == false then
        return false
    else
        return nil
    end
end

-- Shift the rgb values of a given tint by shift amount, and optionally adjust the alpha value
---@deprecated Use `util.get_color_with_alpha` instead.
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
---@deprecated Use `util.get_color_with_alpha` instead.
function reskins.lib.adjust_alpha(tint, alpha)
    local adjusted_tint = { r = tint.r, g = tint.g, b = tint.b, a = alpha }
    return adjusted_tint
end


-- Fetch blend mode, default `"additive"`. May be overridden in `settings-updates.lua` by uncommenting the line.
---@deprecated Use `reskins.library.settings.blend_mode` instead.
---@type data.BlendMode
reskins.lib.blend_mode = reskins.lib.settings.get_value("reskins-lib-blend-mode")

---@deprecated Use `reskins.lib.icons.assign_icons_to_prototype_and_related_prototypes` instead.
function reskins.lib.assign_technology_icons(name, inputs)
    -- Inputs required by this function
    -- technology_icon          - Table or string defining technology icon

    -- Optional inputs (required if making a flat icon)
    -- technology_icon_size     - Pixel size of icons
    -- technology_icon_mipmaps  - Number of mipmaps present in the icon image file

    -- Initialize paths
    local technology = data.raw["technology"][name]

    -- Ensure the technology in question exists
    if technology then
        -- Check whether icon or icons, ensure the key we're not using is erased
        if type(inputs.technology_icon) == "table" then
            -- Set icon_size and icon_mipmaps per icons specification
            for n = 1, #inputs.technology_icon do
                if not inputs.technology_icon[n].icon_size then
                    inputs.technology_icon[n].icon_size = inputs.technology_icon_size
                end

                if not inputs.technology_icon[n].icon_mipmaps then
                    inputs.technology_icon[n].icon_mipmaps = inputs.technology_icon_mipmaps
                end
            end

            technology.icon = nil
            technology.icons = inputs.technology_icon
        else
            technology.icon = inputs.technology_icon
            technology.icons = nil
            technology.icon_size = inputs.technology_icon_size
            technology.icon_mipmaps = inputs.technology_icon_mipmaps
        end
    end
end

---Resizes the given `prototype` by the given `scalar`.
---
---Recursively iterates through the given `prototype` and applies the given `scalar` to all the numeric values
---in the fields listed in `included_fields`.
---@param prototype any
---@param scalar double
---@deprecated Use `reskins.api.prototype.rescale_prototype_recursively(prototype, scalar)` instead.
function reskins.lib.rescale_entity(prototype, scalar)
    reskins.lib.prototypes.rescale_prototype(prototype, scalar)
end

--- Rescale remnants
---@param prototype data.EntityWithHealthPrototype
---@param scalar double
---@deprecated Use `reskins.api.prototype.rescale_remnants_of_prototype(prototype, scalar)` instead.
function reskins.lib.rescale_remnant(prototype, scalar)
    reskins.lib.prototypes.rescale_remnants_of_prototype(prototype, scalar)
end

---@param animation VerticallyOrientableAnimation|data.Animation
---@return data.Animation4Way
---@deprecated Use `reskins.library.sprites.make_4way_animation_from_spritesheet(animation)` instead.
function reskins.lib.make_4way_animation_from_spritesheet(animation)
    return reskins.lib.sprites.make_4way_animation_from_spritesheet(animation)
end


---Stores icon properties for assignment at a later data stage, has same input requirements as `reskins.lib.assign_icons()`
---@param name string # The name of the prototype.
---@param inputs StoreIconsInputs
---@param storage? "technology"|"icons" # Default `"icons"`.
---@deprecated Use `reskins.internal.store_icon_for_deferred_assigment_in_stage(stage, deferrable_icon)` instead.
function reskins.lib.store_icons(name, inputs, storage)
    ---@type DeferrableIconData
    local deferrable_icon = {
        name = name,
        type_name = inputs.type,
        icon_data = util.copy(inputs.icon),
        pictures = util.copy(inputs.icon_picture),
    }

    local stage
    if inputs.defer_to_data_final_fixes then
        stage = reskins.lib.defines.stage.data_final_fixes
    elseif inputs.defer_to_data_updates then
        stage = reskins.lib.defines.stage.data_updates
    else
        log("[Reskins] " .. name .. " was improperly stored for deferred icon assignment.")
        return -- Fail quietly; should never get here
    end

    reskins.internal.store_icon_for_deferred_assigment_in_stage(stage, deferrable_icon)
end

---@class AssignIconInputs
---@field type string # The type name of the prototype.
---@field icon data.FileName|data.IconData[] # The icon to assign, given as a file name or an array of `IconData` objects.
---@field icon_size? data.SpriteSizeType # Required if `icon` is data.FileName, or not every `IconData` object has an `icon_size` value.
---@field icon_mipmaps? data.IconMipMapType
---@field icon_picture? data.SpriteVariations
---@field make_entity_pictures? boolean # When true, entities of type `type` will be assigned the `icon_picture` value.
---@field make_icon_pictures? boolean # When true, valid items will be assigned the `icon_picture` value.

---Robustly assigns an `icon` or `icons` definition to an entity and related prototypes
---@param name string # The name of the prototype.
---@param inputs AssignIconInputs
---@deprecated Use `reskins.api.icon.assign_icons_to_prototype_and_related_prototypes`.
function reskins.lib.assign_icons(name, inputs)
    local entity = inputs.type and data.raw[inputs.type][name]

    -- Recipes are exceptions to the usual pattern
    local item, item_with_data, explosion, remnant
    if inputs.type ~= "recipe" then
        item = data.raw["item"][name]
        item_with_data = data.raw["item-with-entity-data"][name]
        explosion = data.raw["explosion"][name .. "-explosion"]
        remnant = data.raw["corpse"][name .. "-remnants"]
    end

    -- Ensure the key we're not using is erased
    reskins.lib.icons.clear_icon_from_prototype_by_reference(entity)
    reskins.lib.icons.clear_icon_from_prototype_by_reference(item)
    reskins.lib.icons.clear_icon_from_prototype_by_reference(item_with_data)
    reskins.lib.icons.clear_icon_from_prototype_by_reference(explosion)
    reskins.lib.icons.clear_icon_from_prototype_by_reference(remnant)

    -- Check if icon or icons.
    if type(inputs.icon) == "table" then
        -- Ensure icon_size is present before passing to add_missing_icons_defaults.
        for n = 1, #inputs.icon do
            local icon_size = inputs.icon[n].icon_size or inputs.icon_size
            if not icon_size then
                error("Invalid parameter: inputs.icon_size or inputs.icon[n].icon_size must be provided.")
            end

            inputs.icon[n].icon_size = icon_size
        end

        inputs.icon = reskins.lib.icons.add_missing_icons_defaults(inputs.icon, inputs.type == "technology")

        -- Create icons that have multiple layers
        if entity then entity.icons = inputs.icon end
        if item then item.icons = inputs.icon end
        if item_with_data then item_with_data.icons = inputs.icon end
        if explosion then explosion.icons = inputs.icon end
        if remnant then remnant.icons = inputs.icon end
    else
        -- Create icons that do not have multiple layers
        if entity then
            entity.icon = inputs.icon
            entity.icon_size = inputs.icon_size
            entity.icon_mipmaps = inputs.icon_mipmaps
        end

        if item then
            item.icon = inputs.icon
            item.icon_size = inputs.icon_size
            item.icon_mipmaps = inputs.icon_mipmaps
        end

        if item_with_data then
            item_with_data.icon = inputs.icon
            item_with_data.icon_size = inputs.icon_size
            item_with_data.icon_mipmaps = inputs.icon_mipmaps
        end

        if explosion then
            explosion.icon = inputs.icon
            explosion.icon_size = inputs.icon_size
            explosion.icon_mipmaps = inputs.icon_mipmaps
        end

        if remnant then
            remnant.icon = inputs.icon
            remnant.icon_size = inputs.icon_size
            remnant.icon_mipmaps = inputs.icon_mipmaps
        end
    end

    -- Handle picture definitions
    if entity and inputs.icon_picture and inputs.make_entity_pictures then
        entity.pictures = inputs.icon_picture
    end

    if item and inputs.icon_picture and inputs.make_icon_pictures then
        item.pictures = inputs.icon_picture
    end

    -- item-with-entity-data prototypes ignore pictures field as of 1.0
    -- this has been left active in the hopes the default behavior is adjusted
    if item_with_data and inputs.icon_picture and inputs.make_icon_pictures then
        item_with_data.pictures = inputs.icon_picture
    end

    if inputs.type ~= "recipe" then
        reskins.lib.icons.clear_icon_from_prototype_by_name(name, "recipe")
    end
end

---Converts the given `icon` to a sprite.
---@param icon_data data.IconData
---@param scale double
---@return data.Sprite
---@deprecated Use `reskins.api.sprite.create_sprite_from_icon` instead.
function reskins.lib.convert_icon_to_sprite(icon_data, scale)
    if type(icon_data) ~= "table" then
        error("Invalid parameter: icon_data must be a table of type IconData.")
    end

    ---@type data.Sprite
    local sprite = {
        filename = icon_data.icon,
        size = icon_data.icon_size,
        mipmap_count = icon_data.icon_mipmaps and icon_data.icon_mipmaps or 0,
        scale = (icon_data.scale and icon_data.scale or 1) * scale,
        shift = icon_data.shift and util.mul_shift(icon_data.shift, scale / 32) or nil,
        tint = icon_data.tint and icon_data.tint or nil,
    }

    return sprite
end

--- Converts the given `icons_data` to a layered sprite, rescaled by the
--- specified `scale`.
---@param icons_data data.IconData[] # The icons_data to process.
---@param scale double # The scale factor to apply to `icons_data`, relative to a 64x64 pixel icon.
---@return data.Sprite
---@deprecated Use `reskins.api.sprite.create_sprite_from_icons` instead. Note that scale is then true scale, not relative to a 64x64 pixel icon.
function reskins.lib.convert_icons_to_sprite(icons_data, scale)
    ---@type data.Sprite
    local sprite = { layers = {} }

    scale = scale * (32 / icons_data[1].icon_size)
    for _, icon_data in pairs(icons_data) do
        -- This method is deprecated, but we're using it here intentionally to preserve historic behavior.
        -- Which is buggy.
        ---@diagnostic disable-next-line: deprecated
        table.insert(sprite.layers, reskins.lib.convert_icon_to_sprite(icon_data, scale))
    end

    return sprite
end

---Gets a properly formatted `icons` definition directly from the given `prototype`.
---
---The `prototype` is not modified.
---@param prototype data.EntityPrototype|data.ItemPrototype|data.RecipePrototype|data.TechnologyPrototype # The prototype to get the `icons` definition from.
---@return data.IconData[]|nil # The icon reformatted as an `icons` defintion, or `nil`.
---@deprecated Use `reskins.api.icon.get_icon_from_prototype_by_reference` instead.
function reskins.lib.get_icons_from_prototype(prototype)
    if not prototype then return nil end

    ---@type data.IconData[]
    local icons
    if prototype.icons then
        ---@type data.IconData[]
        icons = util.copy(prototype.icons)

        for n = 1, #icons do
            ---@type data.IconData
            local icon = {
                icon = icons[n].icon,
                icon_size = icons[n].icon_size and icons[n].icon_size or prototype.icon_size,
                icon_mipmaps = icons[n].icon_mipmaps or 0,
                shift = icons[n].shift or nil,
                scale = icons[n].scale or nil,
                tint = icons[n].tint or nil,
            }

            icons[n] = icon
        end
    else
        ---@type data.IconData
        local icon = {
            icon = prototype.icon,
            icon_size = prototype.icon_size,
            icon_mipmaps = prototype.icon_mipmaps or 0,
        }

        icons = { icon }
    end

    return icons
end

--- Adds tier labels for the given `tier` to the specified `icons` definition.
---
--- Handles compliance with the mod setting to disable tier labels.
---@param icons data.IconData[] # An icons definition to receive the tier labels.
---@param tier? integer # The tier of the tier labels to add.
---@return data.IconData[] # A copy of `icons` with added tier labels.
---@deprecated Use `reskins.api.tier.add_tier_labels_to_icons(tier, icons)` instead.
function reskins.lib.add_tier_labels_to_icons(icons, tier)
    return reskins.lib.tiers.add_tier_labels_to_icons(tier or 0, icons)
end

--- Adds tier labels for the given `tier` to the prototype with the specified `name` and `type`.
---@param name string # The name of the prototype with the icon to be modified.
---@param tier integer # The tier to apply to the icon.
---@param inputs any # { type = "prototype" }
---@see Reskins.Lib.Tiers.add_tier_labels_to_prototype_by_name
---@see Reskins.Lib.Tiers.add_tier_labels_to_prototype_by_reference
---@deprecated Use `reskins.api.tier.add_tier_labels_to_prototype_by_name` instead.
function reskins.lib.append_tier_labels_to_vanilla_icon(name, tier, inputs)
    reskins.lib.tiers.add_tier_labels_to_prototype_by_name(tier, name, inputs.type)
end

---This method mutates `inputs.icon`.
---@see Reskins.Lib.Tiers.add_tier_labels_to_icon
---@see Reskins.Lib.Tiers.add_tier_labels_to_icons
---@deprecated Use `reskins.api.tier.add_tier_labels_to_icons` instead.
function reskins.lib.append_tier_labels(tier, inputs)
    -- Inputs required by this function
    -- icon             - Table containing an icon/icons definition
    -- tier_labels      - Determines whether tier labels are appended

    if settings.startup["reskins-lib-icon-tier-labeling"].value == true and tier > 0 and inputs.tier_labels == true then
        -- Append the tier labels
        local icon_style = settings.startup["reskins-lib-icon-tier-labeling-style"].value
        table.insert(inputs.icon, {
            icon = "__reskins-library__/graphics/icons/tiers/" .. icon_style .. "/" .. tier .. ".png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.5,
        }
        )
        table.insert(inputs.icon, {
            icon = "__reskins-library__/graphics/icons/tiers/" .. icon_style .. "/" .. tier .. ".png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.5,
            tint = util.get_color_with_alpha(reskins.lib.tiers.get_tint(tier), 0.75),
        })
    end
end

---@see Reskins.Lib.Icons.clear_icon_from_prototype_by_name
---@deprecated Use `reskins.api.icon.clear_icon_from_prototype_by_name` instead.
function reskins.lib.clear_icon_specification(name, type)
    -- Inputs required by this function:
    -- type        - Entity type

    -- Fetch entity
    local entity = data.raw[type][name]

    -- If the entity exists, clear the icon specification
    if entity then
        entity.icon = nil
        entity.icons = nil
        entity.icon_size = nil
        entity.icon_mipmaps = nil
    end
end

---@param mod string # Unused.
---@param data_stage "data-updates"|"data-final-fixes" # The stage to assign the stored icons from.
---@see reskins.internal.assign_icons_deferred_to_stage
---@see Reskins.Lib.Icons.store_icon_for_deferred_assigment_in_stage
---@see Reskins.Lib.Icons.assign_icons_deferred_to_stage
---@deprecated Either use `reskins.internal.assign_icons_deferred_to_stage` instead, or setup your own handling using `reskins.api.store_icon_for_deferred_assigment_in_stage` and `reskins.api.assign_icons_deferred_to_stage.
function reskins.lib.assign_deferred_icons(mod, data_stage)
    ---@type Reskins.Lib.Defines.Stage
    local stage
    if data_stage == "data-updates" then
        stage = reskins.lib.defines.stage.data_updates
    elseif data_stage == "data-final-fixes" then
        stage = reskins.lib.defines.stage.data_final_fixes
    else
        return
    end

    reskins.internal.assign_icons_deferred_to_stage(stage)
end

---@class CompositeIconInput
---@field icons data.IconData[]? # A multi-layer icon. Used if defined.
---@field icon data.IconData? # A single-layer icon. Used if `icons` is not defined.
---@field type string? # The type name of the prototype to source the icon from. Defaults to `"item"`.
---@field scale double? # The scale to apply to the sourced icon. Default `nil`.
---@field shift data.Vector? # The shift to apply to the sourced icon. Default `nil`.

---@param name string # The name of the prototype to source the icon from.
---@param composite_icon data.IconData[] # The icon to composite onto.
---@param params { type: string?, scale: double?, shift: data.Vector? } # The optional `type`, `scale` and `shift` parameters.
---@return data.IconData[] # The composited icon.
---### Deprecated
---@see Reskins.Lib.Icons.add_icons_from_sources_to_icons
---@deprecated Use `reskins.api.icon.add_icons_from_sources_to_icons` instead.
function reskins.lib.composite_existing_icons_onto_icons_definition(name, composite_icon, params)
    ---@type PrototypeIconSource
    local source = {
        name = name,
        type_name = params.type or "item",
        scale = params.scale,
        shift = params.shift,
    }

    local icon_data = reskins.lib.icons.add_icons_from_sources_to_icons(composite_icon, { source })

    return icon_data
end

---@param target_name string # The name of the prototype receiving the composited icon.
---@param target_type string # The type name of the prototype receiving the composited icon.
---@param params { [string]: CompositeIconInput } # A dictionary of `"name" = CompositeIconInput` that provides the icons to be composited.
---### Deprecated
---@see Reskins.Lib.Icons.create_icons_from_sources
---@see Reskins.Lib.Icons.create_and_assign_combined_icons_from_sources_to_recipe
---@deprecated Needs refactoring. See related methods.
function reskins.lib.composite_existing_icons(target_name, target_type, params)
    if target_type == "technology" then
        error("Invalid parameter: compositing icons on technologies is not supported.")
    end

    ---@type (IconDatumSource|IconDataSource|PrototypeIconSource)[]
    local sources = {}

    for name, param in pairs(params) do
        if param.icons then
            ---@type IconDataSource
            local icon_data_source = {
                icon_data = param.icons,
                scale = param.scale,
                shift = param.shift,
            }

            table.insert(sources, icon_data_source)
        elseif param.icon then
            ---@type IconDatumSource
            local icon_datum_source = {
                icon_datum = param.icon,
                scale = param.scale,
                shift = param.shift,
            }

            table.insert(sources, icon_datum_source)
        else
            ---@type PrototypeIconSource
            local prototype_icon_source = {
                name = name,
                type_name = param.type or "item",
                scale = param.scale,
                shift = param.shift,
            }

            table.insert(sources, prototype_icon_source)
        end
    end

    local icon_data = reskins.lib.icons.get_icon_from_prototype_by_name(target_name, target_type)
    if icon_data then
        local combined_icon = reskins.lib.icons.add_icons_from_sources_to_icons(icon_data, sources)
        reskins.lib.icons.assign_icons_to_prototype_and_related_prototypes(target_name, target_type, combined_icon)
    end
end

---@class SpriteVariationParameters
---@field icon string # The name of the icon to create variations for, e.g. "shot".
---@field variations integer # The number of variations to create.
---@field mod "angels"|"bobs"|"lib"|"compatibility" # The mod to source the icon from.
---@field group string # The group folder to source the icon from, e.g. "warfare".
---@field subgroup string? # The subgroup folder to source the icon from, e.g. "components".
---@field glows boolean? # Whether the icon glows. Default `false`.

---
---**Deprecated.**
---
---Replace this:
---```
---local parameters = {
---    icon = "sulfur",
---    variations = 8,
---    mod = "bobs",
---    group = "ores",
---    subgroup = "ores",
---    glows = true,
---}
---
---local sprite = reskins.lib.create_icon_variations(parameters)
---```
---With this:
---```
---local sprite = reskins.internal.create_sprite_variations("bobs", "ores/ores", "sulfur", 8, true)
---```
---@param parameters SpriteVariationParameters
---@return data.SpriteVariations[]
---@deprecated
function reskins.lib.create_icon_variations(parameters)
    local key = parameters.mod
    local subfolder = parameters.subgroup and parameters.group .. "/" .. parameters.subgroup or parameters.group
    local sprite_name = parameters.icon
    local num_variations = parameters.variations
    local is_light = parameters.glows

    return reskins.internal.create_sprite_variations(key, subfolder, sprite_name, num_variations, is_light)
end

---@deprecated Use `reskins.library.sprites.pipes.get_pipe` instead
function reskins.lib.pipe_pictures(inputs)
    ---@type PipeMaterialType
    local material_type = inputs.material
    if inputs.mod == "angels" and (not material_type:find("angels-")) then
        material_type = "angels-" .. inputs.material
    end

    return reskins.lib.sprites.pipes.get_pipe(material_type)
end

---@deprecated Use `reskins.library.sprites.pipes.get_pipe_to_ground` instead
function reskins.lib.underground_pipe_pictures(inputs)
    ---@type PipeMaterialType
    local material_type = inputs.material
    if inputs.mod == "angels" and (not material_type:find("angels-")) then
        material_type = "angels-" .. inputs.material
    end

    return reskins.lib.sprites.pipes.get_pipe_to_ground(material_type)
end

---@deprecated Use `reskins.library.sprites.pipes.get_pipe_covers` instead
function reskins.lib.pipe_covers(inputs)
    ---@type PipeMaterialType
    local material_type = inputs.material
    if inputs.mod == "angels" and (not material_type:find("angels-")) then
        material_type = "angels-" .. inputs.material
    end

    return reskins.lib.sprites.pipes.get_pipe_covers(material_type)
end

-- TRANSPORT BELT PICTURES
---@deprecated Use `reskins.lib.sprites.belts.get_belt_animation_set` instead.
function reskins.lib.transport_belt_animation_set(tint, variant)
    if variant == 1 then
        return reskins.lib.sprites.belts.get_belt_animation_set(reskins.lib.defines.belt_sprites.standard, tint)
    else
        return reskins.lib.sprites.belts.get_belt_animation_set(reskins.lib.defines.belt_sprites.express, tint)
    end
end

-- Connecting north/south oriented pipe shadow overlay
---@deprecated Use `reskins.lib.sprites.pipes.get_vertical_pipe_shadow(shift)` instead.
function reskins.lib.vertical_pipe_shadow(shift)
    return reskins.lib.sprites.pipes.get_vertical_pipe_shadow(shift)
end

---Creates icons from a list of prototypes, applying the given inputs and overrides.
---@param table CreateIconsFromListTable # A dictionary of `CreateIconsFromListOverrides` objects, keyed by the name of the prototype.
---@param inputs CreateIconsFromListInputs # The base inputs to apply to all icons.
---@deprecated # This will be removed in the future. Use `reskins.internal.create_icons_from_list` instead, which will require a rework.
function reskins.lib.create_icons_from_list(table, inputs)
    -- Setup input defaults
    reskins.lib.parse_inputs(inputs)

    for name, overrides in pairs(table) do
        -- Fetch the icon
        local icon_type = overrides.type or inputs.type or "item"
        local icon = data.raw[icon_type][name]

        -- Check if icon exists, if not, skip this iteration
        if not icon then goto continue end

        -- Work with a local copy of inputs
        ---@type CreateIconsFromListInputs
        local inputs_copy = util.copy(inputs)

        -- Handle input parameters
        inputs_copy.type = overrides.type or inputs_copy.type or nil
        inputs_copy.mod = overrides.mod or inputs_copy.mod
        inputs_copy.group = overrides.group or inputs_copy.group
        inputs_copy.icon_size = overrides.icon_size or inputs_copy.icon_size
        inputs_copy.icon_mipmaps = overrides.icon_mipmaps or inputs_copy.icon_mipmaps
        inputs_copy.technology_icon_size = overrides.technology_icon_size or inputs_copy.technology_icon_size
        inputs_copy.technology_icon_mipmaps = overrides.technology_icon_mipmaps or inputs_copy.technology_icon_mipmaps
        inputs_copy.subgroup = overrides.subgroup or inputs_copy.subgroup or nil

        -- Transcribe icon properties
        inputs_copy.technology_icon_layers = overrides.technology_icon_layers or inputs_copy.technology_icon_layers or nil
        inputs_copy.icon_layers = overrides.icon_layers or inputs_copy.icon_layers or nil
        inputs_copy.technology_icon_extras = overrides.technology_icon_extras or inputs_copy.technology_icon_extras or nil
        inputs_copy.icon_extras = overrides.icon_extras or inputs_copy.icon_extras or nil
        inputs_copy.icon_picture_extras = overrides.icon_picture_extras or inputs_copy.icon_picture_extras or nil

        -- Handle all the boolean overrides
        if overrides.make_icon_pictures == false then
            inputs_copy.make_icon_pictures = false
        else
            inputs_copy.make_icon_pictures = overrides.make_icon_pictures or inputs_copy.make_icon_pictures
        end

        if overrides.make_entity_pictures == false then
            inputs_copy.make_entity_pictures = false
        else
            inputs_copy.make_entity_pictures = overrides.make_entity_pictures or inputs_copy.make_entity_pictures
        end

        if overrides.defer_to_data_updates == false then
            inputs_copy.defer_to_data_updates = false
        else
            inputs_copy.defer_to_data_updates = overrides.defer_to_data_updates or inputs_copy.defer_to_data_updates
        end

        if overrides.defer_to_data_final_fixes == false then
            inputs_copy.defer_to_data_final_fixes = false
        else
            inputs_copy.defer_to_data_final_fixes = overrides.defer_to_data_final_fixes or inputs_copy.defer_to_data_final_fixes
        end

        -- Prevent double assignment
        if inputs_copy.defer_to_data_final_fixes then inputs_copy.defer_to_data_updates = nil end

        local flat_icon
        if overrides.flat_icon == false then
            flat_icon = false
        else
            flat_icon = overrides.flat_icon or inputs_copy.flat_icon
        end

        -- Construct the icon
        if flat_icon then
            -- Setup filename details
            local image = overrides.image or name
            local subfolder = inputs_copy.group
            if inputs_copy.subgroup then
                subfolder = inputs_copy.group .. "/" .. inputs_copy.subgroup
            end

            -- Make the icon
            if inputs_copy.type == "technology" then
                inputs_copy.technology_icon_filename = overrides.technology_icon_filename
                    or inputs_copy.technology_icon_filename
                    or reskins[inputs_copy.mod].directory .. "/graphics/technology/" .. subfolder .. "/" .. image .. ".png"

                reskins.lib.construct_technology_icon(name, inputs_copy)
            else
                inputs_copy.icon_filename = overrides.icon_filename
                    or inputs_copy.icon_filename
                    or reskins[inputs_copy.mod].directory .. "/graphics/icons/" .. subfolder .. "/" .. image .. ".png"

                reskins.lib.construct_icon(name, 0, inputs_copy)
            end
        else
            -- Handle tier
            local tier = overrides.tier or 0
            if reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map" then
                tier = overrides.prog_tier or overrides.tier or 0
            end

            -- Handle tints
            inputs_copy.tint = overrides.tint or inputs_copy.tint or reskins.lib.tiers.get_tint(tier)

            -- Adjust tint to belt-type if necessary
            if overrides.uses_belt_mask == true then
                inputs_copy.tint = reskins.lib.tiers.get_belt_tint(tier)
            end

            -- Handle icon_name and related parameters
            inputs_copy.icon_name = overrides.icon_name or inputs_copy.icon_name
            inputs_copy.icon_base = overrides.icon_base or inputs_copy.icon_base or nil
            inputs_copy.icon_mask = overrides.icon_mask or inputs_copy.icon_mask or nil
            inputs_copy.icon_highlights = overrides.icon_highlights or inputs_copy.icon_highlights or nil

            -- Make the icon
            if inputs_copy.type == "technology" then
                reskins.lib.construct_technology_icon(name, inputs_copy)
            else
                reskins.lib.construct_icon(name, tier, inputs_copy)
            end
        end

        -- Label to skip to next iteration
        ::continue::
    end
end