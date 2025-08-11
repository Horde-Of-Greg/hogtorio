local voltages = require("data.constants").VOLTAGES

local entries = {
    {
        name = "bender",
        locale_name = "Metal Bender",
        width = 3,
        height = 3,
        order = "b",
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
    }, {
        name = "lathe",
        locale_name = "Lathe",
        width = 3,
        height = 3,
        order = "l",
        animation_tempo = 6,
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
                name = 'idle',
                next_active = 'working',
                layers = {{
                    filename = "__hogtorio__/graphics/buildings/processing_machine/machine/lathe/overlay_front.png",
                    width = 16,
                    height = 16,
                    scale = 6,
                }}
            }, {
                name = 'working',
                next_inactive = 'idle',
                speed = 0.3,
                layers = {{
                    filename = "__hogtorio__/graphics/buildings/processing_machine/machine/lathe/overlay_front_active.png",
                    width = 16,
                    height = 16,
                    scale = 6,
                    frame_count = 6,
                }}
            }
        }
    }, {
        name = "assembler",
        locale_name = "Assembling Machine",
        width = 3,
        height = 3,
        order = "a",
        sprite_scale = 6,
        custom_recipe_categories = {'lv-lathe'},
        animation_tempo = 22,
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
                    filename = "__hogtorio__/graphics/buildings/processing_machine/machine/assembler/overlay_front.png",
                    width = 16,
                    height = 16,
                    scale = 6,
                }}
            }, {
                name = "working",
                next_inactive = "idle",
                layers = {{
                    filename = "__hogtorio__/graphics/buildings/processing_machine/machine/assembler/overlay_front_active.png",
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
        -- Add the base animation
        table.insert(new_entry.states, {
            name = "base",
            layers = {{
                filename = "__hogtorio__/graphics/buildings/processing_machine/base_voltage/" .. voltage .. "/side.png",
                width = 16,
                height = 16,
                scale = new_entry.sprite_scale or 1,
            }}
        })
        table.insert(generated_entries, new_entry)
    end 
end


return generated_entries