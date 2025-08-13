
local generate = require("data.generator.loader").processing_machine
local entries = require("entries")
local voltages = require("data.constants").VOLTAGES

-- Generate versions of every machine for every voltage
local generated_entries = {}
for _, entry in ipairs(entries) do
    for i, voltage in ipairs(voltages) do
        local new_entry = table.deepcopy(entry)
        new_entry.voltage = voltage
        new_entry.name = voltage .. "-" .. entry.name
        new_entry.speed = 2 ^ i
        -- Add the base animation
        table.insert(new_entry.states, {
            name = "base",
            layers = { {
                filename = "__hogtorio__/graphics/buildings/processing_machine/base_voltage/" .. voltage .. "/side.png",
                width = 16,
                height = 16,
                scale = new_entry.sprite_scale or 1,
            } }
        })
        table.insert(generated_entries, new_entry)
    end
end

for _, machine in ipairs(generated_entries) do
    generate(machine)
end