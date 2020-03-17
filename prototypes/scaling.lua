-- Copyright (c) 2020 Kirazy
-- Part of Reskins: Functions's Library
--     
-- See LICENSE.md in the project directory for license information.

-- local types =
-- {

-- }

-- local function rescale_layer(table, scale)

-- end

-- Keys we need to scale:
-- collision_box, may need to be handled manually?
-- damaged_trigger_effect.offset/offset_deviation
-- drawing_box
-- animation/n|e|s|w/layers/shift,scale
-- working_visualizations/north_position/etc
-- working_visualizations
-- shift = {x, y}
-- 

local fields = 
{
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

local ignored_fields =
{
    "fluid_boxes",
    "fluid_box",
    "energy_source",
    "input_fluid_box",
}

-- Import debug functions
local debug
if __DebugAdapter then
    debug = __DebugAdapter
end

-- ###########################################################
-- Scales values within object
local function scale(object, scale)
    -- Walk table and scale values contained within; assumes values will be numbers
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
    -- Assume object is a table
    elseif type(object) == "table" then
        -- Break reference, work on local copy
        object = table.deepcopy(object)
        -- Recursively call scale_subtable
        scale_subtable(object, scale)
        return object
    end
end
-- ###########################################################


local function rescale_entity(entity, inputs)
    for key, value in pairs(entity) do
        -- Check to see if we need to scale this key's value
        -- debug.print("Analyzing "..key)
        for n = 1, #fields do
            if fields[n] == key then
                entity[key] = scale(value, inputs.scale)
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
            rescale_entity(value, inputs)
        end

        -- Label to skip to next iteration
        ::continue::
    end
end


function reskins.lib.miniaturize_structure(name, inputs)
    -- Initialize paths
    local entity = table.deepcopy(data.raw[inputs.type][inputs.source])
    local item = table.deepcopy(data.raw["item"][inputs.source])
    local explosion = table.deepcopy(data.raw["explosion"][inputs.source.."-explosion"])
    local remnant = table.deepcopy(data.raw["corpse"][inputs.source.."-remnants"])

    -- Duplicate
    if item then
        item.name = name
        item.place_result = name
        data:extend({item})
    end

    if remnant then
        remnant.name = name.."-remnants"
        entity.corpse = remnant.name
        data:extend({remnant})
    end

    if explosion then
        explosion.name = name.."-explosion"
        entity.dying_explosion = explosion.name
        data:extend({explosion})
    end

    if entity then
        -- Handle some small things
        entity.name = name
        entity.drawing_box = nil
        entity.next_upgrade = nil

        -- Rescale the structure
        rescale_entity(entity, inputs)

        -- Handle fluid_box/fluid_boxes/energy_source
        if entity.fluid_boxes then
            if string.match(entity.name, "assembler") then
                entity.fluid_boxes[1].pipe_connections = {{ type="input", position = {0.5, -1.5} }}
                entity.fluid_boxes[2].pipe_connections = {{ type="output", position = {0.5, 1.5} }}
            end
            if string.match(entity.name, "refinery") then
                entity.fluid_boxes[1].pipe_connections = {{ type="input", position = {-1, 2} }}
                entity.fluid_boxes[2].pipe_connections = {{ type="input", position = {1, 2} }}
                entity.fluid_boxes[3].pipe_connections = {{ type="output", position = {-1, -2} }}
                entity.fluid_boxes[4].pipe_connections = {{ type="output", position = {0, -2} }}
                entity.fluid_boxes[5].pipe_connections = {{ type="output", position = {1, -2} }}
            end
            if string.match(entity.name, "chemplant") then
                entity.fluid_boxes[1].pipe_connections = {{ type="input", position = {-0.5, -1.5} }}
                entity.fluid_boxes[2].pipe_connections = {{ type="input", position = {0.5, -1.5} }}
                entity.fluid_boxes[3].pipe_connections = {{ type="output", position = {-0.5, 1.5} }}
                entity.fluid_boxes[4].pipe_connections = {{ type="output", position = {0.5, 1.5} }}
            end
            if string.match(entity.name, "electro") then
                entity.fluid_boxes[1].pipe_connections = {{ type="input", position = {-0.5, -1.5} }}
                entity.fluid_boxes[2].pipe_connections = {{ type="input", position = {0.5, -1.5} }}
                entity.fluid_boxes[3].pipe_connections = {{ type="output", position = {-0.5, 1.5} }}
                entity.fluid_boxes[4].pipe_connections = {{ type="output", position = {0.5, 1.5} }}
            end
            if string.match(entity.name, "bobmetal") then
                entity.fluid_boxes[1].pipe_connections = {{ type="input", position = {0.5, -1.5} }}
                entity.fluid_boxes[2].pipe_connections = {{ type="output", position = {0.5, 1.5} }}
            end
            if string.match(entity.name, "bobchem") then
                entity.fluid_boxes[1].pipe_connections = {{ type="input-output", position = {0.5, -1.5} }}
            end
            if string.match(entity.name, "bobmulti") then
                entity.fluid_boxes[1].pipe_connections = {{ type="input-output", position = {0.5, -1.5} }}
            end
        end
        if entity.input_fluid_box then
            entity.input_fluid_box.pipe_connections = 
              {
                { position = {-1.25, 0} },
                { position = {1.25, 0} },
                { position = {0, 1.25} },
              }
        end
        if entity.fluid_box then
            entity.fluid_box.base_area = (entity.fluid_box.base_area / 2)
            if entity.fluid_box.pipe_connections[1] then
                entity.fluid_box.pipe_connections[1].position = {-0.5,-1.5}
                entity.fluid_box.pipe_connections[2].position = {1.5,0.5}
                entity.fluid_box.pipe_connections[3].position = {0.5,1.5}
                entity.fluid_box.pipe_connections[4].position = {-1.5,-0.5}
                if entity.fluid_box.pipe_connections[5] then
                    entity.fluid_box.pipe_connections[5].position = {0.5,-1.5}
                    entity.fluid_box.pipe_connections[6].position = {1.5,-0.5}
                    entity.fluid_box.pipe_connections[7].position = {-1.5,0.5}
                    entity.fluid_box.pipe_connections[8].position = {-0.5,1.5}
                end
            end
        end

        if entity.energy_source then
            if entity.energy_source.type == "heat" then
                if string.match(entity.name,"assembler") then
                    if entity.energy_source.connections[1] then
                        entity.energy_source.connections[1].position = {0.5, 0}
                    end
                    if entity.energy_source.connections[2] then
                        entity.energy_source.connections[2].position = {-0.5, 0}
                    end
                    if entity.energy_source.connections[3] then
                        entity.energy_source.connections[3].position = {0, -0.5}
                        entity.energy_source.connections[4].position = {0, 0.5}
                    end
                elseif string.match(entity.name,"miner") then
                    entity.energy_source.connections[1].position = {0, 0.5}
                    entity.energy_source.connections[2].position = {0.5, 0}
                    entity.energy_source.connections[3].position = {-0.5, 0}
                end
            end
        end

        data:extend({entity})
    end
end

-- Create test entities
local test_entities = 
{
    ["reskin-test-refinery"] = {"oil-refinery", "assembling-machine", 3, 5},
    ["reskin-test-assembler"] = {"assembling-machine-6", "assembling-machine"},
    ["reskin-test-chemplant"] = {"chemical-plant", "assembling-machine"},
    ["reskin-test-electrolyzer"] = {"electrolyzer", "assembling-machine"},
    ["reskin-test-radar"] = {"radar", "radar"},
    ["reskin-test-furnace"] = {"electric-furnace", "furnace"},
    ["reskin-test-miner"] = {"electric-mining-drill","mining-drill"},
    ["reskin-test-storage-tank"] = {"storage-tank","storage-tank"}
}

for name, map in pairs(test_entities) do
    inputs = {}
    inputs.source = map[1]              -- Source entity we're shrinking
    inputs.type = map[2]                -- Type of entity
    if map[3] and map[4] then
        inputs.scale = map[3]/map[4]    -- Scaling ratio (#tiles_new/#tiles_old)
    else
        inputs.scale = 2/3
    end


    reskins.lib.miniaturize_structure(name, inputs)
end



-- debug.print("Starting test")
-- local entity = {
--     collision_box = {{-1.2, -1.2},{-1.2, -1.2}},
--     shift = {-1.2, 1.2},
--     scale = 1,
-- }

-- entity.collision_box = scale(entity.collision_box, 0.5)
-- entity.shift = scale(entity.shift, 0.75)

-- debug.print("Test concluded")


-- for key, value in pairs(table) do
--     if type(value) == "table" then
--         deep_replace(value, search_for, replacement)
--     else
--         table[key] = value:gsub(search_for, replacement)
--     end
-- end

-- Example of recursive table edit function
-- local function deep_replace(table, search_for, replacement)
--     if not table then return end

--     for key, value in pairs(table) do
--         if type(value) == "table" then
--             deep_replace(value, search_for, replacement)
--         else
--             table[key] = value:gsub(search_for, replacement)
--         end
--     end
-- end








-- -- Rescales a value or a list of values by the specified factor
-- local function shrink(object, scale)
--     if type(object) == "table" then
--         for key, value in pairs(object) do
--             object[key] = scale*value
--         end
--         return object
--     else
--         return object*scale
--     end
-- end

-- -- Transcribes properties from a given object, and shrinks the appropriate values
-- local function rescale_layer(object, scale)
--     local layer = 
--     {
--         filename           = object.filename,
--         priority           = object.priority,
--         x                  = object.x,
--         y                  = object.y,
--         width              = object.width,
--         height             = object.height,
--         frame_count        = object.frame_count,
--         line_length        = object.line_length,
--         repeat_count       = object.repeat_count,
--         shift              = shrink(object.shift, scale),
--         draw_as_shadow     = object.draw_as_shadow,
--         force_hr_shadow    = object.force_hr_shadow,
--         apply_runtime_tint = object.apply_runtime_tint,
--         scale              = shrink(object.scale, scale),
--         tint               = object.tint,
--         blend_mode         = object.blend_mode
--     }
--     return layer   
-- end

-- local function rescale_layer_hr(object, scale)
--     local layer = rescale_layer(object, scale)
--     if object.hr_version and object.hr_version.filename then
--         layer.hr_version = rescale_layer(object.hr_version, scale)
--     end
--     return layer
-- end

-- -- Reduce a given prototype definition, e.g. animations or pictures
-- function reskins.lib.entity_reduce(prototype, scale)
--     local cardinal = {"north","east","south","west"}

--     -- Iterate through the prototype
--     for key, value in pairs(prototype) do
--         -- Check for and reduce cardinal directions
--         for n = 1, #cardinal do
--             if cardinal[n] == key then
--                 -- We have cardinal directions, check for layers
--                 if prototype[cardinal[n]].layers then
--                     -- We have layers, transcribe and shrink
--                     for m = 1, #prototype[cardinal[n]].layers do
--                         prototype[cardinal[n]].layers[m] = rescale_layer_hr()



--     -- Check for directions with layers
--     if prototype.north.layers then

--     elseif prototype.north 
    
    -- --         end
      
-- --         local function make_animation_layer_with_hr_version(idx, anim)
-- --           local anim_parameters = make_animation_layer(idx, anim)
-- --           if anim.hr_version and anim.hr_version.filename then
-- --             anim_parameters.hr_version = make_animation_layer(idx, anim.hr_version)
-- --           end
-- --           return anim_parameters
-- --         end
      
-- --         local function make_animation(idx)
-- --           if animation.layers then
-- --             local tab = { layers = {} }
-- --             for k,v in ipairs(animation.layers) do
-- --               table.insert(tab.layers, make_animation_layer_with_hr_version(idx, v))
-- --             end
-- --             return tab
-- --           else
-- --             return make_animation_layer_with_hr_version(idx, animation)
-- --           end
-- --         end
      
-- --         return
-- --         {
-- --           north = make_animation(0),
-- --           east = make_animation(1),
-- --           south = make_animation(2),
-- --           west = make_animation(3)
-- --         }
-- --       end