
local voltages = require("voltages_store")

local voltages_fluid = {}

for i, voltage in ipairs(voltages) do
    table.insert(voltages_fluid, {
        type = "fluid",
        name = voltage.name,
        localised_name = voltage.localised_name,
        localised_description = voltage.description,
        factoriopedia_description = voltage.description,
        icon = voltage.icon,
        base_color = voltage.base_color,
        flow_color = voltage.flow_color,
        default_temperature = 300,
        fuel_value = tostring(32 * (4 ^ (i - 1))) .. "J",
    })
    table.insert(voltages_fluid, {
        type = "recipe",
        name = voltage.name .. "-generation",
        localised_name = "Generate " .. voltage.localised_name,
        category = "voltage-production",
        energy_required = voltage.energy_required,
        ingredients = {},
        results = {
            {type = "fluid", name = voltage.name, amount = 100}
        }
    })
end

data:extend(voltages_fluid)