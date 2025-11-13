
local core = require('runtime.mechanics.tools.core.init')
local registry = core.registry

local function register()
    -- Register machine prototypes
    registry.register_prototype("crafting-station")
    
    -- Register module prototypes
    registry.register_module("iron-wrench")
    registry.register_module("steel-wrench")
    registry.register_module("iron-file")
    registry.register_module("steel-file")
    registry.register_module("iron-hammer")
    registry.register_module("steel-hammer")
    
    -- register recipes
    registry.register_recipe("iron-wrench", {
        "iron-hammer",
    })
    registry.register_recipe("steel-wrench", {
        "steel-hammer"
    })
    registry.register_recipe("iron-file", {
        "iron-hammer", "iron-wrench"
    })
    registry.register_recipe("steel-file", {
        "steel-hammer", "steel-wrench"
    })
end

return register