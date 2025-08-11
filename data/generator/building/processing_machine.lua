local BuildingAnimation = require("core.animation")
local VOLTAGE_FUEL_VALUES = require("data.constants").VOLTAGE_FUEL_VALUES
local generate_recipe_group = require("data.generator.group.recipe_group")

local function get_machine_base_sprite(machine)
    local layers = {}
    -- original machine.name is machine_voltage-machine_name, so we need to split it
    local m_volt = machine.name:match("^(%w+)-")
    local m_name = machine.name:match("-(%w+)$")
    table.insert(layers, {
        icon = "__hogtorio__/graphics/buildings/processing_machine/base_voltage/" .. m_volt .. "/side.png",
        icon_size = machine.icon_size or 16,
        scale = machine.icon_scale or 1,
    })
    table.insert(layers, {
        icon = "__hogtorio__/graphics/buildings/processing_machine/machine/" .. m_name .. "/overlay_front.png",
        icon_size = machine.icon_size or 16,
        scale = machine.icon_scale or 1,
    })
    return layers
end

local function get_fluidboxes(machine)
    local boxes = {}
    for _, box in ipairs(machine.fluid_boxes or {}) do
        local connection = {}
        for _, pos in ipairs(box.pipe_connections or {}) do
            table.insert(connection, {
                flow_direction = pos.flow_direction or "input-output",
                direction = pos.direction or defines.direction.north,
                position = {
                    (machine.width - pos.position.x) / 2 - 0.5,
                    (machine.height - pos.position.y) / 2 - 0.5
                }
            })
        end
        table.insert(boxes, {
            production_type = box.production_type or "input-output",
            pipe_covers = pipecoverspictures(),
            pipe_picture = assembler2pipepictures(),
            pipe_connections = connection
        })
    end
    return boxes
end

local function get_machine_fuelbox(machine)
    return {
        production_type = "input-output",
        pipe_covers = pipecoverspictures(),
            pipe_picture = assembler2pipepictures(),
            volume = machine.power_buffer or 100,
            pipe_connections = {
                {
                    flow_direction = "input-output",
                    direction = defines.direction.north,
                    position = {0, -machine.height / 2 + 0.5}
                }, {
                    flow_direction = "input-output",
                    direction = defines.direction.south,
                    position = {0, machine.height / 2 - 0.5}
                }
            },
            filter = "voltage-" .. machine.voltage,
        }
end

local function get_machine_collision_box(machine)
    -- Assuming machine.width, height in tiles
    local x = machine.width / 2
    local y = machine.height / 2
    local squeeze_space = machine.squeeze_space or 0.05

    return {
        collision_box = machine.collision_box or {{-x + squeeze_space, -y + squeeze_space}, {x - squeeze_space, y - squeeze_space}},
        selection_box = machine.selection_box or {{-x - squeeze_space, -y - squeeze_space}, {x + squeeze_space, y + squeeze_space}},
    }
end

local function get_graphics_set(machine)
    local build_anim = BuildingAnimation:new(machine.name)
    for _, state in ipairs(machine.states) do
        build_anim:add_state(state)
    end
    return build_anim:get_graphics({
        machine.animation_progress or 0,
    })
end

local function generate(machine)
    -- Default category
    generate_recipe_group({
        name = machine.name,
        order = machine.order or "a",
        localised_name = machine.localised_name or "Processing Machine: " .. machine.name,
    })
    local m_volt = machine.name:match("^(%w+)-")
    local m_volt_upper = string.upper(m_volt)
    local machine_item = {
        type = "item",
        name = machine.name,
        localised_name = m_volt_upper .. " " .. machine.locale_name,
        icons = get_machine_base_sprite(machine),
        subgroup = "processing-machines-" .. machine.voltage,
        order = machine.order or "a",
        place_result = machine.name,
        stack_size = 64
    }
    local collision = get_machine_collision_box(machine)
    local total_categories = {machine.name}
    -- extend total_categories with custom ones from machine
    for _, category in ipairs(machine.custom_recipe_categories or {}) do
        table.insert(total_categories, category)
    end
    local machine_entity = {
        type = "assembling-machine",
        name = machine.name,
        localised_name = m_volt_upper .. " " .. machine.locale_name,
        icons = get_machine_base_sprite(machine),
        minable = {mining_time = machine.mining_time or 1, result = machine.name},
        max_health = machine.health or 200,
        corpse = machine.remnants or "medium-remnants",
        collision_box = collision.collision_box,
        selection_box = collision.selection_box,
        crafting_categories = total_categories,
        crafting_speed = machine.speed or 1,
        energy_usage = VOLTAGE_FUEL_VALUES:get_consumption(machine.voltage),
        energy_source = {
            type = "fluid",
            fluid_box = get_machine_fuelbox(machine),
            burns_fluid = true,
            scale_fluid_usage = true,
        },
        graphics_set = get_graphics_set(machine),
        fluid_boxes = get_fluidboxes(machine),
    }
    data:extend({machine_item, machine_entity})
    if contains(get_keys(machine.recipe), m_volt) then
        local recipe = machine.recipe[m_volt]
        local ingredients = {}
        for _, ingredient in ipairs(recipe.ingredients) do
            table.insert(ingredients, {
                type = "item",
                name = ingredient[1],
                amount = ingredient[2] or 1
            })
        end
        local recipe = {
            type = "recipe",
            name = recipe.name or machine.name,
            category = recipe.category or "crafting",
            subgroup = "processing-machines-" .. machine.voltage,
            order = machine.order or "a",
            energy_required = recipe.energy_required or 1,
            ingredients = ingredients,
            results = {
                {
                    type = "item",
                    name = machine.name,
                    amount = 1
                }
            },
        }
        data:extend { recipe }
    end
end

return generate