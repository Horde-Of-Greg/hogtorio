
-- This state tracker manages a table of active state sources. Each source has a priority. When a state is added from a source, a reevaluation occures, and the highest priority state is selected as the current state.
local StateTracker = {}

StateTracker.__index = StateTracker

function StateTracker:new(handler, init_setup)
    local instance = {
        _states = {},
        _priorities_lookup = {},
        _handler = handler,
    }
    setmetatable(instance, StateTracker)
    if init_setup then
        init_setup(instance)
    end
    return instance
end

function StateTracker:add_state_source(source_name, priority)
    self._priorities_lookup[source_name] = priority
end

function StateTracker:add_state(source_name, state)
    local priority = self._priorities_lookup[source_name]
    if not priority then
        error("Source '" .. source_name .. "' is not registered.")
    end

    self._states[source_name] = { state = state, priority = priority }
    self:_reevaluate_state()
end

function StateTracker:remove_state(source_name)
    self._states[source_name] = nil
    self:_reevaluate_state()
end

function StateTracker:_reevaluate_state()
    local highest_priority = -math.huge
    local selected_state = nil

    for _, state_info in pairs(self._states) do
        if state_info.priority > highest_priority then
            highest_priority = state_info.priority
            selected_state = state_info.state
        end
    end

    if not selected_state then
        selected_state = nil
    end

    if self._handler then
        self._handler(selected_state)
    end
end

-- StateTracker entity trackers 
local StateTrackerList = {}
StateTrackerList.__index = StateTrackerList

function StateTrackerList:new(create_tracker_func, init_setup)
    local instance = {
        _trackers = {},
        _create_tracker_func = create_tracker_func,
    }
    setmetatable(instance, StateTrackerList)
    if init_setup then
        init_setup(instance)
    end
    return instance
end

function StateTrackerList:add_tracker_source(entity, source_name, priority)
    local tracker = self:get_tracker(entity)
    tracker:add_state_source(source_name, priority)
end

function StateTrackerList:get_tracker(entity)
    local tracker = self._trackers[entity.unit_number]
    if not tracker then
        tracker = self._create_tracker_func(entity)
        self._trackers[entity.unit_number] = tracker
    end
    return tracker
end

function StateTrackerList:remove_tracker(entity)
    self._trackers[entity.unit_number] = nil
end

-- TrackerLists

local CustomStateTrackers = StateTrackerList:new(
    function(entity)
        local tracker = StateTracker:new(function(state)
            if state then
                entity.custom_status = state.custom_status
                entity.disabled_by_script = state.disabled_by_script
            else
                entity.custom_status = nil
                entity.disabled_by_script = false
            end
        end)
        return tracker
    end
)


return {
    CustomStateTrackers = CustomStateTrackers,
}