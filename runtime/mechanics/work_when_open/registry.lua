local event_handler = require('runtime.event_handler')

local function init_storage()
    if not storage.work_when_open then
        storage.work_when_open = {
            registered_prototypes = {},
        }
    end
end

local function register_prototype(prototype_name)
    if is_not_key(storage.work_when_open.registered_prototypes, prototype_name) then
        storage.work_when_open.registered_prototypes[prototype_name] = true
    end
end

-- local function register_entity(entity)
--     storage.work_when_open.registered_entities[entity.unit_number] = entity
-- end

-- local function deregister_entity(entity)
--     storage.work_when_open.registered_entities[entity.unit_number] = nil
-- end


return {
    register_prototype = register_prototype,
    init_storage = init_storage,
}
