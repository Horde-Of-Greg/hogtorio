
local generate = require("data.generator.loader").processing_machine
local entries = require("entries")

for _, entry in ipairs(entries) do
    generate(entry, true)
end