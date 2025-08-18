-- local generate = require("data.generator.loader").processing_machine
local generate_ebf = require("data.generator.loader").multiblocks.ebf
local generate_item = require("data.generator.loader").item
local general_entries = require("entries")
local ebf_data = require("data.buildings.multiblocks.ebf")



-- for _, entry in ipairs(general_entries) do
--     generate(entry)
-- end

-- ? EBF
local ebf_base_entry = ebf_data[1]
local ebf_entries = ebf_data[2]
generate_item(ebf_base_entry)
for _, entry in ipairs(ebf_entries) do
    generate_ebf(entry)
end