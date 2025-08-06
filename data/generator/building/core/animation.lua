
local BuildingAnimation = {}
BuildingAnimation.__index = BuildingAnimation

local function get_animation_layers(layers)
    local animation_layers = {}
    for _, layer in ipairs(layers) do
        table.insert(animation_layers, {
            filename = layer.filename,
            frame_count = layer.frame_count or 1,
            line_length = layer.line_length or 1,
            width = layer.width or 64,
            height = layer.height or 64,
            animation_speed = layer.animation_speed or 1,
            scale = layer.scale or 1,
            repeat_count = layer.repeat_count or 1,
        })
    end
    return {
        layers = animation_layers,
    }
end

function BuildingAnimation:new(name)
    local instance = setmetatable({}, self)
    instance.name = name
    instance.states = {}
    return instance
end


function BuildingAnimation:add_state(anim)
    local state = {
        name = anim.name,
        duration = anim.frame_duration or 1,
        next_active = anim.next_active or "working",
        next_inactive = anim.next_inactive or "idle",
    }
    local work_vis = {
        always_draw = true,
        draw_in_states = {anim.name},
        animation = get_animation_layers(anim.layers),
    }
    table.insert(self.states, {state, work_vis})
end

function BuildingAnimation:get_states()
    local tbl = {}
    for _, state in ipairs(self.states) do
        table.insert(tbl, state[1])
    end
    return tbl
end

function BuildingAnimation:get_state(state_name)
    for _, state in ipairs(self.states) do
        if state[1].name == state_name then
            return state[1]
        end
    end
    return nil
end

function BuildingAnimation:get_work_visuals()
    local tbl = {}
    for _, state in ipairs(self.states) do
        table.insert(tbl, state[2])
    end
    return tbl
end

function BuildingAnimation:get_graphics(props)
    return {
        animation_progress = props.animation_progress or 0,
        always_draw_idle_animation = props.always_draw_idle_animation or true,
        states = self:get_states(),
        working_visualisations = self:get_work_visuals()
    }
end

return BuildingAnimation