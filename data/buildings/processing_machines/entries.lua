local voltages = require("data.constants").VOLTAGES

local entries = {
    {
        name = "bender",
        locale_name = "Metal Bender",
        width = 3,
        height = 3,
        order = "b",
        icon_size = 16,
        icon_scale = 1,
        sprite_scale = 6,
        recipe = {
            lv = {
                ingredients = {
                    { "steel-plate",        10 },
                    { "electronic-circuit", 5 },
                    { "iron-gear-wheel",    5 }
                }
            },
        },
        
        states = {
            {
                name = "idle",
                next_active = "working",
                layers = {{
                    filename = "__hogtorio__/graphics/buildings/processing_machine/machine/bender/overlay_front.png",
                    width = 16,
                    height = 16,
                    scale = 6,
                }}
            }, {
                name = "working",
                next_inactive = "idle",
                layers = {{
                    filename = "__hogtorio__/graphics/buildings/processing_machine/machine/bender/overlay_front_active.png",
                    width = 16,
                    height = 16,
                    scale = 6,
                }}
            }
        }
    }
}

-- Generate versions of every machine for every voltage
local generated_entries = {}
for _, entry in ipairs(entries) do
    for _, voltage in ipairs(voltages) do
        local new_entry = table.deepcopy(entry)
        new_entry.voltage = voltage
        new_entry.name = voltage .. "-" .. entry.name
        -- Prepend every layer in every state with a voltage based base sprite
        for _, state in ipairs(new_entry.states) do
            local base_layer = {
                filename = "__hogtorio__/graphics/buildings/processing_machine/base_voltage/" .. voltage .. "/side.png",
                width = 16,
                height = 16,
                scale = new_entry.sprite_scale or 1,
            }
            table.insert(state.layers, 1, base_layer)
        end 
        table.insert(generated_entries, new_entry)
    end
end


return generated_entries