-- Copyright (c) 2020 Kirazy
-- Part of Artisanal Reskins: Core Library
--     
-- See LICENSE.md in the project directory for license information.

-- Make our function host
if not reskins then reskins = {} end
if not reskins.lib then reskins.lib = {} end

-- Library directory
reskins.lib.directory = "__reskins-library__"

-- Most entities have a common process for reskinning, so consolidate the other functions under one superfunction for ease of use
function reskins.lib.setup_standard_entity(name, tier, inputs)
    -- Parse inputs
    reskins.lib.parse_inputs(inputs)    
    
    -- Create particles and explosions   
    if inputs.make_explosions == true then   
        reskins.lib.create_explosions_and_particles(name, inputs)
    end
  
    -- Create remnants
    if inputs.make_remnants == true then
        reskins.lib.create_remnant(name, inputs)
    end

    -- Create icons
    if inputs.make_icons == true then
        if inputs.make_masked_icon == true then
            reskins.lib.setup_masked_icon(name, tier, inputs)
        else
            reskins.lib.setup_standard_icon(name, tier, inputs)
        end
    end
end

function reskins.lib.setup_standard_icon(name, tier, inputs)
    -- Inputs required by this function
    -- group            - Mod/category folder within the graphics/icons folder
    -- subgroup         - Folder nested within group
    -- icon_name        - Folder containing the icon files, and the assumed icon file prefix

    -- Optional inputs, used when each entity being fed to this function has unique base or mask images
    -- icon_base        - Prefix for the icon-base.png file
    -- icon_mask        - Prefix for the icon-mask.png file
    -- icon_highlights  - Prefix for the icon-highlights.png file

    -- Handle compatibility
    local folder_path = inputs.group
    if inputs.subgroup then
        folder_path = inputs.group.."/"..inputs.subgroup
    end

    -- Some entities have variable bases and masks
    local base = inputs.icon_base or inputs.icon_name
    local mask = inputs.icon_mask or inputs.icon_name
    local highlights = inputs.icon_highlights or inputs.icon_name
    
    -- Setup standard icon
    inputs.icon = {        
        -- Base
        {
            icon = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..base.."-icon-base.png"
        },
        -- Mask
        {
            icon = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..mask.."-icon-mask.png",
            tint = inputs.tint
        },
        -- Highlights
        {
            icon = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..highlights.."-icon-highlights.png",
            tint = {1,1,1,0}
        }
    }
    
    -- Setup item picture
    inputs.icon_picture = {
        layers = {
            -- Base
            {
                filename = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..base.."-icon-base.png",
                size = inputs.icon_size,
                mipmaps = inputs.icon_mipmaps,
                scale = 0.25
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..mask.."-icon-mask.png",
                size = inputs.icon_size,
                mipmaps = inputs.icon_mipmaps,
                scale = 0.25,
                tint = inputs.tint
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..highlights.."-icon-highlights.png",
                size = inputs.icon_size,
                mipmaps = inputs.icon_mipmaps,
                scale = 0.25,
                blend_mode = "additive"
            }
        }
    }

    -- Extra layers
    if inputs.icon_extras then
        for n = 1, #inputs.icon_extras do
            table.insert(inputs.icon, inputs.icon_extras[n])
        end
    end

    if inputs.icon_picture_extras then
        for n = 1, #inputs.icon_picture_extras do
            table.insert(inputs.icon_picture.layers, inputs.icon_picture_extras[n])
        end
    end

    -- Append tier labels
    reskins.lib.append_tier_labels(tier, inputs)
    
    -- Assign icons
    reskins.lib.assign_icons(name, inputs)
end

-- Tint icons that use a base and a mask
function reskins.lib.setup_masked_icon(name, tier, inputs)
    -- Inputs required by this function
    -- group            - Folder
    -- subgroup         - Folder contained within group
    -- icon_name        - Folder containing the icon files, and the assumed icon file prefix

    -- Optional inputs, used when each entity being fed to this function has unique base or mask images
    -- icon_base        - Prefix for the icon-base.png file
    -- icon_mask        - Prefix for the icon-mask.png file

    -- Handle compatibility
    local folder_path = inputs.group
    if inputs.subgroup then
        folder_path = inputs.group.."/"..inputs.subgroup
    end

    -- Some entities have variable bases and masks
    local base = inputs.icon_base or inputs.icon_name
    local mask = inputs.icon_mask or inputs.icon_name


    -- Setup standard icon
    inputs.icon = {        
        -- Base
        {
            icon = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..base.."-icon-base.png"
        },
        -- Mask
        {
            icon = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..mask.."-icon-mask.png",
            tint = inputs.tint
        }
    }
    
    -- Setup item picture
    inputs.icon_picture = {
        layers = {
            -- Base
            {
                filename = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..base.."-icon-base.png",
                size = inputs.icon_size,
                mipmaps = inputs.icon_mipmaps,
                scale = 0.25
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/icons/"..folder_path.."/"..inputs.icon_name.."/"..mask.."-icon-mask.png",
                size = inputs.icon_size,
                mipmaps = inputs.icon_mipmaps,
                scale = 0.25,
                tint = inputs.tint
            }
        }
    }

    -- Append tier labels
    if settings.startup["reskins-bobs-do-belt-entity-tier-labeling"].value == true then
        inputs.tier_labels = (inputs.tier_labels ~= false)
    else
        inputs.tier_labels = inputs.tier_labels or false
    end

    reskins.lib.append_tier_labels(tier, inputs)
    
    -- Assign icons
    reskins.lib.assign_icons(name, inputs)
