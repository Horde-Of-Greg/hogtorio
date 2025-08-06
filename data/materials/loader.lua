local generate_material = require("data.generator.loader").material
data:extend({
    {
        type = "item-subgroup",
        name = "materials",
        group = "intermediate-products",
        order = "c"
    }
})

local elements = require('store.elements')

for _, element in pairs(elements) do
    generate_material(element)
end