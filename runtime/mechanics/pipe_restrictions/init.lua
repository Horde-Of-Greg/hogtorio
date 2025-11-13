
local core = require('core.init')
local scan, register_entity, deregister_entity, is_registered_prototype =
    core.scan,
    core.register_entity,
    core.deregister_entity,
    core.is_registered_prototype

-- Setup events
script.on_event(defines.events.on_tick, function(event)
    scan()
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