local generate = require("data.generator.loader").material

local elements = require('store.elements')

for _, element in pairs(elements) do
    generate(element)
end