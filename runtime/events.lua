
local event_handler = require('runtime.event_handler')

require('mechanics.pipe_restrictions.init')
require('mechanics.tools.init')
require("mechanics.work_when_open.init")

script.on_init(function()
    event_handler:emit("init")
end)

script.on_event(defines.events.on_tick, function(event)
    event_handler:emit("update", event)
end)

for _, event in ipairs({
    defines.events.on_built_entity, defines.events.on_robot_built_entity,
    defines.events.on_space_platform_built_entity, defines.events.script_raised_built,
    defines.events.script_raised_revive
}) do
    script.on_event(event, function(e)
        event_handler:emit("entity_built", e)
    end)
end

for _, event in ipairs({
    defines.events.on_entity_died, defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity, defines.events.on_space_platform_mined_entity,
    defines.events.script_raised_destroy
}) do
    script.on_event(event, function(e)
        event_handler:emit("entity_removed", e)
    end)
end

script.on_event(defines.events.on_gui_opened, function(e)
    event_handler:emit("gui_opened", e)
end)

script.on_event(defines.events.on_gui_closed, function(e)
    event_handler:emit("gui_closed", e)
end)