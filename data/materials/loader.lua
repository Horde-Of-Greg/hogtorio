
data:extend({
    {
        type = "item-subgroup",
        name = "materials",
        group = "intermediate-products",
        order = "c"
    }
})


require('class')
local elements = require('store.elements')

for _, element in pairs(elements) do
    local element_entity = Material:new(element)
    element_entity:create_items()
    element_entity:create_recipes(true)
end