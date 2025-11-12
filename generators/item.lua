
local function generate(thing)
    local item = {
        type = "item",
        name = thing.name,
        localised_name = thing.localised_name or thing.name,
        icons = thing.icons,
        subgroup = thing.subgroup,
        order = thing.order,
        stack_size = thing.stack_size or 64,
    }
    if thing.placeable then
        item.place_result = thing.name
    end
    data:extend{item}

    if thing.recipe then
        local recipe = {
            type = "recipe",
            name = thing.name,
            localised_name = thing.localised_name or thing.name,
            icons = thing.icons,
            category = thing.recipe.category or "crafting",
            order = thing.order,

            energy_required = thing.recipe.energy_required or 1,
            ingredients = thing.recipe.ingredients,
            results = thing.recipe.results or {{
                type = "item",
                name = thing.name,
                amount = 1
            }},
        }
        data:extend{recipe}
    end
end

return generate