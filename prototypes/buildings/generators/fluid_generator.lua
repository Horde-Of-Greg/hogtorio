
local _generators = require('generators.init')
local generate_item, generate_entity, generate_recipe = _generators.item, _generators.entity, _generators.recipe

generate_item({
    name = "fluid-generator",
    localised_name = "Creative Fluid Generator",
    icons = {
        {
            icon = "__hogtorio__/graphics/buildings/misc/crafting_station.png",
            icon_size = 16,
        },
    },
    subgroup = "storage",
    order = "a[fluid-generator]",
    stack_size = 64,
    placeable = true,
    recipe = {
        energy_required = 2,
        ingredients = {
            { type = "item", name = "iron-plate", amount = 10 },
            { type = "item", name = "wood",       amount = 5 },
        },
    },
})

generate_recipe({
    name = "fluid-generator-recipe",
    localised_name = "Creative Fluid Generator Recipe",
    category = "crafting",
    icons = {
        {
            icon = "__base__/graphics/icons/iron-gear-wheel.png",
            icon_size = 64,
        },
    },
    order = "a[sample-recipe]",
    energy_required = 5,
    ingredients = {
        { type = "item", name = "iron-plate", amount = 2 },
    },
    results = {
        { type = "item", name = "iron-gear-wheel", amount = 1 },
    },
})

generate_entity({
    name = "fluid-generator",
    localised_name = "Creative Fluid Generator",
    icons = {
        {
            icon = "__hogtorio__/graphics/buildings/misc/crafting_station.png",
            icon_size = 16,
        },
    },
    size = { 3, 3 },
    crafting_categories = { "fluid-creative-generation" },
    crafting_speed = 1,
    energy_source = {
        type = "void",
    },
    states = {
        {
            layers = { {
                filename = "__hogtorio__/graphics/buildings/misc/crafting_station.png",
                width = 16,
                height = 16,
                scale = 6,
            } },
        },
    },
    fluid_boxes = {
        {pattern = "eo-2,1-5"}
    }
})
