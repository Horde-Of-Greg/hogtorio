
local BuildingAnimation = {}
BuildingAnimation.__index = BuildingAnimation

local function get_animation_layers(layers, speed)
    local animation_layers = {}
    for _, layer in ipairs(layers) do
        table.insert(animation_layers, {
            filename = layer.filename,
            frame_count = layer.frame_count or 1,
            line_length = layer.line_length,
            lines_per_file = layer.lines_per_file or layer.frame_count or 1,
            width = layer.width or 64,
            height = layer.height or 64,
            animation_speed = speed,
            scale = layer.scale or 1,
            repeat_count = layer.repeat_count,
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
    instance.visuals = {}
    instance.base_anim = {}
    return instance
end


function BuildingAnimation:add_state(anim)
    local duration = (anim.duration or 1) / (anim.speed or 1)
    if anim.name == "base" then
        -- This is a special case for the base animation
        self.base_anim = get_animation_layers(anim.layers)
        return
    end
    local state = {
        name = anim.name,
        duration = duration,
        next_active = anim.next_active or "working",
        next_inactive = anim.next_inactive or "idle",
    }
    table.insert(self.states, state)
    
    local vis = {
        draw_in_states = { anim.name },
        always_draw = true,
        animation = get_animation_layers(anim.layers, anim.speed),
    }
    table.insert(self.visuals, vis)
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

-- This function simplifies to combine the results
function BuildingAnimation:get_graphics(props)
    return {
        idle_animation = self.base_anim,

        states = self.states,

        working_visualisations = self.visuals,
        
        always_draw_idle_animation = true,
    }
end

return BuildingAnimation