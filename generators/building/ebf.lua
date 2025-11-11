local BuildingAnimation = require("core.animation")
local VOLTAGE_FUEL_VALUES = require("constants").VOLTAGE_FUEL_VALUES
local generate_recipe_group = require("generators.group.recipe_group")

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
    local pipe_con_position
    if not machine.horizontal_energy_hatch then
        pipe_con_position = { 0, machine.height / 2 - 0.5 }
    else
        pipe_con_position = { machine.width / 2 - 0.5, 0 }
    end
    local fboxes = {
        production_type = "input-output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = assembler2pipepictures(),
        volume = machine.power_buffer or 100,
        pipe_connections = {
            {
                flow_direction = "input-output",
                direction = defines.direction.north,
                position = { -pipe_con_position[1], -pipe_con_position[2] }
            }, {
            flow_direction = "input-output",
            direction = defines.direction.south,
            position = pipe_con_position
        }
        },
    }
    return fboxes
end

local function get_machine_collision_box(machine)
    -- Assuming machine.width, height in tiles
    local x = machine.width / 2
    local y = machine.height / 2
    local squeeze_space = machine.squeeze_space or 0.05

    return {
        collision_box = machine.collision_box or
        { { -x + squeeze_space, -y + squeeze_space }, { x - squeeze_space, y - squeeze_space } },
        selection_box = machine.selection_box or
        { { -x - squeeze_space, -y - squeeze_space }, { x + squeeze_space, y + squeeze_space } },
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
        order = machine.order or machine.name,
        localised_name = machine.localised_name
    })

    local machine_item = {
        type = "item",
        name = machine.name,
        localised_name = machine.localised_name,
        icons = machine.icons,
        subgroup = machine.subgroup,
        order = machine.order or machine.name or "a",
        place_result = machine.name,
        stack_size = 64
    }
    local collision = get_machine_collision_box(machine)
    local total_categories = { machine.name }
    -- extend total_categories with custom ones from machine
    for _, category in ipairs(machine.custom_recipe_categories or {}) do
        table.insert(total_categories, category)
    end
    local energ_usage
    energ_usage = VOLTAGE_FUEL_VALUES:multiplier(machine.voltage, 2)

    local machine_entity = {
        type = "assembling-machine",
        name = machine.name,
        localised_name = machine.localised_name,
        icons = machine.icons,
        minable = { mining_time = machine.mining_time or 1, result = machine.name },
        max_health = machine.health or 200,
        fast_replaceable_group = "replaceable_ebf",
        corpse = machine.remnants or "medium-remnants",
        collision_box = collision.collision_box,
        selection_box = collision.selection_box,
        crafting_categories = total_categories,
        crafting_speed = machine.speed or 1,
        energy_usage = energ_usage,
        energy_source = {
            type = "fluid",
            fluid_box = get_machine_fuelbox(machine),
            burns_fluid = true,
            scale_fluid_usage = true,
        },
        graphics_set = get_graphics_set(machine),
        fluid_boxes = get_fluidboxes(machine),
    }
    data:extend({ machine_item, machine_entity })

    local recipe = {
        type = "recipe",
        name = machine.name,
        category = machine.recipe.category or "crafting",
        subgroup = machine.subgroup,
        order = machine.order or "a",
        energy_required = machine.recipe.energy_required or 1,
        ingredients = machine.recipe.ingredients,
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

return generate
