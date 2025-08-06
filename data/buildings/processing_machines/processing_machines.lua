
local generate = require("data.generator.loader").processing_machine
local entries = require("entries")


for _, machine in ipairs(entries) do
    generate(machine)
end