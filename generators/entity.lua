local BuildingAnimation = require("building.core.animation")

local function calculate_collision_selection_boxes(width, height)
    local x_center = width / 2
    local y_center = height / 2
    local offset = 0.1 -- Small offset to allow walking between machines
    return {
        collision_box = {{-x_center + offset, -y_center + offset}, {x_center - offset, y_center - offset}},
        selection_box = {{-x_center, -y_center}, {x_center, y_center}},
    }
end

local function get_graphics_set(entity)
    if #entity.states > 1 then
        local build_anim = BuildingAnimation:new(entity.name)
        for _, state in ipairs(entity.states) do
            build_anim:add_state(state)
        end
        return build_anim:get_graphics({
            entity.animation_progress or 0,
        })
    else
        return {
            idle_animation = {
                layers = entity.states[1].layers,
            },
            always_draw_idle_animation = true,
        }
    end
end

local function generate(entity)
    local bboxes = calculate_collision_selection_boxes(entity.size[1], entity.size[2])
    local collision, selection = bboxes.collision_box, bboxes.selection_box
    local ent = {
        type = "assembling-machine",
        name = entity.name,
        localised_name = entity.localised_name or entity.name,
        icons = entity.icons,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = entity.mining_time or 0.5, result = entity.name},
        max_health = entity.max_health or 200,
        corpse = "small-remnants",
        dying_explosion = "medium-explosion",
        collision_box = collision,
        selection_box = selection,
        crafting_categories = entity.crafting_categories or {"crafting"},
        crafting_speed = entity.crafting_speed or 1,
        energy_source = entity.energy_source or {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = entity.emissions_per_minute or 1,
        },
        module_slots = entity.module_slots or 0,
        allowed_module_categories = entity.module_categories or {},
        allowed_effects = entity.allowed_effects or {"speed", "productivity"},
        energy_usage = entity.energy_usage or "75kW",
        ingredient_count = entity.ingredient_count or 65535,
        graphics_set = get_graphics_set(entity),
    }

    
    data:extend({ent})
end

return generate