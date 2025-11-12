
local function generate(recipe)
    local rec = {
        type = "recipe",
        name = recipe.name,
        localised_name = recipe.localised_name or recipe.name,
        icons = recipe.icons,
        category = recipe.category or "crafting",
        order = recipe.order or "z[unknown]",

        energy_required = recipe.energy_required or 1,
        ingredients = recipe.ingredients,
        results = recipe.results or {{
            type = "item",
            name = recipe.name,
            amount = 1
        }},
    }
    data:extend{rec}
    
end

return generate