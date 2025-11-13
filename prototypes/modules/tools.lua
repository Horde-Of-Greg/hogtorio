local generate_module_group = require('generators.module_group')

local repair_kit = data.raw['repair-tool']['repair-pack']
local repair_kit_icon = repair_kit.icon

generate_module_group({
    name = "wrench-tools",
    modules = {
        {
            name = "iron-wrench",
            localised_name = "Iron Wrench",
            icon = repair_kit_icon,
            icon_size = repair_kit.icon_size,
            recipe = {
                category = "crafting-station",
                ingredients = {
                    {type = "item", name = "iron-plate", amount = 2},
                    {type = "item", name = "iron-stick", amount = 1},
                }
            }
        }, {
            name = "steel-wrench",
            localised_name = "Steel Wrench",
            icon = repair_kit_icon,
            icon_size = repair_kit.icon_size,
            recipe = {
                category = "crafting-station",
                ingredients = {
                    {type = "item", name = "steel-plate", amount = 2},
                    {type = "item", name = "iron-stick", amount = 1},
                }
            }
        }
    }
})

generate_module_group({
    name = "files-tools",
    modules = {
        {
            name = "iron-file",
            localised_name = "Iron File",
            icon = repair_kit_icon,
            icon_size = repair_kit.icon_size,
            recipe = {
                category = "crafting-station",
                ingredients = {
                    {type = "item", name = "iron-plate", amount = 2},
                    {type = "item", name = "iron-stick", amount = 1},
                }
            }
        }, {
            name = "steel-file",
            localised_name = "Steel File",
            icon = repair_kit_icon,
            icon_size = repair_kit.icon_size,
            recipe = {
                category = "crafting-station",
                ingredients = {
                    {type = "item", name = "steel-plate", amount = 2},
                    {type = "item", name = "iron-stick", amount = 1},
                }
            }
        }
    }
})

generate_module_group({
    name = "hammer-tools",
    modules = {
        {
            name = "iron-hammer",
            localised_name = "Iron Hammer",
            icon = repair_kit_icon,
            icon_size = repair_kit.icon_size,
            recipe = {
                ingredients = {
                    {type = "item", name = "iron-plate", amount = 2},
                    {type = "item", name = "iron-stick", amount = 1},
                }
            }
        }, {
            name = "steel-hammer",
            localised_name = "Steel Hammer",
            icon = repair_kit_icon,
            icon_size = repair_kit.icon_size,
            recipe = {
                ingredients = {
                    {type = "item", name = "steel-plate", amount = 2},
                    {type = "item", name = "iron-stick", amount = 1},
                }
            }
        }
    }
})