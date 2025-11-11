
local COIL_TIERS = require("constants").COIL_TIERS
local VOLTAGES = require("constants").VOLTAGES

local base_ebf_item = {
    name = "ebf-base",
    localised_name = "Electric Blast Furnace - Coiless",
    icons = {
        {
            icon = "__hogtorio__/graphics/buildings/multiblocks/ebf/ebf.png",
            icon_size = 160,
        }
    },
    subgroup = "multiblocks",
    order = "a",
    stack_size = 64,
    recipe = {
        ingredients = {
            { type = "item", name = "steel-plate", amount = 5 },
            { type = "item", name = "copper-plate", amount = 5 }
        },
    }
}

local function generate_entry(data)
return {
    name = "ebf-" .. data.coil,
    localised_name = "Electric Blast Furnace - " .. uppercase_first_letter(data.coil),
    subgroup = "multiblocks",
    order = data.order,
    width = 5,
    height = 5,
    mining_time = 2,
    voltage = data.voltage,
    recipe = {
        ingredients = {
            { type = "item", name = "ebf-base",     amount = 1 },
            { type = "item", name = "copper-plate", amount = 5 }
        }
    },
    icons = {
        {
            icon = "__hogtorio__/graphics/buildings/multiblocks/ebf/ebf.png",
            icon_size = 160
        }, {
            icon = "__hogtorio__/graphics/buildings/multiblocks/parts/coils/machine_coil_" .. data.coil .. ".png",
            icon_size = 16,
            scale = 0.75,
            shift = { 0, 5 }
        }
    },
    states = {
        {
            name = "idle",
            is_base = true,
            layers = {{
                filename = "__hogtorio__/graphics/buildings/multiblocks/ebf/ebf.png",
                width = 160,
                height = 160,
            }, {
                filename = "__hogtorio__/graphics/buildings/multiblocks/parts/coils/machine_coil_" .. data.coil .. ".png",
                width = 16,
                height = 16,
                scale = 4,
                shift = { 0, 1 }
            }}
        }, {
            name = "working",
            layers = {{
                filename = "__hogtorio__/graphics/buildings/multiblocks/ebf/ebf.png",
                width = 160,
                height = 160,
            }, {
                filename = "__hogtorio__/graphics/buildings/multiblocks/parts/coils/machine_coil_" .. data.coil .. ".png",
                width = 16,
                height = 16,
                scale = 4,
                shift = { 0, 1 }
            }, {
                filename = "__hogtorio__/graphics/buildings/multiblocks/parts/coils/machine_coil_" .. data.coil .. "_bloom.png",
                width = 16,
                height = 16,
                scale = 4,
                shift = { 0, 1 }
            }}
        }
    }
}
end

local entries = {}

for i, coil in ipairs(COIL_TIERS) do
    table.insert(entries, generate_entry({
        coil = coil,
        voltage = VOLTAGES[i + 1],
        order = tostring(i)
    }))
end

return {base_ebf_item, entries}