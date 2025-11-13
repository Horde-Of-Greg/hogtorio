
local function generate(module_group)
    local group = {
        type = "module-category",
        name = module_group.name
    }
    data:extend{group}
    for i, mod in ipairs(module_group.modules) do
        local effects = {}
        if mod.speed then effects.speed = mod.speed end
        if mod.consumption then effects.consumption = mod.consumption end
        if mod.productivity then effects.productivity = mod.productivity end
        local module = {
            type = "module",
            name = mod.name,
            localised_name = mod.localised_name or ("Hogtorio Module: " .. mod.name),
            icon = mod.icon,
            order = mod.order or tostring(i),
            icon_size = mod.icon_size or 32,

            category = module_group.name,
            effect = effects,
            tier = i,
            stack_size = mod.stack_size or 1,
        }
        data:extend{module}

        local module_recipe = {
            type = "recipe",
            name = mod.name,
            localised_name = mod.localised_name or ("Hogtorio Module: " .. mod.name),
            category = mod.recipe.category or "crafting",
            icon = mod.icon,
            icon_size = mod.icon_size or 32,
            energy_required = mod.recipe.energy_required or 1,
            ingredients = mod.recipe.ingredients or {},
            results = {
                {type = "item", name = mod.name, amount = 1}
            }
        }
        data:extend{module_recipe}
    end
end

return generate