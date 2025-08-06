
data:extend({
    {
        type = "recipe-category",
        name = "voltage-production",
        localised_name = "Voltage Production"
    }
})

data:extend({
    {
        type = "recipe-category",
        name = "hogtorio",
        localised_name = "Hogtorio",
        order = "c"
    }, {
        type = "item-group",
        name = "hogtorio",
        localised_name = "Hogtorio",
        icon = "__hogtorio__/graphics/misc/HOG-logo.png",
        icon_size = 428,
        order = 'x'
        
    }, {
        type = "item-subgroup",
        name = "hogtorio-wires",
        group = "hogtorio",
        order = "a"
    }
})