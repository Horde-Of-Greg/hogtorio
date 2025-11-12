
local generate = require("generators.init").item_group
local voltages = require("constants").VOLTAGES

-- Generate processing machine groups/subgroups
local voltage_proc_machines_subgroups = {}
for i, voltage in voltages:iter() do
    local subgroup = {
        name = "processing-machines-" .. voltage,
        order = tostring(i) .. "[voltage]",
        localised_name = "Processing Machines (" .. voltage .. ")",
    }
    table.insert(voltage_proc_machines_subgroups, subgroup)
end

generate({
    name = "processing-machines",
    order = "b[processing-machines]",
    localised_name = "Hogtorio Processing Machines",
    icons = {
        {
            icon = "__hogtorio__/graphics/buildings/processing_machine/base_voltage/ev/side.png",
            icon_size = 16,
            scale = 4,
        },
        {
            icon = "__hogtorio__/graphics/voltages/ev/ev.png",
            icon_size = 64,
            scale = 1,
        }
    },
    icon_size = 64,
    subgroups = voltage_proc_machines_subgroups
})

local material_types = {
    {"ingots", "Ingots"},
    {"plates", "Plates"},
    {"sticks", "Rods"},
    {"gems", "Gems"},
    {"wires", "Wires"},
    {"dusts", "Dusts"},

}

for i, material_type in ipairs(material_types) do
    data:extend({
        {
            type = "item-subgroup",
            name = "materials-" .. material_type[1],
            localised_name = "Hogtorio " .. material_type[2],
            group = "intermediate-products",
            order = tostring(i) .. "[material-type]",
        }
    })
end

generate{
    type = "item-group",
    name = "hogtorio",
    localised_name = "Hogtorio",
    icons = {{
        icon = "__hogtorio__/graphics/misc/HOG-logo.png",
        icon_size = 428,
    }},
    order = 'x',
    subgroups = {
        {
            name = "hogtorio-wires",
            localised_name = "Hogtorio Wires",
            order = "a"
        }, {
            name = "multiblocks",
            localised_name = "Hogtorio Multiblocks",
            order = "b"
        }
    }
}