local _generators = require("generators.init")
local generate_item, generate_entity, generate_recipe_category, generate_recipe = _generators.item, _generators.entity, _generators.recipe_group, _generators.recipe


generate_item({
    name = "crafting-station",
    localised_name = "Crafting Station",
    icons = {
        {
            icon = "__hogtorio__/graphics/buildings/misc/crafting_station.png",
            icon_size = 16,
            icon_mipmaps = 4,
        },
    },
    subgroup = "storage",
    order = "a[crafting-station]",
    stack_size = 64,
    placeable = true,
    recipe = {
        energy_required = 2,
        ingredients = {
            {type = "item", name = "iron-plate", amount = 10},
            {type = "item", name = "wood", amount = 5},
        },
    },
})

generate_recipe_category({
    name = "crafting-station",
    localised_name = "Crafting Station",
    order = "a[crafting]",
})

generate_recipe({
    name = "sample_station_recipe",
    localised_name = "Sample Station Recipe",
    category = "crafting-station",
    icons = {
        {
            icon = "__base__/graphics/icons/iron-gear-wheel.png",
            icon_size = 64,
            icon_mipmaps = 4,
        },
    },
    order = "a[sample-recipe]",
    energy_required = 5,
    ingredients = {
        {type = "item", name = "iron-plate", amount = 2},
    },
    results = {
        {type = "item", name = "iron-gear-wheel", amount = 1},
    },
})

generate_entity({
    name = "crafting-station",
    localised_name = "Crafting Station",
    icons = {
        {
            icon = "__hogtorio__/graphics/buildings/misc/crafting_station.png",
            icon_size = 16,
            icon_mipmaps = 4,
        },
    },
    size = {3, 3},
    crafting_categories = {"crafting-station"},
    crafting_speed = 1,
    energy_source = {
        type = "void",
    },
    module_slots = 2,
    module_categories = {"wrench-tools", "files-tools", 'hammer-tools'},
    states = {
        {
            layers = {{
                filename = "__hogtorio__/graphics/buildings/misc/crafting_station.png",
                width = 16,
                height = 16,
                scale = 6,
            }},
        },
    },
})