local function generate(fluid)
    local icon_str = "__hogtorio__/graphics/fluids/" .. fluid.name .. ".png"
    local fluid_data = {
        type = "fluid",
        name = fluid.name,
        icons = {
            {
                icon = icon_str,
                icon_size = 16,
            }
        },
        subgroup = fluid.subgroup or "fluids",
        localised_name = fluid.localised_name or fluid.name,
        default_temperature = fluid.default_temperature or 15,
        max_temperature = fluid.max_temperature or 100,
        heat_capacity = fluid.heat_capacity or "1kJ",
        base_color = fluid.base_color or {r=0, g=0, b=1},
        flow_color = fluid.flow_color or {r=0.5, g=0.5, b=1},
    }
    data:extend{fluid_data}
end

return generate