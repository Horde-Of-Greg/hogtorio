
local function generate(recipe_category)
    local recipe_group = {
        type = "recipe-category",
        name = recipe_category.name,
        order = recipe_category.order or "a",
    }
    if recipe_category.localised_name then
        recipe_group.localised_name = recipe_category.localised_name
    end
    data:extend({recipe_group})
end

return generate