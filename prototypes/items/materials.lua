local generate = require("generators.init").material

local elements = require('store.elements')

for _, element in pairs(elements) do
    generate(element)
end
