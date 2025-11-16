
local registry = require('registry')
local register_entries = require('entries')
local event_handler = require('runtime.event_handler')
local custom_state_trackers = require('runtime.states_tracker').CustomStateTrackers

local WORK_WHEN_OPEN_STATE_SOURCE = "work_when_open"
local WORK_WHEN_OPEN_PRIORITY = 30

event_handler:on_init(function()
    registry.init_storage()
    register_entries()
end)

event_handler:on("entity_built", function(event)
    local entity = event.created_entity or event.entity
    if entity and is_key(storage.work_when_open.registered_prototypes, entity.prototype.name) then
        custom_state_trackers:add_tracker_source(entity, WORK_WHEN_OPEN_STATE_SOURCE, WORK_WHEN_OPEN_PRIORITY)
    end
end)

event_handler:on("entity_removed", function(event)
    local entity = event.entity
    if entity and is_key(storage.work_when_open.registered_prototypes, entity.prototype.name) then
        custom_state_trackers:remove_tracker(entity)
    end
end)
event_handler:on("gui_opened", function(event)
    local entity = event.entity
    if entity and is_key(storage.work_when_open.registered_prototypes, entity.prototype.name) then
        -- Re-enable the entity when its GUI is opened
        -- storage.work_when_open.registered_entities[entity.unit_number].disabled_by_script = false

        -- Clear custom status
        -- entity.custom_status = nil

        custom_state_trackers:get_tracker(entity):remove_state("work_when_open")
    end
end)

event_handler:on("gui_closed", function(event)
    local entity = event.entity
    if entity and is_key(storage.work_when_open.registered_prototypes, entity.prototype.name) then
        -- Deregister the entity when its GUI is closed
        -- local entity = storage.work_when_open.registered_entities[entity.unit_number]
        -- entity.disabled_by_script = true

        -- -- Set status to requires manual crafting
        -- entity.custom_status = {
        --     diode = defines.entity_status_diode.red,
        --     label = "Requires manual crafting"
        -- }
        custom_state_trackers:get_tracker(entity):add_state("work_when_open", {
            custom_status = {
                diode = defines.entity_status_diode.red,
                label = "Requires manual crafting"
            },
            disabled_by_script = true
        })
    end
end)
