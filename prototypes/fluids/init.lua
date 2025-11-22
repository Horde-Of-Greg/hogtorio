local _generators = require('generators.init')
local generate_fluid, generate_recipe, generate_recipe_group, generate_item_group = _generators.fluid, _generators.recipe, _generators.recipe_group, _generators.item_group
local entries = require('entries')

generate_item_group({
    name = "fluids",
    localised_name = "Fluids",
    order = "d",
    icons = {
        {
            icon = "__hogtorio__/graphics/fluids/ethanol.png",
            icon_size = 64,
        },
    },
    subgroups = { {
        name = "fluids",
        order = "a",
    } }
})

generate_recipe_group({
    name = "fluid-creative-generation",
    localised_name = "Creative Fluid Generation",
    order = "a[fluid-handling]",
})

for _, fluid in pairs(entries) do
    generate_fluid(fluid)
    -- Creative recipe for testing
    generate_recipe({
        name = fluid.name .. "-creative-generation",
        localised_name = "Creative Generation of " .. fluid.localised_name,
        category = "fluid-creative-generation",
        icons = {
            {
                icon = "__hogtorio__/graphics/fluids/" .. fluid.name .. ".png",
                icon_size = 64,
            },
        },
        order = "a[" .. fluid.name .. "-creative-generation]",
        energy_required = 1,
        ingredients = {},
        results = {
            {type = "fluid", name = fluid.name, amount = 1000},
        },
    })
end

