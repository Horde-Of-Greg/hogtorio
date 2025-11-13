
local registry = require('runtime.mechanics.tools.core.init').registry
require('runtime.mechanics.tools.core.init')

local register_entries = require('entries')

local is_registered_prototype, register_entity, deregister_entity, update_entity_crafting_state = 
    registry.is_registered_prototype,
    registry.register_entity,
    registry.deregister_entity,
    registry.update_entity_crafting_state

local entities_queues = {}
local queue_count = 5
local function create_queues(empty)
    if empty then for i = 1, queue_count do
        entities_queues[i] = {}
    end else
        local index = 1
        local registered_entities = registry.get_registered_entities()
        for i, entity in ipairs(registered_entities) do
            table.insert(entities_queues[index], entity)
            index = index + 1
            if index > queue_count then
                index = 1
            end
        end
    end
end


script.on_init(function()
    registry.init_storage()
    register_entries()
    create_queues(true)
end)

-- Register entities on creation
for _, event in ipairs({
    defines.events.on_built_entity, defines.events.on_robot_built_entity,
    defines.events.on_space_platform_built_entity, defines.events.script_raised_built,
    defines.events.script_raised_revive
}) do
    script.on_event(event, function(e)
        if is_registered_prototype(e.entity.name) then
            register_entity(e.entity)
            create_queues(false)
        end
    end)
end

-- Deregister entities on removal
for _, event in ipairs({
    defines.events.on_entity_died, defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity, defines.events.on_space_platform_mined_entity,
    defines.events.script_raised_destroy
}) do
    script.on_event(event, function(e)
        if is_registered_prototype(e.entity.name) then
            deregister_entity(e.entity)
        end
    end)
end

local current_queue_index = 1
script.on_event(defines.events.on_tick, function(event)
    if event.tick % 5 == 0 then
        local queue_index = current_queue_index
        local entities_queue = entities_queues[queue_index]
        for _, entity in ipairs(entities_queue) do
            update_entity_crafting_state(entity)
        end
        current_queue_index = current_queue_index + 1
        if current_queue_index > queue_count then
            current_queue_index = 1
        end
    end
end)
