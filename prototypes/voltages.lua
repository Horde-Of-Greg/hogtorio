
local voltages = {
    {
        name = 'voltage-lv',
        localised_name = 'Low Voltage',
        description = 'Low voltage level, stings when touched.',
        icon = '__hogtorio__/graphics/voltages/lv/lv.png',
        base_color = { r = 0.2, g = 0.8, b = 0.2, a = 1 },
        flow_color = { r = 0.2, g = 0.8, b = 0.2, a = 1 },
        energy_required = 0.2,
        
    },
    {
        name = 'voltage-mv',
        localised_name = 'Medium Voltage',
        description = 'Medium voltage level, can cause burns.',
        icon = '__hogtorio__/graphics/voltages/mv/mv.png',
        base_color = { r = 0.8, g = 0.8, b = 0.2, a = 1 },
        flow_color = { r = 0.8, g = 0.8, b = 0.2, a = 1 },
        energy_required = 0.4,
    },
    {
        name = 'voltage-hv',
        localised_name = 'High Voltage',
        description = 'High voltage level, can cause electrocution.',
        icon = '__hogtorio__/graphics/voltages/hv/hv.png',
        base_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        flow_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        energy_required = 0.8,
    },
    {
        name = 'voltage-ev',
        localised_name = 'Extreme Voltage',
        description = 'Extreme voltage level, can cause death.',
        icon = '__hogtorio__/graphics/voltages/ev/ev.png',
        base_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        flow_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        energy_required = 1.6,
    }
}

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
            { type = "fluid", name = voltage.name, amount = 100 }
        }
    })
end

data:extend(voltages_fluid)
