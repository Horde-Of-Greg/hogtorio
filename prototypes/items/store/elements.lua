
require("util.color")

local elements = {
    {
        name = "greggy-iron",
        local_name = "Iron",
        color = "0xC8C8C8",
        description = "A basic material used in many recipes.",
        icon_set = "metallic",
        hardness = 1.5
    }, {
        name = "greggy-copper",
        local_name = "Copper",
        color = "0xFF6400",
        description = "A basic material used in many recipes.",
        icon_set = "shiny",
    }, {
        name = "greggy-gold",
        local_name = "Gold",
        color = "0xFFE650",
        description = "A precious material used in advanced recipes.",
        icon_set = "shiny",
    }, {
        name = "greggy-cobalt",
        local_name = "Cobalt",
        color = "0x5050FA",
        description = "A rare material used in advanced recipes.",
        icon_set = "metallic",
        hardness = 3.0
    }
}

return elements
-- This file defines the elements used in the Material class.