end

function reskins.lib.setup_flat_icon(name, icon_tier, filename, inputs)
    -- Parse parameters
    local size = inputs.icon_size or 64
    local mipmaps = inputs.icon_mipmaps or 4

    -- Setup icon
    inputs.icon = filename
    inputs.tier_labels = (inputs.tier_labels ~= false)

    if icon_tier ~= false then
        local tier
        if settings.startup["reskins-lib-tier-mapping"].value == "name-map" then 
            tier = icon_tier[1]
        else 
            tier = icon_tier[2]
            inputs.icon_picture = {filename = filename, size = size, mipmaps = mipmaps, scale = 0.25}
            inputs.icon = {{ icon = inputs.icon }}
        end

        reskins.lib.append_tier_labels(tier, inputs)
    end

    reskins.lib.assign_icons(name, inputs)
end

-- Parses the main inputs table of parameters
function reskins.lib.parse_inputs(inputs)
    -- Check that we have a particles table
    if not inputs.particles then
        inputs.make_explosions = false
    end
    
    -- Constructs defaults for optional input parameters.
    inputs.icon_size       = inputs.icon_size        or 64      -- Pixel size of icons
    inputs.icon_mipmaps    = inputs.icon_mipmaps     or 4       -- Number of mipmaps present in the icon image file       
    inputs.make_explosions = (inputs.make_explosions ~= false)  -- Create explosions; default true
    inputs.make_remnants   = (inputs.make_remnants   ~= false)  -- Create remnant; default true
    inputs.make_icons      = (inputs.make_icons      ~= false)  -- Create icons; default true
    inputs.tier_labels     = (inputs.tier_labels     ~= false)  -- Append tier labels; default true

    return inputs
end

-- Insert tier label icon entries to a given icon definition
function reskins.lib.append_tier_labels(tier, inputs)
    -- Inputs required by this function
    -- icon             - Table containing an icon/icons definition

    -- Setup icon with tier label
    if settings.startup["reskins-lib-icon-tier-labeling"].value == true and tier > 0 and inputs.tier_labels == true then
        icon_style = settings.startup["reskins-lib-icon-tier-labeling-style"].value
        table.insert(inputs.icon, {icon = reskins.lib.directory.."/graphics/icons/tiers/"..icon_style.."/"..tier..".png"})
        table.insert(inputs.icon, {
            icon = reskins.lib.directory.."/graphics/icons/tiers/"..icon_style.."/"..tier..".png",
            tint = reskins.lib.adjust_alpha(reskins.lib.tint_index["tier-"..tier], 0.75)
        })
    end
end

function reskins.lib.append_tier_labels_to_vanilla_icon(name, tier, inputs)
    -- Inputs required by this function
    -- type            - Entity type

    -- Prevent cross-contamination
    local inputs = table.deepcopy(inputs)

    -- Handle required parameters
    reskins.lib.parse_inputs(inputs)

    -- Fetch the icon; vanilla icons are strictly an icon definition
    inputs.icon = {
        {
            icon = data.raw["item"][name].icon
        }
    }

    reskins.lib.append_tier_labels(tier, inputs)

    inputs.icon_picture = {
        {
            filename = data.raw["item"][name].icon,
            size = 64,
            scale = 0.25,
            mipmaps = 4
        }
    }

    reskins.lib.assign_icons(name, inputs)
end


