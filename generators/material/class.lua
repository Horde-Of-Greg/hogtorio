
local material_check = require("types")
require("util.array")
require("util.string")
local VOLTAGES = require("constants").VOLTAGES
require("util.color")
local COMMON_MATERIAL_RELATIONSHIPS = require("constants").COMMON_MATERIAL_RELATIONSHIPS

local Material = {}
Material.__index = Material

function get_recipe_time(base, hardness)
    return base * (hardness ^ 1.4)
end

function Material:load_default_material_flags()
    self.flags = {
        -- {category, hardness_base, amount}
        ingot = {"crafting", 1}, 
        plate = {"bender", 1.5}, 
        stick = {"lathe", 2.5, 2}
    }
end

function Material:get_localised_name(material, voltage)
    if voltage then
        if self.local_name then
            return { "", self.local_name .. " " .. uppercase_first_letter(material) .. " (", uppercase(VOLTAGES[voltage]), ")" }
        else 
            return { "", self.name .. " " .. uppercase_first_letter(material) .. " (", uppercase(VOLTAGES[voltage]), ")" }
        end
    else
        if self.local_name then
            return { "", self.local_name .. " " .. uppercase_first_letter(material) }
        else
            return { "", self.name .. " " .. uppercase_first_letter(material) }
        end
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
    instance.min_voltage = props.min_voltage or "lv"
    instance.hardness = props.hardness or 1
    instance.crafting_time = props.crafting_time or 1

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
    for material, flag in pairs(self.flags) do
        icons = self:generate_icon(material)
        data:extend({
            {
                type = "item",
                name = self.name .. "-" .. material,
                localised_name = self:get_localised_name(material),
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
    for material, flags in pairs(self.flags) do
        if flags[1] == "crafting" then
            recipe_machine = "crafting"
        else
            recipe_machine = self.min_voltage .. "-" .. flags[1]
        end
        local ingredients = {}
        if COMMON_MATERIAL_RELATIONSHIPS[material] then
            table.insert(ingredients, {
                type = "item",
                name = self.name .. "-" .. COMMON_MATERIAL_RELATIONSHIPS[material],
                amount = 1
            })
        end
        data:extend({
            {
                type = "recipe",
                name = self.name .. "-" .. material,
                localised_name = self:get_localised_name(material),
                category = recipe_machine,
                subgroup = "materials-" .. material .. "s",
                order = "a",
                energy_required = get_recipe_time(flags[2], self.hardness),
                ingredients = ingredients,
                results = {{
                    type = "item",
                    name = self.name .. "-" .. material,
                    amount = flags[3] or 1
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
        for _, voltage in ipairs(VOLTAGES.getBetterVoltages(self.min_voltage)) do
            data:extend({
                {
                    type = "recipe",
                    name = self.name .. "-" .. recipe.name .. "-" .. voltage,
                    localised_name = self:get_localised_name(recipe.name, voltage),
                    category = voltage .. "-" .. (recipe.category or "crafting"),
                    subgroup = recipe.subgroup or ("materials-" .. recipe.name .. "s"),
                    order = "a",
                    energy_required = get_recipe_time(recipe.time or 1, self.hardness),
                    ingredients = recipe.ingredients,
                    result = self.name .. "-" .. recipe.name
                }
            })
        end
    end
end

return Material