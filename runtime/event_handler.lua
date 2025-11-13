
local EventHandler = {
    events = {}
}

EventHandler.__index = EventHandler

function EventHandler:on(event_id, handler)
    if not self.events[event_id] then
        self.events[event_id] = {}
    end
    table.insert(self.events[event_id], handler)
end

function EventHandler:on_nth_tick(tick, event_id, handler)
    self:on(event_id, function(...)
        if (game.tick % tick) == 0 then
            handler(...)
        end
    end)
end

function EventHandler:emit(event_id, ...)
    local handlers = self.events[event_id]
    if handlers then
        for _, handler in ipairs(handlers) do
            handler(...)
        end
    end
end

function EventHandler:get_handlers(event_id)
    return self.events[event_id] or {}
end

function EventHandler:new()
    local instance = setmetatable({ events = {} }, self)
    return instance
end

function EventHandler.clear()
    EventHandler.events = {}
end

return EventHandler:new()