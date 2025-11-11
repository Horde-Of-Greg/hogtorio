
wire_data = {
    {
        name = "lv-wire",
        localised_name = "Low Voltage Wire",
        max_health = 100,
        subgroup = "hogtorio-wires",
        order = "a[low-voltage]-a[wire]"
    },
    {
        name = "mv-wire",
        localised_name = "Medium Voltage Wire",
        max_health = 100,
        subgroup = "hogtorio-wires",
        order = "b[medium-voltage]-a[wire]"
    },
    {
        name = "hv-wire",
        localised_name = "High Voltage Wire",
        max_health = 100,
        subgroup = "hogtorio-wires",
        order = "c[high-voltage]-a[wire]"
    },
    {
        name = "ev-wire",
        localised_name = "Extreme Voltage Wire",
        max_health = 100,
        subgroup = "hogtorio-wires",
        order = "d[extreme-voltage]-a[wire]"
    }
}

for _, wire in ipairs(wire_data) do
    local wire_copy = table.deepcopy(data.raw["pipe"]["pipe"])
    wire_copy.name = wire.name
    wire_copy.localised_name = wire.localised_name
    wire_copy.max_health = wire.max_health
    wire_copy.subgroup = wire.subgroup
    wire_copy.order = wire.order
    wire_copy.minable = { hardness = 0.2, mining_time = 0.5, result = wire.name }

    local wire_item_copy = table.deepcopy(data.raw["item"]["pipe"])
    wire_item_copy.name = wire.name
    wire_item_copy.localised_name = wire.localised_name
    wire_item_copy.subgroup = wire.subgroup
    wire_item_copy.order = wire.order
    wire_item_copy.place_result = wire.name


    recipe = {
        type = "recipe",
        name = wire.name .. "-recipe",
        localised_name = "Craft " .. wire.localised_name,
        category = "crafting",
        subgroup = wire.subgroup,
        energy_required = 0.5,
        ingredients = {
            {type = "item", name = "copper-cable", amount = 5},
            {type = "item", name = "iron-plate", amount = 2}
        },
        results = {
            {type = "item", name = wire.name, amount = 1}
        }
    }
    -- Add the new wire to the data table
    data:extend({wire_copy, wire_item_copy, recipe})
end
