local colour_entries = require('colours')
require('util.string')

local entries = {

}



-- Generate default fluids for undefined entries
for name, colour in pairs(colour_entries) do
    if not entries[name] then
        entries[name] = {
            name = name,
            localised_name = name_to_localised_str(name),
            base_color = colour,
            flow_color = colour,
        }
    end
end

return entries