function reskins.lib.assign_order(name, inputs)
    -- Inputs required by this function
    -- type
    -- sort_order
    -- sort_group
    -- sort_subgroup

    -- Initialize paths
    local entity
    if inputs.type then
        entity = data.raw[inputs.type][name]
    end
    local item = data.raw["item"][name]
    local explosion = data.raw["explosion"][name.."-explosion"]
    local remnant = data.raw["corpse"][name.."-remnants"]

    if entity then
        entity.order = inputs.sort_order
        entity.group = inputs.sort_group
        entity.subgroup = inputs.sort_subgroup
    end

    if item then
        item.order = inputs.sort_order
        item.group = inputs.sort_group
        item.subgroup = inputs.sort_subgroup
    end

    if explosion then
        explosion.order = inputs.sort_order
        explosion.group = inputs.sort_group
        explosion.subgroup = inputs.sort_subgroup
    end

    if remnant then
        remnant.order = inputs.sort_order
        remnant.group = inputs.sort_group
        remnant.subgroup = inputs.sort_subgroup
    end
end


function reskins.lib.assign_icons(name, inputs)
    -- Inputs required by this function
    -- type            - Entity type
    -- icon            - Table or string defining icon
    -- icon_size       - Pixel size of icons
    -- icon_mipmaps    - Number of mipmaps present in the icon image file

    -- Initialize paths
    local entity
    if inputs.type then
        entity = data.raw[inputs.type][name]
    end
    local item = data.raw["item"][name]
    local explosion = data.raw["explosion"][name.."-explosion"]
    local remnant = data.raw["corpse"][name.."-remnants"]

    -- Check whether icon or icons, ensure the key we're not using is erased
    if type(inputs.icon) == "table" then
        -- Create icons that have multiple layers
        if entity then
            entity.icon = nil        
            entity.icons = inputs.icon
            if inputs.make_entity_pictures then
                entity.pictures = inputs.icon_picture
            end
        end

        if item then
            item.icon = nil
            item.icons = inputs.icon
            if inputs.icon_picture then
                item.pictures = inputs.icon_picture
            end
        end

        if explosion then 
            explosion.icon = nil        
            explosion.icons = inputs.icon
        end

        if remnant then
            remnant.icon = nil
            remnant.icons = inputs.icon
        end
    else
        -- Create icons that do not have multiple layers
        if entity then
            entity.icons = nil
            entity.icon = inputs.icon
        end

        if item then
            item.icons = nil        
            item.icon = inputs.icon
            if inputs.icon_picture then
                item.pictures = inputs.icon_picture
            end
        end

        if explosion then
            explosion.icons = nil        
            explosion.icon = inputs.icon
        end

        if remnant then
            remnant.icons = nil
            remnant.icon = inputs.icon
        end
    end

    -- Make assignments common to all cases
    if entity then
        entity.icon_size = inputs.icon_size
        entity.icon_mipmaps = inputs.icon_mipmaps          
    end

    if item then
        item.icon_size = inputs.icon_size
        item.icon_mipmaps = inputs.icon_mipmaps 
    end

    if explosion then
        explosion.icon_size = inputs.icon_size
        explosion.icon_mipmaps = inputs.icon_mipmaps
    end
    
    if remnant then
        remnant.icon_size = inputs.icon_size
        remnant.icon_mipmaps = inputs.icon_mipmaps
    end
end

-- Create remnant entity; reskin the remnant after calling this function
function reskins.lib.create_remnant(name, inputs)
    -- Inputs required by this function:
    -- base_entity - Entity to copy remnant prototype from
    -- type        - Entity type

    -- Copy remnant prototype
    local remnant = table.deepcopy(data.raw["corpse"][inputs.base_entity.."-remnants"])
    remnant.name = name.."-remnants"
    data:extend({remnant})      

    -- Assign corpse to originating entity
    data.raw[inputs.type][name]["corpse"] = remnant.name
end

-- Create explosion entity; create particles after calling this function
function reskins.lib.create_explosion(name, inputs)
    -- Inputs required by this function:
    -- base_entity - Entity to copy explosion prototype from
    -- type        - Entity type

    local explosion = table.deepcopy(data.raw["explosion"][inputs.base_entity.."-explosion"])
    explosion.name = name.."-explosion"
    data:extend({explosion})

    -- Assign explosion to originating entity
    data.raw[inputs.type][name]["dying_explosion"] = explosion.name
end

-- Create tinted particle
function reskins.lib.create_particle(name, base_entity, base_particle, key, tint)
    -- Copy the particle prototype
    local particle = table.deepcopy(data.raw["optimized-particle"][base_entity.."-"..base_particle])
    particle.name = name.."-"..base_particle.."-tinted"
    particle.pictures.sheet.tint = tint
    particle.pictures.sheet.hr_version.tint = tint
    data:extend({particle})

    -- Assign particle to originating explosion
    data.raw["explosion"][name.."-explosion"]["created_effect"]["action_delivery"]["target_effects"][key].particle_name = particle.name
