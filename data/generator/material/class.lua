
local material_check = require("types")
require("util.array_manipulation")
require("util.str_manipulation")

local Material = {}
Material.__index = Material

function Material:load_default_material_flags()
    self.flags = {
        "ingot", "plate", "stick"
    }
end

function Material:get_locale_name(material)
    if self.local_name then
        return self.local_name .. " " .. uppercase_first_letter(material)
    else
        return uppercase_first_letter(material)
    end
end

function Material:new(
    props
)
    local instance = setmetatable({}, self)
    instance.name = props.name
    instance.local_name = props.local_name or props.name
    instance.color = props.color
    instance.description = props.description
    instance.icon_set = props.icon_set or "dull"
    instance.recipes = props.recipes or {}

    instance:load_default_material_flags()
    if props.flags then
        instance.default_flags = extend_array(instance.flags, props.flags)
    end
    return instance
end

function Material:generate_icon(material)
    icons = {}
    local color_tint = hex_to_rgba(self.color)
    local true_icon_set = material_check(material, self.icon_set)
    local material_set, is_overlay = true_icon_set[1], true_icon_set[2]
    base_icon_path = "__hogtorio__/graphics/materials/" .. material_set .. "/" .. material .. ".png"
    table.insert(icons, {
        icon = base_icon_path,
        icon_size = 16,
        tint = color_tint
    })
    if is_overlay then
        overlay_icon_path = "__hogtorio__/graphics/materials/" .. self.icon_set .. "/" .. material .. "_overlay.png"
        table.insert(icons, {
            icon = overlay_icon_path,
            icon_size = 16,
        })
    end
    return icons
end

function Material:create_items()
    for _, material in pairs(self.flags) do
        icons = self:generate_icon(material)
        data:extend({
            {
                type = "item",
                name = self.name .. "-" .. material,
                localised_name = self:get_locale_name(material),
                localised_description = self.description,
                icons = icons,
                subgroup = "materials-" .. material .. "s",
                order = "a",
                stack_size = 100
            }
        })
    end
end

function Material:create_default_recipes()
    for _, material in pairs(self.flags) do
        data:extend({
            {
                type = "recipe",
                name = self.name .. "-" .. material,
                localised_name = self:get_locale_name(material),
                category = "crafting",
                subgroup = "materials-" .. material .. "s",
                order = "a",
                energy_required = 1,
                ingredients = { { type = "item", name = self.name .. "-" .. material, amount = 1 } },
                results = {{
                    type = "item",
                    name = self.name .. "-" .. material,
                    amount = 1
                }}
            }
        })
    end
end

function Material:create_recipes(load_default)
    if load_default then
        self:create_default_recipes()
    end
    for _, recipe in ipairs(self.recipes) do
        data:extend({
            {
                type = "recipe",
                name = self:get_locale_name(recipe.name),
                category = recipe.category or "crafting",
                subgroup = recipe.subgroup or "materials-" .. recipe.name .. "s",
                order = "a",
                energy_required = recipe.energy_required or 1,
                ingredients = recipe.ingredients,
                result = recipe.result
            }
        })
    end
end

return Material