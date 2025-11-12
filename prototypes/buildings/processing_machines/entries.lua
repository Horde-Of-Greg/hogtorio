
local entries = {
    {
        name = "bender",
        localised_name = "Metal Bender",
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
            mv = {
                ingredients = {
                    { "steel-plate",        20 },
                    { "advanced-circuit",   10 },
                    { "iron-gear-wheel",    10 }
                }
            },
            hv = {
                ingredients = {
                    { "steel-plate",        40 },
                    { "processing-unit",    20 },
                    { "iron-gear-wheel",    20 }
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
        localised_name = "Lathe",
        width = 3,
        height = 3,
        order = "l",
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
                speed = 0.1,
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
        localised_name = "Assembling Machine",
        width = 3,
        height = 3,
        order = "a",
        sprite_scale = 6,
        custom_recipe_categories = {'lv-lathe'},
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

return entries