Material = require('class')

local function generate(material)
    local element_entity = Material:new(material)
    element_entity:create_items()
    element_entity:create_recipes(true)
end

return generate