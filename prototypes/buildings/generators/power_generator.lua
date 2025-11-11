

data:extend({
    {
        type = "item",
        name = "power_generator",
        localised_name = "Test Power Generator",
        stack_size = 10,
        icon = "__hogtorio__/graphics/buildings/power-generator/sprite.png",
        place_result = "power_generator",
    },
    {
        type = "recipe",
        name = "power_generator",
        category = "crafting",
        energy_required = 5,
        ingredients = {
            {type = "item", name = "greggy-iron-ingot", amount = 10},
            {type = "item", name = "copper-cable", amount = 5}
        },
        results = {
            {type = "item", name = "power_generator", amount = 1}
        }
    },
    {
        type = "assembling-machine",
        name = "power_generator",
        localised_name = "Test Power Generator",
        localised_description = "Generates power for testing purposes.",
        icon = "__hogtorio__/graphics/buildings/power-generator/sprite.png",
        icon_size = 64,
        flags = {"placeable-neutral", "player-creation"},
        max_health = 200,
        collision_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        energy_source = {
            type = "void",
        },
        energy_usage = "1W",
        ingredient_count = 0,
        effectivity = 1.0,
        crafting_speed = 1,
        minable = {
            mining_time = 1,
            result = "power_generator",
        },
        graphics_set = {
            animation = {
                north = {
                    filename = "__hogtorio__/graphics/buildings/power-generator/sprite.png",
                    width = 64,
                    height = 64,
                    frame_count = 1,
                    line_length = 1,
                    scale = 1.5
                }
            },
        },
        fluid_boxes = {
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                pipe_picture = assembler2pipepictures(),
                volume = 1000,
                pipe_connections = {{
                    flow_direction = "output",
                    direction = defines.direction.north,
                    position = {0, -1}
                }}
            }
        },
        crafting_categories = {"voltage-production"},
    }
})