end

-- Batch the explosion and particle function together for ease of use
function reskins.lib.create_explosions_and_particles(name, inputs)
    -- Inputs required by this function:
    -- base_entity - Entity to copy explosion prototype from
    -- type        - Entity type
    -- tint        - Particle color

    -- Create explosions and related particles
    reskins.lib.create_explosion(name, inputs)
        
    -- Create and assign needed particles with appropriate tints
    for particle, key in pairs(inputs.particles) do 
        -- Create and assign the particle
        reskins.lib.create_particle(name, inputs.base_entity, reskins.lib.particle_index[particle], key, inputs.tint)
    end
end

-- Adjust the alpha value of a given tint
function reskins.lib.adjust_alpha(tint, alpha)
    adjusted_tint = {r = tint.r, g = tint.g, b = tint.b, a = alpha}
    return adjusted_tint
end

-- Shift the rgb values of a given tint by shift amount, and optionally adjust the alpha value
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

-- This function prepares a given tint for entities that use a base and mask layer instead of a base, mask, and highlights layer
-- Primarily this means belt-related entities
function reskins.lib.belt_mask_tint(tint)
    -- Define correction constants
    local color_shift = 40/255
    local alpha = 0.82

    -- Color correct the tint
    belt_mask_tint = reskins.lib.adjust_tint(tint, color_shift, alpha)

    return belt_mask_tint
end

if settings.startup["reskins-lib-customize-tier-colors"].value == true then
    reskins.lib.tint_index =
    {
        ["tier-0"] = util.color(settings.startup["reskins-lib-custom-colors-tier-0"].value),
        ["tier-1"] = util.color(settings.startup["reskins-lib-custom-colors-tier-1"].value),
        ["tier-2"] = util.color(settings.startup["reskins-lib-custom-colors-tier-2"].value),
        ["tier-3"] = util.color(settings.startup["reskins-lib-custom-colors-tier-3"].value),
        ["tier-4"] = util.color(settings.startup["reskins-lib-custom-colors-tier-4"].value),
        ["tier-5"] = util.color(settings.startup["reskins-lib-custom-colors-tier-5"].value),
    }
else
    reskins.lib.tint_index =
    {
        ["tier-0"] = util.color("4d4d4d"),
        ["tier-1"] = util.color("de9400"),
        ["tier-2"] = util.color("c20600"),
        ["tier-3"] = util.color("1b87c2"),
        ["tier-4"] = util.color("a600bf"),
        ["tier-5"] = util.color("23de55"),
    }
end

reskins.lib.particle_index = 
{
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

local fields = {
    "shift", 
    "scale", 
    "collision_box",
    "selection_box",
    "north_position", 
    "south_position", 
    "east_position", 
    "west_position",
    "window_bounding_box",
    "circuit_wire_connection_points",
}

local ignored_fields ={
    "fluid_boxes",
    "fluid_box",
    "energy_source",
    "input_fluid_box",
}

function reskins.lib.scale(object, scale)
    -- Walk table and scale values contained within
    local function scale_subtable(object, scale)
        for key, value in pairs(object) do
            if type(value) == "table" then
                scale_subtable(value, scale)
            elseif type(value) == "number" then
                object[key] = value*scale
            end
        end
    end

    -- Check if we're a number
    if type(object) == "number" then
        return object*scale
    -- Object is a table
    elseif type(object) == "table" then
        -- Break reference, work on local copy
        object = table.deepcopy(object)
        -- Recursively call scale_subtable
        scale_subtable(object, scale)
        return object
    end
end

function reskins.lib.rescale_entity(entity, scalar)
	for key, value in pairs(entity) do
		-- This section checks to see where we are, and for the existence of scale.
		-- Scale is defined if it is missing where it should be present.

		-- This checks to see if we're within an hr_version table
		if key == "hr_version" then
			entity.scale = entity.scale or 0.5
		-- If we're not, see if there's a filename, which means we're in a low-res table
		elseif entity.filename then
			entity.scale = entity.scale or 1
		end

        -- Check to see if we need to scale this key's value
        for n = 1, #fields do
            if fields[n] == key then
                entity[key] = reskins.lib.scale(value, scalar)
                -- Move to the next key rather than digging down further
                goto continue
            end
        end

        -- Check to see if we need to ignore this key
        for n = 1, #ignored_fields do
            if ignored_fields[n] == key then
                -- Move to the next key rather than digging down further
                goto continue
            end
        end

        if(type(value) == "table") then
            reskins.lib.rescale_entity(value, scalar)
        end

        -- Label to skip to next iteration
        ::continue::
    end
end