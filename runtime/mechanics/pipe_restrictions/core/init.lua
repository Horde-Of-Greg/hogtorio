
local registry = require('registry')
local scanner = require('scanner')

return {
    scan = scanner.scan,
    register_entity = scanner.register_entity,
    deregister_entity = scanner.deregister_entity,
    is_registered_prototype = registry.is_registered_prototype,
}