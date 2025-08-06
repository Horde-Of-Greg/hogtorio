
return {
    {
        name = 'voltage-lv',
        locale_name = 'Low Voltage',
        description = 'Low voltage level, stings when touched.',
        icon = '__hogtorio__/graphics/voltages/lv/lv.png',
        base_color = { r = 0.2, g = 0.8, b = 0.2, a = 1 },
        flow_color = { r = 0.2, g = 0.8, b = 0.2, a = 1 },
        energy_required = 0.2,
        
    },
    {
        name = 'voltage-mv',
        locale_name = 'Medium Voltage',
        description = 'Medium voltage level, can cause burns.',
        icon = '__hogtorio__/graphics/voltages/mv/mv.png',
        base_color = { r = 0.8, g = 0.8, b = 0.2, a = 1 },
        flow_color = { r = 0.8, g = 0.8, b = 0.2, a = 1 },
        energy_required = 0.4,
    },
    {
        name = 'voltage-hv',
        locale_name = 'High Voltage',
        description = 'High voltage level, can cause electrocution.',
        icon = '__hogtorio__/graphics/voltages/hv/hv.png',
        base_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        flow_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        energy_required = 0.8,
    },
    {
        name = 'voltage-ev',
        locale_name = 'Extreme Voltage',
        description = 'Extreme voltage level, can cause death.',
        icon = '__hogtorio__/graphics/voltages/ev/ev.png',
        base_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        flow_color = { r = 0.8, g = 0.2, b = 0.2, a = 1 },
        energy_required = 1.6,
    }
}